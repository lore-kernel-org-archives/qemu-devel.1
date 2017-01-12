Received: from eggs.gnu.org ([2001:4830:134:3::10]:46036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjv-0002qO-0G
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjt-0006Om-EJ
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:43 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:02:27 +1100
Message-Id: <20170112020327.24882-8-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 07/67] target-ppc: implement lxsd and lxssp
 instructions
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

lxsd: Load VSX Scalar Dword
lxssp: Load VSX Scalar Single

Moreover, DS-Form instructions shares the same primary opcode, bits
30:31 are used to decode the instruction. Use a common routine to decode
primary opcode(0x39) - ds-form instructions and branch-out depending on
bits 30:31.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c              | 25 +++++++++++++++++++++++++
 target/ppc/translate/fp-ops.inc.c   |  1 -
 target/ppc/translate/vsx-impl.inc.c | 21 +++++++++++++++++++++
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index d3bda1b..9114f85 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6053,6 +6053,29 @@ GEN_TM_PRIV_NOOP(trechkpt);
 
 #include "translate/spe-impl.inc.c"
 
+/* Handles lfdp, lxsd, lxssp */
+static void gen_dform39(DisasContext *ctx)
+{
+    switch (ctx->opcode & 0x3) {
+    case 0: /* lfdp */
+        if (ctx->insns_flags2 & PPC2_ISA205) {
+            return gen_lfdp(ctx);
+        }
+        break;
+    case 2: /* lxsd */
+        if (ctx->insns_flags2 & PPC2_ISA300) {
+            return gen_lxsd(ctx);
+        }
+        break;
+    case 3: /* lxssp */
+        if (ctx->insns_flags2 & PPC2_ISA300) {
+            return gen_lxssp(ctx);
+        }
+        break;
+    }
+    return gen_invalid(ctx);
+}
+
 static opcode_t opcodes[] = {
 GEN_HANDLER(invalid, 0x00, 0x00, 0x00, 0xFFFFFFFF, PPC_NONE),
 GEN_HANDLER(cmp, 0x1F, 0x00, 0x00, 0x00400000, PPC_INTEGER),
@@ -6125,6 +6148,8 @@ GEN_HANDLER(ld, 0x3A, 0xFF, 0xFF, 0x00000000, PPC_64B),
 GEN_HANDLER(lq, 0x38, 0xFF, 0xFF, 0x00000000, PPC_64BX),
 GEN_HANDLER(std, 0x3E, 0xFF, 0xFF, 0x00000000, PPC_64B),
 #endif
+/* handles lfdp, lxsd, lxssp */
+GEN_HANDLER_E(dform39, 0x39, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
 GEN_HANDLER(lmw, 0x2E, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(stmw, 0x2F, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(lswi, 0x1F, 0x15, 0x12, 0x00000001, PPC_STRING),
diff --git a/target/ppc/translate/fp-ops.inc.c b/target/ppc/translate/fp-ops.inc.c
index d36ab4e..3127fa0 100644
--- a/target/ppc/translate/fp-ops.inc.c
+++ b/target/ppc/translate/fp-ops.inc.c
@@ -68,7 +68,6 @@ GEN_LDFS(lfd, ld64, 0x12, PPC_FLOAT)
 GEN_LDFS(lfs, ld32fs, 0x10, PPC_FLOAT)
 GEN_HANDLER_E(lfiwax, 0x1f, 0x17, 0x1a, 0x00000001, PPC_NONE, PPC2_ISA205),
 GEN_HANDLER_E(lfiwzx, 0x1f, 0x17, 0x1b, 0x1, PPC_NONE, PPC2_FP_CVT_ISA206),
-GEN_HANDLER_E(lfdp, 0x39, 0xFF, 0xFF, 0x00200003, PPC_NONE, PPC2_ISA205),
 GEN_HANDLER_E(lfdpx, 0x1F, 0x17, 0x18, 0x00200001, PPC_NONE, PPC2_ISA205),
 
 #define GEN_STF(name, stop, opc, type)                                        \
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index ed9588e..1d7cd23 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -190,6 +190,27 @@ static void gen_lxvb16x(DisasContext *ctx)
     tcg_temp_free(EA);
 }
 
+#define VSX_LOAD_SCALAR_DS(name, operation)                       \
+static void gen_##name(DisasContext *ctx)                         \
+{                                                                 \
+    TCGv EA;                                                      \
+    TCGv_i64 xth = cpu_vsrh(rD(ctx->opcode) + 32);                \
+                                                                  \
+    if (unlikely(!ctx->altivec_enabled)) {                        \
+        gen_exception(ctx, POWERPC_EXCP_VPU);                     \
+        return;                                                   \
+    }                                                             \
+    gen_set_access_type(ctx, ACCESS_INT);                         \
+    EA = tcg_temp_new();                                          \
+    gen_addr_imm_index(ctx, EA, 0x03);                            \
+    gen_qemu_##operation(ctx, xth, EA);                           \
+    /* NOTE: cpu_vsrl is undefined */                             \
+    tcg_temp_free(EA);                                            \
+}
+
+VSX_LOAD_SCALAR_DS(lxsd, ld64_i64)
+VSX_LOAD_SCALAR_DS(lxssp, ld32fs)
+
 #define VSX_STORE_SCALAR(name, operation)                     \
 static void gen_##name(DisasContext *ctx)                     \
 {                                                             \
-- 
2.9.3
