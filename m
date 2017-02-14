Received: from eggs.gnu.org ([2001:4830:134:3::10]:58809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cdiDT-00079O-QJ
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 13:52:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cdiDT-0008DS-1a
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 13:52:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1cdiDS-0008Cu-Ru
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 13:52:42 -0500
From: P J P <ppandit@redhat.com>
Date: Wed, 15 Feb 2017 00:22:24 +0530
Message-Id: <20170214185225.7994-4-ppandit@redhat.com>
In-Reply-To: <20170214185225.7994-1-ppandit@redhat.com>
References: <20170214185225.7994-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH v4 3/4] sd: sdhci: conditionally invoke multi
 block transfer
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

In sdhci_write invoke multi block transfer if it is enabled
in the transfer mode register 's->trnmod'.

Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/sd/sdhci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index f8220c0..8ae75fe 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1023,7 +1023,11 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         /* Writing to last byte of sdmasysad might trigger transfer */
         if (!(mask & 0xFF000000) && TRANSFERRING_DATA(s->prnsts) && s->blkcnt &&
                 s->blksize && SDHC_DMA_TYPE(s->hostctl) == SDHC_CTRL_SDMA) {
-            sdhci_sdma_transfer_multi_blocks(s);
+            if (s->trnmod & SDHC_TRNS_MULTI) {
+                sdhci_sdma_transfer_multi_blocks(s);
+            } else {
+                sdhci_sdma_transfer_single_block(s);
+            }
         }
         break;
     case SDHC_BLKSIZE:
-- 
2.9.3
