Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC65C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 22:07:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 745E72051A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 22:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R+gTfdGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 745E72051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDEwa-0007C2-JA
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 18:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDEvn-0006hV-Gj
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 18:06:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDEvl-0004aO-9T
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 18:06:55 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:42977)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDEvj-0004Xl-Ve
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 18:06:52 -0400
Received: by mail-pf1-x443.google.com with SMTP id x2so7105993pfn.9
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 15:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Rvmh//+V47re9fP3WVX87tCu7tJv+jR1mJSN3IpM4Kc=;
 b=R+gTfdGwACXXcemddyF5iJBTE6ooV9OklHt4rIXyUPPF8jbp20PRIQX5euxVlQzSzg
 a6L12CFGru+wwHR51G2O5xXBH8jWK5Ncy/C2rgmkoTgK0soR8Wjj50PeSLHFbtqRbjRj
 wErpaq5sbg9JAUiJ4QZ+PkSFNagrNNwnN8E7GY+KhFhGrw7cYdcSBEfawVJcGcwPv92f
 4KrGbb92XD7Bcal8jW6t2mW4ZX5pCY7oGz72R+ubh1OTgQC/KtgQgV+xbjPvPN3us8Lb
 N+vdudU7qNSOeYPc+WWMHG95i/eOGajO/eyOvfR8w1pWcBTUC0lPUZLT7ZQYjynMXr9y
 9jyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Rvmh//+V47re9fP3WVX87tCu7tJv+jR1mJSN3IpM4Kc=;
 b=Km2IFP+ByxmzeKkyjkqbm9RdDFuUuNbRJGT5ALuOICGsKx8/MkIVJeMzH7EH0ei5wl
 PnbyveiIjx2sM3qM++Aq3KnivLsHn9Jl56oaY74vnad8IYeomKuTTbr/v3Jaq+UeWIhf
 qCoKNCtbY/dAhJVNCy4Y8tUNZlQkyWPLHaHoP2XRXTDzUZB+7PWjv4gieXSXERAs2Zu1
 ZsEzZZ9rgx9aVMkpWDTLVKITRY4vxBQVQlwyHOzxp+v6mIEt8p/MsfAQKj+L6YP79jaG
 ZfDUtmKMI0V2Lec6pt6d72XIdq/1/n0ExtZeCWE7JDygTKzs4ha/vRPC08Fp7N3ZBm7B
 b+ZQ==
X-Gm-Message-State: ANhLgQ1qWv+Vbwtkh5WggTmIaJ9OaxDozm9nLQHyNKkI1v0OQ84wfZnK
 8ngyJtr8nADGRxniUildqLQoQQ==
X-Google-Smtp-Source: ADFU+vtd1CTfSajKCv6kPUO0edjfdiJaiDlNM4UlscbzfhvxeChMUpf9oDTrUSMrXdd0GXvXDIglOQ==
X-Received: by 2002:a63:33c2:: with SMTP id
 z185mr19618641pgz.125.1584223610462; 
 Sat, 14 Mar 2020 15:06:50 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 x16sm13682614pfn.42.2020.03.14.15.06.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 15:06:49 -0700 (PDT)
Subject: Re: [PATCH v5 39/60] target/riscv: vector floating-point classify
 instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-40-zhiwei_liu@c-sky.com>
 <6710853a-3354-1064-a7f8-4c2378bd680d@linaro.org>
 <de78aac2-42d6-52ec-8e7c-5e59ef1e06fd@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d48f0bf4-3ed0-4ba3-7df4-91ed25842ccb@linaro.org>
Date: Sat, 14 Mar 2020 15:06:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <de78aac2-42d6-52ec-8e7c-5e59ef1e06fd@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/14/20 2:15 AM, LIU Zhiwei wrote:
>>> +static uint64_t fclass_d(uint64_t frs1, float_status *s)
>>> +{
>>> +    float64 f = frs1;
>>> +    bool sign = float64_is_neg(f);
>>> +
>>> +    if (float64_is_infinity(f)) {
>>> +        return sign ? 1 << 0 : 1 << 7;
>>> +    } else if (float64_is_zero(f)) {
>>> +        return sign ? 1 << 3 : 1 << 4;
>>> +    } else if (float64_is_zero_or_denormal(f)) {
>>> +        return sign ? 1 << 2 : 1 << 5;
>>> +    } else if (float64_is_any_nan(f)) {
>>> +        float_status s = { }; /* for snan_bit_is_one */
>>> +        return float64_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
>>> +    } else {
>>> +        return sign ? 1 << 1 : 1 << 6;
>>> +    }
>>> +}
>> These need to be moved out of fpu_helper.c so they can be shared.
> I will add an internals.h and move the declaration to internals.h.

Actually, let's just put declarations for them in internals.h and remove the
static.  They are large enough that they don't need to be inlined.


r~

