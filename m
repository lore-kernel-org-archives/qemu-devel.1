Received: from eggs.gnu.org ([2001:4830:134:3::10]:56273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fSKOe-0002TN-UD
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:50:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fSKOa-0000in-N6
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:50:00 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:39581)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fSKOa-0000hz-96
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:49:56 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 11 Jun 2018 12:49:27 +0200
Message-Id: <20180611104935.20499-2-laurent@vivier.eu>
In-Reply-To: <20180611104935.20499-1-laurent@vivier.eu>
References: <20180611104935.20499-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 1/9] target/m68k: Use DISAS_NORETURN for
 exceptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

The raise_exception helper does not return.  Do not generate
any code following that.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20180512050250.12774-2-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/translate.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 4b5dbdb51c..de1be58f65 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -291,18 +291,18 @@ static void gen_jmp(DisasContext *s, TCGv dest)
     s->is_jmp = DISAS_JUMP;
 }
 
-static void gen_raise_exception(int nr)
+static void gen_exception(DisasContext *s, uint32_t dest, int nr)
 {
-    TCGv_i32 tmp = tcg_const_i32(nr);
+    TCGv_i32 tmp;
 
+    update_cc_op(s);
+    tcg_gen_movi_i32(QREG_PC, dest);
+
+    tmp = tcg_const_i32(nr);
     gen_helper_raise_exception(cpu_env, tmp);
     tcg_temp_free_i32(tmp);
-}
 
-static void gen_exception(DisasContext *s, uint32_t where, int nr)
-{
-    gen_jmp_im(s, where);
-    gen_raise_exception(nr);
+    s->is_jmp = DISAS_NORETURN;
 }
 
 static inline void gen_addr_fault(DisasContext *s)
@@ -6106,7 +6106,6 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 
         if (unlikely(cpu_breakpoint_test(cs, dc->pc, BP_ANY))) {
             gen_exception(dc, dc->pc, EXCP_DEBUG);
-            dc->is_jmp = DISAS_JUMP;
             /* The address covered by the breakpoint must be included in
                [tb->pc, tb->pc + tb->size) in order to for it to be
                properly cleared -- thus we increment the PC here so that
@@ -6150,6 +6149,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
             tcg_gen_exit_tb(NULL, 0);
             break;
         case DISAS_TB_JUMP:
+        case DISAS_NORETURN:
             /* nothing more to generate */
             break;
         }
-- 
2.14.4
