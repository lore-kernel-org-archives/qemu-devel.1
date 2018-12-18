Received: from eggs.gnu.org ([2001:4830:134:3::10]:52824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92r-0001dJ-Pd
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92p-0002ne-0u
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:39:57 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:33774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZ92o-0002EC-LL
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:39:54 -0500
Received: by mail-pf1-x442.google.com with SMTP id c123so7663614pfb.0
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 22:39:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 17 Dec 2018 22:38:54 -0800
Message-Id: <20181218063911.2112-18-richard.henderson@linaro.org>
In-Reply-To: <20181218063911.2112-1-richard.henderson@linaro.org>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 17/34] target/ppc: convert VMX logical
 instructions to use vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20181217122405.18732-9-mark.cave-ayland@ilande.co.uk>
---
 target/ppc/translate.c              |  1 +
 target/ppc/translate/vmx-impl.inc.c | 63 ++++++++++++++++-------------
 2 files changed, 37 insertions(+), 27 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 8e89aec14d..1b61bfa093 100644
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
index 75d2b2280f..c13828a09d 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -262,41 +262,50 @@ GEN_VX_VMUL10(vmul10euq, 1, 0);
 GEN_VX_VMUL10(vmul10cuq, 0, 1);
 GEN_VX_VMUL10(vmul10ecuq, 1, 1);
 
-/* Logical operations */
-#define GEN_VX_LOGICAL(name, tcg_op, opc2, opc3)                        \
-static void glue(gen_, name)(DisasContext *ctx)                                 \
+#define GEN_VXFORM_V(name, vece, tcg_op, opc2, opc3)                    \
+static void glue(gen_, name)(DisasContext *ctx)                         \
 {                                                                       \
-    TCGv_i64 t0 = tcg_temp_new_i64();                                   \
-    TCGv_i64 t1 = tcg_temp_new_i64();                                   \
-    TCGv_i64 avr = tcg_temp_new_i64();                                  \
-                                                                        \
     if (unlikely(!ctx->altivec_enabled)) {                              \
         gen_exception(ctx, POWERPC_EXCP_VPU);                           \
         return;                                                         \
     }                                                                   \
-    get_avr64(t0, rA(ctx->opcode), true);                               \
-    get_avr64(t1, rB(ctx->opcode), true);                               \
-    tcg_op(avr, t0, t1);                                                \
-    set_avr64(rD(ctx->opcode), avr, true);                              \
                                                                         \
-    get_avr64(t0, rA(ctx->opcode), false);                              \
-    get_avr64(t1, rB(ctx->opcode), false);                              \
-    tcg_op(avr, t0, t1);                                                \
-    set_avr64(rD(ctx->opcode), avr, false);                             \
-                                                                        \
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
+#define GEN_VXFORM_VN(name, vece, tcg_op, opc2, opc3)                   \
+static void glue(gen_, name)(DisasContext *ctx)                         \
+{                                                                       \
+    if (unlikely(!ctx->altivec_enabled)) {                              \
+        gen_exception(ctx, POWERPC_EXCP_VPU);                           \
+        return;                                                         \
+    }                                                                   \
+                                                                        \
+    tcg_op(vece,                                                        \
+           avr64_offset(rD(ctx->opcode), true),                         \
+           avr64_offset(rA(ctx->opcode), true),                         \
+           avr64_offset(rB(ctx->opcode), true),                         \
+           16, 16);                                                     \
+                                                                        \
+    tcg_gen_gvec_not(vece,                                              \
+                     avr64_offset(rD(ctx->opcode), true),               \
+                     avr64_offset(rD(ctx->opcode), true),               \
+                     16, 16);                                           \
+}
+
+/* Logical operations */
+GEN_VXFORM_V(vand, MO_64, tcg_gen_gvec_and, 2, 16);
+GEN_VXFORM_V(vandc, MO_64, tcg_gen_gvec_andc, 2, 17);
+GEN_VXFORM_V(vor, MO_64, tcg_gen_gvec_or, 2, 18);
+GEN_VXFORM_V(vxor, MO_64, tcg_gen_gvec_xor, 2, 19);
+GEN_VXFORM_VN(vnor, MO_64, tcg_gen_gvec_or, 2, 20);
+GEN_VXFORM_VN(veqv, MO_64, tcg_gen_gvec_xor, 2, 26);
+GEN_VXFORM_VN(vnand, MO_64, tcg_gen_gvec_and, 2, 22);
+GEN_VXFORM_V(vorc, MO_64, tcg_gen_gvec_orc, 2, 21);
 
 #define GEN_VXFORM(name, opc2, opc3)                                    \
 static void glue(gen_, name)(DisasContext *ctx)                                 \
-- 
2.17.2
