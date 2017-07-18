Received: from eggs.gnu.org ([2001:4830:134:3::10]:43125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXKY5-0004UE-8E
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXKY2-00048H-6W
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:55:53 -0400
Received: from mail-qt0-x22c.google.com ([2607:f8b0:400d:c0d::22c]:36680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXKY2-00047v-2Q
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:55:50 -0400
Received: by mail-qt0-x22c.google.com with SMTP id 21so7305526qtx.3
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 21:55:48 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Jul 2017 01:55:30 -0300
Message-Id: <20170718045540.16322-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 00/10] optimize various tcg_gen() functions
 using extract/deposit op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Laurent Vivier <laurent@vivier.eu>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Hi Richard,

Please find here the update series. Maybe you'll need to update the commit sha-1
58daf05d07dd in commits 3-8.

Regards,

Phil.

[v5]

- gitignore entries for cocci generated files
- cleaned/improved cocci script, updated usage
- fix output using Mersenne "number" instead of "prime" (Eric Blake)
- use deposit() on alpha and sparc (Richard Henderson)
- enable tci bswap16_i64()

[v4]

Tried to fix wrong previous attempt...
After getting some nice/fast pieces of advice from Coccinelle folks, I tried to
improved the script (not much inline documentation yet although).
- correctly check if this optimizable?
- document as Mersenne number instead of prime (Eric Blake)
- try to write Python code instead of BASIC (Markus Elfring advices)
- try to reduce regex usage
- try to match shri(); unrelated(); andi(); pattern to optimize, I was surprised
  to see the alpha diff Coccinelle found.

This is surely not the last version of this patchset, but I think now the
generated patches are correct and I prefer reviewers to look at them fixed
instead of wrong one in the ML.
Still lot of work to do in the cocci script, now it seems to hang trying to
parse "target/arm/translate.c".

[v3]

In my first attempt I misunderstood tcg_gen_extract() intrinsics, and Richard
Henderson pointed that out.
In this patchset the cocci script is corrected and clarified, it also print how
arguments are checked while running.
Also:
- incorrect patches have been removed. (Richard Henderson, Nikunj A Dadhania)
- Coccinelle script licensed GPLv2+ (Eric Blake)
- comment in each commit about how to apply the patch (Eric Blake)
- added Acked-by for m68k (Laurent Vivier)
- Cc: Coccinelle developers.

[v2]

Resent the cocci script.
 
[v1]

While reviewing a commit from Aurelien Jarno where he optimized a TCG generator
for SH-4 [1] I found the same optimization done on PPC by Nikunj A Dadhania few
months ago [2].
After asking on the ML about a cocci script [3] I thought it would be easier to
learn about Coccinelle.

citing Aurelien Jarno:
    This doesn't change the generated code on x86, but optimizes it on most
    RISC architectures and makes the code simpler to read.

I actually applied the script using the following command:

$ docker run -v `pwd`:`pwd` -w `pwd` petersenna/coccinelle \
    --sp-file scripts/coccinelle/tcg_gen_extract.cocci \
    --macro-file scripts/cocci-macro-file.h \
    --dir target \
    --in-place

Please review again! thanks.

[1] http://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg01466.html
[2] http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg05211.html
[3] http://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg01499.html

Philippe Mathieu-Daudé (10):
  coccinelle: ignore ASTs pre-parsed cached C files
  coccinelle: add a script to optimize tcg op using tcg_gen_extract()
  target/arm: optimize aarch64 rev16() using extract op
  target/m68k: optimize bcd_flags() using extract op
  target/ppc: optimize various functions using extract op
  target/sparc: optimize various functions using extract op
  target/sparc: optimize gen_op_mulscc() using extract op
  target/sparc: optimize gen_op_mulscc() using deposit op
  target/alpha: optimize gen_cvtlq() using extract op
  tcg/tci: enable bswap16_i64

 .gitignore                               |   2 +
 scripts/coccinelle/tcg_gen_extract.cocci | 107 +++++++++++++++++++++++++++++++
 target/alpha/translate.c                 |   8 +--
 target/arm/translate-a64.c               |   6 +-
 target/m68k/translate.c                  |   3 +-
 target/ppc/translate.c                   |  21 ++----
 target/ppc/translate/vsx-impl.inc.c      |  24 +++----
 target/sparc/translate.c                 |  20 ++----
 tcg/tci.c                                |   1 -
 9 files changed, 136 insertions(+), 56 deletions(-)
 create mode 100644 scripts/coccinelle/tcg_gen_extract.cocci

-- 
2.13.2
