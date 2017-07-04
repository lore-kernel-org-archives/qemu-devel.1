Received: from eggs.gnu.org ([2001:4830:134:3::10]:41650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dSKY6-0002O4-IA
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:55:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dSKY3-0000hr-ST
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:55:14 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:35796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dSKY3-0000hF-KM
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:55:11 -0400
Received: by mail-lf0-x242.google.com with SMTP id z78so4905132lff.2
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 02:55:11 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue,  4 Jul 2017 11:54:46 +0200
Message-Id: <1499162088-1562-16-git-send-email-edgar.iglesias@gmail.com>
In-Reply-To: <1499162088-1562-1-git-send-email-edgar.iglesias@gmail.com>
References: <1499162088-1562-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 15/17] target-microblaze: dec_barrel: Add
 BSIFI
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

Add support for BSIFI.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 3fad13c..cb65d1e 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -661,7 +661,7 @@ static void dec_barrel(DisasContext *dc)
 {
     TCGv t0;
     unsigned int imm_w, imm_s;
-    bool s, t, e = false;
+    bool s, t, e = false, i = false;
 
     if ((dc->tb_flags & MSR_EE_FLAG)
           && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)
@@ -673,6 +673,7 @@ static void dec_barrel(DisasContext *dc)
 
     if (dc->type_b) {
         /* Insert and extract are only available in immediate mode.  */
+        i = extract32(dc->imm, 15, 1);
         e = extract32(dc->imm, 14, 1);
     }
     s = extract32(dc->imm, 10, 1);
@@ -692,6 +693,17 @@ static void dec_barrel(DisasContext *dc)
         } else {
             tcg_gen_extract_i32(cpu_R[dc->rd], cpu_R[dc->ra], imm_s, imm_w);
         }
+    } else if (i) {
+        int width = imm_w - imm_s + 1;
+
+        if (imm_w < imm_s) {
+            /* These inputs have an undefined behavior.  */
+            qemu_log_mask(LOG_GUEST_ERROR, "bsifi: Bad input w=%d s=%d\n",
+                          imm_w, imm_s);
+        } else {
+            tcg_gen_deposit_i32(cpu_R[dc->rd], cpu_R[dc->rd], cpu_R[dc->ra],
+                                imm_s, width);
+        }
     } else {
         t0 = tcg_temp_new();
 
-- 
2.7.4
