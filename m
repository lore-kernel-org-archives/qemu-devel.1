Received: from eggs.gnu.org ([2001:4830:134:3::10]:41663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXh3o-0003gq-N1
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:58:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXh3n-0002EY-Uc
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:58:08 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXh3n-0002EQ-P2
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:58:07 -0400
Received: by mail-pf0-x244.google.com with SMTP id e199so5100500pfh.0
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 21:58:07 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 18:57:19 -1000
Message-Id: <20170719045722.25492-12-rth@twiddle.net>
In-Reply-To: <20170719045722.25492-1-rth@twiddle.net>
References: <20170719045722.25492-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/14] target/sparc: optimize gen_op_mulscc()
 using deposit op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Suggested-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20170718045540.16322-9-f4bug@amsat.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sparc/translate.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 67a83b7..a425efb 100644
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
2.9.4
