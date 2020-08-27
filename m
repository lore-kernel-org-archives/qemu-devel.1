Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE4AC433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:18:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DC35207CD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvZAg91t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC35207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBNPN-0002vA-MV
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 15:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kBNOp-0002Ud-AF
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:17:27 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:33771)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kBNOn-0008Fw-Ha
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:17:27 -0400
Received: by mail-lj1-x244.google.com with SMTP id r13so4284681ljm.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 12:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=5MmcG2WUG/QravcvfaUdLtMrqeg1UHkiH48156QYyvI=;
 b=bvZAg91tMR+2JG88g9JOpE7++I3kfEWMq4WuqLbABbqFh8zyAguSzTs6mQJY/uzvy7
 mWwrQg0ld5KefnZCOY+udrtkdnp7AFQK/HqnZh0xdYnVSzu4kSJCvgyV6DfcjF1Jk1OS
 x7yw8lqjQF01t6HEHeFvdSByEkc7CKYpdYuYSHbBeeTDQXZDI8Cz3gDf2/4mT9N2aqHm
 SvS0Hao8nTYKIjuO4oKQpGNNqFJeovrNl2USden04WkSmKa2fQ4ADuEO+9XjYhlVDq75
 Hk5uibIitBb1d0FFA+UjoR0E50hS57LjX6zJ1IWmT2QShGPKVCDj1xcM2jSbg9CZ17Bq
 VE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5MmcG2WUG/QravcvfaUdLtMrqeg1UHkiH48156QYyvI=;
 b=tpurUPeCx3AkTUGTyc7VIYix6EHKxdAnFGpY12kIwynZt1KqtEickRdHL8eECg3rPd
 yXnDzWxhT1ONMxQH2H20Ad8YVTlkXQl+q1d5T5wPQGJ1uM3UwNl9pTRiR7AALuPk/i9e
 wFtFbUP4MfLGzA2LL/5BjspDW9qY77lHz4YJiLCnNDZybPAlwwt9pvlEmT0NPYN0WduQ
 XT2+wt4XQU8gZQU8/XnxEqUWE7vFH9CFRiiqup7yZ4HXw4Gg5asOruElWxFOmLo0it76
 70XehMUzqzKQqAmL0jAZR9SFViGgrF13fHuGHchCqxmp2+9jxIIHhwJUWCzEm4RJnSXX
 C4Pg==
X-Gm-Message-State: AOAM531U7jlqJLJAIjeaPM7w0VHx17skxUMM3EfGGrWgjoF/75+NHbiR
 2dg5lesOzTeuqEQt+HRDRz4=
X-Google-Smtp-Source: ABdhPJzbmufDVzp6wOK0DJYSsOPBcuTBp6uvKcPbFAozPRJOVH3Ig2+sika7SpZruGCwHYkweg7lOw==
X-Received: by 2002:a2e:8ed4:: with SMTP id e20mr11120851ljl.403.1598555843505; 
 Thu, 27 Aug 2020 12:17:23 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id l133sm716839lfd.74.2020.08.27.12.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 12:17:22 -0700 (PDT)
Date: Thu, 27 Aug 2020 21:17:22 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 62/77] target/microblaze: Try to keep imm and delay slot
 together
Message-ID: <20200827191722.GP2954729@toto>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
 <20200825205950.730499-63-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825205950.730499-63-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 18
