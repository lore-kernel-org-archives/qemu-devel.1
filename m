Received: from eggs.gnu.org ([2001:4830:134:3::10]:46199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=770980de4=jancraig@amazon.com>)
	id 1fuIiN-0006CA-0v
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:42:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=770980de4=jancraig@amazon.com>)
	id 1fuIiI-00026e-Tl
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:41:58 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:30130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=770980de4=jancraig@amazon.com>)
	id 1fuIiI-000260-H2
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:41:54 -0400
From: Craig Janeczek <jancraig@amazon.com>
Date: Mon, 27 Aug 2018 10:38:01 -0400
Message-Id: <20180827143806.25048-2-jancraig@amazon.com>
In-Reply-To: <20180827143806.25048-1-jancraig@amazon.com>
References: <20180827143806.25048-1-jancraig@amazon.com>
Subject: [Qemu-devel] [PATCH v2 1/6] target/mips: Add MXU instructions
 S32I2M and S32M2I
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarkovic@wavecomp.com, aurelien@aurel32.net, Craig Janeczek <jancraig@amazon.com>

This commit makes the MXU registers and the utility functions for
reading/writing to them. This is required for full MXU instruction
support.

Adds support for emulating the S32I2M and S32M2I MXU instructions.

Signed-off-by: Craig Janeczek <jancraig@amazon.com>
---
 v1
    - initial patch
 v2
    - Fix checkpatch.pl errors
    - remove mips64 ifdef
    - changed bitfield usage to extract32
    - squashed register addition patch into this one

 target/mips/cpu.h       |  1 +
 target/mips/translate.c | 71 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 009202cf64..4b2948a2c8 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -170,6 +170,7 @@ struct TCState {
         MSACSR_FS_MASK)
 
     float_status msa_fp_status;
+    target_ulong mxu_gpr[16];
 };
 
 typedef struct CPUMIPSState CPUMIPSState;
diff --git a/target/mips/translate.c b/target/mips/translate.c
index bdd880bb77..ef819d67e0 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -364,6 +364,9 @@ enum {
     OPC_CLO      = 0x21 | OPC_SPECIAL2,
     OPC_DCLZ     = 0x24 | OPC_SPECIAL2,
     OPC_DCLO     = 0x25 | OPC_SPECIAL2,
+    /* MXU */
+    OPC_MXU_S32I2M = 0x2F | OPC_SPECIAL2,
+    OPC_MXU_S32M2I = 0x2E | OPC_SPECIAL2,
     /* Special */
     OPC_SDBBP    = 0x3F | OPC_SPECIAL2,
 };
@@ -1398,6 +1401,9 @@ static TCGv_i32 fpu_fcr0, fpu_fcr31;
 static TCGv_i64 fpu_f64[32];
 static TCGv_i64 msa_wr_d[64];
 
+/* MXU registers */
+static TCGv mxu_gpr[16];
+
 #include "exec/gen-icount.h"
 
 #define gen_helper_0e0i(name, arg) do {                           \
@@ -1517,6 +1523,13 @@ static const char * const msaregnames[] = {
     "w30.d0", "w30.d1", "w31.d0", "w31.d1",
 };
 
+static const char * const mxuregnames[] = {
+    "XR1",  "XR2",  "XR3",  "XR4",  "XR5",
+    "XR6",  "XR7",  "XR8",  "XR9",  "XR10",
+    "XR11", "XR12", "XR13", "XR14", "XR15",
+    "XR16",
+};
+
 #define LOG_DISAS(...)                                                        \
     do {                                                                      \
         if (MIPS_DEBUG_DISAS) {                                               \
@@ -1550,6 +1563,23 @@ static inline void gen_store_gpr (TCGv t, int reg)
         tcg_gen_mov_tl(cpu_gpr[reg], t);
 }
 
+/* MXU General purpose registers moves. */
+static inline void gen_load_mxu_gpr(TCGv t, int reg)
+{
+    if (reg == 0) {
+        tcg_gen_movi_tl(t, 0);
+    } else {
+        tcg_gen_mov_tl(t, mxu_gpr[reg - 1]);
+    }
+}
+
+static inline void gen_store_mxu_gpr(TCGv t, int reg)
+{
+    if (reg != 0) {
+        tcg_gen_mov_tl(mxu_gpr[reg - 1], t);
+    }
+}
+
 /* Moves to/from shadow registers. */
 static inline void gen_load_srsgpr (int from, int to)
 {
@@ -3738,6 +3768,35 @@ static void gen_cl (DisasContext *ctx, uint32_t opc,
     }
 }
 
+/* MXU Instructions */
+static void gen_mxu(DisasContext *ctx, uint32_t opc)
+{
+    TCGv t0;
+    uint32_t xra, rb;
+
+    t0 = tcg_temp_new();
+
+    switch (opc) {
+    case OPC_MXU_S32I2M:
+        xra = extract32(ctx->opcode, 6, 5);
+        rb = extract32(ctx->opcode, 16, 5);
+
+        gen_load_gpr(t0, rb);
+        gen_store_mxu_gpr(t0, xra);
+        break;
+
+    case OPC_MXU_S32M2I:
+        xra = extract32(ctx->opcode, 6, 5);
+        rb = extract32(ctx->opcode, 16, 5);
+
+        gen_load_mxu_gpr(t0, xra);
+        gen_store_gpr(t0, rb);
+        break;
+    }
+
+    tcg_temp_free(t0);
+}
+
 /* Godson integer instructions */
 static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
                                  int rd, int rs, int rt)
@@ -17818,6 +17877,12 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
         check_insn(ctx, INSN_LOONGSON2F);
         gen_loongson_integer(ctx, op1, rd, rs, rt);
         break;
+
+    case OPC_MXU_S32I2M:
+    case OPC_MXU_S32M2I:
+        gen_mxu(ctx, op1);
+        break;
+
     case OPC_CLO:
     case OPC_CLZ:
         check_insn(ctx, ISA_MIPS32);
@@ -20742,6 +20807,12 @@ void mips_tcg_init(void)
     fpu_fcr31 = tcg_global_mem_new_i32(cpu_env,
                                        offsetof(CPUMIPSState, active_fpu.fcr31),
                                        "fcr31");
+
+    for (i = 0; i < 16; i++)
+        mxu_gpr[i] = tcg_global_mem_new(cpu_env,
+                                        offsetof(CPUMIPSState,
+                                                 active_tc.mxu_gpr[i]),
+                                        mxuregnames[i]);
 }
 
 #include "translate_init.inc.c"
-- 
2.18.0
