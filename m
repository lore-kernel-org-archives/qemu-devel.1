Received: from eggs.gnu.org ([2001:4830:134:3::10]:44792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dNLiO-00031Z-6f
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:09:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dNLiN-0003d8-9l
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:09:16 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:35741)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dNLiN-0003cl-2E
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:09:15 -0400
Received: by mail-lf0-x241.google.com with SMTP id n136so4202070lfn.2
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 09:09:15 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 20 Jun 2017 18:09:03 +0200
Message-Id: <1497974944-27050-7-git-send-email-edgar.iglesias@gmail.com>
In-Reply-To: <1497974944-27050-1-git-send-email-edgar.iglesias@gmail.com>
References: <1497974944-27050-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 6/7] target-microblaze: dec_barrel: Add BSIFI
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

Add support for BSIFI.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 4a8ab22..743b66f 100644
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
@@ -686,6 +687,17 @@ static void dec_barrel(DisasContext *dc)
 
     if (e) {
         tcg_gen_extract_i32(cpu_R[dc->rd], cpu_R[dc->ra], imm_s, imm_w);
+    } else if (i) {
+        int width = imm_w - imm_s + 1;
+
+        if (width == 0 || imm_w <= imm_s) {
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
