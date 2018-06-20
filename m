Received: from eggs.gnu.org ([2001:4830:134:3::10]:35106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbum-0003c0-Lk
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:08:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbui-00047v-LQ
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:08:44 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:33913)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Yongbok.Kim@mips.com>)
	id 1fVbui-00046D-EO
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:08:40 -0400
From: Yongbok Kim <yongbok.kim@mips.com>
Date: Wed, 20 Jun 2018 13:05:52 +0100
Message-ID: <20180620120620.12806-8-yongbok.kim@mips.com>
In-Reply-To: <20180620120620.12806-1-yongbok.kim@mips.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 07/35] target/mips: Add nanoMIPS save and
 restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, Aleksandar.Markovic@mips.com, James.Hogan@mips.com, Paul.Burton@mips.com, Matthew.Fortune@mips.com, Stefan.Markovic@mips.com

From: Matthew Fortune <matthew.fortune@imgtec.com>

Add nanoMIPS save and restore instructions

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
---
 target/mips/translate.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index c1a98da..4ce80bf 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16232,6 +16232,66 @@ static int mmreg4z_nanomips(int r)
     return map[r & 0xf];
 }
 
+static void gen_adjust_sp(DisasContext *ctx, int u)
+{
+    TCGv tsp = tcg_temp_new();
+    gen_base_offset_addr(ctx, tsp, 29, u);
+    gen_store_gpr(tsp, 29);
+    tcg_temp_free(tsp);
+}
+
+static void gen_save(DisasContext *ctx, uint8_t rt, uint8_t count,
+                     uint8_t gp, uint16_t u)
+{
+    int counter = 0;
+    TCGv va = tcg_temp_new();
+    TCGv t0 = tcg_temp_new();
+    /* fprintf(stderr, "save %d, %d, %d, %d\n", rt, count, gp, u); */
+
+    while (counter != count) {
+        bool use_gp = gp && (counter == count - 1);
+        int this_rt = use_gp ? 28 : (rt & 0x10) | ((rt + counter) & 0x1f);
+        int this_offset = -((counter + 1) << 2);
+        gen_base_offset_addr(ctx, va, 29, this_offset);
+        gen_load_gpr(t0, this_rt);
+        tcg_gen_qemu_st_tl(t0, va, ctx->mem_idx, MO_TEUL |
+                                   ctx->default_tcg_memop_mask);
+        counter++;
+    }
+
+    /* adjust stack pointer */
+    gen_adjust_sp(ctx, -u);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(va);
+}
+
+static void gen_restore(DisasContext *ctx, uint8_t rt, uint8_t count,
+                        uint8_t gp, uint16_t u)
+{
+    int counter = 0;
+    TCGv va = tcg_temp_new();
+    TCGv t0 = tcg_temp_new();
+
+    while (counter != count) {
+        bool use_gp = gp && (counter == count - 1);
+        int this_rt = use_gp ? 28 : (rt & 0x10) | ((rt + counter) & 0x1f);
+        int this_offset = u - ((counter + 1) << 2);
+        gen_base_offset_addr(ctx, va, 29, this_offset);
+        tcg_gen_qemu_ld_tl(t0, va, ctx->mem_idx, MO_TESL |
+                        ctx->default_tcg_memop_mask);
+        tcg_gen_ext32s_tl(t0, t0);
+        gen_store_gpr(t0, this_rt);
+        counter++;
+    }
+
+    /* adjust stack pointer */
+    gen_adjust_sp(ctx, u);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(va);
+}
+
 static void gen_pool16c_nanomips_insn(DisasContext *ctx)
 {
     int rt = mmreg_nanomips(uMIPS_RD(ctx->opcode));
@@ -16576,6 +16636,20 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case NM_P16_SR:
+    {
+        int count = extract32(ctx->opcode, 0, 4);
+        int u = extract32(ctx->opcode, 4, 4) << 4;
+        int rt = 30 + ((ctx->opcode >> 9) & 1);
+        switch ((ctx->opcode >> 8) & 1) {
+        case NM_SAVE16:
+            gen_save(ctx, rt, count, 0, u);
+            break;
+        case NM_RESTORE_JRC16:
+            gen_restore(ctx, rt, count, 0, u);
+            gen_compute_branch(ctx, OPC_JR, 2, 31, 0, 0, 0);
+            break;
+        }
+    }
         break;
     case NM_MOVEP:
     case NM_MOVEPREV:
-- 
1.9.1
