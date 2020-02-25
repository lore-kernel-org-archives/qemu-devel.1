Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9319BC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C8B721927
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ncd/l9CA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C8B721927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55329 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Zzy-0002nU-IS
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:11:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6YpW-0002Ug-3K
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:56:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6YpS-0003S1-0u
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:56:49 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:32813)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6YpR-0003Qz-RB
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:56:45 -0500
Received: by mail-ot1-x341.google.com with SMTP id w6so11842499otk.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5yEcJudPsSKynUdTsOA6q32GCiSnAoOzrKCJ4IpFVN4=;
 b=Ncd/l9CAT2rVt9Nsutg3JlLCh1Jf+Cb1g10T5dCWiA/pH4pGDfv5OdL6Nb+nkDmzOj
 /89/sGA3AAtVSNYmbF+QzPzbGfezFmBmYASUmsPZFMHZyNCWK9CiUKWGo9cy745uUvkc
 HTuUbD/fXtROjPHjRKMNEKbIxYB2xjiSCMYBh1g64h7zDWV3JNZAgxtrFaqT26Vq0ubJ
 AoSL1T2g/BMgPSvwjHZjlh3j7dQde3eTRw5qz0qxyCZ583I7fKFHStmKMS7WsYmVlfE9
 wJt7xhgraHfLYfmDwkHW3Vcy/XUTqqo6r+UNFRGN5+BdQ2iQXnEbWlB5z9Ugu8DPa44L
 QMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5yEcJudPsSKynUdTsOA6q32GCiSnAoOzrKCJ4IpFVN4=;
 b=NeF93AqlXmhO1rVWD+x6zQIDnLJKFeNRTjnqr8frU9wWwnd7nkqo1UF9bssdkgZaTx
 PSGoMMGXiwr4lUYjg9KTtB1GzyZUlgjgRsyjt5jrDz8niO/DH8VgRNlvwWoH5mIAFbMX
 +AKy4SCygZx8jWxhejdSOcvZKF5WLNOIk1o6CYJIZn1AbIkWlXcmmei8prqhGxvnOLTN
 UfphfL0tJxdCFnUlAUkvk5bcqMqby8VTVZlil9US1olPVUELNTA6CKDTWYMqUeKHb1VO
 RbLvuulN0NLBkZAe28XAbyP3WuPAS1z/4eSCed/DWsDB3rJowRVK5uXO23zym0PA6yav
 mwIg==
X-Gm-Message-State: APjAAAW+W1bPLODNcdIqVk2/bvqRCq5AYKydaRhjJT+wxsPAAIyY6sE/
 AQD2W+WwLIS/Io3D06uN6+O7JJ186wkyavDNxmlI6A==
X-Google-Smtp-Source: APXvYqxU6zkajVJ92SnE497jzqtyPMfvCH7hPylncgHEiUeFaPGL+HQ6Ui3g5efeXcT4LLA96ovKDBAs81PMAUpm13Y=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr44674013ota.232.1582631804724; 
 Tue, 25 Feb 2020 03:56:44 -0800 (PST)
MIME-Version: 1.0
References: <20200218190958.745-1-richard.henderson@linaro.org>
 <20200218190958.745-7-richard.henderson@linaro.org>
In-Reply-To: <20200218190958.745-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2020 11:56:33 +0000
Message-ID: <CAFEAcA91aWV45=ozUbekqKzx3EgDm3kamkzM=tROdK7wMndx8A@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] target/arm: Honor the HCR_EL2.TPU bit
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Feb 2020 at 19:10, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This bit traps EL1 access to cache maintenance insns that operate
> to the point of unification.  There are no longer any references to
> plain aa64_cacheop_access, so remove it.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 53 +++++++++++++++++++++++++++------------------
>  1 file changed, 32 insertions(+), 21 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index ed34d4200f..21ee9cf7de 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -4301,19 +4301,6 @@ static const ARMCPRegInfo uao_reginfo = {
>      .readfn = aa64_uao_read, .writefn = aa64_uao_write
>  };
>
> -static CPAccessResult aa64_cacheop_access(CPUARMState *env,
> -                                          const ARMCPRegInfo *ri,
> -                                          bool isread)
> -{
> -    /* Cache invalidate/clean: NOP, but EL0 must UNDEF unless
> -     * SCTLR_EL1.UCI is set.
> -     */
> -    if (arm_current_el(env) == 0 && !(arm_sctlr(env, 0) & SCTLR_UCI)) {
> -        return CP_ACCESS_TRAP;
> -    }
> -    return CP_ACCESS_OK;
> -}
> -
>  static CPAccessResult aa64_cacheop_poc_access(CPUARMState *env,
>                                                const ARMCPRegInfo *ri,
>                                                bool isread)
> @@ -4336,6 +4323,28 @@ static CPAccessResult aa64_cacheop_poc_access(CPUARMState *env,
>      return CP_ACCESS_OK;
>  }
>
> +static CPAccessResult aa64_cacheop_pou_access(CPUARMState *env,
> +                                              const ARMCPRegInfo *ri,
> +                                              bool isread)
> +{
> +    /* Cache invalidate/clean to Point of Unification... */
> +    switch (arm_current_el(env)) {
> +    case 0:
> +        /* ... EL0 must UNDEF unless SCTLR_EL1.UCI is set.  */
> +        if (!(arm_sctlr(env, 0) & SCTLR_UCI)) {
> +            return CP_ACCESS_TRAP;
> +        }
> +        break;

Again, we want to fall through here rather than breaking.

> +    case 1:
> +        /* ... EL1 must trap to EL2 if HCR_EL2.TPU is set.  */
> +        if (arm_hcr_el2_eff(env) & HCR_TPU) {
> +            return CP_ACCESS_TRAP_EL2;
> +        }
> +        break;
> +    }
> +    return CP_ACCESS_OK;
> +}

thanks
-- PMM

