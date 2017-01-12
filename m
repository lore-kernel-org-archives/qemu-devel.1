Received: from eggs.gnu.org ([2001:4830:134:3::10]:45989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUju-0002pV-7g
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjs-0006O3-Sw
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:42 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:02:28 +1100
Message-Id: <20170112020327.24882-9-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 08/67] target-ppc: implement stxsd and stxssp
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

stxsd:  Store VSX Scalar Dword
stxssp: Store VSX Scalar SP

Moreover, DQ-Form/DS-FORM instructions shares the same primary
opcode(0x3D). For DQ-FORM bits 29:31 are used, for DS-FORM bits 30:31
are used. Common routine to decode primary opcode(0x3D) -
ds-form/dq-form instructions is required.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c              | 34 ++++++++++++++++++++++++++++++++++
 target/ppc/translate/fp-ops.inc.c   |  1 -
 target/ppc/translate/vsx-impl.inc.c | 21 +++++++++++++++++++++
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 9114f85..a1bf74c 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6076,6 +6076,38 @@ static void gen_dform39(DisasContext *ctx)
     return gen_invalid(ctx);
 }
 
+/* handles stfdp, stxsd, stxssp */
+static void gen_dform3D(DisasContext *ctx)
+{
+    if ((ctx->opcode & 3) == 1) { /* DQ-FORM */
+        switch (ctx->opcode & 0x7) {
+        case 1: /* lxv */
+            break;
+        case 5: /* stxv */
+            break;
+        }
+    } else { /* DS-FORM */
+        switch (ctx->opcode & 0x3) {
+        case 0: /* stfdp */
+            if (ctx->insns_flags2 & PPC2_ISA205) {
+                return gen_stfdp(ctx);
+            }
+            break;
+        case 2: /* stxsd */
+            if (ctx->insns_flags2 & PPC2_ISA300) {
+                return gen_stxsd(ctx);
+            }
+            break;
+        case 3: /* stxssp */
+            if (ctx->insns_flags2 & PPC2_ISA300) {
+                return gen_stxssp(ctx);
+            }
+            break;
+        }
+    }
+    return gen_invalid(ctx);
+}
+
 static opcode_t opcodes[] = {
 GEN_HANDLER(invalid, 0x00, 0x00, 0x00, 0xFFFFFFFF, PPC_NONE),
 GEN_HANDLER(cmp, 0x1F, 0x00, 0x00, 0x00400000, PPC_INTEGER),
@@ -6150,6 +6182,8 @@ GEN_HANDLER(std, 0x3E, 0xFF, 0xFF, 0x00000000, PPC_64B),
 #endif
 /* handles lfdp, lxsd, lxssp */
 GEN_HANDLER_E(dform39, 0x39, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
+/* handles stfdp, stxsd, stxssp */
+GEN_HANDLER_E(dform3D, 0x3D, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
 GEN_HANDLER(lmw, 0x2E, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(stmw, 0x2F, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(lswi, 0x1F, 0x15, 0x12, 0x00000001, PPC_STRING),
diff --git a/target/ppc/translate/fp-ops.inc.c b/target/ppc/translate/fp-ops.inc.c
index 3127fa0..3c6d05a 100644
--- a/target/ppc/translate/fp-ops.inc.c
+++ b/target/ppc/translate/fp-ops.inc.c
@@ -87,7 +87,6 @@ GEN_STXF(name, stop, 0x17, op | 0x00, type)
 GEN_STFS(stfd, st64_i64, 0x16, PPC_FLOAT)
 GEN_STFS(stfs, st32fs, 0x14, PPC_FLOAT)
 GEN_STXF(stfiw, st32fiw, 0x17, 0x1E, PPC_FLOAT_STFIWX)
-GEN_HANDLER_E(stfdp, 0x3D, 0xFF, 0xFF, 0x00200003, PPC_NONE, PPC2_ISA205),
 GEN_HANDLER_E(stfdpx, 0x1F, 0x17, 0x1C, 0x00200001, PPC_NONE, PPC2_ISA205),
 
 GEN_HANDLER(frsqrtes, 0x3B, 0x1A, 0xFF, 0x001F07C0, PPC_FLOAT_FRSQRTES),
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 1d7cd23..8ee44cf 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -332,6 +332,27 @@ static void gen_stxvb16x(DisasContext *ctx)
     tcg_temp_free(EA);
 }
 
+#define VSX_STORE_SCALAR_DS(name, operation)                      \
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
+VSX_LOAD_SCALAR_DS(stxsd, st64_i64)
+VSX_LOAD_SCALAR_DS(stxssp, st32fs)
+
 #define MV_VSRW(name, tcgop1, tcgop2, target, source)           \
 static void gen_##name(DisasContext *ctx)                       \
 {                                                               \
-- 
2.9.3
