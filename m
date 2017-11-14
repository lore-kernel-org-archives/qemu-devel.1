Received: from eggs.gnu.org ([2001:4830:134:3::10]:57855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eEQi4-0005W2-6i
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 21:12:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eEQi1-00011m-1L
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 21:12:20 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Nov 2017 10:11:38 +0800
Message-Id: <1510625498-4821-9-git-send-email-jasowang@redhat.com>
In-Reply-To: <1510625498-4821-1-git-send-email-jasowang@redhat.com>
References: <1510625498-4821-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 8/8] net/socket: fix coverity issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Jens Freimann <jfreimann@redhat.com>, qemu-stable@nongnu.org, Jason Wang <jasowang@redhat.com>

From: Jens Freimann <jfreimann@redhat.com>

This fixes coverity issue CID1005339.

Make sure that saddr is not used uninitialized if the
mcast parameter is NULL.

Cc: qemu-stable@nongnu.org
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jens Freimann <jfreimann@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/socket.c b/net/socket.c
index 83a2a31..6917fbc 100644
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
2.7.4
