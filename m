Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA76C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A41A247C9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yKxwMO7g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A41A247C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXnbp-0002rS-8N
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 11:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXnWX-0004TX-4D
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:38:05 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXnWU-0000hV-61
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:38:04 -0400
Received: by mail-pl1-x642.google.com with SMTP id j5so2651472plk.7
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 08:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=om/PY/dr8sqpQP1wVkGQjD0OXvAzyU46yhLk+LQHcds=;
 b=yKxwMO7gByBnXbEToW4/MlHTfMkii1fyaaZWFOBlniB9fvJsClv7mEDdMwFSod3um8
 Ts/qYxufra9ti+pg+Lvu51FrazcSb+xaY8BLk8JmBGAJz6VZuBKlVZpZJAOXSEPeNxTk
 05wkWd8lM/nQiBGk9XZVuPEXe45vOsVq9yUXacq4ZYsGlIdDEE6azbTRrboQa1HUSA6i
 L78go8Omi5+OAwXpwXtuigPQ1SzlWwVyztXPdomdjsqgPuA+R/kkoDookfscvzRNUT5D
 hIqYLzqSfWbjbBeVHXhi6lzEiOHZaeW2GnR3gDzarMUI0BoU7G8ROu/GKloXHPFKhmAG
 O8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=om/PY/dr8sqpQP1wVkGQjD0OXvAzyU46yhLk+LQHcds=;
 b=cVc1geuInzSd7JvXA1lg0XCXLUzNBNsSznImVYmeJ9ZMl57YefOVgSL4QC2ylpMtST
 66urq1QL6aSSZBsUxec0AT4LZW5YaJWww+GAdWpRsI2LhYmODZXGVl35gApuHNi2mm7B
 DhDDN0zyL0jNKa0uy5giwonc1LCQiOAjSbRokgdv6KLgBnVca66hEUL+tBevbxPsnT8i
 2cXTE4LQDbAxeAG3DgWm+wcCeQQBvI9tu6PBLLO8CNdpx3jo63nGueoJVjYQHbu4sQqJ
 umTl7mJkdzCedVlIr2/g0qkzG6aENPVFkJpxYD9wSm9ziJBh4RqONtZHFJgTdevVH0Hu
 bsYA==
X-Gm-Message-State: AOAM533rjnRwHaF63N5yCpHPYl0Olwtd5BZcfYPpFMoxRD49u4CZCe2I
 UWP8/pI7cUl8LLphNmE94X9SIw==
X-Google-Smtp-Source: ABdhPJym8U4WKANMpr9YwyBFM8nDo2c1TKD8sM14RHDcyqhCEgWQswWjTpnPPvHCqZjRQtQm2SVrkA==
X-Received: by 2002:a17:902:a60c:b029:d5:dc92:a1ca with SMTP id
 u12-20020a170902a60cb02900d5dc92a1camr8060864plq.16.1603899480554; 
 Wed, 28 Oct 2020 08:38:00 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 20sm6303570pfh.219.2020.10.28.08.37.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 08:37:59 -0700 (PDT)
Subject: Re: [PATCH 3/9] accel/tcg/user-exec: silence the compiler warnings
To: Thomas Huth <thuth@redhat.com>, Chen Qun <kuhn.chenqun@huawei.com>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20201028041819.2169003-1-kuhn.chenqun@huawei.com>
 <20201028041819.2169003-4-kuhn.chenqun@huawei.com>
 <e2a3548e-d36c-3338-f298-150cce3c3d47@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d84d1e42-5814-05fb-4bfa-878cdca0754b@linaro.org>
Date: Wed, 28 Oct 2020 08:37:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e2a3548e-d36c-3338-f298-150cce3c3d47@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.921,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 zhang.zhanghailiang@huawei.com, ganqixin@huawei.com,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/28/20 6:52 AM, Thomas Huth wrote:
> On 28/10/2020 05.18, Chen Qun wrote:
>> When using -Wimplicit-fallthrough in our CFLAGS, the compiler showed warning:
>> ../accel/tcg/user-exec.c: In function ‘handle_cpu_signal’:
>> ../accel/tcg/user-exec.c:169:13: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>   169 |             cpu_exit_tb_from_sighandler(cpu, old_set);
>>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ../accel/tcg/user-exec.c:172:9: note: here
>>   172 |         default:
>>
>> This exception branch fall through the 'default' branch and run the 'g_assert_not_reached' statement.
>> So we could use "fall through" instead of "NORETURN" here.
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
>> ---
>> Cc: Riku Voipio <riku.voipio@iki.fi>
>> Cc: Richard Henderson <richard.henderson@linaro.org>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  accel/tcg/user-exec.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
>> index 4ebe25461a..330468e990 100644
>> --- a/accel/tcg/user-exec.c
>> +++ b/accel/tcg/user-exec.c
>> @@ -167,7 +167,7 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
>>               */
>>              clear_helper_retaddr();
>>              cpu_exit_tb_from_sighandler(cpu, old_set);
>> -            /* NORETURN */
>> +            /* fall through */
> 
> There should not be a fall through here since the previous function should
> never return. Does the warning go away if you mark the
> cpu_exit_tb_from_sighandler() function with QEMU_NORETURN ? If so, I think
> that would be the better fix.

The compiler should have figured that out itself, due to cpu_loop_exit_noexc
being marked QEMU_NORETURN.  However,
if adding a second QEMU_NORETURN works, I'm fine with that.

As a very last resort, we can change the comment to

    /* no return, but fall through to assert not reached */

which correctly documents both the function preceding and also contains the
regexp that the compiler is using for the warning.


r~


