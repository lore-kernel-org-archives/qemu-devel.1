Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348FBC4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 21:33:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE5B0214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 21:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dSfrIfCF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5B0214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAL60-0004LM-5X
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 17:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33584)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iAL4S-0003kP-7R
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 17:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iAL4M-0001yO-E7
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 17:31:34 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34070)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iAL4G-0001u9-AF
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 17:31:24 -0400
Received: by mail-pl1-x641.google.com with SMTP id d3so2090340plr.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 14:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qPUmFy7nnfR4BPVnW0Iq/YrfVYfO4gvONfjfSzy1Vk0=;
 b=dSfrIfCFlnPEuOaFeecweOgBko2te3tG2lNhXwM7HoD+t6D5ckiYZPiaXdFSR/Sjt0
 bXM1tuy1rjulI/TnAAJMFkVwuWdi3kLcoezfForRbu3kn6NAi/78yQ3e5hi7xuKz3jFw
 QCHwEU46A8GuKdwpJuopkN3CNLzu2bNRpkLj/MF6gy26bV8Rmrv6RecrF8XrYOTt/Apx
 7aXc34swEsv5P2cwWQffb2v/p7lzrU4M0D6I68IRC6RZwfbjF0eRkRCuz54G0sM/DOy9
 st8Fm5j+ZYUpm04R3W6ggLV2QEojPyC48d/Dy0fCjZTFXJFQgYS2Tia7UbwIiN5JsJSc
 loxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qPUmFy7nnfR4BPVnW0Iq/YrfVYfO4gvONfjfSzy1Vk0=;
 b=bj08w5un2C21HAek35LHVx9/XQEKBt7VLyQAOjB8YHA86sk7F9G/V0n7wKo5nADEYy
 cboFt0qJCC8Gng2Hqr1FyfkUSWlCF3jJRydhWT2nals6250mcQmr95HIwj7CpGvEfgQL
 xBYOD59+jPXpbu3qJpDbd3K66g1QZS2UmQtVCE/ZRGgvEu6QxHqBhxrYsAvfpuxPAY1/
 iuaWPTVV1AxyzgQJPtlMC8udEUbUJvP7r9U9/O2KDn9mKdVN530naYxVKq368cxSUgfw
 CCJ0F5Wcr9BuVu7oH5IhFxz1EYM0tYiqLYBiz2CmS6jcYjRlNvy6zs+KIRv+bkpysKmD
 Znng==
X-Gm-Message-State: APjAAAWbSttNC4icjd/sN2Ph62AowQTXQJykFtwlo4yKI7J/DfkxjWRl
 doRcbusGtjtS7a9jxnpqJocxSJvV8IyZvQ==
X-Google-Smtp-Source: APXvYqxycGZyP9EXo0dng9aO66nUlu3FH5wGlsCluKPx/wX9nyGzePwjIknnEVJvdKEvY1Yx1VzRrQ==
X-Received: by 2002:a17:902:bd97:: with SMTP id
 q23mr773044pls.259.1568755874644; 
 Tue, 17 Sep 2019 14:31:14 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s5sm3706620pfe.52.2019.09.17.14.31.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Sep 2019 14:31:13 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190917184109.12564-1-alex.bennee@linaro.org>
 <20190917184109.12564-9-alex.bennee@linaro.org>
 <73df6b9e-d096-f58f-dfeb-aad0c8e50d39@linaro.org> <878sqm1w0f.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <62cd0ee7-dcf3-7731-399e-168a02c1ccda@linaro.org>
Date: Tue, 17 Sep 2019 14:31:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <878sqm1w0f.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [PATCH v1 8/9] tests/tcg: add generic version of
 float_convs
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/19 4:57 PM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 9/17/19 2:41 PM, Alex Bennée wrote:
>>> +    for (i = 0; i < ARRAY_SIZE(round_flags); ++i) {
>>> +        fesetround(round_flags[i].flag);
>>
>> If we're going to make this a generic test, perhaps
>> continue if fesetround fails?
> 
> I ifdef'ed the missing symbols? Can the symbol exits but not be settable?

I dunno, maybe?  Perhaps based on the exact host.


r~


