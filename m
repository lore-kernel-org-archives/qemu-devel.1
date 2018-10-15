Received: from eggs.gnu.org ([2001:4830:134:3::10]:47244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gC1n7-0004s9-QZ
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 08:16:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gC1n4-0008SP-FT
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 08:16:09 -0400
Received: from mail-bl2nam02on0729.outbound.protection.outlook.com
	([2a01:111:f400:fe46::729]:62336
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gC1n4-0008R7-7p
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 08:16:06 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 15 Oct 2018 12:16:01 +0000
Message-ID: <BN6PR2201MB125158347C995B4CC764BCDBC6FD0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <cover.1539428198.git.noring@nocrew.org>
In-Reply-To: <cover.1539428198.git.noring@nocrew.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 0/7] target/mips: Limited support for
 the R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, =?iso-8859-1?Q?J=FCrgen_Urban?= <JuergenUrban@gmx.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> From: Fredrik Noring <noring@nocrew.org>
> Sent: Saturday, October 13, 2018 1:09 PM
> To: Aleksandar Markovic; Maciej W. Rozycki; Philippe Mathieu-Daud=E9
> Cc: Richard Henderson; Aurelien Jarno; Petar Jovanovic; Peter Maydell; J=
=FCrgen Urban; > qemu-devel@nongnu.org
> Subject: [PATCH v7 0/7] target/mips: Limited support for the R5900
>=20
> The primary purpose of these changes is to support programs compiled
> by GCC for the R5900 target and thereby run R5900 Linux distributions,
> for example Gentoo.
>=20

Hello, Fredrik.

Your series is getting better and better with each version, which is very g=
ood. For a change, I don't have any objection about the title. :) Patch 7 w=
ill be integrated shortly in the MIPS queue, you don't need to worry about =
it. With this series you are not only supporting your prime use case, but y=
ou are introducing a new instruction set to QEMU. Try to step back and get =
wider perspective. No matter how limited the support for the new ISA is, it=
s introduction to QEMU must have following elements:

(1) Definition of basic preprocessor constants for the new ISA.
(2) All opcodes for the ISA.
(3) Basic decoding engine for new instructions.

Your patch 1 adresses 1). However, there are no patches for (2) and (3) in =
this series. Let me walk though the details on how to implement (2) and (3)=
.

(2) All opcodes for the ISA.

Only if an R5900 instruction has the same name, opcode, and functionality, =
corresponding MIPS III/IV opcode can and must be reused for R5900. For all =
other cases, R5900-specific opcode must be supplied. I'll limit further con=
sideration to MMI instructions, but you should consider the whole R5900 ins=
truction set.

For MMI instruction, there should be a patch "target/mips: Add R5900 Emotio=
n Engine MMI instruction opcodes" that adds following code segment:

/*
 *  Emotion Engine MMI instruction set opcodes
 *  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 */

#define EE_CLASS_MMI        0x1C    /* the same as OPC_SPECIAL2 */

/*
 *  MMI instruction class
 *
 *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
 *  +-----------+---------+---------+---------+---------+-----------+
 *  | CLASS_MMI |         |         |         |         |   opcode  |
 *  +-----------+---------+---------+---------+---------+-----------+
 */

#define EE_MMI_MADD         0x00
#define EE_MMI_MADDU        0x01
#define EE_MMI_PLZCW        0x04
#define EE_MMI_CLASS_MMI0   0x08
#define EE_MMI_CLASS_MMI2   0x09
#define EE_MMI_MFHI1        0x10
#define EE_MMI_MTHI1        0x11
#define EE_MMI_MFLO1        0x12
#define EE_MMI_MTLO1        0x13
#define EE_MMI_MULT1        0x18
#define EE_MMI_MULTU1       0x19
#define EE_MMI_DIV1         0x1a
#define EE_MMI_DIVU1        0x1b
#define EE_MMI_MADD1        0x20
#define EE_MMI_MADDU1       0x21
#define EE_MMI_CLASS_MMI1   0x28
#define EE_MMI_CLASS_MMI3   0x29
#define EE_MMI_PMFHL        0x30
#define EE_MMI_PMTHL        0x31
#define EE_MMI_PSLLH        0x34
#define EE_MMI_PSRLH        0x36
#define EE_MMI_PSRAH        0x37
#define EE_MMI_PSLLW        0x3c
#define EE_MMI_PSRLW        0x3e
#define EE_MMI_PSRAW        0x3f

