Received: from eggs.gnu.org ([2001:4830:134:3::10]:50104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYjW-0006sQ-EZ
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYjR-000557-VV
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:38 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXYjR-00054n-RJ
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:33 -0400
Received: by mail-qt0-x243.google.com with SMTP id l55so3659100qtl.3
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 13:04:33 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 10:02:50 -1000
Message-Id: <20170718200255.31647-26-rth@twiddle.net>
In-Reply-To: <20170718200255.31647-1-rth@twiddle.net>
References: <20170718200255.31647-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v3 25/30] target/sh4: Add missing FPSCR.PR == 0
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
Cc: aurelien@aurel32.net

Both frchg and fschg require PR == 0, otherwise undefined_operation.

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sh4/translate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 65cc7d1..a5d07a0 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -479,10 +479,12 @@ static void _decode_opc(DisasContext * ctx)
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
2.9.4
