Received: from eggs.gnu.org ([2001:4830:134:3::10]:45758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gByXL-0004d4-FB
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gByXK-0004ZB-CZ
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:39 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Oct 2018 16:46:23 +0800
Message-Id: <1539593186-32183-24-git-send-email-jasowang@redhat.com>
In-Reply-To: <1539593186-32183-1-git-send-email-jasowang@redhat.com>
References: <1539593186-32183-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 23/26] pcnet: fix possible buffer overflow
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

In pcnet_receive(), we try to assign size_ to size which converts from
size_t to integer. This will cause troubles when size_ is greater
INT_MAX, this will lead a negative value in size and it can then pass
the check of size < MIN_BUF_SIZE which may lead out of bound access
for both buf and buf1.

Fixing by converting the type of size to size_t.

CC: qemu-stable@nongnu.org
Reported-by: Daniel Shapira <daniel@twistlock.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/pcnet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
index 0c44554..d9ba04b 100644
--- a/hw/net/pcnet.c
+++ b/hw/net/pcnet.c
@@ -988,14 +988,14 @@ ssize_t pcnet_receive(NetClientState *nc, const uint8_t *buf, size_t size_)
     uint8_t buf1[60];
     int remaining;
     int crc_err = 0;
-    int size = size_;
+    size_t size = size_;
 
     if (CSR_DRX(s) || CSR_STOP(s) || CSR_SPND(s) || !size ||
         (CSR_LOOP(s) && !s->looptest)) {
         return -1;
     }
 #ifdef PCNET_DEBUG
-    printf("pcnet_receive size=%d\n", size);
+    printf("pcnet_receive size=%zu\n", size);
 #endif
 
     /* if too small buffer, then expand it */
-- 
2.5.0
