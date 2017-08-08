Received: from eggs.gnu.org ([2001:4830:134:3::10]:58845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df7Jr-0000Sg-Tp
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 12:25:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df7Jq-0006xA-12
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 12:25:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1df7Jp-0006wk-Me
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 12:25:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 95A56C047B7D
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 16:25:20 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue,  8 Aug 2017 18:22:16 +0200
Message-Id: <20170808162224.32419-12-quintela@redhat.com>
In-Reply-To: <20170808162224.32419-1-quintela@redhat.com>
References: <20170808162224.32419-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v6 11/19] migration: Start of multiple fd work
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
---
 migration/migration.c |  5 +++
 migration/ram.c       | 99 +++++++++++++++++++++++++++++++++++++++++++--------
 migration/ram.h       |  3 ++
 migration/socket.c    | 36 ++++++++++++++++++-
 migration/socket.h    | 10 ++++++
 5 files changed, 138 insertions(+), 15 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index e36e880..944d6e2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -413,6 +413,11 @@ void migration_ioc_process_incoming(QIOChannel *ioc)
  */
 bool migration_has_all_channels(void)
 {
+    if (migrate_use_multifd()) {
+        int thread_count = migrate_multifd_threads();
+
+        return thread_count == multifd_created_threads();
+    }
     return true;
 }
 
diff --git a/migration/ram.c b/migration/ram.c
index 9fb3496..e9fa556 100644
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
@@ -46,6 +47,8 @@
 #include "exec/ram_addr.h"
 #include "qemu/rcu_queue.h"
 #include "migration/colo.h"
+#include "sysemu/sysemu.h"
+#include "qemu/uuid.h"
 
 /***********************************************************/
 /* ram save/restore */
@@ -361,6 +364,7 @@ static void compress_threads_save_setup(void)
 struct MultiFDSendParams {
     uint8_t id;
     QemuThread thread;
+    QIOChannel *c;
     QemuSemaphore sem;
     QemuMutex mutex;
     bool quit;
@@ -401,6 +405,7 @@ void multifd_save_cleanup(void)
         qemu_thread_join(&p->thread);
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
+        socket_send_channel_destroy(p->c);
     }
     g_free(multifd_send_state->params);
     multifd_send_state->params = NULL;
@@ -408,9 +413,26 @@ void multifd_save_cleanup(void)
     multifd_send_state = NULL;
 }
 
