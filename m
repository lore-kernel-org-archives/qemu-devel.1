Received: from eggs.gnu.org ([2001:4830:134:3::10]:57601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eEQha-0004Rz-PM
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 21:11:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eEQhZ-0000j8-Sb
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 21:11:50 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Nov 2017 10:11:31 +0800
Message-Id: <1510625498-4821-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1510625498-4821-1-git-send-email-jasowang@redhat.com>
References: <1510625498-4821-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 1/8] net: fix check for number of parameters to
 -netdev socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Jens Freimann <jfreimann@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-stable@nongnu.org

From: Jens Freimann <jfreimann@redhat.com>

Since commit 0f8c289ad "net: fix -netdev socket,fd= for UDP sockets"
we allow more than one parameter for -netdev socket. But now
we run into an assert when no parameter at all is specified

> qemu-system-x86_64 -netdev socket
socket.c:729: net_init_socket: Assertion `sock->has_udp' failed.

Fix this by reverting the change of the if condition done in 0f8c289ad.

Cc: Jason Wang <jasowang@redhat.com>
Cc: qemu-stable@nongnu.org
Fixes: 0f8c289ad539feb5135c545bea947b310a893f4b
Reported-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Signed-off-by: Jens Freimann <jfreimann@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index e6b471c..83a2a31 100644
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
2.7.4
