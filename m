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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC028C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 21:11:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8254B2080C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 21:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiyKreJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8254B2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBPB7-0000Ju-QT
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 17:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kBPAR-0008Ig-So
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 17:10:43 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:46952)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kBPAO-0005gX-PJ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 17:10:43 -0400
Received: by mail-lj1-x243.google.com with SMTP id h19so8025670ljg.13
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 14:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=5TAc988/d9jnBKYQivedJuRuD3WvGHRDYTqqBi9ou5Y=;
 b=BiyKreJc8yMFL6levQ/fzrJmCdN673IyG1DctsVKB5TGv1fSx4Dtrg39Pilpx7QkFE
 j9Lik1TLWXaPUbNXL0Edsm0Y4bENCA745iTG+avuZ+76IVnyDbpRoHoMoySabHgFMJZI
 H+x3W3twdfDlg/P3ojtpQnPNrRBR6crXeNCeGJfa2G42CnCAQsDQas7uxfFzfrmepjOc
 JgI6xeNp3qVTA4HyQXQpfXZsvNK2hNqCKdcWEcc1l1lICqqq9giE+WdQHbb+Q4PLb2Nx
 nN4onT4V+/55FaTr+lpzua0CvBcoSnj3hPhXJEGRQFCFpiV/55IOnuJIMOqZAWv81b58
 99Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5TAc988/d9jnBKYQivedJuRuD3WvGHRDYTqqBi9ou5Y=;
 b=MO3Atp/7LSsAElzLf7E15bu49jMsrSMXd/a2tkGKrUl5FvIUkjnVjVPwuxPVVVDf/R
 0jenlpmodqNCj9jr9wP2iHYFZbcHO1Hyt5EkJz+kttzrdeU+BYCFvLeM16JmUNnJyQGi
 Cjtz6rijw4RzgcCaBq4t0ejoVRdoHUNSqPpDaeAgzoRaxQmnjEuHSwRzXaMHvqyEcnCO
 DqgJfMtk0GmTnNNu7cRMuXvwWKq6V+MaVmadaIebcfK48khmp5Z6dJ4o+oIAnEKiGubO
 UUljVLaZLXu4qO3airYc3i4mwaNLbhYO/rj60rVjCQ4x+M6GUwFh7QrVo77E1RJh7ziw
 UTMw==
X-Gm-Message-State: AOAM533ALpdfyEN2Blb1P/lGqiCTH1q6SUB8YRfY+qHkWshrJ1biTGm1
 SNEaS2ClECfvRAoatGhpv/o=
X-Google-Smtp-Source: ABdhPJyQ1FLo5CHj5NhPoFTcgvdpQ7K1fpyylSte5b6UlJQ4zUZ3Rr1t8hsGiuGzLH+qjuj8Oc3N/A==
X-Received: by 2002:a2e:164f:: with SMTP id 15mr10925810ljw.68.1598562638546; 
 Thu, 27 Aug 2020 14:10:38 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id t27sm701645ljd.101.2020.08.27.14.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 14:10:37 -0700 (PDT)
Date: Thu, 27 Aug 2020 23:10:37 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 73/77] target/microblaze: Convert dec_stream to decodetree
Message-ID: <20200827211037.GQ2954729@toto>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
 <20200825205950.730499-74-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825205950.730499-74-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x243.google.com
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

