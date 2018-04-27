Received: from eggs.gnu.org ([2001:4830:134:3::10]:55807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fC74w-0005nV-Ni
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 13:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fC74r-0002rF-Nr
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 13:22:38 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:33346)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fC74r-0002qz-DJ
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 13:22:33 -0400
Received: by mail-wm0-x231.google.com with SMTP id x12so4006136wmc.0
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 10:22:33 -0700 (PDT)
References: <20180425012300.14698-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180425012300.14698-1-richard.henderson@linaro.org>
Date: Fri, 27 Apr 2018 18:22:30 +0100
Message-ID: <87wowsk1ih.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/9] target/arm: Fixups for
 ARM_FEATURE_V8_FP16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> When running the gcc testsuite with current aarch64-linux-user,
> the testsuite detects the presence of the fp16 extension and
> enables lots of extra tests for builtins.
>
> Quite a few of these new tests fail because we missed implementing
> some instructions.  We really should go back and verify that nothing
> else is missing from this (rather large) extension.

So this set of instructions is generated from any ASL description that
contains "half":

# Input file for risugen defining AArch64 instructions
.mode arm.aarch64
FADDP_asisdpair_only_H A64_V 0101111000110000110110 Rn:5  Rd:5
FRECPS_asimdsamefp16_only A64_V 0 Q:1 001110010 Rm:5 001111 Rn:5  Rd:5
FMAXNMP_asisdpair_only_H A64_V 0101111000110000110010 Rn:5  Rd:5
SCVTF_asimdmiscfp16_R A64_V 0 Q:1 00111001111001110110 Rn:5  Rd:5
FRSQRTE_asisdmiscfp16_R A64_V 0111111011111001110110 Rn:5  Rd:5
FCMGT_asisdmiscfp16_FZ A64_V 0101111011111000110010 Rn:5  Rd:5
FMUL_asimdsamefp16_only A64_V 0 Q:1 101110010 Rm:5 000111 Rn:5  Rd:5
FSUB_asimdsamefp16_only A64_V 0 Q:1 001110110 Rm:5 000101 Rn:5  Rd:5
FMAX_H_floatdp2 A64_V 00011110111 Rm:5 010010 Rn:5  Rd:5
FADDP_asimdsamefp16_only A64_V 0 Q:1 101110010 Rm:5 000101 Rn:5  Rd:5
FMAXNMP_asimdsamefp16_only A64_V 0 Q:1 101110010 Rm:5 000001 Rn:5  Rd:5
FMUL_asisdelem_RH_H A64_V 0101111100 L:1  M:1  Rm:4 1001 H:1 0 Rn:5  Rd:5
FCMGT_asimdsamefp16_only A64_V 0 Q:1 101110110 Rm:5 001001 Rn:5  Rd:5
FCVTAS_asisdmiscfp16_R A64_V 0101111001111001110010 Rn:5  Rd:5
FADD_asimdsamefp16_only A64_V 0 Q:1 001110010 Rm:5 000101 Rn:5  Rd:5
FCSEL_H_floatsel A64_V 00011110111 Rm:5  cond:4 11 Rn:5  Rd:5
FMAXNM_H_floatdp2 A64_V 00011110111 Rm:5 011010 Rn:5  Rd:5
FMAXNM_asimdsamefp16_only A64_V 0 Q:1 001110010 Rm:5 000001 Rn:5  Rd:5
FMINNMP_asisdpair_only_H A64_V 0101111010110000110010 Rn:5  Rd:5
FNMUL_H_floatdp2 A64_V 00011110111 Rm:5 100010 Rn:5  Rd:5
FCMPE_H_floatcmp A64_V 00011110111 Rm:5 001000 Rn:5 10000
FMUL_asimdelem_RH_H A64_V 0 Q:1 00111100 L:1  M:1  Rm:4 1001 H:1 0 Rn:5  Rd=
:5
FRINTN_asimdmiscfp16_R A64_V 0 Q:1 00111001111001100010 Rn:5  Rd:5
FCCMP_H_floatccmp A64_V 00011110111 Rm:5  cond:4 01 Rn:5 0 nzcv:4
FMADD_H_floatdp3 A64_V 00011111110 Rm:5 0 Ra:5  Rn:5  Rd:5
FCVTZS_asisdmiscfp16_R A64_V 0101111011111001101110 Rn:5  Rd:5
FCVTMS_asisdmiscfp16_R A64_V 0101111001111001101110 Rn:5  Rd:5
FMINP_asimdsamefp16_only A64_V 0 Q:1 101110110 Rm:5 001101 Rn:5  Rd:5
FRECPE_asimdmiscfp16_R A64_V 0 Q:1 00111011111001110110 Rn:5  Rd:5
FCMGE_asisdmiscfp16_FZ A64_V 0111111011111000110010 Rn:5  Rd:5
FNEG_asimdmiscfp16_R A64_V 0 Q:1 10111011111000111110 Rn:5  Rd:5
FCMGE_asisdsamefp16_only A64_V 01111110010 Rm:5 001001 Rn:5  Rd:5
FMULX_asisdelem_RH_H A64_V 0111111100 L:1  M:1  Rm:4 1001 H:1 0 Rn:5  Rd:5
SCVTF_asisdmiscfp16_R A64_V 0101111001111001110110 Rn:5  Rd:5
FMAXNMV_asimdall_only_H A64_V 0 Q:1 00111000110000110010 Rn:5  Rd:5
FMLA_asimdsamefp16_only A64_V 0 Q:1 001110010 Rm:5 000011 Rn:5  Rd:5
FACGT_asisdsamefp16_only A64_V 01111110110 Rm:5 001011 Rn:5  Rd:5
FRINTP_H_floatdp1 A64_V 0001111011100100110000 Rn:5  Rd:5
FRINTZ_asimdmiscfp16_R A64_V 0 Q:1 00111011111001100110 Rn:5  Rd:5
FRINTI_asimdmiscfp16_R A64_V 0 Q:1 10111011111001100110 Rn:5  Rd:5
FDIV_H_floatdp2 A64_V 00011110111 Rm:5 000110 Rn:5  Rd:5
FCVTZS_asimdmiscfp16_R A64_V 0 Q:1 00111011111001101110 Rn:5  Rd:5
FRINTP_asimdmiscfp16_R A64_V 0 Q:1 00111011111001100010 Rn:5  Rd:5
FCCMPE_H_floatccmp A64_V 00011110111 Rm:5  cond:4 01 Rn:5 1 nzcv:4
FCMGT_asisdsamefp16_only A64_V 01111110110 Rm:5 001001 Rn:5  Rd:5
FRINTM_asimdmiscfp16_R A64_V 0 Q:1 00111001111001100110 Rn:5  Rd:5
FMAXP_asimdsamefp16_only A64_V 0 Q:1 101110010 Rm:5 001101 Rn:5  Rd:5
FABD_asisdsamefp16_only A64_V 01111110110 Rm:5 000101 Rn:5  Rd:5
FCMGE_asimdmiscfp16_FZ A64_V 0 Q:1 10111011111000110010 Rn:5  Rd:5
FCMEQ_asimdsamefp16_only A64_V 0 Q:1 001110010 Rm:5 001001 Rn:5  Rd:5
FMINNM_asimdsamefp16_only A64_V 0 Q:1 001110110 Rm:5 000001 Rn:5  Rd:5
FNMADD_H_floatdp3 A64_V 00011111111 Rm:5 0 Ra:5  Rn:5  Rd:5
FRINTI_H_floatdp1 A64_V 0001111011100111110000 Rn:5  Rd:5
FMINNM_H_floatdp2 A64_V 00011110111 Rm:5 011110 Rn:5  Rd:5
FCMLT_asimdmiscfp16_FZ A64_V 0 Q:1 00111011111000111010 Rn:5  Rd:5
FCVTAU_asisdmiscfp16_R A64_V 0111111001111001110010 Rn:5  Rd:5
FCVTNU_asisdmiscfp16_R A64_V 0111111001111001101010 Rn:5  Rd:5
FCVTZU_asisdmiscfp16_R A64_V 0111111011111001101110 Rn:5  Rd:5
FABS_asimdmiscfp16_R A64_V 0 Q:1 00111011111000111110 Rn:5  Rd:5
FMLS_asisdelem_RH_H A64_V 0101111100 L:1  M:1  Rm:4 0101 H:1 0 Rn:5  Rd:5
FCMLT_asisdmiscfp16_FZ A64_V 0101111011111000111010 Rn:5  Rd:5
FMAXP_asisdpair_only_H A64_V 0101111000110000111110 Rn:5  Rd:5
FCVTPS_asisdmiscfp16_R A64_V 0101111011111001101010 Rn:5  Rd:5
FRECPE_asisdmiscfp16_R A64_V 0101111011111001110110 Rn:5  Rd:5
FMINNMV_asimdall_only_H A64_V 0 Q:1 00111010110000110010 Rn:5  Rd:5
FRSQRTE_asimdmiscfp16_R A64_V 0 Q:1 10111011111001110110 Rn:5  Rd:5
FMUL_H_floatdp2 A64_V 00011110111 Rm:5 000010 Rn:5  Rd:5
FMLS_asimdsamefp16_only A64_V 0 Q:1 001110110 Rm:5 000011 Rn:5  Rd:5
FDIV_asimdsamefp16_only A64_V 0 Q:1 101110010 Rm:5 001111 Rn:5  Rd:5
FSUB_H_floatdp2 A64_V 00011110111 Rm:5 001110 Rn:5  Rd:5
FMLS_asimdelem_RH_H A64_V 0 Q:1 00111100 L:1  M:1  Rm:4 0101 H:1 0 Rn:5  Rd=
:5
FMLA_asimdelem_RH_H A64_V 0 Q:1 00111100 L:1  M:1  Rm:4 0001 H:1 0 Rn:5  Rd=
:5
FCVTPU_asimdmiscfp16_R A64_V 0 Q:1 10111011111001101010 Rn:5  Rd:5
FCMLE_asimdmiscfp16_FZ A64_V 0 Q:1 10111011111000110110 Rn:5  Rd:5
FMLA_asisdelem_RH_H A64_V 0101111100 L:1  M:1  Rm:4 0001 H:1 0 Rn:5  Rd:5
FCVTMS_asimdmiscfp16_R A64_V 0 Q:1 00111001111001101110 Rn:5  Rd:5
FRINTM_H_floatdp1 A64_V 0001111011100101010000 Rn:5  Rd:5
FCVTMU_asimdmiscfp16_R A64_V 0 Q:1 10111001111001101110 Rn:5  Rd:5
FCMGE_asimdsamefp16_only A64_V 0 Q:1 101110010 Rm:5 001001 Rn:5  Rd:5
FRSQRTS_asisdsamefp16_only A64_V 01011110110 Rm:5 001111 Rn:5  Rd:5
FCMEQ_asisdsamefp16_only A64_V 01011110010 Rm:5 001001 Rn:5  Rd:5
FRINTZ_H_floatdp1 A64_V 0001111011100101110000 Rn:5  Rd:5
FCVTNS_asimdmiscfp16_R A64_V 0 Q:1 00111001111001101010 Rn:5  Rd:5
FRSQRTS_asimdsamefp16_only A64_V 0 Q:1 001110110 Rm:5 001111 Rn:5  Rd:5
FRINTX_H_floatdp1 A64_V 0001111011100111010000 Rn:5  Rd:5
FRINTA_H_floatdp1 A64_V 0001111011100110010000 Rn:5  Rd:5
FABD_asimdsamefp16_only A64_V 0 Q:1 101110110 Rm:5 000101 Rn:5  Rd:5
FCVTPU_asisdmiscfp16_R A64_V 0111111011111001101010 Rn:5  Rd:5
FACGE_asisdsamefp16_only A64_V 01111110010 Rm:5 001011 Rn:5  Rd:5
FACGT_asimdsamefp16_only A64_V 0 Q:1 101110110 Rm:5 001011 Rn:5  Rd:5
FCMEQ_asisdmiscfp16_FZ A64_V 0101111011111000110110 Rn:5  Rd:5
FCVTAS_asimdmiscfp16_R A64_V 0 Q:1 00111001111001110010 Rn:5  Rd:5
FMULX_asimdsamefp16_only A64_V 0 Q:1 001110010 Rm:5 000111 Rn:5  Rd:5
FMSUB_H_floatdp3 A64_V 00011111110 Rm:5 1 Ra:5  Rn:5  Rd:5
FCVTMU_asisdmiscfp16_R A64_V 0111111001111001101110 Rn:5  Rd:5
FMIN_H_floatdp2 A64_V 00011110111 Rm:5 010110 Rn:5  Rd:5
FSQRT_asimdmiscfp16_R A64_V 0 Q:1 10111011111001111110 Rn:5  Rd:5
FRINTX_asimdmiscfp16_R A64_V 0 Q:1 10111001111001100110 Rn:5  Rd:5
UCVTF_asimdmiscfp16_R A64_V 0 Q:1 10111001111001110110 Rn:5  Rd:5
FNMSUB_H_floatdp3 A64_V 00011111111 Rm:5 1 Ra:5  Rn:5  Rd:5
FCVTNU_asimdmiscfp16_R A64_V 0 Q:1 10111001111001101010 Rn:5  Rd:5
FMINNMP_asimdsamefp16_only A64_V 0 Q:1 101110110 Rm:5 000001 Rn:5  Rd:5
FRECPX_asisdmiscfp16_R A64_V 0101111011111001111110 Rn:5  Rd:5
FMULX_asisdsamefp16_only A64_V 01011110010 Rm:5 000111 Rn:5  Rd:5
FABS_H_floatdp1 A64_V 0001111011100000110000 Rn:5  Rd:5
FMAX_asimdsamefp16_only A64_V 0 Q:1 001110010 Rm:5 001101 Rn:5  Rd:5
FADD_H_floatdp2 A64_V 00011110111 Rm:5 001010 Rn:5  Rd:5
FRINTN_H_floatdp1 A64_V 0001111011100100010000 Rn:5  Rd:5
UCVTF_asisdmiscfp16_R A64_V 0111111001111001110110 Rn:5  Rd:5
FACGE_asimdsamefp16_only A64_V 0 Q:1 101110010 Rm:5 001011 Rn:5  Rd:5
FCMP_H_floatcmp A64_V 00011110111 Rm:5 001000 Rn:5 00000
FSQRT_H_floatdp1 A64_V 0001111011100001110000 Rn:5  Rd:5
FMAXV_asimdall_only_H A64_V 0 Q:1 00111000110000111110 Rn:5  Rd:5
FCVTPS_asimdmiscfp16_R A64_V 0 Q:1 00111011111001101010 Rn:5  Rd:5
FCMLE_asisdmiscfp16_FZ A64_V 0111111011111000110110 Rn:5  Rd:5
FMINV_asimdall_only_H A64_V 0 Q:1 00111010110000111110 Rn:5  Rd:5
FMINP_asisdpair_only_H A64_V 0101111010110000111110 Rn:5  Rd:5
FCMGT_asimdmiscfp16_FZ A64_V 0 Q:1 00111011111000110010 Rn:5  Rd:5
FCMP_HZ_floatcmp A64_V 00011110111 Rm:5 001000 Rn:5 01000
FRECPS_asisdsamefp16_only A64_V 01011110010 Rm:5 001111 Rn:5  Rd:5
FMOV_H_floatimm A64_V 00011110111 imm8:8 10000000 Rd:5
FCVTNS_asisdmiscfp16_R A64_V 0101111001111001101010 Rn:5  Rd:5
FMULX_asimdelem_RH_H A64_V 0 Q:1 10111100 L:1  M:1  Rm:4 1001 H:1 0 Rn:5  R=
d:5
FRINTA_asimdmiscfp16_R A64_V 0 Q:1 10111001111001100010 Rn:5  Rd:5
FCVTAU_asimdmiscfp16_R A64_V 0 Q:1 10111001111001110010 Rn:5  Rd:5
FMIN_asimdsamefp16_only A64_V 0 Q:1 001110110 Rm:5 001101 Rn:5  Rd:5
FCMEQ_asimdmiscfp16_FZ A64_V 0 Q:1 00111011111000110110 Rn:5  Rd:5
FCMPE_HZ_floatcmp A64_V 00011110111 Rm:5 001000 Rn:5 11000
FCVTZU_asimdmiscfp16_R A64_V 0 Q:1 10111011111001101110 Rn:5  Rd:5
FNEG_H_floatdp1 A64_V 0001111011100001010000 Rn:5  Rd:5
FMOV_H_floatdp1 A64_V 0001111011100000010000 Rn:5  Rd:5

