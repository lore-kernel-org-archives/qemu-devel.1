Received: from eggs.gnu.org ([2001:4830:134:3::10]:33256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXyVe-0008Eb-VN
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 19:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXyVe-0006lH-38
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 19:36:02 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXyVd-0006kp-Lj
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 19:36:02 -0400
Received: by mail-qt0-x241.google.com with SMTP id 19so1789632qty.1
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 16:36:01 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 19 Jul 2017 13:34:49 -1000
Message-Id: <20170719233455.8740-9-rth@twiddle.net>
In-Reply-To: <20170719233455.8740-1-rth@twiddle.net>
References: <20170719233455.8740-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 08/14] target/m68k: optimize bcd_flags()
 using extract op
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

Done with the Coccinelle semantic patch
scripts/coccinelle/tcg_gen_extract.cocci.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Message-Id: <20170718045540.16322-5-f4bug@amsat.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/m68k/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 3a519b790d..e709e6cde2 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -1749,8 +1749,7 @@ static void bcd_flags(TCGv val)
     tcg_gen_andi_i32(QREG_CC_C, val, 0x0ff);
     tcg_gen_or_i32(QREG_CC_Z, QREG_CC_Z, QREG_CC_C);
 
-    tcg_gen_shri_i32(QREG_CC_C, val, 8);
-    tcg_gen_andi_i32(QREG_CC_C, QREG_CC_C, 1);
+    tcg_gen_extract_i32(QREG_CC_C, val, 8, 1);
 
     tcg_gen_mov_i32(QREG_CC_X, QREG_CC_C);
 }
-- 
2.13.3
