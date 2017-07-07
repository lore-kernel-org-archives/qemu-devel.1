Received: from eggs.gnu.org ([2001:4830:134:3::10]:35458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTIxW-00044F-2x
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:25:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTIxV-0001af-9r
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:25:30 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dTIxV-0001aV-5h
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:25:29 -0400
Received: by mail-qk0-x242.google.com with SMTP id p21so2762222qke.0
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 19:25:29 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  6 Jul 2017 16:21:09 -1000
Message-Id: <20170707022111.21836-26-rth@twiddle.net>
In-Reply-To: <20170707022111.21836-1-rth@twiddle.net>
References: <20170707022111.21836-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 25/27] target/sh4: Add missing FPSCR.PR == 0
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
Cc: aurelien@aurel32.net, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

Both frchg and fschg require PR == 0, otherwise undefined_operation.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sh4/translate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 35a5c91..2b62e39 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -485,10 +485,12 @@ static void _decode_opc(DisasContext * ctx)
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
