Received: from eggs.gnu.org ([2001:4830:134:3::10]:34446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dxE9O-00019H-S3
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 11:21:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dxE9I-00078S-UT
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 11:21:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1dxE9I-00078A-PB
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 11:21:20 -0400
From: Jens Freimann <jfreimann@redhat.com>
Date: Wed, 27 Sep 2017 17:21:18 +0200
Message-Id: <20170927152118.13328-1-jfreimann@redhat.com>
Subject: [Qemu-devel] [PATCH v3] net: fix check for number of parameters to
 -netdev socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, maozy.fnst@cn.fujitsu.com

Since commit 0f8c289ad "net: fix -netdev socket,fd= for UDP sockets"
we allow more than one parameter for -netdev socket. But now
we run into an assert when no parameter at all is specified

> qemu-system-x86_64 -netdev socket
socket.c:729: net_init_socket: Assertion `sock->has_udp' failed.

Fix this by reverting the change of the if condition done in 0f8c289ad.

Cc: Jason Wang <jasowang@redhat.com>
Fixes: 0f8c289ad539feb5135c545bea947b310a893f4b
Reported-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Signed-off-by: Jens Freimann <jfreimann@redhat.com>

---
v2->v3:
- go back to the original check != 1. No need for more than one
  argument, putting sock->has_fd back into the calculation is enough

v1->v2:
- add check to prevent listen= and connect= being used at the same time

 net/socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index e6b471c63d..83a2a31025 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -695,8 +695,8 @@ int net_init_socket(const Netdev *netdev, const char *name,
     assert(netdev->type == NET_CLIENT_DRIVER_SOCKET);
     sock = &netdev->u.socket;
 
-    if (sock->has_listen + sock->has_connect + sock->has_mcast +
-        sock->has_udp > 1) {
+    if (sock->has_fd + sock->has_listen + sock->has_connect + sock->has_mcast +
+        sock->has_udp != 1) {
         error_setg(errp, "exactly one of listen=, connect=, mcast= or udp="
                    " is required");
         return -1;
-- 
2.13.5
