Received: from eggs.gnu.org ([2001:4830:134:3::10]:56489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnPLJ-0004OR-Hm
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnPLI-0005vm-AG
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:44:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cnPLI-0005v7-1f
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:44:52 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 363B683F46
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 12:44:52 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 13 Mar 2017 13:44:27 +0100
Message-Id: <20170313124434.1043-10-quintela@redhat.com>
In-Reply-To: <20170313124434.1043-1-quintela@redhat.com>
References: <20170313124434.1043-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 09/16] migration: Start of multiple fd work
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

Signed-off-by: Juan Quintela <quintela@redhat.com>

--
Split SocketArgs into incoming and outgoing args

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/migration.h |  7 +++++
 migration/ram.c               | 35 ++++++++++++++++++++++
 migration/socket.c            | 67 +++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 106 insertions(+), 3 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index e8b9fcb..cbb049d 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -23,6 +23,7 @@
 #include "exec/cpu-common.h"
 #include "qemu/coroutine_int.h"
 #include "qom/object.h"
+#include "io/channel.h"
 
 #define QEMU_VM_FILE_MAGIC           0x5145564d
 #define QEMU_VM_FILE_VERSION_COMPAT  0x00000002
@@ -235,6 +236,12 @@ void tcp_start_incoming_migration(const char *host_port, Error **errp);
 
 void tcp_start_outgoing_migration(MigrationState *s, const char *host_port, Error **errp);
 
+QIOChannel *socket_recv_channel_create(void);
+int socket_recv_channel_destroy(QIOChannel *recv);
+int socket_recv_channel_close_listening(void);
+QIOChannel *socket_send_channel_create(void);
+int socket_send_channel_destroy(QIOChannel *send);
+
 void unix_start_incoming_migration(const char *path, Error **errp);
 
 void unix_start_outgoing_migration(MigrationState *s, const char *path, Error **errp);
diff --git a/migration/ram.c b/migration/ram.c
index ee32fa8..7833e6f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -387,7 +387,9 @@ void migrate_compress_threads_create(void)
 struct MultiFDSendParams {
     int id;
     QemuThread thread;
+    QIOChannel *c;
     QemuSemaphore sem;
+    QemuSemaphore init;
     QemuMutex mutex;
     bool quit;
 };
@@ -427,6 +429,8 @@ void migrate_multifd_send_threads_join(void)
         qemu_thread_join(&p->thread);
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
+        qemu_sem_destroy(&p->init);
+        socket_send_channel_destroy(p->c);
     }
     g_free(multifd_send_state->params);
     multifd_send_state->params = NULL;
@@ -438,6 +442,11 @@ static void *multifd_send_thread(void *opaque)
 {
     MultiFDSendParams *p = opaque;
 
+    char start = 's';
+
+    qio_channel_write(p->c, &start, 1, &error_abort);
+    qemu_sem_post(&p->init);
+
     while (true) {
         qemu_mutex_lock(&p->mutex);
         if (p->quit) {
@@ -468,12 +477,20 @@ int migrate_multifd_send_threads_create(void)
 
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem, 0);
+        qemu_sem_init(&p->init, 0);
         p->quit = false;
         p->id = i;
+        p->c = socket_send_channel_create();
+        if (!p->c) {
+            error_report("Error creating a send channel");
+            migrate_multifd_send_threads_join();
+            return -1;
+        }
         snprintf(thread_name, 15, "multifd_send_%d", i);
         qemu_thread_create(&p->thread, thread_name, multifd_send_thread, p,
                            QEMU_THREAD_JOINABLE);
         multifd_send_state->count++;
+        qemu_sem_wait(&p->init);
     }
     return 0;
 }
