Received: from eggs.gnu.org ([2001:4830:134:3::10]:58676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fE02c-0000ce-72
	for qemu-devel@nongnu.org; Wed, 02 May 2018 18:16:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fE02b-0007sK-E5
	for qemu-devel@nongnu.org; Wed, 02 May 2018 18:16:02 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:44364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fE02b-0007rp-6O
	for qemu-devel@nongnu.org; Wed, 02 May 2018 18:16:01 -0400
Received: by mail-pf0-x244.google.com with SMTP id q22so12956834pff.11
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 15:16:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  2 May 2018 15:15:42 -0700
Message-Id: <20180502221552.3873-5-richard.henderson@linaro.org>
In-Reply-To: <20180502221552.3873-1-richard.henderson@linaro.org>
References: <20180502221552.3873-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 04/14] target/arm: Clear SVE high bits for
 FMOV
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-stable@nongnu.org

Use write_fp_dreg and clear_vec_high to zero the bits
that need zeroing for these cases.

Cc: qemu-stable@nongnu.org
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 7021a31b89..c64c3ed99d 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5444,31 +5444,24 @@ static void handle_fmov(DisasContext *s, int rd, int rn, int type, bool itof)
 
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
2.14.3
