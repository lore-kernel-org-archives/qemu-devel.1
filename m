Received: from eggs.gnu.org ([2001:4830:134:3::10]:36947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gDLNz-00034e-16
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 23:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gDLNx-0003K1-Qh
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 23:23:38 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 19 Oct 2018 11:22:23 +0800
Message-Id: <1539919345-10703-25-git-send-email-jasowang@redhat.com>
In-Reply-To: <1539919345-10703-1-git-send-email-jasowang@redhat.com>
References: <1539919345-10703-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL V2 24/26] net: ignore packet size greater than
 INT_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-stable@nongnu.org

There should not be a reason for passing a packet size greater than
INT_MAX. It's usually a hint of bug somewhere, so ignore packet size
greater than INT_MAX in qemu_deliver_packet_iov()

CC: qemu-stable@nongnu.org
Reported-by: Daniel Shapira <daniel@twistlock.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/net.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/net.c b/net/net.c
index c66847e..07c194a 100644
--- a/net/net.c
+++ b/net/net.c
@@ -712,10 +712,15 @@ ssize_t qemu_deliver_packet_iov(NetClientState *sender,
                                 void *opaque)
 {
     NetClientState *nc = opaque;
+    size_t size = iov_size(iov, iovcnt);
     int ret;
 
+    if (size > INT_MAX) {
+        return size;
+    }
+
     if (nc->link_down) {
-        return iov_size(iov, iovcnt);
+        return size;
     }
 
     if (nc->receive_disabled) {
-- 
2.5.0
