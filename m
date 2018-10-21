Received: from eggs.gnu.org ([2001:4830:134:3::10]:44621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFgh-0005kX-CJ
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFge-0008NA-63
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:30:43 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:40487)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gEFgd-0008MC-N9
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:30:40 -0400
Date: Sun, 21 Oct 2018 17:30:32 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <cover.1540134918.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 00/38] target/mips: Limited support for the
 R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, "Maciej W. Rozycki" <macro@linux-mips.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

The primary purpose of these changes is to support programs compiled
by GCC for the R5900 target and thereby run R5900 Linux distributions,
for example Gentoo.

GCC in version 7.3, by itself, by inspection of the GCC source code
and inspection of the generated machine code, for the R5900 target,
only emits two instructions that are specific to the R5900: the three-
operand MULT and MULTU. GCC and libc also emit certain MIPS III
instructions that are not part of the R5900 ISA. They are normally
trapped and emulated by the Linux kernel, and therefore need to be
treated accordingly by QEMU. This is addressed, in turn, by the
patch series.

A program compiled by GCC is taken to mean source code compiled by GCC
under the restrictions above. One can, with the apparent limitations,
with a bit of effort obtain a fully functioning operating system such
as R5900 Gentoo. Strictly speaking, programs need not be compiled by
GCC to make use of this change.

Instructions and other facilities of the R5900 not implemented by these
changes are intended to signal provisional exceptions. One such example
is the FPU that is not compliant with IEEE 754-1985 in system mode. It
is therefore provisionally disabled. In user space the FPU is trapped
and emulated by IEEE 754-1985 compliant software in the kernel, and
this is handled accordingly by QEMU. Another example is the 93
multimedia instructions specific to the R5900 that generate provisional
reserved instruction exception signals.

One of the benefits of running a Linux distribution under QEMU is that
programs can be compiled with a native compiler, where the host and
target are the same, as opposed to a cross-compiler, where they are
not the same. This is especially important in cases where the target
hardware does not have the resources to run a native compiler.

Problems with cross-compilation are often related to host and target
differences in integer sizes, pointer sizes, endianness, machine code,
ABI, etc. Sometimes cross-compilation is not even supported by the
build script for a given package. One effective way to avoid those
problems is to replace the cross-compiler with a native compiler. This
change of compilation methods does not resolve the inherent problems
with cross-compilation.

The native compiler naturally replaces the cross-compiler, because one
typically uses one or the other, and preferably the native compiler
when the circumstances admit this. The native compiler is also a good
test case for the R5900 QEMU user mode. Additionally, Gentoo is well-
known for compiling and installing its packages from sources.

This change has been tested with Gentoo compiled for R5900, including
native compilation of several packages under QEMU. I used the Gentoo
sys-devel/crossdev package

https://wiki.gentoo.org/wiki/Crossdev

with patches mainly to simplify the handling of LL/SC and floating
point support, to avoid complications with additional configure and
compiler flags. Busybox

https://busybox.net/

can also be used to build a simple functional R5900 program. It can be
used to test the R5900 CPU in QEMU user mode.

The R5900 implements the 64-bit MIPS III instruction set except DMULT,
DMULTU, DDIV, DDIVU, LL, SC, LLD and SCD. The MIPS IV instructions MOVN,
MOVZ and PREF are implemented. It has the R5900 specific three-operand
instructions MADD, MADDU, MULT and MULTU as well as pipeline 1 versions
MULT1, MULTU1, DIV1, DIVU1, MADD1, MADDU1, MFHI1, MFLO1, MTHI1 and
MTLO1. A set of 93 128-bit multimedia instructions specific to the
R5900 is also implemented.

The Toshiba TX System RISC TX79 Core Architecture manual

https://wiki.qemu.org/File:C790.pdf

describes the C790 processor that is a follow-up to the R5900. There
are a few notable differences in that the R5900 FPU

- is not IEEE 754-1985 compliant,
- does not implement double format, and
- its machine code is nonstandard.

Changes in v8:
- Support, disassembly and tests for MADD, MADD1, MADDU and MADDU1
- Support, disassembly and tests for MTLO1, MTHI1, MFLO1 and MFHI1
- Support, disassembly and tests for MULT1, MULTU1, DIV1 and DIVU1
- Opcode definitions and placeholder code for all unsupported MMIs
- check_insn_opc_user_only flags parameter type is uint64_t
- Toshiba TX System RISC TX79 manual PDF QEMU wiki link
- Merge of [PATCH v7 7/7] with Toshiba/Sony rename

Changes in v7:
- Rename gen_mul_txxx to gen_mul_txx9
- Use MIPS_INVAL("mul TXx9")
- Reviewed-by: Philippe Mathieu-Daud=C3=A9

Changes in v6:
- Set the CP0 PRId implementation number to 0x2E for the R5900
- Refer to the C790 follow-up in the definition of the R5900
- Define and use check_insn_opc_user_only in the same change
- Rename gen_mul_r5900 to gen_mul_txxx
- Enclose single statements in braces
- Expand and reword commit messages and notes
- Reword the cover letter subject line
- All changes build with GCC and Clang
- Approval from checkpatch.pl

