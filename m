Received: from eggs.gnu.org ([209.51.188.92]:52490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1gyIrY-0000Zd-OC
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:12:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1gyIrX-0003Iq-Lh
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:12:16 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:53604 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1gyIrX-0002cb-B5
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:12:15 -0500
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Mon, 25 Feb 2019 17:10:35 +0100
Message-Id: <1551111037-23411-2-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1551111037-23411-1-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1551111037-23411-1-git-send-email-mateja.marjanovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 1/3] target/mips: Add emulation of MMI
 instruction PCPYH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com

Add emulation of MMI instruction PCPYH. The emulation is implemented
using TCG front end operations directly to achieve better performance.

Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
---
 target/mips/translate.c | 115 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 112 insertions(+), 3 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 3b17020..a3a5f9b 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -4362,6 +4362,7 @@ static void gen_shift(DisasContext *ctx, uint32_t opc,
     tcg_temp_free(t1);
 }
 
+#if defined(TARGET_MIPS64)
 /* Copy GPR to and from TX79 HI1/LO1 register. */
 static void gen_HILO1_tx79(DisasContext *ctx, uint32_t opc, int reg)
 {
@@ -4397,6 +4398,7 @@ static void gen_HILO1_tx79(DisasContext *ctx, uint32_t opc, int reg)
         break;
     }
 }
+#endif
 
 /* Arithmetic on HI/LO registers */
 static void gen_HILO(DisasContext *ctx, uint32_t opc, int acc, int reg)
@@ -4746,6 +4748,7 @@ static void gen_r6_muldiv(DisasContext *ctx, int opc, int rd, int rs, int rt)
     tcg_temp_free(t1);
 }
 
+#if defined(TARGET_MIPS64)
 static void gen_div1_tx79(DisasContext *ctx, uint32_t opc, int rs, int rt)
 {
     TCGv t0, t1;
@@ -4802,6 +4805,7 @@ static void gen_div1_tx79(DisasContext *ctx, uint32_t opc, int rs, int rt)
     tcg_temp_free(t0);
     tcg_temp_free(t1);
 }
+#endif
 
 static void gen_muldiv(DisasContext *ctx, uint32_t opc,
                        int acc, int rs, int rt)
@@ -24324,6 +24328,97 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
 }
 
 
+#if defined(TARGET_MIPS64)
+
+
+/*
+ *
+ *           MMI (MultiMedia Interface) ASE instructions
+ *           ===========================================
+ */
+
+/*
+ *          MMI instructions category: data communication
+ *          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *    PCPYH    PEXCH    PEXTLB   PINTH    PPACB    PEXT5    PREVH
+ *    PCPYLD   PEXCW    PEXTLH   PINTEH   PPACH    PPAC5    PROT3W
+ *    PCPYUD   PEXCEH   PEXTLW            PPACW
+ *             PEXCEW   PEXTUB
+ *                      PEXTUB
+ *                      PEXTUB
+ */
+
+/*
+ *  PCPYH rd, rt
+ *
+ *    Parallel Copy Halfword
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+---------+---------+---------+-----------+
+ *  |    MMI    |0 0 0 0 0|   rt    |   rd    |  PCPYH  |    MMI3   |
+ *  +-----------+---------+---------+---------+---------+-----------+
+ */
+static void gen_mmi_pcpyh(DisasContext *ctx)
+{
+    uint32_t pd, rt, rd;
+    uint32_t opcode;
+
+    opcode = ctx->opcode;
+
+    pd = extract32(opcode, 21, 5);
+    rt = extract32(opcode, 16, 5);
+    rd = extract32(opcode, 11, 5);
+
+    if (unlikely(pd != 0)) {
+        generate_exception_end(ctx, EXCP_RI);
+    } else if (rd == 0) {
+        /* nop */
+    } else if (rt == 0) {
+        tcg_gen_movi_i64(cpu_gpr[rt], 0);
+        tcg_gen_movi_i64(cpu_mmr[rt], 0);
+    } else {
+        TCGv_i64 t0;
+        TCGv_i64 t1;
+        TCGv_i64 t2;
+        uint64_t mask = (1ULL << 16) - 1;
+
+        t0 = tcg_temp_new();
+        t1 = tcg_temp_new();
+        t2 = tcg_temp_new();
+
+        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask);
+        tcg_gen_movi_i64(t1, 0);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_shli_i64(t0, t0, 16);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_shli_i64(t0, t0, 16);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_shli_i64(t0, t0, 16);
+        tcg_gen_or_i64(t1, t0, t1);
+
+        tcg_gen_andi_i64(t0, cpu_mmr[rt], mask);
+        tcg_gen_movi_i64(t2, 0);
+        tcg_gen_or_i64(t2, t0, t2);
+        tcg_gen_shli_i64(t0, t0, 16);
+        tcg_gen_or_i64(t2, t0, t2);
+        tcg_gen_shli_i64(t0, t0, 16);
+        tcg_gen_or_i64(t2, t0, t2);
+        tcg_gen_shli_i64(t0, t0, 16);
+        tcg_gen_or_i64(t2, t0, t2);
+
+        tcg_gen_mov_i64(cpu_gpr[rd], t1);
+        tcg_gen_mov_i64(cpu_mmr[rd], t2);
+
+        tcg_temp_free(t0);
+        tcg_temp_free(t1);
+        tcg_temp_free(t2);
+    }
+}
+
+#endif
+
+
 #if !defined(TARGET_MIPS64)
 
 /* MXU accumulate add/subtract 1-bit pattern 'aptn1' */
