Received: from eggs.gnu.org ([2001:4830:134:3::10]:60377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fBISl-0004Np-AL
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fBISf-0004dj-1c
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:19:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45346 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fBISe-0004dI-Rj
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:19:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7C1EE4023155
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 11:19:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 25 Apr 2018 13:19:33 +0200
Message-Id: <20180425111940.1030-2-quintela@redhat.com>
In-Reply-To: <20180425111940.1030-1-quintela@redhat.com>
References: <20180425111940.1030-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v8 1/8] qemu-sockets: Export
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
index 159e69c3b1..3bbf3a37a0 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -382,35 +382,6 @@ static void tcp_chr_free_connection(Chardev *chr)
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
index 8140fea685..efea0ea850 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -110,4 +110,7 @@ SocketAddress *socket_remote_address(int fd, Error **errp);
  */
 SocketAddress *socket_address_flatten(SocketAddressLegacy *addr);
 
+char *SocketAddress_to_str(const char *prefix, SocketAddress *addr,
+                           bool is_listen, bool is_telnet);
+
 #endif /* QEMU_SOCKETS_H */
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 8bd8bb64eb..09f04bf76b 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -1333,3 +1333,32 @@ SocketAddress *socket_address_flatten(SocketAddressLegacy *addr_legacy)
 
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
2.17.0
