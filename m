Received: from eggs.gnu.org ([2001:4830:134:3::10]:42986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKZ-0003nN-Av
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKY-0005J0-BC
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:19 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:23 -0500
Message-Id: <20180723201748.25573-75-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 74/99] target/arm: Clear SVE high bits for FMOV
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

Use write_fp_dreg and clear_vec_high to zero the bits
that need zeroing for these cases.

Cc: qemu-stable@nongnu.org
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180502221552.3873-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 9a9f1f59521f46e8ff4527d9a2b52f83577e2aa3)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/arm/translate-a64.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 3c4c9b9fdc..639cd95772 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5438,31 +5438,24 @@ static void handle_fmov(DisasContext *s, int rd, int rn, int type, bool itof)
 
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
2.17.1
