Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D93C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:10:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 506092054F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D50dMajd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 506092054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUEa7-0005Ux-Dz
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 15:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43996)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUEVe-0004xF-N5
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:06:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUEVd-00061K-R9
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:06:10 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35411)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUEVd-000611-Cq
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:06:09 -0400
Received: by mail-pf1-x444.google.com with SMTP id r14so299457pfg.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 12:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=q0u/KlVsH3MKHHxTLVdwTj7dRKKXsXsqIxsfm1kMwh0=;
 b=D50dMajdjI/rlFb/AY02kIGrrJ9ZKIIMtdlS5FHVeWhVLW2mTm8TGnxRhbfqSly2kR
 ggK54D39xwZ8DcDA+FMdG4q2ZZFoEMs3usX9PsxmQND9DSCwThNpNxjrTyYPp4x6EIAy
 AiyzXjIuO67RciirHjJuyO5ayAJbOcKSOFW6EdFVMPsdGsjAHcJApwVrkq8nzPsAz/fj
 UqWdE1uBcggH6Z44Kr92BYMDoEZh7JGm1tFnxudK6cR+oPA+A4rueLhJOAJSIueUwTGQ
 BMr+XUxN4MOwdByt8eoqL2kHIktL/tp2I/QwypRaM5ii9V9dzyGTlTzTVfHg4FGFRZms
 /blQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=q0u/KlVsH3MKHHxTLVdwTj7dRKKXsXsqIxsfm1kMwh0=;
 b=ZkTbQLE26lY4VY8VdqkzKidy8VOVPwcQlgNTlI+SzHSmlMYD8Hrl/elx+2fL88Qxu+
 msAwEHdJpgd2deVKF3GNBh42UIPg1faS8ZnClFeJAH5hjjObFG9B2jAvx7KB4diKVmFn
 GGN4f4+iGRabTOES9Q7csbVyenK6AC2cF5NDqAMDUgGBKnR3cI9yM+dXqiK8olJ2pMdY
 lLToRJWjdN3r4J7qCysRew0ANaGj712ir39G8XC2H274dFEZIJdeJyQIJEKOJ9dQT0x3
 bwCN9tD62HlcfnOIaVVvLAENhBrRm7UlAExCafPgKO5PpH9pVz9ZQWcckYPSRKtk2k/V
 aNhA==
X-Gm-Message-State: AGi0PuYMM9D3hTWzhM+Z8lKif9/eqqvYDkYlS70FS2HVhvxLITfByuf3
 po4H99O8EYsEBiBm7wM3C7yEh1NHhws=
X-Google-Smtp-Source: APiQypL62oGhMNZeiUQDHaXZxicL+u5pWMxdRQDfXOSH7PXIS/BqsHhvNKZaOwH6kvF4xT9OcsJX8g==
X-Received: by 2002:aa7:8bdc:: with SMTP id s28mr189453pfd.57.1588273567405;
 Thu, 30 Apr 2020 12:06:07 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id j26sm433501pfr.215.2020.04.30.12.06.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 12:06:06 -0700 (PDT)
Subject: Re: [PATCH 10/36] target/arm: Convert VFM[AS]L (scalar) to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-11-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d037f0f0-e9e1-8b73-c405-2632109aa778@linaro.org>
Date: Thu, 30 Apr 2020 12:06:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::444
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 11:09 AM, Peter Maydell wrote:
> Convert the VFM[AS]L (scalar) insns in the 2reg-scalar-ext group
> to decodetree. These are the last ones in the group so we can remove
> all the legacy decode for the group.
> 
> Note that in disas_thumb2_insn() the parts of this encoding space
> where the decodetree decoder returns false will correctly be directed
> to illegal_op by the "(insn & (1 << 28))" check so they won't fall
> into disas_coproc_insn() by mistake.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-neon.inc.c |  32 ++++++++++
>  target/arm/translate.c          | 107 +-------------------------------
>  target/arm/neon-shared.decode   |   7 +++
>  3 files changed, 40 insertions(+), 106 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

