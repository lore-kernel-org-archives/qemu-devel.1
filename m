Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9913EC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 16:33:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6246520675
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 16:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zrUDicuC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6246520675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icB78-000879-6L
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 11:33:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1icAh2-0008W6-7r
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 11:06:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1icAgw-0008Dp-0j
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 11:06:23 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46051)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1icAgu-0007wv-N5
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 11:06:21 -0500
Received: by mail-pf1-x443.google.com with SMTP id 2so2052450pfg.12
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 08:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qPlxmpsww/pu/bjvZI3jSfIkTgDjwuMlI8DdBaeblcE=;
 b=zrUDicuC5vJp8eOS+zae9b4mnkSMy6Eba9YkZ39rXCjz6TgntJbdTRj56xT35AKPZ6
 b66D7T59e6zVwF/1PJD4oZHQnSf+89CRACCZ8Kjft/0pKzE7Le7obKXKUEryll5919di
 lPdYYkbNiCIhX1U43SH6SAK3zkx67o2qVSPTxJiX/nSTYOa6G31wYDsUbtYtGBHV6wlP
 Fegv5dbO/bRdwdAdp6tzU+dAu8cPjnr353betzNe8UoxtzGmxxtTziqCvAIxwXfQOwp4
 6ofVOMVf1pGlKO3/hRPSZ4r71kqMmaroc9husZjrwJFsw9QK9uIFwD5HveY0nNci0tXi
 QboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qPlxmpsww/pu/bjvZI3jSfIkTgDjwuMlI8DdBaeblcE=;
 b=EyC2N26SJ31shMHl/+34nnrAPJfqLJR3ReQ5IGzb4AVMI+aCHKpUzUCrZJsZPirA1i
 DXPSWLVGMgxXM7SAkDIbn0G9Tw8jiHyCdVeUzJhnFqZviKVJ040FBLgpqA29c2QtUpYr
 POtzf7DCmzrJeI+CFm6szCQLFVRaiWRA/TjJ13AgVj1HiLke2xr/Em7XPmq2aQSsIc/c
 //l35GhqKXQ5KDq4CNbWt02rp+lgxmN6K1JjHdra4NEvs6081CGVrNZYEilXCesZzv1l
 k5WTRJPjf3lq3n3QJoLvW9hMQWBBbzBdHluBPFtnEli3NPezP6JgoPdBwU4fL/p863k8
 FJbA==
X-Gm-Message-State: APjAAAX0Fy34Ztk3flZzP/nFwHoAFaOu9XDwyad2HeEgr4enJYwk+zat
 5iwc/4na9YNEXM1od36oGlPufg==
X-Google-Smtp-Source: APXvYqzSdzBwyum6Yk0RuvnTROce3CUdvtALlK+A/5V5UOLp0Vya8gSGvtMlsnzHzfTX5ELuka+sVw==
X-Received: by 2002:a62:5e04:: with SMTP id s4mr5700726pfb.63.1575389177445;
 Tue, 03 Dec 2019 08:06:17 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id i5sm220648pgj.58.2019.12.03.08.06.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2019 08:06:16 -0800 (PST)
Subject: Re: [PATCH v5 04/22] target/arm: Add helper_mte_check{1,2,3}
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191011134744.2477-1-richard.henderson@linaro.org>
 <20191011134744.2477-5-richard.henderson@linaro.org>
 <CAFEAcA_WOMbFzFQghakLxxuCTc2b3p6eb18nS5KSrSj+oW-Ckg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5fb06e8a-3cc6-072e-a906-0c83fd2d107c@linaro.org>
Date: Tue, 3 Dec 2019 08:06:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_WOMbFzFQghakLxxuCTc2b3p6eb18nS5KSrSj+oW-Ckg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/3/19 1:42 PM, Peter Maydell wrote:
>> +static int allocation_tag_from_addr(uint64_t ptr)
>> +{
>> +    ptr += 1ULL << 55;  /* carry ptr[55] into ptr[59:56].  */
>> +    return extract64(ptr, 56, 4);
> 
> What's the carry-bit-55 logic for? The pseudocode
> AArch64.AllocationTagFromAddress just returns bits [59:56].

This was the old physical tag extraction.

>> +static uint64_t do_mte_check(CPUARMState *env, uint64_t dirty_ptr,
>> +                             uint64_t clean_ptr, uint32_t select,
>> +                             uintptr_t ra)
>> +{
>> +    ARMMMUIdx stage1 = arm_stage1_mmu_idx(env);
>> +    int ptr_tag, mem_tag;
>> +
>> +    /*
>> +     * If TCMA is enabled, then physical tag 0 is unchecked.
>> +     * Note the rules in D6.8.1 are written with logical tags, where
>> +     * the corresponding physical tag rule is simpler: equal to 0.
>> +     * We will need the physical tag below anyway.
>> +     */
> 
> This reads a bit oddly, because (in the final version of the spec)
> physical and logical tags are identical (AArch64.PhysicalTag()
> just returns bits [59:56] of the vaddr).

I missed that change between draft and final.

Wow, that's really annoying.  If they were going to drop physical vs logical
tags, why did they keep the language?

Frankly, it made a *lot* of sense as a way to handle addresses in TTBR1, which
now have asymmetric special cases.  In particular, ADDG will, as I read it now,
with allocation tag access disabled, munge a TTBR1 address to <59:56> = 0.
Which is fine so long as access is disabled, but when re-enabled (e.g. via
PSTATE.TCO) the address will no longer pass the TCMA test.

Is this really intentional?


r~

