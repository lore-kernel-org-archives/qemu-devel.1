Received: from eggs.gnu.org ([2001:4830:134:3::10]:47539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <saipava@xhdsaipava40.localdomain>)
	id 1f8hj3-0000xX-Lk
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 03:41:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <saipava@xhdsaipava40.localdomain>)
	id 1f8hiy-0006kE-Pf
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 03:41:57 -0400
Received: from mail-sn1nam01on0078.outbound.protection.outlook.com
	([104.47.32.78]:60371
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <saipava@xhdsaipava40.localdomain>)
	id 1f8hiy-0006io-EK
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 03:41:52 -0400
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Date: Wed, 18 Apr 2018 13:11:38 +0530
Message-ID: <1524037298-23401-2-git-send-email-saipava@xilinx.com>
In-Reply-To: <1524037298-23401-1-git-send-email-saipava@xilinx.com>
References: <1524037298-23401-1-git-send-email-saipava@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 1/1] xilinx_spips: send dummy cycles only if
 cmd requires it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alistair@alistair23.me, crosthwaite.peter@gmail.com, peter.maydell@linaro.org, edgar.iglesias@gmail.com, frasse.iglesias@gmail.com
Cc: qemu-devel@nongnu.org

For all the commands, which do not have an entry in
xilinx_spips_num_dummies, present logic sends dummy cycles when ever we
are in SNOOP_NONE state, fix it to only send dummy cycles if the cmd
requires them.

SNOOP_NONE state handle is moved above (previously its part of default else
case), as its same as SNOOP_STRIPPING during data cycles.

Signed-off-by: Sai Pavan Boddu <saipava@xilinx.com>
---
TODO: Maybe we could delete the SNOOP_NONE state as it seems to be
same as SNOOP_STRIPPING

 hw/ssi/xilinx_spips.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 426f971..4f6760d 100644
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
@@ -626,11 +627,12 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
             for (i = 0; i < num_effective_busses(s); ++i) {
                 tx_rx[i] = tx;
             }
-        } else {
+        } else if (s->cmd_dummies > 0) {
             /* Extract a dummy byte and generate dummy cycles according to the
              * link state */
             tx = fifo8_pop(&s->tx_fifo);
             dummy_cycles = 8 / s->link_state;
+            s->cmd_dummies--;
         }
 
         for (i = 0; i < num_effective_busses(s); ++i) {
-- 
2.7.4
