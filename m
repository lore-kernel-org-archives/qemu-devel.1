Received: from eggs.gnu.org ([2001:4830:134:3::10]:53508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d2YOm-0003vI-Ft
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:27:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d2YOl-0006uo-GB
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:27:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d2YOl-0006ue-7o
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:27:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 43C818553D
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 07:27:02 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 24 Apr 2017 09:26:47 +0200
Message-Id: <1493018820-23445-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1493018820-23445-1-git-send-email-armbru@redhat.com>
References: <1493018820-23445-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 02/15] socket: Make errp the last parameter of
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
Cc: Fam Zheng <famz@redhat.com>

From: Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170421122710.15373-2-famz@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
2.7.4