Changes in v5:
- Reorder check_insn_opc_user_only calls
- Call check_insn_opc_removed in check_insn_opc_user_only

Changes in v4:
- Split into a patch series consisting of eight changes
- Expand commit messages and notes
- Introduce check_insn_opc_user_only
- Base R5900 on MIPS III, with MOVN, MOVZ and PREF from MIPS IV
- DMULT, DMULTU, DDIV, DDIVU, LL, SC, LLD and SCD are user only
- Note Toshiba/Sony R5900 for EF_MIPS_MACH_R5900 definition
- Rework gen_mul_r5900
- Fix ICE and DCE
- Fix SEGBITS and PABITS
- Fix indentation

Changes in v3:
- Apply to HEAD
- Remove the word "initial" from subject line

Changes in v2:
- Update mips_defs array with R5900 values
- LL/SC and FPU are user only

Fredrik Noring (38):
  target/mips: Define R5900 instructions and CPU preprocessor constants
  disas/mips: Define R5900 disassembly constants
  target/mips: R5900 Multimedia Instruction overview note
  target/mips: Define R5900 MMI class, and LQ and SQ opcode constants
  target/mips: Define R5900 MMI{0,1,2,3} subclasses and MMI opcode consta=
nts
  target/mips: Define R5900 MMI0 opcode constants
  target/mips: Define R5900 MMI1 opcode constants
  target/mips: Define R5900 MMI2 opcode constants
  target/mips: Define R5900 MMI3 opcode constants
  target/mips: Placeholder for R5900 MMI SQ, handle user mode RDHWR
  target/mips: Placeholder for R5900 MMI LQ
  target/mips: Placeholder for R5900 MMI instruction class
  target/mips: Placeholder for R5900 MMI0 instruction subclass
  target/mips: Placeholder for R5900 MMI1 instruction subclass
  target/mips: Placeholder for R5900 MMI2 instruction subclass
  target/mips: Placeholder for R5900 MMI3 instruction subclass
  target/mips: Support R5900 three-operand MULT and MULTU
  target/mips: Support R5900 three-operand MULT1 and MULTU1
  target/mips: Support R5900 MFLO1, MTLO1, MFHI1 and MTHI1
  target/mips: Support R5900 DIV1 and DIVU1
  target/mips: Support R5900 MOVN, MOVZ and PREF from MIPS IV
  target/mips: Support R5900 three-operand MADD and MADD1
  target/mips: Support R5900 three-operand MADDU and MADDU1
  target/mips: R5900 DMULT[U], DDIV[U], LL[D] and SC[D] are user only
  tests/tcg/mips: Test R5900 three-operand MULT
  tests/tcg/mips: Test R5900 three-operand MULTU
  tests/tcg/mips: Test R5900 three-operand MULT1
  tests/tcg/mips: Test R5900 three-operand MULTU1
  tests/tcg/mips: Test R5900 MFLO1 and MFHI1
  tests/tcg/mips: Test R5900 MTLO1 and MTHI1
  tests/tcg/mips: Test R5900 DIV1
  tests/tcg/mips: Test R5900 DIVU1
  tests/tcg/mips: Test R5900 three-operand MADD
  tests/tcg/mips: Test R5900 three-operand MADD1
  tests/tcg/mips: Test R5900 three-operand MADDU
  tests/tcg/mips: Test R5900 three-operand MADDU1
  target/mips: Define the R5900 CPU
  linux-user/mips: Recognise the R5900 CPU model

 disas/mips.c                       |  20 +
 linux-user/mips/target_elf.h       |   3 +
 target/mips/mips-defs.h            |   2 +
 target/mips/translate.c            | 871 ++++++++++++++++++++++++++++-
 target/mips/translate_init.inc.c   |  59 ++
 tests/tcg/mips/mipsr5900/Makefile  |  32 ++
 tests/tcg/mips/mipsr5900/div1.c    |  73 +++
 tests/tcg/mips/mipsr5900/divu1.c   |  48 ++
 tests/tcg/mips/mipsr5900/madd.c    |  78 +++
 tests/tcg/mips/mipsr5900/maddu.c   |  70 +++
 tests/tcg/mips/mipsr5900/mflohi1.c |  35 ++
 tests/tcg/mips/mipsr5900/mtlohi1.c |  40 ++
 tests/tcg/mips/mipsr5900/mult.c    |  76 +++
 tests/tcg/mips/mipsr5900/multu.c   |  68 +++
 14 files changed, 1465 insertions(+), 10 deletions(-)
 create mode 100644 tests/tcg/mips/mipsr5900/Makefile
 create mode 100644 tests/tcg/mips/mipsr5900/div1.c
 create mode 100644 tests/tcg/mips/mipsr5900/divu1.c
 create mode 100644 tests/tcg/mips/mipsr5900/madd.c
 create mode 100644 tests/tcg/mips/mipsr5900/maddu.c
 create mode 100644 tests/tcg/mips/mipsr5900/mflohi1.c
 create mode 100644 tests/tcg/mips/mipsr5900/mtlohi1.c
 create mode 100644 tests/tcg/mips/mipsr5900/mult.c
 create mode 100644 tests/tcg/mips/mipsr5900/multu.c

--=20
2.18.1
