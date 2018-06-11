Received: from eggs.gnu.org ([2001:4830:134:3::10]:56324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fSKOj-0002WY-GI
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:50:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fSKOf-0000mQ-8v
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:50:05 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:59969)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fSKOe-0000kL-P0
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:50:01 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 11 Jun 2018 12:49:28 +0200
Message-Id: <20180611104935.20499-3-laurent@vivier.eu>
In-Reply-To: <20180611104935.20499-1-laurent@vivier.eu>
References: <20180611104935.20499-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 2/9] target/m68k: Replace DISAS_TB_JUMP with
 DISAS_NORETURN
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

We have exited the TB after using goto_tb; there is no
distinction from DISAS_NORETURN.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20180512050250.12774-3-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/translate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index de1be58f65..bfa30cde0a 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -199,7 +199,6 @@ static void do_writebacks(DisasContext *s)
 /* is_jmp field values */
 #define DISAS_JUMP      DISAS_TARGET_0 /* only pc was modified dynamically */
 #define DISAS_UPDATE    DISAS_TARGET_1 /* cpu state was modified dynamically */
-#define DISAS_TB_JUMP   DISAS_TARGET_2 /* only pc was modified statically */
 #define DISAS_JUMP_NEXT DISAS_TARGET_3
 
 #if defined(CONFIG_USER_ONLY)
@@ -1496,7 +1495,7 @@ static void gen_jmp_tb(DisasContext *s, int n, uint32_t dest)
         gen_jmp_im(s, dest);
         tcg_gen_exit_tb(NULL, 0);
     }
-    s->is_jmp = DISAS_TB_JUMP;
+    s->is_jmp = DISAS_NORETURN;
 }
 
 DISAS_INSN(scc)
@@ -6148,7 +6147,6 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
             /* indicate that the hash table must be used to find the next TB */
             tcg_gen_exit_tb(NULL, 0);
             break;
-        case DISAS_TB_JUMP:
         case DISAS_NORETURN:
             /* nothing more to generate */
             break;
-- 
2.14.4
