Received: from eggs.gnu.org ([209.51.188.92]:39233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gpJZz-0000jU-7S
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:09:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gpJZx-0008C6-Mv
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:08:59 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:33521)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gpJZx-00087W-5Q
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:08:57 -0500
Received: by mail-pg1-x52d.google.com with SMTP id z11so1903264pgu.0
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 13:08:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 31 Jan 2019 13:08:49 -0800
Message-Id: <20190131210851.9842-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] decodetree: Support for variable-length
 ISAs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ysato@users.sourceforge.jp

I'm not sure how much simplication could be had for "simple"
variable-length ISAs like ARM thumb2 or RISC-V.

But the recently posted RX port is more complicated than those.
For me, what makes RX more difficult is that there is no easy
test of the first N bits to determine the length of the insn.

I put together a starting point for the RX decode.  I'm sure
there are a few mistakes, but it's close enough to see how the
decoding might work.

I have chosen to have this RX decoder only consider the "base"
instruction, without the "extra" bits like the immediate associated
with the LI field, or the memory displacement associated with
the LD field.

The new decode_load function reads the bytes of the insn with
minimal decoding and no further validation of invalid insns;
that is left for the main decode function.

This is expecting a helper function that assembles the bytes.
While I say I rule out Thumb2+RISC-V above, they are not implausible
examples.  These have uint16_t granularity, and I didn't want to
assume the endianness of the granules.

But for RX, with byte granularity,

uint32_t decode_load_bytes(DisasContext *ctx, uint32_t insn,
                           int i, int n)
{
    while (++i <= n) {
        uint8_t b = cpu_ldub_code(ctx->env, ctx->base.pc_next++);
        insn |= b << (32 - i * 8);
    }
    return insn;
}

For the actual port submission, I would break up the translation
into small bits.  Just a few lines into the decode file and the
associated functions within translate.c.


r~


Richard Henderson (2):
  decodetree: Initial support for variable-length ISAs
  decodetree: Expand a decode_load function

 scripts/decodetree.py | 213 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 200 insertions(+), 13 deletions(-)

---

&bcnd		cd dsp
&jdsp		dsp
&jreg		rs
&rr		rd rs
&ri		rd imm
&rrr		rd rs rs2
&rri		rd imm rs2
&rm		rd rs ld mi
&mi		rs ld mi imm
&mr		rs ld mi rs2

########

%b2_r_0		16:4
%b2_li_2	18:2 !function=li
%b2_li_8	24:2 !function=li
%b2_dsp5_3	23:4 19:1

@b2_rds		.... .... .... rd:4		&rr rs=%b2_r_0
@b2_rds_li	.... .... .... rd:4		&rri rs2=%b2_r_0 imm=%b2_li_8
@b2_rds_uimm4	.... .... imm:4 rd:4		&rri rs2=%b2_r_0
@b2_rds_imm5	.... ... imm:5 rd:4		&rri rs2=%b2_r_0
@b2_rd_rs_li	.... .... rs2:4 rd:4		&rri imm=%b2_li_8
@b2_rd_ld_ub	.... .. ld:2 rs:4 rd:4		&rm mi=4
@b2_ld_imm3	.... .. ld:2 rs:4 . imm:3	&mi mi=4

########

%b3_r_0		8:4
%b3_li_10	18:2 !function=li
%b3_dsp5_8	23:1 16:4

@b3_rd_rs	.... .... .... .... rs:4 rd:4		&rr
@b3_rd_li	.... .... .... .... .... rd:4 \
		&rri rs2=%b3_r_0 imm=%b3_li_10
@b3_rd_ld	.... .... mi:2 .... ld:2 rs:4 rd:4	&rm
@b3_rd_ld_ub	.... .... .... .. ld:2 rs:4 rd:4	&rm mi=4
@b3_rd_ld_ul	.... .... .... .. ld:2 rs:4 rd:4	&rm mi=2
@b3_rd_rs_rs2	.... .... .... rd:4 rs:4 rs2:4		&rrr
@b3_ld_rs2	.... .... .... .. ld:2 rs:4 rs2:4	&mr
@b3_rds_imm5	.... .... ....... imm:5 rd:4		&rri rs2=%b3_r_0
@b3_rd_rs_imm5	.... .... ... imm:5 rs2:4 rd:4		&rri