/*
 *  MMI0 instruction class
 *
 *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
 *  +-----------+---------+---------+---------+---------+-----------+
 *  | CLASS_MMI |         |         |         |  opcode | CLASS_MMI0|
 *  +-----------+---------+---------+---------+---------+-----------+
 */

#define EE_MMI0_PADDW       0x00
#define EE_MMI0_PSUBW       0x01
#define EE_MMI0_PCGTW       0x02
#define EE_MMI0_PMAXW       0x03
#define EE_MMI0_PADDH       0x04
#define EE_MMI0_PSUBH       0x05
#define EE_MMI0_PCGTH       0x06
#define EE_MMI0_PMAXH       0x07
#define EE_MMI0_PADDB       0x08
#define EE_MMI0_PSUBB       0x09
#define EE_MMI0_PCGTB       0x0a
#define EE_MMI0_PADDSW      0x10
#define EE_MMI0_PSUBSW      0x11
#define EE_MMI0_PEXTLW      0x12
#define EE_MMI0_PPACW       0x13
#define EE_MMI0_PADDSH      0x14
#define EE_MMI0_PSUBSH      0x15
#define EE_MMI0_PEXTLH      0x16
#define EE_MMI0_PPACH       0x17
#define EE_MMI0_PADDSB      0x18
#define EE_MMI0_PSUBSB      0x19
#define EE_MMI0_PEXTLB      0x1a
#define EE_MMI0_PPACB       0x1b
#define EE_MMI0_PEXT5       0x1e
#define EE_MMI0_PPAC5       0x1f

/*
 *  MMI1 instruction class
 *
 *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
 *  +-----------+---------+---------+---------+---------+-----------+
 *  | CLASS_MMI |         |         |         |  opcode | CLASS_MMI1|
 *  +-----------+---------+---------+---------+---------+-----------+
 */

#define EE_MMI1_PABSW       0x01
#define EE_MMI1_PCEQW       0x02
#define EE_MMI1_PMINW       0x03
#define EE_MMI1_PADSBH      0x04
#define EE_MMI1_PABSH       0x05
#define EE_MMI1_PCEQH       0x06
#define EE_MMI1_PMINH       0x07
#define EE_MMI1_PCEQB       0x0a
#define EE_MMI1_PADDUW      0x10
#define EE_MMI1_PSUBUW      0x11
#define EE_MMI1_PEXTUW      0x12
#define EE_MMI1_PADDUH      0x14
#define EE_MMI1_PSUBUH      0x15
#define EE_MMI1_PEXTUH      0x16
#define EE_MMI1_PADDUB      0x18
#define EE_MMI1_PSUBUB      0x19
#define EE_MMI1_PEXTUB      0x1a
#define EE_MMI1_QFSRV       0x1b

/*
 *  MMI2 instruction class
 *
 *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
 *  +-----------+---------+---------+---------+---------+-----------+
 *  | CLASS_MMI |         |         |         |  opcode | CLASS_MMI2|
 *  +-----------+---------+---------+---------+---------+-----------+
 */

#define EE_MMI2_PMADDW      0x00
#define EE_MMI2_PSLLVW      0x02
#define EE_MMI2_PSRLVW      0x03
#define EE_MMI2_PMSUBW      0x04
#define EE_MMI2_PMFHI       0x08
#define EE_MMI2_PMFLO       0x09
#define EE_MMI2_PINTH       0x0a
#define EE_MMI2_PMULTW      0x0c
#define EE_MMI2_PDIVW       0x0d
#define EE_MMI2_PCPYLD      0x0e
#define EE_MMI2_PMADDH      0x10
#define EE_MMI2_PHMADH      0x11
#define EE_MMI2_PAND        0x12
#define EE_MMI2_PXOR        0x13
#define EE_MMI2_PMSUBH      0x14
#define EE_MMI2_PHMSBH      0x15
#define EE_MMI2_PEXEH       0x1a
#define EE_MMI2_PREVH       0x1b
#define EE_MMI2_PMULTH      0x1c
#define EE_MMI2_PDIVBW      0x1d
#define EE_MMI2_PEXEW       0x1e
#define EE_MMI2_PROT3W      0x1f

