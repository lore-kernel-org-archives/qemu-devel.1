Received: from eggs.gnu.org ([208.118.235.92]:59985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7732fbd28=jancraig@amazon.com>)
	id 1fvSsp-000139-Ug
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7732fbd28=jancraig@amazon.com>)
	id 1fvSiV-00005v-L4
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:34:59 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:46178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=7732fbd28=jancraig@amazon.com>)
	id 1fvSiV-00005b-Ak
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:34:55 -0400
From: Craig Janeczek <jancraig@amazon.com>
Date: Thu, 30 Aug 2018 15:30:19 -0400
Message-Id: <20180830193019.20104-10-jancraig@amazon.com>
In-Reply-To: <20180830193019.20104-1-jancraig@amazon.com>
References: <20180830193019.20104-1-jancraig@amazon.com>
Subject: [Qemu-devel] [PATCH v4 9/9] target/mips: Add MXU instructions
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
 v4
    - Add check for MXUEN

 target/mips/translate.c | 49 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 31c7342261..297f913d36 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -4222,6 +4222,51 @@ static void gen_mxu_q8mul(DisasContext *ctx, uint32_t opc)
     tcg_temp_free(t7);
 }
 
+/* S32LDD XRa, rb, S12 - Load a word from memory to XRF
+ * S32LDDR XRa, rb, S12 - Load a word from memory to XRF,
+ *                        reversed byte sequence */
+static void gen_mxu_s32ldd(DisasContext *ctx, uint32_t opc)
+{
+    TCGv t0, t1;
+    TCGLabel *l0;
+    uint32_t xra, s12, sel, rb;
+
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+
+    l0 = gen_new_label();
+
+    xra = extract32(ctx->opcode, 6, 4);
+    s12 = extract32(ctx->opcode, 10, 10);
+    sel = extract32(ctx->opcode, 20, 1);
+    rb = extract32(ctx->opcode, 21, 5);
+
+    gen_load_mxu_cr(t0);
+    tcg_gen_andi_tl(t0, t0, MXUEN);
+    tcg_gen_brcondi_tl(TCG_COND_NE, t0, MXUEN, l0);
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
+    gen_set_label(l0);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+}
+
 /* Godson integer instructions */
 static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
                                  int rd, int rs, int rt)
@@ -18310,6 +18355,10 @@ static void decode_opc_special2_mxu(CPUMIPSState *env, DisasContext *ctx)
         gen_mxu_q8mul(ctx, op1);
         break;
 
+    case OPC_MXU_S32LDD:
+        gen_mxu_s32ldd(ctx, op1);
+        break;
+
     default:            /* Invalid */
         MIPS_INVAL("special2_mxu");
         generate_exception_end(ctx, EXCP_RI);
-- 
2.18.0
