Received: from eggs.gnu.org ([2001:4830:134:3::10]:47272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d91NK-0006ZO-4v
	for qemu-devel@nongnu.org; Thu, 11 May 2017 23:36:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d91NJ-0003eV-9I
	for qemu-devel@nongnu.org; Thu, 11 May 2017 23:36:18 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d91NJ-0003eN-30
	for qemu-devel@nongnu.org; Thu, 11 May 2017 23:36:17 -0400
Received: by mail-qt0-x244.google.com with SMTP id a46so5374112qte.0
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 20:36:16 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 12 May 2017 00:35:41 -0300
Message-Id: <20170512033543.6789-4-f4bug@amsat.org>
In-Reply-To: <20170512033543.6789-1-f4bug@amsat.org>
References: <20170512033543.6789-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 3/5] target/m68k: optimize bcd_flags() using
 extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Patch created mechanically using Coccinelle script via:

    $ spatch --macro-file scripts/cocci-macro-file.h --in-place \
        --sp-file scripts/coccinelle/tcg_gen_extract.cocci --dir target

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 9f60fbc0db..babb9e2c5b 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -1463,8 +1463,7 @@ static void bcd_flags(TCGv val)
     tcg_gen_andi_i32(QREG_CC_C, val, 0x0ff);
     tcg_gen_or_i32(QREG_CC_Z, QREG_CC_Z, QREG_CC_C);
 
-    tcg_gen_shri_i32(QREG_CC_C, val, 8);
-    tcg_gen_andi_i32(QREG_CC_C, QREG_CC_C, 1);
+    tcg_gen_extract_i32(QREG_CC_C, val, 8, 1);
 
     tcg_gen_mov_i32(QREG_CC_X, QREG_CC_C);
 }
-- 
2.11.0
