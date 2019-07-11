Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C096C74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:44:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 348DA2084B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PipvIq/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 348DA2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlYQp-0006oq-IT
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 08:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56960)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hlYQI-0006I5-Ej
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hlYQH-000774-64
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:43:42 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44650)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hlYQH-00076L-0R
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:43:41 -0400
Received: by mail-ot1-x341.google.com with SMTP id b7so5655329otl.11
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 05:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZUHo5N51KdqNy5ukMcABAlH5JkqI72LPh9L730eX+XY=;
 b=PipvIq/CXIytzDBbqHrOuYDS6WfJakY9xOZl1JgEk14B8Dreu6mUdqW/AMvHU/cj8b
 mLSuZ4dh/+R6R4yfjvo+rvEpQE5Porx5isnhwSart0KfOH6JQNsFdFPnQ17aA8VEWT+g
 0kpSzVKN1uwn9ugIUIw0WndQY4XeWWmDCwdfaD8nS8/TNGoKUieFeZ3on7ttmanYJ0UV
 nWYSTGP8g2jO1wIxq6pvi9+gHgCSfa9XTlq9MlSmkfVSeiVTq6EBD4Gl5Q2rJzYdJ7ta
 nvflHr80Ha4kFjCQATX28vCJBIb9mTekit1Tg3F9aKr+jf9N2f/JF8cC7z/pesNvciZF
 3JPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZUHo5N51KdqNy5ukMcABAlH5JkqI72LPh9L730eX+XY=;
 b=c9Ri0fTEcMkEU8oIXgW9GdcN1H+oFzl/EAMcjEoS03lhAaa6C+dXi8A1Z4iYlkBtzW
 Iv/pwqafGdAN30oT1TGBSfTGUb/CwhtJm9gfbKO6mPq6r1GJwknJKlgBb00l6M5VMM+7
 cyJYS63jh45JFlntSMgEcYziczX3KXZZD6zM03abypQRW0EDt0RiR7W8Hv9XfELYyFX/
 0f4Pcbz7jE2HCAAJiEYDJHzgjJZrZNk9uVSnNGxPjGSYrazbuQwrD6byXIJzGLBVYyo0
 33aETBuWFB+EIUbS8J/1Asse9GZIVd5QTtnafl5jS80MYcDh63qXTPiPVxNpOw+g0JyS
 rsUg==
X-Gm-Message-State: APjAAAXxEwR0KnDrwXytNwvszDCJonRkw+JpOY63LC1HcutpoxDZl0l0
 W0CKPe/13NHY6ipV1Xza31A06w==
X-Google-Smtp-Source: APXvYqyEi5mYggz8BKINh53jJUmmIGXfz58mflarfxnaw+/Q63cHyENzkiSQzgHz/jzgXIqvNQQ6Iw==
X-Received: by 2002:a9d:7352:: with SMTP id l18mr3330291otk.292.1562849019954; 
 Thu, 11 Jul 2019 05:43:39 -0700 (PDT)
Received: from [192.168.43.94] ([208.54.86.238])
 by smtp.gmail.com with ESMTPSA id w9sm1801712otk.16.2019.07.11.05.43.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Jul 2019 05:43:39 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190711121231.3601-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <21ffce4e-72cf-2c5f-71b1-cb53367dccda@linaro.org>
Date: Thu, 11 Jul 2019 14:43:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190711121231.3601-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH for-4.1] target/arm: Set VFP-related MVFR0
 fields for arm926 and arm1026
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
Cc: Christophe Lyon <christophe.lyon@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/11/19 2:12 PM, Peter Maydell wrote:
> The ARMv5 architecture didn't specify detailed per-feature ID
> registers. Now that we're using the MVFR0 register fields to
> gate the existence of VFP instructions, we need to set up
> the correct values in the cpu->isar structure so that we still
> provide an FPU to the guest.
> 
> This fixes a regression in the arm926 and arm1026 CPUs, which
> are the only ones that both have VFP and are ARMv5 or earlier.
> This regression was introduced by the VFP refactoring, and more
> specifically by commits 1120827fa182f0e76 and 266bd25c485597c,
> which accidentally disabled VFP short-vector support and
> double-precision support on these CPUs.
> 
> Reported-by: Christophe Lyon <christophe.lyon@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: 1120827fa182f0e
> Fixes: 266bd25c485597c
> Fixes: https://bugs.launchpad.net/qemu/+bug/1836192
> ---
> I've followed the existing approach we used for ISAR1 here
> of just filling in the fields we care about, rather than trying
> to set the entire register value.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> @@ -1713,6 +1719,12 @@ static void arm1026_initfn(Object *obj)
>          };
>          define_one_arm_cp_reg(cpu, &ifar);
>      }
> +    /*
> +     * Similarly, we need to set MVFR0 fields to enable double precision
> +     * and short vector support even though ARMv5 doesn't have this register.
> +     */
> +    cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
> +    cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPDP, 1);
>  }

I would have placed this immediately after the Jazelle isar setup, so that the
"Similarly" comment had the proper referent.  But, no biggie.


r~

