Received: from eggs.gnu.org ([2001:4830:134:3::10]:59961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHMdX-0007cw-Ua
	for qemu-devel@nongnu.org; Sat, 12 May 2018 01:00:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHMdX-0007Lx-7L
	for qemu-devel@nongnu.org; Sat, 12 May 2018 01:00:04 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:45876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fHMdX-0007Lk-2h
	for qemu-devel@nongnu.org; Sat, 12 May 2018 01:00:03 -0400
Received: by mail-pg0-x243.google.com with SMTP id w3-v6so3243768pgv.12
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 22:00:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 11 May 2018 21:59:45 -0700
Message-Id: <20180512045950.12386-7-richard.henderson@linaro.org>
In-Reply-To: <20180512045950.12386-1-richard.henderson@linaro.org>
References: <20180512045950.12386-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 4/9] target/m68k: Use lookup_and_goto_tb for
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
Cc: laurent@vivier.eu

These are all indirect or out-of-page direct jumps.
We can indirectly chain to the next TB without going
back to the main loop.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index c795d8e64f..80712ed0af 100644
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
2.17.0
