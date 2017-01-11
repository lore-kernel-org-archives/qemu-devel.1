Received: from eggs.gnu.org ([2001:4830:134:3::10]:56989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1cRJEF-0008N6-Jw
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 08:46:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1cRJEA-0005Zo-LP
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 08:46:15 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:51711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1cRJEA-0005YF-F0
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 08:46:10 -0500
Received: from tweenies.uni-paderborn.de ([131.234.189.21]:58362
	helo=localhost.localdomain)
	by mail.uni-paderborn.de with esmtp (Exim 4.84_2 amazonia)
	id 1cRJE8-0007uR-7C
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:46:08 +0100
Received: from mail.uni-paderborn.de by tweenies with queue id 1467563-4
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 13:46:08 GMT
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Wed, 11 Jan 2017 14:45:48 +0100
Message-Id: <20170111134549.32669-5-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20170111134549.32669-1-kbastian@mail.uni-paderborn.de>
References: <20170111134549.32669-1-kbastian@mail.uni-paderborn.de>
Subject: [Qemu-devel] [PULL 4/5] target-tricore: Added new JNE instruction
 variant
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peer Adelt <peer.adelt@c-lab.de>

From: Peer Adelt <peer.adelt@c-lab.de>

If D[15] is != sign_ext(const4) then PC will be set to (PC +
zero_ext(disp4 + 16)).

[BK: fixed style errors]
Signed-off-by: Peer Adelt <peer.adelt@c-lab.de>
Message-Id: <1465314555-11501-5-git-send-email-peer.adelt@c-lab.de>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/translate.c       | 18 ++++++++++++++++++
 target/tricore/tricore-opcodes.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 1cdd87e8fb..9d1ee66b94 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -3362,9 +3362,17 @@ static void gen_compute_branch(DisasContext *ctx, uint32_t opc, int r1,
     case OPC1_16_SBC_JEQ:
         gen_branch_condi(ctx, TCG_COND_EQ, cpu_gpr_d[15], constant, offset);
         break;
+    case OPC1_16_SBC_JEQ2:
+        gen_branch_condi(ctx, TCG_COND_EQ, cpu_gpr_d[15], constant,
+                         offset + 16);
+        break;
     case OPC1_16_SBC_JNE:
         gen_branch_condi(ctx, TCG_COND_NE, cpu_gpr_d[15], constant, offset);
         break;
+    case OPC1_16_SBC_JNE2:
+        gen_branch_condi(ctx, TCG_COND_NE, cpu_gpr_d[15],
+                         constant, offset + 16);
+        break;
 /* SBRN-format jumps */
     case OPC1_16_SBRN_JZ_T:
         temp = tcg_temp_new();
@@ -4097,6 +4105,16 @@ static void decode_16Bit_opc(CPUTriCoreState *env, DisasContext *ctx)
         const16 = MASK_OP_SBC_CONST4_SEXT(ctx->opcode);
         gen_compute_branch(ctx, op1, 0, 0, const16, address);
         break;
+    case OPC1_16_SBC_JEQ2:
+    case OPC1_16_SBC_JNE2:
+        if (tricore_feature(env, TRICORE_FEATURE_16)) {
+            address = MASK_OP_SBC_DISP4(ctx->opcode);
+            const16 = MASK_OP_SBC_CONST4_SEXT(ctx->opcode);
+            gen_compute_branch(ctx, op1, 0, 0, const16, address);
+        } else {
+            generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
+        }
+        break;
 /* SBRN-format */
     case OPC1_16_SBRN_JNZ_T:
     case OPC1_16_SBRN_JZ_T:
diff --git a/target/tricore/tricore-opcodes.h b/target/tricore/tricore-opcodes.h
index 78ba338640..08394b85ac 100644
--- a/target/tricore/tricore-opcodes.h
+++ b/target/tricore/tricore-opcodes.h
@@ -311,6 +311,7 @@ enum {
     OPC1_16_SRR_EQ                                   = 0x3a,
     OPC1_16_SB_J                                     = 0x3c,
     OPC1_16_SBC_JEQ                                  = 0x1e,
+    OPC1_16_SBC_JEQ2                                 = 0x9e,
     OPC1_16_SBR_JEQ                                  = 0x3e,
     OPC1_16_SBR_JGEZ                                 = 0xce,
     OPC1_16_SBR_JGTZ                                 = 0x4e,
@@ -318,6 +319,7 @@ enum {
     OPC1_16_SBR_JLEZ                                 = 0x8e,
     OPC1_16_SBR_JLTZ                                 = 0x0e,
     OPC1_16_SBC_JNE                                  = 0x5e,
+    OPC1_16_SBC_JNE2                                 = 0xde,
     OPC1_16_SBR_JNE                                  = 0x7e,
     OPC1_16_SB_JNZ                                   = 0xee,
     OPC1_16_SBR_JNZ                                  = 0xf6,
-- 
2.11.0
