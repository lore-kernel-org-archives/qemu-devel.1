Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CBFC33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 13:12:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 400DC205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 13:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zZr/gaI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 400DC205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixW5c-0002zA-Gk
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 08:12:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixW50-0002Xh-M5
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 08:11:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixW4z-0000Ia-A7
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 08:11:26 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:47043)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixW4z-0000Hl-4a
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 08:11:25 -0500
Received: by mail-ot1-x344.google.com with SMTP id g64so6431475otb.13
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 05:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RDQY3gNXXYvcxgo8mWEqK+uC9feJt5tPCLhtqB093hU=;
 b=zZr/gaI0NbbnEyJVlsWbDB+RPQMicNBnwYNpNjxIPKcgx8dA0lcXzGdiYDwlTZ1Fcp
 zHbYaQFiAzYtl31S2o5v6QQDtqZPfXk5+nLO4DpKTOXmit+AmwVTpIVkJRh+kMMjerWE
 037RPQHw+5FVgoo8rSFc1pTvgWJ5x5W0gfFyOGEwjjcE0jsA3+yD9tiJC5pac8tvESYX
 Ly54rALOUgTxJDaXH5jji1dFhvs08S2v+0bIKx9BMwZd17tRvINMierG7LW4RpaOKaZD
 1pktgSnfRpFJKv5KqKUXtuHn1B9Xkp+9peZD6vqkL/fpaokJFAu6eWdlbprSHIWx3SUk
 BApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RDQY3gNXXYvcxgo8mWEqK+uC9feJt5tPCLhtqB093hU=;
 b=SmA9fQ7CPKs7lMTkW6iq4kPR64WAdy0Lo6W0hxOQSEf3P3hZdaY36gDsNNHRn3uhuJ
 xUCfKtlpsnnxa/Ye/lvr7svqfRaii5KlhAQGz1zTP9UNxw/TPVCRaEy/NsGZCLm3phpM
 wpRYgIU+psAzTV/2IYsTqOpLzSi265fWgcqsO/S3Rd5vkIpnCe2OfzTu67rSwLEEO9Fn
 7NamEZJJIMfM7+AypCnVvGFUJUh5+6GtkvFNuD/rIj9nOze74FH1dlw3K+4kqTOTWgv4
 ykHFYuXIlsicUwrbwMrjj0xHaXh1JQbJCo2dxlUgQJVmpgq4qqBUs0oYy7sS9X49wMWV
 AmHQ==
X-Gm-Message-State: APjAAAURpTD/NDz4KQoRBrecCQu86t/Ae6P5tp/1G66hi4xdAeaXMKdk
 CUuxMqkyHYnElM3vy6DEB4geymRrDpQgQa7kDK1xgkd491g=
X-Google-Smtp-Source: APXvYqzG1xP7ruG4lUry8RXI31b0SDwnce/XQcaGv2uuQPODeS2y4d7Mz/DuvhVx5nKCe9KRTSXLK6OKvC4j8m/0PNA=
X-Received: by 2002:a05:6830:1184:: with SMTP id
 u4mr7273210otq.221.1580476283536; 
 Fri, 31 Jan 2020 05:11:23 -0800 (PST)
MIME-Version: 1.0
References: <20200129235614.29829-1-richard.henderson@linaro.org>
 <20200129235614.29829-31-richard.henderson@linaro.org>
In-Reply-To: <20200129235614.29829-31-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jan 2020 13:11:12 +0000
Message-ID: <CAFEAcA-FnhiRuFG49ZJ3s9OUb2VAqKtJAnceMQ8GOOyJtmHDnQ@mail.gmail.com>
Subject: Re: [PATCH v5 30/41] target/arm: Flush tlb for ASID changes in EL2&0
 translation regime
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 Jan 2020 at 23:56, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Since we only support a single ASID, flush the tlb when it changes.
>
> Note that TCR_EL2, like TCR_EL1, has the A1 bit that chooses between
> the two TTBR* registers for the location of the ASID.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 0b67cefcbb..708a2ecf91 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3763,7 +3763,7 @@ static void vmsa_ttbcr_reset(CPUARMState *env, const ARMCPRegInfo *ri)
>      tcr->base_mask = 0xffffc000u;
>  }
>
> -static void vmsa_tcr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
> +static void vmsa_tcr_el12_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                                 uint64_t value)
>  {
>      ARMCPU *cpu = env_archcpu(env);
> @@ -3789,7 +3789,17 @@ static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  static void vmsa_tcr_ttbr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                                      uint64_t value)
>  {
> -    /* TODO: There are ASID fields in here with HCR_EL2.E2H */
> +    /*
> +     * If we are running with E2&0 regime, then an ASID is active.
> +     * Flush if that might be changing.  Note we're not checking
> +     * TCR_EL2.A1 to know if this is really the TTBRx_EL2 that
> +     * holds the active ASID, only checking the field that might.
> +     */
> +    if (extract64(raw_read(env, ri) ^ value, 48, 16) &&
> +        (arm_hcr_el2_eff(env) & HCR_E2H)) {
> +        tlb_flush_by_mmuidx(env_cpu(env),
> +                            ARMMMUIdxBit_E20_2 | ARMMMUIdxBit_E20_0);
> +    }
>      raw_write(env, ri, value);
>  }
>
> @@ -3849,7 +3859,7 @@ static const ARMCPRegInfo vmsa_cp_reginfo[] = {
>                               offsetof(CPUARMState, cp15.ttbr1_ns) } },
>      { .name = "TCR_EL1", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .crn = 2, .crm = 0, .opc1 = 0, .opc2 = 2,
> -      .access = PL1_RW, .writefn = vmsa_tcr_el1_write,
> +      .access = PL1_RW, .writefn = vmsa_tcr_el12_write,
>        .resetfn = vmsa_ttbcr_reset, .raw_writefn = raw_write,
>        .fieldoffset = offsetof(CPUARMState, cp15.tcr_el[1]) },
>      { .name = "TTBCR", .cp = 15, .crn = 2, .crm = 0, .opc1 = 0, .opc2 = 2,
> @@ -5175,10 +5185,8 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
>        .resetvalue = 0 },
>      { .name = "TCR_EL2", .state = ARM_CP_STATE_BOTH,
>        .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 2,
> -      .access = PL2_RW,
> -      /* no .writefn needed as this can't cause an ASID change;
> -       * no .raw_writefn or .resetfn needed as we never use mask/base_mask
> -       */
> +      .access = PL2_RW, .writefn = vmsa_tcr_el12_write,

This blows away the entire TLB on a TCR_EL2 write, which is
safe but a bit overzealous; we could skip it if E2H was clear
(and probably also be a bit more precise about which TLB
indexes to clear). But it's not a big deal so I'm happy if
we leave this as-is.

> +      /* no .raw_writefn or .resetfn needed as we never use mask/base_mask */
>        .fieldoffset = offsetof(CPUARMState, cp15.tcr_el[2]) },
>      { .name = "VTCR", .state = ARM_CP_STATE_AA32,
>        .cp = 15, .opc1 = 4, .crn = 2, .crm = 1, .opc2 = 2,
> --
> 2.20.1

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