X-Spam_score: 1.8
X-Spam_bar: +
X-Spam_report: (1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.899, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 25, 2020 at 01:59:35PM -0700, Richard Henderson wrote:
> If the last insn on a page is imm, or a branch with delay slot,
> then end a tb early if this has not begun the tb.  If it has
> begun the tb, then we can allow the tb to span two pages as if
> the imm plus its consumer, or branch plus delay, or imm plus
> branch plus delay, are a single insn.
> 
> If the insn in the delay slot faults, then the exception handler
> will have reset the PC to the beginning of this sequence anyway,
> via the stored D_FLAG and BIMM_FLAG bits.
> 
> Disable all of this when single-stepping.


Hi Richard,

We've got a Linux boot that fails after applying this patch.
It goes from always working to only working like 1 out of 3 times.
It fails deep in user-space so I don't have a good log for it.

I guess we'll have to review this patch more.

I can share images but the machine is (DTB) dynamic so it only runs with
Xilinx QEMU 5.1 branch (I've backported your series for testing).

Cheers,
Edgar

> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/microblaze/translate.c | 65 ++++++++++++++++++++++++++++++-----
>  1 file changed, 56 insertions(+), 9 deletions(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 4675326083..fcfc1ac184 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -530,11 +530,50 @@ static void gen_idivu(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
>  DO_TYPEA_CFG(idiv, use_div, true, gen_idiv)
>  DO_TYPEA_CFG(idivu, use_div, true, gen_idivu)
>  
> +/*
> + * Try to keep the current instruction with the one following.
> + * So if this insn is the last in the TB, and is not the first
> + * in the TB, and we are not singlestepping, then back up and
> + * exit the current TB.
> + */
> +static bool wait_for_next_tb(DisasContext *dc)
> +{
> +    if (dc->base.num_insns >= dc->base.max_insns
> +        && !dc->base.singlestep_enabled) {
> +        /* Also consider if this insn (e.g. brid) itself uses an imm. */
> +        int ninsns = (dc->tb_flags & IMM_FLAG ? 2 : 1);
> +
> +        /*
> +         * If this is not the first insn in the TB, back up and
> +         * start again with a new TB.
> +         */
> +        if (dc->base.num_insns > ninsns) {
> +            dc->base.pc_next -= ninsns * 4;
> +            dc->base.num_insns -= ninsns;
> +            dc->base.is_jmp = DISAS_TOO_MANY;
> +            return true;
> +        }
> +
> +        /*
> +         * Correspondingly, if this is the first insn of the TB,
> +         * then extend the TB as necessary to keep it with the
> +         * next insn.  Do this by *reducing* the number of insns
> +         * processed by this TB so that icount does fail an assertion.
> +         */
> +        if (dc->base.num_insns == ninsns) {
> +            dc->base.num_insns = 0;
> +        }
> +    }
> +    return false;
> +}
> +
>  static bool trans_imm(DisasContext *dc, arg_imm *arg)
>  {
> -    dc->ext_imm = arg->imm << 16;
> -    tcg_gen_movi_i32(cpu_imm, dc->ext_imm);
> -    dc->tb_flags_to_set = IMM_FLAG;
> +    if (!wait_for_next_tb(dc)) {
> +        dc->ext_imm = arg->imm << 16;
> +        tcg_gen_movi_i32(cpu_imm, dc->ext_imm);
> +        dc->tb_flags_to_set = IMM_FLAG;
> +    }
>      return true;
>  }
>  
> @@ -1311,12 +1350,17 @@ static void eval_cond_jmp(DisasContext *dc, TCGv_i32 pc_true, TCGv_i32 pc_false)
>      tcg_temp_free_i32(zero);
>  }
>  
> -static void dec_setup_dslot(DisasContext *dc)
> +static bool dec_setup_dslot(DisasContext *dc)
>  {
> +    if (wait_for_next_tb(dc)) {
> +        return true;
> +    }
> +
>      dc->tb_flags_to_set |= D_FLAG;
>      if (dc->type_b && (dc->tb_flags & IMM_FLAG)) {
>          dc->tb_flags_to_set |= BIMM_FLAG;
>      }
> +    return false;
>  }
>  
>  static void dec_bcc(DisasContext *dc)
> @@ -1327,8 +1371,8 @@ static void dec_bcc(DisasContext *dc)
>      cc = EXTRACT_FIELD(dc->ir, 21, 23);
>      dslot = dc->ir & (1 << 25);
>  
> -    if (dslot) {
> -        dec_setup_dslot(dc);
> +    if (dslot && dec_setup_dslot(dc)) {
> +        return;
>      }
>  
>      if (dc->type_b) {
> @@ -1402,9 +1446,10 @@ static void dec_br(DisasContext *dc)
>          }
>      }
>  
> -    if (dslot) {
> -        dec_setup_dslot(dc);
> +    if (dslot && dec_setup_dslot(dc)) {
> +        return;
>      }
> +
>      if (link && dc->rd) {
>          tcg_gen_movi_i32(cpu_R[dc->rd], dc->base.pc_next);
>      }
> @@ -1513,7 +1558,9 @@ static void dec_rts(DisasContext *dc)
>          return;
>      }
>  
> -    dec_setup_dslot(dc);
> +    if (dec_setup_dslot(dc)) {
> +        return;
> +    }
>  
>      if (i_bit) {
>          dc->tb_flags |= DRTI_FLAG;
> -- 
> 2.25.1
> 

