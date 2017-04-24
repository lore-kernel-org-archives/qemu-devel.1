Received: from eggs.gnu.org ([2001:4830:134:3::10]:53625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d2YOs-0003zS-14
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:27:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d2YOo-0006wz-SG
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:27:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d2YOo-0006wS-MR
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:27:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A93E1369C4
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 07:27:05 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 24 Apr 2017 09:26:50 +0200
Message-Id: <1493018820-23445-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1493018820-23445-1-git-send-email-armbru@redhat.com>
References: <1493018820-23445-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 05/15] socket: Make errp the last parameter of
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
Cc: Fam Zheng <famz@redhat.com>

From: Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170421122710.15373-5-famz@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
2.7.4
