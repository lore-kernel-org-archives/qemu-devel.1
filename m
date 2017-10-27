Received: from eggs.gnu.org ([2001:4830:134:3::10]:58758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e80Rc-00039d-Kq
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 04:56:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e80RX-0000p1-NO
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 04:56:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e80RX-0000ok-Hd
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 04:56:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 88DEE34C4
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 08:56:42 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 27 Oct 2017 09:56:33 +0100
Message-Id: <20171027085633.14367-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] sockets: avoid crash when cleaning up sockets
 for an invalid FD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

If socket_listen_cleanup is passed an invalid FD, then querying the socket
local address will fail. We must thus be prepared for the returned addr to
be NULL

Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 util/qemu-sockets.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index b47fb45885..c7fdaa63fb 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -1073,6 +1073,9 @@ void socket_listen_cleanup(int fd, Error **errp)
     SocketAddress *addr;
 
     addr = socket_local_address(fd, errp);
+    if (!addr) {
+        return;
+    }
 
     if (addr->type == SOCKET_ADDRESS_TYPE_UNIX
         && addr->u.q_unix.path) {
-- 
2.13.6
