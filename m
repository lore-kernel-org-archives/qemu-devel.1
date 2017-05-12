Received: from eggs.gnu.org ([2001:4830:134:3::10]:47181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d91N9-0006TD-Mp
	for qemu-devel@nongnu.org; Thu, 11 May 2017 23:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d91N5-0003Yp-Of
	for qemu-devel@nongnu.org; Thu, 11 May 2017 23:36:07 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 12 May 2017 00:35:38 -0300
Message-Id: <20170512033543.6789-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/5] optimize various tcg_gen() functions
 using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Artyom Tarasenko <atar4qemu@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Laurent Vivier <lvivier@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Markus Elfring <elfring@users.sourceforge.net>, Julia Lawall <julia.lawall@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>

Changes from v1:

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

Please review, thanks.

[1] http://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg01466.html
[2] http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg05211.html
[3] http://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg01499.html

Philippe Mathieu-Daudé (5):
  coccinelle: add a script to optimize tcg op using tcg_gen_extract()
  target/arm: optimize rev16() using extract op
  target/m68k: optimize bcd_flags() using extract op
  target/ppc: using various functions using extract op
  target/sparc: optimize various functions using extract op

 scripts/coccinelle/tcg_gen_extract.cocci | 69 ++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c               |  6 +--
 target/m68k/translate.c                  |  3 +-
 target/ppc/translate.c                   |  9 ++---
 target/ppc/translate/vsx-impl.inc.c      | 15 +++----
 target/sparc/translate.c                 | 15 +++----
 6 files changed, 85 insertions(+), 32 deletions(-)
 create mode 100644 scripts/coccinelle/tcg_gen_extract.cocci

-- 
2.11.0
