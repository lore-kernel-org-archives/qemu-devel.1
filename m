Received: from eggs.gnu.org ([2001:4830:134:3::10]:43234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKu-00047d-RU
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKt-0005Tj-NL
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:40 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:32 -0500
Message-Id: <20180723201748.25573-84-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 83/99] target/arm: Implement FCSEL for fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

From: Alex Bennée <alex.bennee@linaro.org>

These were missed out from the rest of the half-precision work.

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180512003217.9105-10-richard.henderson@linaro.org
[rth: Fix erroneous check vs type]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

(cherry picked from commit ace97feef3613194900d4eb9ffc6819b840fbaeb)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/arm/translate-a64.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 05d51ecbdc..7075f27e05 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -4660,15 +4660,34 @@ static void disas_fp_csel(DisasContext *s, uint32_t insn)
     unsigned int mos, type, rm, cond, rn, rd;
     TCGv_i64 t_true, t_false, t_zero;
     DisasCompare64 c;
+    TCGMemOp sz;
 
     mos = extract32(insn, 29, 3);
-    type = extract32(insn, 22, 2); /* 0 = single, 1 = double */
+    type = extract32(insn, 22, 2);
     rm = extract32(insn, 16, 5);
     cond = extract32(insn, 12, 4);
     rn = extract32(insn, 5, 5);
     rd = extract32(insn, 0, 5);
 
-    if (mos || type > 1) {
+    if (mos) {
+        unallocated_encoding(s);
+        return;
+    }
+
+    switch (type) {
+    case 0:
+        sz = MO_32;
+        break;
+    case 1:
+        sz = MO_64;
+        break;
+    case 3:
+        sz = MO_16;
+        if (arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+            break;
+        }
+        /* fallthru */
+    default:
         unallocated_encoding(s);
         return;
     }
@@ -4677,11 +4696,11 @@ static void disas_fp_csel(DisasContext *s, uint32_t insn)
         return;
     }
 
-    /* Zero extend sreg inputs to 64 bits now.  */
+    /* Zero extend sreg & hreg inputs to 64 bits now.  */
     t_true = tcg_temp_new_i64();
     t_false = tcg_temp_new_i64();
-    read_vec_element(s, t_true, rn, 0, type ? MO_64 : MO_32);
-    read_vec_element(s, t_false, rm, 0, type ? MO_64 : MO_32);
+    read_vec_element(s, t_true, rn, 0, sz);
+    read_vec_element(s, t_false, rm, 0, sz);
 
     a64_test_cc(&c, cond);
     t_zero = tcg_const_i64(0);
@@ -4690,7 +4709,7 @@ static void disas_fp_csel(DisasContext *s, uint32_t insn)
     tcg_temp_free_i64(t_false);
     a64_free_cc(&c);
 
-    /* Note that sregs write back zeros to the high bits,
+    /* Note that sregs & hregs write back zeros to the high bits,
        and we've already done the zero-extension.  */
     write_fp_dreg(s, rd, t_true);
     tcg_temp_free_i64(t_true);
-- 
2.17.1
