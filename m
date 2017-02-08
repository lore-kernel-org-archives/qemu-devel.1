Received: from eggs.gnu.org ([2001:4830:134:3::10]:60859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cbLxb-0005bq-0R
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 01:42:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cbLxZ-0005fk-U9
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 01:42:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1cbLxZ-0005fg-OL
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 01:42:33 -0500
From: P J P <ppandit@redhat.com>
Date: Wed,  8 Feb 2017 12:12:12 +0530
Message-Id: <20170208064212.25307-4-ppandit@redhat.com>
In-Reply-To: <20170208064212.25307-1-ppandit@redhat.com>
References: <20170208064212.25307-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/3] sd: sdhci: Remove block count enable
 check in single block transfers
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

In the SDHCI protocol the 'Block count enable' bit
of the Transfer Mode register is relevant only in multi block
transfers. We need not check it in single block transfers.

Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/sd/sdhci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

Update: change commit title and log message
  -> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg01568.html

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 532ef87..95e11cd 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -569,7 +569,6 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
 }
 
 /* single block SDMA transfer */
-
 static void sdhci_sdma_transfer_single_block(SDHCIState *s)
 {
     int n;
@@ -588,10 +587,7 @@ static void sdhci_sdma_transfer_single_block(SDHCIState *s)
             sdbus_write_data(&s->sdbus, s->fifo_buffer[n]);
         }
     }
-
-    if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
-        s->blkcnt--;
-    }
+    s->blkcnt--;
 
     sdhci_end_transfer(s);
 }
-- 
2.9.3