/*
 *  MMI3 instruction class
 *
 *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
 *  +-----------+---------+---------+---------+---------+-----------+
 *  | CLASS_MMI |         |         |         |  opcode | CLASS_MMI3|
 *  +-----------+---------+---------+---------+---------+-----------+
 */

#define EE_MMI3_PMADDUW     0x00
#define EE_MMI3_PSRAVW      0x03
#define EE_MMI3_PMTHI       0x08
#define EE_MMI3_PMTLO       0x09
#define EE_MMI3_PINTEH      0x0a
#define EE_MMI3_PMULTUW     0x0c
#define EE_MMI3_PDIVUW      0x0d
#define EE_MMI3_PCPYUD      0x0e
#define EE_MMI3_POR         0x12
#define EE_MMI3_PNOR        0x13
#define EE_MMI3_PEXCH       0x1a
#define EE_MMI3_PCPYH       0x1b
#define EE_MMI3_PEXCW       0x1e

(This is just a suggestion, the organization and naming of course can be di=
fferent; double-check accuracy of opcodes)



(3) Basic decoding engine for new instructions.

As you can notice, MMI opcodes occupy the same space as OPC_SPECIAL2. So th=
is segment from translate.c:

    case OPC_SPECIAL2:
        decode_opc_special2_legacy(env, ctx);
        break;

should become something like this:

    case OPC_SPECIAL2:
        if(ctx->insn_flags & INSN_R5900) {
            decode_ee_mmi(env, ctx);
        } else {}
            decode_opc_special2_legacy(env, ctx);
        }
        break;

where decode_ee_mmi() is defined by yourself as something like this:


