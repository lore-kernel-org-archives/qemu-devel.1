Received: from eggs.gnu.org ([2001:4830:134:3::10]:46712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7u-0008Al-51
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7r-0000CY-7Z
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:34 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  1 Mar 2017 15:43:37 +1100
Message-Id: <20170301044405.1792-23-david@gibson.dropbear.id.au>
In-Reply-To: <20170301044405.1792-1-david@gibson.dropbear.id.au>
References: <20170301044405.1792-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 22/50] target/ppc: add ov32 flag in divide
 operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, thuth@redhat.com, lvivier@redhat.com, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Add helper_div_compute_ov() in the int_helper for updating the overflow
flags.

For Divide Word:
SO, OV, and OV32 bits reflects overflow of the 32-bit result

For Divide DoubleWord:
SO, OV, and OV32 bits reflects overflow of the 64-bit result

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index ccf3bff..982e66f 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1021,6 +1021,9 @@ static inline void gen_op_arith_divw(DisasContext *ctx, TCGv ret, TCGv arg1,
     }
     if (compute_ov) {
         tcg_gen_extu_i32_tl(cpu_ov, t2);
+        if (is_isa300(ctx)) {
+            tcg_gen_extu_i32_tl(cpu_ov32, t2);
+        }
         tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
     }
     tcg_temp_free_i32(t0);
@@ -1092,6 +1095,9 @@ static inline void gen_op_arith_divd(DisasContext *ctx, TCGv ret, TCGv arg1,
     }
     if (compute_ov) {
         tcg_gen_mov_tl(cpu_ov, t2);
+        if (is_isa300(ctx)) {
+            tcg_gen_mov_tl(cpu_ov32, t2);
+        }
         tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
     }
     tcg_temp_free_i64(t0);
@@ -1110,10 +1116,10 @@ static void glue(gen_, name)(DisasContext *ctx)
                       cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)],     \
                       sign, compute_ov);                                      \
 }
-/* divwu  divwu.  divwuo  divwuo.   */
+/* divdu  divdu.  divduo  divduo.   */
 GEN_INT_ARITH_DIVD(divdu, 0x0E, 0, 0);
 GEN_INT_ARITH_DIVD(divduo, 0x1E, 0, 1);
-/* divw  divw.  divwo  divwo.   */
+/* divd  divd.  divdo  divdo.   */
 GEN_INT_ARITH_DIVD(divd, 0x0F, 1, 0);
 GEN_INT_ARITH_DIVD(divdo, 0x1F, 1, 1);
 
-- 
2.9.3
