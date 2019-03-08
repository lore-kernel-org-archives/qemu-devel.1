Received: from eggs.gnu.org ([209.51.188.92]:57147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h2KiY-0001vS-6E
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:59:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h2KiX-0001kf-Cg
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:59:38 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:44185)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h2KiX-0001jE-4i
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:59:37 -0500
Received: by mail-pf1-x441.google.com with SMTP id a3so14786226pff.11
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 10:59:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  8 Mar 2019 10:59:32 -0800
Message-Id: <20190308185932.4954-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] target/hppa: Check for page crossings in
 use_goto_tb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: svens@stackframe.org

We got away with eliding this check when target/hppa was user-only,
but missed adding this check when adding system support.

Fixes an early crash in the HP-UX 11 installer.

Reported-by: Sven Schnelle <svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index dc5636fe94..6c815e05c2 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -816,12 +816,10 @@ static bool gen_illegal(DisasContext *ctx)
 
 static bool use_goto_tb(DisasContext *ctx, target_ureg dest)
 {
-    /* Suppress goto_tb in the case of single-steping and IO.  */
-    if ((tb_cflags(ctx->base.tb) & CF_LAST_IO)
-        || ctx->base.singlestep_enabled) {
-        return false;
-    }
-    return true;
+    /* Suppress goto_tb for page crossing, IO, or single-steping.  */
+    return !(((ctx->base.pc_first ^ dest) & TARGET_PAGE_MASK)
+             || (tb_cflags(ctx->base.tb) & CF_LAST_IO)
+             || ctx->base.singlestep_enabled);
 }
 
 /* If the next insn is to be nullified, and it's on the same page,
-- 
2.17.2
