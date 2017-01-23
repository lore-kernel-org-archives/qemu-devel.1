Received: from eggs.gnu.org ([2001:4830:134:3::10]:33786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVmED-0002FF-L4
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVmEC-00036i-9Q
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cVmEC-00036S-0R
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:40 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 357C94DD58
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 21:32:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 23 Jan 2017 22:32:13 +0100
Message-Id: <1485207141-1941-10-git-send-email-quintela@redhat.com>
In-Reply-To: <1485207141-1941-1-git-send-email-quintela@redhat.com>
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 09/17] migration: Start of multiple fd work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, dgilbert@redhat.com

We create new channels for each new thread created. We only send through
them a character to be sure that we are creating the channels in the
right order.

Note: Reference count/freeing of channels is not done

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/migration.h |  6 +++++
 migration/ram.c               | 45 +++++++++++++++++++++++++++++++++-
 migration/socket.c            | 56 +++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 104 insertions(+), 3 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index f119ba0..3989bd6 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -22,6 +22,7 @@
 #include "qapi-types.h"
 #include "exec/cpu-common.h"
 #include "qemu/coroutine_int.h"
+#include "io/channel.h"

 #define QEMU_VM_FILE_MAGIC           0x5145564d
 #define QEMU_VM_FILE_VERSION_COMPAT  0x00000002
@@ -218,6 +219,11 @@ void tcp_start_incoming_migration(const char *host_port, Error **errp);

 void tcp_start_outgoing_migration(MigrationState *s, const char *host_port, Error **errp);

+QIOChannel *socket_recv_channel_create(void);
+int socket_recv_channel_destroy(QIOChannel *recv);
+QIOChannel *socket_send_channel_create(void);
+int socket_send_channel_destroy(QIOChannel *send);
+
 void unix_start_incoming_migration(const char *path, Error **errp);

 void unix_start_outgoing_migration(MigrationState *s, const char *path, Error **errp);
diff --git a/migration/ram.c b/migration/ram.c
index 939f364..5ad7cb3 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -386,9 +386,11 @@ void migrate_compress_threads_create(void)

 struct MultiFDSendParams {
     QemuThread thread;
+    QIOChannel *c;
     QemuCond cond;
     QemuMutex mutex;
     bool quit;
+    bool started;
 };
 typedef struct MultiFDSendParams MultiFDSendParams;

@@ -397,6 +399,13 @@ static MultiFDSendParams *multifd_send;
 static void *multifd_send_thread(void *opaque)
 {
     MultiFDSendParams *params = opaque;
+    char start = 's';
+
+    qio_channel_write(params->c, &start, 1, &error_abort);
+    qemu_mutex_lock(&params->mutex);
+    params->started = true;
+    qemu_cond_signal(&params->cond);
+    qemu_mutex_unlock(&params->mutex);

     qemu_mutex_lock(&params->mutex);
     while (!params->quit){
@@ -433,6 +442,7 @@ void migrate_multifd_send_threads_join(void)
         qemu_thread_join(&multifd_send[i].thread);
         qemu_mutex_destroy(&multifd_send[i].mutex);
         qemu_cond_destroy(&multifd_send[i].cond);
+        socket_send_channel_destroy(multifd_send[i].c);
     }
     g_free(multifd_send);
     multifd_send = NULL;
@@ -452,18 +462,31 @@ void migrate_multifd_send_threads_create(void)
         qemu_mutex_init(&multifd_send[i].mutex);
         qemu_cond_init(&multifd_send[i].cond);
         multifd_send[i].quit = false;
+        multifd_send[i].started = false;
+        multifd_send[i].c = socket_send_channel_create();
+        if(!multifd_send[i].c) {
+            error_report("Error creating a send channel");
+            exit(0);
+        }
         snprintf(thread_name, 15, "multifd_send_%d", i);
         qemu_thread_create(&multifd_send[i].thread, thread_name,
                            multifd_send_thread, &multifd_send[i],
                            QEMU_THREAD_JOINABLE);
+        qemu_mutex_lock(&multifd_send[i].mutex);
+        while (!multifd_send[i].started) {
+            qemu_cond_wait(&multifd_send[i].cond, &multifd_send[i].mutex);
+        }
+        qemu_mutex_unlock(&multifd_send[i].mutex);
     }
 }

 struct MultiFDRecvParams {
     QemuThread thread;
+    QIOChannel *c;
     QemuCond cond;
     QemuMutex mutex;
     bool quit;
+    bool started;
 };
 typedef struct MultiFDRecvParams MultiFDRecvParams;