########

%b4_li_18	18:2 !function=li

@b4_rd_ldmi	.... .... mi:2 .... ld:2 .... .... rs:4 rd:4	&rm

########

ABS_rr		0111 1110 0010 ....			@b2_rds
ABS_rr		1111 1100 0000 1111 .... ....		@b3_rd_rs

ADC_ri		1111 1101 0111 ..00 0000 ....		@b3_rd_li
ADC_rr		1111 1100 0000 1011 .... ....		@b3_rd_rs
# Note only mi==2 allowed.
ADC_rl		0000 0110 ..10 00.. 0000 0010 .... ....	@b4_rd_ldmi

ADD_rri		0110 0010 .... ....			@b2_rds_uimm4
ADD_rri		0111 00.. .... ....			@b2_rd_rs_li
ADD_rl		0100 10.. .... ....			@b2_rd_ld_ub
ADD_rl		0000 0110 ..00 10.. .... ....		@b3_rd_ld
ADD_rrr		1111 1111 0010 .... .... ....		@b3_rd_rs_rs2

AND_rri		0110 0100 .... ....			@b2_rds_uimm4
AND_rri		0111 01.. 0010 ....			@b2_rds_li
AND_rl		0101 00.. .... ....			@b2_rd_ld_ub
AND_rl		0000 0110 ..01 00.. .... ....		@b3_rd_ld
AND_rrr		1111 1111 0100 .... .... ....		@b3_rd_rs_rs2

BCLR_li		1111 00.. .... 1...			@b2_ld_imm3
BCLR_ri		0111 101. .... ....			@b2_rds_imm5
BCLR_lr		1111 1100 0110 01.. .... ....		@b3_ld_rs2 mi=4

BCnd_s		0001 cd:1 dsp:3				&bcnd
BCnd_b		0010 cd:4 dsp:8				&bcnd
BCnd_w		0011 101 cd:1 dsp:16			&bcnd

# Note that BNOT has cd = 15
BMCnd_BNOT_mi	1111 1100 111 imm:3 ld:2 rd:4 cd:4
BMCnd_BNOT_ri	1111 1101 111 imm:5 cd:4 rd:4

BNOT_lr		1111 1100 0110 11.. .... ....		@b3_ld_rs2 mi=2

BRA_s		0000 1 dsp:3				&jdsp
#BRA_b		0010 1110 dsp:8		# overlaps BCnd_b
BRA_w		0011 1000 dsp:16			&jdsp
BRA_a		0000 0100 dsp:24			&jdsp

BRK		0000 0000

BSET_li		1111 00.. .... 0...			@b2_ld_imm3
BSET_ri		0111 100. .... ....			@b2_rds_imm5
BSET_lr		1111 1100 0110 00.. .... ....		@b3_ld_rs2 mi=4

BSR_w		0011 1001 dsp:16			&jdsp
BSR_a		0000 0101 dsp:24			&jdsp

BTST_li		1111 01.. .... 0...			@b2_ld_imm3
BTST_ri		0111 110. .... ....			@b2_rds_imm5
BTST_lr		1111 1100 0110 10.. .... ....		@b3_ld_rs2 mi=4

CLRPSW		0111 1111 1011 cb:4

CMP_ri		0110 0001 .... ....			@b2_rds_uimm4
CMP_ri		0111 0101 0101 rs2:4 imm:8		&rri rd=0
CMP_ri		0111 01.. 0000 rs2:4			&rri imm=%b2_li_8 rd=0
CMP_rl		0100 01.. .... ....			@b2_rd_ld_ub
CMP_rl		0000 0110 ..00 01.. .... ....		@b3_rd_ld

DIV_rri		1111 1101 0111 ..00 1000 ....		@b3_rd_li
DIV_rl		1111 1100 0010 00.. .... ....		@b3_rd_ld_ub
DIV_rl		0000 0110 ..10 00.. 0000 1000 .... ....	@b4_rd_ldmi

