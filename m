Received: from eggs.gnu.org ([2001:4830:134:3::10]:40137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.org>) id 1eneni-0002RW-4x
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 01:19:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.org>) id 1enenf-0007Qf-1Y
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 01:19:46 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:51453)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <david.brenken@efs-auto.org>)
	id 1enene-0007QI-Nf
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 01:19:42 -0500
From: David Brenken <david.brenken@efs-auto.org>
Date: Mon, 19 Feb 2018 07:18:23 +0100
Message-Id: <20180219061827.2112-2-david.brenken@efs-auto.org>
In-Reply-To: <20180219061827.2112-1-david.brenken@efs-auto.org>
References: <20180219061827.2112-1-david.brenken@efs-auto.org>
Subject: [Qemu-devel] [PATCH 1/5] tricore: added some missing cpu
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de, David Brenken <david.brenken@efs-auto.de>, Georg Hofstetter <georg.hofstetter@efs-auto.de>, Florian Artmeier <florian.artmeier@efs-auto.de>

From: David Brenken <david.brenken@efs-auto.de>

Signed-off-by: David Brenken <david.brenken@efs-auto.de>
Signed-off-by: Georg Hofstetter <georg.hofstetter@efs-auto.de>
Signed-off-by: Florian Artmeier <florian.artmeier@efs-auto.de>
---
 target/tricore/translate.c       | 22 ++++++++++++++++++++++
 target/tricore/tricore-opcodes.h |  4 ++++
 2 files changed, 26 insertions(+)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 4e5b083..959697f 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -3389,10 +3389,18 @@ static void gen_compute_branch(DisasContext *ctx, uint32_t opc, int r1,
         gen_branch_cond(ctx, TCG_COND_EQ, cpu_gpr_d[r1], cpu_gpr_d[15],
                         offset);
         break;
+    case OPC1_16_SBR_JEQ2:
+        gen_branch_cond(ctx, TCG_COND_EQ, cpu_gpr_d[r1], cpu_gpr_d[15],
+                        offset + 16);
+        break;
     case OPC1_16_SBR_JNE:
         gen_branch_cond(ctx, TCG_COND_NE, cpu_gpr_d[r1], cpu_gpr_d[15],
                         offset);
         break;
+    case OPC1_16_SBR_JNE2:
+        gen_branch_cond(ctx, TCG_COND_NE, cpu_gpr_d[r1], cpu_gpr_d[15],
+                        offset + 16);
+        break;
     case OPC1_16_SBR_JNZ:
         gen_branch_condi(ctx, TCG_COND_NE, cpu_gpr_d[r1], 0, offset);
         break;
@@ -4089,6 +4097,10 @@ static void decode_16Bit_opc(CPUTriCoreState *env, DisasContext *ctx)
         gen_offset_ld(ctx, cpu_gpr_d[r1], cpu_gpr_a[15], const16 * 4, MO_LESL);
         break;
 /* SB-format */
+    case OPC1_16_SB_JNE:
+        address = MASK_OP_SBC_DISP4(ctx->opcode);
+        gen_compute_branch(ctx, op1, 0, 0, 0, address);
+        break;
     case OPC1_16_SB_CALL:
     case OPC1_16_SB_J:
     case OPC1_16_SB_JNZ:
@@ -4122,6 +4134,7 @@ static void decode_16Bit_opc(CPUTriCoreState *env, DisasContext *ctx)
         break;
 /* SBR-format */
     case OPC1_16_SBR_JEQ:
+    case OPC1_16_SBR_JEQ2:
     case OPC1_16_SBR_JGEZ:
     case OPC1_16_SBR_JGTZ:
     case OPC1_16_SBR_JLEZ:
@@ -6256,6 +6269,15 @@ static void decode_rr_accumulator(CPUTriCoreState *env, DisasContext *ctx)
             generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
         }
         break;
+    case OPC2_32_RR_MOVS_64:
+        if (tricore_feature(env, TRICORE_FEATURE_16)) {
+            CHECK_REG_PAIR(r3);
+            tcg_gen_mov_tl(cpu_gpr_d[r3], cpu_gpr_d[r2]);
+            tcg_gen_sari_tl(cpu_gpr_d[r3 + 1], cpu_gpr_d[r2], 31);
+        } else {
+            generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
+        }
+        break;
     case OPC2_32_RR_NE:
         tcg_gen_setcond_tl(TCG_COND_NE, cpu_gpr_d[r3], cpu_gpr_d[r1],
                            cpu_gpr_d[r2]);
diff --git a/target/tricore/tricore-opcodes.h b/target/tricore/tricore-opcodes.h
index 08394b8..600785e 100644
--- a/target/tricore/tricore-opcodes.h
+++ b/target/tricore/tricore-opcodes.h
@@ -313,6 +313,7 @@ enum {
     OPC1_16_SBC_JEQ                                  = 0x1e,
     OPC1_16_SBC_JEQ2                                 = 0x9e,
     OPC1_16_SBR_JEQ                                  = 0x3e,
+    OPC1_16_SBR_JEQ2                                 = 0xbe,
     OPC1_16_SBR_JGEZ                                 = 0xce,
     OPC1_16_SBR_JGTZ                                 = 0x4e,
     OPC1_16_SR_JI                                    = 0xdc,
@@ -321,11 +322,13 @@ enum {
     OPC1_16_SBC_JNE                                  = 0x5e,
     OPC1_16_SBC_JNE2                                 = 0xde,
     OPC1_16_SBR_JNE                                  = 0x7e,
+    OPC1_16_SBR_JNE2                                 = 0xfe,
     OPC1_16_SB_JNZ                                   = 0xee,
     OPC1_16_SBR_JNZ                                  = 0xf6,
     OPC1_16_SBR_JNZ_A                                = 0x7c,
     OPC1_16_SBRN_JNZ_T                               = 0xae,
     OPC1_16_SB_JZ                                    = 0x6e,
+    OPC1_16_SB_JNE                                   = 0xfe,
     OPC1_16_SBR_JZ                                   = 0x76,
     OPC1_16_SBR_JZ_A                                 = 0xbc,
     OPC1_16_SBRN_JZ_T                                = 0x2e,
@@ -1064,6 +1067,7 @@ enum {
     OPC2_32_RR_MIN_H                             = 0x78,
     OPC2_32_RR_MIN_HU                            = 0x79,
     OPC2_32_RR_MOV                               = 0x1f,
+    OPC2_32_RR_MOVS_64                           = 0x80,
     OPC2_32_RR_MOV_64                            = 0x81,
     OPC2_32_RR_NE                                = 0x11,
     OPC2_32_RR_OR_EQ                             = 0x27,
-- 
2.7.4
