Received: from eggs.gnu.org ([2001:4830:134:3::10]:42555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gBHo0-0006R6-0D
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 07:10:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gBHnv-0007lY-2u
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 07:09:59 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:53483)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gBHnu-0007kS-Ee
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 07:09:54 -0400
Date: Sat, 13 Oct 2018 13:09:46 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <cover.1539428198.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 0/7] target/mips: Limited support for the
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

http://www.lukasz.dk/files/tx79architecture.pdf

describes the C790 processor that is a follow-up to the R5900. There
are a few notable differences in that the R5900 FPU

- is not IEEE 754-1985 compliant,
- does not implement double format, and
- its machine code is nonstandard.

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
- Split into a patch series consting of eight changes
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

Fredrik Noring (7):
  target/mips: Define R5900 instructions and CPU preprocessor constants
  target/mips: Support R5900 specific three-operand MULT and MULTU
  target/mips: Support R5900 instructions MOVN, MOVZ and PREF from MIPS I=
V
  target/mips: R5900 DMULT[U], DDIV[U], LL[D] and SC[D] are user only
  target/mips: Define the R5900 CPU
  linux-user/mips: Recognise the R5900 CPU model
  elf: Toshiba/Sony rather than MIPS are the implementors of the R5900

 include/elf.h                    |   2 +-
 linux-user/mips/target_elf.h     |   3 ++
 target/mips/mips-defs.h          |   2 +
 target/mips/translate.c          | 101 +++++++++++++++++++++++++++++++++=
++++--
 target/mips/translate_init.inc.c |  59 +++++++++++++++++++++++
 5 files changed, 163 insertions(+), 4 deletions(-)

--=20
2.16.4