@@ -472,7 +495,14 @@ static MultiFDRecvParams *multifd_recv;
 static void *multifd_recv_thread(void *opaque)
 {
     MultiFDRecvParams *params = opaque;
- 
+    char start;
+
+    qio_channel_read(params->c, &start, 1, &error_abort);
+    qemu_mutex_lock(&params->mutex);
+    params->started = true;
+    qemu_cond_signal(&params->cond);
+    qemu_mutex_unlock(&params->mutex);
+
     qemu_mutex_lock(&params->mutex);
     while (!params->quit){
         qemu_cond_wait(&params->cond, &params->mutex);
@@ -508,6 +538,7 @@ void migrate_multifd_recv_threads_join(void)
         qemu_thread_join(&multifd_recv[i].thread);
         qemu_mutex_destroy(&multifd_recv[i].mutex);
         qemu_cond_destroy(&multifd_recv[i].cond);
+        socket_send_channel_destroy(multifd_recv[i].c);
     }
     g_free(multifd_recv);
     multifd_recv = NULL;
@@ -526,9 +557,21 @@ void migrate_multifd_recv_threads_create(void)
         qemu_mutex_init(&multifd_recv[i].mutex);
         qemu_cond_init(&multifd_recv[i].cond);
         multifd_recv[i].quit = false;
+        multifd_recv[i].started = false;
+        multifd_recv[i].c = socket_recv_channel_create();
+
+        if(!multifd_recv[i].c) {
+            error_report("Error creating a recv channel");
+            exit(0);
+        }
         qemu_thread_create(&multifd_recv[i].thread, "multifd_recv",
                            multifd_recv_thread, &multifd_recv[i],
                            QEMU_THREAD_JOINABLE);
+        qemu_mutex_lock(&multifd_recv[i].mutex);
+        while (!multifd_recv[i].started) {
+            qemu_cond_wait(&multifd_recv[i].cond, &multifd_recv[i].mutex);
+        }
+        qemu_mutex_unlock(&multifd_recv[i].mutex);
     }
 }

diff --git a/migration/socket.c b/migration/socket.c
index 11f80b1..7cd9213 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -24,6 +24,54 @@
 #include "io/channel-socket.h"
 #include "trace.h"

+struct SocketArgs {
+    QIOChannelSocket *ioc;
+    SocketAddress *saddr;
+    Error **errp;
+} socket_args;
+
+QIOChannel *socket_recv_channel_create(void)
+{
+    QIOChannelSocket *sioc;
+    Error *err = NULL;
+
+    sioc = qio_channel_socket_accept(QIO_CHANNEL_SOCKET(socket_args.ioc),
+                                     &err);
+    if (!sioc) {
+        error_report("could not accept migration connection (%s)",
+                     error_get_pretty(err));
+        return NULL;
+    }
+    return QIO_CHANNEL(sioc);
+}
+
+int socket_recv_channel_destroy(QIOChannel *recv)
+{
+    // Remove channel
+    object_unref(OBJECT(send));
+    return 0;
+}
+
+QIOChannel *socket_send_channel_create(void)
+{
+    QIOChannelSocket *sioc = qio_channel_socket_new();
+
+    qio_channel_socket_connect_sync(sioc, socket_args.saddr,
+                                    socket_args.errp);
+    qio_channel_set_delay(QIO_CHANNEL(sioc), false);
+    return QIO_CHANNEL(sioc);
+}
+
+int socket_send_channel_destroy(QIOChannel *send)
+{
+    // Remove channel
+    object_unref(OBJECT(send));
+    if (socket_args.saddr) {
+        qapi_free_SocketAddress(socket_args.saddr);
+        socket_args.saddr = NULL;
+    }
+    return 0;
+}

 static SocketAddress *tcp_build_address(const char *host_port, Error **errp)
 {
@@ -96,6 +144,10 @@ static void socket_start_outgoing_migration(MigrationState *s,
     struct SocketConnectData *data = g_new0(struct SocketConnectData, 1);

     data->s = s;
+
+    socket_args.saddr = saddr;
+    socket_args.errp = errp;
+
     if (saddr->type == SOCKET_ADDRESS_KIND_INET) {
         data->hostname = g_strdup(saddr->u.inet.data->host);
     }
@@ -106,7 +158,6 @@ static void socket_start_outgoing_migration(MigrationState *s,
                                      socket_outgoing_migration,
                                      data,
                                      socket_connect_data_free);
-    qapi_free_SocketAddress(saddr);
 }

 void tcp_start_outgoing_migration(MigrationState *s,
@@ -154,7 +205,7 @@ static gboolean socket_accept_incoming_migration(QIOChannel *ioc,

 out:
     /* Close listening socket as its no longer needed */
-    qio_channel_close(ioc, NULL);
+//    qio_channel_close(ioc, NULL);
     return FALSE; /* unregister */
 }

@@ -163,6 +214,7 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
                                             Error **errp)
 {
     QIOChannelSocket *listen_ioc = qio_channel_socket_new();
+    socket_args.ioc = listen_ioc;

     qio_channel_set_name(QIO_CHANNEL(listen_ioc),
                          "migration-socket-listener");
-- 
2.9.3
