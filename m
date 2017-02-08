Received: from eggs.gnu.org ([2001:4830:134:3::10]:60847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cbLxW-0005aC-Rt
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 01:42:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cbLxV-0005fL-Pa
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 01:42:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1cbLxV-0005fE-KI
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 01:42:29 -0500
From: P J P <ppandit@redhat.com>
Date: Wed,  8 Feb 2017 12:12:11 +0530
Message-Id: <20170208064212.25307-3-ppandit@redhat.com>
In-Reply-To: <20170208064212.25307-1-ppandit@redhat.com>
References: <20170208064212.25307-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/3] sd: sdhci: conditionally invoke multi
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
Cc: Alistair Francis <alistair23@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Wjjzhang <wjjzhang@tencent.com>, Jiang Xin <jiangxin1@huawei.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

In sdhci_write invoke multi block transfer if it is enabled
in the transfer mode register 's->trnmod'.

Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/sd/sdhci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index cf400c8..532ef87 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1022,7 +1022,11 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         /* Writing to last byte of sdmasysad might trigger transfer */
         if (!(mask & 0xFF000000) && TRANSFERRING_DATA(s->prnsts) && s->blkcnt &&
                 s->blksize && SDHC_DMA_TYPE(s->hostctl) == SDHC_CTRL_SDMA) {
-            sdhci_sdma_transfer_multi_blocks(s);
+            if (!(s->trnmod & SDHC_TRNS_MULTI)) {
+                sdhci_sdma_transfer_single_block(s);
+            } else {
+                sdhci_sdma_transfer_multi_blocks(s);
+            }
         }
         break;
     case SDHC_BLKSIZE:
-- 
2.9.3