@@ -27247,6 +27342,9 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
     }
 }
 
+
+#if defined(TARGET_MIPS64)
+
 static void decode_mmi0(CPUMIPSState *env, DisasContext *ctx)
 {
     uint32_t opc = MASK_MMI0(ctx->opcode);
@@ -27370,10 +27468,12 @@ static void decode_mmi3(CPUMIPSState *env, DisasContext *ctx)
     case MMI_OPC_3_POR:        /* TODO: MMI_OPC_3_POR */
     case MMI_OPC_3_PNOR:       /* TODO: MMI_OPC_3_PNOR */
     case MMI_OPC_3_PEXCH:      /* TODO: MMI_OPC_3_PEXCH */
-    case MMI_OPC_3_PCPYH:      /* TODO: MMI_OPC_3_PCPYH */
     case MMI_OPC_3_PEXCW:      /* TODO: MMI_OPC_3_PEXCW */
         generate_exception_end(ctx, EXCP_RI); /* TODO: MMI_OPC_CLASS_MMI3 */
         break;
+    case MMI_OPC_3_PCPYH:
+        gen_mmi_pcpyh(ctx);
+        break;
     default:
         MIPS_INVAL("TX79 MMI class MMI3");
         generate_exception_end(ctx, EXCP_RI);
@@ -27491,6 +27591,8 @@ static void decode_mmi_sq(CPUMIPSState *env, DisasContext *ctx)
     gen_mmi_sq(ctx, base, rt, offset);
 }
 
+#endif
+
 static void decode_opc_special3(CPUMIPSState *env, DisasContext *ctx)
 {
     int rs, rt, rd, sa;
@@ -28796,10 +28898,11 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         decode_opc_special(env, ctx);
         break;
     case OPC_SPECIAL2:
+#if defined(TARGET_MIPS64)
         if ((ctx->insn_flags & INSN_R5900) && (ctx->insn_flags & ASE_MMI)) {
             decode_mmi(env, ctx);
-#if !defined(TARGET_MIPS64)
-        } else if (ctx->insn_flags & ASE_MXU) {
+#else
+        if (ctx->insn_flags & ASE_MXU) {
             decode_opc_mxu(env, ctx);
 #endif
         } else {
@@ -28807,11 +28910,15 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case OPC_SPECIAL3:
+#if defined(TARGET_MIPS64)
         if (ctx->insn_flags & INSN_R5900) {
             decode_mmi_sq(env, ctx);    /* MMI_OPC_SQ */
         } else {
             decode_opc_special3(env, ctx);
         }
+#else
+        decode_opc_special3(env, ctx);
+#endif
         break;
     case OPC_REGIMM:
         op1 = MASK_REGIMM(ctx->opcode);
@@ -29483,7 +29590,9 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         break;
     case OPC_MSA: /* OPC_MDMX */
         if (ctx->insn_flags & INSN_R5900) {
+#if defined(TARGET_MIPS64)
             gen_mmi_lq(env, ctx);    /* MMI_OPC_LQ */
+#endif
         } else {
             /* MDMX: Not implemented. */
             gen_msa(env, ctx);
-- 
2.7.4