On Tue, Aug 25, 2020 at 01:59:46PM -0700, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/microblaze/insns.decode |  6 ++++
>  target/microblaze/translate.c  | 64 ++++++++++++++++++++++++++--------
>  2 files changed, 55 insertions(+), 15 deletions(-)
> 
> diff --git a/target/microblaze/insns.decode b/target/microblaze/insns.decode
> index 48c60082e0..79d32c826c 100644
> --- a/target/microblaze/insns.decode
> +++ b/target/microblaze/insns.decode
> @@ -156,6 +156,9 @@ flt             010110 ..... ..... ----- 0101 000 0000  @typea0
>  fint            010110 ..... ..... ----- 0110 000 0000  @typea0
>  fsqrt           010110 ..... ..... 00000 0111 000 0000  @typea0
>  
> +get             011011 rd:5  00000 0 ctrl:5 000000 imm:4
> +getd            010011 rd:5  00000 rb:5  0 ctrl:5  00000
> +
>  idiv            010010 ..... ..... ..... 000 0000 0000  @typea
>  idivu           010010 ..... ..... ..... 000 0000 0010  @typea
>  
> @@ -198,6 +201,9 @@ pcmpbf          100000 ..... ..... ..... 100 0000 0000  @typea
>  pcmpeq          100010 ..... ..... ..... 100 0000 0000  @typea
>  pcmpne          100011 ..... ..... ..... 100 0000 0000  @typea
>  
> +put             011011 00000 ra:5  1 ctrl:5 000000 imm:4
> +putd            010011 00000 ra:5  rb:5  1 ctrl:5  00000
> +
>  rsub            000001 ..... ..... ..... 000 0000 0000  @typea
>  rsubc           000011 ..... ..... ..... 000 0000 0000  @typea
>  rsubk           000101 ..... ..... ..... 000 0000 0000  @typea
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index e9e4a0e1db..0a05b49f8e 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -1587,33 +1587,68 @@ static void dec_null(DisasContext *dc)
>  }
>  
>  /* Insns connected to FSL or AXI stream attached devices.  */
> -static void dec_stream(DisasContext *dc)
> +static bool do_get(DisasContext *dc, int rd, int rb, int imm, int ctrl)
>  {
>      TCGv_i32 t_id, t_ctrl;
> -    int ctrl;
>  
>      if (trap_userspace(dc, true)) {
> -        return;
> +        return true;
>      }
>  
>      t_id = tcg_temp_new_i32();
> -    if (dc->type_b) {
> -        tcg_gen_movi_i32(t_id, dc->imm & 0xf);
> -        ctrl = dc->imm >> 10;
> +    if (rb) {
> +        tcg_gen_andi_i32(t_id, cpu_R[rb], 0xf);
>      } else {
> -        tcg_gen_andi_i32(t_id, cpu_R[dc->rb], 0xf);
> -        ctrl = dc->imm >> 5;
> +        tcg_gen_movi_i32(t_id, imm);
>      }
>  
>      t_ctrl = tcg_const_i32(ctrl);
> -
> -    if (dc->rd == 0) {
> -        gen_helper_put(t_id, t_ctrl, cpu_R[dc->ra]);
> -    } else {
> -        gen_helper_get(cpu_R[dc->rd], t_id, t_ctrl);
> -    }
> +    gen_helper_get(reg_for_write(dc, rd), t_id, t_ctrl);
>      tcg_temp_free_i32(t_id);
>      tcg_temp_free_i32(t_ctrl);
> +    return true;
> +}
> +
> +static bool trans_get(DisasContext *dc, arg_get *arg)
> +{
> +    return do_get(dc, arg->rd, 0, arg->imm, arg->ctrl);
> +}
> +
> +static bool trans_getd(DisasContext *dc, arg_getd *arg)
> +{
> +    return do_get(dc, arg->rd, arg->rb, 0, arg->ctrl);
> +}
> +
> +static bool do_put(DisasContext *dc, int ra, int rb, int imm, int ctrl)
> +{
> +    TCGv_i32 t_id, t_ctrl;
> +
> +    if (trap_userspace(dc, true)) {
> +        return true;
> +    }
> +
> +    t_id = tcg_temp_new_i32();
> +    if (rb) {
> +        tcg_gen_andi_i32(t_id, cpu_R[rb], 0xf);
> +    } else {
> +        tcg_gen_movi_i32(t_id, imm);
> +    }
> +
> +    t_ctrl = tcg_const_i32(ctrl);
> +    gen_helper_get(t_id, t_ctrl, reg_for_read(dc, ra));


I think you've got a typo here, get -> put.

Cheers,
Edgar

