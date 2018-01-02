Received: from eggs.gnu.org ([2001:4830:134:3::10]:52270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWWBL-00071f-DR
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 18:41:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWWBI-00035G-OB
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 18:41:19 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:60778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eWWBI-00034Z-DZ
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 18:41:16 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed,  3 Jan 2018 00:40:53 +0100
Message-Id: <20180102234108.32713-3-laurent@vivier.eu>
In-Reply-To: <20180102234108.32713-1-laurent@vivier.eu>
References: <20180102234108.32713-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v6 02/17] target/m68k: fix gen_get_ccr()
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