@@ -481,6 +498,8 @@ int migrate_multifd_send_threads_create(void)
 struct MultiFDRecvParams {
     int id;
     QemuThread thread;
+    QIOChannel *c;
+    QemuSemaphore init;
     QemuSemaphore sem;
     QemuMutex mutex;
     bool quit;
@@ -521,6 +540,8 @@ void migrate_multifd_recv_threads_join(void)
         qemu_thread_join(&p->thread);
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
+        qemu_sem_destroy(&p->init);
+        socket_send_channel_destroy(multifd_recv_state->params[i].c);
     }
     g_free(multifd_recv_state->params);
     multifd_recv_state->params = NULL;
@@ -531,6 +552,10 @@ void migrate_multifd_recv_threads_join(void)
 static void *multifd_recv_thread(void *opaque)
 {
     MultiFDRecvParams *p = opaque;
+    char start;
+
+    qio_channel_read(p->c, &start, 1, &error_abort);
+    qemu_sem_post(&p->init);
 
     while (true) {
         qemu_mutex_lock(&p->mutex);
@@ -561,12 +586,22 @@ int migrate_multifd_recv_threads_create(void)
 
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem, 0);
+        qemu_sem_init(&p->init, 0);
         p->quit = false;
         p->id = i;
+        p->c = socket_recv_channel_create();
+
+        if (!p->c) {
+            error_report("Error creating a recv channel");
+            migrate_multifd_recv_threads_join();
+            return -1;
+        }
         qemu_thread_create(&p->thread, "multifd_recv", multifd_recv_thread, p,
                            QEMU_THREAD_JOINABLE);
         multifd_recv_state->count++;
+        qemu_sem_wait(&p->init);
     }
+    socket_recv_channel_close_listening();
     return 0;
 }
 
diff --git a/migration/socket.c b/migration/socket.c
index 13966f1..58a16b5 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -24,6 +24,65 @@
 #include "io/channel-socket.h"
 #include "trace.h"
 
+struct SocketIncomingArgs {
+    QIOChannelSocket *ioc;
+} incoming_args;
+
+QIOChannel *socket_recv_channel_create(void)
+{
+    QIOChannelSocket *sioc;
+    Error *err = NULL;
+
+    sioc = qio_channel_socket_accept(QIO_CHANNEL_SOCKET(incoming_args.ioc),
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
+    /* Remove channel */
+    object_unref(OBJECT(send));
+    return 0;
+}
+
+/* we have created all the recv channels, we can close the main one */
+int socket_recv_channel_close_listening(void)
+{
+    /* Close listening socket as its no longer needed */
+    qio_channel_close(QIO_CHANNEL(incoming_args.ioc), NULL);
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
@@ -97,6 +156,10 @@ static void socket_start_outgoing_migration(MigrationState *s,
     struct SocketConnectData *data = g_new0(struct SocketConnectData, 1);
 
     data->s = s;
+
+    outgoing_args.saddr = saddr;
+    outgoing_args.errp = errp;
+
     if (saddr->type == SOCKET_ADDRESS_KIND_INET) {
         data->hostname = g_strdup(saddr->u.inet.data->host);
     }
@@ -107,7 +170,6 @@ static void socket_start_outgoing_migration(MigrationState *s,
                                      socket_outgoing_migration,
                                      data,
                                      socket_connect_data_free);
-    qapi_free_SocketAddress(saddr);
 }
 
 void tcp_start_outgoing_migration(MigrationState *s,
@@ -154,8 +216,6 @@ static gboolean socket_accept_incoming_migration(QIOChannel *ioc,
     object_unref(OBJECT(sioc));
 
 out:
-    /* Close listening socket as its no longer needed */
-    qio_channel_close(ioc, NULL);
     return FALSE; /* unregister */
 }
 
@@ -164,6 +224,7 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
                                             Error **errp)
 {
     QIOChannelSocket *listen_ioc = qio_channel_socket_new();
+    incoming_args.ioc = listen_ioc;
 
     qio_channel_set_name(QIO_CHANNEL(listen_ioc),
                          "migration-socket-listener");
-- 
2.9.3
