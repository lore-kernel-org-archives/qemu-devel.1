Received: from eggs.gnu.org ([2001:4830:134:3::10]:37720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV5-00030F-0L
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV2-0007z0-V1
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:06 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 Feb 2017 17:33:18 +1100
Message-Id: <20170222063348.32176-14-david@gibson.dropbear.id.au>
In-Reply-To: <20170222063348.32176-1-david@gibson.dropbear.id.au>
References: <20170222063348.32176-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 13/43] target-ppc: implement store atomic
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, imammedo@redhat.com, Balamuruhan S <bala24@linux.vnet.ibm.com>, Harish S <harisrir@linux.vnet.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Balamuruhan S <bala24@linux.vnet.ibm.com>

stwat: Store Word Atomic
stdat: Store Doubleword Atomic

The instruction includes as function code (5 bits) which gives a detail
on the operation to be performed. The patch implements five such
functions.

Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
Signed-off-by: Harish S <harisrir@linux.vnet.ibm.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
[ implement stdat, use macro and combine both implementation ]
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index ea2ec44..255735a 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3033,6 +3033,56 @@ LD_ATOMIC(lwat, DEF_MEMOP(MO_UL), i32, trunc_tl_i32, extu_i32_tl)
 LD_ATOMIC(ldat, DEF_MEMOP(MO_Q), i64, mov_i64, mov_i64)
 #endif
 
+#define ST_ATOMIC(name, memop, tp, op)                                  \
+static void gen_##name(DisasContext *ctx)                               \
+{                                                                       \
+    int len = MEMOP_GET_SIZE(memop);                                    \
+    uint32_t gpr_FC = FC(ctx->opcode);                                  \
+    TCGv EA = tcg_temp_local_new();                                     \
+    TCGv_##tp t0, t1;                                                   \
+                                                                        \
+    gen_addr_register(ctx, EA);                                         \
+    if (len > 1) {                                                      \
+        gen_check_align(ctx, EA, len - 1);                              \
+    }                                                                   \
+    t0 = tcg_temp_new_##tp();                                           \
+    t1 = tcg_temp_new_##tp();                                           \
+    tcg_gen_##op(t0, cpu_gpr[rD(ctx->opcode) + 1]);                     \
+                                                                        \
+    switch (gpr_FC) {                                                   \
+    case 0: /* add and Store */                                         \
+        tcg_gen_atomic_add_fetch_##tp(t1, EA, t0, ctx->mem_idx, memop); \
+        break;                                                          \
+    case 1: /* xor and Store */                                         \
+        tcg_gen_atomic_xor_fetch_##tp(t1, EA, t0, ctx->mem_idx, memop); \
+        break;                                                          \
+    case 2: /* Or and Store */                                          \
+        tcg_gen_atomic_or_fetch_##tp(t1, EA, t0, ctx->mem_idx, memop);  \
+        break;                                                          \
+    case 3: /* 'and' and Store */                                       \
+        tcg_gen_atomic_and_fetch_##tp(t1, EA, t0, ctx->mem_idx, memop); \
+        break;                                                          \
+    case 4:  /* Store max unsigned */                                   \
+    case 5:  /* Store max signed */                                     \
+    case 6:  /* Store min unsigned */                                   \
+    case 7:  /* Store min signed */                                     \
+    case 24: /* Store twin  */                                          \
+        gen_invalid(ctx);                                               \
+        break;                                                          \
+    default:                                                            \
+        /* invoke data storage error handler */                         \
+        gen_exception_err(ctx, POWERPC_EXCP_DSI, POWERPC_EXCP_INVAL);   \
+    }                                                                   \
+    tcg_temp_free_##tp(t0);                                             \
+    tcg_temp_free_##tp(t1);                                             \
+    tcg_temp_free(EA);                                                  \
+}
+
+ST_ATOMIC(stwat, DEF_MEMOP(MO_UL), i32, trunc_tl_i32)
+#if defined(TARGET_PPC64)
+ST_ATOMIC(stdat, DEF_MEMOP(MO_Q), i64, mov_i64)
+#endif
+
 #if defined(CONFIG_USER_ONLY)
 static void gen_conditional_store(DisasContext *ctx, TCGv EA,
                                   int reg, int memop)
@@ -6288,11 +6338,13 @@ GEN_HANDLER_E(lbarx, 0x1F, 0x14, 0x01, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
 GEN_HANDLER_E(lharx, 0x1F, 0x14, 0x03, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
 GEN_HANDLER(lwarx, 0x1F, 0x14, 0x00, 0x00000000, PPC_RES),
 GEN_HANDLER_E(lwat, 0x1F, 0x06, 0x12, 0x00000001, PPC_NONE, PPC2_ISA300),
+GEN_HANDLER_E(stwat, 0x1F, 0x06, 0x16, 0x00000001, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(stbcx_, 0x1F, 0x16, 0x15, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
 GEN_HANDLER_E(sthcx_, 0x1F, 0x16, 0x16, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
 GEN_HANDLER2(stwcx_, "stwcx.", 0x1F, 0x16, 0x04, 0x00000000, PPC_RES),
 #if defined(TARGET_PPC64)
 GEN_HANDLER_E(ldat, 0x1F, 0x06, 0x13, 0x00000001, PPC_NONE, PPC2_ISA300),
+GEN_HANDLER_E(stdat, 0x1F, 0x06, 0x17, 0x00000001, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER(ldarx, 0x1F, 0x14, 0x02, 0x00000000, PPC_64B),
 GEN_HANDLER_E(lqarx, 0x1F, 0x14, 0x08, 0, PPC_NONE, PPC2_LSQ_ISA207),
 GEN_HANDLER2(stdcx_, "stdcx.", 0x1F, 0x16, 0x06, 0x00000000, PPC_64B),
-- 
2.9.3
