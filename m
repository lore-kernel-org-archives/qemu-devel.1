Received: from eggs.gnu.org ([2001:4830:134:3::10]:43918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dlNP6-0004Wd-KN
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 18:48:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dlNP5-0001wY-Bz
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 18:48:40 -0400
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:37489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dlNP5-0001ss-4Q
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 18:48:39 -0400
Received: by mail-pg0-x230.google.com with SMTP id 83so5885490pgb.4
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 15:48:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 25 Aug 2017 15:48:33 -0700
Message-Id: <20170825224833.4463-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] target/arm: Fix aa64 ldp register writeback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-stable@nongnu.org

For "ldp x0, x1, [x0]", if the second load is on a second page and
the second page is unmapped, the exception would be raised with x0
already modified.  This means the instruction couldn't be restarted.

Cc: qemu-arm@nongnu.org
Cc: qemu-stable@nongnu.org
Reported-by: Andrew <andrew@fubar.geek.nz>
Fixes: https://bugs.launchpad.net/qemu/+bug/1713066
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index c596025b04..bfba816a77 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -2217,29 +2217,33 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
         } else {
             do_fp_st(s, rt, tcg_addr, size);
         }
-    } else {
-        TCGv_i64 tcg_rt = cpu_reg(s, rt);
-        if (is_load) {
-            do_gpr_ld(s, tcg_rt, tcg_addr, size, is_signed, false,
-                      false, 0, false, false);
-        } else {
-            do_gpr_st(s, tcg_rt, tcg_addr, size,
-                      false, 0, false, false);
-        }
-    }
-    tcg_gen_addi_i64(tcg_addr, tcg_addr, 1 << size);
-    if (is_vector) {
+        tcg_gen_addi_i64(tcg_addr, tcg_addr, 1 << size);
         if (is_load) {
             do_fp_ld(s, rt2, tcg_addr, size);
         } else {
             do_fp_st(s, rt2, tcg_addr, size);
         }
     } else {
+        TCGv_i64 tcg_rt = cpu_reg(s, rt);
         TCGv_i64 tcg_rt2 = cpu_reg(s, rt2);
+
         if (is_load) {
+            TCGv_i64 tmp = tcg_temp_new_i64();
+
+            /* Do not modify tcg_rt before recognizing any exception
+               from the second load.  */
+            do_gpr_ld(s, tmp, tcg_addr, size, is_signed, false,
+                      false, 0, false, false);
+            tcg_gen_addi_i64(tcg_addr, tcg_addr, 1 << size);
             do_gpr_ld(s, tcg_rt2, tcg_addr, size, is_signed, false,
                       false, 0, false, false);
+
+            tcg_gen_mov_i64(tcg_rt, tmp);
+            tcg_temp_free_i64(tmp);
         } else {
+            do_gpr_st(s, tcg_rt, tcg_addr, size,
+                      false, 0, false, false);
+            tcg_gen_addi_i64(tcg_addr, tcg_addr, 1 << size);
             do_gpr_st(s, tcg_rt2, tcg_addr, size,
                       false, 0, false, false);
         }
-- 
2.13.5
