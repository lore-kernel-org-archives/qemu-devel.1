Received: from eggs.gnu.org ([2001:4830:134:3::10]:55037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dzhCW-0004tM-9K
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:46:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dzhCU-0002qi-Bq
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:46:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dzhCU-0002po-1x
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:46:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0F85A80090
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 10:46:49 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  4 Oct 2017 12:46:28 +0200
Message-Id: <20171004104636.7963-5-quintela@redhat.com>
In-Reply-To: <20171004104636.7963-1-quintela@redhat.com>
References: <20171004104636.7963-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v9 04/12] migration: Start of multiple fd work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

We create new channels for each new thread created. We send through
them a string containing <uuid> multifd <channel number> so we are
sure that we connect the right channels in both sides.

Signed-off-by: Juan Quintela <quintela@redhat.com>

--
Split SocketArgs into incoming and outgoing args

Use UUID's on the initial message, so we are sure we are connecting to
the right channel.

Remove init semaphore.  Now that we use uuids on the init message, we
know that this is our channel.

Fix recv socket destwroy, we were destroying send channels.
This was very interesting, because we were using an unreferred object
without problems.

Move to struct of pointers
init channel sooner.
split recv thread creation.
listen on main thread
We count the number of created threads to know when we need to stop listening
Use g_strdup_printf
report channel id on errors
Add name parameter
Use local_err
Add Error * parameter to socket_send_channel_create()
Use qio_channel_*_all
Use asynchronous connect
Use an struct to send all fields
Use default uuid
---
 migration/migration.c |   5 ++
 migration/ram.c       | 128 +++++++++++++++++++++++++++++++++++++++++++-------
 migration/ram.h       |   3 ++
 migration/socket.c    |  34 +++++++++++++-
 migration/socket.h    |  10 ++++
 5 files changed, 162 insertions(+), 18 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 61b7e7105a..ee98c50d8c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -419,6 +419,11 @@ void migration_ioc_process_incoming(QIOChannel *ioc)
  */
 bool migration_has_all_channels(void)
 {
+    if (migrate_use_multifd()) {
+        int thread_count = migrate_multifd_channels();
+
+        return thread_count == multifd_created_channels();
+    }
     return true;
 }
 
diff --git a/migration/ram.c b/migration/ram.c
index b83f8977c5..b57006594b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -36,6 +36,7 @@
 #include "xbzrle.h"
 #include "ram.h"
 #include "migration.h"
+#include "socket.h"
 #include "migration/register.h"
 #include "migration/misc.h"
 #include "qemu-file.h"
@@ -47,6 +48,8 @@
 #include "qemu/rcu_queue.h"
 #include "migration/colo.h"
 #include "migration/block.h"
+#include "sysemu/sysemu.h"
+#include "qemu/uuid.h"
 
 /***********************************************************/
 /* ram save/restore */
@@ -363,6 +366,7 @@ struct MultiFDSendParams {
     uint8_t id;
     char *name;
     QemuThread thread;
+    QIOChannel *c;
     QemuSemaphore sem;
     QemuMutex mutex;
     bool quit;
@@ -379,6 +383,12 @@ static void terminate_multifd_send_threads(Error *errp)
 {
     int i;
 
+    if (errp) {
+        MigrationState *s = migrate_get_current();
+        migrate_set_error(s, errp);
+        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
+                          MIGRATION_STATUS_FAILED);
+    }
     for (i = 0; i < multifd_send_state->count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
@@ -404,6 +414,7 @@ int multifd_save_cleanup(Error **errp)
         qemu_thread_join(&p->thread);
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
+        socket_send_channel_destroy(p->c);
         g_free(p->name);
         p->name = NULL;
     }
@@ -414,9 +425,27 @@ int multifd_save_cleanup(Error **errp)
     return ret;
 }
 
