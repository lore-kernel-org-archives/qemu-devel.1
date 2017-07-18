Received: from eggs.gnu.org ([2001:4830:134:3::10]:43228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXKYG-0004eV-Pf
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:56:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXKYF-0004Fv-V0
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:56:04 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXKYF-0004Fc-RU
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:56:03 -0400
Received: by mail-qt0-x243.google.com with SMTP id 19so1215808qty.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 21:56:03 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Jul 2017 01:55:34 -0300
Message-Id: <20170718045540.16322-5-f4bug@amsat.org>
In-Reply-To: <20170718045540.16322-1-f4bug@amsat.org>
References: <20170718045540.16322-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 04/10] target/m68k: optimize bcd_flags()
 using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Done with the Coccinelle semantic patch from commit 58daf05d07dd
(see scripts/coccinelle/tcg_gen_extract.cocci)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
Richard: maybe you need to update 58daf05d07dd to your commit...

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
2.13.2
