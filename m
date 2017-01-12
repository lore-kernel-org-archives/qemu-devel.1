Received: from eggs.gnu.org ([2001:4830:134:3::10]:46053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjv-0002qk-CY
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjs-0006OE-UM
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:43 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:02:29 +1100
Message-Id: <20170112020327.24882-10-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 09/67] target-ppc: implement lxv/lxvx and
 stxv/stxvx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

lxv:  Load VSX Vector
lxvx: Load VSX Vector Indexed

    Little/Big-endian Storage
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    |F0|F1|F2|F3|F4|F5|F6|F7|E0|E1|E2|E3|E4|E5|E6|E7|
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+

    Vector load results:
    BE:
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    |F0|F1|F2|F3|F4|F5|F6|F7|E0|E1|E2|E3|E4|E5|E6|E7|
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+

    LE:
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    |E7|E6|E5|E4|E3|E2|E1|E0|F7|F6|F5|F4|F3|F2|F1|F0|
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+

stxv: Store VSX Vector
stxvx: Store VSX Vector Indexed

    Vector (8-bit elements) in BE:
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    |F0|F1|F2|F3|F4|F5|F6|F7|E0|E1|E2|E3|E4|E5|E6|E7|
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+

    Vector (8-bit elements) in LE:
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    |E7|E6|E5|E4|E3|E2|E1|E0|F7|F6|F5|F4|F3|F2|F1|F0|
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+

    Store results in following:
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    |F0|F1|F2|F3|F4|F5|F6|F7|E0|E1|E2|E3|E4|E5|E6|E7|
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/internal.h               |  1 +
 target/ppc/translate.c              | 10 ++++++--
 target/ppc/translate/vsx-impl.inc.c | 50 +++++++++++++++++++++++++++++++++++++
 target/ppc/translate/vsx-ops.inc.c  |  2 ++
 4 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 9a4a74a..e83ea45 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -187,6 +187,7 @@ EXTRACT_HELPER(DCM, 10, 6)
 /* DFP Z23-form */
 EXTRACT_HELPER(RMC, 9, 2)
 
+EXTRACT_HELPER_SPLIT(DQxT, 3, 1, 21, 5);
 EXTRACT_HELPER_SPLIT(xT, 0, 1, 21, 5);
 EXTRACT_HELPER_SPLIT(xS, 0, 1, 21, 5);
 EXTRACT_HELPER_SPLIT(xA, 2, 1, 16, 5);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index a1bf74c..f68f427 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6076,14 +6076,20 @@ static void gen_dform39(DisasContext *ctx)
     return gen_invalid(ctx);
 }
 
