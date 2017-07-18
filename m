Received: from eggs.gnu.org ([2001:4830:134:3::10]:43397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXKYX-0004tV-Rx
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:56:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXKYU-0004QI-S6
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:56:21 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:33108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXKYU-0004Q7-NS
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:56:18 -0400
Received: by mail-qk0-x241.google.com with SMTP id u126so310505qka.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 21:56:18 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Jul 2017 01:55:38 -0300
Message-Id: <20170718045540.16322-9-f4bug@amsat.org>
In-Reply-To: <20170718045540.16322-1-f4bug@amsat.org>
References: <20170718045540.16322-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 08/10] target/sparc: optimize
 gen_op_mulscc() using deposit op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Laurent Vivier <laurent@vivier.eu>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>

Suggested-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/sparc/translate.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 67a83b77cc..a425efb1f1 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -632,11 +632,8 @@ static inline void gen_op_mulscc(TCGv dst, TCGv src1, TCGv src2)
 
     // b2 = T0 & 1;
     // env->y = (b2 << 31) | (env->y >> 1);
-    tcg_gen_andi_tl(r_temp, cpu_cc_src, 0x1);
-    tcg_gen_shli_tl(r_temp, r_temp, 31);
     tcg_gen_extract_tl(t0, cpu_y, 1, 31);
-    tcg_gen_or_tl(t0, t0, r_temp);
-    tcg_gen_andi_tl(cpu_y, t0, 0xffffffff);
+    tcg_gen_deposit_tl(cpu_y, cpu_y, cpu_cc_src, 31, 1);
 
     // b1 = N ^ V;
     gen_mov_reg_N(t0, cpu_psr);
-- 
2.13.2