And the generated test cases and traces:

  http://people.linaro.org/~alex.bennee/testcases/arm64.risu/testcases.armv=
8.2_half.tar.xz

Currently I'm seeing failures on:

Failed 9 tests:
testcases.armv8.2_half/insn_FCCMP_H_floatccmp__INC.risu.bin
testcases.armv8.2_half/insn_FCCMPE_H_floatccmp__INC.risu.bin
testcases.armv8.2_half/insn_FCMP_H_floatcmp__INC.risu.bin
testcases.armv8.2_half/insn_FCMP_HZ_floatcmp__INC.risu.bin
testcases.armv8.2_half/insn_FCMPE_H_floatcmp__INC.risu.bin
testcases.armv8.2_half/insn_FCMPE_HZ_floatcmp__INC.risu.bin
testcases.armv8.2_half/insn_FCSEL_H_floatsel__INC.risu.bin
testcases.armv8.2_half/insn_FMOV_H_floatimm__INC.risu.bin
testcases.armv8.2_half/insn_FSQRT_H_floatdp1__INC.risu.bin

but I haven't checked to see if that is just instructions the FVP has in
full SVE mode that aren't in the just FP16 fixes branch I was testing
against.


>
> In addition, it tests some edge conditions on data that show flaws
> in the way we were performing integer<->fp conversion; particularly
> with respect to scaled conversion.
>
>
> r~
>
> PS: FWIW, this was written against my tgt-arm-sve-9 tree, since I
> was trying to test sve as generated by gcc.  I don't *think* there
> are any dependencies on any of the sve patches, but I didn't check.
>
> PPS: There are two more failures that might be qemu fp16 failures,
> but those are SIGSEGV.  This patch set cures all of the SIGILL and
> (subsequent) SIGABRT type failures within the testsuite.
>
>
> Richard Henderson (9):
>   target/arm: Implement vector shifted SCVF/UCVF for fp16
>   target/arm: Implement vector shifted FCVT for fp16
>   target/arm: Fix float16 to/from int16
>   target/arm: Clear SVE high bits for FMOV
>   target/arm: Implement FMOV (general) for fp16
>   target/arm: Implement FCVT (scalar,integer) for fp16
>   target/arm: Implement FCVT (scalar,fixed-point) for fp16
>   target/arm: Implement FP data-processing (2 source) for fp16
>   target/arm: Implement FP data-processing (3 source) for fp16
>
>  target/arm/helper.h        |   6 +
>  target/arm/helper.c        |  87 ++++++++++-
>  target/arm/translate-a64.c | 371 +++++++++++++++++++++++++++++++++++++--=
------
>  3 files changed, 399 insertions(+), 65 deletions(-)


--
Alex Benn=C3=A9e
