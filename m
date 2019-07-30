Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64796C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 14:54:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE2C20665
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 14:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AH0GvLYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE2C20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsTWf-0003l6-FF
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 10:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38843)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsTWB-0003Co-NY
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 10:54:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsTWA-0004ZR-Kt
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 10:54:23 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46140)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsTWA-0004Yo-AU
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 10:54:22 -0400
Received: by mail-pg1-x541.google.com with SMTP id k189so11147110pgk.13
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 07:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lLkaJ3wgFvcEuAPw7ikJ5rmvzJ8As6bAxa2G5iVp+/E=;
 b=AH0GvLYG37kF5plDzvl43jiLzrrC0DnRDDjHlaKpzfKmjyk22Fj0VmS5s7G8fVGbj5
 PaB99FgF8anrRZ4rhr1VE/xpCXz8FRa9GA1tOMo8vQqET4JGoK1/Yr/v5Y3vsfXXYJNb
 5RptY5WBBBhgDMGhF05BXvnRCE+yfOLw01tturUgjsIaqZ0uALorYNnvzP3AvE/VMypm
 R+Y7+EHY1fabDMXxIJD+JxJzU49YMVG6tD0v7/4CQ5JbC8XGFYT+zhZ/5ugX+33PNQ2i
 gjbgyPDyQx+R2fmrLeB8rCjsTab1yNe7QdkATe/vLYaWo2MEPq5M0ezEgD/UJGSrLXlP
 TAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lLkaJ3wgFvcEuAPw7ikJ5rmvzJ8As6bAxa2G5iVp+/E=;
 b=Mm8JcFZEWuV4sJ3VaXcQgi5NznTE4dS8z9yg6euYLZC9/HqlJH0/VQ1Fe4Ha0dCh0K
 Vbtb4pItvjRLSRVZR410d/j/Oj50zhGWKVS12GqhXmIcyKhoeB4lJW73H6Cmb6nRaV8S
 G5tPArLf0Qm2PZeWdHliI5LTMpN6CuvZggKlwgsQ3sw16piX6rv6ZpyUwjA5Y8NMu9uw
 nSvPzk1ZWuLufmIui7C1jYnV448DY9272ZmLt591fpCm2oxeqrfcbekenSwK1P6TZzIQ
 WHqoY9h6d0AbG0THurFGOaahr5oF7vonUOtQWOGE3pebK7pONSHojjHE2rGw/nvp4fuh
 20Ag==
X-Gm-Message-State: APjAAAWYA1EwaNkh8afKVOggR9NKXYiD5cDExDHd0nJjXV0zycn2Jd6A
 mDyU3E0TJ7UpuuttP67yef7FHg==
X-Google-Smtp-Source: APXvYqzCUJgfyVYv/LynUZ7w4X+HENloQlavokj2Nsq9w7XlNQA787qXtKVbAL2l/5oyyTgvcgYbTA==
X-Received: by 2002:a17:90a:cb01:: with SMTP id
 z1mr2628925pjt.93.1564498460892; 
 Tue, 30 Jul 2019 07:54:20 -0700 (PDT)
Received: from [192.168.101.105] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id x65sm65132285pfd.139.2019.07.30.07.54.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Jul 2019 07:54:20 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190730132522.27086-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6788a31f-a46a-0fd3-0513-a2fe558d0703@linaro.org>
Date: Tue, 30 Jul 2019 07:54:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730132522.27086-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH for-4.1?] target/arm: Deliver BKPT/BRK
 exceptions to correct exception level
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/30/19 6:25 AM, Peter Maydell wrote:
> Most Arm architectural debug exceptions (eg watchpoints) are ignored
> if the configured "debug exception level" is below the current
> exception level (so for example EL1 can't arrange to get debug exceptions
> for EL2 execution). Exceptions generated by the BRK or BPKT instructions
> are a special case -- they must always cause an exception, so if
> we're executing above the debug exception level then we
> must take them to the current exception level.
> 
> This fixes a bug where executing BRK at EL2 could result in an
> exception being taken at EL1 (which is strictly forbidden by the
> architecture).
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1838277
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> At this point in the release cycle I'm not sure we should put this
> into 4.1 -- it is definitely a bug but it's not a regression as
> we've been wrong like this for multiple releases, pretty much
> since we put in the debug handling code I suspect.

I'd lean to putting it in, fwiw.


r~

