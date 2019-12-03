Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54CCC432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 17:27:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E6342073B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 17:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gxj93EMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6342073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icBwy-0003re-5w
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 12:27:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1icApD-0003Zk-Ic
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 11:14:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1icAox-0003Ry-0m
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 11:14:40 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:35792)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1icAot-0003O0-7R
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 11:14:37 -0500
Received: by mail-pj1-x1042.google.com with SMTP id w23so627882pjd.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 08:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=m/GrtFDIpUGCPR2VKiymWN5ig4th9UzpETIPcVzQZwM=;
 b=Gxj93EMQEDNXx+9uH+yAaDemwYyjMep+z7TB242BIKQK09nNj945DFcwdZNZ+uaBnJ
 sfjS80AHP7xe72AMXJnKmjco6bERdJdkfMnaGP94wrh7m7W459Kmz/9gFeB8UXsveF6Q
 QJ+3dt1eRzjHpz6Pxb/9LNGkYNghSMpM19kPNIfhTdYelrvOth7cZoZ02fd0+uEKrHF7
 pAm5+Mpd4gnomkBq9Gl4JahycOG5I3Y9u1erWYy7uevU78vrTWnyrnodr+OkjGIomOCm
 YeaA4ZGa7EfOxKh28RtfgzM+f18OTVxZIOz1FQ3tKDq33Hosdx5NCEwDhRmFpyhYsRLh
 5rxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=m/GrtFDIpUGCPR2VKiymWN5ig4th9UzpETIPcVzQZwM=;
 b=SLSgUAQVCMha5n+kjJUEHyS5cw8v9daw778B5/lQc+jwwPnFSTDuutEoET7VaxwMcx
 zobuTOXYePlA5b1qpVhkt95BkuXmIw3TWb9UVbW7f34VzN21RUdJu1AaxUuG6eJuuC0x
 xvjLF7phYiZ7wuK/7FUqUWc1YcKshz9JpEpI0l0dMpOEYQLUOkgjQrFQxVkdMQgH0CG+
 4o1eCjD94bzsSDuSDEv4XGtzsSb0H//W/FrgQEdWalwYY8kvgV1op8POJ3xuV1vPk6Q3
 RWmQddvDT+tFwsU6SJX0ALkHbNHNlPe/cFqylMDv1rfp9uXroPm4Do4QrmSx1ttTqrP4
 +OVg==
X-Gm-Message-State: APjAAAWPC7QSjRFwMMgGu+7gqb7mD9+cVqUZGOr6MvXv9FDjF4iY2N75
 yzCW9MppMVx9UzJIwWfAiytooQ==
X-Google-Smtp-Source: APXvYqxoFEnmSaSoM4THYyoGsi0v6ZcdCmQhKgJKRlyvsIyjkE8b31oZhUcuenAr2dtNCloyR4U6GQ==
X-Received: by 2002:a17:902:6b01:: with SMTP id
 o1mr5582660plk.24.1575389669582; 
 Tue, 03 Dec 2019 08:14:29 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s60sm708994pjb.3.2019.12.03.08.14.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2019 08:14:28 -0800 (PST)
Subject: Re: [PATCH v5 04/22] target/arm: Add helper_mte_check{1,2,3}
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191011134744.2477-1-richard.henderson@linaro.org>
 <20191011134744.2477-5-richard.henderson@linaro.org>
 <CAFEAcA_WOMbFzFQghakLxxuCTc2b3p6eb18nS5KSrSj+oW-Ckg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <120a00d4-a33d-6263-c6d4-4671449d7dab@linaro.org>
Date: Tue, 3 Dec 2019 08:14:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_WOMbFzFQghakLxxuCTc2b3p6eb18nS5KSrSj+oW-Ckg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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

Oh, to finish up on the replies...

On 12/3/19 1:42 PM, Peter Maydell wrote:
>> +    ptr_tag = allocation_tag_from_addr(dirty_ptr);
>> +    if (ptr_tag == 0) {
>> +        ARMVAParameters p = aa64_va_parameters(env, dirty_ptr, stage1, true);
>> +        if (p.tcma) {
>> +            return clean_ptr;
>> +        }
>> +    }
> 
> I don't think this logic gets the "regime has two address ranges"
> case correct. For a two-address-range translation regime (where
> TCR_ELx has TCMA0 and TCMA1 bits, rather than just a single TCMA bit),
> then the 'select' argument to this function needs to be involved,
> because we should do a tag-unchecked access if:
>  * addr[59:55]==0b00000 (ie select == 0 and ptr_tag == 0)
>    and TCR_ELx.TCMA0 is set
>  * addr[59:55]==0b11111 (ie select == 1 and ptr_tag == 0xf)
>    and TCR_ELx.TCMA1 is set
> (the pseudocode for this is in AArch64.AccessTagIsChecked(),
> and the TCR_EL1.TCMA[01] bit definitions agree; the text in
> D6.8.1 appears to be confused.)

It used to be correct.

That was the lovely bit about physical vs logical tags.  Add 1 bit bit 55, let
the carry ripple up, so that the physical tag check for TCMA was always against 0.

That seems to be broken now in the final spec.

>> +        el = arm_current_el(env);
>> +        regime_el = (el ? el : 1);   /* TODO: ARMv8.1-VHE EL2&0 regime */
> 
> We could write this as "regime_el(env, stage1)" if that function
> wasn't local to helper.c, right ?

Yes.

>> +            /* noreturn; fall through to assert anyway */
> 
> hopefully this fallthrough comment syntax doesn't confuse any
> of our compilers/static analyzers...

It shouldn't...

>> +            /* Tag check fail causes asynchronous flag set.  */
>> +            env->cp15.tfsr_el[regime_el] |= 1 << select;
> 
> Won't this incorrectly accumulate tagfails for EL0 into
> TFSR_EL1 rather than TFSRE0_EL1 ? I think you want "[el]".

Yep.

>> +            /* Case 3: Reserved. */
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                          "Tag check failure with SCTLR_EL%d.TCF "
>> +                          "set to reserved value %d\n", regime_el, tcf);
> 
> Technically this message is going to be wrong for the
> case of el==0 (where it's SCTLR_EL1.TCF0, not .TCF, that's
> been mis-set).

Yep.


r~

