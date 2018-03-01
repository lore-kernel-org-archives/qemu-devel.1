Received: from eggs.gnu.org ([2001:4830:134:3::10]:33797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJv-0003is-9z
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJu-00087T-6w
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:19 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1erMJt-00082m-U8
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:18 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJh-0000XZ-Us
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:24:05 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Mar 2018 11:23:23 +0000
Message-Id: <20180301112403.12487-3-peter.maydell@linaro.org>
In-Reply-To: <20180301112403.12487-1-peter.maydell@linaro.org>
References: <20180301112403.12487-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 02/42] xilinx_spips: Enable only two slaves when
 reading/writing with stripe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Francisco Iglesias <frasse.iglesias@gmail.com>

Assert only the lower cs on bus 0 and upper cs on bus 1 when both buses and
chip selects are enabled (e.g reading/writing with stripe).

Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Tested-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 20180223232233.31482-2-frasse.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/xilinx_spips.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 8af36ca3d4..0cb484ecf4 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -223,7 +223,7 @@ static void xilinx_spips_update_cs(XilinxSPIPS *s, int field)
 {
     int i;
 
-    for (i = 0; i < s->num_cs; i++) {
+    for (i = 0; i < s->num_cs * s->num_busses; i++) {
         bool old_state = s->cs_lines_state[i];
         bool new_state = field & (1 << i);
 
@@ -234,7 +234,7 @@ static void xilinx_spips_update_cs(XilinxSPIPS *s, int field)
         }
         qemu_set_irq(s->cs_lines[i], !new_state);
     }
-    if (!(field & ((1 << s->num_cs) - 1))) {
+    if (!(field & ((1 << (s->num_cs * s->num_busses)) - 1))) {
         s->snoop_state = SNOOP_CHECKING;
         s->cmd_dummies = 0;
         s->link_state = 1;
@@ -248,7 +248,40 @@ static void xlnx_zynqmp_qspips_update_cs_lines(XlnxZynqMPQSPIPS *s)
 {
     if (s->regs[R_GQSPI_GF_SNAPSHOT]) {
         int field = ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, CHIP_SELECT);
-        xilinx_spips_update_cs(XILINX_SPIPS(s), field);
+        bool upper_cs_sel = field & (1 << 1);
+        bool lower_cs_sel = field & 1;
+        bool bus0_enabled;
+        bool bus1_enabled;
+        uint8_t buses;
+        int cs = 0;
+
+        buses = ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, DATA_BUS_SELECT);
+        bus0_enabled = buses & 1;
+        bus1_enabled = buses & (1 << 1);
+
+        if (bus0_enabled && bus1_enabled) {
+            if (lower_cs_sel) {
+                cs |= 1;
+            }
+            if (upper_cs_sel) {
+                cs |= 1 << 3;
+            }
+        } else if (bus0_enabled) {
+            if (lower_cs_sel) {
+                cs |= 1;
+            }
+            if (upper_cs_sel) {
+                cs |= 1 << 1;
+            }
+        } else if (bus1_enabled) {
+            if (lower_cs_sel) {
+                cs |= 1 << 2;
+            }
+            if (upper_cs_sel) {
+                cs |= 1 << 3;
+            }
+        }
+        xilinx_spips_update_cs(XILINX_SPIPS(s), cs);
     }
 }
 
@@ -260,7 +293,7 @@ static void xilinx_spips_update_cs_lines(XilinxSPIPS *s)
     if (num_effective_busses(s) == 2) {
         /* Single bit chip-select for qspi */
         field &= 0x1;
-        field |= field << 1;
+        field |= field << 3;
     /* Dual stack U-Page */
     } else if (s->regs[R_LQSPI_CFG] & LQSPI_CFG_TWO_MEM &&
                s->regs[R_LQSPI_STS] & LQSPI_CFG_U_PAGE) {
-- 
2.16.2