static void decode_ee_mmi(CPUMIPSState *env, DisasContext *ctx)
{
    uint32_t opcode =3D extract32(ctx->opcode, 6, 0);

    switch(opcode) {
   =20
    case EE_MMI_MADD:
        /* TODO: Implement emulation of EE_MMI_MADD */
        generate_exception_end(ctx, EXCP_RI);
        break;=20
    case EE_MMI_MADDU:
        /* TODO: Implement emulation of EE_MMI_MADDU */
        generate_exception_end(ctx, EXCP_RI);
        break;=20
    case EE_MMI_PLZCW:
        /* TODO: Implement emulation of EE_MMI_PLZCW */
        generate_exception_end(ctx, EXCP_RI);
        break;=20
    case EE_MMI_CLASS_MMI0:
        decode_ee_mmi0(env, ctx);
        break;=20
    case EE_MMI_CLASS_MMI2:
        decode_ee_mmi2(env, ctx);
        break;=20
    case EE_MMI_MFHI1:
        /* TODO: Implement emulation of EE_MMI_MFHI1 */
        generate_exception_end(ctx, EXCP_RI);
        break;=20
    case EE_MMI_MTHI1:
        /* TODO: Implement emulation of EE_MMI_MTHI1 */
        generate_exception_end(ctx, EXCP_RI);
        break;=20
    case EE_MMI_MFLO1:
        /* TODO: Implement emulation of EE_MMI_MFLO1 */
        generate_exception_end(ctx, EXCP_RI);
        break;=20
    case EE_MMI_MTLO1:
        /* TODO: Implement emulation of EE_MMI_MTLO1 */
        generate_exception_end(ctx, EXCP_RI);
        break;=20
    case EE_MMI_MULT1:
        /* TODO: Implement emulation of EE_MMI_MULT1 */
        generate_exception_end(ctx, EXCP_RI);
        break;=20
    case EE_MMI_MULTU1:
        /* TODO: Implement emulation of EE_MMI_MULTU1 */
        generate_exception_end(ctx, EXCP_RI);
        break;=20
    case EE_MMI_DIV1:
        /* TODO: Implement emulation of EE_MMI_DIV1 */
        generate_exception_end(ctx, EXCP_RI);
        break;=20
    case EE_MMI_DIVU1:
        /* TODO: Implement emulation of EE_MMI_DIVU1 */
        generate_exception_end(ctx, EXCP_RI);
        break;=20
    case EE_MMI_MADD1:
        /* TODO: Implement emulation of EE_MMI_MADD1 */
        generate_exception_end(ctx, EXCP_RI);
        break;=20
    case EE_MMI_MADDU1:
        /* TODO: Implement emulation of EE_MMI_MADDU1 */
        generate_exception_end(ctx, EXCP_RI);
        break;=20
    case EE_MMI_CLASS_MMI1:
        decode_ee_mmi1(env, ctx);
        break;=20
    case EE_MMI_CLASS_MMI3:
        decode_ee_mmi3(env, ctx);
        break;=20
    case EE_MMI_PMFHL:
        /* TODO: Implement emulation of EE_MMI_PMFHL */
        generate_exception_end(ctx, EXCP_RI);
        break;=20
    case EE_MMI_PMTHL:
        /* TODO: Implement emulation of EE_MMI_PMTHL */
        generate_exception_end(ctx, EXCP_RI);
        break;=20
    case EE_MMI_PSLLH:
        /* TODO: Implement emulation of EE_MMI_PSLLH */
        generate_exception_end(ctx, EXCP_RI);
        break;=20
    case EE_MMI_PSRLH:
        /* TODO: Implement emulation of EE_MMI_PSRLH */
        generate_exception_end(ctx, EXCP_RI);
        break;=20
    case EE_MMI_PSRAH:
        /* TODO: Implement emulation of EE_MMI_PSRAH */
        generate_exception_end(ctx, EXCP_RI);
        break;=20
    case EE_MMI_PSLLW:
        /* TODO: Implement emulation of EE_MMI_PSLLW */
        generate_exception_end(ctx, EXCP_RI);
        break;=20
    case EE_MMI_PSRLW:
        /* TODO: Implement emulation of EE_MMI_PSRLW */
        generate_exception_end(ctx, EXCP_RI);
        break;=20
    case EE_MMI_PSRAW:
        /* TODO: Implement emulation of EE_MMI_PSRAW */
        generate_exception_end(ctx, EXCP_RI);
        break;=20
    default:
        generate_exception_end(ctx, EXCP_RI);
        break;=20
    }

Of course, you need to specify functions decode_ee_mmi0(), decode_ee_mmi1()=
, decode_ee_mmi2(), and decode_ee_mmi3() too.

You can change format and naming in the code above, but I insist that each =
unimplemeted instuction has its own "TODO" and "generate_exception()".

Please focus on the elements I presented in this email. They are necessary =
to complete this patch series.

Keep MMI changes described above in two separate patches. You'll need proba=
bly several such pairs to cover the whole R5900.

FPU opcodes need such treatment too. This will affect your overall solution=
, hopefully it will be better after the reorganization.

Thanks,
Aleksandar


> GCC in version 7.3, by itself, by inspection of the GCC source code
> and inspection of the generated machine code, for the R5900 target,
> only emits two instructions that are specific to the R5900: the three-
> operand MULT and MULTU. GCC and libc also emit certain MIPS III
> instructions that are not part of the R5900 ISA. They are normally
> trapped and emulated by the Linux kernel, and therefore need to be
> treated accordingly by QEMU. This is addressed, in turn, by the
> patch series.
>=20
> A program compiled by GCC is taken to mean source code compiled by GCC
> under the restrictions above. One can, with the apparent limitations,
> with a bit of effort obtain a fully functioning operating system such
> as R5900 Gentoo. Strictly speaking, programs need not be compiled by
> GCC to make use of this change.
>=20
> Instructions and other facilities of the R5900 not implemented by these
> changes are intended to signal provisional exceptions. One such example
> is the FPU that is not compliant with IEEE 754-1985 in system mode. It
> is therefore provisionally disabled. In user space the FPU is trapped
> and emulated by IEEE 754-1985 compliant software in the kernel, and
> this is handled accordingly by QEMU. Another example is the 93
> multimedia instructions specific to the R5900 that generate provisional
> reserved instruction exception signals.
>=20
> One of the benefits of running a Linux distribution under QEMU is that
> programs can be compiled with a native compiler, where the host and
> target are the same, as opposed to a cross-compiler, where they are
> not the same. This is especially important in cases where the target
> hardware does not have the resources to run a native compiler.
>=20
> Problems with cross-compilation are often related to host and target
> differences in integer sizes, pointer sizes, endianness, machine code,
> ABI, etc. Sometimes cross-compilation is not even supported by the
> build script for a given package. One effective way to avoid those
> problems is to replace the cross-compiler with a native compiler. This
> change of compilation methods does not resolve the inherent problems
> with cross-compilation.
>=20
> The native compiler naturally replaces the cross-compiler, because one
> typically uses one or the other, and preferably the native compiler
> when the circumstances admit this. The native compiler is also a good
> test case for the R5900 QEMU user mode. Additionally, Gentoo is well-
> known for compiling and installing its packages from sources.
>=20
> This change has been tested with Gentoo compiled for R5900, including
> native compilation of several packages under QEMU. I used the Gentoo
> sys-devel/crossdev package
>=20
> https://wiki.gentoo.org/wiki/Crossdev
>=20
> with patches mainly to simplify the handling of LL/SC and floating
> point support, to avoid complications with additional configure and
> compiler flags. Busybox
>=20
> https://busybox.net/
>=20
> can also be used to build a simple functional R5900 program. It can be
> used to test the R5900 CPU in QEMU user mode.
>=20
> The R5900 implements the 64-bit MIPS III instruction set except DMULT,
> DMULTU, DDIV, DDIVU, LL, SC, LLD and SCD. The MIPS IV instructions MOVN,
> MOVZ and PREF are implemented. It has the R5900 specific three-operand
> instructions MADD, MADDU, MULT and MULTU as well as pipeline 1 versions
> MULT1, MULTU1, DIV1, DIVU1, MADD1, MADDU1, MFHI1, MFLO1, MTHI1 and
> MTLO1. A set of 93 128-bit multimedia instructions specific to the
> R5900 is also implemented.
>=20
> The Toshiba TX System RISC TX79 Core Architecture manual
>=20
> http://www.lukasz.dk/files/tx79architecture.pdf
>=20
> describes the C790 processor that is a follow-up to the R5900. There
> are a few notable differences in that the R5900 FPU
>=20
> - is not IEEE 754-1985 compliant,
> - does not implement double format, and
> - its machine code is nonstandard.
>=20
> Changes in v7:
> - Rename gen_mul_txxx to gen_mul_txx9
> - Use MIPS_INVAL("mul TXx9")
> - Reviewed-by: Philippe Mathieu-Daud=E9
>=20
> Changes in v6:
> - Set the CP0 PRId implementation number to 0x2E for the R5900
> - Refer to the C790 follow-up in the definition of the R5900
> - Define and use check_insn_opc_user_only in the same change
> - Rename gen_mul_r5900 to gen_mul_txxx
> - Enclose single statements in braces
> - Expand and reword commit messages and notes
> - Reword the cover letter subject line
> - All changes build with GCC and Clang
> - Approval from checkpatch.pl
>=20
> Changes in v5:
> - Reorder check_insn_opc_user_only calls
> - Call check_insn_opc_removed in check_insn_opc_user_only
>=20
> Changes in v4:
> - Split into a patch series consting of eight changes
> - Expand commit messages and notes
> - Introduce check_insn_opc_user_only
> - Base R5900 on MIPS III, with MOVN, MOVZ and PREF from MIPS IV
> - DMULT, DMULTU, DDIV, DDIVU, LL, SC, LLD and SCD are user only
> - Note Toshiba/Sony R5900 for EF_MIPS_MACH_R5900 definition
> - Rework gen_mul_r5900
> - Fix ICE and DCE
> - Fix SEGBITS and PABITS
> - Fix indentation
>=20
> Changes in v3:
> - Apply to HEAD
> - Remove the word "initial" from subject line
>=20
> Changes in v2:
> - Update mips_defs array with R5900 values
> - LL/SC and FPU are user only
>=20
> Fredrik Noring (7):
>   target/mips: Define R5900 instructions and CPU preprocessor constants
>   target/mips: Support R5900 specific three-operand MULT and MULTU
>   target/mips: Support R5900 instructions MOVN, MOVZ and PREF from MIPS I=
V
>   target/mips: R5900 DMULT[U], DDIV[U], LL[D] and SC[D] are user only
>   target/mips: Define the R5900 CPU
>   linux-user/mips: Recognise the R5900 CPU model
>   elf: Toshiba/Sony rather than MIPS are the implementors of the R5900
>=20
>  include/elf.h                    |   2 +-
>  linux-user/mips/target_elf.h     |   3 ++
>  target/mips/mips-defs.h          |   2 +
>  target/mips/translate.c          | 101 +++++++++++++++++++++++++++++++++=
++++--
>  target/mips/translate_init.inc.c |  59 +++++++++++++++++++++++
>  5 files changed, 163 insertions(+), 4 deletions(-)
>=20
> --
> 2.16.4
>=20
> =