+typedef struct {
+    uint32_t version;
+    uint8_t id;
+    char uuid[UUID_FMT_LEN];
+} MigrateMultiFDInit_t;
+
 static void *multifd_send_thread(void *opaque)
 {
     MultiFDSendParams *p = opaque;
+    MigrateMultiFDInit_t msg;
+    Error *local_err = NULL;
+    size_t ret;
+
+    msg.version = 1;
+    msg.id = p->id;
+    qemu_uuid_unparse(&qemu_uuid, (char *)&msg.uuid);
+    ret = qio_channel_write_all(p->c, (char *)&msg, sizeof(msg), &local_err);
+    if (ret != 0) {
+        terminate_multifd_send_threads(local_err);
+        return NULL;
+    }
 
     while (true) {
         qemu_mutex_lock(&p->mutex);
@@ -431,6 +460,27 @@ static void *multifd_send_thread(void *opaque)
     return NULL;
 }
 
+static void multifd_new_channel_async(QIOTask *task, gpointer opaque)
+{
+    MultiFDSendParams *p = opaque;
+    QIOChannel *sioc = QIO_CHANNEL(qio_task_get_source(task));
+    Error *local_err;
+
+    if (qio_task_propagate_error(task, &local_err)) {
+        if (multifd_save_cleanup(&local_err) != 0) {
+            migrate_set_error(migrate_get_current(), local_err);
+        }
+    } else {
+        p->c = QIO_CHANNEL(sioc);
+        qio_channel_set_delay(p->c, false);
+
+        qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
+                           QEMU_THREAD_JOINABLE);
+
+        multifd_send_state->count++;
+    }
+}
+
 int multifd_save_setup(void)
 {
     int thread_count;
@@ -451,10 +501,7 @@ int multifd_save_setup(void)
         p->quit = false;
         p->id = i;
         p->name = g_strdup_printf("multifdsend_%d", i);
-        qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
-                           QEMU_THREAD_JOINABLE);
-
-        multifd_send_state->count++;
+        socket_send_channel_create(multifd_new_channel_async, p);
     }
     return 0;
 }
@@ -463,6 +510,7 @@ struct MultiFDRecvParams {
     uint8_t id;
     char *name;
     QemuThread thread;
+    QIOChannel *c;
     QemuSemaphore sem;
     QemuMutex mutex;
     bool quit;
@@ -473,12 +521,22 @@ struct {
     MultiFDRecvParams *params;
     /* number of created threads */
     int count;
+    /* Should we finish */
+    bool quit;
 } *multifd_recv_state;
 
 static void terminate_multifd_recv_threads(Error *errp)
 {
     int i;
 
+    if (errp) {
+        MigrationState *s = migrate_get_current();
+        migrate_set_error(s, errp);
+        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
+                          MIGRATION_STATUS_FAILED);
+    }
+    multifd_recv_state->quit = true;
+
     for (i = 0; i < multifd_recv_state->count; i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
@@ -504,6 +562,7 @@ int multifd_load_cleanup(Error **errp)
         qemu_thread_join(&p->thread);
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
+        socket_recv_channel_destroy(p->c);
         g_free(p->name);
         p->name = NULL;
     }
@@ -532,10 +591,51 @@ static void *multifd_recv_thread(void *opaque)
     return NULL;
 }
 
+void multifd_new_channel(QIOChannel *ioc)
+{
+    MultiFDRecvParams *p;
+    MigrateMultiFDInit_t msg;
+    Error *local_err = NULL;
+    char *uuid;
+    size_t ret;
+
+    ret = qio_channel_read_all(ioc, (char *)&msg, sizeof(msg), &local_err);
+    if (ret != 0) {
+        terminate_multifd_recv_threads(local_err);
+        return;
+    }
+
+    uuid = qemu_uuid_unparse_strdup(&qemu_uuid);
+
+    if (strcmp(msg.uuid, uuid)) {
+        g_free(uuid);
+        error_setg(&local_err, "multifd: received uuid '%s' and expected "
+                   "uuid '%s' for channel %hhd", msg.uuid, uuid, msg.id);
+        terminate_multifd_recv_threads(local_err);
+        return;
+    }
+    g_free(uuid);
+
+    p = &multifd_recv_state->params[msg.id];
+    if (p->id != 0) {
+        error_setg(&local_err, "multifd: received id '%d' already setup'", msg.id);
+        terminate_multifd_recv_threads(local_err);
+        return;
+    }
+    qemu_mutex_init(&p->mutex);
+    qemu_sem_init(&p->sem, 0);
+    p->quit = false;
+    p->id = msg.id;
+    p->c = ioc;
+    multifd_recv_state->count++;
+    p->name = g_strdup_printf("multifdrecv_%d", msg.id);
+    qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
+                       QEMU_THREAD_JOINABLE);
+}
+
 int multifd_load_setup(void)
 {
     int thread_count;
-    uint8_t i;
 
     if (!migrate_use_multifd()) {
         return 0;
@@ -544,21 +644,15 @@ int multifd_load_setup(void)
     multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
     multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
     multifd_recv_state->count = 0;
-    for (i = 0; i < thread_count; i++) {
-        MultiFDRecvParams *p = &multifd_recv_state->params[i];
-
-        qemu_mutex_init(&p->mutex);
-        qemu_sem_init(&p->sem, 0);
-        p->quit = false;
-        p->id = i;
-        p->name = g_strdup_printf("multifdrecv_%d", i);
-        qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
-                           QEMU_THREAD_JOINABLE);
-        multifd_recv_state->count++;
-    }
+    multifd_recv_state->quit = false;
     return 0;
 }
 
