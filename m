Received: from eggs.gnu.org ([2001:4830:134:3::10]:52954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSk-0005Fo-8L
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSX-00050p-0s
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:46 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1doqSW-000503-Qa
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:32 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSV-0005eU-RS
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:26:31 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Sep 2017 13:26:06 +0100
Message-Id: <1504527967-29248-36-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
References: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 35/36] target/arm: Fix aa64 ldp register
 writeback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

For "ldp x0, x1, [x0]", if the second load is on a second page and
the second page is unmapped, the exception would be raised with x0
already modified.  This means the instruction couldn't be restarted.

Cc: qemu-arm@nongnu.org
Cc: qemu-stable@nongnu.org
Reported-by: Andrew <andrew@fubar.geek.nz>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20170825224833.4463-1-richard.henderson@linaro.org
Fixes: https://bugs.launchpad.net/qemu/+bug/1713066
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
[PMM: tweaked comment format]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 2200e25..cb44632 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -2217,29 +2217,34 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
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
+             * from the second load.
+             */
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
2.7.4
