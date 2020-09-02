Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE683C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:17:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F67B20684
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaM3HxQX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F67B20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDWON-0001lW-MH
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 13:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDWKZ-0005In-Vj
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:13:56 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40666)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDWKY-0001yK-4u
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:13:55 -0400
Received: by mail-wr1-x441.google.com with SMTP id j2so200324wrx.7
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 10:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=D3GlCHseyvaT+D8ZUmhgSFDnZIH+dXaS+DervvALfuA=;
 b=EaM3HxQXY2evyCmji0d8+oaA4Tuo5bUdQDEuVLnbu/d/+aNsIPi7z3+h50FLt6cvRq
 dTCCcljozme4ZvrkefiQi1l3fXatNKwJvSvelHESA71MUMMgJbKE4S8umbok6o0PPnx1
 3i8keakQltSHV0w3K5UuU4EhlkPDpPM/Og3Fyiw1dvuerB18TWDNlshhtT1zaLtp5GwC
 m8h2Tc7jUD7ykM4cHgqQh8v7QlKOc3nruGJGJ/Oi9Q7fBRGJw+IdGNPN7kpnkd/PlCBC
 M8LMtl7k+vwI5bRoq02DAmzvCCcjIOAkDFS1FJNXhYEUQMYlNZ5Abxdpcg9TtnBELLz0
 R0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=D3GlCHseyvaT+D8ZUmhgSFDnZIH+dXaS+DervvALfuA=;
 b=Flak2cPCK2RJLGNVCjCPGmhzw0TC0zjlRm5oxcpu54OC3DTFwEHdsLWMbvw3iw2y8w
 0ux+ltS7r2lvXLxLMz2/x58k+ivPZq+nc9A3oTM7AqN6hlM5GsG4FDygznGVHz0Do95T
 JiAjj6Hp/Evx5mq45e7f+MH8xhox3K35nBCY4nHoey+bNh6VNCQXa1L5tirzpvRKD5S7
 jWuQE2e7J9aT+14jTaSZQxbWyIKi/gDy6FLjm4umcZFUqcGJFVPVRVzJmg8QUTM3nPlW
 tHZxsuwhebxj8Uq1K87p6SbQOBIO8qQLpmPoxufSXqj3OPEYjy0GK5yd4J2+k5jDwSOZ
 FFog==
X-Gm-Message-State: AOAM531K6qU6smqK2+kBnpd9pCmtD8F7J3UhH/DeijSbgt9mRMoHBHKJ
 03lnLABbJYqIlL/NLUX3sKJWZDecINQ=
X-Google-Smtp-Source: ABdhPJxKwJeXtRfYtlrdqG03alV37AjDqmiBhGpVG7anAnN1W6xjbNpdFR/uuruVJjEl7znVqdQTJg==
X-Received: by 2002:adf:ae42:: with SMTP id u2mr7734406wrd.337.1599066832680; 
 Wed, 02 Sep 2020 10:13:52 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id 70sm504939wme.15.2020.09.02.10.13.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 10:13:52 -0700 (PDT)
Subject: Re: [PATCH 7/7] target/microblaze: Diagnose invalid insns in delay
 slots
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200902163559.1077728-1-richard.henderson@linaro.org>
 <20200902163559.1077728-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <11e67139-9af2-3cc1-2b5a-c2bfd6eb8da6@amsat.org>
Date: Wed, 2 Sep 2020 19:13:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902163559.1077728-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-0.324,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/2/20 6:35 PM, Richard Henderson wrote:
> These cases result in undefined and undocumented behaviour but the
> behaviour is deterministic, i.e cores will not lock-up or expose
> security issues.  However, RTL will not raise exceptions either.
> 
> Therefore, log a GUEST_ERROR and treat these cases as nops, to
> avoid corner cases which could put qemu into an invalid state.

