Received: from eggs.gnu.org ([2001:4830:134:3::10]:56992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1cRJEF-0008N8-Ks
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 08:46:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1cRJEA-0005aB-Ph
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 08:46:15 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:52615)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1cRJEA-0005Xq-JP
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 08:46:10 -0500
Received: from wormulon.uni-paderborn.de ([131.234.189.22]:49684
	helo=localhost.localdomain)
	by mail.uni-paderborn.de with esmtp (Exim 4.84_2 nylar)
	id 1cRJE8-0001FI-N5
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:46:08 +0100
Received: from mail.uni-paderborn.de by wormulon with queue id 1475635-5
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 13:46:07 GMT
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Wed, 11 Jan 2017 14:45:47 +0100
Message-Id: <20170111134549.32669-4-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20170111134549.32669-1-kbastian@mail.uni-paderborn.de>
References: <20170111134549.32669-1-kbastian@mail.uni-paderborn.de>
Subject: [Qemu-devel] [PULL 3/5] target-tricore: Added new MOV instruction
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

Puts the content of data register D[a] into E[c][63:32] and the
content of data register D[b] into E[c][31:0].

[BK: fix style error]
[BK: Allocate temporaries only when needed]
Signed-off-by: Peer Adelt <peer.adelt@c-lab.de>
Message-Id: <1465314555-11501-4-git-send-email-peer.adelt@c-lab.de>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/translate.c       | 16 ++++++++++++++++
 target/tricore/tricore-opcodes.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index a8234dba83..1cdd87e8fb 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -6034,6 +6034,8 @@ static void decode_rr_accumulator(CPUTriCoreState *env, DisasContext *ctx)
     uint32_t op2;
     int r3, r2, r1;
 
+    TCGv temp;
+
     r3 = MASK_OP_RR_D(ctx->opcode);
     r2 = MASK_OP_RR_S2(ctx->opcode);
     r1 = MASK_OP_RR_S1(ctx->opcode);
@@ -6224,6 +6226,20 @@ static void decode_rr_accumulator(CPUTriCoreState *env, DisasContext *ctx)
     case OPC2_32_RR_MOV:
         tcg_gen_mov_tl(cpu_gpr_d[r3], cpu_gpr_d[r2]);
         break;
+    case OPC2_32_RR_MOV_64:
+        if (tricore_feature(env, TRICORE_FEATURE_16)) {
+            temp = tcg_temp_new();
+
+            CHECK_REG_PAIR(r3);
+            tcg_gen_mov_tl(temp, cpu_gpr_d[r1]);
+            tcg_gen_mov_tl(cpu_gpr_d[r3], cpu_gpr_d[r2]);
+            tcg_gen_mov_tl(cpu_gpr_d[r3 + 1], temp);
+
+            tcg_temp_free(temp);
+        } else {
+            generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
+        }
+        break;
     case OPC2_32_RR_NE:
         tcg_gen_setcond_tl(TCG_COND_NE, cpu_gpr_d[r3], cpu_gpr_d[r1],
                            cpu_gpr_d[r2]);
diff --git a/target/tricore/tricore-opcodes.h b/target/tricore/tricore-opcodes.h
index df666b081f..78ba338640 100644
--- a/target/tricore/tricore-opcodes.h
+++ b/target/tricore/tricore-opcodes.h
@@ -1062,6 +1062,7 @@ enum {
     OPC2_32_RR_MIN_H                             = 0x78,
     OPC2_32_RR_MIN_HU                            = 0x79,
     OPC2_32_RR_MOV                               = 0x1f,
+    OPC2_32_RR_MOV_64                            = 0x81,
     OPC2_32_RR_NE                                = 0x11,
     OPC2_32_RR_OR_EQ                             = 0x27,
     OPC2_32_RR_OR_GE                             = 0x2b,
-- 
2.11.0
