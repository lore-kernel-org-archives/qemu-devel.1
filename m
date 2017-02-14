Received: from eggs.gnu.org ([2001:4830:134:3::10]:58786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cdiDR-00076n-Bk
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 13:52:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cdiDP-0008BO-Rc
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 13:52:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1cdiDP-0008BE-LA
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 13:52:39 -0500
From: P J P <ppandit@redhat.com>
Date: Wed, 15 Feb 2017 00:22:23 +0530
Message-Id: <20170214185225.7994-3-ppandit@redhat.com>
In-Reply-To: <20170214185225.7994-1-ppandit@redhat.com>
References: <20170214185225.7994-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH v4 2/4] sd: sdhci: check transfer mode register
 in multi block transfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair23@gmail.com>, Wjjzhang <wjjzhang@tencent.com>, Jiang Xin <jiangxin1@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

In the SDHCI protocol, the transfer mode register value
is used during multi block transfer to check if block count
register is enabled and should be updated. Transfer mode
register could be set such that, block count register would
not be updated, thus leading to an infinite loop. Add check
to avoid it.

Reported-by: Wjjzhang <wjjzhang@tencent.com>
Reported-by: Jiang Xin <jiangxin1@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/sd/sdhci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index cf647fa..f8220c0 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -487,6 +487,11 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
     uint32_t boundary_chk = 1 << (((s->blksize & 0xf000) >> 12) + 12);
     uint32_t boundary_count = boundary_chk - (s->sdmasysad % boundary_chk);
 
+    if (!(s->trnmod & SDHC_TRNS_BLK_CNT_EN) || !s->blkcnt) {
+        qemu_log_mask(LOG_UNIMP, "infinite transfer is not supported\n");
+        return;
+    }
+
     /* XXX: Some sd/mmc drivers (for example, u-boot-slp) do not account for
      * possible stop at page boundary if initial address is not page aligned,
      * allow them to work properly */
@@ -798,11 +803,6 @@ static void sdhci_data_transfer(void *opaque)
     if (s->trnmod & SDHC_TRNS_DMA) {
         switch (SDHC_DMA_TYPE(s->hostctl)) {
         case SDHC_CTRL_SDMA:
-            if ((s->trnmod & SDHC_TRNS_MULTI) &&
-                    (!(s->trnmod & SDHC_TRNS_BLK_CNT_EN) || s->blkcnt == 0)) {
-                break;
-            }
-
             if ((s->blkcnt == 1) || !(s->trnmod & SDHC_TRNS_MULTI)) {
                 sdhci_sdma_transfer_single_block(s);
             } else {
-- 
2.9.3
