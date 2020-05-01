Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01222C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 16:07:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7727208DB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 16:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cnMjRken"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7727208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUYCf-0002pX-UX
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 12:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUY4i-00012L-7m
 for qemu-devel@nongnu.org; Fri, 01 May 2020 12:03:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUY3I-0005lG-67
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:59:39 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35632)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUY3H-0005hs-Ls
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:58:11 -0400
Received: by mail-oi1-x242.google.com with SMTP id o7so150788oif.2
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 08:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0II5KOiKx3aLfM51C/N4C/613U0yDAvzHZjXkCsSyDI=;
 b=cnMjRken/U1cDu9x0E04fWyMUf8piztv7hzx25Atyz9DFyiz7c1oZZBFhxdE5mkl+A
 bo62Wk8PGYSs2Lb+nkg0wdrfcGQ83IHuquRQ3/9p7icI1JEJSNxShiZ5NKVwlf15HPEX
 fe6n8LkBCHf8+DhsiUKtU1UMpYqQOY8HfGjUnklT8D69/YagiE5L3YXjtd83kNljhdIK
 XlvB7dN4wvkw+fM9dNdpNaVsafBebTWQEx8/qeliRuXQoLPJjG3D+JWj1qFuRXEGmlrb
 RZJFh/GeLiVk3o+CooRy5WM2soUmDl2yeC4F7+86N4sWwYN0dUWbGlYETf9xYGP9X4xG
 uqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0II5KOiKx3aLfM51C/N4C/613U0yDAvzHZjXkCsSyDI=;
 b=f5AYDgqdTv//leTl+ThktGJiEnDaWbQJVXNnmg+qtemGp57MEqAgorUwYfCxODS46w
 6FDqmzb21TqfVlqGfih8/f3ryhOruUUqR/VhkYJwSxs0bsnkgWxtnwaEC6yQWDkCdpNP
 HsjTgrBTxdl7Sn7gSKCO8Ccm9gOvDVqBIGD4gq1tcN7KSb0cjDnTXqsbFEDw3EU7hVyU
 mqNlMgn3t3dlt5g86ylTCUrNSOrmlNU343SKocVkDVmafc7wY1P+VTq4ch4iFEa+YYHc
 MIJSbossPBGrmPZ98aWQn4rtZ5SK/ImaIk8PcCLMmAfvDs2SnCq/qV4S+qTyNvgRYxuG
 JCXw==
X-Gm-Message-State: AGi0PuZuecrAUxA6wLEUtkkm8BmqGpxCoNZROMNgLwQQxfo6XBZlHRtF
 h0ikmPyxF6KYzgisK8zkGnky5byKi/KhBkfZjl8C4g==
X-Google-Smtp-Source: APiQypJhhIFXd4oRWQybqv1n+HowJQs80i2cJa9lVp5efDeqaqZ2m9Bkadexp8CR5REebd20oK6tOjVEBax03OlGSDE=
X-Received: by 2002:aca:3441:: with SMTP id b62mr186843oia.146.1588348690170; 
 Fri, 01 May 2020 08:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-24-peter.maydell@linaro.org>
 <366a2e79-d963-bfdc-fcc6-2a63026fa1db@linaro.org>
 <CAFEAcA8M6M7CYg0AsTVbmfX88jzW9MZvRFihQ9cGDJNHhXV+Pw@mail.gmail.com>
 <2050ff9f-1338-2b6e-230f-e07c72ece3e5@linaro.org>
In-Reply-To: <2050ff9f-1338-2b6e-230f-e07c72ece3e5@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 May 2020 16:57:59 +0100
Message-ID: <CAFEAcA8u=0LED6BQdkDCa-i3ySk986oSnMQzZj4KaBaBQ5tDuw@mail.gmail.com>
Subject: Re: [PATCH 23/36] target/arm: Convert Neon 64-bit element 3-reg-same
 insns
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::242
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

On Fri, 1 May 2020 at 16:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
> The original intention of the hook is to expand some inline tcg ops.  That it
> can be used to call a helper is a happy accident.  For a helper that needs env,
> ideally we would use tcg_gen_gvec_ptr and handle the vector with one call.

The inconsistency where half the helpers nede to be passed cpu_env
and the other half don't is really irritating for writing code
that calls them. Lots of ought-to-be-common code ends up needing
two versions :-(

-- PMM

