Received: from eggs.gnu.org ([2001:4830:134:3::10]:41629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dSKY3-0002JV-Ar
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:55:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dSKY2-0000gu-In
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:55:11 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:33153)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dSKY2-0000g9-BJ
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:55:10 -0400
Received: by mail-lf0-x243.google.com with SMTP id t72so17251327lff.0
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 02:55:10 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue,  4 Jul 2017 11:54:45 +0200
Message-Id: <1499162088-1562-15-git-send-email-edgar.iglesias@gmail.com>
In-Reply-To: <1499162088-1562-1-git-send-email-edgar.iglesias@gmail.com>
References: <1499162088-1562-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 14/17] target-microblaze: dec_barrel: Add
 BSEFI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistai@xilinx.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add support for BSEFI.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 6ee4885..3fad13c 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -660,7 +660,8 @@ static void dec_div(DisasContext *dc)
 static void dec_barrel(DisasContext *dc)
 {
     TCGv t0;
-    bool s, t;
+    unsigned int imm_w, imm_s;
+    bool s, t, e = false;
 
     if ((dc->tb_flags & MSR_EE_FLAG)
           && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)
@@ -670,27 +671,44 @@ static void dec_barrel(DisasContext *dc)
         return;
     }
 
+    if (dc->type_b) {
+        /* Insert and extract are only available in immediate mode.  */
+        e = extract32(dc->imm, 14, 1);
+    }
     s = extract32(dc->imm, 10, 1);
     t = extract32(dc->imm, 9, 1);
+    imm_w = extract32(dc->imm, 6, 5);
+    imm_s = extract32(dc->imm, 0, 5);
 
-    LOG_DIS("bs%s%s r%d r%d r%d\n",
+    LOG_DIS("bs%s%s%s r%d r%d r%d\n",
+            e ? "e" : "",
             s ? "l" : "r", t ? "a" : "l", dc->rd, dc->ra, dc->rb);
 
-    t0 = tcg_temp_new();
+    if (e) {
+        if (imm_w + imm_s > 32 || imm_w == 0) {
+            /* These inputs have an undefined behavior.  */
+            qemu_log_mask(LOG_GUEST_ERROR, "bsefi: Bad input w=%d s=%d\n",
+                          imm_w, imm_s);
+        } else {
+            tcg_gen_extract_i32(cpu_R[dc->rd], cpu_R[dc->ra], imm_s, imm_w);
+        }
+    } else {
+        t0 = tcg_temp_new();
 
-    tcg_gen_mov_tl(t0, *(dec_alu_op_b(dc)));
-    tcg_gen_andi_tl(t0, t0, 31);
+        tcg_gen_mov_tl(t0, *(dec_alu_op_b(dc)));
+        tcg_gen_andi_tl(t0, t0, 31);
 
-    if (s) {
-        tcg_gen_shl_tl(cpu_R[dc->rd], cpu_R[dc->ra], t0);
-    } else {
-        if (t) {
-            tcg_gen_sar_tl(cpu_R[dc->rd], cpu_R[dc->ra], t0);
+        if (s) {
+            tcg_gen_shl_tl(cpu_R[dc->rd], cpu_R[dc->ra], t0);
         } else {
-            tcg_gen_shr_tl(cpu_R[dc->rd], cpu_R[dc->ra], t0);
+            if (t) {
+                tcg_gen_sar_tl(cpu_R[dc->rd], cpu_R[dc->ra], t0);
+            } else {
+                tcg_gen_shr_tl(cpu_R[dc->rd], cpu_R[dc->ra], t0);
+            }
         }
+        tcg_temp_free(t0);
     }
-    tcg_temp_free(t0);
 }
 
 static void dec_bit(DisasContext *dc)
-- 
2.7.4
