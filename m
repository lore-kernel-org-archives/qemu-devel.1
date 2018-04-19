Received: from eggs.gnu.org ([2001:4830:134:3::10]:59746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <saipava@xhdsaipava40.localdomain>)
	id 1f932l-0004hn-Rr
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 02:27:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <saipava@xhdsaipava40.localdomain>)
	id 1f932g-00044U-U3
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 02:27:43 -0400
Received: from mail-by2nam01on0072.outbound.protection.outlook.com
	([104.47.34.72]:51478
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <saipava@xhdsaipava40.localdomain>)
	id 1f932g-00042t-Gd
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 02:27:38 -0400
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Date: Thu, 19 Apr 2018 11:57:23 +0530
Message-ID: <1524119244-1240-1-git-send-email-saipava@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3] xilinx_spips: Correct SNOOP_NONE state when
 flushing the txfifo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alistair@alistair23.me, crosthwaite.peter@gmail.com, peter.maydell@linaro.org, edgar.iglesias@gmail.com, frasse.iglesias@gmail.com
Cc: qemu-devel@nongnu.org, saipava@xilinx.com

SNOOP_NONE state handle is moved above in the if ladder, as it's same
as SNOOP_STRIPPING during data cycles.

Signed-off-by: Sai Pavan Boddu <saipava@xilinx.com>
---
Changes for V2:
	Fixed commit message
	Reordered to code, to avoid code duplication.
Changes for V3:
	Dropped the cover letter, as its a minor fix now
	Fixed commit message by explaining only what's fixed
	removed the dummy_byte decrement changes

 hw/ssi/xilinx_spips.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 426f971..03f5fae 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -616,7 +616,8 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
         if (fifo8_is_empty(&s->tx_fifo)) {
             xilinx_spips_update_ixr(s);
             return;
-        } else if (s->snoop_state == SNOOP_STRIPING) {
+        } else if (s->snoop_state == SNOOP_STRIPING ||
+                   s->snoop_state == SNOOP_NONE) {
             for (i = 0; i < num_effective_busses(s); ++i) {
                 tx_rx[i] = fifo8_pop(&s->tx_fifo);
             }
-- 
2.7.4
