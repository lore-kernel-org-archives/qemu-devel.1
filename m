Received: from eggs.gnu.org ([2001:4830:134:3::10]:59592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vq-00011j-Ti
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vp-00056s-SC
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:30 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cX8Vp-000541-Lv
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:29 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vo-0003Sq-R5
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 15:32:28 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 15:32:17 +0000
Message-Id: <1485531137-2362-23-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1485531137-2362-1-git-send-email-peter.maydell@linaro.org>
References: <1485531137-2362-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 22/22] dma: omap: check dma channel data_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Prasad J Pandit <pjp@fedoraproject.org>

When setting dma channel 'data_type', if (value & 3) == 3,
the set 'data_type' is said to be bad. This also leads to an
OOB access in 'omap_dma_transfer_generic', while doing
cpu_physical_memory_r/w operations. Add check to avoid it.

Reported-by: Jiang Xin <jiangxin1@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Message-id: 20170127120528.30959-1-ppandit@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/omap_dma.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index f6f86f9..45dfe7a 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -878,15 +878,17 @@ static int omap_dma_ch_reg_write(struct omap_dma_s *s,
         ch->burst[0] = (value & 0x0180) >> 7;
         ch->pack[0] = (value & 0x0040) >> 6;
         ch->port[0] = (enum omap_dma_port) ((value & 0x003c) >> 2);
-        ch->data_type = 1 << (value & 3);
         if (ch->port[0] >= __omap_dma_port_last)
             printf("%s: invalid DMA port %i\n", __FUNCTION__,
                             ch->port[0]);
         if (ch->port[1] >= __omap_dma_port_last)
             printf("%s: invalid DMA port %i\n", __FUNCTION__,
                             ch->port[1]);
-        if ((value & 3) == 3)
+        ch->data_type = 1 << (value & 3);
+        if ((value & 3) == 3) {
             printf("%s: bad data_type for DMA channel\n", __FUNCTION__);
+            ch->data_type >>= 1;
+        }
         break;
 
     case 0x02:	/* SYS_DMA_CCR_CH0 */
@@ -1988,8 +1990,10 @@ static void omap_dma4_write(void *opaque, hwaddr addr,
             fprintf(stderr, "%s: bad MReqAddressTranslate sideband signal\n",
                             __FUNCTION__);
         ch->data_type = 1 << (value & 3);
-        if ((value & 3) == 3)
+        if ((value & 3) == 3) {
             printf("%s: bad data_type for DMA channel\n", __FUNCTION__);
+            ch->data_type >>= 1;
+        }
         break;
 
     case 0x14:	/* DMA4_CEN */
-- 
2.7.4
