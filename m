Received: from eggs.gnu.org ([2001:4830:134:3::10]:52580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fudfg-0006gP-4p
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:04:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fudfZ-0006Yi-Oo
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:04:35 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:59075)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fudfY-0006Ry-7Y
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:04:29 -0400
From: Craig Janeczek <jancraig@amazon.com>
Date: Tue, 28 Aug 2018 09:00:41 -0400
Message-Id: <20180828130041.26445-9-jancraig@amazon.com>
In-Reply-To: <20180828130041.26445-1-jancraig@amazon.com>
References: <20180828130041.26445-1-jancraig@amazon.com>
Subject: [Qemu-devel] [PATCH v3 8/8] target/mips: Add MXU instructions
 S32LDD and S32LDDR
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

Adds support for emulating the S32LDD and S32LDDR MXU instructions.

Signed-off-by: Craig Janeczek <jancraig@amazon.com>
---
 v1
    - initial patch
 v2
    - changed bitfield usage to extract32
 v3
    - Split gen_mxu function into command specific gen_mxu_<ins> functions

 target/mips/translate.c | 47 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index a28ea124c2..1ddc9f04e8 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -4123,6 +4123,42 @@ static void gen_mxu_q8mul(DisasContext *ctx, uint32_t opc)
     tcg_temp_free(t7);
 }
 
+/* S32LDD XRa, rb, S12 - Load a word from memory to XRF
+ * S32LDDR XRa, rb, S12 - Load a word from memory to XRF,
+ *                        reversed byte sequence */
+static void gen_mxu_s32ldd(DisasContext *ctx, uint32_t opc)
+{
+    TCGv t0, t1;
+    uint32_t xra, s12, sel, rb;
+
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+
+    xra = extract32(ctx->opcode, 6, 4);
+    s12 = extract32(ctx->opcode, 10, 10);
+    sel = extract32(ctx->opcode, 20, 1);
+    rb = extract32(ctx->opcode, 21, 5);
+
+    gen_load_gpr(t0, rb);
+
+    tcg_gen_movi_tl(t1, s12);
+    tcg_gen_shli_tl(t1, t1, 2);
+    if (s12 & 0x200) {
+        tcg_gen_ori_tl(t1, t1, 0xFFFFF000);
+    }
+    tcg_gen_add_tl(t1, t0, t1);
+    tcg_gen_qemu_ld_tl(t1, t1, ctx->mem_idx, MO_SL);
+
+    if (sel == 1) {
+        /* S32LDDR */
+        tcg_gen_bswap32_tl(t1, t1);
+    }
+    gen_store_mxu_gpr(t1, xra);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+}
+
 /* Godson integer instructions */
 static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
                                  int rd, int rs, int rt)
@@ -18212,7 +18248,6 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
         break;
     case OPC_DIV_G_2F_MXU_S32LDI:
     case OPC_DIVU_G_2F_MXU_S32LDIV:
-    case OPC_MULT_G_2F_MXU_S32LDD:
     case OPC_MULTU_G_2F_MXU_S32LDDV:
     case OPC_MOD_G_2F_MXU_Q8ADDE:
     case OPC_MODU_G_2F:
@@ -18244,6 +18279,16 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
         gen_mxu_q8mul(ctx, op1);
         break;
 
+    case OPC_MULT_G_2F_MXU_S32LDD:
+        /* There is an overlap of opcodes between Loongson2F and MXU */
+        if (ctx->insn_flags & INSN_LOONGSON2F) {
+            check_insn(ctx, INSN_LOONGSON2F);
+            gen_loongson_integer(ctx, op1, rd, rs, rt);
+        } else {
+            gen_mxu_s32ldd(ctx, op1);
+        }
+        break;
+
     case OPC_CLO:
     case OPC_CLZ:
         check_insn(ctx, ISA_MIPS32);
-- 
2.18.0
