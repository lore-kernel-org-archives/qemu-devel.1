Received: from eggs.gnu.org ([209.51.188.92]:60984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gil0L-0002Lv-LN
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:01:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gil0K-0002Sc-1E
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:01:05 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:55048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gil0J-0002RR-PM
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:01:03 -0500
Date: Sun, 13 Jan 2019 20:00:59 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <cover.1547403692.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH 0/9] target/mips: Limited support for R5900
 multimedia instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, qemu-devel@nongnu.org

This series introduces limited support for R5900 multimedia instructions
(MMIs) by implementing and testing PCPYLD, PCPYUD, LQ and SQ.

32 128-bit multimedia registers (MMRs) are introduced. They are split into
two 64-bit halves: the lower halves are the GPRs and the upper halves are
accessible by the R5900-specific multimedia instructions.

The MMIs are only available with TARGET_MIPS64 since 64-bit GPRs are
required.

The relation between SQ and RDHWR may need to be revisited. I'm hoping to
discuss the details with Maciej.

This series has been successfully built with the 10 different build
configurations

    {gcc,clang} x -m64 x mips{,64}el-{linux-user,softmmu}
    {gcc,clang} x -m64 x mipsn32el-linux-user

in addition successfully completing the R5900 test suite

    cd tests/tcg/mips/mipsr5900 && make check
    cd tests/tcg/mips/mipsn32r5900 && make check

Fredrik Noring (9):
  target/mips: Require TARGET_MIPS64 for R5900 multimedia instructions
  target/mips: Introduce 32 R5900 128-bit multimedia registers
  target/mips: Support the R5900 PCPYLD multimedia instruction
  target/mips: Support the R5900 PCPYUD multimedia instruction
  target/mips: Support the R5900 LQ multimedia instruction
  target/mips: Support the R5900 SQ multimedia instruction
  tests/tcg/mips: Test R5900 multimedia instructions PCPYUD and PCPYLD
  tests/tcg/mips: Test R5900 multimedia instruction LQ
  tests/tcg/mips: Test R5900 multimedia instruction SQ

 target/mips/cpu.h                     |   2 +
 target/mips/translate.c               | 180 +++++++++++++++++++++++---
 tests/tcg/mips/mipsn32r5900/Makefile  |  27 ++++
 tests/tcg/mips/mipsn32r5900/lq.c      | 111 ++++++++++++++++
 tests/tcg/mips/mipsn32r5900/pcpyuld.c |  46 +++++++
 tests/tcg/mips/mipsn32r5900/sq.c      | 105 +++++++++++++++
 6 files changed, 452 insertions(+), 19 deletions(-)
 create mode 100644 tests/tcg/mips/mipsn32r5900/Makefile
 create mode 100644 tests/tcg/mips/mipsn32r5900/lq.c
 create mode 100644 tests/tcg/mips/mipsn32r5900/pcpyuld.c
 create mode 100644 tests/tcg/mips/mipsn32r5900/sq.c

-- 
2.19.2
