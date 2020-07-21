Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640C1C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:36:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B33820717
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="stWZoh8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B33820717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxrVl-0006Ub-DI
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 08:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jxrRL-0007GA-KH
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:32:11 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44452)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jxrRI-0003Tf-Qy
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:32:10 -0400
Received: by mail-wr1-x444.google.com with SMTP id b6so21005598wrs.11
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 05:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=DhBK8HyX73jHYM3ax8BFgUhYlAuX64Zsz0yqTH0y8OU=;
 b=stWZoh8zgInPseKhyj9p6QdzDVtmZiiRDSH+fetB7dAkuWzbO+LEYgXAl8KoWYlvEI
 Op4BlsTTS4HRqLnRA+FKSpYc8nZUvTG/vLdirQZUhJz61FcKU/2imhFDrxBQiVtoNkdN
 ml7AhT5okrdfB3Y4fmE/jg0XvQzAMAs/WkINcMTBMTn1zIqvjiVk94CT7p1s9fgNolnM
 GmHCGxvL7md3QnLAh2dWslPlWXRPhs+MFX4h6fTdn+9B0l5YiSYSUmnIC5N40bPgyHCD
 zdaBk8pE7zvPVXFmkTu5cWkYk+dZLsptlntv1xVDEiVfmBO3XKZCacdlmbbyEV6DoMMY
 xOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=DhBK8HyX73jHYM3ax8BFgUhYlAuX64Zsz0yqTH0y8OU=;
 b=iR4A2sqtJSy3R3QQMdZhRK0heyT3kJsbue6lAZ7K1Yl8VlDFSxhrKn9Qk1DLxgFX5C
 fbxEFRvh+JzHmUhBfmz3uBz7Cp2jobO6wfz9JaMm8Rf2DCzIt/wsn0ae0OmtGj4f6WD5
 CbT0MuOpLpJh6nmI19pADgLNWWB5Xv+3ADcAT1HuHryR/FJwiZZlrbJ+OboMu+PTS2TQ
 VOQcP0qRHEWAr8WrVU59R0k+uttw532JNftBSYj4FGkNruNN2+FNgpC4vk02NrtafFwu
 issifCnUDAa0FQ2+kdWp1VPm6AaKjgliExVNvge+AfnPkamJlqop/9gEvmy3CuJQoUDm
 mUYQ==
X-Gm-Message-State: AOAM532MFFgrrDafI/9decwpS1AntEtrMmCVqmHUoWbAael+FcXr/7RM
 VbyL4BBATBEOX7Zop+QpWN5+ug==
X-Google-Smtp-Source: ABdhPJxlUkv0gdJPi6NSrXeRPyJSexBu+hddyYjg9W9KJlJMcS6heFKp+pYJRHGy0zww21zyu9dktg==
X-Received: by 2002:adf:9062:: with SMTP id h89mr24495065wrh.285.1595334726562; 
 Tue, 21 Jul 2020 05:32:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e5sm21099169wrc.37.2020.07.21.05.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 05:32:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8506D1FF7E;
 Tue, 21 Jul 2020 13:32:04 +0100 (BST)
References: <20200721085757.14358-1-f4bug@amsat.org>
 <5989e383-eade-7112-7c04-336679734e49@vivier.eu>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [RFC PATCH-for-5.1?] tests/tcg/multiarch/linux-test: Skip test
 if nanosleep missing (Travis)
In-reply-to: <5989e383-eade-7112-7c04-336679734e49@vivier.eu>
Date: Tue, 21 Jul 2020 13:32:04 +0100
Message-ID: <87v9ihujzv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Laurent Vivier <laurent@vivier.eu> writes:

> Le 21/07/2020 =C3=A0 10:57, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit :
>> The time test sometimes fails on Travis-CI [*]:
>>=20
>>     TEST    linux-test on aarch64
>>   tests/tcg/multiarch/linux-test.c:237: nanosleep
>>   make[2]: *** [run-linux-test] Error 1
>>   make: *** [run-tcg-tests-aarch64-linux-user] Error 2
>>=20
>> As this seems due to a container limitation on Travis-CI,
>> simply skip the test there.
>>=20
>> [*] https://travis-ci.org/github/qemu/qemu/jobs/710005078#L3706
>>=20
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>> RFC because per Laurent Vivier we are not using the correct libc
>>     while cross-linking the test (maybe change in the container
>>     packages?)
>> ---
>>  tests/tcg/multiarch/linux-test.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/linu=
x-test.c
>> index 8a7c15cd31..c7dfdec9ec 100644
>> --- a/tests/tcg/multiarch/linux-test.c
>> +++ b/tests/tcg/multiarch/linux-test.c
>> @@ -233,8 +233,13 @@ static void test_time(void)
>>      ts.tv_sec =3D 0;
>>      ts.tv_nsec =3D 20 * 1000000;
>>      chk_error(nanosleep(&ts, &rem));
>> -    if (rem.tv_sec !=3D 1)
>> +    if (rem.tv_sec !=3D 1) {
>> +        if (getenv("TRAVIS_ARCH")) {
>> +            printf("nanosleep missing? skipping 'time' test\n");
>> +            return;
>> +        }
>>          error("nanosleep");
>> +    }
>>      chk_error(gettimeofday(&tv2, NULL));
>>      ti =3D tv2.tv_sec - tv.tv_sec;
>>      if (ti >=3D 2)
>>=20
>
> Well, in the end I think the problem is in linux-user:
>
> We copy the "rem" structure even if there is no error, so "1" is
> overwritten.
>
> We don't have the problem on all architectures because some use
> nanosleep() syscall (that is correct) others use clock_nanosleep()
> syscall that is not correct.
>
> This should fix the problem:
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 1211e759c26c..130005716ece 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -11831,7 +11831,7 @@ static abi_long do_syscall1(void *cpu_env, int
> num, abi_long arg1,
>          target_to_host_timespec(&ts, arg3);
>          ret =3D get_errno(safe_clock_nanosleep(arg1, arg2,
>                                               &ts, arg4 ? &ts : NULL));
> -        if (arg4)
> +        if (is_error(ret) && arg4)
>              host_to_target_timespec(arg4, &ts);

So the testcase worked and caught something :-)

I don't know why I couldn't trigger it reliably on my own dev setting thoug=
h...

>
>  #if defined(TARGET_PPC)
>
> Thanks,
> Laurent


--=20
Alex Benn=C3=A9e

