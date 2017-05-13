Received: from eggs.gnu.org ([2001:4830:134:3::10]:37116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d9TQB-0005Au-WA
	for qemu-devel@nongnu.org; Sat, 13 May 2017 05:33:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d9TQA-0001L8-MO
	for qemu-devel@nongnu.org; Sat, 13 May 2017 05:33:07 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:43756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d9TQA-0001H8-GS
	for qemu-devel@nongnu.org; Sat, 13 May 2017 05:33:06 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sat, 13 May 2017 11:32:44 +0200
Message-Id: <20170513093248.18230-12-aurelien@aurel32.net>
In-Reply-To: <20170513093248.18230-1-aurelien@aurel32.net>
References: <20170513093248.18230-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/15] target/sh4: generate fences for SH4
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

synco is a SH4-A only instruction.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 7a504a7f5a..d61b176a7d 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1569,10 +1569,11 @@ static void _decode_opc(DisasContext * ctx)
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
