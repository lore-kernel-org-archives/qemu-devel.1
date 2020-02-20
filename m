Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3501C11D0C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 17:05:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7401820722
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 17:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="raa+QBZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7401820722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4pG1-0001xj-Gt
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 12:05:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j4pEE-0000Qq-6j
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:03:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j4pEB-0005c0-Nl
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:03:09 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:46127)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j4pEB-0005bM-G2
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:03:07 -0500
Received: by mail-oi1-x241.google.com with SMTP id a22so28217809oid.13
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 09:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cdb3TMg4prEF+OQHOf2N7J8Way5onsKPgO4qcQpe6dE=;
 b=raa+QBZCSvTNaCOaUGtkBNYXFfpRktpv7id7nifqgRZZLRfj3taWGZlQQitZiwzMlR
 0HgTl2m/faePEB+mYNif92lJ3BNE2uYeNriYBYzaoefIdtpBlgfDeFfNb9U6jTsLULSQ
 9rU/fkqSVMz9fUqLXq9mSwDNJdBXwXAURwaSJoqcVC9adn8Nl588OkpQ/4O0YKr5WDHi
 5RNlI05i3PkLuLi8MA4w3R6dqKUfEG6rS/hD7bvU7sGi4+jJ/gCeFvYggNoHFEES+iUe
 +qGDK1eZh5GG31jFJkf3mXt3tHyknc0XwtIq5ctW1hiMAb4whKFeyJQUi2lndewncASj
 FhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cdb3TMg4prEF+OQHOf2N7J8Way5onsKPgO4qcQpe6dE=;
 b=Qkbbz/oDleTPs5Wza/+b8m3qtchJXBluo+RAEWJYBpdesbCUvPdKgRu/CrSL8UO2IV
 VdjG61COIRpFuwTHzcZ7vtAh/mvPiLEpc6qcjtke+sdN78tZbMR4nZxueqmEWPw2K7BL
 QuvpcvZ5pr2ii/b1FSFGb1IbFEdUcgsqkm5lObUKuGLKM112rUyH5WyQPOz5so4ZHww1
 AgLiDpuDxjE5EWo9mhH04CRrjOkAykZRxg1GvwnVSPOuNwkbgZbIfTnRJ5AshQHThzWq
 ln/6GyTZFzc7TVWBQgwqhPb43Ql2kX4rqWsuB2FCCaa7UsRCkzyJQMpGCmwUMfrZYqQK
 tN0A==
X-Gm-Message-State: APjAAAUO/PaHw3MzNC9t4VfGh6f2Z7lxx5lYbEph9QOXEt+FDuHoGo32
 AnJ03qn9w1KyRYyLTNgpO5A8Q8kxC0HBljLGbu+RlQ==
X-Google-Smtp-Source: APXvYqxE9QAOpmgAM8GlCJnv6JFUgDXIWzxRpTo4vY6vC3ffqiBZoXgZ8gQ1iMwwMnMKsWO9JQfBmGxxfZHW0FWdeZ4=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr2729616oic.48.1582218186118; 
 Thu, 20 Feb 2020 09:03:06 -0800 (PST)
MIME-Version: 1.0
References: <20200214181547.21408-1-richard.henderson@linaro.org>
 <20200214181547.21408-14-richard.henderson@linaro.org>
In-Reply-To: <20200214181547.21408-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2020 17:02:55 +0000
Message-ID: <CAFEAcA_YZt26sZhfRtUpOjZYpfCT3r0qQe9q_sAk_4f8y1Tdpw@mail.gmail.com>
Subject: Re: [PATCH 13/19] target/arm: Move VLLDM and VLSTM to vfp.decode
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Feb 2020 at 18:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Now that we no longer have an early check for ARM_FEATURE_VFP,
> we can use the proper ISA check in trans_VLLDM_VLSTM.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/vfp.decode          |  2 ++
>  target/arm/translate-vfp.inc.c | 35 ++++++++++++++++++++++
>  target/arm/translate.c         | 53 ++++++----------------------------
>  3 files changed, 46 insertions(+), 44 deletions(-)
>
> diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
> index a67b3f29ee..592fe9e1e4 100644
> --- a/target/arm/vfp.decode
> +++ b/target/arm/vfp.decode
> @@ -242,3 +242,5 @@ VCVT_sp_int  ---- 1110 1.11 110 s:1 .... 1010 rz:1 1.0 .... \
>               vd=%vd_sp vm=%vm_sp
>  VCVT_dp_int  ---- 1110 1.11 110 s:1 .... 1011 rz:1 1.0 .... \
>               vd=%vd_sp vm=%vm_dp
> +
> +VLLDM_VLSTM  1110 1100 001 l:1 rn:4 0000 1010 0000 0000
> diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
> index f6f7601fe2..8f2b97e0e7 100644
> --- a/target/arm/translate-vfp.inc.c
> +++ b/target/arm/translate-vfp.inc.c
> @@ -2816,3 +2816,38 @@ static bool trans_VCVT_dp_int(DisasContext *s, arg_VCVT_dp_int *a)
>      tcg_temp_free_ptr(fpst);
>      return true;
>  }
> +
> +/*
> + * Decode VLLDM of VLSTM are nonstandard because:

"Decode of VLLDM and VLSTM"

> + *  * if there is no FPU then these insns must NOP in
> + *    Secure state and UNDEF in Nonsecure state
> + *  * if there is an FPU then these insns do not have
> + *    the usual behaviour that disas_vfp_insn() provides of
> + *    being controlled by CPACR/NSACR enable bits or the
> + *    lazy-stacking logic.

s/disas_vfp_insn/vfp_access_check/ (we never updated this
old comment when we moved the logic as part of the decodetree
conversion).

> + */
> +static bool trans_VLLDM_VLSTM(DisasContext *s, arg_VLLDM_VLSTM *a)
> +{
> +    TCGv_i32 fptr;
> +
> +    if (!arm_dc_feature(s, ARM_FEATURE_M) ||
> +        !arm_dc_feature(s, ARM_FEATURE_V8)) {
> +        return false;
> +    }
> +    if (!dc_isar_feature(aa32_fpsp_v2, s)) {
> +        /* No FPU: NOP if secure, otherwise UNDEF.  */
> +        return s->v8m_secure;
> +    }

We need to UNDEF if !v8m_secure even if there is an FPU.

> +
> +    fptr = load_reg(s, a->rn);
> +    if (a->l) {
> +        gen_helper_v7m_vlldm(cpu_env, fptr);
> +    } else {
> +        gen_helper_v7m_vlstm(cpu_env, fptr);
> +    }
> +    tcg_temp_free_i32(fptr);
> +
> +    /* End the TB, because we have updated FP control bits */
> +    s->base.is_jmp = DISAS_UPDATE;
> +    return true;
> +}

thanks
-- PMM

