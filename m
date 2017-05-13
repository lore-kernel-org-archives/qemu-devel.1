Received: from eggs.gnu.org ([2001:4830:134:3::10]:37117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d9TQC-0005Av-0a
	for qemu-devel@nongnu.org; Sat, 13 May 2017 05:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d9TQA-0001LK-Nk
	for qemu-devel@nongnu.org; Sat, 13 May 2017 05:33:07 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:43798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d9TQA-0001HJ-GS
	for qemu-devel@nongnu.org; Sat, 13 May 2017 05:33:06 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sat, 13 May 2017 11:32:41 +0200
Message-Id: <20170513093248.18230-9-aurelien@aurel32.net>
In-Reply-To: <20170513093248.18230-1-aurelien@aurel32.net>
References: <20170513093248.18230-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/15] target/sh4: fold ctx->bstate = BS_BRANCH
 into gen_conditional_jump
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 8cee7d333f..a4c7a0895b 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -279,6 +279,7 @@ static void gen_conditional_jump(DisasContext * ctx,
     gen_goto_tb(ctx, 0, ifnott);
     gen_set_label(l1);
     gen_goto_tb(ctx, 1, ift);
+    ctx->bstate = BS_BRANCH;
 }
 
 /* Delayed conditional jump (bt or bf) */
@@ -1158,9 +1159,7 @@ static void _decode_opc(DisasContext * ctx)
 	return;
     case 0x8b00:		/* bf label */
 	CHECK_NOT_DELAY_SLOT
-	    gen_conditional_jump(ctx, ctx->pc + 2,
-				 ctx->pc + 4 + B7_0s * 2);
-	ctx->bstate = BS_BRANCH;
+        gen_conditional_jump(ctx, ctx->pc + 2, ctx->pc + 4 + B7_0s * 2);
 	return;
     case 0x8f00:		/* bf/s label */
 	CHECK_NOT_DELAY_SLOT
@@ -1170,9 +1169,7 @@ static void _decode_opc(DisasContext * ctx)
 	return;
     case 0x8900:		/* bt label */
 	CHECK_NOT_DELAY_SLOT
-	    gen_conditional_jump(ctx, ctx->pc + 4 + B7_0s * 2,
-				 ctx->pc + 2);
-	ctx->bstate = BS_BRANCH;
+        gen_conditional_jump(ctx, ctx->pc + 4 + B7_0s * 2, ctx->pc + 2);
 	return;
     case 0x8d00:		/* bt/s label */
 	CHECK_NOT_DELAY_SLOT
-- 
2.11.0