+/* Default uuid for multifd when qemu is not started with uuid */
+static char multifd_uuid[] = "5c49fd7e-af88-4a07-b6e8-091fd696ad40";
+/* strlen(multifd) + '-' + <channel id> + '-' +  UUID_FMT + '\0' */
+#define MULTIFD_UUID_MSG (7 + 1 + 3 + 1 + UUID_FMT_LEN + 1)
+
 static void *multifd_send_thread(void *opaque)
 {
     MultiFDSendParams *p = opaque;
+    char *string;
+    char *string_uuid;
+
+    if (qemu_uuid_set) {
+        string_uuid = qemu_uuid_unparse_strdup(&qemu_uuid);
+    } else {
+        string_uuid = g_strdup(multifd_uuid);
+    }
+    string = g_strdup_printf("%s multifd %03d", string_uuid, p->id);
+    g_free(string_uuid);
+    qio_channel_write(p->c, string, MULTIFD_UUID_MSG, &error_abort);
+    g_free(string);
 
     while (true) {
         qemu_mutex_lock(&p->mutex);
@@ -445,6 +467,12 @@ int multifd_save_setup(void)
         qemu_sem_init(&p->sem, 0);
         p->quit = false;
         p->id = i;
+        p->c = socket_send_channel_create();
+        if (!p->c) {
+            error_report("Error creating a send channel");
+            multifd_save_cleanup();
+            return -1;
+        }
         snprintf(thread_name, sizeof(thread_name), "multifdsend_%d", i);
         qemu_thread_create(&p->thread, thread_name, multifd_send_thread, p,
                            QEMU_THREAD_JOINABLE);
@@ -456,6 +484,7 @@ int multifd_save_setup(void)
 struct MultiFDRecvParams {
     uint8_t id;
     QemuThread thread;
+    QIOChannel *c;
     QemuSemaphore sem;
     QemuMutex mutex;
     bool quit;
@@ -466,12 +495,16 @@ struct {
     MultiFDRecvParams **params;
     /* number of created threads */
     int count;
+    /* Should we finish */
+    bool quit;
 } *multifd_recv_state;
 
 static void terminate_multifd_recv_threads(void)
 {
     int i;
 
+    multifd_recv_state->quit = true;
+
     for (i = 0; i < multifd_recv_state->count; i++) {
         MultiFDRecvParams *p = multifd_recv_state->params[i];
 
@@ -496,6 +529,7 @@ void multifd_load_cleanup(void)
         qemu_thread_join(&p->thread);
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
+        socket_recv_channel_destroy(p->c);
         g_free(p);
         multifd_recv_state->params[i] = NULL;
     }
@@ -522,10 +556,54 @@ static void *multifd_recv_thread(void *opaque)
     return NULL;
 }
 
+void multifd_new_channel(QIOChannel *ioc)
+{
+    MultiFDRecvParams *p = g_new0(MultiFDRecvParams, 1);
+    MigrationState *s = migrate_get_current();
+    char string[MULTIFD_UUID_MSG];
+    char string_uuid[UUID_FMT_LEN];
+    char *uuid;
+    int id;
+
+    qio_channel_read(ioc, string, sizeof(string), &error_abort);
+    sscanf(string, "%s multifd %03d", string_uuid, &id);
+
+    if (qemu_uuid_set) {
+        uuid = qemu_uuid_unparse_strdup(&qemu_uuid);
+    } else {
+        uuid = g_strdup(multifd_uuid);
+    }
+    if (strcmp(string_uuid, uuid)) {
+        error_report("multifd: received uuid '%s' and expected uuid '%s'"
+                     " for channel %d", string_uuid, uuid, id);
+        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
+                          MIGRATION_STATUS_FAILED);
+        terminate_multifd_recv_threads();
+        return;
+    }
+    g_free(uuid);
+
+    if (multifd_recv_state->params[id] != NULL) {
+        error_report("multifd: received id '%d' is already setup'", id);
+        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
+                          MIGRATION_STATUS_FAILED);
+        terminate_multifd_recv_threads();
+        return;
+    }
+    qemu_mutex_init(&p->mutex);
+    qemu_sem_init(&p->sem, 0);
+    p->quit = false;
+    p->id = id;
+    p->c = ioc;
+    atomic_set(&multifd_recv_state->params[id], p);
+    multifd_recv_state->count++;
+    qemu_thread_create(&p->thread, "multifd_recv", multifd_recv_thread, p,
+                       QEMU_THREAD_JOINABLE);
+}
+
 int multifd_load_setup(void)
 {
     int thread_count;
-    uint8_t i;
 
     if (!migrate_use_multifd()) {
         return 0;
@@ -534,22 +612,15 @@ int multifd_load_setup(void)
     multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
     multifd_recv_state->params = g_new0(MultiFDRecvParams *, thread_count);
     multifd_recv_state->count = 0;
-    for (i = 0; i < thread_count; i++) {
-        char thread_name[16];
-        MultiFDRecvParams *p = multifd_recv_state->params[i];
-
-        qemu_mutex_init(&p->mutex);
-        qemu_sem_init(&p->sem, 0);
-        p->quit = false;
-        p->id = i;
-        snprintf(thread_name, sizeof(thread_name), "multifdrecv_%d", i);
-        qemu_thread_create(&p->thread, thread_name, multifd_recv_thread, p,
-                           QEMU_THREAD_JOINABLE);
-        multifd_recv_state->count++;
-    }
+    multifd_recv_state->quit = false;
     return 0;
 }
 
+int multifd_created_threads(void)
+{
+    return multifd_recv_state->count;
+}
+
 /**
  * save_page_header: write page header to wire
  *
diff --git a/migration/ram.h b/migration/ram.h
index 93c2bb4..b3dabf2 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -31,6 +31,7 @@
 
 #include "qemu-common.h"
 #include "exec/cpu-common.h"
+#include "io/channel.h"
 
 extern MigrationStats ram_counters;
 extern XBZRLECacheStats xbzrle_counters;
@@ -43,6 +44,8 @@ int multifd_save_setup(void);
 void multifd_save_cleanup(void);
 int multifd_load_setup(void);
 void multifd_load_cleanup(void);
+void multifd_new_channel(QIOChannel *ioc);
+int multifd_created_threads(void);
 
 uint64_t ram_pagesize_summary(void);
 int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len);
diff --git a/migration/socket.c b/migration/socket.c
index dee8690..5dd6f42 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -26,6 +26,38 @@
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
+    Error **errp;
+} outgoing_args;
+
+QIOChannel *socket_send_channel_create(void)
+{
+    QIOChannelSocket *sioc = qio_channel_socket_new();
+
+    qio_channel_socket_connect_sync(sioc, outgoing_args.saddr,
+                                    outgoing_args.errp);
+    qio_channel_set_delay(QIO_CHANNEL(sioc), false);
+    return QIO_CHANNEL(sioc);
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
@@ -96,6 +128,9 @@ static void socket_start_outgoing_migration(MigrationState *s,
     struct SocketConnectData *data = g_new0(struct SocketConnectData, 1);
 
     data->s = s;
+    outgoing_args.saddr = saddr;
+    outgoing_args.errp = errp;
+
     if (saddr->type == SOCKET_ADDRESS_TYPE_INET) {
         data->hostname = g_strdup(saddr->u.inet.host);
     }
@@ -106,7 +141,6 @@ static void socket_start_outgoing_migration(MigrationState *s,
                                      socket_outgoing_migration,
                                      data,
                                      socket_connect_data_free);
-    qapi_free_SocketAddress(saddr);
 }
 
 void tcp_start_outgoing_migration(MigrationState *s,
diff --git a/migration/socket.h b/migration/socket.h
index 6b91e9d..dabce0e 100644
--- a/migration/socket.h
+++ b/migration/socket.h
@@ -16,6 +16,16 @@
 
 #ifndef QEMU_MIGRATION_SOCKET_H
 #define QEMU_MIGRATION_SOCKET_H
+
+#include "io/channel.h"
+
+QIOChannel *socket_recv_channel_create(void);
+int socket_recv_channel_destroy(QIOChannel *recv);
+
+QIOChannel *socket_send_channel_create(void);
+
+int socket_send_channel_destroy(QIOChannel *send);
+
 void tcp_start_incoming_migration(const char *host_port, Error **errp);
 
 void tcp_start_outgoing_migration(MigrationState *s, const char *host_port,
-- 
2.9.4
