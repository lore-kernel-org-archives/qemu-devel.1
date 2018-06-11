Received: from eggs.gnu.org ([2001:4830:134:3::10]:56385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fSKOm-0002bd-OG
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:50:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fSKOg-0000nm-NL
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:50:08 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:55203)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fSKOg-0000m8-AU
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:50:02 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 11 Jun 2018 12:49:30 +0200
Message-Id: <20180611104935.20499-5-laurent@vivier.eu>
In-Reply-To: <20180611104935.20499-1-laurent@vivier.eu>
References: <20180611104935.20499-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 4/9] target/m68k: Use lookup_and_goto_tb for
 DISAS_JUMP
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

These are all indirect or out-of-page direct jumps.
We can indirectly chain to the next TB without going
back to the main loop.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20180512050250.12774-5-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/translate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 6238d9edc9..4b92a20c05 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -6139,8 +6139,11 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
             update_cc_op(dc);
             gen_jmp_tb(dc, 0, dc->pc);
             break;
-        default:
         case DISAS_JUMP:
+            /* We updated CC_OP and PC in gen_jmp/gen_jmp_im.  */
+            tcg_gen_lookup_and_goto_ptr();
+            break;
+        default:
         case DISAS_UPDATE:
             update_cc_op(dc);
             /* indicate that the hash table must be used to find the next TB */
-- 
2.14.4
