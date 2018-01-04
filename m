Received: from eggs.gnu.org ([2001:4830:134:3::10]:58326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWuLS-0000pW-7r
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 20:29:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWuLP-00075K-1x
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 20:29:22 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:54394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eWuLO-00071J-O1
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 20:29:18 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  4 Jan 2018 02:28:58 +0100
Message-Id: <20180104012913.30763-3-laurent@vivier.eu>
In-Reply-To: <20180104012913.30763-1-laurent@vivier.eu>
References: <20180104012913.30763-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v7 02/17] target/m68k: fix gen_get_ccr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>

As gen_helper_get_ccr() is able to compute CCR from cc_op and
flags, we don't need to flush flags before to call it.
flush_flags() and get_ccr() use COMPUTE_CCR() to compute
flags. get_ccr() computes CCR value,
whereas flush_flags update live cc_op and flags.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
