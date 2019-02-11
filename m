Received: from eggs.gnu.org ([209.51.188.92]:37307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gt05l-0005ie-5M
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 20:09:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gt05i-0008Np-G5
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 20:08:59 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:44318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gt05i-0008Em-2E
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 20:08:58 -0500
Received: by mail-pl1-x62a.google.com with SMTP id p4so4492102plq.11
	for <qemu-devel@nongnu.org>; Sun, 10 Feb 2019 17:08:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 10 Feb 2019 17:08:16 -0800
Message-Id: <20190211010829.29869-14-richard.henderson@linaro.org>
In-Reply-To: <20190211010829.29869-1-richard.henderson@linaro.org>
References: <20190211010829.29869-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 13/26] target/arm: Implement the SUBP
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Fix extraction length.
---
 target/arm/translate-a64.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 2e0d797294..3e46ee6f69 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5132,19 +5132,39 @@ static void handle_crc32(DisasContext *s,
  */
 static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
 {
-    unsigned int sf, rm, opcode, rn, rd;
+    unsigned int sf, rm, opcode, rn, rd, setflag;
     sf = extract32(insn, 31, 1);
+    setflag = extract32(insn, 29, 1);
     rm = extract32(insn, 16, 5);
     opcode = extract32(insn, 10, 6);
     rn = extract32(insn, 5, 5);
     rd = extract32(insn, 0, 5);
 
-    if (extract32(insn, 29, 1)) {
+    if (setflag && opcode != 0) {
         unallocated_encoding(s);
         return;
     }
 
     switch (opcode) {
+    case 0: /* SUBP(S) */
+        if (sf == 0 || !dc_isar_feature(aa64_mte_insn_reg, s)) {
+            goto do_unallocated;
+        } else {
+            TCGv_i64 tcg_n, tcg_m, tcg_d;
+
+            tcg_n = read_cpu_reg_sp(s, rn, true);
+            tcg_m = read_cpu_reg_sp(s, rm, true);
+            tcg_gen_sextract_i64(tcg_n, tcg_n, 0, 56);
+            tcg_gen_sextract_i64(tcg_m, tcg_m, 0, 56);
+            tcg_d = cpu_reg(s, rd);
+
+            if (setflag) {
+                gen_sub_CC(true, tcg_d, tcg_n, tcg_m);
+            } else {
+                tcg_gen_sub_i64(tcg_d, tcg_n, tcg_m);
+            }
+        }
+        break;
     case 2: /* UDIV */
         handle_div(s, false, sf, rm, rn, rd);
         break;
-- 
2.17.2
