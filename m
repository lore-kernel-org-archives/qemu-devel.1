Received: from eggs.gnu.org ([2001:4830:134:3::10]:50846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d6xff-00030M-Rv
	for qemu-devel@nongnu.org; Sat, 06 May 2017 07:14:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d6xff-0003vh-1R
	for qemu-devel@nongnu.org; Sat, 06 May 2017 07:14:43 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:40006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d6xfe-0003uJ-QO
	for qemu-devel@nongnu.org; Sat, 06 May 2017 07:14:42 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sat,  6 May 2017 13:14:28 +0200
Message-Id: <20170506111431.12548-12-aurelien@aurel32.net>
In-Reply-To: <20170506111431.12548-1-aurelien@aurel32.net>
References: <20170506111431.12548-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 11/14] target/sh4: generate fences for SH4
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

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 8c766eed2a..9fe2e2d4d9 100644
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
