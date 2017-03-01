Received: from eggs.gnu.org ([2001:4830:134:3::10]:46324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7j-0007wc-W1
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7i-0008VA-Gq
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:23 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  1 Mar 2017 15:43:32 +1100
Message-Id: <20170301044405.1792-18-david@gibson.dropbear.id.au>
In-Reply-To: <20170301044405.1792-1-david@gibson.dropbear.id.au>
References: <20170301044405.1792-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 17/50] target/ppc: update ca32 in arithmetic add
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

Adds routine to compute ca32 - gen_op_arith_compute_ca32

For 64-bit mode use the compute ca32 routine. While for 32-bit mode, CA
and CA32 will have same value.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index be7378b..eba83ef 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -816,6 +816,23 @@ static inline void gen_op_arith_compute_ov(DisasContext *ctx, TCGv arg0,
     tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
 }
 
+static inline void gen_op_arith_compute_ca32(DisasContext *ctx,
+                                             TCGv res, TCGv arg0, TCGv arg1,
+                                             int sub)
+{
+    TCGv t0;
+
+    if (!is_isa300(ctx)) {
+        return;
+    }
+
+    t0 = tcg_temp_new();
+    tcg_gen_xor_tl(t0, arg0, arg1);
+    tcg_gen_xor_tl(t0, t0, res);
+    tcg_gen_extract_tl(cpu_ca32, t0, 32, 1);
+    tcg_temp_free(t0);
+}
+
 /* Common add function */
 static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
                                     TCGv arg2, bool add_ca, bool compute_ca,
@@ -842,6 +859,9 @@ static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
             tcg_temp_free(t1);
             tcg_gen_shri_tl(cpu_ca, cpu_ca, 32);   /* extract bit 32 */
             tcg_gen_andi_tl(cpu_ca, cpu_ca, 1);
+            if (is_isa300(ctx)) {
+                tcg_gen_mov_tl(cpu_ca32, cpu_ca);
+            }
         } else {
             TCGv zero = tcg_const_tl(0);
             if (add_ca) {
@@ -850,6 +870,7 @@ static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
             } else {
                 tcg_gen_add2_tl(t0, cpu_ca, arg1, zero, arg2, zero);
             }
+            gen_op_arith_compute_ca32(ctx, t0, arg1, arg2, 0);
             tcg_temp_free(zero);
         }
     } else {
-- 
2.9.3
