Received: from eggs.gnu.org ([2001:4830:134:3::10]:40080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYNoo-0003uU-C6
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 22:37:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYNon-0007Wt-43
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 22:37:30 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:37177)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYNom-0007Wd-SQ
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 22:37:29 -0400
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Fri, 21 Jul 2017 03:37:08 +0100
Message-ID: <1500604635-15027-8-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1500604635-15027-1-git-send-email-yongbok.kim@imgtec.com>
References: <1500604635-15027-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 07/14] target/mips: Decode microMIPS EVA load &
 store instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, James Hogan <james.hogan@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>

From: James Hogan <james.hogan@imgtec.com>

Implement decoding of microMIPS EVA load and store instruction groups in
the POOL31C pool. These use the same gen_ld(), gen_st(), gen_st_cond()
helpers as the MIPS32 decoding, passing the equivalent MIPS32 opcodes as
opc.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 target/mips/translate.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 115 insertions(+), 4 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 93fb8f3..9787919 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -12519,19 +12519,45 @@ enum {
     LWR = 0x1,
     SWR = 0x9,
     PREF = 0x2,
-    /* 0xa is reserved */
+    ST_EVA = 0xa,
     LL = 0x3,
     SC = 0xb,
     LDL = 0x4,
     SDL = 0xc,
     LDR = 0x5,
     SDR = 0xd,
-    /* 0x6 is reserved */
+    LD_EVA = 0x6,
     LWU = 0xe,
     LLD = 0x7,
     SCD = 0xf
 };
 
+/* POOL32C LD-EVA encoding of minor opcode field (bits 11..9) */
+
+enum {
+    LBUE = 0x0,
+    LHUE = 0x1,
+    LWLE = 0x2,
+    LWRE = 0x3,
+    LBE = 0x4,
+    LHE = 0x5,
+    LLE = 0x6,
+    LWE = 0x7,
+};
+
+/* POOL32C ST-EVA encoding of minor opcode field (bits 11..9) */
+
+enum {
+    SWLE = 0x0,
+    SWRE = 0x1,
+    PREFE = 0x2,
+    CACHEE = 0x3,
+    SBE = 0x4,
+    SHE = 0x5,
+    SCE = 0x6,
+    SWE = 0x7,
+};
+
 /* POOL32F encoding of minor opcode field (bits 5..0) */
 
 enum {
@@ -13832,7 +13858,7 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
     uint16_t insn;
     int rt, rs, rd, rr;
     int16_t imm;
-    uint32_t op, minor, mips32_op;
+    uint32_t op, minor, minor2, mips32_op;
     uint32_t cond, fmt, cc;
 
     insn = cpu_lduw_code(env, ctx->pc + 2);
@@ -14777,7 +14803,7 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
             gen_ld(ctx, mips32_op, rt, rs, offset);
             break;
         do_st_lr:
-            gen_st(ctx, mips32_op, rt, rs, SIMM(ctx->opcode, 0, 12));
+            gen_st(ctx, mips32_op, rt, rs, offset);
             break;
         case SC:
             gen_st_cond(ctx, OPC_SC, rt, rs, offset);
@@ -14789,6 +14815,91 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
             gen_st_cond(ctx, OPC_SCD, rt, rs, offset);
             break;
 #endif
+        case LD_EVA:
+            if (!ctx->eva) {
+                MIPS_INVAL("pool32c ld-eva");
+                generate_exception_end(ctx, EXCP_RI);
+                break;
+            }
+            check_cp0_enabled(ctx);
+
+            minor2 = (ctx->opcode >> 9) & 0x7;
+            offset = sextract32(ctx->opcode, 0, 9);
+            switch (minor2) {
+            case LBUE:
+                mips32_op = OPC_LBUE;
+                goto do_ld_lr;
+            case LHUE:
+                mips32_op = OPC_LHUE;
+                goto do_ld_lr;
+            case LWLE:
+                check_insn_opc_removed(ctx, ISA_MIPS32R6);
+                mips32_op = OPC_LWLE;
+                goto do_ld_lr;
+            case LWRE:
+                check_insn_opc_removed(ctx, ISA_MIPS32R6);
+                mips32_op = OPC_LWRE;
+                goto do_ld_lr;
+            case LBE:
+                mips32_op = OPC_LBE;
+                goto do_ld_lr;
+            case LHE:
+                mips32_op = OPC_LHE;
+                goto do_ld_lr;
+            case LLE:
+                mips32_op = OPC_LLE;
+                goto do_ld_lr;
+            case LWE:
+                mips32_op = OPC_LWE;
+                goto do_ld_lr;
+            };
+            break;
+        case ST_EVA:
+            if (!ctx->eva) {
+                MIPS_INVAL("pool32c st-eva");
+                generate_exception_end(ctx, EXCP_RI);
+                break;
+            }
+            check_cp0_enabled(ctx);
+
+            minor2 = (ctx->opcode >> 9) & 0x7;
+            offset = sextract32(ctx->opcode, 0, 9);
+            switch (minor2) {
+            case SWLE:
+                check_insn_opc_removed(ctx, ISA_MIPS32R6);
+                mips32_op = OPC_SWLE;
+                goto do_st_lr;
+            case SWRE:
+                check_insn_opc_removed(ctx, ISA_MIPS32R6);
+                mips32_op = OPC_SWRE;
+                goto do_st_lr;
+            case PREFE:
+                /* Treat as no-op */
+                if ((ctx->insn_flags & ISA_MIPS32R6) && (rt >= 24)) {
+                    /* hint codes 24-31 are reserved and signal RI */
+                    generate_exception(ctx, EXCP_RI);
+                }
+                break;
+            case CACHEE:
+                /* Treat as no-op */
+                if (ctx->hflags & MIPS_HFLAG_ITC_CACHE) {
+                    gen_cache_operation(ctx, rt, rs, offset);
+                }
+                break;
+            case SBE:
+                mips32_op = OPC_SBE;
+                goto do_st_lr;
+            case SHE:
+                mips32_op = OPC_SHE;
+                goto do_st_lr;
+            case SCE:
+                gen_st_cond(ctx, OPC_SCE, rt, rs, offset);
+                break;
+            case SWE:
+                mips32_op = OPC_SWE;
+                goto do_st_lr;
+            };
+            break;
         case PREF:
             /* Treat as no-op */
             if ((ctx->insn_flags & ISA_MIPS32R6) && (rt >= 24)) {
-- 
2.7.4
