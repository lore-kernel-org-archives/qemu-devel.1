Received: from eggs.gnu.org ([2001:4830:134:3::10]:46249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7i-0007ux-E8
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7g-0008Te-O2
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:22 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  1 Mar 2017 15:43:33 +1100
Message-Id: <20170301044405.1792-19-david@gibson.dropbear.id.au>
In-Reply-To: <20170301044405.1792-1-david@gibson.dropbear.id.au>
References: <20170301044405.1792-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 18/50] target/ppc: update ca32 in arithmetic
 substract
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

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index eba83ef..e083082 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -827,7 +827,11 @@ static inline void gen_op_arith_compute_ca32(DisasContext *ctx,
     }
 
     t0 = tcg_temp_new();
-    tcg_gen_xor_tl(t0, arg0, arg1);
+    if (sub) {
+        tcg_gen_eqv_tl(t0, arg0, arg1);
+    } else {
+        tcg_gen_xor_tl(t0, arg0, arg1);
+    }
     tcg_gen_xor_tl(t0, t0, res);
     tcg_gen_extract_tl(cpu_ca32, t0, 32, 1);
     tcg_temp_free(t0);
@@ -1378,17 +1382,22 @@ static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
             tcg_temp_free(t1);
             tcg_gen_shri_tl(cpu_ca, cpu_ca, 32);    /* extract bit 32 */
             tcg_gen_andi_tl(cpu_ca, cpu_ca, 1);
+            if (is_isa300(ctx)) {
+                tcg_gen_mov_tl(cpu_ca32, cpu_ca);
+            }
         } else if (add_ca) {
             TCGv zero, inv1 = tcg_temp_new();
             tcg_gen_not_tl(inv1, arg1);
             zero = tcg_const_tl(0);
             tcg_gen_add2_tl(t0, cpu_ca, arg2, zero, cpu_ca, zero);
             tcg_gen_add2_tl(t0, cpu_ca, t0, cpu_ca, inv1, zero);
+            gen_op_arith_compute_ca32(ctx, t0, inv1, arg2, 0);
             tcg_temp_free(zero);
             tcg_temp_free(inv1);
         } else {
             tcg_gen_setcond_tl(TCG_COND_GEU, cpu_ca, arg2, arg1);
             tcg_gen_sub_tl(t0, arg2, arg1);
+            gen_op_arith_compute_ca32(ctx, t0, arg1, arg2, 1);
         }
     } else if (add_ca) {
         /* Since we're ignoring carry-out, we can simplify the
-- 
2.9.3
