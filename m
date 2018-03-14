Received: from eggs.gnu.org ([2001:4830:134:3::10]:50462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ew9QT-0007aB-HT
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 12:38:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ew9QQ-0004L0-8o
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 12:38:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35946 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ew9QQ-0004K3-3H
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 12:38:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 04C88406E968
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 16:38:46 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 14 Mar 2018 17:38:31 +0100
Message-Id: <20180314163838.7158-2-quintela@redhat.com>
In-Reply-To: <20180314163838.7158-1-quintela@redhat.com>
References: <20180314163838.7158-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v6 1/8] qemu-sockets: Export
 SocketAddress_to_str
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

Migration code needs that function in hmp.c (so we need to export it),
and it needs it on tests/migration-test.c, so we need to move it to a
place where it is compiled into the test framework.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 chardev/char-socket.c  | 29 -----------------------------
 include/qemu/sockets.h |  3 +++
 util/qemu-sockets.c    | 29 +++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index a220803c01..dc27ecce81 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -373,35 +373,6 @@ static void tcp_chr_free_connection(Chardev *chr)
     s->connected = 0;
 }
 
-static char *SocketAddress_to_str(const char *prefix, SocketAddress *addr,
-                                  bool is_listen, bool is_telnet)
-{
-    switch (addr->type) {
-    case SOCKET_ADDRESS_TYPE_INET:
-        return g_strdup_printf("%s%s:%s:%s%s", prefix,
-                               is_telnet ? "telnet" : "tcp",
-                               addr->u.inet.host,
-                               addr->u.inet.port,
-                               is_listen ? ",server" : "");
-        break;
-    case SOCKET_ADDRESS_TYPE_UNIX:
-        return g_strdup_printf("%sunix:%s%s", prefix,
-                               addr->u.q_unix.path,
-                               is_listen ? ",server" : "");
-        break;
-    case SOCKET_ADDRESS_TYPE_FD:
-        return g_strdup_printf("%sfd:%s%s", prefix, addr->u.fd.str,
-                               is_listen ? ",server" : "");
-        break;
-    case SOCKET_ADDRESS_TYPE_VSOCK:
-        return g_strdup_printf("%svsock:%s:%s", prefix,
-                               addr->u.vsock.cid,
-                               addr->u.vsock.port);
-    default:
-        abort();
-    }
-}
-
 static void update_disconnected_filename(SocketChardev *s)
 {
     Chardev *chr = CHARDEV(s);
diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index e88d4c37ab..a8bc2d7cfb 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -109,4 +109,7 @@ SocketAddress *socket_remote_address(int fd, Error **errp);
  */
 SocketAddress *socket_address_flatten(SocketAddressLegacy *addr);
 
+char *SocketAddress_to_str(const char *prefix, SocketAddress *addr,
+                           bool is_listen, bool is_telnet);
+
 #endif /* QEMU_SOCKETS_H */
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 7f13e8a338..25965c6ee1 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -1301,3 +1301,32 @@ SocketAddress *socket_address_flatten(SocketAddressLegacy *addr_legacy)
 
     return addr;
 }
+
+char *SocketAddress_to_str(const char *prefix, SocketAddress *addr,
+                                  bool is_listen, bool is_telnet)
+{
+    switch (addr->type) {
+    case SOCKET_ADDRESS_TYPE_INET:
+        return g_strdup_printf("%s%s:%s:%s%s", prefix,
+                               is_telnet ? "telnet" : "tcp",
+                               addr->u.inet.host,
+                               addr->u.inet.port,
+                               is_listen ? ",server" : "");
+        break;
+    case SOCKET_ADDRESS_TYPE_UNIX:
+        return g_strdup_printf("%sunix:%s%s", prefix,
+                               addr->u.q_unix.path,
+                               is_listen ? ",server" : "");
+        break;
+    case SOCKET_ADDRESS_TYPE_FD:
+        return g_strdup_printf("%sfd:%s%s", prefix, addr->u.fd.str,
+                               is_listen ? ",server" : "");
+        break;
+    case SOCKET_ADDRESS_TYPE_VSOCK:
+        return g_strdup_printf("%svsock:%s:%s", prefix,
+                               addr->u.vsock.cid,
+                               addr->u.vsock.port);
+    default:
+        abort();
+    }
+}
-- 
2.14.3