-/* handles stfdp, stxsd, stxssp */
+/* handles stfdp, lxv, stxsd, stxssp lxvx */
 static void gen_dform3D(DisasContext *ctx)
 {
     if ((ctx->opcode & 3) == 1) { /* DQ-FORM */
         switch (ctx->opcode & 0x7) {
         case 1: /* lxv */
+            if (ctx->insns_flags2 & PPC2_ISA300) {
+                return gen_lxv(ctx);
+            }
             break;
         case 5: /* stxv */
+            if (ctx->insns_flags2 & PPC2_ISA300) {
+                return gen_stxv(ctx);
+            }
             break;
         }
     } else { /* DS-FORM */
@@ -6182,7 +6188,7 @@ GEN_HANDLER(std, 0x3E, 0xFF, 0xFF, 0x00000000, PPC_64B),
 #endif
 /* handles lfdp, lxsd, lxssp */
 GEN_HANDLER_E(dform39, 0x39, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
-/* handles stfdp, stxsd, stxssp */
+/* handles stfdp, lxv, stxsd, stxssp, stxv */
 GEN_HANDLER_E(dform3D, 0x3D, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
 GEN_HANDLER(lmw, 0x2E, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(stmw, 0x2F, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 8ee44cf..2fbdbd2 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -190,6 +190,56 @@ static void gen_lxvb16x(DisasContext *ctx)
     tcg_temp_free(EA);
 }
 
+#define VSX_VECTOR_LOAD_STORE(name, op, indexed)            \
+static void gen_##name(DisasContext *ctx)                   \
+{                                                           \
+    int xt;                                                 \
+    TCGv EA;                                                \
+    TCGv_i64 xth, xtl;                                      \
+                                                            \
+    if (indexed) {                                          \
+        xt = xT(ctx->opcode);                               \
+    } else {                                                \
+        xt = DQxT(ctx->opcode);                             \
+    }                                                       \
+    xth = cpu_vsrh(xt);                                     \
+    xtl = cpu_vsrl(xt);                                     \
+                                                            \
+    if (xt < 32) {                                          \
+        if (unlikely(!ctx->vsx_enabled)) {                  \
+            gen_exception(ctx, POWERPC_EXCP_VSXU);          \
+            return;                                         \
+        }                                                   \
+    } else {                                                \
+        if (unlikely(!ctx->altivec_enabled)) {              \
+            gen_exception(ctx, POWERPC_EXCP_VPU);           \
+            return;                                         \
+        }                                                   \
+    }                                                       \
+    gen_set_access_type(ctx, ACCESS_INT);                   \
+    EA = tcg_temp_new();                                    \
+    if (indexed) {                                          \
+        gen_addr_reg_index(ctx, EA);                        \
+    } else {                                                \
+        gen_addr_imm_index(ctx, EA, 0x0F);                  \
+    }                                                       \
+    if (ctx->le_mode) {                                     \
+        tcg_gen_qemu_##op(xtl, EA, ctx->mem_idx, MO_LEQ);   \
+        tcg_gen_addi_tl(EA, EA, 8);                         \
+        tcg_gen_qemu_##op(xth, EA, ctx->mem_idx, MO_LEQ);   \
+    } else {                                                \
+        tcg_gen_qemu_##op(xth, EA, ctx->mem_idx, MO_BEQ);   \
+        tcg_gen_addi_tl(EA, EA, 8);                         \
+        tcg_gen_qemu_##op(xtl, EA, ctx->mem_idx, MO_BEQ);   \
+    }                                                       \
+    tcg_temp_free(EA);                                      \
+}
+
+VSX_VECTOR_LOAD_STORE(lxv, ld_i64, 0)
+VSX_VECTOR_LOAD_STORE(stxv, st_i64, 0)
+VSX_VECTOR_LOAD_STORE(lxvx, ld_i64, 1)
+VSX_VECTOR_LOAD_STORE(stxvx, st_i64, 1)
+
 #define VSX_LOAD_SCALAR_DS(name, operation)                       \
 static void gen_##name(DisasContext *ctx)                         \
 {                                                                 \
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index 7f09527..8a1cbe0 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -9,6 +9,7 @@ GEN_HANDLER_E(lxvdsx, 0x1F, 0x0C, 0x0A, 0, PPC_NONE, PPC2_VSX),
 GEN_HANDLER_E(lxvw4x, 0x1F, 0x0C, 0x18, 0, PPC_NONE, PPC2_VSX),
 GEN_HANDLER_E(lxvh8x, 0x1F, 0x0C, 0x19, 0, PPC_NONE,  PPC2_ISA300),
 GEN_HANDLER_E(lxvb16x, 0x1F, 0x0C, 0x1B, 0, PPC_NONE, PPC2_ISA300),
+GEN_HANDLER_E(lxvx, 0x1F, 0x0C, 0x08, 0x00000040, PPC_NONE, PPC2_ISA300),
 
 GEN_HANDLER_E(stxsdx, 0x1F, 0xC, 0x16, 0, PPC_NONE, PPC2_VSX),
 GEN_HANDLER_E(stxsibx, 0x1F, 0xD, 0x1C, 0, PPC_NONE, PPC2_ISA300),
@@ -19,6 +20,7 @@ GEN_HANDLER_E(stxvd2x, 0x1F, 0xC, 0x1E, 0, PPC_NONE, PPC2_VSX),
 GEN_HANDLER_E(stxvw4x, 0x1F, 0xC, 0x1C, 0, PPC_NONE, PPC2_VSX),
 GEN_HANDLER_E(stxvh8x, 0x1F, 0x0C, 0x1D, 0, PPC_NONE,  PPC2_ISA300),
 GEN_HANDLER_E(stxvb16x, 0x1F, 0x0C, 0x1F, 0, PPC_NONE, PPC2_ISA300),
+GEN_HANDLER_E(stxvx, 0x1F, 0x0C, 0x0C, 0, PPC_NONE, PPC2_ISA300),
 
 GEN_HANDLER_E(mfvsrwz, 0x1F, 0x13, 0x03, 0x0000F800, PPC_NONE, PPC2_VSX207),
 GEN_HANDLER_E(mtvsrwa, 0x1F, 0x13, 0x06, 0x0000F800, PPC_NONE, PPC2_VSX207),
-- 
2.9.3
