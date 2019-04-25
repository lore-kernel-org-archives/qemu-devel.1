Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EF3C43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:10:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAC2420651
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dCmNLuXt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAC2420651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60092 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJgx9-0004zc-Oa
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 12:10:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hJgrI-0000lo-T8
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hJgrG-00025R-Vs
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:04:24 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hJgrG-000219-O9
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:04:22 -0400
Received: by mail-pf1-x442.google.com with SMTP id e24so117262pfi.12
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 09:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
	h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
	:content-transfer-encoding;
	bh=nWdlSvpiJ+R9I7Uj4Fwsx1Ebf+bL+Gke5uooZwvmc9U=;
	b=dCmNLuXtI/g+a5y7ZiyFZFIfH+1wYFHyF/UqWbnJyAvKuivx+FOm8R6G9l5edjvHg6
	ynsj+lL1aOTwUECSBiESxotUclrzVmmvTQ5CvQNaaOOBAw9me3L+9QWR3YtZhvw0LFuC
	MnuKS/p6ZlJ1jAuWG2ie2pnLvMP0hn/JJyq4vQEbA6FAtOUym5ZJi04yCzdRcAMqdJao
	u654c71Matd6wwAKlfOrtW5MmgGrlY+9YUCvMvbyKp6Jzf5a9dZgobqVgXI2g51i4b3A
	+h5maeTk97+AA8kTcCtz/cY+lc5CZGXwy0sEs1yLlGWUsApzUUtk4UT+RLcRVrWLWHsG
	8tBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
	:mime-version:content-transfer-encoding;
	bh=nWdlSvpiJ+R9I7Uj4Fwsx1Ebf+bL+Gke5uooZwvmc9U=;
	b=tdjG2aJnta3IGxd8hwWXhhv2hXv0+dGArV8mn2AeXJNTQ9Cqd8fnLJp1O5BQ/HTfax
	blztxxSlbPlb08Y6VYF6GcnVHcHqUKRiBPaCcIrpMBiLg0Hr/vgQ1m2rhbyFA8Wqn8GT
	OT7iozqjnefWM1tUZoejoRLRAR7df6fLfDv7laZDEmZx6Amf98z1d15Ju1ivAVNlYfwy
	nJUag5T1fGJ8/oV7J0vI0Xk+7FrXV9p9wMsmVn64Yq2ZX05MC1+gwYkRYBZcw4wMJVyJ
	5DIE4HVjFkrG/PnftEWsjiVtB9IyvCWntFaYBoxBaKBIf0hbqHJIX5ku1uvXDzL7bZTa
	37BQ==
X-Gm-Message-State: APjAAAVsRSF1O/DpD/lrOtQRxSo3ZeVmDtwFPvtHmqbWvAo2qG1/YPaz
	bfda/Cz7XdcchGrpBdQCD3BYmT8FxfM=
X-Google-Smtp-Source: APXvYqwJJ7fnwEwyRf9CMor2ExTJ4nhGOBNX0rQbhOLrHPvrVCUQyT7YKHNTmqgP6ont9Y/ll14l3A==
X-Received: by 2002:a65:654c:: with SMTP id a12mr6593269pgw.101.1556208259699; 
	Thu, 25 Apr 2019 09:04:19 -0700 (PDT)
Received: from localhost ([134.134.139.92]) by smtp.gmail.com with ESMTPSA id
	p14sm35730486pfa.26.2019.04.25.09.04.18
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 09:04:18 -0700 (PDT)
Date: Thu, 25 Apr 2019 09:04:18 -0700 (PDT)
X-Google-Original-Date: Thu, 25 Apr 2019 08:13:57 PDT (-0700)
In-Reply-To: <20190401031155.21293-6-richard.henderson@linaro.org>
From: Palmer Dabbelt <palmer@sifive.com>
To: richard.henderson@linaro.org
Message-ID: <mhng-04e16861-08f5-49ca-9f8a-00d3cdcb103b@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH for-4.1 5/8] target/riscv: Use pattern
 groups in insn16.decode
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425160418.-iieLINJUe7WmOWQGzAjyorJg7RKDXfS_af-b3zbiQc@z>

