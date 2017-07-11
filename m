Received: from eggs.gnu.org ([2001:4830:134:3::10]:40663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUkPw-0002nD-1I
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 21:56:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUkPt-0001BN-1h
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 21:56:48 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUkPs-0001BD-Rk
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 21:56:44 -0400
Received: by mail-qt0-f195.google.com with SMTP id c20so14973475qte.0
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 18:56:44 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 10 Jul 2017 22:55:24 -0300
Message-Id: <20170711015524.22936-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] util/cacheinfo: add missing include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, Richard Henderson <rth@twiddle.net>, Pranith Kumar <bobby.prani@gmail.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Geert Martin Ijewski <gm.ijewski@web.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

This include was forgotten when splitting cacheinfo.c out of
tcg/ppc/tcg-target.inc.c (see commit b255b2c8).

While compiling on powerpc:

      CC      util/cacheinfo.o
    qemu/util/cacheinfo.c: In function 'arch_cache_info':
    qemu/util/cacheinfo.c:137:33: error: 'AT_ICACHEBSIZE' undeclared (first use in this function)
             *isize = qemu_getauxval(AT_ICACHEBSIZE);
                                     ^
    qemu/util/cacheinfo.c:137:33: note: each undeclared identifier is reported only once for each function it appears in
    qemu/util/cacheinfo.c:140:33: error: 'AT_DCACHEBSIZE' undeclared (first use in this function)
             *dsize = qemu_getauxval(AT_DCACHEBSIZE);
                                     ^
    qemu/rules.mak:66: recipe for target 'util/cacheinfo.o' failed
    make: *** [util/cacheinfo.o] Error 1

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 util/cacheinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/util/cacheinfo.c b/util/cacheinfo.c
index 6253049533..593940f27b 100644
--- a/util/cacheinfo.c
+++ b/util/cacheinfo.c
@@ -129,6 +129,7 @@ static void arch_cache_info(int *isize, int *dsize)
 }
 
 #elif defined(_ARCH_PPC) && defined(__linux__)
+# include "elf.h"
 
 static void arch_cache_info(int *isize, int *dsize)
 {
-- 
2.13.2
