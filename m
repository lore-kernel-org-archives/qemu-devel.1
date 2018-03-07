Received: from eggs.gnu.org ([2001:4830:134:3::10]:59811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1etWoS-00055F-24
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1etWoM-0006Hl-Dg
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:48 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45262 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1etWoM-0006HY-8z
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:42 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C8A3B814F0CF
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 11:00:41 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  7 Mar 2018 12:00:03 +0100
Message-Id: <20180307110010.2205-18-quintela@redhat.com>
In-Reply-To: <20180307110010.2205-1-quintela@redhat.com>
References: <20180307110010.2205-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v10 17/24] migration: Export functions to
 create send channels
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/socket.c | 28 +++++++++++++++++++++++++++-
 migration/socket.h |  3 +++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/migration/socket.c b/migration/socket.c
index 26110739cf..b3b5571ebb 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -39,6 +39,28 @@ int socket_recv_channel_unref(QIOChannel *recv)
     return 0;
 }
 
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
+
 static SocketAddress *tcp_build_address(const char *host_port, Error **errp)
 {
     SocketAddress *saddr;
@@ -106,6 +128,11 @@ static void socket_start_outgoing_migration(MigrationState *s,
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
@@ -116,7 +143,6 @@ static void socket_start_outgoing_migration(MigrationState *s,
                                      socket_outgoing_migration,
                                      data,
                                      socket_connect_data_free);
-    qapi_free_SocketAddress(saddr);
 }
 
 void tcp_start_outgoing_migration(MigrationState *s,
diff --git a/migration/socket.h b/migration/socket.h
index 638a85255a..cbdb8d64c3 100644
--- a/migration/socket.h
+++ b/migration/socket.h
@@ -23,6 +23,9 @@
 int socket_recv_channel_ref(QIOChannel *recv);
 int socket_recv_channel_unref(QIOChannel *recv);
 
+void socket_send_channel_create(void (*f)(QIOTask *, gpointer), void *data);
+int socket_send_channel_destroy(QIOChannel *send);
+
 void tcp_start_incoming_migration(const char *host_port, Error **errp);
 
 void tcp_start_outgoing_migration(MigrationState *s, const char *host_port,
-- 
2.14.3
