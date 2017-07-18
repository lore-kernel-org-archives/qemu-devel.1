Received: from eggs.gnu.org ([2001:4830:134:3::10]:48662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaPm-0005lI-VY
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaPk-00041Q-J5
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:22 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:48442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dXaOY-0003Uz-2w
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:20 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue, 18 Jul 2017 23:50:48 +0200
Message-Id: <20170718215050.3812-30-aurelien@aurel32.net>
In-Reply-To: <20170718215050.3812-1-aurelien@aurel32.net>
References: <20170718215050.3812-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PULL 29/31] target/sh4: Add missing FPSCR.PR == 0
 checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>

From: Richard Henderson <rth@twiddle.net>

Both frchg and fschg require PR == 0, otherwise undefined_operation.

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-Id: <20170718200255.31647-26-rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 1ed0349374..92a2c002fc 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -473,10 +473,12 @@ static void _decode_opc(DisasContext * ctx)
         tcg_gen_movi_i32(cpu_sr_t, 1);
 	return;
     case 0xfbfd:		/* frchg */
+        CHECK_FPSCR_PR_0
 	tcg_gen_xori_i32(cpu_fpscr, cpu_fpscr, FPSCR_FR);
 	ctx->bstate = BS_STOP;
 	return;
     case 0xf3fd:		/* fschg */
+        CHECK_FPSCR_PR_0
         tcg_gen_xori_i32(cpu_fpscr, cpu_fpscr, FPSCR_SZ);
 	ctx->bstate = BS_STOP;
 	return;
-- 
2.11.0
