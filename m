Received: from eggs.gnu.org ([2001:4830:134:3::10]:51911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eJdzC-0002Je-Me
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:23:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eJdz8-0004AS-OF
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:23:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eJdz8-0004A8-IQ
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:23:30 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 28 Nov 2017 11:23:01 +0000
Message-Id: <20171128112301.5636-2-berrange@redhat.com>
In-Reply-To: <20171128112301.5636-1-berrange@redhat.com>
References: <20171128112301.5636-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL (for 2.11) v1 1/1] sockets: avoid crash when
 cleaning up sockets for an invalid FD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

If socket_listen_cleanup is passed an invalid FD, then querying the socket
local address will fail. We must thus be prepared for the returned addr to
be NULL

Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 util/qemu-sockets.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 8b75541ce4..a1cf47e625 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -1079,6 +1079,9 @@ void socket_listen_cleanup(int fd, Error **errp)
     SocketAddress *addr;
 
     addr = socket_local_address(fd, errp);
+    if (!addr) {
+        return;
+    }
 
     if (addr->type == SOCKET_ADDRESS_TYPE_UNIX
         && addr->u.q_unix.path) {
-- 
2.14.3
