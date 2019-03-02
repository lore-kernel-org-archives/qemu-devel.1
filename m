Received: from eggs.gnu.org ([209.51.188.92]:49585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1gzy45-0002xb-T3
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 01:24:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1gzy29-0002ze-0E
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 01:22:12 -0500
Received: from mail02.asahi-net.or.jp ([202.224.55.14]:36026)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1gzy25-0002sz-1y
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 01:22:03 -0500
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sat,  2 Mar 2019 15:21:28 +0900
Message-Id: <20190302062138.10713-2-ysato@users.sourceforge.jp>
In-Reply-To: <20190302062138.10713-1-ysato@users.sourceforge.jp>
References: <20190122121413.31437-1-ysato@users.sourceforge.jp>
	<20190302062138.10713-1-ysato@users.sourceforge.jp>
Subject: [Qemu-devel] [PATCH RFC v3 01/11] target/rx: TCG Translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, peter.maydell@linaro.org, richard.henderson@linaro.org

This part only supported RXv1 instructions.
Instruction manual.
https://www.renesas.com/us/en/doc/products/mpumcu/doc/rx_family/r01us0032ej0120_rxsm.pdf

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 target/rx/insns.decode |  336 ++++++++
 target/rx/translate.c  | 2220 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 2556 insertions(+)
 create mode 100644 target/rx/insns.decode
 create mode 100644 target/rx/translate.c

diff --git a/target/rx/insns.decode b/target/rx/insns.decode
new file mode 100644
index 0000000000..59de4566e0
--- /dev/null
+++ b/target/rx/insns.decode
@@ -0,0 +1,336 @@
+&bcnd		cd dsp
+&jdsp		dsp
+&jreg		rs
+&rr		rd rs
+&ri		rd imm
+&rrr		rd rs rs2
+&rri		rd imm rs2 len
+&rrli		rd rs2 imm
+&rm		rd rs ld mi
+&mi		rs ld mi imm
+&mr		rs ld mi rs2
+
+########
+
+%b2_r_0		16:4
+%b2_li_2	18:2 !function=li
+%b2_li_8	24:2 !function=li
+%b2_dsp5_3	23:4 19:1
+
+@b2_rds		.... .... .... rd:4		&rr rs=255
+@b2_rds_li	.... .... .... rd:4		&rrli rs2=%b2_r_0 imm=%b2_li_8
+@b2_rds_uimm4	.... .... imm:4 rd:4		&rri rs2=255 len=2
+@b2_rds_imm5	.... ... imm:5 rd:4		&rri rs2=255 len=2
+@b2_rd_rs_li	.... .... rs2:4 rd:4		&rrli imm=%b2_li_8
+@b2_rd_ld_ub	.... .. ld:2 rs:4 rd:4		&rm mi=4
+@b2_ld_imm3	.... .. ld:2 rs:4 . imm:3	&mi mi=4
+
+########
+
+%b3_r_0		8:4
+%b3_li_10	18:2 !function=li
+%b3_dsp5_8	23:1 16:4
+
+@b3_rd_rs	.... .... .... .... rs:4 rd:4		&rr
+@b3_rd_li	.... .... .... .... .... rd:4 \
+		&rrli rs2=%b3_r_0 imm=%b3_li_10
+@b3_rd_ld	.... .... mi:2 .... ld:2 rs:4 rd:4	&rm
+@b3_rd_ld_ub	.... .... .... .. ld:2 rs:4 rd:4	&rm mi=4
+@b3_rd_ld_ul	.... .... .... .. ld:2 rs:4 rd:4	&rm mi=2
+@b3_rd_rs_rs2	.... .... .... rd:4 rs:4 rs2:4		&rrr
+@b3_ld_rs2	.... .... .... .. ld:2 rs:4 rs2:4	&mr
+@b3_rds_imm5	.... .... ....... imm:5 rd:4		&rri rs2=%b3_r_0 len=2
+@b3_rd_rs_imm5	.... .... ... imm:5 rs2:4 rd:4		&rri len=2
+
+########
+
+%b4_li_18	18:2 !function=li
+
+@b4_rd_ldmi	.... .... mi:2 .... ld:2 .... .... rs:4 rd:4	&rm
+
+########
+
+ABS_rr		0111 1110 0010 ....			@b2_rds
+ABS_rr		1111 1100 0000 1111 .... ....		@b3_rd_rs
+
+ADC_rli		1111 1101 0111 ..00 0010 ....		@b3_rd_li
+ADC_rr		1111 1100 0000 1011 .... ....		@b3_rd_rs
+# Note only mi==2 allowed.
+ADC_rl		0000 0110 ..10 00.. 0000 0010 .... ....	@b4_rd_ldmi
+
+ADD_rri		0110 0010 .... ....			@b2_rds_uimm4
+ADD_rrli	0111 00.. .... ....			@b2_rd_rs_li
+ADD_rl		0100 10.. .... ....			@b2_rd_ld_ub
+ADD_rl		0000 0110 ..00 10.. .... ....		@b3_rd_ld
+ADD_rrr		1111 1111 0010 .... .... ....		@b3_rd_rs_rs2
+
+AND_ri		0110 0100 .... ....			@b2_rds_uimm4
+AND_rli		0111 01.. 0010 ....			@b2_rds_li
+AND_rl		0101 00.. .... ....			@b2_rd_ld_ub
+AND_rl		0000 0110 ..01 00.. .... ....		@b3_rd_ld
+AND_rrr		1111 1111 0100 .... .... ....		@b3_rd_rs_rs2
+
+BCLR_li		1111 00.. .... 1...			@b2_ld_imm3
+BCLR_ri		0111 101. .... ....			@b2_rds_imm5
+BCLR_lr		1111 1100 0110 01.. .... ....		@b3_ld_rs2 mi=4
+
+BCnd_s		0001 cd:1 dsp:3				&bcnd
+BCnd_b		0010 cd:4 dsp:8				&bcnd
+BCnd_w		0011 101 cd:1 dsp:16			&bcnd
+
+# Note that BNOT has cd = 15
+BMCnd_BNOT_mi	1111 1100 111 imm:3 ld:2 rd:4 cd:4
+BMCnd_BNOT_ri	1111 1101 111 imm:5 cd:4 rd:4
+
+BNOT_lr		1111 1100 0110 11.. .... ....		@b3_ld_rs2 mi=2
+
+BRA_s		0000 1 dsp:3				&jdsp
+#BRA_b		0010 1110 dsp:8		# overlaps BCnd_b
+BRA_w		0011 1000 dsp:16			&jdsp
+BRA_a		0000 0100 dsp:24			&jdsp
+BRA_l		0111 1111 0100 rd:4
+
+BRK		0000 0000
+
+BSET_li		1111 00.. .... 0...			@b2_ld_imm3
+BSET_ri		0111 100. .... ....			@b2_rds_imm5
+BSET_lr		1111 1100 0110 00.. .... ....		@b3_ld_rs2 mi=4
+
+BSR_w		0011 1001 dsp:16			&jdsp
+BSR_a		0000 0101 dsp:24			&jdsp
+BSR_l		0111 1111 0101 rd:4
+
+BTST_li		1111 01.. .... 0...			@b2_ld_imm3
+BTST_ri		0111 110. .... ....			@b2_rds_imm5
+BTST_lr		1111 1100 0110 10.. .... ....		@b3_ld_rs2 mi=4
+
+CLRPSW		0111 1111 1011 cb:4
+
+CMP_ri		0110 0001 .... ....			@b2_rds_uimm4
+CMP_ri		0111 0101 0101 rs2:4 imm:8		&rri rd=0 len=3
+CMP_rli		0111 01.. 0000 rs2:4			&rrli imm=%b2_li_8 rd=0
+CMP_rl		0100 01.. .... ....			@b2_rd_ld_ub
+CMP_rl		0000 0110 ..00 01.. .... ....		@b3_rd_ld
+
+DIV_ri		1111 1101 0111 ..00 1000 ....		@b3_rd_li
+DIV_rl		1111 1100 0010 00.. .... ....		@b3_rd_ld_ub
+DIV_rl		0000 0110 ..10 00.. 0000 1000 .... ....	@b4_rd_ldmi
+
+DIVU_ri		1111 1101 0111 ..00 1001 ....		@b3_rd_li
+DIVU_rl		1111 1100 0010 01.. .... ....		@b3_rd_ld_ub
+DIVU_rl		0000 0110 ..10 00.. 0000 1001 .... ....	@b4_rd_ldmi
+
+EMUL_ri		1111 1101 0111 ..00 0110 ....		@b3_rd_li
+EMUL_rl		1111 1100 0001 10.. .... ....		@b3_rd_ld_ub
+EMUL_rl		0000 0110 ..10 00.. 0000 0110 .... ....	@b4_rd_ldmi
+
+EMULU_ri	1111 1101 0111 ..00 0111 ....		@b3_rd_li
+EMULU_rl	1111 1100 0001 11.. .... ....		@b3_rd_ld_ub
+EMULU_rl	0000 0110 ..10 00.. 0000 0111 .... ....	@b4_rd_ldmi
+
+FADD_ri		1111 1101 0111 0010 0010 rd:4
+FADD_rl		1111 1100 1000 10.. .... ....		@b3_rd_ld_ul
+
+FCMP_ri		1111 1101 0111 0010 0001 rd:4
+FCMP_rl		1111 1100 1000 01.. .... ....		@b3_rd_ld_ul
+
+FDIV_ri		1111 1101 0111 0010 0100 rd:4
+FDIV_rl		1111 1100 1001 00.. .... ....		@b3_rd_ld_ul
+
+FMUL_ri		1111 1101 0111 0010 0011 rd:4
+FMUL_rl		1111 1100 1000 11.. .... ....		@b3_rd_ld_ul
+
+FSUB_ri		1111 1101 0111 0010 0000 rd:4
+FSUB_rl		1111 1100 1000 00.. .... ....		@b3_rd_ld_ul
+
+FTOI		1111 1100 1001 01.. .... ....		@b3_rd_ld_ul
+
+INT		0111 0101 0110 0000 imm:8
+
+ITOF		1111 1100 0100 01.. .... ....		@b3_rd_ld_ub
+ITOF		0000 0110 ..10 00.. 0001 0001 .... ....	@b4_rd_ldmi
+
+JMP		0111 1111 0000 rs:4			&jreg
+JSR		0111 1111 0001 rs:4			&jreg
+
+MACHI		1111 1101 0000 0100 rs:4 rs2:4
+MACLO		1111 1101 0000 0101 rs:4 rs2:4
+
+MAX_ri		1111 1101 0111 ..00 0100 ....		@b3_rd_li
+MAX_rl		1111 1100 0001 00.. .... ....		@b3_rd_ld_ub
+MAX_rl		0000 0110 ..10 00.. 0000 0100 .... ....	@b4_rd_ldmi
+
+MIN_ri		1111 1101 0111 ..00 0101 ....		@b3_rd_li
+MIN_rl		1111 1100 0001 01.. .... ....		@b3_rd_ld_ub
+MIN_rl		0000 0110 ..10 00.. 0000 0101 .... ....	@b4_rd_ldmi
+
+MOV_mr		1000 0 .... rd:3 . rs:3			dsp=%b2_dsp5_3 sz=0
+MOV_mr		1001 0 .... rd:3 . rs:3			dsp=%b2_dsp5_3 sz=1
+MOV_mr		1010 0 .... rd:3 . rs:3			dsp=%b2_dsp5_3 sz=2
+MOV_rm		1000 1 .... rs:3 . rd:3			dsp=%b2_dsp5_3 sz=0
+MOV_rm		1001 1 .... rs:3 . rd:3			dsp=%b2_dsp5_3 sz=1
+MOV_rm		1010 1 .... rs:3 . rd:3			dsp=%b2_dsp5_3 sz=2
+MOV_ri		0110 0110 imm:4 rd:4 len=2
+MOV_mi		0011 1100 . rd:3 .... imm:8		sz=0 dsp=%b3_dsp5_8
+MOV_mi		0011 1101 . rd:3 .... imm:8		sz=1 dsp=%b3_dsp5_8
+MOV_mi		0011 1110 . rd:3 .... imm:8		sz=2 dsp=%b3_dsp5_8
+MOV_ri		0111 0101 0100 rd:4 imm:8 len=3
+MOV_rli		1111 1011 rd:4 .. 10			imm=%b2_li_2
+MOV_mli		1111 1000 rd:4 .. sz:2			dsp=0 imm=%b2_li_2 ld=0
+MOV_mli		1111 1001 rd:4 .. sz:2 dsp:8		imm=%b3_li_10 ld=1
+MOV_mli		1111 1010 rd:4 .. sz:2 dsp:16		imm=%b4_li_18 ld=2
+MOV_ra		1111 1110 01 sz:2 ri:4 rb:4 rd:4
+MOV_ar		1111 1110 00 sz:2 ri:4 rb:4 rs:4
+# Note ldd=3 and lds=3 indicate register src or dst
+MOV_ll		1100 ldd:2 lds:2 rs:4 rd:4		sz=0
+MOV_ll		1101 ldd:2 lds:2 rs:4 rd:4		sz=1
+MOV_ll		1110 ldd:2 lds:2 rs:4 rd:4		sz=2
+MOV_pr		1111 1101 0010 0 ad:1 sz:2 rd:4 rs:4
+MOV_rp		1111 1101 0010 1 ad:1 sz:2 rd:4 rs:4
+
+MOVU_rm		1011 sz:1 ... . rs:3 . rd:3		dsp=%b2_dsp5_3
+MOVU_rl		0101 1 sz:1 ld:2 rs:4 rd:4
+MOVU_ra		1111 1110 110 sz:1 ri:4 rb:4 rd:4
+MOVU_rp		1111 1101 0011 1 ad:1 0 sz:1 rs:4 rd:4
+
+MUL_ri		0110 0011 .... ....			@b2_rds_uimm4
+MUL_rli		0111 01.. 0001 ....			@b2_rds_li
+MUL_rl		0100 11.. .... ....			@b2_rd_ld_ub
+MUL_rl		0000 0110 ..00 11.. .... ....		@b3_rd_ld
+MUL_rrr		1111 1111 0011 .... .... ....		@b3_rd_rs_rs2
+
+MULHI		1111 1101 0000 0000 rs:4 rs2:4
+MULLO		1111 1101 0000 0001 rs:4 rs2:4
+
+MVFACHI		1111 1101 0001 1111 0000 rd:4
+MVFACMI		1111 1101 0001 1111 0010 rd:4
+
+MVFC		1111 1101 0110 1010 cr:4 rd:4
+
+MVTACHI		1111 1101 0001 0111 0000 rs:4
+MVTACLO		1111 1101 0001 0111 0001 rs:4
+
+MVTC_i		1111 1101 0111 ..11 0000 cr:4		imm=%b3_li_10
+MVTC_r		1111 1101 0110 1000 rs:4 cr:4
+
+MVTIPL		0111 0101 0111 0000 0000 imm:4
+
+NEG_rr		0111 1110 0001 ....			@b2_rds
+NEG_rr		1111 1100 0000 0111 .... ....		@b3_rd_rs
+
+NOP		0000 0011
+
+NOT_rr		0111 1110 0000 ....			@b2_rds
+NOT_rr		1111 1100 0011 1011 .... ....		@b3_rd_rs
+
+OR_ri		0110 0101 .... ....			@b2_rds_uimm4
+OR_rli		0111 01.. 0011 ....			@b2_rds_li
+OR_rl		0101 01.. .... ....			@b2_rd_ld_ub
+OR_rl		0000 0110 .. 0101 .. .... ....		@b3_rd_ld
+OR_rrr		1111 1111 0101 .... .... ....		@b3_rd_rs_rs2
+
+POP		0111 1110 1011 rd:4
+POPC		0111 1110 1110 cr:4
+POPM		0110 1111 rd:4 rd2:4
+
+PUSH_r		0111 1110 1000 rs:4			sz=0
+PUSH_r		0111 1110 1001 rs:4			sz=1
+PUSH_r		0111 1110 1010 rs:4			sz=2
+PUSH_m		1111 01 ld:2 rs:4 10 sz:2
+PUSHC		0111 1110 1100 cr:4
+PUSHM		0110 1110 rs:4 rs2:4
+
+RACW		1111 1101 0001 1000 000 imm:1 0000
+
+REVL		1111 1101 0110 0111 rs:4 rd:4
+REVW		1111 1101 0110 0101 rs:4 rd:4
+
+# Note that sz=3 overlaps SMOVF
+RMPA		0111 1111 1000 1100			sz=0
+RMPA		0111 1111 1000 1101			sz=1
+RMPA		0111 1111 1000 1110			sz=2
+
+ROLC		0111 1110 0101 ....			@b2_rds
+RORC		0111 1110 0100 ....			@b2_rds
+
+ROTL_ri		1111 1101 0110 111. .... ....		@b3_rds_imm5
+ROTL_rr		1111 1101 0110 0110 .... ....		@b3_rd_rs
+
+ROTR_ri		1111 1101 0110 110. .... ....		@b3_rds_imm5
+ROTR_rr		1111 1101 0110 0100 .... ....		@b3_rd_rs
+
+ROUND		1111 1100 1001 10 ld:2 rs:4 rd:4
+
+RTE		0111 1111 1001 0101
+
+RTFI		0111 1111 1001 0100
+
+RTS		0000 0010
+
+RTSD_i		0110 0111 imm:8
+RTSD_irr	0011 1111 rd:4 rd2:4 imm:8
+
+SAT		0111 1110 0011 ....			@b2_rds
+SATR		0111 1111 1001 0011
+
+SBB_rr		1111 1100 0000 0011 .... ....		@b3_rd_rs
+# Note only mi==2 allowed.
+SBB_rl		0000 0110 ..10 00.. 0000 0000 .... ....	@b4_rd_ldmi
+
+SCCnd		1111 1100 1101 sz:2 ld:2 rd:4 cd:4
+
+SCMPU		0111 1111 1000 0011
+
+SETPSW		0111 1111 1010 cb:4
+
+SHAR_rri	0110 101. .... ....			@b2_rds_imm5
+SHAR_rri	1111 1101 101. .... .... ....		@b3_rd_rs_imm5
+SHAR_rr		1111 1101 0110 0001 .... ....		@b3_rd_rs
+
+SHLL_rri	0110 110. .... ....			@b2_rds_imm5
+SHLL_rri	1111 1101 110. .... .... ....		@b3_rd_rs_imm5
+SHLL_rr		1111 1101 0110 0010 .... ....		@b3_rd_rs
+
+SHLR_rri	0110 100. .... ....			@b2_rds_imm5
+SHLR_rri	1111 1101 100. .... .... ....		@b3_rd_rs_imm5
+SHLR_rr		1111 1101 0110 0000 .... ....		@b3_rd_rs
+
+SMOVB		0111 1111 1000 1011
+SMOVF		0111 1111 1000 1111
+SMOVU		0111 1111 1000 0111
+
+# Note that sz=3 overlaps SMOVB
+SSTR		0111 1111 1000 1000			sz=0
+SSTR		0111 1111 1000 1001			sz=1
+SSTR		0111 1111 1000 1010			sz=2
+
+STNZ		1111 1101 0111 ..00 1111 ....		@b3_rd_li
+STZ		1111 1101 0111 ..00 1110 ....		@b3_rd_li
+
+SUB_ri		0110 0000 .... ....			@b2_rds_uimm4
+SUB_rl		0100 00.. .... ....			@b2_rd_ld_ub
+SUB_rl		0000 0110 ..00 00.. .... ....		@b3_rd_ld
+SUB_rrr		1111 1111 0000 .... .... ....		@b3_rd_rs_rs2
+
+# Note that sz=3 overlaps SCMPU
+SUNTIL		0111 1111 1000 0000			sz=0
+SUNTIL		0111 1111 1000 0001			sz=1
+SUNTIL		0111 1111 1000 0010			sz=2
+
+# Note that sz=3 overlaps SMOVU
+SWHILE		0111 1111 1000 0100			sz=0
+SWHILE		0111 1111 1000 0101			sz=1
+SWHILE		0111 1111 1000 0110			sz=2
+
+TST_rli		1111 1101 0111 ..00 1100 ....		@b3_rd_li
+TST_rl		1111 1100 0011 00.. .... ....		@b3_rd_ld_ub
+TST_rl		0000 0110 ..10 00.. 0000 1100 .... .... @b4_rd_ldmi
+
+WAIT		0111 1111 1001 0110
+
+XCHG_rl		1111 1100 0100 00.. .... ....		@b3_rd_ld_ub
+XCHG_rl		0000 0110 ..10 00.. 0001 0000 .... ....	@b4_rd_ldmi
+
+XOR_rli		1111 1101 0111 ..00 1101 ....		@b3_rd_li
+XOR_rl		1111 1100 0011 01.. .... ....		@b3_rd_ld_ub
+XOR_rl		0000 0110 ..10 00.. 0000 1101 .... ....	@b4_rd_ldmi
diff --git a/target/rx/translate.c b/target/rx/translate.c
new file mode 100644
index 0000000000..ee4ee5a760
--- /dev/null
+++ b/target/rx/translate.c
@@ -0,0 +1,2220 @@
+/*
+ *  RX translation
+ *
+ *  Copyright (c) 2019 Yoshinori Sato
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bswap.h"
+#include "cpu.h"
+#include "disas/disas.h"
+#include "exec/exec-all.h"
+#include "tcg-op.h"
+#include "exec/cpu_ldst.h"
+#include "exec/helper-proto.h"
+#include "exec/helper-gen.h"
+#include "exec/translator.h"
+#include "trace-tcg.h"
+#include "exec/log.h"
+
+typedef struct DisasContext {
+    DisasContextBase base;
+    CPURXState *env;
+    TCGv src;
+} DisasContext;
+
+/* Target-specific values for dc->base.is_jmp.  */
+#define DISAS_JUMP    DISAS_TARGET_0
+
+/* global register indexes */
+static TCGv cpu_regs[16];
+static TCGv cpu_psw, cpu_psw_o, cpu_psw_s, cpu_psw_z, cpu_psw_c;
+static TCGv cpu_psw_i, cpu_psw_pm, cpu_psw_u, cpu_psw_ipl;
+static TCGv cpu_usp, cpu_fpsw, cpu_bpsw, cpu_bpc, cpu_isp;
+static TCGv cpu_fintv, cpu_intb, cpu_pc;
+static TCGv_i64 cpu_acc;
+static TCGv cpu_pswop, cpu_pswop_v[3];
+
+#include "exec/gen-icount.h"
+
+static uint32_t decode_load_bytes(DisasContext *ctx, uint32_t insn,
+                           int i, int n)
+{
+    while (++i <= n) {
+        uint8_t b = cpu_ldub_code(ctx->env, ctx->base.pc_next++);
+        insn |= b << (32 - i * 8);
+    }
+    return insn;
+}
+
+static uint32_t li(DisasContext *ctx, int sz)
+{
+    int32_t tmp, addr;
+    CPURXState *env = ctx->env;
+    addr = ctx->base.pc_next;
+
+    switch (sz) {
+    case 1:
+        ctx->base.pc_next += 1;
+        return cpu_ldsb_code(env, addr);
+    case 2:
+        ctx->base.pc_next += 2;
+        return cpu_ldsw_code(env, addr);
+    case 3:
+        ctx->base.pc_next += 3;
+        tmp = cpu_ldsb_code(env, addr + 2) << 16;
+        tmp |= cpu_lduw_code(env, addr) & 0xffff;
+        return tmp;
+    case 0:
+        ctx->base.pc_next += 4;
+        return cpu_ldl_code(env, addr);
+    default:
+        g_assert_not_reached();
+    }
+}
+
+/* Include the auto-generated decoder.  */
+#include "decode.inc.c"
+
+void rx_cpu_dump_state(CPUState *cs, FILE *f,
+                           fprintf_function cpu_fprintf, int flags)
+{
+    RXCPU *cpu = RXCPU(cs);
+    CPURXState *env = &cpu->env;
+    int i;
+    uint32_t psw;
+
+    psw = pack_psw(env);
+    cpu_fprintf(f, "pc=0x%08x psw=0x%08x\n",
+                env->pc, psw);
+    for (i = 0; i < 16; i += 4) {
+        cpu_fprintf(f, "r%d=0x%08x r%d=0x%08x r%d=0x%08x r%d=0x%08x\n",
+                    i, env->regs[i], i + 1, env->regs[i + 1],
+                    i + 2, env->regs[i + 2], i + 3, env->regs[i + 3]);
+    }
+}
+
+static inline void gen_save_cpu_state(DisasContext *dc, bool save_pc)
+{
+    if (save_pc) {
+        tcg_gen_movi_i32(cpu_pc, dc->base.pc_next);
+    }
+}
+
+static inline bool use_goto_tb(DisasContext *dc, target_ulong dest)
+{
+    if (unlikely(dc->base.singlestep_enabled)) {
+        return false;
+    } else {
+        return true;
+    }
+}
+
+static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
+{
+    if (use_goto_tb(dc, dest)) {
+        tcg_gen_goto_tb(n);
+        tcg_gen_movi_i32(cpu_pc, dest);
+        tcg_gen_exit_tb(dc->base.tb, n);
+    } else {
+        tcg_gen_movi_i32(cpu_pc, dest);
+        if (dc->base.singlestep_enabled) {
+            gen_helper_debug(cpu_env);
+        } else {
+            tcg_gen_lookup_and_goto_ptr();
+        }
+    }
+    dc->base.is_jmp = DISAS_NORETURN;
+}
+
+#define RX_MEMORY_ST 0
+#define RX_MEMORY_LD 1
+#define RX_MEMORY_BYTE 0
+#define RX_MEMORY_WORD 1
+#define RX_MEMORY_LONG 2
+
+#define RX_OP_AND 0
+#define RX_OP_OR 1
+#define RX_OP_XOR 2
+#define RX_OP_TST 3
+
+#define RX_MI_BYTE 0
+#define RX_MI_WORD 1
+#define RX_MI_LONG 2
+#define RX_MI_UWORD 3
+
+/* generic load / store wrapper */
+static inline void rx_gen_ldst(unsigned int size, unsigned int dir,
+                        TCGv reg, TCGv mem)
+{
+    if (dir) {
+        tcg_gen_qemu_ld_i32(reg, mem, 0, size | MO_SIGN | MO_TE);
+    } else {
+        tcg_gen_qemu_st_i32(reg, mem, 0, size | MO_TE);
+    }
+}
+
+/* unsigned load */
+static inline void rx_gen_ldu(unsigned int size, TCGv reg, TCGv mem)
+{
+    tcg_gen_qemu_ld_i32(reg, mem, 0, size | MO_TE);
+}
+
+/* [ri, rb] */
+static inline void rx_gen_regindex(DisasContext *ctx, int size, int ri, int rb)
+{
+    tcg_gen_shli_i32(ctx->src, cpu_regs[ri], size);
+    tcg_gen_add_i32(ctx->src, ctx->src, cpu_regs[rb]);
+}
+
+/* dsp[reg] */
+static inline void rx_index_addr(int ld, int size, int reg,
+                          DisasContext *ctx)
+{
+    uint32_t dsp;
+
+    switch (ld) {
+    case 0:
+        tcg_gen_mov_i32(ctx->src, cpu_regs[reg]);
+        break;
+    case 1:
+        dsp = cpu_ldub_code(ctx->env, ctx->base.pc_next) << size;
+        tcg_gen_addi_i32(ctx->src, cpu_regs[reg], dsp);
+        ctx->base.pc_next += 1;
+        break;
+    case 2:
+        dsp = cpu_lduw_code(ctx->env, ctx->base.pc_next) << size;
+        tcg_gen_addi_i32(ctx->src, cpu_regs[reg], dsp);
+        ctx->base.pc_next += 2;
+        break;
+    }
+}
+
+/* load source operand */
+static inline TCGv rx_load_source(DisasContext *ctx, int ld, int mi, int rs)
+{
+    if (ld < 3) {
+        switch (mi) {
+        case 4:
+            /* dsp[rs].ub */
+            rx_index_addr(ld, RX_MEMORY_BYTE, rs, ctx);
+            rx_gen_ldu(RX_MEMORY_BYTE, ctx->src, ctx->src);
+            break;
+        case 3:
+            /* dsp[rs].uw */
+            rx_index_addr(ld, RX_MEMORY_WORD, rs, ctx);
+            rx_gen_ldu(RX_MEMORY_WORD, ctx->src, ctx->src);
+            break;
+        default:
+            rx_index_addr(ld, mi, rs, ctx);
+            rx_gen_ldst(mi, RX_MEMORY_LD, ctx->src, ctx->src);
+            break;
+        }
+        return ctx->src;
+    } else {
+        return cpu_regs[rs];
+    }
+}
+
+/* mov.[bwl] rs,dsp5[rd] */
+static bool trans_MOV_mr(DisasContext *ctx, arg_MOV_mr *a)
+{
+    tcg_gen_addi_i32(ctx->src, cpu_regs[a->rd], a->dsp << a->sz);
+    rx_gen_ldst(a->sz, RX_MEMORY_ST, cpu_regs[a->rs], ctx->src);
+    return true;
+}
+
+/* mov.[bwl] dsp[rd],rs */
+static bool trans_MOV_rm(DisasContext *ctx, arg_MOV_rm *a)
+{
+    tcg_gen_addi_i32(ctx->src, cpu_regs[a->rd], a->dsp << a->sz);
+    rx_gen_ldst(a->sz, RX_MEMORY_LD, cpu_regs[a->rs], ctx->src);
+    return true;
+}
+
+/* mov.l #uimm4,rd */
+/* mov.l #uimm8,rd */
+static bool trans_MOV_ri(DisasContext *ctx, arg_MOV_ri *a)
+{
+    tcg_gen_movi_i32(cpu_regs[a->rd], a->imm & 0xff);
+    return true;
+}
+
+/* mov.[bwl] #uimm8,dsp[rd] */
+static bool trans_MOV_mi(DisasContext *ctx, arg_MOV_mi *a)
+{
+    TCGv imm = tcg_const_i32(a->imm & 0xff);
+    tcg_gen_addi_i32(ctx->src, cpu_regs[a->rd], a->dsp << a->sz);
+    rx_gen_ldst(a->sz, RX_MEMORY_ST, imm, ctx->src);
+    tcg_temp_free(imm);
+    return true;
+}
+
+/* mov.l #imm,rd */
+static bool trans_MOV_rli(DisasContext *ctx, arg_MOV_rli *a)
+{
+    tcg_gen_movi_i32(cpu_regs[a->rd], a->imm);
+    return true;
+}
+
+
+/* mov #imm, dsp[rd] */
+static bool trans_MOV_mli(DisasContext *ctx, arg_MOV_mli *a)
+{
+    TCGv imm = tcg_const_i32(a->imm);
+    if (a->ld == 2) {
+        a->dsp = bswap_16(a->dsp);
+    }
+    tcg_gen_addi_i32(ctx->src, cpu_regs[a->rd], a->dsp << a->sz);
+    rx_gen_ldst(a->sz, RX_MEMORY_ST, imm, ctx->src);
+    tcg_temp_free(imm);
+    return true;
+}
+
+
+/* mov.[bwl] [ri,rb],rd */
+static bool trans_MOV_ra(DisasContext *ctx, arg_MOV_ra *a)
+{
+    rx_gen_regindex(ctx, a->sz, a->ri, a->rb);
+    rx_gen_ldst(a->sz, RX_MEMORY_LD, cpu_regs[a->rd], ctx->src);
+    return true;
+}
+
+/* mov.[bwl] rd,[ri,rb] */
+static bool trans_MOV_ar(DisasContext *ctx, arg_MOV_ar *a)
+{
+    rx_gen_regindex(ctx, a->sz, a->ri, a->rb);
+    rx_gen_ldst(a->sz, RX_MEMORY_ST, cpu_regs[a->rs], ctx->src);
+    return true;
+}
+
+
+/* mov.[bwl] dsp[rs],dsp[rd] */
+/* mov.[bwl] rs,dsp[rd] */
+/* mov.[bwl] dsp[rs],rd */
+/* mov.[bwl] rs,rd */
+static bool trans_MOV_ll(DisasContext *ctx, arg_MOV_ll *a)
+{
+    int rs, rd;
+    static void (* const mov[])(TCGv ret, TCGv arg) = {
+        tcg_gen_ext8s_i32, tcg_gen_ext16s_i32, tcg_gen_mov_i32,
+    };
+    TCGv tmp;
+    if (a->lds == 3 && a->ldd < 3) {
+        rs = a->rd;
+        rd = a->rs;
+    } else {
+        rs = a->rs;
+        rd = a->rd;
+    }
+    if (a->lds == 3 && a->ldd == 3) {
+        /* mov.[bwl] rs,rd */
+        mov[a->sz](cpu_regs[rd], cpu_regs[rs]);
+    } else if (a->lds == 3) {
+        /* mov.[bwl] rs,dsp[rd] */
+        rx_index_addr(a->ldd, a->sz, rd, ctx);
+        rx_gen_ldst(a->sz, RX_MEMORY_ST, cpu_regs[rs], ctx->src);
+    } else if (a->ldd == 3) {
+        /* mov.[bwl] dsp[rs],rd */
+        rx_index_addr(a->lds, a->sz, rs, ctx);
+        rx_gen_ldst(a->sz, RX_MEMORY_LD, cpu_regs[rd], ctx->src);
+    } else {
+        /* mov.[bwl] dsp[rs],dsp[rd] */
+        tmp = tcg_temp_new();
+        rx_index_addr(a->lds, a->sz, rs, ctx);
+        rx_gen_ldst(a->sz, RX_MEMORY_LD, tmp, ctx->src);
+        rx_index_addr(a->ldd, a->sz, rd, ctx);
+        rx_gen_ldst(a->sz, RX_MEMORY_ST, tmp, ctx->src);
+        tcg_temp_free(tmp);
+    }
+    return true;
+}
+
+#define MOV_prrp(dir)                                                   \
+    do {                                                                \
+        if (a->ad == 1) {                                               \
+            tcg_gen_subi_i32(cpu_regs[a->rd],                           \
+                             cpu_regs[a->rd], 1 << a->sz);              \
+        }                                                               \
+        rx_gen_ldst(a->sz, dir, cpu_regs[a->rs], cpu_regs[a->rd]);      \
+        if (a->ad == 0) {                                               \
+            tcg_gen_addi_i32(cpu_regs[a->rd],                           \
+                             cpu_regs[a->rd], 1 << a->sz);              \
+        }                                                               \
+        return true;                                                    \
+    } while (0)
+
+/* mov.[bwl] rs,[rd+] */
+/* mov.[bwl] rs,[-rd] */
+static bool trans_MOV_pr(DisasContext *ctx, arg_MOV_pr *a)
+{
+    MOV_prrp(RX_MEMORY_ST);
+}
+
+/* mov.[bwl] [rd+],rs */
+/* mov.[bwl] [-rd],rs */
+static bool trans_MOV_rp(DisasContext *ctx, arg_MOV_rp *a)
+{
+   MOV_prrp(RX_MEMORY_LD);
+}
+
+/* movu.[bw] dsp5[rs],rd */
+static bool trans_MOVU_rm(DisasContext *ctx, arg_MOVU_rm *a)
+{
+    tcg_gen_addi_i32(ctx->src, cpu_regs[a->rs], a->dsp << a->sz);
+    rx_gen_ldu(a->sz, cpu_regs[a->rd], ctx->src);
+    return true;
+}
+
+/* movu.[bw] rs,rd */
+/* movu.[bw] dsp[rs],rd */
+static bool trans_MOVU_rl(DisasContext *ctx, arg_MOVU_rl *a)
+{
+    static void (* const ext[])(TCGv ret, TCGv arg) = {
+        tcg_gen_ext8u_i32, tcg_gen_ext16u_i32,
+    };
+
+    if (a->ld < 3) {
+        /* from memory */
+        rx_index_addr(a->ld, a->sz, a->rs, ctx);
+        rx_gen_ldu(a->sz, cpu_regs[a->rd], ctx->src);
+    } else {
+        ext[a->sz](cpu_regs[a->rd], cpu_regs[a->rs]);
+    }
+    return true;
+}
+
+/* movu.[bw] [ri,rb],rd */
+static bool trans_MOVU_ra(DisasContext *ctx, arg_MOVU_ra *a)
+{
+    rx_gen_regindex(ctx, a->sz, a->ri, a->rb);
+    rx_gen_ldu(a->sz, cpu_regs[a->rd], ctx->src);
+    return true;
+}
+
+/* movu.[bw] [rs+],rd */
+/* movu.[bw] [-rs],rd */
+static bool trans_MOVU_rp(DisasContext *ctx, arg_MOVU_rp *a)
+{
+    if (a->ad == 1) {
+        tcg_gen_subi_i32(cpu_regs[a->rs], cpu_regs[a->rs], 1 << a->sz);
+    }
+    rx_gen_ldu(a->sz, cpu_regs[a->rd], cpu_regs[a->rs]);
+    if (a->ad == 0) {
+        tcg_gen_addi_i32(cpu_regs[a->rs], cpu_regs[a->rs], 1 << a->sz);
+    }
+    return true;
+}
+
+/* pop rd */
+static bool trans_POP(DisasContext *ctx, arg_POP *a)
+{
+    rx_gen_ldst(RX_LONG, RX_MEMORY_LD, cpu_regs[a->rd], cpu_regs[0]);
+    if (a->rd != 0) {
+        tcg_gen_addi_i32(cpu_regs[0], cpu_regs[0], 4);
+    }
+    return true;
+}
+
+/* popc rx */
+static bool trans_POPC(DisasContext *ctx, arg_POPC *a)
+{
+
+    TCGv cr = tcg_const_i32(a->cr);
+    rx_gen_ldst(RX_LONG, RX_MEMORY_LD, ctx->src, cpu_regs[0]);
+    tcg_gen_addi_i32(cpu_regs[0], cpu_regs[0], 4);
+    gen_helper_mvtc(cpu_env, cr, ctx->src);
+    tcg_temp_free(cr);
+    return true;
+}
+
+/* popm rd-rd2 */
+static bool trans_POPM(DisasContext *ctx, arg_POPM *a)
+{
+    int r;
+
+    for (r = a->rd; r <= a->rd2; r++) {
+        rx_gen_ldst(RX_LONG, RX_MEMORY_LD, cpu_regs[r], cpu_regs[0]);
+        tcg_gen_addi_i32(cpu_regs[0], cpu_regs[0], 4);
+    }
+    return true;
+}
+
+/* push rs */
+static bool trans_PUSH_r(DisasContext *ctx, arg_PUSH_r *a)
+{
+    if (a->rs != 0) {
+        tcg_gen_subi_i32(cpu_regs[0], cpu_regs[0], 4);
+        rx_gen_ldst(a->sz, RX_MEMORY_ST, cpu_regs[a->rs], cpu_regs[0]);
+    } else {
+        tcg_gen_mov_i32(ctx->src, cpu_regs[a->rs]);
+        tcg_gen_subi_i32(cpu_regs[0], cpu_regs[0], 4);
+        rx_gen_ldst(a->sz, RX_MEMORY_ST, ctx->src, cpu_regs[0]);
+    }
+    return true;
+}
+
+/* push dsp[rs] */
+static bool trans_PUSH_m(DisasContext *ctx, arg_PUSH_m *a)
+{
+    rx_index_addr(a->ld, a->sz, a->rs, ctx);
+    rx_gen_ldst(a->sz, RX_MEMORY_LD, ctx->src, ctx->src);
+    tcg_gen_subi_i32(cpu_regs[0], cpu_regs[0], 4);
+    rx_gen_ldst(a->sz, RX_MEMORY_ST, ctx->src, cpu_regs[0]);
+    return true;
+}
+
+/* pushc rx */
+static bool trans_PUSHC(DisasContext *ctx, arg_PUSHC *a)
+{
+    TCGv cr;
+    cr = tcg_const_i32(a->cr);
+    gen_helper_mvfc(ctx->src, cpu_env, cr);
+    tcg_gen_subi_i32(cpu_regs[0], cpu_regs[0], 4);
+    rx_gen_ldst(RX_LONG, RX_MEMORY_ST, ctx->src, cpu_regs[0]);
+    tcg_temp_free(cr);
+    return true;
+}
+
+/* pushm rs-rs2*/
+static bool trans_PUSHM(DisasContext *ctx, arg_PUSHM *a)
+{
+    int r;
+
+    for (r = a->rs2; r >= a->rs; r--) {
+        tcg_gen_subi_i32(cpu_regs[0], cpu_regs[0], 4);
+        rx_gen_ldst(RX_LONG, RX_MEMORY_ST, cpu_regs[r], cpu_regs[0]);
+    }
+    return true;
+}
+
+/* xchg rs,rd */
+/* xchg dsp[rs].<mi>,rd */
+static bool trans_XCHG_rl(DisasContext *ctx, arg_XCHG_rl *a)
+{
+    int sz;
+    TCGv tmp;
+    tmp = tcg_temp_new();
+    if (a->ld == 3) {
+        /* xchg rs,rd */
+        tcg_gen_mov_i32(tmp, cpu_regs[a->rs]);
+        tcg_gen_mov_i32(cpu_regs[a->rs], cpu_regs[a->rd]);
+        tcg_gen_mov_i32(cpu_regs[a->rd], tmp);
+    } else {
+        switch (a->mi) {
+        case 0 ... 2:
+            rx_index_addr(a->ld, a->mi, a->rs, ctx);
+            rx_gen_ldst(a->mi, RX_MEMORY_LD, tmp, ctx->src);
+            sz = a->mi;
+            break;
+        case 3:
+            rx_index_addr(a->ld, RX_MEMORY_WORD, a->rs, ctx);
+            rx_gen_ldu(RX_MEMORY_WORD, tmp, ctx->src);
+            sz = RX_MEMORY_WORD;
+            break;
+        case 4:
+            rx_index_addr(a->ld, RX_MEMORY_BYTE, a->rs, ctx);
+            rx_gen_ldu(RX_MEMORY_BYTE, tmp, ctx->src);
+            sz = RX_MEMORY_BYTE;
+            break;
+        }
+        rx_gen_ldst(sz, RX_MEMORY_ST, cpu_regs[a->rd], ctx->src);
+        tcg_gen_mov_i32(cpu_regs[a->rd], tmp);
+    }
+    tcg_temp_free(tmp);
+    return true;
+}
+
+#define STZFN(maskop)                                                   \
+    do {                                                                \
+        TCGv mask, imm;                                                 \
+        mask = tcg_temp_new();                                          \
+        imm = tcg_temp_new();                                           \
+        maskop;                                                         \
+        tcg_gen_andi_i32(imm, mask, a->imm);                            \
+        tcg_gen_andc_i32(cpu_regs[a->rd], cpu_regs[a->rd], mask);       \
+        tcg_gen_or_i32(cpu_regs[a->rd], cpu_regs[a->rd], imm);          \
+        tcg_temp_free(mask);                                            \
+        tcg_temp_free(imm);                                             \
+        return true;                                                    \
+    } while (0)
+
+/* stz #imm,rd */
+static bool trans_STZ(DisasContext *ctx, arg_STZ *a)
+{
+    STZFN(tcg_gen_neg_i32(mask, cpu_psw_z));
+}
+
+/* stnz #imm,rd */
+static bool trans_STNZ(DisasContext *ctx, arg_STNZ *a)
+{
+    STZFN(tcg_gen_subi_i32(mask, cpu_psw_z, 1));
+}
+
+/* sccnd.[bwl] rd */
+/* sccnd.[bwl] dsp:[rd] */
+static bool trans_SCCnd(DisasContext *ctx, arg_SCCnd *a)
+{
+    TCGv cond = tcg_const_i32(a->cd);
+    TCGv val;
+    val = tcg_temp_new();
+    gen_helper_sccond(val, cpu_env, cond);
+    if (a->ld < 3) {
+        rx_index_addr(a->sz, a->ld, a->rd, ctx);
+        rx_gen_ldst(a->sz, RX_MEMORY_ST, val, ctx->src);
+    } else {
+        tcg_gen_mov_i32(cpu_regs[a->rd], val);
+    }
+    tcg_temp_free(cond);
+    tcg_temp_free(val);
+    return true;
+}
+
+/* rtsd #imm */
+static bool trans_RTSD_i(DisasContext *ctx, arg_RTSD_i *a)
+{
+    tcg_gen_addi_i32(cpu_regs[0], cpu_regs[0], (a->imm & 0xff)  << 2);
+    rx_gen_ldst(RX_LONG, RX_MEMORY_LD, cpu_pc, cpu_regs[0]);
+    tcg_gen_addi_i32(cpu_regs[0], cpu_regs[0], 4);
+    ctx->base.is_jmp = DISAS_JUMP;
+    return true;
+}
+
+/* rtsd #imm, rd-rd2 */
+static bool trans_RTSD_irr(DisasContext *ctx, arg_RTSD_irr *a)
+{
+    int dst;
+    int adj = (a->imm & 0xff) - (a->rd2 - a->rd + 1);
+
+    tcg_gen_addi_i32(cpu_regs[0], cpu_regs[0], adj << 2);
+    for (dst = a->rd; dst <= a->rd2; dst++) {
+        rx_gen_ldst(RX_LONG, RX_MEMORY_LD, cpu_regs[dst], cpu_regs[0]);
+        tcg_gen_addi_i32(cpu_regs[0], cpu_regs[0], 4);
+    }
+    rx_gen_ldst(RX_LONG, RX_MEMORY_LD, cpu_pc, cpu_regs[0]);
+    tcg_gen_addi_i32(cpu_regs[0], cpu_regs[0], 4);
+    ctx->base.is_jmp = DISAS_JUMP;
+    return true;
+}
+
+#define GEN_LOGIC_OP(opr, ret, arg1, arg2) \
+    do {                                                                \
+        opr(ret, arg1, arg2);                                       \
+        tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_psw_z, ret, 0);           \
+        tcg_gen_setcondi_i32(TCG_COND_GEU, cpu_psw_s, ret, 0x80000000UL); \
+    } while (0)
+
+/* and #uimm:4, rd */
+static bool trans_AND_ri(DisasContext *ctx, arg_AND_ri *a)
+{
+    GEN_LOGIC_OP(tcg_gen_andi_i32, cpu_regs[a->rd], cpu_regs[a->rd], a->imm);
+    return true;
+}
+
+/* and #imm, rd */
+static bool trans_AND_rli(DisasContext *ctx, arg_AND_rli *a)
+{
+    GEN_LOGIC_OP(tcg_gen_andi_i32, cpu_regs[a->rd], cpu_regs[a->rd], a->imm);
+    return true;
+}
+
+/* and dsp[rs], rd */
+/* and rs,rd */
+static bool trans_AND_rl(DisasContext *ctx, arg_AND_rl *a)
+{
+    TCGv val;
+    val = rx_load_source(ctx, a->ld, a->mi, a->rs);
+    GEN_LOGIC_OP(tcg_gen_and_i32, cpu_regs[a->rd], cpu_regs[a->rd], val);
+    return true;
+}
+
+/* and rs,rs2,rd */
+static bool trans_AND_rrr(DisasContext *ctx, arg_AND_rrr *a)
+{
+    GEN_LOGIC_OP(tcg_gen_and_i32, cpu_regs[a->rd],
+                 cpu_regs[a->rs2], cpu_regs[a->rs]);
+    return true;
+}
+
+/* or #uimm:4, rd */
+static bool trans_OR_ri(DisasContext *ctx, arg_OR_ri *a)
+{
+    GEN_LOGIC_OP(tcg_gen_ori_i32, cpu_regs[a->rd], cpu_regs[a->rd], a->imm);
+    return true;
+}
+
+/* or #imm, rd */
+static bool trans_OR_rli(DisasContext *ctx, arg_OR_rli *a)
+{
+    GEN_LOGIC_OP(tcg_gen_ori_i32, cpu_regs[a->rd], cpu_regs[a->rd], a->imm);
+    return true;
+}
+
+/* or dsp[rs], rd */
+/* or rs,rd */
+static bool trans_OR_rl(DisasContext *ctx, arg_OR_rl *a)
+{
+    TCGv val;
+    val = rx_load_source(ctx, a->ld, a->mi, a->rs);
+    GEN_LOGIC_OP(tcg_gen_or_i32, cpu_regs[a->rd], cpu_regs[a->rd], val);
+    return true;
+}
+
+/* or rs,rs2,rd */
+static bool trans_OR_rrr(DisasContext *ctx, arg_OR_rrr *a)
+{
+    GEN_LOGIC_OP(tcg_gen_or_i32, cpu_regs[a->rd],
+                 cpu_regs[a->rs2], cpu_regs[a->rs]);
+    return true;
+}
+
+/* xor #imm, rd */
+static bool trans_XOR_rli(DisasContext *ctx, arg_XOR_rli *a)
+{
+    GEN_LOGIC_OP(tcg_gen_xori_i32, cpu_regs[a->rd], cpu_regs[a->rd], a->imm);
+    return true;
+}
+
+/* xor dsp[rs], rd */
+/* xor rs,rd */
+static bool trans_XOR_rl(DisasContext *ctx, arg_XOR_rl *a)
+{
+    TCGv val;
+    val = rx_load_source(ctx, a->ld, a->mi, a->rs);
+    GEN_LOGIC_OP(tcg_gen_xor_i32, cpu_regs[a->rd], cpu_regs[a->rd], val);
+    return true;
+}
+
+/* tst #imm, rd */
+static bool trans_TST_rli(DisasContext *ctx, arg_TST_rli *a)
+{
+    TCGv tmp;
+    tmp = tcg_temp_new();
+    GEN_LOGIC_OP(tcg_gen_andi_i32, tmp, cpu_regs[a->rd], a->imm);
+    tcg_temp_free(tmp);
+    return true;
+}
+
+/* tst dsp[rs], rd */
+/* tst rs, rd */
+static bool trans_TST_rl(DisasContext *ctx, arg_TST_rl *a)
+{
+    TCGv val;
+    TCGv tmp;
+    tmp = tcg_temp_new();
+    val = rx_load_source(ctx, a->ld, a->mi, a->rs);
+    GEN_LOGIC_OP(tcg_gen_and_i32, tmp, cpu_regs[a->rd], val);
+    tcg_temp_free(tmp);
+    return true;
+}
+
+/* not rd */
+/* not rs, rd */
+static bool trans_NOT_rr(DisasContext *ctx, arg_NOT_rr *a)
+{
+    int rs;
+    rs = a->rs < 16 ? a->rs : a->rd;
+    tcg_gen_not_i32(cpu_regs[a->rd], cpu_regs[rs]);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_psw_z, cpu_regs[a->rd], 0);
+    tcg_gen_setcondi_i32(TCG_COND_GEU, cpu_psw_s,
+                         cpu_regs[a->rd], 0x80000000UL);
+    return true;
+}
+
+/* neg rd */
+/* neg rs, rd */
+static bool trans_NEG_rr(DisasContext *ctx, arg_NEG_rr *a)
+{
+    int rs;
+    rs = a->rs < 16 ? a->rs : a->rd;
+    tcg_gen_movi_i32(cpu_pswop, RX_PSW_OP_NONE);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_psw_o, cpu_regs[rs], 0x80000000);
+    tcg_gen_neg_i32(cpu_regs[a->rd], cpu_regs[rs]);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_psw_z, cpu_regs[a->rd], 0);
+    tcg_gen_setcondi_i32(TCG_COND_GEU, cpu_psw_s,
+                         cpu_regs[a->rd], 0x80000000UL);
+    tcg_gen_mov_i32(cpu_psw_c, cpu_psw_z);
+    return true;
+}
+
+/* ret = arg1 + arg2 + psw_c */
+static void rx_gen_adc_i32(TCGv ret, TCGv arg1, TCGv arg2)
+{
+    TCGv cf, z;
+    cf = tcg_temp_new();
+    z = tcg_const_i32(0);
+    tcg_gen_mov_i32(cf, cpu_psw_c);
+    tcg_gen_add2_i32(ret, cpu_psw_c, arg1, z, arg2, z);
+    tcg_gen_add2_i32(ret, cpu_psw_c, ret, cpu_psw_c, cf, z);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_psw_z, ret, 0);
+    tcg_gen_setcondi_i32(TCG_COND_GEU, cpu_psw_s, ret, 0x80000000UL);
+    tcg_gen_mov_i32(cpu_pswop_v[0], arg1);
+    tcg_gen_mov_i32(cpu_pswop_v[1], arg2);
+    tcg_gen_mov_i32(cpu_pswop_v[2], ret);
+    tcg_gen_movi_i32(cpu_pswop, RX_PSW_OP_ADD);
+    tcg_temp_free(cf);
+    tcg_temp_free(z);
+}
+
+/* adc #imm, rd */
+static bool trans_ADC_rli(DisasContext *ctx, arg_ADC_rli *a)
+{
+    tcg_gen_movi_i32(ctx->src, a->imm);
+    rx_gen_adc_i32(cpu_regs[a->rd], cpu_regs[a->rd], ctx->src);
+    return true;
+}
+
+/* adc rs, rd */
+static bool trans_ADC_rr(DisasContext *ctx, arg_ADC_rr *a)
+{
+    rx_gen_adc_i32(cpu_regs[a->rd], cpu_regs[a->rd], cpu_regs[a->rs]);
+    return true;
+}
+
+/* adc dsp[rs], rd */
+static bool trans_ADC_rl(DisasContext *ctx, arg_ADC_rl *a)
+{
+    rx_index_addr(a->ld, RX_LONG, a->rs, ctx);
+    rx_gen_ldst(a->ld, RX_MEMORY_LD, ctx->src, ctx->src);
+    rx_gen_adc_i32(cpu_regs[a->rd], cpu_regs[a->rd], ctx->src);
+    return true;
+}
+
+/* ret = arg1 + arg2 */
+static void rx_gen_add_i32(TCGv ret, TCGv arg1, TCGv arg2)
+{
+    TCGv z;
+    z = tcg_const_i32(0);
+    tcg_gen_add2_i32(ret, cpu_psw_c, arg1, z, arg2, z);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_psw_z, ret, 0);
+    tcg_gen_setcondi_i32(TCG_COND_GEU, cpu_psw_s, ret, 0x80000000UL);
+    tcg_gen_mov_i32(cpu_pswop_v[0], arg1);
+    tcg_gen_mov_i32(cpu_pswop_v[1], arg2);
+    tcg_gen_mov_i32(cpu_pswop_v[2], ret);
+    tcg_gen_movi_i32(cpu_pswop, RX_PSW_OP_ADD);
+    tcg_temp_free(z);
+}
+
+/* add #uimm4, rd */
+static bool trans_ADD_rri(DisasContext *ctx, arg_ADD_rri *a)
+{
+    tcg_gen_movi_i32(ctx->src, a->imm);
+    rx_gen_add_i32(cpu_regs[a->rd], cpu_regs[a->rd], ctx->src);
+    return true;
+}
+
+/* add rs, rd */
+/* add dsp[rs], rd */
+static bool trans_ADD_rl(DisasContext *ctx, arg_ADD_rl *a)
+{
+    TCGv val;
+    val = rx_load_source(ctx, a->ld, a->mi, a->rs);
+    rx_gen_add_i32(cpu_regs[a->rd], cpu_regs[a->rd], val);
+    return true;
+}
+
+/* add #imm, rs, rd */
+static bool trans_ADD_rrli(DisasContext *ctx, arg_ADD_rrli *a)
+{
+    tcg_gen_movi_i32(ctx->src, a->imm);
+    rx_gen_add_i32(cpu_regs[a->rd], cpu_regs[a->rs2], ctx->src);
+    return true;
+}
+
+/* add rs, rs2, rd */
+static bool trans_ADD_rrr(DisasContext *ctx, arg_ADD_rrr *a)
+{
+    rx_gen_add_i32(cpu_regs[a->rd], cpu_regs[a->rs], cpu_regs[a->rs2]);
+    return true;
+}
+
+/* ret = arg1 - arg2 */
+static void rx_gen_sub_i32(TCGv ret, TCGv arg1, TCGv arg2)
+{
+    TCGv z;
+    z = tcg_const_i32(0);
+    tcg_gen_sub2_i32(ret, cpu_psw_c, arg1, z, arg2, z);
+    tcg_gen_addi_i32(cpu_psw_c, cpu_psw_c, 1);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_psw_z, ret, 0);
+    tcg_gen_setcondi_i32(TCG_COND_GEU, cpu_psw_s, ret, 0x80000000UL);
+    tcg_gen_mov_i32(cpu_pswop_v[0], arg1);
+    tcg_gen_mov_i32(cpu_pswop_v[1], arg2);
+    tcg_gen_mov_i32(cpu_pswop_v[2], ret);
+    tcg_gen_movi_i32(cpu_pswop, RX_PSW_OP_SUB);
+    tcg_temp_free(z);
+}
+
+/* ret = arg1 - arg2 - !psw_c */
+static void rx_gen_sbb_i32(TCGv ret, TCGv arg1, TCGv arg2)
+{
+    TCGv cf, z;
+    cf = tcg_temp_new();
+    z = tcg_const_i32(0);
+    tcg_gen_xori_i32(cf, cpu_psw_c, 1);
+    tcg_gen_sub2_i32(ret, cpu_psw_c, arg1, z, arg2, z);
+    tcg_gen_sub2_i32(ret, cpu_psw_c, ret, cpu_psw_c, cf, z);
+    tcg_gen_addi_i32(cpu_psw_c, cpu_psw_c, 1);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_psw_z, ret, 0);
+    tcg_gen_setcondi_i32(TCG_COND_GEU, cpu_psw_s, ret, 0x80000000UL);
+    tcg_gen_mov_i32(cpu_pswop_v[0], arg1);
+    tcg_gen_mov_i32(cpu_pswop_v[1], arg2);
+    tcg_gen_mov_i32(cpu_pswop_v[2], ret);
+    tcg_gen_movi_i32(cpu_pswop, RX_PSW_OP_SUB);
+    tcg_temp_free(cf);
+    tcg_temp_free(z);
+}
+
+/* cmp #imm4, rd */
+/* cmp #imm8, rd */
+static bool trans_CMP_ri(DisasContext *ctx, arg_CMP_ri *a)
+{
+    int rs;
+    TCGv tmp;
+    tmp = tcg_temp_new();
+    rs = (a->rs2 < 16) ? a->rs2 : a->rd;
+    tcg_gen_movi_i32(ctx->src, a->imm & 0xff);
+    rx_gen_sub_i32(tmp,  cpu_regs[rs], ctx->src);
+    tcg_temp_free(tmp);
+    return true;
+}
+
+/* cmp #imm, rs2 */
+static bool trans_CMP_rli(DisasContext *ctx, arg_CMP_rli *a)
+{
+    TCGv tmp;
+    tmp = tcg_temp_new();
+    tcg_gen_movi_i32(ctx->src, a->imm);
+    rx_gen_sub_i32(tmp, cpu_regs[a->rs2], ctx->src);
+    tcg_temp_free(tmp);
+    return true;
+}
+
+/* cmp rs, rs2 */
+/* cmp dsp[rs], rs2 */
+static bool trans_CMP_rl(DisasContext *ctx, arg_CMP_rl *a)
+{
+    TCGv val;
+    TCGv tmp;
+    tmp = tcg_temp_new();
+    val = rx_load_source(ctx, a->ld, a->mi, a->rs);
+    rx_gen_sub_i32(tmp, cpu_regs[a->rd], val);
+    tcg_temp_free(tmp);
+    return true;
+}
+
+/* sub #imm4, rd */
+static bool trans_SUB_ri(DisasContext *ctx, arg_SUB_ri *a)
+{
+    tcg_gen_movi_i32(ctx->src, a->imm);
+    rx_gen_sub_i32(cpu_regs[a->rd], cpu_regs[a->rd], ctx->src);
+    return true;
+}
+
+/* sub rs, rd */
+/* sub dsp[rs], rd */
+static bool trans_SUB_rl(DisasContext *ctx, arg_SUB_rl *a)
+{
+    TCGv val;
+    val = rx_load_source(ctx, a->ld, a->mi, a->rs);
+    rx_gen_sub_i32(cpu_regs[a->rd], cpu_regs[a->rd], val);
+    return true;
+}
+
+/* sub rs, rs2, rd */
+static bool trans_SUB_rrr(DisasContext *ctx, arg_SUB_rrr *a)
+{
+    rx_gen_sub_i32(cpu_regs[a->rd], cpu_regs[a->rs2], cpu_regs[a->rs]);
+    return true;
+}
+
+/* sbb rs, rd */
+static bool trans_SBB_rr(DisasContext *ctx, arg_SBB_rr *a)
+{
+    rx_gen_sbb_i32(cpu_regs[a->rd], cpu_regs[a->rd], cpu_regs[a->rs]);
+    return true;
+}
+
+/* sbb dsp[rs], rd */
+static bool trans_SBB_rl(DisasContext *ctx, arg_SBB_rl *a)
+{
+    TCGv val;
+    val = rx_load_source(ctx, a->ld, RX_MI_LONG, a->rs);
+    rx_gen_sbb_i32(cpu_regs[a->rd], cpu_regs[a->rd], val);
+    return true;
+}
+
+/* abs rd */
+/* abs rs, rd */
+static bool trans_ABS_rr(DisasContext *ctx, arg_ABS_rr *a)
+{
+    TCGv neg;
+    TCGv zero;
+    int rs;
+    rs = a->rs < 16 ? a->rs : a->rd;
+    neg = tcg_temp_new();
+    zero = tcg_const_i32(0);
+    tcg_gen_neg_i32(neg, cpu_regs[rs]);
+    tcg_gen_movcond_i32(TCG_COND_LT, cpu_regs[a->rd], cpu_regs[rs], zero,
+                        neg, cpu_regs[rs]);
+    tcg_temp_free(neg);
+    tcg_temp_free(zero);
+    return true;
+}
+
+/* max #imm, rd */
+static bool trans_MAX_ri(DisasContext *ctx, arg_MAX_ri *a)
+{
+    tcg_gen_movi_i32(ctx->src, a->imm);
+    tcg_gen_smax_i32(cpu_regs[a->rd], cpu_regs[a->rd], ctx->src);
+    return true;
+}
+
+/* max rs, rd */
+/* max dsp[rs], rd */
+static bool trans_MAX_rl(DisasContext *ctx, arg_MAX_rl *a)
+{
+    TCGv val;
+    val = rx_load_source(ctx, a->ld, a->mi, a->rs);
+    tcg_gen_smax_i32(cpu_regs[a->rd], cpu_regs[a->rd], val);
+    return true;
+}
+
+/* min #imm, rd */
+static bool trans_MIN_ri(DisasContext *ctx, arg_MIN_ri *a)
+{
+    tcg_gen_movi_i32(ctx->src, a->imm);
+    tcg_gen_smin_i32(cpu_regs[a->rd], cpu_regs[a->rd], ctx->src);
+    return true;
+}
+
+/* min rs, rd */
+/* min dsp[rs], rd */
+static bool trans_MIN_rl(DisasContext *ctx, arg_MIN_rl *a)
+{
+    TCGv val;
+    val = rx_load_source(ctx, a->ld, a->mi, a->rs);
+    tcg_gen_smin_i32(cpu_regs[a->rd], cpu_regs[a->rd], val);
+    return true;
+}
+
+/* mul #uimm4, rd */
+static bool trans_MUL_ri(DisasContext *ctx, arg_MUL_ri *a)
+{
+    tcg_gen_muli_i32(cpu_regs[a->rd], cpu_regs[a->rd], a->imm);
+    return true;
+}
+
+/* mul #imm, rd */
+static bool trans_MUL_rli(DisasContext *ctx, arg_MUL_rli *a)
+{
+    tcg_gen_muli_i32(cpu_regs[a->rd], cpu_regs[a->rd], a->imm);
+    return true;
+}
+
+/* mul rs, rd */
+/* mul dsp[rs], rd */
+static bool trans_MUL_rl(DisasContext *ctx, arg_MUL_rl *a)
+{
+    TCGv val;
+
+    val = rx_load_source(ctx, a->ld, a->mi, a->rs);
+    tcg_gen_mul_i32(cpu_regs[a->rd], cpu_regs[a->rd], val);
+    return true;
+}
+
+/* mul rs, rs2, rd */
+static bool trans_MUL_rrr(DisasContext *ctx, arg_MUL_rrr *a)
+{
+    tcg_gen_mul_i32(cpu_regs[a->rd], cpu_regs[a->rs], cpu_regs[a->rs2]);
+    return true;
+}
+
+/* emul #imm, rd */
+static bool trans_EMUL_ri(DisasContext *ctx, arg_EMUL_ri *a)
+{
+    tcg_gen_movi_i32(ctx->src, a->imm);
+    tcg_gen_muls2_i32(cpu_regs[a->rd], cpu_regs[a->rd + 1],
+                      cpu_regs[a->rd], ctx->src);
+    return true;
+}
+
+/* emul rs, rd */
+/* emul dsp[rs], rd */
+static bool trans_EMUL_rl(DisasContext *ctx, arg_EMUL_rl *a)
+{
+    TCGv val;
+    val = rx_load_source(ctx, a->ld, a->mi, a->rs);
+    tcg_gen_muls2_i32(cpu_regs[a->rd], cpu_regs[a->rd + 1],
+                      cpu_regs[a->rd], val);
+    return true;
+}
+
+/* emulu #imm, rd */
+static bool trans_EMULU_ri(DisasContext *ctx, arg_EMULU_ri *a)
+{
+    tcg_gen_movi_i32(ctx->src, a->imm);
+    tcg_gen_mulu2_i32(cpu_regs[a->rd], cpu_regs[a->rd + 1],
+                      cpu_regs[a->rd], ctx->src);
+    return true;
+}
+
+/* emulu rs, rd */
+/* emulu dsp[rs], rd */
+static bool trans_EMULU_rl(DisasContext *ctx, arg_EMULU_rl *a)
+{
+    TCGv val;
+    val = rx_load_source(ctx, a->ld, a->mi, a->rs);
+    tcg_gen_mulu2_i32(cpu_regs[a->rd], cpu_regs[a->rd + 1],
+                      cpu_regs[a->rd], val);
+    return true;
+}
+
+/* div #imm, rd */
+static bool trans_DIV_ri(DisasContext *ctx, arg_DIV_ri *a)
+{
+    tcg_gen_movi_i32(ctx->src, a->imm);
+    gen_helper_div(cpu_regs[a->rd], cpu_env, cpu_regs[a->rd], ctx->src);
+    return true;
+}
+
+/* div rs, rd */
+/* div dsp[rs], rd */
+static bool trans_DIV_rl(DisasContext *ctx, arg_DIV_rl *a)
+{
+    TCGv val;
+    val = rx_load_source(ctx, a->ld, a->mi, a->rs);
+    gen_helper_divu(cpu_regs[a->rd], cpu_env, cpu_regs[a->rd], val);
+    return true;
+}
+
+/* divu #imm, rd */
+static bool trans_DIVU_ri(DisasContext *ctx, arg_DIVU_ri *a)
+{
+    tcg_gen_movi_i32(ctx->src, a->imm);
+    gen_helper_divu(cpu_regs[a->rd], cpu_env, cpu_regs[a->rd], ctx->src);
+    return true;
+}
+
+/* divu rs, rd */
+/* divu dsp[rs], rd */
+static bool trans_DIVU_rl(DisasContext *ctx, arg_DIVU_rl *a)
+{
+    TCGv val;
+    val = rx_load_source(ctx, a->ld, a->mi, a->rs);
+    gen_helper_divu(cpu_regs[a->rd], cpu_env, cpu_regs[a->rd], val);
+    return true;
+}
+
+
+/* shll #imm:5, rd */
+/* shll #imm:5, rs, rd */
+static bool trans_SHLL_rri(DisasContext *ctx, arg_SHLL_rri *a)
+{
+    int rs;
+
+    rs =  (a->rs2 >= 16) ? a->rd : a->rs2;
+    if (a->imm) {
+        tcg_gen_shri_i32(cpu_psw_c, cpu_regs[a->rd], 32 - a->imm);
+        tcg_gen_shli_i32(cpu_regs[a->rd], cpu_regs[rs], a->imm);
+        tcg_gen_mov_i32(cpu_pswop_v[0], cpu_regs[rs]);
+        tcg_gen_movi_i32(cpu_pswop_v[0], a->imm);
+        tcg_gen_movi_i32(cpu_pswop, RX_PSW_OP_SHLL);
+    } else {
+        tcg_gen_movi_i32(cpu_psw_c, 0);
+        tcg_gen_movi_i32(cpu_psw_o, 0);
+        tcg_gen_movi_i32(cpu_pswop, RX_PSW_OP_NONE);
+    }
+    tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_psw_z, cpu_regs[a->rd], 0);
+    tcg_gen_setcondi_i32(TCG_COND_GEU, cpu_psw_s,
+                         cpu_regs[a->rd], 0x80000000UL);
+    return true;
+}
+
+/* shll rs, rd */
+static bool trans_SHLL_rr(DisasContext *ctx, arg_SHLL_rr *a)
+{
+    TCGLabel *l1, *l2;
+    TCGv count;
+
+    l1 = gen_new_label();
+    l2 = gen_new_label();
+    tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_regs[a->rs], 0, l1);
+    count = tcg_const_i32(32);
+    tcg_gen_sub_i32(ctx->src, count, cpu_regs[a->rs]);
+    tcg_gen_shr_i32(cpu_psw_c, cpu_regs[a->rd], count);
+    tcg_gen_shl_i32(cpu_regs[a->rd], cpu_regs[a->rd], cpu_regs[a->rs]);
+    tcg_gen_mov_i32(cpu_pswop_v[0], cpu_regs[a->rd]);
+    tcg_gen_mov_i32(cpu_pswop_v[1], cpu_regs[a->rs]);
+    tcg_gen_movi_i32(cpu_pswop, RX_PSW_OP_SHLL);
+    tcg_gen_br(l2);
+    gen_set_label(l1);
+    tcg_gen_movi_i32(cpu_psw_c, 0);
+    tcg_gen_movi_i32(cpu_psw_o, 0);
+    tcg_gen_movi_i32(cpu_pswop, RX_PSW_OP_NONE);
+    gen_set_label(l2);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_psw_z, cpu_regs[a->rd], 0);
+    tcg_gen_setcondi_i32(TCG_COND_GEU, cpu_psw_s,
+                         cpu_regs[a->rd], 0x80000000UL);
+    tcg_temp_free(count);
+    return true;
+}
+
+#define SHIFTR_IMM(op)                                                  \
+    do {                                                                \
+        int rs;                                                         \
+        rs =  (a->rs2 >= 16) ? a->rd : a->rs2;                          \
+        if (a->imm) {                                                   \
+            op(cpu_regs[a->rd], cpu_regs[rs], a->imm - 1);              \
+            tcg_gen_andi_i32(cpu_psw_c, cpu_regs[a->rd], 0x00000001);   \
+            op(cpu_regs[a->rd], cpu_regs[a->rd], 1);                    \
+        } else {                                                        \
+            tcg_gen_movi_i32(cpu_psw_c, 0);                             \
+        }                                                               \
+        tcg_gen_movi_i32(cpu_psw_o, 0);                                 \
+        tcg_gen_movi_i32(cpu_pswop, RX_PSW_OP_NONE);                    \
+        tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_psw_z, cpu_regs[a->rd], 0); \
+        tcg_gen_setcondi_i32(TCG_COND_GEU, cpu_psw_s,                   \
+                             cpu_regs[a->rd], 0x80000000UL);            \
+    } while (0)
+
+#define SHIFTR_REG(op, opimm)                                                 \
+    do {                                                                \
+        TCGLabel *skipz, *done;                                         \
+        TCGv count;                                                     \
+        skipz = gen_new_label();                                        \
+        done = gen_new_label();                                         \
+        count = tcg_temp_new();                                         \
+        tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_regs[a->rs], 0, skipz);    \
+        tcg_gen_subi_i32(count, cpu_regs[a->rs], 1);                    \
+        op(cpu_regs[a->rd], cpu_regs[a->rd], count);                    \
+        tcg_gen_andi_i32(cpu_psw_c, cpu_regs[a->rd], 0x00000001);       \
+        opimm(cpu_regs[a->rd], cpu_regs[a->rd], 1);                     \
+        tcg_gen_br(done);                                               \
+        gen_set_label(skipz);                                           \
+        tcg_gen_movi_i32(cpu_psw_c, 0);                                 \
+        gen_set_label(done);                                            \
+        tcg_gen_movi_i32(cpu_psw_o, 0);                                 \
+        tcg_gen_movi_i32(cpu_pswop, RX_PSW_OP_NONE);                    \
+        tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_psw_z, cpu_regs[a->rd], 0); \
+        tcg_gen_setcondi_i32(TCG_COND_GEU, cpu_psw_s,                   \
+                             cpu_regs[a->rd], 0x80000000UL);            \
+        tcg_temp_free(count);                                           \
+    } while (0)
+
+/* shar #imm:5, rd */
+/* shar #imm:5, rs, rd */
+static bool trans_SHAR_rri(DisasContext *ctx, arg_SHAR_rri *a)
+{
+    SHIFTR_IMM(tcg_gen_sari_i32);
+    return true;
+}
+
+/* shar rs, rd */
+static bool trans_SHAR_rr(DisasContext *ctx, arg_SHAR_rr *a)
+{
+    SHIFTR_REG(tcg_gen_sar_i32, tcg_gen_sari_i32);
+    return true;
+}
+
+/* shlr #imm:5, rd */
+/* shlr #imm:5, rs, rd */
+static bool trans_SHLR_rri(DisasContext *ctx, arg_SHLR_rri *a)
+{
+    SHIFTR_IMM(tcg_gen_shri_i32);
+    return true;
+}
+
+/* shlr rs, rd */
+static bool trans_SHLR_rr(DisasContext *ctx, arg_SHLR_rr *a)
+{
+    SHIFTR_REG(tcg_gen_shr_i32, tcg_gen_shri_i32);
+    return true;
+}
+
+/* rolc rd*/
+static bool trans_ROLC(DisasContext *ctx, arg_ROLC *a)
+{
+    TCGv tmp;
+    tmp = tcg_temp_new();
+    tcg_gen_shri_i32(tmp, cpu_regs[a->rd], 31);
+    tcg_gen_shli_i32(cpu_regs[a->rd], cpu_regs[a->rd], 1);
+    tcg_gen_or_i32(cpu_regs[a->rd], cpu_regs[a->rd], cpu_psw_c);
+    tcg_gen_mov_i32(cpu_psw_c, tmp);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_psw_z, cpu_regs[a->rd], 0);
+    tcg_gen_setcondi_i32(TCG_COND_GEU, cpu_psw_s,
+                         cpu_regs[a->rd], 0x80000000UL);
+    tcg_temp_free(tmp);
+    return true;
+}
+
+/* rorc rd */
+static bool trans_RORC(DisasContext *ctx, arg_RORC *a)
+{
+    TCGv tmp;
+    tmp = tcg_temp_new();
+    tcg_gen_andi_i32(tmp, cpu_regs[a->rd], 0x00000001);
+    tcg_gen_shri_i32(cpu_regs[a->rd], cpu_regs[a->rd], 1);
+    tcg_gen_shli_i32(cpu_psw_c, cpu_psw_c, 31);
+    tcg_gen_or_i32(cpu_regs[a->rd], cpu_regs[a->rd], cpu_psw_c);
+    tcg_gen_mov_i32(cpu_psw_c, tmp);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_psw_z, cpu_regs[a->rd], 0);
+    tcg_gen_setcondi_i32(TCG_COND_GEU, cpu_psw_s,
+                         cpu_regs[a->rd], 0x80000000UL);
+    return true;
+}
+
+
+static void rx_rot_imm(int dir, int rd, uint32_t imm)
+{
+    if (dir) {
+        tcg_gen_rotli_i32(cpu_regs[rd], cpu_regs[rd], imm);
+        tcg_gen_andi_i32(cpu_psw_c, cpu_regs[rd], 0x00000001);
+    } else {
+        tcg_gen_rotri_i32(cpu_regs[rd], cpu_regs[rd], imm);
+        tcg_gen_shri_i32(cpu_psw_c, cpu_regs[rd], 31);
+    }
+    tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_psw_z, cpu_regs[rd], 0);
+    tcg_gen_setcondi_i32(TCG_COND_GEU, cpu_psw_s, cpu_regs[rd], 0x80000000UL);
+}
+
+static void rx_rot_reg(int dir, int rd, int rs)
+{
+    if (dir) {
+        tcg_gen_rotl_i32(cpu_regs[rd], cpu_regs[rd], cpu_regs[rs]);
+        tcg_gen_andi_i32(cpu_psw_c, cpu_regs[rd], 0x00000001);
+    } else {
+        tcg_gen_rotr_i32(cpu_regs[rd], cpu_regs[rd], cpu_regs[rs]);
+        tcg_gen_shri_i32(cpu_psw_c, cpu_regs[rd], 31);
+    }
+}
+
+/* rotl #imm, rd */
+static bool trans_ROTL_ri(DisasContext *ctx, arg_ROTL_ri *a)
+{
+    rx_rot_imm(1, a->rd, a->imm);
+    return true;
+}
+
+/* rotl rs, rd */
+static bool trans_ROTL_rr(DisasContext *ctx, arg_ROTL_rr *a)
+{
+    rx_rot_reg(1, a->rd, a->rs);
+    return true;
+}
+
+/* rotr #imm, rd */
+static bool trans_ROTR_ri(DisasContext *ctx, arg_ROTR_ri *a)
+{
+    rx_rot_imm(0, a->rd, a->imm);
+    return true;
+}
+
+/* rotr rs, rd */
+static bool trans_ROTR_rr(DisasContext *ctx, arg_ROTR_rr *a)
+{
+    rx_rot_reg(0, a->rd, a->rs);
+    return true;
+}
+
+/* revl rs, rd */
+static bool trans_REVL(DisasContext *ctx, arg_REVL *a)
+{
+    tcg_gen_bswap32_i32(cpu_regs[a->rd], cpu_regs[a->rs]);
+    return true;
+}
+
+/* revw rs, rd */
+static bool trans_REVW(DisasContext *ctx, arg_REVW *a)
+{
+    TCGv hi, lo;
+
+    hi = tcg_temp_new();
+    lo = tcg_temp_new();
+    tcg_gen_shri_i32(hi, cpu_regs[a->rs], 16);
+    tcg_gen_bswap16_i32(hi, hi);
+    tcg_gen_shli_i32(hi, hi, 16);
+    tcg_gen_bswap16_i32(lo, cpu_regs[a->rs]);
+    tcg_gen_or_i32(cpu_regs[a->rd], hi, lo);
+    tcg_temp_free(hi);
+    tcg_temp_free(lo);
+    return true;
+}
+
+/* conditional branch helper */
+static void rx_bcnd_main(DisasContext *ctx, int cd, int dst, int len)
+{
+        TCGv t, f, cond;
+        switch (cd) {
+        case 0 ... 13:
+            t = tcg_const_i32(ctx->base.pc_next - len + dst);
+            f = tcg_const_i32(ctx->base.pc_next);
+            cond = tcg_const_i32(cd);
+            gen_helper_brcond(cpu_pc, cpu_env, cond, t, f);
+            tcg_temp_free(cond);
+            tcg_temp_free(t);
+            tcg_temp_free(f);
+            break;
+        case 14:
+            /* always true case */
+            tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next - len + dst);
+            break;
+        case 15:
+            /* always false case */
+            tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next);
+            break;
+    }
+    ctx->base.is_jmp = DISAS_JUMP;
+}
+
+static int16_t rev16(uint16_t dsp)
+{
+    return ((dsp << 8) & 0xff00) | ((dsp >> 8) & 0x00ff);
+}
+
+static int32_t rev24(uint32_t dsp)
+{
+    dsp = ((dsp << 16) & 0xff0000) |
+        (dsp & 0x00ff00) |
+        ((dsp >> 16) & 0x0000ff);
+    dsp |= (dsp & 0x00800000) ? 0xff000000 : 0x00000000;
+    return dsp;
+}
+
+/* beq dsp:3 */
+/* bne dsp:3 */
+static bool trans_BCnd_s(DisasContext *ctx, arg_BCnd_s *a)
+{
+    if (a->dsp < 3) {
+        a->dsp += 8;
+    }
+    rx_bcnd_main(ctx, a->cd, a->dsp, 1);
+    return true;
+}
+
+/* beq dsp:8 */
+/* bne dsp:8 */
+/* bc dsp:8 */
+/* bnc dsp:8 */
+/* bgtu dsp:8 */
+/* bleu dsp:8 */
+/* bpz dsp:8 */
+/* bn dsp:8 */
+/* bge dsp:8 */
+/* blt dsp:8 */
+/* bgt dsp:8 */
+/* ble dsp:8 */
+/* bo dsp:8 */
+/* bno dsp:8 */
+/* bra dsp:8 */
+static bool trans_BCnd_b(DisasContext *ctx, arg_BCnd_b *a)
+{
+    rx_bcnd_main(ctx, a->cd, (int8_t)a->dsp, 2);
+    return true;
+}
+
+/* beq dsp:16 */
+/* bne dsp:16 */
+static bool trans_BCnd_w(DisasContext *ctx, arg_BCnd_w *a)
+{
+    rx_bcnd_main(ctx, a->cd, rev16(a->dsp), 3);
+    return true;
+}
+
+/* bra dsp:3 */
+static bool trans_BRA_s(DisasContext *ctx, arg_BRA_s *a)
+{
+    if (a->dsp < 3) {
+        a->dsp += 8;
+    }
+    rx_bcnd_main(ctx, 14, a->dsp, 1);
+    return true;
+}
+
+/* bra dsp:16 */
+static bool trans_BRA_w(DisasContext *ctx, arg_BRA_w *a)
+{
+    rx_bcnd_main(ctx, 14, rev16(a->dsp), 3);
+    return true;
+}
+
+/* bra dsp:24 */
+static bool trans_BRA_a(DisasContext *ctx, arg_BRA_a *a)
+{
+    rx_bcnd_main(ctx, 14, rev24(a->dsp), 4);
+    return true;
+}
+
+/* bra rs */
+static bool trans_BRA_l(DisasContext *ctx, arg_BRA_l *a)
+{
+    tcg_gen_add_i32(cpu_pc, cpu_pc, cpu_regs[a->rd]);
+    ctx->base.is_jmp = DISAS_JUMP;
+    return true;
+}
+
+static void rx_save_pc(DisasContext *ctx)
+{
+    tcg_gen_movi_i32(ctx->src, ctx->base.pc_next);
+    tcg_gen_subi_i32(cpu_regs[0], cpu_regs[0], 4);
+    rx_gen_ldst(RX_LONG, RX_MEMORY_ST, ctx->src, cpu_regs[0]);
+}
+
+/* jmp rs */
+static bool trans_JMP(DisasContext *ctx, arg_JMP *a)
+{
+    tcg_gen_mov_i32(cpu_pc, cpu_regs[a->rs]);
+    ctx->base.is_jmp = DISAS_JUMP;
+    return true;
+}
+
+/* jsr rs */
+static bool trans_JSR(DisasContext *ctx, arg_JSR *a)
+{
+    rx_save_pc(ctx);
+    tcg_gen_mov_i32(cpu_pc, cpu_regs[a->rs]);
+    ctx->base.is_jmp = DISAS_JUMP;
+    return true;
+}
+
+/* bsr dsp:16 */
+static bool trans_BSR_w(DisasContext *ctx, arg_BSR_w *a)
+{
+    rx_save_pc(ctx);
+    rx_bcnd_main(ctx, 14, rev16(a->dsp), 3);
+    return true;
+}
+
+/* bsr dsp:24 */
+static bool trans_BSR_a(DisasContext *ctx, arg_BSR_a *a)
+{
+    rx_save_pc(ctx);
+    rx_bcnd_main(ctx, 14, rev24(a->dsp), 4);
+    return true;
+}
+
+/* bsr rs */
+static bool trans_BSR_l(DisasContext *ctx, arg_BSR_l *a)
+{
+    rx_save_pc(ctx);
+    tcg_gen_add_i32(cpu_pc, cpu_pc, cpu_regs[a->rd]);
+    ctx->base.is_jmp = DISAS_JUMP;
+    return true;
+}
+
+/* rts */
+static bool trans_RTS(DisasContext *ctx, arg_RTS *a)
+{
+    rx_gen_ldst(RX_LONG, RX_MEMORY_LD, cpu_pc, cpu_regs[0]);
+    tcg_gen_addi_i32(cpu_regs[0], cpu_regs[0], 4);
+    ctx->base.is_jmp = DISAS_JUMP;
+    return true;
+}
+
+/* nop */
+static bool trans_NOP(DisasContext *ctx, arg_NOP *a)
+{
+    return true;
+}
+
+/* scmpu */
+static bool trans_SCMPU(DisasContext *ctx, arg_SCMPU *a)
+{
+    gen_helper_scmpu(cpu_env);
+    return true;
+}
+
+/* smovu */
+static bool trans_SMOVU(DisasContext *ctx, arg_SMOVU *a)
+{
+    gen_helper_smovu(cpu_env);
+    return true;
+}
+
+/* smovf */
+static bool trans_SMOVF(DisasContext *ctx, arg_SMOVF *a)
+{
+    gen_helper_smovf(cpu_env);
+    return true;
+}
+
+/* smovb */
+static bool trans_SMOVB(DisasContext *ctx, arg_SMOVB *a)
+{
+    gen_helper_smovb(cpu_env);
+    return true;
+}
+
+#define STRING(op)                              \
+    do {                                        \
+        TCGv size = tcg_const_i32(a->sz);       \
+        gen_helper_##op(cpu_env, size);         \
+        tcg_temp_free(size);                    \
+    } while (0)
+
+/* suntile */
+static bool trans_SUNTIL(DisasContext *ctx, arg_SUNTIL *a)
+{
+    STRING(suntil);
+    return true;
+}
+
+/* swhile */
+static bool trans_SWHILE(DisasContext *ctx, arg_SWHILE *a)
+{
+    STRING(swhile);
+    return true;
+}
+/* sstr */
+static bool trans_SSTR(DisasContext *ctx, arg_SSTR *a)
+{
+    STRING(sstr);
+    return true;
+}
+
+/* rmpa */
+static bool trans_RMPA(DisasContext *ctx, arg_RMPA *a)
+{
+    STRING(rmpa);
+    return true;
+}
+
+#define MULMAC(op)                                            \
+    do {                                                      \
+        TCGv regs = tcg_const_i32(a->rs << 4 | a->rs2);       \
+        gen_helper_##op(cpu_env, regs);                       \
+        tcg_temp_free(regs);                                  \
+    } while (0)
+
+/* mulhi rs,rs2 */
+static bool trans_MULHI(DisasContext *ctx, arg_MULHI *a)
+{
+    MULMAC(mulhi);
+    return true;
+}
+
+/* mullo rs,rs2 */
+static bool trans_MULLO(DisasContext *ctx, arg_MULLO *a)
+{
+    MULMAC(mullo);
+    return true;
+}
+
+/* machi rs,rs2 */
+static bool trans_MACHI(DisasContext *ctx, arg_MACHI *a)
+{
+    MULMAC(machi);
+    return true;
+}
+
+/* maclo rs,rs2 */
+static bool trans_MACLO(DisasContext *ctx, arg_MACLO *a)
+{
+    MULMAC(maclo);
+    return true;
+}
+
+/* mvfachi rd */
+static bool trans_MVFACHI(DisasContext *ctx, arg_MVFACHI *a)
+{
+    tcg_gen_extrh_i64_i32(cpu_regs[a->rd], cpu_acc);
+    return true;
+}
+
+/* mvfacmi rd */
+static bool trans_MVFACMI(DisasContext *ctx, arg_MVFACMI *a)
+{
+    TCGv_i64 tmp;
+    tmp = tcg_temp_new_i64();
+    tcg_gen_shri_i64(tmp, cpu_acc, 16);
+    tcg_gen_extrl_i64_i32(cpu_regs[a->rd], tmp);
+    tcg_temp_free_i64(tmp);
+    return true;
+}
+
+/* mvtachi rs */
+static bool trans_MVTACHI(DisasContext *ctx, arg_MVTACHI *a)
+{
+    TCGv_i32 hi, lo;
+    hi = tcg_temp_new_i32();
+    lo = tcg_temp_new_i32();
+    tcg_gen_extr_i64_i32(lo, hi, cpu_acc);
+    tcg_gen_concat_i32_i64(cpu_acc, lo, cpu_regs[a->rs]);
+    tcg_temp_free_i32(hi);
+    tcg_temp_free_i32(lo);
+    return true;
+}
+
+/* mvtaclo rs */
+static bool trans_MVTACLO(DisasContext *ctx, arg_MVTACLO *a)
+{
+    TCGv_i32 hi, lo;
+    hi = tcg_temp_new_i32();
+    lo = tcg_temp_new_i32();
+    tcg_gen_extr_i64_i32(lo, hi, cpu_acc);
+    tcg_gen_concat_i32_i64(cpu_acc, cpu_regs[a->rs], hi);
+    tcg_temp_free_i32(hi);
+    tcg_temp_free_i32(lo);
+    return true;
+}
+
+/* racw #imm */
+static bool trans_RACW(DisasContext *ctx, arg_RACW *a)
+{
+    tcg_gen_movi_i32(ctx->src, a->imm + 1);
+    gen_helper_racw(cpu_env, ctx->src);
+    return true;
+}
+
+/* sat rd */
+static bool trans_SAT(DisasContext *ctx, arg_SAT *a)
+{
+    tcg_gen_movi_i32(ctx->src, a->rd);
+    gen_helper_sat(cpu_env, ctx->src);
+    return true;
+}
+
+/* satr */
+static bool trans_SATR(DisasContext *ctx, arg_SATR *a)
+{
+    gen_helper_satr(cpu_env);
+    return true;
+}
+
+#define cat3(a, b, c) a##b##c
+#define FOP(name, op)                                                   \
+    static bool cat3(trans_, name, _ri)(DisasContext *ctx,              \
+                                        cat3(arg_, name, _ri) * a)      \
+    {                                                                   \
+        tcg_gen_movi_i32(ctx->src, li(ctx, 0));                         \
+        gen_helper_##op(cpu_regs[a->rd], cpu_env, cpu_regs[a->rd], ctx->src); \
+        return true;                                                    \
+    }                                                                   \
+    static bool cat3(trans_, name, _rl)(DisasContext *ctx,              \
+                                        cat3(arg_, name, _rl) * a)      \
+    {                                                                   \
+        TCGv val;                                                       \
+        val = rx_load_source(ctx, a->ld, RX_MI_LONG, a->rs);            \
+        gen_helper_##op(cpu_regs[a->rd], cpu_env, cpu_regs[a->rd], val); \
+        return true;                                                    \
+    }
+
+#define FCONVOP(name, op)                                       \
+    static bool trans_##name(DisasContext *ctx, arg_##name * a) \
+    {                                                           \
+        TCGv val;                                               \
+        val = rx_load_source(ctx, a->ld, RX_MI_LONG, a->rs);    \
+        gen_helper_##op(cpu_regs[a->rd], cpu_env, val);         \
+        return true;                                            \
+    }
+
+FOP(FADD, fadd)
+FOP(FSUB, fsub)
+FOP(FMUL, fmul)
+FOP(FDIV, fdiv)
+
+/* fcmp #imm, rd */
+static bool trans_FCMP_ri(DisasContext *ctx, arg_FCMP_ri *a)
+{
+    tcg_gen_movi_i32(ctx->src, li(ctx, 0));
+    gen_helper_fcmp(cpu_env, cpu_regs[a->rd], ctx->src);
+    return true;
+}
+
+/* fcmp dsp[rs], rd */
+/* fcmp rs, rd */
+static bool trans_FCMP_rl(DisasContext *ctx, arg_FCMP_rl *a)
+{
+    TCGv val;
+    val = rx_load_source(ctx, a->ld, RX_MI_LONG, a->rs);
+    gen_helper_fcmp(cpu_env, cpu_regs[a->rd], val);
+    return true;
+}
+
+FCONVOP(FTOI, ftoi)
+FCONVOP(ROUND, round)
+
+/* itof rs, rd */
+/* itof dsp[rs], rd */
+static bool trans_ITOF(DisasContext *ctx, arg_ITOF *a)
+{
+    TCGv val;
+    val = rx_load_source(ctx, a->ld, a->mi, a->rs);
+    gen_helper_itof(cpu_regs[a->rd], cpu_env, val);
+    return true;
+}
+
+static void rx_bsetmem(TCGv mem, TCGv mask)
+{
+    TCGv val;
+    val = tcg_temp_new();
+    rx_gen_ldst(RX_MEMORY_BYTE, RX_MEMORY_LD, val, mem);
+    tcg_gen_or_i32(val, val, mask);
+    rx_gen_ldst(RX_MEMORY_BYTE, RX_MEMORY_ST, val, mem);
+    tcg_temp_free(val);
+}
+
+static void rx_bclrmem(TCGv mem, TCGv mask)
+{
+    TCGv val;
+    val = tcg_temp_new();
+    rx_gen_ldst(RX_MEMORY_BYTE, RX_MEMORY_LD, val, mem);
+    tcg_gen_not_i32(mask, mask);
+    tcg_gen_and_i32(val, val, mask);
+    rx_gen_ldst(RX_MEMORY_BYTE, RX_MEMORY_ST, val, mem);
+    tcg_temp_free(val);
+}
+
+static void rx_btstmem(TCGv mem, TCGv mask)
+{
+    TCGv val;
+    val = tcg_temp_new();
+    rx_gen_ldst(RX_MEMORY_BYTE, RX_MEMORY_LD, val, mem);
+    tcg_gen_and_i32(val, val, mask);
+    tcg_gen_setcondi_i32(TCG_COND_NE, cpu_psw_c, val, 0);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_psw_z, val, 0);
+    tcg_temp_free(val);
+}
+
+static void rx_bnotmem(TCGv mem, TCGv mask)
+{
+    TCGv val;
+    val = tcg_temp_new();
+    rx_gen_ldst(RX_MEMORY_BYTE, RX_MEMORY_LD, val, mem);
+    tcg_gen_xor_i32(val, val, mask);
+    rx_gen_ldst(RX_MEMORY_BYTE, RX_MEMORY_ST, val, mem);
+    tcg_temp_free(val);
+}
+
+static void rx_bsetreg(TCGv reg, TCGv mask)
+{
+    tcg_gen_or_i32(reg, reg, mask);
+}
+
+static void rx_bclrreg(TCGv reg, TCGv mask)
+{
+    tcg_gen_not_i32(mask, mask);
+    tcg_gen_and_i32(reg, reg, mask);
+}
+
+static void rx_btstreg(TCGv reg, TCGv mask)
+{
+    TCGv t0;
+    t0 = tcg_temp_new();
+    tcg_gen_and_i32(t0, reg, mask);
+    tcg_gen_setcondi_i32(TCG_COND_NE, cpu_psw_c, t0, 0);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_psw_z, t0, 0);
+    tcg_temp_free(t0);
+}
+
+static void rx_bnotreg(TCGv reg, TCGv mask)
+{
+    tcg_gen_xor_i32(reg, reg, mask);
+}
+
+#define BITOP(name, op)                                                 \
+    static bool cat3(trans_, name, _li)(DisasContext *ctx,              \
+                                        cat3(arg_, name, _li) * a)      \
+    {                                                                   \
+        TCGv mask;                                                      \
+        mask = tcg_const_i32(1 << a->imm);                              \
+        rx_index_addr(a->ld, RX_MEMORY_BYTE, a->rs, ctx);               \
+        cat3(rx_, op, mem)(ctx->src, mask);                              \
+        tcg_temp_free(mask);                                            \
+        return true;                                                    \
+    }                                                                   \
+    static bool cat3(trans_, name, _lr)(DisasContext *ctx,              \
+                                        cat3(arg_, name, _lr) * a)      \
+    {                                                                   \
+        TCGv mask;                                                      \
+        mask = tcg_const_i32(1);                                        \
+        tcg_gen_shl_i32(mask, mask, cpu_regs[a->rs2]);                  \
+        switch (a->ld) {                                                \
+        case 0 ... 2:                                                   \
+            rx_index_addr(a->ld, RX_MEMORY_BYTE, a->rs, ctx);           \
+            cat3(rx_, op, mem)(ctx->src, mask);                          \
+            break;                                                      \
+        case 3:                                                         \
+            cat3(rx_, op, reg)(cpu_regs[a->rs], mask);             \
+            break;                                                      \
+        }                                                               \
+        tcg_temp_free(mask);                                            \
+        return true;                                                    \
+    }                                                                   \
+    static bool cat3(trans_, name, _ri)(DisasContext *ctx,              \
+                                        cat3(arg_, name, _ri) * a)      \
+    {                                                                   \
+        TCGv mask;                                                      \
+        mask = tcg_const_i32(1 << a->imm);                              \
+        cat3(rx_, op, reg)(cpu_regs[a->rd], mask);                       \
+        tcg_temp_free(mask);                                            \
+        return true;                                                    \
+    }
+
+BITOP(BSET, bset)
+BITOP(BCLR, bclr)
+BITOP(BTST, btst)
+
+/* bnot rs, dsp[rd] */
+/* bnot rs, rd */
+static bool trans_BNOT_lr(DisasContext *ctx, arg_BNOT_lr *a)
+{
+    TCGv mask;                                                          \
+    mask = tcg_const_i32(1);                                            \
+    tcg_gen_shl_i32(mask, mask, cpu_regs[a->rs2]);
+    switch (a->ld) {
+    case 0 ... 2:
+        rx_index_addr(a->ld, RX_MEMORY_BYTE, a->rs, ctx);
+        rx_bnotmem(ctx->src, mask);
+        break;
+    case 3:
+        rx_bnotreg(cpu_regs[a->rs], mask);
+        break;
+    }
+    tcg_temp_free(mask);
+    return true;
+}
+
+/* bmcond #imm, dsp[rd] */
+/* bnot #imm, dsp[rd] */
+static bool trans_BMCnd_BNOT_mi(DisasContext *ctx, arg_BMCnd_BNOT_mi *a)
+{
+    TCGv bit, cond, val;
+    val = tcg_temp_new();
+    rx_index_addr(a->ld, RX_MEMORY_BYTE, a->rd, ctx);
+    rx_gen_ldst(RX_MEMORY_BYTE, RX_MEMORY_LD, val, ctx->src);
+    if (a->cd == 15) {
+        /* special case bnot #imm, mem */
+        tcg_gen_xori_i32(val, val, 1 << a->imm);
+    } else {
+        cond = tcg_const_i32(a->cd);
+        bit = tcg_const_i32(a->imm);
+        gen_helper_bmcond(val, cpu_env, val, bit, cond);
+        tcg_temp_free(bit);
+        tcg_temp_free(cond);
+    }
+    rx_gen_ldst(RX_MEMORY_BYTE, RX_MEMORY_ST, val, ctx->src);
+    tcg_temp_free(val);
+    return true;
+}
+
+/* bmcond #imm, rd */
+/* bnot #imm, rd */
+static bool trans_BMCnd_BNOT_ri(DisasContext *ctx, arg_BMCnd_BNOT_ri *a)
+{
+    TCGv bit, cond;
+    if (a->cd == 15) {
+        /* special case bnot #imm, reg */
+        tcg_gen_xori_i32(cpu_regs[a->rd], cpu_regs[a->rd], 1 << a->imm);
+    } else {
+        cond = tcg_const_i32(a->cd);
+        bit = tcg_const_i32(a->imm);
+        gen_helper_bmcond(cpu_regs[a->rd], cpu_env,
+                          cpu_regs[a->rd], bit, cond);
+        tcg_temp_free(bit);
+        tcg_temp_free(cond);
+    }
+    return true;
+}
+
+static void check_previleged(void)
+{
+    TCGLabel *good;
+
+    good = gen_new_label();
+    tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_psw_pm, 0, good);
+    gen_helper_raise_privilege_violation(cpu_env);
+    gen_set_label(good);
+}
+
+static inline void clrsetpsw(int dst, int mode)
+{
+    TCGv psw[] = {
+        cpu_psw_c, cpu_psw_z, cpu_psw_s, cpu_psw_o,
+        NULL, NULL, NULL, NULL,
+        cpu_psw_i, cpu_psw_u, NULL, NULL,
+        NULL, NULL, NULL, NULL
+    };
+    TCGLabel *skip;
+
+    skip = gen_new_label();
+    if (dst >= 8) {
+        tcg_gen_brcondi_i32(TCG_COND_NE, cpu_psw_pm, 0, skip);
+    }
+    tcg_gen_movi_i32(psw[dst], mode);
+    if (dst == 3) {
+        tcg_gen_movi_i32(cpu_pswop, RX_PSW_OP_NONE);
+    }
+    gen_set_label(skip);
+}
+
+/* clrpsw psw */
+static bool trans_CLRPSW(DisasContext *ctx, arg_CLRPSW *a)
+{
+    clrsetpsw(a->cb, 0);
+    return true;
+}
+
+/* setpsw psw */
+static bool trans_SETPSW(DisasContext *ctx, arg_SETPSW *a)
+{
+    clrsetpsw(a->cb, 1);
+    return true;
+}
+
+/* mvtipl #imm */
+static bool trans_MVTIPL(DisasContext *ctx, arg_MVTIPL *a)
+{
+    check_previleged();
+    tcg_gen_movi_i32(cpu_psw_ipl, a->imm);
+    return true;
+}
+
+/* mvtc #imm, rd */
+static bool trans_MVTC_i(DisasContext *ctx, arg_MVTC_i *a)
+{
+    TCGv cr, imm;
+
+    imm = tcg_const_i32(a->imm);
+    cr = tcg_const_i32(a->cr);
+    gen_helper_mvtc(cpu_env, cr, imm);
+    tcg_temp_free(cr);
+    tcg_temp_free(imm);
+    return true;
+}
+
+/* mvtc rs, rd */
+static bool trans_MVTC_r(DisasContext *ctx, arg_MVTC_r *a)
+{
+    TCGv cr;
+
+    cr = tcg_const_i32(a->cr);
+    gen_helper_mvtc(cpu_env, cr, cpu_regs[a->rs]);
+    tcg_temp_free(cr);
+    return true;
+}
+
+/* mvfc rs, rd */
+static bool trans_MVFC(DisasContext *ctx, arg_MVFC *a)
+{
+    TCGv cr;
+
+    cr = tcg_const_i32(a->cr);
+    if (a->cr == 1) {
+        tcg_gen_movi_i32(cpu_regs[a->rd], ctx->base.pc_next - 3);
+    } else {
+        gen_helper_mvfc(cpu_regs[a->rd], cpu_env, cr);
+    }
+    tcg_temp_free(cr);
+    return true;
+}
+
+/* rtfi */
+static bool trans_RTFI(DisasContext *ctx, arg_RTFI *a)
+{
+    check_previleged();
+    tcg_gen_mov_i32(cpu_pc, cpu_bpc);
+    tcg_gen_mov_i32(cpu_psw, cpu_bpsw);
+    gen_helper_unpack_psw(cpu_env);
+    ctx->base.is_jmp = DISAS_JUMP;
+    return true;
+}
+
+/* rtfe */
+static bool trans_RTE(DisasContext *ctx, arg_RTE *a)
+{
+    check_previleged();
+    rx_gen_ldst(RX_LONG, RX_MEMORY_LD, cpu_pc, cpu_regs[0]);
+    tcg_gen_addi_i32(cpu_regs[0], cpu_regs[0], 4);
+    rx_gen_ldst(RX_LONG, RX_MEMORY_LD, cpu_psw, cpu_regs[0]);
+    tcg_gen_addi_i32(cpu_regs[0], cpu_regs[0], 4);
+    gen_helper_unpack_psw(cpu_env);
+    ctx->base.is_jmp = DISAS_JUMP;
+    return true;
+}
+
+/* brk */
+static bool trans_BRK(DisasContext *ctx, arg_BRK *a)
+{
+    tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next);
+    gen_helper_rxbrk(cpu_env);
+    ctx->base.is_jmp = DISAS_NORETURN;
+    return true;
+}
+
+/* int #imm */
+static bool trans_INT(DisasContext *ctx, arg_INT *a)
+{
+    TCGv vec;
+
+    vec = tcg_const_i32(a->imm & 0xff);
+    tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next);
+    gen_helper_rxint(cpu_env, vec);
+    tcg_temp_free(vec);
+    ctx->base.is_jmp = DISAS_NORETURN;
+    return true;
+}
+
+/* wait */
+static bool trans_WAIT(DisasContext *ctx, arg_WAIT *a)
+{
+    check_previleged();
+    tcg_gen_addi_i32(cpu_pc, cpu_pc, 2);
+    gen_helper_wait(cpu_env);
+    return true;
+}
+
+static void rx_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+
+    ctx->src = tcg_temp_new();
+}
+
+static void rx_tr_tb_start(DisasContextBase *dcbase, CPUState *cs)
+{
+}
+
+static void rx_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+
+    tcg_gen_insn_start(ctx->base.pc_next);
+}
+
+static bool rx_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
+                                    const CPUBreakpoint *bp)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+
+    /* We have hit a breakpoint - make sure PC is up-to-date */
+    gen_save_cpu_state(ctx, true);
+    gen_helper_debug(cpu_env);
+    ctx->base.is_jmp = DISAS_NORETURN;
+    ctx->base.pc_next += 1;
+    return true;
+}
+
+static void rx_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
+{
+    CPURXState *env = cs->env_ptr;
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+    uint32_t insn;
+
+    ctx->env = env;
+    insn = decode_load(ctx);
+    if (!decode(ctx, insn)) {
+        gen_helper_raise_illegal_instruction(cpu_env);
+    }
+}
+
+static void rx_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+
+    switch (ctx->base.is_jmp) {
+    case DISAS_NEXT:
+    case DISAS_TOO_MANY:
+        gen_save_cpu_state(ctx, false);
+        gen_goto_tb(ctx, 0, dcbase->pc_next);
+        break;
+    case DISAS_JUMP:
+        if (ctx->base.singlestep_enabled) {
+            gen_helper_debug(cpu_env);
+        } else {
+            tcg_gen_lookup_and_goto_ptr();
+        }
+        break;
+    case DISAS_NORETURN:
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void rx_tr_disas_log(const DisasContextBase *dcbase, CPUState *cs)
+{
+    qemu_log("IN:\n");  /* , lookup_symbol(dcbase->pc_first)); */
+    log_target_disas(cs, dcbase->pc_first, dcbase->tb->size);
+}
+
+static const TranslatorOps rx_tr_ops = {
+    .init_disas_context = rx_tr_init_disas_context,
+    .tb_start           = rx_tr_tb_start,
+    .insn_start         = rx_tr_insn_start,
+    .breakpoint_check   = rx_tr_breakpoint_check,
+    .translate_insn     = rx_tr_translate_insn,
+    .tb_stop            = rx_tr_tb_stop,
+    .disas_log          = rx_tr_disas_log,
+};
+
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
+{
+    DisasContext dc;
+
+    translator_loop(&rx_tr_ops, &dc.base, cs, tb);
+}
+
+void restore_state_to_opc(CPURXState *env, TranslationBlock *tb,
+                          target_ulong *data)
+{
+    env->pc = data[0];
+    env->psw = data[1];
+    rx_cpu_unpack_psw(env, 1);
+}
+
+#define ALLOC_REGISTER(sym, name) \
+    cpu_##sym = tcg_global_mem_new_i32(cpu_env, \
+                                       offsetof(CPURXState, sym), name)
+
+void rx_translate_init(void)
+{
+    static const char * const regnames[16] = {
+        "R0", "R1", "R2", "R3", "R4", "R5", "R6", "R7",
+        "R8", "R9", "R10", "R11", "R12", "R13", "R14", "R15"
+    };
+    int i;
+
+    for (i = 0; i < 16; i++) {
+        cpu_regs[i] = tcg_global_mem_new_i32(cpu_env,
+                                              offsetof(CPURXState, regs[i]),
+                                              regnames[i]);
+    }
+    ALLOC_REGISTER(pc, "PC");
+    ALLOC_REGISTER(psw, "PSW");
+    ALLOC_REGISTER(psw_o, "PSW(O)");
+    ALLOC_REGISTER(psw_s, "PSW(S)");
+    ALLOC_REGISTER(psw_z, "PSW(Z)");
+    ALLOC_REGISTER(psw_c, "PSW(C)");
+    ALLOC_REGISTER(psw_u, "PSW(U)");
+    ALLOC_REGISTER(psw_i, "PSW(I)");
+    ALLOC_REGISTER(psw_pm, "PSW(PM)");
+    ALLOC_REGISTER(psw_ipl, "PSW(IPL)");
+    ALLOC_REGISTER(usp, "USP");
+    ALLOC_REGISTER(fpsw, "FPSW");
+    ALLOC_REGISTER(bpsw, "BPSW");
+    ALLOC_REGISTER(bpc, "BPC");
+    ALLOC_REGISTER(isp, "ISP");
+    ALLOC_REGISTER(fintv, "FINTV");
+    ALLOC_REGISTER(intb, "INTB");
+    cpu_acc = tcg_global_mem_new_i64(cpu_env,
+                                     offsetof(CPURXState, acc), "ACC");
+    cpu_pswop = tcg_global_mem_new_i32(cpu_env,
+                                     offsetof(CPURXState, psw_op), "");
+    for (i = 0; i < 3; i++) {
+        cpu_pswop_v[i] = tcg_global_mem_new_i32(cpu_env,
+                                                offsetof(CPURXState, psw_v[i]),
+                                                "");
+    }
+}
-- 
2.11.0