DIVU_rri	1111 1101 0111 ..00 1001 ....		@b3_rd_li
DIVU_rl		1111 1100 0010 01.. .... ....		@b3_rd_ld_ub
DIVU_rl		0000 0110 ..10 00.. 0000 1001 .... ....	@b4_rd_ldmi

EMUL_rri	1111 1101 0111 ..00 0110 ....		@b3_rd_li
EMUL_rl		1111 1100 0001 10.. .... ....		@b3_rd_ld_ub
EMUL_rl		0000 0110 ..10 00.. 0000 0110 .... ....	@b4_rd_ldmi

EMULU_rri	1111 1101 0111 ..00 0111 ....		@b3_rd_li
EMULU_rl	1111 1100 0001 11.. .... ....		@b3_rd_ld_ub
EMULU_rl	0000 0110 ..10 00.. 0000 0111 .... ....	@b4_rd_ldmi

FADD_ri		1111 1101 0111 0010 0010 rd:4
FADD_rl		1111 1100 1000 10.. .... ....		@b3_rd_ld_ul

FCMP_ri		1111 1101 0111 0010 0001 rd:4
FCMP_rl		1111 1100 1000 01.. .... ....		@b3_rd_ld_ul

FDIV_ri		1111 1101 0111 0010 0100 rd:4
FDIV_rl		1111 1100 1001 00.. .... ....		@b3_rd_ld_ul

FMUL_ri		1111 1101 0111 0010 0011 rd:4
FMUL_rl		1111 1100 1000 11.. .... ....		@b3_rd_ld_ul

FSUB_ri		1111 1101 0111 0010 0000 rd:4
FSUB_rl		1111 1100 1000 00.. .... ....		@b3_rd_ld_ul

FTOI		1111 1100 1001 01.. .... ....		@b3_rd_ld_ul

INT		0111 0101 0110 0000 imm:8

ITOF		1111 1100 0100 01.. .... ....		@b3_rd_ld_ub
ITOF		0000 0110 ..10 00.. 0001 0001 .... ....	@b4_rd_ldmi

JMP		0111 1111 0000 rs:4			&jreg
JSR		0111 1111 0001 rs:4			&jreg

MACHI		1111 1101 0000 0100 rs:4 rs2:4
MACLO		1111 1101 0000 0101 rs:4 rs2:4

MAX_ri		1111 1101 0111 ..00 0100 ....		@b3_rd_li
MAX_rl		1111 1100 0001 00.. .... ....		@b3_rd_ld_ub
MAX_rl		0000 0110 ..10 00.. 0000 0100 .... ....	@b4_rd_ldmi

MIN_ri		1111 1101 0111 ..00 0101 ....		@b3_rd_li
MIN_rl		1111 1100 0001 01.. .... ....		@b3_rd_ld_ub
MIN_rl		0000 0110 ..10 00.. 0000 0101 .... ....	@b4_rd_ldmi

MOV_mr		1000 0 .... rd:3 . rs:3			dsp=%b2_dsp5_3 mi=4
MOV_mr		1001 0 .... rd:3 . rs:3			dsp=%b2_dsp5_3 mi=3
MOV_mr		1010 0 .... rd:3 . rs:3			dsp=%b2_dsp5_3 mi=2
MOV_rm		1000 1 .... rs:3 . rd:3			dsp=%b2_dsp5_3 mi=0
MOV_rm		1001 1 .... rs:3 . rd:3			dsp=%b2_dsp5_3 mi=1
MOV_rm		1010 1 .... rs:3 . rd:3			dsp=%b2_dsp5_3 mi=2
MOV_ri		0110 0110 imm:4 rd:4
MOV_mi		0011 1100 . rd:3 .... imm:8		sz=0 dsp=%b3_dsp5_8
MOV_mi		0011 1101 . rd:3 .... imm:s8		sz=1 dsp=%b3_dsp5_8
MOV_mi		0011 1110 . rd:3 .... imm:s8		sz=2 dsp=%b3_dsp5_8
MOV_ri		0111 0101 0100 rd:4 imm:8
MOV_ri		1111 1011 rd:4 .. 10			imm=%b2_li_2
MOV_mi		1111 1000 rd:4 .. sz:2			dsp=0 imm=%b2_li_2
MOV_mi		1111 1001 rd:4 .. sz:2 dsp:8		imm=%b3_li_10
MOV_mi		1111 1010 rd:4 .. sz:2 dsp:16		imm=%b4_li_18
MOV_ar		1111 1110 01 sz:2 ri:4 rb:4 rd:4
MOV_ra		1111 1110 00 sz:2 ri:4 rb:4 rs:4
# Note ldd=3 and lds=3 indicate register src or dst
MOV_ll		1100 ldd:2 lds:2 rs:4 rd:4		sz=0
MOV_ll		1101 ldd:2 lds:2 rs:4 rd:4		sz=1
MOV_ll		1110 ldd:2 lds:2 rs:4 rd:4		sz=2
MOV_pr		1111 1101 0010 0 ad:1 sz:2 rd:4 rs:4
MOV_rp		1111 1101 0010 1 ad:1 sz:2 rs:4 rd:4

