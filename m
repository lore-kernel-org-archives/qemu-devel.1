Received: from eggs.gnu.org ([2001:4830:134:3::10]:45722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gByXI-0004a8-FB
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gByXH-0004U8-Pd
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:36 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Oct 2018 16:46:21 +0800
Message-Id: <1539593186-32183-22-git-send-email-jasowang@redhat.com>
In-Reply-To: <1539593186-32183-1-git-send-email-jasowang@redhat.com>
References: <1539593186-32183-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 21/26] ne2000: fix possible out of bound access
 in ne2000_receive
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

In ne2000_receive(), we try to assign size_ to size which converts
from size_t to integer. This will cause troubles when size_ is greater
INT_MAX, this will lead a negative value in size and it can then pass
the check of size < MIN_BUF_SIZE which may lead out of bound access of
for both buf and buf1.

Fixing by converting the type of size to size_t.

CC: qemu-stable@nongnu.org
Reported-by: Daniel Shapira <daniel@twistlock.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/ne2000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/ne2000.c b/hw/net/ne2000.c
index 07d79e3..869518e 100644
--- a/hw/net/ne2000.c
+++ b/hw/net/ne2000.c
@@ -174,7 +174,7 @@ static int ne2000_buffer_full(NE2000State *s)
 ssize_t ne2000_receive(NetClientState *nc, const uint8_t *buf, size_t size_)
 {
     NE2000State *s = qemu_get_nic_opaque(nc);
-    int size = size_;
+    size_t size = size_;
     uint8_t *p;
     unsigned int total_len, next, avail, len, index, mcast_idx;
     uint8_t buf1[60];
@@ -182,7 +182,7 @@ ssize_t ne2000_receive(NetClientState *nc, const uint8_t *buf, size_t size_)
         { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
 
 #if defined(DEBUG_NE2000)
-    printf("NE2000: received len=%d\n", size);
+    printf("NE2000: received len=%zu\n", size);
 #endif
 
     if (s->cmd & E8390_STOP || ne2000_buffer_full(s))
-- 
2.5.0
