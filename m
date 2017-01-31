Received: from eggs.gnu.org ([2001:4830:134:3::10]:46966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cYXU6-00067G-HT
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 07:24:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cYXU5-00059F-Cn
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 07:24:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1cYXU5-00058h-7q
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 07:24:29 -0500
From: P J P <ppandit@redhat.com>
Date: Tue, 31 Jan 2017 17:54:16 +0530
Message-Id: <20170131122416.10284-3-ppandit@redhat.com>
In-Reply-To: <20170131122416.10284-1-ppandit@redhat.com>
References: <20170131122416.10284-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] sd: sdhci: block count enable not relevant
 in single block transfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Wjjzhang <wjjzhang@tencent.com>, Jiang Xin <jiangxin1@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

In SDHCI device emulation the 'Block count enable' bit
of the Transfer Mode register is only relevant in multi block
transfers. We need not check it in single block transfers.

Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/sd/sdhci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 150464f..d921423 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -570,7 +570,6 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
 }
 
 /* single block SDMA transfer */
-
 static void sdhci_sdma_transfer_single_block(SDHCIState *s)
 {
     int n;
@@ -589,10 +588,7 @@ static void sdhci_sdma_transfer_single_block(SDHCIState *s)
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
