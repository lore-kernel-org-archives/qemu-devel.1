Received: from eggs.gnu.org ([2001:4830:134:3::10]:54052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1Xej-0002Aj-Aq
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:27:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1Xei-0000dD-Eb
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:27:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d1Xei-0000cr-9F
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:27:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 538818FADA
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 12:27:19 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Fri, 21 Apr 2017 20:26:59 +0800
Message-Id: <20170421122710.15373-4-famz@redhat.com>
In-Reply-To: <20170421122710.15373-1-famz@redhat.com>
References: <20170421122710.15373-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 03/14] socket: Make errp the last parameter of
 unix_connect_saddr
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
 util/qemu-sockets.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 8e11349..0fe5f13 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -911,8 +911,9 @@ err:
     return -1;
 }
 
-static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp,
-                              NonBlockingConnectHandler *callback, void *opaque)
+static int unix_connect_saddr(UnixSocketAddress *saddr,
+                              NonBlockingConnectHandler *callback, void *opaque,
+                              Error **errp)
 {
     struct sockaddr_un un;
     ConnectState *connect_state = NULL;
@@ -979,8 +980,9 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
     return -1;
 }
 
-static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp,
-                              NonBlockingConnectHandler *callback, void *opaque)
+static int unix_connect_saddr(UnixSocketAddress *saddr,
+                              NonBlockingConnectHandler *callback, void *opaque,
+                              Error **errp)
 {
     error_setg(errp, "unix sockets are not available on windows");
     errno = ENOTSUP;
@@ -1026,7 +1028,7 @@ int unix_connect(const char *path, Error **errp)
 
     saddr = g_new0(UnixSocketAddress, 1);
     saddr->path = g_strdup(path);
-    sock = unix_connect_saddr(saddr, errp, NULL, NULL);
+    sock = unix_connect_saddr(saddr, NULL, NULL, errp);
     qapi_free_UnixSocketAddress(saddr);
     return sock;
 }
@@ -1086,7 +1088,7 @@ int socket_connect(SocketAddress *addr, NonBlockingConnectHandler *callback,
         break;
 
     case SOCKET_ADDRESS_KIND_UNIX:
-        fd = unix_connect_saddr(addr->u.q_unix.data, errp, callback, opaque);
+        fd = unix_connect_saddr(addr->u.q_unix.data, callback, opaque, errp);
         break;
 
     case SOCKET_ADDRESS_KIND_FD:
-- 
2.9.3
