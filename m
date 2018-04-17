Received: from eggs.gnu.org ([2001:4830:134:3::10]:59603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <saipava@xhdsaipava40.localdomain>)
	id 1f8SuJ-0002vQ-J3
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <saipava@xhdsaipava40.localdomain>)
	id 1f8SuE-0004L5-O8
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:52:35 -0400
Received: from mail-by2nam01on0074.outbound.protection.outlook.com
	([104.47.34.74]:58464
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <saipava@xhdsaipava40.localdomain>)
	id 1f8SuE-0004JZ-5c
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:52:30 -0400
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Date: Tue, 17 Apr 2018 19:48:16 +0530
Message-ID: <1523974696-1965-2-git-send-email-saipava@xilinx.com>
In-Reply-To: <1523974696-1965-1-git-send-email-saipava@xilinx.com>
References: <1523974696-1965-1-git-send-email-saipava@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 1/1] xilinx_spips: send dummy only if cmd
 requires it
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
xilinx_spips_num_dummies, present logic sends dummy byte when ever we
are in SNOOP_NONE state, fix it to send only if cmd requires them.

Only transmit max of 1 dummy byte(i.e 8 cycles) is a single snoop cycle.
And also convert dummy bytes to cycles (required by m25p80).

Signed-off-by: Sai Pavan Boddu <saipava@xilinx.com>
---
 hw/ssi/xilinx_spips.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 426f971..8278930 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -627,10 +627,17 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
                 tx_rx[i] = tx;
             }
         } else {
-            /* Extract a dummy byte and generate dummy cycles according to the
-             * link state */
             tx = fifo8_pop(&s->tx_fifo);
-            dummy_cycles = 8 / s->link_state;
+            if (s->cmd_dummies > 0) {
+                /* Extract a dummy byte and generate dummy cycles according to
+                 * the link state */
+                 dummy_cycles = (s->cmd_dummies ? 1 : 0) * 8 / s->link_state;
+                 s->cmd_dummies--;
+            } else {
+                for (i = 0; i < num_effective_busses(s); ++i) {
+                    tx_rx[i] = tx;
+                }
+            }
         }
 
         for (i = 0; i < num_effective_busses(s); ++i) {
-- 
2.7.4
