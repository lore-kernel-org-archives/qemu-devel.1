Received: from eggs.gnu.org ([2001:4830:134:3::10]:47751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fmSWJ-0000a1-Dt
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 19:33:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fmSWE-0007eS-Dy
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 19:33:07 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fmSWE-0007e6-73
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 19:33:02 -0400
Received: by mail-pg1-x542.google.com with SMTP id z8-v6so5334234pgu.8
	for <qemu-devel@nongnu.org>; Sun, 05 Aug 2018 16:33:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun,  5 Aug 2018 16:32:58 -0700
Message-Id: <20180805233258.31892-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] tcg/optimize: Do not skip default processing
 of dup_vec
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent.desnogues@gmail.com

If we do not opimize away dup_vec, we must mark its output as changed.

Fixes: 170ba88f45b
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index d4ea67e541..5dbe11c3c8 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1094,9 +1094,9 @@ void tcg_optimize(TCGContext *s)
                 tmp = arg_info(op->args[1])->val;
                 tmp = dup_const(TCGOP_VECE(op), tmp);
                 tcg_opt_gen_movi(s, op, op->args[0], tmp);
-                continue;
+                break;
             }
-            break;
+            goto do_default;
 
         CASE_OP_32_64(not):
         CASE_OP_32_64(neg):
-- 
2.17.1