Excellent! This is the same issue I have with TX39 MIPS cores :)
Thanks for the clean fix.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/microblaze/translate.c | 47 +++++++++++++++++++++++++++++------
>  1 file changed, 40 insertions(+), 7 deletions(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 4416361d08..caa4831aed 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -179,6 +179,20 @@ static bool trap_userspace(DisasContext *dc, bool cond)
>      return cond_user;
>  }
>  
> +/*
> + * Return true, and log an error, if the current insn is
> + * within a delay slot.
> + */
> +static bool invalid_delay_slot(DisasContext *dc, const char *insn_type)
> +{
> +    if (dc->tb_flags & D_FLAG) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Invalid insn in delay slot: %s\n", insn_type);
> +        return true;
> +    }
> +    return false;
> +}
> +
>  static TCGv_i32 reg_for_read(DisasContext *dc, int reg)
>  {
>      if (likely(reg != 0)) {
> @@ -500,6 +514,9 @@ DO_TYPEA_CFG(idivu, use_div, true, gen_idivu)
>  
>  static bool trans_imm(DisasContext *dc, arg_imm *arg)
>  {
> +    if (invalid_delay_slot(dc, "imm")) {
> +        return true;
> +    }
>      dc->ext_imm = arg->imm << 16;
>      tcg_gen_movi_i32(cpu_imm, dc->ext_imm);
>      dc->tb_flags_to_set = IMM_FLAG;
> @@ -1067,6 +1084,9 @@ static bool do_branch(DisasContext *dc, int dest_rb, int dest_imm,
>  {
>      uint32_t add_pc;
>  
> +    if (invalid_delay_slot(dc, "branch")) {
> +        return true;
> +    }
>      if (delay) {
>          setup_dslot(dc, dest_rb < 0);
>      }
> @@ -1106,6 +1126,9 @@ static bool do_bcc(DisasContext *dc, int dest_rb, int dest_imm,
>  {
>      TCGv_i32 zero, next;
>  
> +    if (invalid_delay_slot(dc, "bcc")) {
> +        return true;
> +    }
>      if (delay) {
>          setup_dslot(dc, dest_rb < 0);
>      }
> @@ -1158,6 +1181,10 @@ static bool trans_brk(DisasContext *dc, arg_typea_br *arg)
>      if (trap_userspace(dc, true)) {
>          return true;
>      }
> +    if (invalid_delay_slot(dc, "brk")) {
> +        return true;
> +    }
> +
>      tcg_gen_mov_i32(cpu_pc, reg_for_read(dc, arg->rb));
>      if (arg->rd) {
>          tcg_gen_movi_i32(cpu_R[arg->rd], dc->base.pc_next);
> @@ -1176,6 +1203,10 @@ static bool trans_brki(DisasContext *dc, arg_typeb_br *arg)
>      if (trap_userspace(dc, imm != 0x8 && imm != 0x18)) {
>          return true;
>      }
> +    if (invalid_delay_slot(dc, "brki")) {
> +        return true;
> +    }
> +
>      tcg_gen_movi_i32(cpu_pc, imm);
>      if (arg->rd) {
>          tcg_gen_movi_i32(cpu_R[arg->rd], dc->base.pc_next);
> @@ -1216,6 +1247,11 @@ static bool trans_mbar(DisasContext *dc, arg_mbar *arg)
>  {
>      int mbar_imm = arg->imm;
>  
> +    /* Note that mbar is a specialized branch instruction. */
> +    if (invalid_delay_slot(dc, "mbar")) {
> +        return true;
> +    }
> +
>      /* Data access memory barrier.  */
>      if ((mbar_imm & 2) == 0) {
>          tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
> @@ -1263,6 +1299,10 @@ static bool do_rts(DisasContext *dc, arg_typeb_bc *arg, int to_set)
>      if (trap_userspace(dc, to_set)) {
>          return true;
>      }
> +    if (invalid_delay_slot(dc, "rts")) {
> +        return true;
> +    }
> +
>      dc->tb_flags_to_set |= to_set;
>      setup_dslot(dc, true);
>  
> @@ -1695,7 +1735,6 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
>      if (dc->jmp_cond != TCG_COND_NEVER && !(dc->tb_flags & D_FLAG)) {
>          /*
>           * Finish any return-from branch.
> -         * TODO: Diagnose rtXd in delay slot of rtYd earlier.
>           */
>          uint32_t rt_ibe = dc->tb_flags & (DRTI_FLAG | DRTB_FLAG | DRTE_FLAG);
>          if (unlikely(rt_ibe != 0)) {
> @@ -1717,12 +1756,6 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
>               * and will handle D_FLAG in mb_cpu_do_interrupt.
>               */
>              break;
> -        case DISAS_EXIT:
> -            /*
> -             * TODO: diagnose brk/brki in delay slot earlier.
> -             * This would then fold into the illegal insn case above.
> -             */
> -            break;
>          case DISAS_NEXT:
>              /*
>               * Normal insn a delay slot.
> 


