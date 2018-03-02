Received: from eggs.gnu.org ([2001:4830:134:3::10]:56405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1erjK2-0001oF-Ol
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:57:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1erjJy-0001zW-ON
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:57:58 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:46788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1erjJy-0001xu-Dh
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:57:54 -0500
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Fri,  2 Mar 2018 12:57:40 +0100
Message-Id: <20180302115743.3409-2-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20180302115743.3409-1-kbastian@mail.uni-paderborn.de>
References: <20180302115743.3409-1-kbastian@mail.uni-paderborn.de>
Subject: [Qemu-devel] [PULL 1/4] target/tricore: added JNE/JEQ/MOV variant
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, David Brenken <david.brenken@efs-auto.de>, Florian Artmeier <florian.artmeier@efs-auto.de>, Georg Hofstetter <georg.hofstetter@efs-auto.de>

From: David Brenken <david.brenken@efs-auto.de>

Signed-off-by: David Brenken <david.brenken@efs-auto.de>
Signed-off-by: Florian Artmeier <florian.artmeier@efs-auto.de>
Signed-off-by: Georg Hofstetter <georg.hofstetter@efs-auto.de>
Message-Id: <20180301155619.8640-2-david.brenken@efs-auto.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
[BK: Fixed commit message, to reflect which insn were added]
---
 target/tricore/translate.c       | 27 +++++++++++++++++++++++++++
 target/tricore/tricore-opcodes.h |  3 +++
 2 files changed, 30 insertions(+)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 4e5b083665..54de0dd346 100644
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
@@ -4121,6 +4129,16 @@ static void decode_16Bit_opc(CPUTriCoreState *env, DisasContext *ctx)
         gen_compute_branch(ctx, op1, 0, 0, const16, address);
         break;
 /* SBR-format */
+    case OPC1_16_SBR_JEQ2:
+    case OPC1_16_SBR_JNE2:
+        if (tricore_feature(env, TRICORE_FEATURE_16)) {
+            r1 = MASK_OP_SBR_S2(ctx->opcode);
+            address = MASK_OP_SBR_DISP4(ctx->opcode);
+            gen_compute_branch(ctx, op1, r1, 0, 0, address);
+        } else {
+            generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
+        }
+        break;
     case OPC1_16_SBR_JEQ:
     case OPC1_16_SBR_JGEZ:
     case OPC1_16_SBR_JGTZ:
@@ -6256,6 +6274,15 @@ static void decode_rr_accumulator(CPUTriCoreState *env, DisasContext *ctx)
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
index 08394b85ac..2c3baab694 100644
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
@@ -321,6 +322,7 @@ enum {
     OPC1_16_SBC_JNE                                  = 0x5e,
     OPC1_16_SBC_JNE2                                 = 0xde,
     OPC1_16_SBR_JNE                                  = 0x7e,
+    OPC1_16_SBR_JNE2                                 = 0xfe,
     OPC1_16_SB_JNZ                                   = 0xee,
     OPC1_16_SBR_JNZ                                  = 0xf6,
     OPC1_16_SBR_JNZ_A                                = 0x7c,
@@ -1064,6 +1066,7 @@ enum {
     OPC2_32_RR_MIN_H                             = 0x78,
     OPC2_32_RR_MIN_HU                            = 0x79,
     OPC2_32_RR_MOV                               = 0x1f,
+    OPC2_32_RR_MOVS_64                           = 0x80,
     OPC2_32_RR_MOV_64                            = 0x81,
     OPC2_32_RR_NE                                = 0x11,
     OPC2_32_RR_OR_EQ                             = 0x27,
-- 
2.16.2
