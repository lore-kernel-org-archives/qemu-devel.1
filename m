Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2E5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:28:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8367206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8vQWG9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8367206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxuBk-0000ZH-3d
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 11:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxu9j-0007Es-9I
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 11:26:11 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39121)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxu9h-0005t5-Dm
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 11:26:11 -0400
Received: by mail-wm1-x341.google.com with SMTP id w3so3287031wmi.4
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 08:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+IRi+TkYlJ+zxvgthUkY5dmKfUVwxnbK7eI0LvwU5K4=;
 b=F8vQWG9n5p9cHcUCfdsmI16XlRXw33Lwnxk5DpGLykCxQITm1AudXHeT35CxXW0+6q
 hV/H+w3r7xe4vvAusOLe7LXHgvY9SLlx3MNbro4ueYV9EMe7p5Y4uDb+mP7irlR+wscC
 ov5HU3wMOu2Y7xPXthm5Ij7Rh4L0+RcStwxMYIFkTBhyByjBONsmzazLke6SfrDmNM9x
 lLmSPBGmQ4IsOgk91rAE3vde0BroKS3QZIMmAzB8eIHoPAizXXZQBPg93kV+lQgfP/ux
 ppcCtFDcW6YcdBXaotMZCqBGKSS95fhiqzndVP8dMqvWTqwwK5qFCABCKa5mkhwa/hQJ
 fQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+IRi+TkYlJ+zxvgthUkY5dmKfUVwxnbK7eI0LvwU5K4=;
 b=oeeI7QMOfUaxQCg3BxMO20DN5Ozm3QQ7Jpqal7ujCrTdIgpYWzkEF7YeS++y9CBkg0
 /xu2pCol1q7t84S7t4wXAnNGEQR4mSKWx1+hFxKHePprCsBwhWTTJTpAkPSfRGe4MeyZ
 CaSigtf8HZZMCjVtTl3dGCKkT9D01QRWRt0r27339GOZMyWoswyMeBotnXlGAuFhyxIo
 3iTMU6zpZGlvfXAUG04/tbgPraHA+BulV/XuMmMEe6O4+s+GoszLN+zju9TVcPUrimYj
 L3Jc3CAlcCJJPH7k4hehr2iC4vGqxYlxVx9aHFPCuKZiawNaBGt54Ut4hmPyaYywahum
 1u8Q==
X-Gm-Message-State: AOAM530J4f7ix6om/+PBnItzxrP7gsooC4u47G8prK7qzTMY/qCz8Pfe
 N7HvsmWiziobRNXUPig5yMQ=
X-Google-Smtp-Source: ABdhPJyn1iuVOijXtGc1adPJYwTul7gTVmNCSm/W5/6KF4z+YWKtnFwXVys2O/G2m+bKCmnCW0s/6Q==
X-Received: by 2002:a05:600c:20d3:: with SMTP id
 y19mr4789889wmm.10.1595345167341; 
 Tue, 21 Jul 2020 08:26:07 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id t15sm3931352wmj.14.2020.07.21.08.26.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2020 08:26:06 -0700 (PDT)
Subject: Re: [RFC PATCH-for-5.1?] tests/tcg/multiarch/linux-test: Skip test if
 nanosleep missing (Travis)
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200721085757.14358-1-f4bug@amsat.org>
 <5989e383-eade-7112-7c04-336679734e49@vivier.eu>
 <bb745eb2-74bc-f013-36de-4cb8d6f364f1@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <01fefb26-7104-642f-0851-0af7fa1678a2@amsat.org>
Date: Tue, 21 Jul 2020 17:26:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <bb745eb2-74bc-f013-36de-4cb8d6f364f1@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/21/20 2:24 PM, Laurent Vivier wrote:
> Le 21/07/2020 à 13:38, Laurent Vivier a écrit :
>> Le 21/07/2020 à 10:57, Philippe Mathieu-Daudé a écrit :
>>> The time test sometimes fails on Travis-CI [*]:
>>>
>>>     TEST    linux-test on aarch64
>>>   tests/tcg/multiarch/linux-test.c:237: nanosleep
>>>   make[2]: *** [run-linux-test] Error 1
>>>   make: *** [run-tcg-tests-aarch64-linux-user] Error 2
>>>
>>> As this seems due to a container limitation on Travis-CI,
>>> simply skip the test there.
>>>
>>> [*] https://travis-ci.org/github/qemu/qemu/jobs/710005078#L3706
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>> RFC because per Laurent Vivier we are not using the correct libc
>>>     while cross-linking the test (maybe change in the container
>>>     packages?)
>>> ---
>>>  tests/tcg/multiarch/linux-test.c | 7 ++++++-
>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/linux-test.c
>>> index 8a7c15cd31..c7dfdec9ec 100644
>>> --- a/tests/tcg/multiarch/linux-test.c
>>> +++ b/tests/tcg/multiarch/linux-test.c
>>> @@ -233,8 +233,13 @@ static void test_time(void)
>>>      ts.tv_sec = 0;
>>>      ts.tv_nsec = 20 * 1000000;
>>>      chk_error(nanosleep(&ts, &rem));
>>> -    if (rem.tv_sec != 1)
>>> +    if (rem.tv_sec != 1) {
>>> +        if (getenv("TRAVIS_ARCH")) {
>>> +            printf("nanosleep missing? skipping 'time' test\n");
>>> +            return;
>>> +        }
>>>          error("nanosleep");
>>> +    }
>>>      chk_error(gettimeofday(&tv2, NULL));
>>>      ti = tv2.tv_sec - tv.tv_sec;
>>>      if (ti >= 2)
>>>
>>
>> Well, in the end I think the problem is in linux-user:
>>
>> We copy the "rem" structure even if there is no error, so "1" is
>> overwritten.
>>
>> We don't have the problem on all architectures because some use
>> nanosleep() syscall (that is correct) others use clock_nanosleep()
>> syscall that is not correct.
>>
>> This should fix the problem:
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 1211e759c26c..130005716ece 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -11831,7 +11831,7 @@ static abi_long do_syscall1(void *cpu_env, int
>> num, abi_long arg1,
>>          target_to_host_timespec(&ts, arg3);
>>          ret = get_errno(safe_clock_nanosleep(arg1, arg2,
>>                                               &ts, arg4 ? &ts : NULL));
>> -        if (arg4)
>> +        if (is_error(ret) && arg4)
>>              host_to_target_timespec(arg4, &ts);
>>
>>  #if defined(TARGET_PPC)
> 
> According to clock_nanosleep(2) it should be in fact:
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 1211e759c26c..63e7cd8947e5 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -11831,8 +11831,9 @@ static abi_long do_syscall1(void *cpu_env, int
> num, abi_long arg1,
>          target_to_host_timespec(&ts, arg3);
>          ret = get_errno(safe_clock_nanosleep(arg1, arg2,
>                                               &ts, arg4 ? &ts : NULL));
> -        if (arg4)
> +        if (ret == -TARGET_EINTR && arg4 && arg2 != TIMER_ABSTIME) {
>              host_to_target_timespec(arg4, &ts);
> +        }

I tested this hunk and couldn't reproduce it on Travis-CI. Since it is
intermittent, that doesn't mean much, but still if you send a proper
path you can add "Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>".

> 
>  #if defined(TARGET_PPC)
>          /* clock_nanosleep is odd in that it returns positive errno values.
> 
> 

