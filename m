Received: from eggs.gnu.org ([2001:4830:134:3::10]:45857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d5JX5-0007YO-3d
	for qemu-devel@nongnu.org; Mon, 01 May 2017 18:11:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d5JX3-0004G0-AH
	for qemu-devel@nongnu.org; Mon, 01 May 2017 18:11:03 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:57326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d5JX3-0004Bd-3f
	for qemu-devel@nongnu.org; Mon, 01 May 2017 18:11:01 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue,  2 May 2017 00:10:43 +0200
Message-Id: <20170501221046.9369-12-aurelien@aurel32.net>
In-Reply-To: <20170501221046.9369-1-aurelien@aurel32.net>
References: <20170501221046.9369-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 11/14] target/sh4: generate fences for SH4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

synco is a SH4-A only instruction.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 7de459c9a5..c226be9718 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1570,10 +1570,11 @@ static void _decode_opc(DisasContext * ctx)
 	else
 	    break;
     case 0x00ab:		/* synco */
-	if (ctx->features & SH_FEATURE_SH4A)
-	    return;
-	else
-	    break;
+        if (ctx->features & SH_FEATURE_SH4A) {
+            tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
+            return;
+        }
+        break;
     case 0x4024:		/* rotcl Rn */
 	{
 	    TCGv tmp = tcg_temp_new();
-- 
2.11.0
