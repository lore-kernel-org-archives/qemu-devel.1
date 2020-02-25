Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF64C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:30:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34D26218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zTtFHOjM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D26218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZMY-0004rs-Bd
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:30:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6Ylm-000311-5W
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:53:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6Ylk-0002vj-W9
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:58 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39912)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6Ylk-0002te-Pr
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:56 -0500
Received: by mail-oi1-x244.google.com with SMTP id 18so9309118oij.6
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aJRMdQi09YW8qV3NySHZ3GH8pZ/YqCH1KOoEGG3bJQo=;
 b=zTtFHOjMYMoqFN2D0RAbUQSIzySGJxUGRd0ofgh6UXJmmodDAfSYC2anwrFgWXW4Qh
 FYkeP/LuYo2TDT+sKdmKmeaYlQBCJqB0ENhPlzzV97/3evqkuWQuhoCuzQK+wz4DgMPc
 nZr54lfQwhRylS7DHrKnK/HzAIGqOl55uiIhSRO65ndYNmdjeTCEswkVYo7L2L9rKeYr
 1SbZcblwLz/ouXfCtRGIFe7/6gsITy8UXWqpS3YL1wSYIk7q+yTu7ahOHzfQcOB20oFC
 /iC+oVx5kh0zf4VJMyN0SBgPcxO1RqfA7pEs9Xt8irB/EK5jjZ25YbKpNXYIMY8nWblz
 3udw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aJRMdQi09YW8qV3NySHZ3GH8pZ/YqCH1KOoEGG3bJQo=;
 b=N8SXSvn2MgVfE34bYhat58Yy0EScCf7lnXzVIfIZMfAojLMN/qM22088CSTr02Wr4L
 hAxEWuCP7qY48uZ2JCThAl8p9UAVI4JVC6UdR7nwwGpQ8VUhb3PidbweCQ3YghDHdLbn
 FON+ZWHRbjMAEwOiwciVgZ+2OQMWVZBRSZYEtbH6OjoxiiCGmwhDCx2weQkIoKnvTcTr
 0Lz0ASGZLtOR6VGxfrUeEdDdf0E5byKVj2sPQRabCQbpRFGapGK9h+FJfftNEQ2LEPgq
 OOdN7r9+c/816O7l0Ze0awDqBJtRVgxjsrSUlGgIpRi2Guqmm6wphAXVjqUa0W1E21S5
 BC6g==
X-Gm-Message-State: APjAAAWW9Q8CbBG93wqEetc92utFMsDFZW7UKeQ8nUrqy3U8UPIfp4DC
 1qfvprpKjG5cQMGIQiItmgiaj+e2gtEXx2rDe1bUWLhC
X-Google-Smtp-Source: APXvYqxDeBacEgSZ2fhpUn0ggiLK3AodT7zxfARVS/J1LVNvotmECkD7so+TpbHYd9fNTb3OCopO5pPH/qowwLrzYkc=
X-Received: by 2002:aca:b2c5:: with SMTP id b188mr3143942oif.163.1582631575924; 
 Tue, 25 Feb 2020 03:52:55 -0800 (PST)
MIME-Version: 1.0
References: <20200218190958.745-1-richard.henderson@linaro.org>
 <20200218190958.745-6-richard.henderson@linaro.org>
In-Reply-To: <20200218190958.745-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2020 11:52:45 +0000
Message-ID: <CAFEAcA8HSBwsARgc8DbOUrrSy3HWYYUqMKS9Q8s+iTJLQEr2dA@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] target/arm: Honor the HCR_EL2.TPCP bit
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
> to the point of coherency or persistence.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 39 +++++++++++++++++++++++++++++++--------
>  1 file changed, 31 insertions(+), 8 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 52b6e68659..ed34d4200f 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -4314,6 +4314,28 @@ static CPAccessResult aa64_cacheop_access(CPUARMState *env,
>      return CP_ACCESS_OK;
>  }
>
> +static CPAccessResult aa64_cacheop_poc_access(CPUARMState *env,
> +                                              const ARMCPRegInfo *ri,
> +                                              bool isread)
> +{
> +    /* Cache invalidate/clean to Point of Coherency or Persistence...  */
> +    switch (arm_current_el(env)) {
> +    case 0:
> +        /* ... EL0 must UNDEF unless SCTLR_EL1.UCI is set.  */
> +        if (!(arm_sctlr(env, 0) & SCTLR_UCI)) {
> +            return CP_ACCESS_TRAP;
> +        }
> +        break;

If we're at EL0 and SCTLR.UCI is set, then we should fall
through to honour the HCR_EL2.TPCP check, not always-succeed.

> +    case 1:
> +        /* ... EL1 must trap to EL2 if HCR_EL2.TPCP is set.  */
> +        if (arm_hcr_el2_eff(env) & HCR_TPCP) {
> +            return CP_ACCESS_TRAP_EL2;
> +        }
> +        break;
> +    }
> +    return CP_ACCESS_OK;
> +}

thanks
-- PMM

