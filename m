Received: from eggs.gnu.org ([2001:4830:134:3::10]:43053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gFjRD-0004rk-VC
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:28:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gFjRA-0005DP-S2
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:28:51 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:35942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gFjRA-00056q-Em
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:28:48 -0400
Date: Thu, 25 Oct 2018 19:28:44 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <cover.1540487815.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/11] target/mips: Amend R5900 support
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

This series amends the R5900 support with the following noncritical
features:

- The vendor-specific Application-Specific Extension (ASE) ASE_MMI is
  renamed to ASE_TOSHIBA_MMI, because several vendors have multimedia
  instruction (MMI) sets and other extensions of various kinds. ASE
  vendor namespaces make it clear these are not generic architectural
  features and also avoid name clashes.

- The R5900 LQ and SQ instructions are now also covered by the Toshiba
  MMI ASE, as per the TX79 manual[1].

- The three-operand MADD and MADDU instructions specific to the R5900
  and the Toshiba TX19, TX39 and TX79 cores are now supported and tested
  by the R5900 TCG test suite.

- The three-operand MADD1 and MADDU1 pipeline 1 instructions specific
  to the R5900 and the Toshiba TX79 core are now supported and tested
  by the R5900 TCG test suite.

- The membership field of struct mips_opcode is now uint64_t instead
  of unsigned long, that is too small in 32-bit builds.

- R5900 disassembly constants are defined.

- The R5900 instructions DIV1, DIVU1, MFLO, MTLO, MFHI, MTHI, MULT1 and
  MULTU1 are now disassembled. Unfortunately, the opcodes for MADD1 and
  MADDU1 clash with the opcodes for CLZ and CLO, resulting in incorrect
  disassembly. MADD1 and MADDU1 are therefore left undefined.

This series has been successfully built with the 16 different build
configurations

    {gcc,clang} x -m{32,64} x mips{,64}el-{linux-user,softmmu}

in addition to successfully completing the R5900 test suite

    cd tests/tcg/mips/mipsr5900 && make check

Reference:

[1] "Toshiba TX System RISC TX79 Core Architecture", Toshiba Corporation,
    section B.3.2, p. B-4, <https://wiki.qemu.org/File:C790.pdf>.

Fredrik Noring (9):
  target/mips: Rename ASE_MMI to ASE_TOSHIBA_MMI, with Toshiba namespace
  target/mips: R5900 LQ and SQ also belong to the Toshiba MMI ASE
  target/mips: Support R5900 three-operand MADD1 and MADDU1
  tests/tcg/mips: Test R5900 three-operand MADD
  tests/tcg/mips: Test R5900 three-operand MADD1
  tests/tcg/mips: Test R5900 three-operand MADDU
  tests/tcg/mips: Test R5900 three-operand MADDU1
  disas/mips: Define R5900 disassembly constants
  disas/mips: Disassemble R5900 DIV[U]1, M{F,T}{LO,HI}1 and MULT[U]1

Philippe Mathieu-Daud=C3=A9 (2):
  target/mips: Support Toshiba specific three-operand MADD and MADDU
  disas/mips: Increase 'member of ISAs' flag holder size

 disas/mips.c                      | 22 ++++++++-
 target/mips/mips-defs.h           |  2 +-
 target/mips/translate.c           | 77 ++++++++++++++++++++++++++----
 target/mips/translate_init.inc.c  |  2 +-
 tests/tcg/mips/mipsr5900/Makefile |  2 +
 tests/tcg/mips/mipsr5900/madd.c   | 78 +++++++++++++++++++++++++++++++
 tests/tcg/mips/mipsr5900/maddu.c  | 70 +++++++++++++++++++++++++++
 7 files changed, 240 insertions(+), 13 deletions(-)
 create mode 100644 tests/tcg/mips/mipsr5900/madd.c
 create mode 100644 tests/tcg/mips/mipsr5900/maddu.c

--=20
2.18.1
