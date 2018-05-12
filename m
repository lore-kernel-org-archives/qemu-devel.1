Received: from eggs.gnu.org ([2001:4830:134:3::10]:60512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHMgN-000415-Uc
	for qemu-devel@nongnu.org; Sat, 12 May 2018 01:03:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHMgK-0008L7-6H
	for qemu-devel@nongnu.org; Sat, 12 May 2018 01:02:59 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:34671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fHMgK-0008L1-08
	for qemu-devel@nongnu.org; Sat, 12 May 2018 01:02:56 -0400
Received: by mail-pl0-x242.google.com with SMTP id ay10-v6so4372966plb.1
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 22:02:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 11 May 2018 22:02:43 -0700
Message-Id: <20180512050250.12774-3-richard.henderson@linaro.org>
In-Reply-To: <20180512050250.12774-1-richard.henderson@linaro.org>
References: <20180512050250.12774-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/9] target/m68k: Replace DISAS_TB_JUMP with
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
Cc: laurent@vivier.eu

We have exited the TB after using goto_tb; there is no
distinction from DISAS_NORETURN.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 86404906e0..6ab24fac0b 100644
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
         tcg_gen_exit_tb(0);
     }
-    s->is_jmp = DISAS_TB_JUMP;
+    s->is_jmp = DISAS_NORETURN;
 }
 
 DISAS_INSN(scc)
@@ -6148,7 +6147,6 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
             /* indicate that the hash table must be used to find the next TB */
             tcg_gen_exit_tb(0);
             break;
-        case DISAS_TB_JUMP:
         case DISAS_NORETURN:
             /* nothing more to generate */
             break;
-- 
2.17.0
