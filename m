Received: from eggs.gnu.org ([2001:4830:134:3::10]:54591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1eBi2E-0000uR-J4
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1eBi2A-0006fO-Kd
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:05:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1eBi2A-0006ep-F7
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:05:50 -0500
From: Jens Freimann <jfreimann@redhat.com>
Date: Mon,  6 Nov 2017 15:05:46 +0100
Message-Id: <20171106140546.24643-1-jfreimann@redhat.com>
Subject: [Qemu-devel] [PATCH v2] net/socket: fix coverity issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jasowang@redhat.com

This fixes coverity issue CID1005339.

Make sure that saddr is not used uninitialized if the
mcast parameter is NULL.

Cc: qemu-stable@nongnu.org
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jens Freimann <jfreimann@redhat.com>
---
 net/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/socket.c b/net/socket.c
index e6b471c63d..09c9b2a5d1 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -373,7 +373,7 @@ static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
     net_socket_read_poll(s, true);
 
     /* mcast: save bound address as dst */
-    if (is_connected) {
+    if (is_connected && mcast != NULL) {
         s->dgram_dst = saddr;
         snprintf(nc->info_str, sizeof(nc->info_str),
                  "socket: fd=%d (cloned mcast=%s:%d)",
-- 
2.13.6
