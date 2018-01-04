Received: from eggs.gnu.org ([2001:4830:134:3::10]:55306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eX8bb-0007YZ-42
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:43:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eX8bX-0003Vi-UA
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:42:59 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:56586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eX8bX-0003Th-I7
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:42:55 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  4 Jan 2018 17:42:36 +0100
Message-Id: <20180104164251.26494-3-laurent@vivier.eu>
In-Reply-To: <20180104164251.26494-1-laurent@vivier.eu>
References: <20180104164251.26494-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 02/17] target/m68k: fix gen_get_ccr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

As gen_helper_get_ccr() is able to compute CCR from cc_op and
flags, we don't need to flush flags before to call it.
flush_flags() and get_ccr() use COMPUTE_CCR() to compute
flags. get_ccr() computes CCR value,
whereas flush_flags update live cc_op and flags.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20180104012913.30763-3-laurent@vivier.eu>
---
 target/m68k/translate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 0e9d651a2a..1e9fb01252 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -2478,7 +2478,6 @@ static TCGv gen_get_ccr(DisasContext *s)
 {
     TCGv dest;
 
-    gen_flush_flags(s);
     update_cc_op(s);
     dest = tcg_temp_new();
     gen_helper_get_ccr(dest, cpu_env);
-- 
2.14.3