On Sun, 31 Mar 2019 20:11:52 PDT (-0700), richard.henderson@linaro.org wrote:
> This eliminates about half of the complicated decode
> bits within insn_trans/trans_rvc.inc.c.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/riscv/insn_trans/trans_rvc.inc.c | 63 -------------------------
>  target/riscv/insn_trans/trans_rvi.inc.c |  6 +++
>  target/riscv/insn16.decode              | 29 +++++++++---
>  3 files changed, 29 insertions(+), 69 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvc.inc.c b/target/riscv/insn_trans/trans_rvc.inc.c
> index 691b1e2725..43bff97f66 100644
> --- a/target/riscv/insn_trans/trans_rvc.inc.c
> +++ b/target/riscv/insn_trans/trans_rvc.inc.c
> @@ -18,16 +18,6 @@
>   * this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>
> -static bool trans_c_addi4spn(DisasContext *ctx, arg_c_addi4spn *a)
> -{
> -    if (a->nzuimm == 0) {
> -        /* Reserved in ISA */
> -        return false;
> -    }
> -    arg_addi arg = { .rd = a->rd, .rs1 = 2, .imm = a->nzuimm };
> -    return trans_addi(ctx, &arg);
> -}
> -
>  static bool trans_c_flw_ld(DisasContext *ctx, arg_c_flw_ld *a)
>  {
>  #ifdef TARGET_RISCV32
> @@ -79,25 +69,6 @@ static bool trans_c_jal_addiw(DisasContext *ctx, arg_c_jal_addiw *a)
>  #endif
>  }
>
> -static bool trans_c_addi16sp_lui(DisasContext *ctx, arg_c_addi16sp_lui *a)
> -{
> -    if (a->rd == 2) {
> -        /* C.ADDI16SP */
> -        arg_addi arg = { .rd = 2, .rs1 = 2, .imm = a->imm_addi16sp };
> -        return trans_addi(ctx, &arg);
> -    } else if (a->imm_lui != 0) {
> -        /* C.LUI */
> -        if (a->rd == 0) {
> -            /* Hint: insn is valid but does not affect state */
> -            return true;
> -        }
> -        arg_lui arg = { .rd = a->rd, .imm = a->imm_lui };
> -        return trans_lui(ctx, &arg);
> -    }
> -    return false;
> -}
> -
> -
>  static bool trans_c_subw(DisasContext *ctx, arg_c_subw *a)
>  {
>  #ifdef TARGET_RISCV64
> @@ -130,40 +101,6 @@ static bool trans_c_flwsp_ldsp(DisasContext *ctx, arg_c_flwsp_ldsp *a)
>      return false;
>  }
>
> -static bool trans_c_jr_mv(DisasContext *ctx, arg_c_jr_mv *a)
> -{
> -    if (a->rd != 0 && a->rs2 == 0) {
> -        /* C.JR */
> -        arg_jalr arg = { .rd = 0, .rs1 = a->rd, .imm = 0 };
> -        return trans_jalr(ctx, &arg);
> -    } else if (a->rd != 0 && a->rs2 != 0) {
> -        /* C.MV */
> -        arg_add arg = { .rd = a->rd, .rs1 = 0, .rs2 = a->rs2 };
> -        return trans_add(ctx, &arg);
> -    }
> -    return false;
> -}
> -
> -static bool trans_c_ebreak_jalr_add(DisasContext *ctx, arg_c_ebreak_jalr_add *a)
> -{
> -    if (a->rd == 0 && a->rs2 == 0) {
> -        /* C.EBREAK */
> -        arg_ebreak arg = { };
> -        return trans_ebreak(ctx, &arg);
> -    } else if (a->rd != 0) {
> -        if (a->rs2 == 0) {
> -            /* C.JALR */
> -            arg_jalr arg = { .rd = 1, .rs1 = a->rd, .imm = 0 };
> -            return trans_jalr(ctx, &arg);
> -        } else {
> -            /* C.ADD */
> -            arg_add arg = { .rd = a->rd, .rs1 = a->rd, .rs2 = a->rs2 };
> -            return trans_add(ctx, &arg);
> -        }
> -    }
> -    return false;
> -}
> -
>  static bool trans_c_fswsp_sdsp(DisasContext *ctx, arg_c_fswsp_sdsp *a)
>  {
>  #ifdef TARGET_RISCV32
> diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
> index d420a4d8b2..caf91f9a05 100644
> --- a/target/riscv/insn_trans/trans_rvi.inc.c
> +++ b/target/riscv/insn_trans/trans_rvi.inc.c
> @@ -18,6 +18,12 @@
>   * this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>
> +static bool trans_illegal(DisasContext *ctx, arg_empty *a)
> +{
> +    gen_exception_illegal(ctx);
> +    return true;
> +}
> +
>  static bool trans_lui(DisasContext *ctx, arg_lui *a)
>  {
>      if (a->rd != 0) {
> diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
> index add9cf3923..3c79edf1c9 100644
> --- a/target/riscv/insn16.decode
> +++ b/target/riscv/insn16.decode
> @@ -70,7 +70,6 @@
>  # Formats 16:
>  @cr        ....  ..... .....  .. &r      rs2=%rs2_5       rs1=%rd     %rd
>  @ci        ... . ..... .....  .. &i      imm=%imm_ci      rs1=%rd     %rd
> -@ciw       ...   ........ ... .. &ciw    nzuimm=%nzuimm_ciw           rd=%rs2_3
>  @cl_d      ... ... ... .. ... .. &i      imm=%uimm_cl_d   rs1=%rs1_3  rd=%rs2_3
>  @cl_w      ... ... ... .. ... .. &i      imm=%uimm_cl_w   rs1=%rs1_3  rd=%rs2_3
>  @cl        ... ... ... .. ... .. &cl                      rs1=%rs1_3  rd=%rs2_3
> @@ -86,8 +85,12 @@
>  @c_sdsp    ... . .....  ..... .. &s      imm=%uimm_6bit_sd rs1=2 rs2=%rs2_5
>  @c_swsp    ... . .....  ..... .. &s      imm=%uimm_6bit_sw rs1=2 rs2=%rs2_5
>  @c_li      ... . .....  ..... .. &i      imm=%imm_ci rs1=0 %rd
> +@c_lui     ... . .....  ..... .. &u      imm=%imm_lui %rd
> +@c_jalr    ... . .....  ..... .. &i      imm=0 rs1=%rd
> +@c_mv      ... . ..... .....  .. &i      imm=0 rs1=%rs2_5 %rd
>
> -@c_addi16sp_lui ... .  ..... ..... .. &caddi16sp_lui %imm_lui %imm_addi16sp %rd
> +@c_addi4spn     ... .  ..... ..... .. &i imm=%nzuimm_ciw rs1=2 rd=%rs2_3
> +@c_addi16sp     ... .  ..... ..... .. &i imm=%imm_addi16sp rs1=2 rd=2
>  @c_flwsp_ldsp   ... .  ..... ..... .. &cflwsp_ldsp uimm_flwsp=%uimm_6bit_lw \
>      uimm_ldsp=%uimm_6bit_ld %rd
>  @c_fswsp_sdsp   ... .  ..... ..... .. &cfswsp_sdsp uimm_fswsp=%uimm_6bit_sw \
> @@ -101,7 +104,11 @@
>  @c_andi         ... . .. ... ..... .. &i imm=%imm_ci rs1=%rs1_3 rd=%rs1_3
>
>  # *** RV64C Standard Extension (Quadrant 0) ***
> -c_addi4spn        000    ........ ... 00 @ciw
> +{
> +  # Opcode of all zeros is illegal; rd != 0, nzuimm == 0 is reserved.
> +  illegal         000  000 000 00 --- 00
> +  addi            000  ... ... .. ... 00 @c_addi4spn
> +}
>  fld               001  ... ... .. ... 00 @cl_d
>  lw                010  ... ... .. ... 00 @cl_w
>  c_flw_ld          011  --- ... -- ... 00 @cl    #Note: Must parse uimm manually
> @@ -113,7 +120,10 @@ c_fsw_sd          111  --- ... -- ... 00 @cs    #Note: Must parse uimm manually
>  addi              000 .  .....  ..... 01 @ci
>  c_jal_addiw       001 .  .....  ..... 01 @ci #Note: parse rd and/or imm manually
>  addi              010 .  .....  ..... 01 @c_li
> -c_addi16sp_lui    011 .  .....  ..... 01 @c_addi16sp_lui # shares opc with C.LUI
> +{
> +  addi            011 .  00010  ..... 01 @c_addi16sp
> +  lui             011 .  .....  ..... 01 @c_lui
> +}
>  srli              100 . 00 ...  ..... 01 @c_shift
>  srai              100 . 01 ...  ..... 01 @c_shift
>  andi              100 . 10 ...  ..... 01 @c_andi
> @@ -132,8 +142,15 @@ slli              000 .  .....  ..... 10 @c_shift2
>  fld               001 .  .....  ..... 10 @c_ldsp
>  lw                010 .  .....  ..... 10 @c_lwsp
>  c_flwsp_ldsp      011 .  .....  ..... 10 @c_flwsp_ldsp #C.LDSP:RV64;C.FLWSP:RV32
> -c_jr_mv           100 0  .....  ..... 10 @cr
> -c_ebreak_jalr_add 100 1  .....  ..... 10 @cr
> +{
> +  jalr            100 0  .....  00000 10 @c_jalr rd=0  # C.JR
> +  addi            100 0  .....  ..... 10 @c_mv
> +}
> +{
> +  ebreak          100 1  00000  00000 10
> +  jalr            100 1  .....  00000 10 @c_jalr rd=1  # C.JALR
> +  add             100 1  .....  ..... 10 @cr
> +}
>  fsd               101   ......  ..... 10 @c_sdsp
>  sw                110 .  .....  ..... 10 @c_swsp
>  c_fswsp_sdsp      111 .  .....  ..... 10 @c_fswsp_sdsp #C.SDSP:RV64;C.FSWSP:RV32

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

