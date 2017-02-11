Received: from eggs.gnu.org ([2001:4830:134:3::10]:59269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1ccZGs-0008KB-9k
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 10:07:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1ccZGr-00072U-2j
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 10:07:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1ccZGq-00072Q-Sk
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 10:07:28 -0500
From: P J P <ppandit@redhat.com>
Date: Sat, 11 Feb 2017 20:37:00 +0530
Message-Id: <20170211150701.23391-4-ppandit@redhat.com>
In-Reply-To: <20170211150701.23391-1-ppandit@redhat.com>
References: <20170211150701.23391-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/4] sd: sdhci: conditionally invoke multi
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
Cc: Alistair Francis <alistair23@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Wjjzhang <wjjzhang@tencent.com>, Jiang Xin <jiangxin1@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

In sdhci_write invoke multi block transfer if it is enabled
in the transfer mode register 's->trnmod'.

Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/sd/sdhci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Update: test if (s->trnmod & SDHC_TRNS_MULTI) is true
  -> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg02357.html

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 0307b8c..99fa0c7 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1022,7 +1022,11 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
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
