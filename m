Received: from eggs.gnu.org ([2001:4830:134:3::10]:54078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1Xel-0002CU-0a
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:27:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1Xek-0000dw-Af
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:27:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d1Xek-0000dj-4W
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:27:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 24AFC6AAC8
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 12:27:21 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Fri, 21 Apr 2017 20:27:00 +0800
Message-Id: <20170421122710.15373-5-famz@redhat.com>
In-Reply-To: <20170421122710.15373-1-famz@redhat.com>
References: <20170421122710.15373-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 04/14] socket: Make errp the last parameter of
 vsock_connect_saddr
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
 util/qemu-sockets.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 0fe5f13..8188d9a 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -728,9 +728,10 @@ static int vsock_connect_addr(const struct sockaddr_vm *svm, bool *in_progress,
     return sock;
 }
 
-static int vsock_connect_saddr(VsockSocketAddress *vaddr, Error **errp,
+static int vsock_connect_saddr(VsockSocketAddress *vaddr,
                                NonBlockingConnectHandler *callback,
-                               void *opaque)
+                               void *opaque,
+                               Error **errp)
 {
     struct sockaddr_vm svm;
     int sock = -1;
@@ -819,9 +820,9 @@ static void vsock_unsupported(Error **errp)
     error_setg(errp, "socket family AF_VSOCK unsupported");
 }
 
-static int vsock_connect_saddr(VsockSocketAddress *vaddr, Error **errp,
+static int vsock_connect_saddr(VsockSocketAddress *vaddr,
                                NonBlockingConnectHandler *callback,
-                               void *opaque)
+                               void *opaque, Error **errp)
 {
     vsock_unsupported(errp);
     return -1;
@@ -1100,7 +1101,7 @@ int socket_connect(SocketAddress *addr, NonBlockingConnectHandler *callback,
         break;
 
     case SOCKET_ADDRESS_KIND_VSOCK:
-        fd = vsock_connect_saddr(addr->u.vsock.data, errp, callback, opaque);
+        fd = vsock_connect_saddr(addr->u.vsock.data, callback, opaque, errp);
         break;
 
     default:
-- 
2.9.3