MOVU_rm		1011 sz:1 ... . rs:3 . rd:3		dsp=%b2_dsp5_3
MOVU_rl		0101 1 sz:1 ld:2 rs:4 rd:4
MOVU_ra		1111 1110 110 sz:1 ri:4 rb:4 rd:4
MOVU_rp		1111 1101 0011 1 ad:1 0 sz:1 rs:4 rd:4

MUL_ri		0110 0011 .... ....			@b2_rds_uimm4
MUL_ri		0111 01.. 0001 ....			@b2_rds_li
MUL_rl		0100 11.. .... ....			@b2_rd_ld_ub
MUL_rl		0000 0110 ..00 11.. .... ....		@b3_rd_ld
MUL_rrr		1111 1111 0011 .... .... ....		@b3_rd_rs_rs2

MULHI		1111 1101 0000 0000 rs:4 rs2:4
MULLO		1111 1101 0000 0001 rs:4 rs2:4

MVFACHI		1111 1101 0001 1111 0000 rd:4
MVFACMI		1111 1101 0001 1111 0010 rd:4

MVFC		1111 1101 0110 1010 cr:4 rd:4

MVTACHI		1111 1101 0001 0111 0000 rs:4
MVTACLO		1111 1101 0001 0111 0001 rs:4

MVTC_i		1111 1101 0111 ..11 0000 cr:4		imm=%b3_li_10
MVTC_r		1111 1101 0110 1000 rs:4 cr:4

NEG_rr		0111 1110 0001 ....			@b2_rds
NEG_rr		1111 1100 0000 0111 .... ....		@b3_rd_rs

NOP		0000 0011

NOT_rr		0111 1110 0000 ....			@b2_rds
NOT_rr		1111 1100 0011 1011 .... ....		@b3_rd_rs

OR_rri		0110 0101 .... ....			@b2_rds_uimm4
OR_rri		0111 01.. 0011 ....			@b2_rds_li
OR_rl		0101 01.. .... ....			@b2_rd_ld_ub
OR_rl		0000 0110 .. 0101 .. .... ....		@b3_rd_ld
OR_rrr		1111 1111 0101 .... .... ....		@b3_rd_rs_rs2

POP		0111 1110 1011 rd:4
POPC		0111 1110 1110 cr:4
POPM		0110 1111 rd:4 rd2:4

PUSH_r		0111 1110 1000 rs:4			sz=0
PUSH_r		0111 1110 1001 rs:4			sz=1
PUSH_r		0111 1110 1010 rs:4			sz=2
PUSH_m		1111 01 ld:2 rs:4 10 sz:2
PUSHC		0111 1110 1100 cr:4
PUSHM		0110 1110 rs:4 rs2:4

RACW		1111 1101 0001 1000 000 imm:1 0000

REVL		1111 1101 0110 0111 rs:4 rd:4
REVW		1111 1101 0110 0101 rs:4 rd:4

