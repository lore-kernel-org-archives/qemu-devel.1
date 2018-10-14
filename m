Received: from eggs.gnu.org ([2001:4830:134:3::10]:50122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBhOq-000262-GE
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 10:29:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBhOn-0006dU-CG
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 10:29:44 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:45917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBhOn-0006co-5E
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 10:29:41 -0400
Received: by mail-wr1-x431.google.com with SMTP id q5-v6so18281652wrw.12
	for <qemu-devel@nongnu.org>; Sun, 14 Oct 2018 07:29:40 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 14 Oct 2018 16:29:27 +0200
Message-Id: <20181014142928.2784-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] target/mips: Support Toshiba specific
 three-operand MADD and MADDU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Maciej W . Rozycki" <macro@linux-mips.org>, Fredrik Noring <noring@nocrew.org>, Richard Henderson <richard.henderson@linaro.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?J=C3=BCrgen=20Urban?= <JuergenUrban@gmx.de>

The three-operand MADD and MADDU are specific to the
Toshiba TX19/TX39/TX79 cores.

The "32-Bit TX System RISC TX39 Family Architecture manual"
is available at https://wiki.qemu.org/File:DSAE0022432.pdf

Signed-off-by: Philippe Mathieu-Daudé<f4bug@amsat.org>
---
Based-on: 540683755a2357b670b107a29658531466be18f4.1539428198.git.noring@nocrew.org
"target/mips: Limited support for the R5900" from Fredrik Noring:
https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02731.html

 target/mips/translate.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 2d5c0a8173..4b3168961c 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -3843,6 +3843,46 @@ static void gen_mul_txx9(DisasContext *ctx, uint32_t opc,
             tcg_temp_free_i32(t3);
         }
         break;
+    case OPC_MADD:
+        {
+            TCGv_i64 t2 = tcg_temp_new_i64();
+            TCGv_i64 t3 = tcg_temp_new_i64();
+
+            tcg_gen_ext_tl_i64(t2, t0);
+            tcg_gen_ext_tl_i64(t3, t1);
+            tcg_gen_mul_i64(t2, t2, t3);
+            tcg_gen_concat_tl_i64(t3, cpu_LO[acc], cpu_HI[acc]);
+            tcg_gen_add_i64(t2, t2, t3);
+            tcg_temp_free_i64(t3);
+            gen_move_low32(cpu_LO[acc], t2);
+            gen_move_high32(cpu_HI[acc], t2);
+            if (rd) {
+                gen_move_low32(cpu_gpr[rd], t2);
+            }
+            tcg_temp_free_i64(t2);
+        }
+        break;
+    case OPC_MADDU:
+        {
+            TCGv_i64 t2 = tcg_temp_new_i64();
+            TCGv_i64 t3 = tcg_temp_new_i64();
+
+            tcg_gen_ext32u_tl(t0, t0);
+            tcg_gen_ext32u_tl(t1, t1);
+            tcg_gen_extu_tl_i64(t2, t0);
+            tcg_gen_extu_tl_i64(t3, t1);
+            tcg_gen_mul_i64(t2, t2, t3);
+            tcg_gen_concat_tl_i64(t3, cpu_LO[acc], cpu_HI[acc]);
+            tcg_gen_add_i64(t2, t2, t3);
+            tcg_temp_free_i64(t3);
+            gen_move_low32(cpu_LO[acc], t2);
+            gen_move_high32(cpu_HI[acc], t2);
+            if (rd) {
+                gen_move_low32(cpu_gpr[rd], t2);
+            }
+            tcg_temp_free_i64(t2);
+        }
+        break;
     default:
         MIPS_INVAL("mul TXx9");
         generate_exception_end(ctx, EXCP_RI);
-- 
2.17.1
