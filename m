Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2C8C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 20:43:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B25D20674
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 20:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NS02G+nM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B25D20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7ly9-0005mt-JY
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 16:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k7lxT-00050D-SS
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 16:42:19 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:52190)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k7lxS-00024v-2I
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 16:42:19 -0400
Received: by mail-pj1-x1044.google.com with SMTP id c6so8378559pje.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 13:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DTGsijsAWjNCqPb+2YqlYgUFMIz3fNqA/82Z7Uv7OF0=;
 b=NS02G+nMUmEHRz0bctMRH+R8gpK5FPmTWBYoydDdqt8CXYdNhTcTflE8jbZ9lzfZv3
 CUVbZvEp+OtSG3NTF9dqtNhWmp6nhdIqcub01f0ceaXK+9EY3epY1JF8vd2fHIHViRk2
 pXqQQEJAKBrZAaL2gX8rNKSVcsp2EZidbAEV1tmFkBCjKw9uRZ8pGnR3yTRmR7Me+8+P
 sM7nkRLTqeJcgEkDQiMoIHvW75zXf01mRbQW4RFGi7AbN+SyHfEzrRylIhpgGRZh3GgM
 OpJLkCpVKa/PcJ/XrH2wYCy7BjfVQ6JAfeY9EiQGVea0/ymduNhk7dgHMVTdFRuHp6I4
 hH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DTGsijsAWjNCqPb+2YqlYgUFMIz3fNqA/82Z7Uv7OF0=;
 b=WCEdDn5KUpwzPIpEFN4Ll6tBh812VvOriNVQrorwpKnEAA/KEF2aMV4Bv0bz9ZtPI+
 E6tdlgHFKigM13h0k6c6w5nEwhFkJsjDeTCJW+d7fMMpaxCNByiZpgEqUvqIcuJCX00q
 mcAoEQrzZr5Uda1R+/2+HqWMMGJPQAKalTQVGVxV5io2ekX9bpgPYH1tLI8dBI4w8VKK
 oKxHU7eIA+PB043RrHBDWwO4kUyWgUWYqDj5nGJ5cltmY0DGoea1aGgcMrBxsuAIF/5R
 ea9mtFynfSi/VGflxVaWZezlc+ZyGgTubWZi3SC7TbkfG8g8B6WoFkVGoqkFwgudut6y
 E1aw==
X-Gm-Message-State: AOAM530W6Euw2BRvZhCpxno8GFmdJYMlIHUuk0/IoH/aDWthaQIbTSGo
 WACfuL4tKa/4Bu07NI8Y13DsS2fRTDskqQ==
X-Google-Smtp-Source: ABdhPJxo8IEoPV7sN/OZBWXLpB0mmBSd/Gdj9rN48ynH4Dapp2RJvsaYy7n5jPJvX8PaLoFkiwRpHQ==
X-Received: by 2002:a17:902:4b:: with SMTP id
 69mr12887107pla.245.1597696936232; 
 Mon, 17 Aug 2020 13:42:16 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b22sm21327840pfb.213.2020.08.17.13.42.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2020 13:42:15 -0700 (PDT)
Subject: Re: [PATCH 01/17] crypto: Move QCryptoCipher typedef to
 qemu/typedefs.h
From: Richard Henderson <richard.henderson@linaro.org>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200813032537.2888593-1-richard.henderson@linaro.org>
 <20200813032537.2888593-2-richard.henderson@linaro.org>
 <20200817164801.GK4775@redhat.com>
 <01f1a99c-9983-9b92-b91d-bd117055cf21@linaro.org>
Message-ID: <03d945f7-bd4a-8f55-433c-b5c9ab7080c4@linaro.org>
Date: Mon, 17 Aug 2020 13:42:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <01f1a99c-9983-9b92-b91d-bd117055cf21@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 1:38 PM, Richard Henderson wrote:
> On 8/17/20 9:48 AM, Daniel P. Berrangé wrote:
>> On Wed, Aug 12, 2020 at 08:25:21PM -0700, Richard Henderson wrote:
>>> This allows header files to declare pointers without pulling
>>> in the entire crypto subsystem.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>  include/crypto/cipher.h | 2 --
>>>  include/qemu/typedefs.h | 1 +
>>>  2 files changed, 1 insertion(+), 2 deletions(-)
>>
>> I'm not in favour of this change or the next. Using #include "cipher.h"
>> is not a burden on the users of the crypto code. Moving typedefs away
>> from the associated struct is a step backwards IMHO.
> 
> Consider if you put a pointer to QCryptoCipher in a relatively generic header
> file (e.g. "target/foo/cpu.h"), restricting "cipher.h" to a portion of the
> implementation (e.g. target/foo/helper_crypto.c).
> 
> This sort of thing is exactly why "qemu/typedefs.h" exists.

As for the next patch for QCryptoCipherDriver, I could easily see not moving
the typedef to typedefs.h, but instaed to "crypto.h", where we do in fact want
to declare an incomplete structure.  I think it's a real mistake to be using
void* there at present.


r~