# Note that sz=3 overlaps SMOVF
RMPA		0111 1111 1000 1100			sz=0
RMPA		0111 1111 1000 1101			sz=1
RMPA		0111 1111 1000 1110			sz=2

ROLC		0111 1110 0101 ....			@b2_rds
RORC		0111 1110 0100 ....			@b2_rds

ROTL_ri		1111 1101 0110 111. .... ....		@b3_rds_imm5
ROTL_rr		1111 1101 0110 0110 .... ....		@b3_rd_rs

ROTR_ri		1111 1101 0110 110. .... ....		@b3_rds_imm5
ROTR_rr		1111 1101 0110 0100 .... ....		@b3_rd_rs

ROUND		1111 1100 1001 10 ld:2 rs:4 rd:4

RTE		0111 1111 1001 0101

RTFI		0111 1111 1001 0100

RTS		0000 0010

RTSD_i		0110 0111 imm:8
RTSD_irr	0011 1111 rd:4 rd2:4 imm:8

SAT		0111 1110 0011 ....			@b2_rds
SATR		0111 1111 1001 0011

SBB_rr		1111 1100 0000 0011 .... ....		@b3_rd_rs
# Note only mi==2 allowed.
SBB_rl		0000 0110 ..10 00.. 0000 0000 .... ....	@b4_rd_ldmi

SCCnd		1111 1100 1101 sz:2 ld:2 rd:4 cd:4

SCMPU		0111 1111 1000 0011

SETPSW		0111 1111 1010 cb:4

SHAR_rri	0110 101. .... ....			@b2_rds_imm5
SHAR_rri	1111 1101 101. .... .... ....		@b3_rd_rs_imm5
SHAR_rr		1111 1101 0110 0001 .... ....		@b3_rd_rs

SHLL_rri	0110 110. .... ....			@b2_rds_imm5
SHLL_rri	1111 1101 110. .... .... ....		@b3_rd_rs_imm5
SHLL_rr		1111 1101 0110 0010 .... ....		@b3_rd_rs

SHLR_rri	0110 100. .... ....			@b2_rds_imm5
SHLR_rri	1111 1101 100. .... .... ....		@b3_rd_rs_imm5
SHLR_rr		1111 1101 0110 0000 .... ....		@b3_rd_rs

SMOVB		0111 1111 1000 1011
SMOVF		0111 1111 1000 1111
SMOVU		0111 1111 1000 0111

# Note that sz=3 overlaps SMOVB
SSTR		0111 1111 1000 1000			sz=0
SSTR		0111 1111 1000 1001			sz=1
SSTR		0111 1111 1000 1010			sz=2

STNZ		1111 1101 0111 ..00 1111 ....		@b3_rd_li
STZ		1111 1101 0111 ..00 1110 ....		@b3_rd_li

SUB_rri		0110 0000 .... ....			@b2_rds_uimm4
SUB_rl		0100 00.. .... ....			@b2_rd_ld_ub
SUB_rl		0000 0110 ..00 00.. .... ....		@b3_rd_ld
SUB_rrr		1111 1111 0000 .... .... ....		@b3_rd_rs_rs2

# Note that sz=3 overlaps SCMPU
SUNTIL		0111 1111 1000 0000			sz=0
SUNTIL		0111 1111 1000 0001			sz=1
SUNTIL		0111 1111 1000 0010			sz=2

# Note that sz=3 overlaps SMOVU
SWHILE		0111 1111 1000 0100			sz=0
SWHILE		0111 1111 1000 0101			sz=1
SWHILE		0111 1111 1000 0110			sz=2

TST_ri		1111 1101 0111 ..00 1100 ....		@b3_rd_li

WAIT		0111 1111 1001 0110

XCHG_rl		1111 1100 0100 00.. .... ....		@b3_rd_ld_ub
XCHG_rl		0000 0110 ..10 00.. 0001 0000 .... ....	@b4_rd_ldmi

XOR_rri		1111 1101 0111 ..00 1101 ....		@b3_rd_li
XOR_rl		1111 1100 0011 01.. .... ....		@b3_rd_ld_ub
XOR_rl		0000 0110 ..10 00.. 0000 1101 .... ....	@b4_rd_ldmi
