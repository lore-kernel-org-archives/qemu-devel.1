Received: from eggs.gnu.org ([2001:4830:134:3::10]:44818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9K9H-0008Pr-2c
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:39:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9K9G-0002XJ-AM
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:39:03 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9K9G-0002WW-6A
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:39:02 -0400
Received: by mail-qt0-x243.google.com with SMTP id a46so8697242qte.0
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 16:39:02 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 12 May 2017 20:38:39 -0300
Message-Id: <20170512233843.27713-3-f4bug@amsat.org>
In-Reply-To: <20170512233843.27713-1-f4bug@amsat.org>
References: <20170512233843.27713-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 2/6] target/alpha: optimize cvtlq() using
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
---
 target/alpha/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index df5d695344..531af4f5b8 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -747,9 +747,8 @@ static void gen_cvtlq(TCGv vc, TCGv vb)
     /* The arithmetic right shift here, plus the sign-extended mask below
        yields a sign-extended result without an explicit ext32s_i64.  */
     tcg_gen_sari_i64(tmp, vb, 32);
-    tcg_gen_shri_i64(vc, vb, 29);
+    tcg_gen_extract_i64(vc, vb, 29, 30);
     tcg_gen_andi_i64(tmp, tmp, (int32_t)0xc0000000);
-    tcg_gen_andi_i64(vc, vc, 0x3fffffff);
     tcg_gen_or_i64(vc, vc, tmp);
 
     tcg_temp_free(tmp);
-- 
2.11.0
