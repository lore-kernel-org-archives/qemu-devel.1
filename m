Received: from eggs.gnu.org ([209.51.188.92]:53520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1guaJq-0006mm-28
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:02:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1guaJg-0000I7-ON
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:02:04 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 15 Feb 2019 10:00:42 +0000
Message-Id: <20190215100058.20015-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190215100058.20015-1-mark.cave-ayland@ilande.co.uk>
References: <20190215100058.20015-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 01/17] target/ppc: convert VMX logical
 instructions to use vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, richard.henderson@linaro.org

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c              |  1 +
 target/ppc/translate/vmx-impl.inc.c | 47 +++++++++++++------------------------
 2 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index e169c43643..f66786254d 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -24,6 +24,7 @@
 #include "disas/disas.h"
 #include "exec/exec-all.h"
 #include "tcg-op.h"
+#include "tcg-op-gvec.h"
 #include "qemu/host-utils.h"
 #include "exec/cpu_ldst.h"
 
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index f99d0284c2..c74932e5ee 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -266,45 +266,30 @@ GEN_VX_VMUL10(vmul10euq, 1, 0);
 GEN_VX_VMUL10(vmul10cuq, 0, 1);
 GEN_VX_VMUL10(vmul10ecuq, 1, 1);
 
-/* Logical operations */
-#define GEN_VX_LOGICAL(name, tcg_op, opc2, opc3)                        \
-static void glue(gen_, name)(DisasContext *ctx)                                 \
+#define GEN_VXFORM_V(name, vece, tcg_op, opc2, opc3)                    \
+static void glue(gen_, name)(DisasContext *ctx)                         \
 {                                                                       \
-    TCGv_i64 t0;                                                        \
-    TCGv_i64 t1;                                                        \
-    TCGv_i64 avr;                                                       \
-                                                                        \
     if (unlikely(!ctx->altivec_enabled)) {                              \
         gen_exception(ctx, POWERPC_EXCP_VPU);                           \
         return;                                                         \
     }                                                                   \
-    t0 = tcg_temp_new_i64();                                            \
-    t1 = tcg_temp_new_i64();                                            \
-    avr = tcg_temp_new_i64();                                           \
-                                                                        \
-    get_avr64(t0, rA(ctx->opcode), true);                               \
-    get_avr64(t1, rB(ctx->opcode), true);                               \
-    tcg_op(avr, t0, t1);                                                \
-    set_avr64(rD(ctx->opcode), avr, true);                              \
-                                                                        \
-    get_avr64(t0, rA(ctx->opcode), false);                              \
-    get_avr64(t1, rB(ctx->opcode), false);                              \
-    tcg_op(avr, t0, t1);                                                \
-    set_avr64(rD(ctx->opcode), avr, false);                             \
                                                                         \
-    tcg_temp_free_i64(t0);                                              \
-    tcg_temp_free_i64(t1);                                              \
-    tcg_temp_free_i64(avr);                                             \
+    tcg_op(vece,                                                        \
+           avr64_offset(rD(ctx->opcode), true),                         \
+           avr64_offset(rA(ctx->opcode), true),                         \
+           avr64_offset(rB(ctx->opcode), true),                         \
+           16, 16);                                                     \
 }
 
-GEN_VX_LOGICAL(vand, tcg_gen_and_i64, 2, 16);
-GEN_VX_LOGICAL(vandc, tcg_gen_andc_i64, 2, 17);
-GEN_VX_LOGICAL(vor, tcg_gen_or_i64, 2, 18);
-GEN_VX_LOGICAL(vxor, tcg_gen_xor_i64, 2, 19);
-GEN_VX_LOGICAL(vnor, tcg_gen_nor_i64, 2, 20);
-GEN_VX_LOGICAL(veqv, tcg_gen_eqv_i64, 2, 26);
-GEN_VX_LOGICAL(vnand, tcg_gen_nand_i64, 2, 22);
-GEN_VX_LOGICAL(vorc, tcg_gen_orc_i64, 2, 21);
+/* Logical operations */
+GEN_VXFORM_V(vand, MO_64, tcg_gen_gvec_and, 2, 16);
+GEN_VXFORM_V(vandc, MO_64, tcg_gen_gvec_andc, 2, 17);
+GEN_VXFORM_V(vor, MO_64, tcg_gen_gvec_or, 2, 18);
+GEN_VXFORM_V(vxor, MO_64, tcg_gen_gvec_xor, 2, 19);
+GEN_VXFORM_V(vnor, MO_64, tcg_gen_gvec_nor, 2, 20);
+GEN_VXFORM_V(veqv, MO_64, tcg_gen_gvec_eqv, 2, 26);
+GEN_VXFORM_V(vnand, MO_64, tcg_gen_gvec_nand, 2, 22);
+GEN_VXFORM_V(vorc, MO_64, tcg_gen_gvec_orc, 2, 21);
 
 #define GEN_VXFORM(name, opc2, opc3)                                    \
 static void glue(gen_, name)(DisasContext *ctx)                                 \
-- 
2.11.0
