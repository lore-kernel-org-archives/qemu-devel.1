Received: from eggs.gnu.org ([2001:4830:134:3::10]:59050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ewnwE-0006dn-59
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:54:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ewnwC-0002Y7-EJ
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:54:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52330 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ewnwC-0002Xt-94
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:54:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C4EA1406E96C
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 11:54:19 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 16 Mar 2018 12:53:54 +0100
Message-Id: <20180316115403.4148-7-quintela@redhat.com>
In-Reply-To: <20180316115403.4148-1-quintela@redhat.com>
References: <20180316115403.4148-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v11 06/15] migration: Export functions to
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
 migration/socket.h |  7 +++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/migration/socket.c b/migration/socket.c
index 8dda1d9a98..7889753fab 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -28,6 +28,28 @@
 #include "trace.h"
 
 
+struct SocketOutgoingArgs {
+    SocketAddress *saddr;
+} outgoing_args;
+
+void socket_send_channel_create(QIOTaskFunc f, void *data)
+{
+    QIOChannelSocket *sioc = qio_channel_socket_new();
+    qio_channel_socket_connect_async(sioc, outgoing_args.saddr,
+                                     f, data, NULL, NULL);
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
@@ -95,6 +117,11 @@ static void socket_start_outgoing_migration(MigrationState *s,
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
@@ -106,7 +133,6 @@ static void socket_start_outgoing_migration(MigrationState *s,
                                      data,
                                      socket_connect_data_free,
                                      NULL);
-    qapi_free_SocketAddress(saddr);
 }
 
 void tcp_start_outgoing_migration(MigrationState *s,
diff --git a/migration/socket.h b/migration/socket.h
index 6b91e9db38..528c3b0202 100644
--- a/migration/socket.h
+++ b/migration/socket.h
@@ -16,6 +16,13 @@
 
 #ifndef QEMU_MIGRATION_SOCKET_H
 #define QEMU_MIGRATION_SOCKET_H
+
+#include "io/channel.h"
+#include "io/task.h"
+
+void socket_send_channel_create(QIOTaskFunc f, void *data);
+int socket_send_channel_destroy(QIOChannel *send);
+
 void tcp_start_incoming_migration(const char *host_port, Error **errp);
 
 void tcp_start_outgoing_migration(MigrationState *s, const char *host_port,
-- 
2.14.3
