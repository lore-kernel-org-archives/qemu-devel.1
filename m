Received: from eggs.gnu.org ([2001:4830:134:3::10]:53234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzHf-0003JY-5Q
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:36:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzHc-0007Gt-1N
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:36:51 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53062)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzHb-0007AA-Om
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:36:47 -0500
Received: by mail-wm1-x341.google.com with SMTP id r11-v6so6742489wmb.2
	for <qemu-devel@nongnu.org>; Sun, 11 Nov 2018 15:36:38 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 12 Nov 2018 00:36:15 +0100
Message-Id: <20181111233622.8976-5-f4bug@amsat.org>
In-Reply-To: <20181111233622.8976-1-f4bug@amsat.org>
References: <20181111233622.8976-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 04/11] target/mips: Avoid access to
 CPUMIPSState from decode* functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peer Adelt <peer.adelt@hni.uni-paderborn.de>, Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>

The DisasContext is already initialized from the CPUMIPSState in
mips_tr_init_disas_context().

Suggested-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index f5e8d0b4d2..e726f3ec00 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16534,7 +16534,7 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
             check_insn(ctx, ASE_MIPS3D);
             /* Fall through */
         do_cp1branch:
-            if (env->CP0_Config1 & (1 << CP0C1_FP)) {
+            if (ctx->CP0_Config1 & (1 << CP0C1_FP)) {
                 check_cp1_enabled(ctx);
                 gen_compute_branch1(ctx, mips32_op,
                                     (ctx->opcode >> 18) & 0x7, imm << 1);
@@ -23809,7 +23809,7 @@ static void decode_opc_special_legacy(CPUMIPSState *env, DisasContext *ctx)
         break;
     case OPC_MOVCI:
         check_insn(ctx, ISA_MIPS4 | ISA_MIPS32);
-        if (env->CP0_Config1 & (1 << CP0C1_FP)) {
+        if (ctx->CP0_Config1 & (1 << CP0C1_FP)) {
             check_cp1_enabled(ctx);
             gen_movci(ctx, rd, rs, (ctx->opcode >> 18) & 0x7,
                       (ctx->opcode >> 16) & 1);
-- 
2.17.2
