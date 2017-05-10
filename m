Received: from eggs.gnu.org ([2001:4830:134:3::10]:32966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8Xs1-00086g-TG
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:06:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8Xry-0006NU-Id
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:06:01 -0400
Received: from mail-qt0-x22b.google.com ([2607:f8b0:400d:c0d::22b]:34959)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8Xry-0006NL-CU
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:05:58 -0400
Received: by mail-qt0-x22b.google.com with SMTP id n4so1646360qte.2
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 13:05:58 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 10 May 2017 17:05:27 -0300
Message-Id: <20170510200535.13268-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/8] optimize various tcg_gen() functions using
 extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

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

Philippe Mathieu-Daudé (8):
  coccinelle: add a script to optimize tcg op using tcg_gen_extract()
  target/arm: optimize smul_dual() and neon_trn_u8() using extract op
  target/arm: optimize rev16() using extract op
  target/cris: optimize gen_swapb() using extract op
  target/m68k: optimize bcd_flags() using extract op
  target/mips: optimize bshfl() using extract op
  target/ppc: using various functions using extract op
  target/sparc: optimize various functions using extract op

 scripts/coccinelle/tcg_gen_extract.cocci | 26 ++++++++++++++++++++++++++
 target/arm/translate-a64.c               |  6 ++----
 target/arm/translate.c                   |  6 ++----
 target/cris/translate.c                  |  3 +--
 target/m68k/translate.c                  |  3 +--
 target/mips/translate.c                  |  9 +++------
 target/ppc/translate.c                   |  9 +++------
 target/ppc/translate/vsx-impl.inc.c      | 21 +++++++--------------
 target/sparc/translate.c                 | 15 +++++----------
 9 files changed, 50 insertions(+), 48 deletions(-)
 create mode 100644 scripts/coccinelle/tcg_gen_extract.cocci

-- 
2.11.0
