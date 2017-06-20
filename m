Received: from eggs.gnu.org ([2001:4830:134:3::10]:44776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dNLiM-0002zT-Ti
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dNLiM-0003ch-3f
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:09:14 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:34749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dNLiL-0003cP-TH
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:09:14 -0400
Received: by mail-lf0-x244.google.com with SMTP id l200so4068097lfg.1
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 09:09:13 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 20 Jun 2017 18:09:02 +0200
Message-Id: <1497974944-27050-6-git-send-email-edgar.iglesias@gmail.com>
In-Reply-To: <1497974944-27050-1-git-send-email-edgar.iglesias@gmail.com>
References: <1497974944-27050-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 5/7] target-microblaze: dec_barrel: Add BSEFI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, alistai@xilinx.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add support for BSEFI.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 6ee4885..4a8ab22 100644
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
@@ -670,27 +671,38 @@ static void dec_barrel(DisasContext *dc)
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
+        tcg_gen_extract_i32(cpu_R[dc->rd], cpu_R[dc->ra], imm_s, imm_w);
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
