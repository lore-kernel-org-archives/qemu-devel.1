Received: from eggs.gnu.org ([209.51.188.92]:54207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gmGXO-00025B-0l
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:17:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gmGXL-0007fK-Va
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:17:41 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:56777 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gmGXL-0007d8-Lu
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:17:39 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 23 Jan 2019 12:15:58 +0100
Message-Id: <1548242160-16039-8-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1548242160-16039-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1548242160-16039-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 7/9] target/mips: nanoMIPS: Fix branch
 handling
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

From: Stefan Markovic <smarkovic@wavecomp.com>

Fix nanoMIPS branch handling.

Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index aaf7dff..e9b5d1d 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -19758,6 +19758,10 @@ static void gen_compute_imm_branch(DisasContext *ctx, uint32_t opc,
         goto out;
     }
 
+    /* branch completion */
+    clear_branch_hflags(ctx);
+    ctx->base.is_jmp = DISAS_NORETURN;
+
     if (bcond_compute == 0) {
         /* Uncoditional compact branch */
         gen_goto_tb(ctx, 0, ctx->btarget);
@@ -19798,6 +19802,10 @@ static void gen_compute_nanomips_pbalrsc_branch(DisasContext *ctx, int rs,
     tcg_gen_movi_tl(t1, ctx->base.pc_next + 4);
     gen_op_addr_add(ctx, btarget, t1, t0);
 
+    /* branch completion */
+    clear_branch_hflags(ctx);
+    ctx->base.is_jmp = DISAS_NORETURN;
+
     /* unconditional branch to register */
     tcg_gen_mov_tl(cpu_PC, btarget);
     tcg_gen_lookup_and_goto_ptr();
@@ -19936,6 +19944,10 @@ static void gen_compute_compact_branch_nm(DisasContext *ctx, uint32_t opc,
             goto out;
         }
 
+        /* branch completion */
+        clear_branch_hflags(ctx);
+        ctx->base.is_jmp = DISAS_NORETURN;
+
         /* Generating branch here as compact branches don't have delay slot */
         gen_goto_tb(ctx, 1, ctx->btarget);
         gen_set_label(fs);
-- 
2.7.4
