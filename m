Received: from eggs.gnu.org ([2001:4830:134:3::10]:54001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1Xeg-00028W-Tz
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:27:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1Xee-0000am-TC
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:27:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d1Xee-0000aO-Ll
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:27:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B0578C056793
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 12:27:15 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Fri, 21 Apr 2017 20:26:57 +0800
Message-Id: <20170421122710.15373-2-famz@redhat.com>
In-Reply-To: <20170421122710.15373-1-famz@redhat.com>
References: <20170421122710.15373-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 01/14] socket: Make errp the last parameter of
 socket_connect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/sheepdog.c       | 2 +-
 include/qemu/sockets.h | 4 ++--
 io/channel-socket.c    | 2 +-
 net/socket.c           | 2 +-
 util/qemu-sockets.c    | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index fb9203e..b2a5998 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -595,7 +595,7 @@ static int connect_to_sdog(BDRVSheepdogState *s, Error **errp)
 {
     int fd;
 
-    fd = socket_connect(s->addr, errp, NULL, NULL);
+    fd = socket_connect(s->addr, NULL, NULL, errp);
 
     if (s->addr->type == SOCKET_ADDRESS_KIND_INET && fd >= 0) {
         int ret = socket_set_nodelay(fd);
diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index 7842f6d..567eef1 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -45,8 +45,8 @@ int unix_listen(const char *path, char *ostr, int olen, Error **errp);
 int unix_connect(const char *path, Error **errp);
 
 SocketAddress *socket_parse(const char *str, Error **errp);
-int socket_connect(SocketAddress *addr, Error **errp,
-                   NonBlockingConnectHandler *callback, void *opaque);
+int socket_connect(SocketAddress *addr, NonBlockingConnectHandler *callback,
+                   void *opaque, Error **errp);
 int socket_listen(SocketAddress *addr, Error **errp);
 void socket_listen_cleanup(int fd, Error **errp);
 int socket_dgram(SocketAddress *remote, SocketAddress *local, Error **errp);
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 64b36f5..53386b7 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -140,7 +140,7 @@ int qio_channel_socket_connect_sync(QIOChannelSocket *ioc,
     int fd;
 
     trace_qio_channel_socket_connect_sync(ioc, addr);
-    fd = socket_connect(addr, errp, NULL, NULL);
+    fd = socket_connect(addr, NULL, NULL, errp);
     if (fd < 0) {
         trace_qio_channel_socket_connect_fail(ioc);
         return -1;
diff --git a/net/socket.c b/net/socket.c
index fe3547b..b8c931e 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -578,7 +578,7 @@ static int net_socket_connect_init(NetClientState *peer,
         goto err;
     }
 
-    fd = socket_connect(c->saddr, &local_error, net_socket_connected, c);
+    fd = socket_connect(c->saddr, net_socket_connected, c, &local_error);
     if (fd < 0) {
         goto err;
     }
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 21442c3..f79d334 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -1074,8 +1074,8 @@ fail:
     return NULL;
 }
 
-int socket_connect(SocketAddress *addr, Error **errp,
-                   NonBlockingConnectHandler *callback, void *opaque)
+int socket_connect(SocketAddress *addr, NonBlockingConnectHandler *callback,
+                   void *opaque, Error **errp)
 {
     int fd;
 
-- 
2.9.3
