Received: from eggs.gnu.org ([2001:4830:134:3::10]:48672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpdL-0005CA-4Y
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpdK-0000z0-7J
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:39 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fGpdK-0000y5-0X
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:38 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpdJ-0003cT-1i
	for qemu-devel@nongnu.org; Thu, 10 May 2018 18:45:37 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 May 2018 18:45:19 +0100
Message-Id: <20180510174519.11264-22-peter.maydell@linaro.org>
In-Reply-To: <20180510174519.11264-1-peter.maydell@linaro.org>
References: <20180510174519.11264-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 21/21] target/arm: Clear SVE high bits for FMOV
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

Use write_fp_dreg and clear_vec_high to zero the bits
that need zeroing for these cases.

Cc: qemu-stable@nongnu.org
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180502221552.3873-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index b302171545..b0471c842e 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5681,31 +5681,24 @@ static void handle_fmov(DisasContext *s, int rd, int rn, int type, bool itof)
 
     if (itof) {
         TCGv_i64 tcg_rn = cpu_reg(s, rn);
+        TCGv_i64 tmp;
 
         switch (type) {
         case 0:
-        {
             /* 32 bit */
-            TCGv_i64 tmp = tcg_temp_new_i64();
+            tmp = tcg_temp_new_i64();
             tcg_gen_ext32u_i64(tmp, tcg_rn);
-            tcg_gen_st_i64(tmp, cpu_env, fp_reg_offset(s, rd, MO_64));
-            tcg_gen_movi_i64(tmp, 0);
-            tcg_gen_st_i64(tmp, cpu_env, fp_reg_hi_offset(s, rd));
+            write_fp_dreg(s, rd, tmp);
             tcg_temp_free_i64(tmp);
             break;
-        }
         case 1:
-        {
             /* 64 bit */
-            TCGv_i64 tmp = tcg_const_i64(0);
-            tcg_gen_st_i64(tcg_rn, cpu_env, fp_reg_offset(s, rd, MO_64));
-            tcg_gen_st_i64(tmp, cpu_env, fp_reg_hi_offset(s, rd));
-            tcg_temp_free_i64(tmp);
+            write_fp_dreg(s, rd, tcg_rn);
             break;
-        }
         case 2:
             /* 64 bit to top half. */
             tcg_gen_st_i64(tcg_rn, cpu_env, fp_reg_hi_offset(s, rd));
+            clear_vec_high(s, true, rd);
             break;
         }
     } else {
-- 
2.17.0
