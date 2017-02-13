Received: from eggs.gnu.org ([2001:4830:134:3::10]:57847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdKIQ-00087D-GE
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:20:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdKIL-0004xv-Nw
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:20:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cdKIL-0004xK-G8
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:20:09 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B87473B708
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 17:20:09 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 13 Feb 2017 18:19:43 +0100
Message-Id: <1487006388-7966-8-git-send-email-quintela@redhat.com>
In-Reply-To: <1487006388-7966-1-git-send-email-quintela@redhat.com>
References: <1487006388-7966-1-git-send-email-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 07/12] migration: Start of multiple fd work
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
---
 include/migration/migration.h |  7 +++++
 migration/ram.c               | 33 ++++++++++++++++++++++
 migration/socket.c            | 64 +++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 101 insertions(+), 3 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 13fac75..ff890b5 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -22,6 +22,7 @@
 #include "qapi-types.h"
 #include "exec/cpu-common.h"
 #include "qemu/coroutine_int.h"
+#include "io/channel.h"

 #define QEMU_VM_FILE_MAGIC           0x5145564d
 #define QEMU_VM_FILE_VERSION_COMPAT  0x00000002
@@ -224,6 +225,12 @@ void tcp_start_incoming_migration(const char *host_port, Error **errp);

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
index 0cb19cf..b101a59 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -386,7 +386,9 @@ void migrate_compress_threads_create(void)

 struct MultiFDSendParams {
     QemuThread thread;
+    QIOChannel *c;
     QemuSemaphore sem;
+    QemuSemaphore init;
     QemuMutex mutex;
     bool quit;
 };
@@ -397,6 +399,10 @@ static MultiFDSendParams *multifd_send;
 static void *multifd_send_thread(void *opaque)
 {
     MultiFDSendParams *params = opaque;
+    char start = 's';
+
+    qio_channel_write(params->c, &start, 1, &error_abort);
+    qemu_sem_post(&params->init);

     while (true) {
         qemu_mutex_lock(&params->mutex);
@@ -441,7 +447,10 @@ void migrate_multifd_send_threads_join(void)
         qemu_thread_join(&p->thread);
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
+        qemu_sem_destroy(&p->init);
+        socket_send_channel_destroy(p->c);
     }
+
     g_free(multifd_send);
     multifd_send = NULL;
 }
@@ -461,15 +470,24 @@ void migrate_multifd_send_threads_create(void)

         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem, 0);
+        qemu_sem_init(&p->init, 0);
         p->quit = false;
+        p->c = socket_send_channel_create();
+        if (!p->c) {
+            error_report("Error creating a send channel");
+            exit(0);
+        }
         snprintf(thread_name, 15, "multifd_send_%d", i);
         qemu_thread_create(&p->thread, thread_name, multifd_send_thread, p,
                            QEMU_THREAD_JOINABLE);
+        qemu_sem_wait(&p->init);
     }
 }

 struct MultiFDRecvParams {
     QemuThread thread;
+    QIOChannel *c;
+    QemuSemaphore init;
     QemuSemaphore sem;
     QemuMutex mutex;
     bool quit;
@@ -481,6 +499,10 @@ static MultiFDRecvParams *multifd_recv;
 static void *multifd_recv_thread(void *opaque)
 {
     MultiFDRecvParams *params = opaque;
+    char start;
+
+    qio_channel_read(params->c, &start, 1, &error_abort);
+    qemu_sem_post(&params->init);

     while (true) {
         qemu_mutex_lock(&params->mutex);
@@ -525,6 +547,8 @@ void migrate_multifd_recv_threads_join(void)
         qemu_thread_join(&p->thread);
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
+        qemu_sem_destroy(&p->init);
+        socket_send_channel_destroy(multifd_recv[i].c);
     }
     g_free(multifd_recv);
     multifd_recv = NULL;
@@ -544,10 +568,19 @@ void migrate_multifd_recv_threads_create(void)

         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem, 0);
+        qemu_sem_init(&p->init, 0);
         p->quit = false;
+        p->c = socket_recv_channel_create();
+
+        if (!p->c) {
+            error_report("Error creating a recv channel");
+            exit(0);
+        }
         qemu_thread_create(&p->thread, "multifd_recv", multifd_recv_thread, p,
                            QEMU_THREAD_JOINABLE);
+        qemu_sem_wait(&p->init);
     }
+    socket_recv_channel_close_listening();
 }

 /**
diff --git a/migration/socket.c b/migration/socket.c
index 13966f1..1c764f1 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -24,6 +24,62 @@
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
+    /* Remove channel */
+    object_unref(OBJECT(send));
+    return 0;
+}
+
+/* we have created all the recv channels, we can close the main one */
+int socket_recv_channel_close_listening(void)
+{
+    /* Close listening socket as its no longer needed */
+    qio_channel_close(QIO_CHANNEL(socket_args.ioc), NULL);
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
+    /* Remove channel */
+    object_unref(OBJECT(send));
+    if (socket_args.saddr) {
+        qapi_free_SocketAddress(socket_args.saddr);
+        socket_args.saddr = NULL;
+    }
+    return 0;
+}

 static SocketAddress *tcp_build_address(const char *host_port, Error **errp)
 {
@@ -97,6 +153,10 @@ static void socket_start_outgoing_migration(MigrationState *s,
     struct SocketConnectData *data = g_new0(struct SocketConnectData, 1);

     data->s = s;
+
+    socket_args.saddr = saddr;
+    socket_args.errp = errp;
+
     if (saddr->type == SOCKET_ADDRESS_KIND_INET) {
         data->hostname = g_strdup(saddr->u.inet.data->host);
     }
@@ -107,7 +167,6 @@ static void socket_start_outgoing_migration(MigrationState *s,
                                      socket_outgoing_migration,
                                      data,
                                      socket_connect_data_free);
-    qapi_free_SocketAddress(saddr);
 }

 void tcp_start_outgoing_migration(MigrationState *s,
@@ -154,8 +213,6 @@ static gboolean socket_accept_incoming_migration(QIOChannel *ioc,
     object_unref(OBJECT(sioc));

 out:
-    /* Close listening socket as its no longer needed */
-    qio_channel_close(ioc, NULL);
     return FALSE; /* unregister */
 }

@@ -164,6 +221,7 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
                                             Error **errp)
 {
     QIOChannelSocket *listen_ioc = qio_channel_socket_new();
+    socket_args.ioc = listen_ioc;

     qio_channel_set_name(QIO_CHANNEL(listen_ioc),
                          "migration-socket-listener");
-- 
2.7.4