+int multifd_created_channels(void)
+{
+    return multifd_recv_state->count;
+}
+
 /**
  * save_page_header: write page header to wire
  *
diff --git a/migration/ram.h b/migration/ram.h
index 4a72d66503..5221bc9beb 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -31,6 +31,7 @@
 
 #include "qemu-common.h"
 #include "exec/cpu-common.h"
+#include "io/channel.h"
 
 extern MigrationStats ram_counters;
 extern XBZRLECacheStats xbzrle_counters;
@@ -43,6 +44,8 @@ int multifd_save_setup(void);
 int multifd_save_cleanup(Error **errp);
 int multifd_load_setup(void);
 int multifd_load_cleanup(Error **errp);
+void multifd_new_channel(QIOChannel *ioc);
+int multifd_created_channels(void);
 
 uint64_t ram_pagesize_summary(void);
 int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len);
diff --git a/migration/socket.c b/migration/socket.c
index 2d70747a1a..22fb05edc8 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -26,6 +26,34 @@
 #include "io/channel-socket.h"
 #include "trace.h"
 
+int socket_recv_channel_destroy(QIOChannel *recv)
+{
+    /* Remove channel */
+    object_unref(OBJECT(recv));
+    return 0;
+}
+
+struct SocketOutgoingArgs {
+    SocketAddress *saddr;
+} outgoing_args;
+
+void socket_send_channel_create(void (*f)(QIOTask *, gpointer), void *data)
+{
+    QIOChannelSocket *sioc = qio_channel_socket_new();
+    qio_channel_socket_connect_async(sioc, outgoing_args.saddr,
+                                     f, data, NULL);
+}
+
+int socket_send_channel_destroy(QIOChannel *send)
+{
+    /* Remove channel */
+    object_unref(OBJECT(send));
+    if (outgoing_args.saddr) {
+        qapi_free_SocketAddress(outgoing_args.saddr);
+        outgoing_args.saddr = NULL;
+    }
+    return 0;
+}
 
 static SocketAddress *tcp_build_address(const char *host_port, Error **errp)
 {
@@ -95,6 +123,11 @@ static void socket_start_outgoing_migration(MigrationState *s,
     struct SocketConnectData *data = g_new0(struct SocketConnectData, 1);
 
     data->s = s;
+
+    /* in case previous migration leaked it */
+    qapi_free_SocketAddress(outgoing_args.saddr);
+    outgoing_args.saddr = saddr;
+
     if (saddr->type == SOCKET_ADDRESS_TYPE_INET) {
         data->hostname = g_strdup(saddr->u.inet.host);
     }
@@ -105,7 +138,6 @@ static void socket_start_outgoing_migration(MigrationState *s,
                                      socket_outgoing_migration,
                                      data,
                                      socket_connect_data_free);
-    qapi_free_SocketAddress(saddr);
 }
 
 void tcp_start_outgoing_migration(MigrationState *s,
diff --git a/migration/socket.h b/migration/socket.h
index 6b91e9db38..afb0ff0f51 100644
--- a/migration/socket.h
+++ b/migration/socket.h
@@ -16,6 +16,16 @@
 
 #ifndef QEMU_MIGRATION_SOCKET_H
 #define QEMU_MIGRATION_SOCKET_H
+
+#include "io/channel.h"
+#include "io/task.h"
+
+QIOChannel *socket_recv_channel_create(void);
+int socket_recv_channel_destroy(QIOChannel *recv);
+
+void socket_send_channel_create(void (*f)(QIOTask *, gpointer), void *data);
+int socket_send_channel_destroy(QIOChannel *send);
+
 void tcp_start_incoming_migration(const char *host_port, Error **errp);
 
 void tcp_start_outgoing_migration(MigrationState *s, const char *host_port,
-- 
2.13.5
