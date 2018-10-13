Received: from eggs.gnu.org ([2001:4830:134:3::10]:43039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gBHpM-0007Ro-OD
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 07:11:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gBHpL-0000EM-3m
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 07:11:24 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:42384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gBHpK-0000CN-D7
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 07:11:22 -0400
Date: Sat, 13 Oct 2018 13:10:54 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <4c1d5692e1a5964352ae2df78a10f2b1f1120a2c.1539428198.git.noring@nocrew.org>
References: <cover.1539428198.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1539428198.git.noring@nocrew.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 5/7] target/mips: Define the R5900 CPU
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

The primary purpose of this change is to support programs compiled by
GCC for the R5900 target and thereby run R5900 Linux distributions, for
example Gentoo.

GCC in version 7.3, by itself, by inspection of the GCC source code
and inspection of the generated machine code, for the R5900 target,
only emits two instructions that are specific to the R5900: the three-
operand MULT and MULTU. GCC and libc also emit certain MIPS III
instructions that are not part of the R5900 ISA. They are normally
trapped and emulated by the Linux kernel, and therefore need to be
treated accordingly by QEMU.

A program compiled by GCC is taken to mean source code compiled by GCC
under the restrictions above. One can, with the apparent limitations,
with a bit of effort obtain a fully functioning operating system such
as R5900 Gentoo. Strictly speaking, programs need not be compiled by
GCC to make use of this change.

Instructions and other facilities of the R5900 not implemented by this
change are intended to signal provisional exceptions. One such example
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
native compilation of several packages under QEMU.

Signed-off-by: Fredrik Noring <noring@nocrew.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 target/mips/translate_init.inc.c | 59 ++++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 59 insertions(+)

diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_ini=
t.inc.c
index b3320b9dc7..b5dacf4ffe 100644
--- a/target/mips/translate_init.inc.c
+++ b/target/mips/translate_init.inc.c
@@ -410,6 +410,65 @@ const mips_def_t mips_defs[] =3D
         .insn_flags =3D CPU_MIPS32R5 | ASE_MSA,
         .mmu_type =3D MMU_TYPE_R4000,
     },
+    {
+        /*
+         * The Toshiba TX System RISC TX79 Core Architecture manual
+         *
+         * http://www.lukasz.dk/files/tx79architecture.pdf
+         *
+         * describes the C790 processor that is a follow-up to the R5900=
.
+         * There are a few notable differences in that the R5900 FPU
+         *
+         * - is not IEEE 754-1985 compliant,
+         * - does not implement double format, and
+         * - its machine code is nonstandard.
+         */
+        .name =3D "R5900",
+        .CP0_PRid =3D 0x00002E00,
+        /* No L2 cache, icache size 32k, dcache size 32k, uncached coher=
ency. */
+        .CP0_Config0 =3D (0x3 << 9) | (0x3 << 6) | (0x2 << CP0C0_K0),
+        .CP0_Status_rw_bitmask =3D 0xF4C79C1F,
+#ifdef CONFIG_USER_ONLY
+        /*
+         * R5900 hardware traps to the Linux kernel for IEEE 754-1985 an=
d LL/SC
+         * emulation. For user only, QEMU is the kernel, so we emulate t=
he traps
+         * by simply emulating the instructions directly.
+         *
+         * Note: Config1 is only used internally, the R5900 has only Con=
fig0.
+         */
+        .CP0_Config1 =3D (1 << CP0C1_FP) | (47 << CP0C1_MMU),
+        .CP0_LLAddr_rw_bitmask =3D 0xFFFFFFFF,
+        .CP0_LLAddr_shift =3D 4,
+        .CP1_fcr0 =3D (0x38 << FCR0_PRID) | (0x0 << FCR0_REV),
+        .CP1_fcr31 =3D 0,
+        .CP1_fcr31_rw_bitmask =3D 0x0183FFFF,
+#else
+        /*
+         * The R5900 COP1 FPU implements single-precision floating-point
+         * operations but is not entirely IEEE 754-1985 compatible. In
+         * particular,
+         *
+         * - NaN (not a number) and +/- infinities are not supported;
+         * - exception mechanisms are not fully supported;
+         * - denormalized numbers are not supported;
+         * - rounding towards nearest and +/- infinities are not support=
ed;
+         * - computed results usually differs in the least significant b=
it;
+         * - saturations can differ more than the least significant bit.
+         *
+         * Since only rounding towards zero is supported, the two least
+         * significant bits of FCR31 are hardwired to 01.
+         *
+         * FPU emulation is disabled here until it is implemented.
+         *
+         * Note: Config1 is only used internally, the R5900 has only Con=
fig0.
+         */
+        .CP0_Config1 =3D (47 << CP0C1_MMU),
+#endif /* !CONFIG_USER_ONLY */
+        .SEGBITS =3D 32,
+        .PABITS =3D 32,
+        .insn_flags =3D CPU_R5900,
+        .mmu_type =3D MMU_TYPE_R4000,
+    },
     {
         /* A generic CPU supporting MIPS32 Release 6 ISA.
            FIXME: Support IEEE 754-2008 FP.
--=20
2.16.4
