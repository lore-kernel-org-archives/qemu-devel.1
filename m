Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF46C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:24:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AB8C22286
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vtgk5I+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AB8C22286
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIXQb-0004pW-HQ
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 09:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIXPN-0003z7-RA
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 09:23:37 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35367)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIXPM-0004Fz-28
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 09:23:37 -0400
Received: by mail-wm1-x343.google.com with SMTP id y15so3044408wmi.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 06:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=5GytSI5sRwxpnxdo7rNoJNsGc/17TFxhpkWskb5BqDI=;
 b=Vtgk5I+ScY7lEPtMPeCaBXO2RRWts11b9phqTOTO/+L0yoZ5XDAAf8toshfWBjApB/
 dMh20jtVtoMc48x6F9vEIErJbtE7Z2oCSp+rnDMQZf14KyohXPG9VFItXXiWvh6MbMoF
 ebAt5hP1eBNYOPvw45U1Bp0JjKRWxFnlo0jpe3PpTEONTiuEWbNeq4MPHYpSZXyf2Wfs
 iUmwkDfB19B2ZgxE8uZcXHb1Kup4OCZg/Wq5hvJ1JKwJ0DuhmEvBR8BdSAARrlBMdmsn
 ypoSrKNbp8YavGEQ0XCITnVT2aiH9P7sxJmfOZweFxNfBhds99lT5tcUHwUXijTuGUsh
 9uGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=5GytSI5sRwxpnxdo7rNoJNsGc/17TFxhpkWskb5BqDI=;
 b=WynfXcuAOycT3AMWHzInk0t+8fAX00lmTG3IjyuQZOnu//Y/E3ByGQVCWqHfPxA74E
 G2130mB0XMPChGNiN8LLepkN9eZmaDuN5Y9FG2wMPE9pp79wHHtsr4h4Ae7rlGf/2CRL
 Y4D3GpPL/lLK104/B8pjtKxEjQ7QWdxGe5wuEPKbX6YHvH3kA5HaDPauDD10Z9vAVf0g
 Almk9lshXpFeVjbUmXHD5OyCs+xzUrlflEujSfN8pWSPsu0DL4H35z5KKBGtFfDyylIM
 NrpXoNuq+qNPv2PoSl7g81yrXtWeiuX4teSGH2a4JsqmVzAWouc/AabvRVC8qo4aSfhI
 RgaA==
X-Gm-Message-State: AOAM533WqymbPmrdnhaTd/dioIZf/aGNpVJZPT3G6g6rGV54Qn7leB2h
 2NK47oO8qJ4inD0wThInt/Lyjg==
X-Google-Smtp-Source: ABdhPJw/xaqpPC+d5L9CDEdftWz34YQessHKnL3uT/+5soH+1fyHni109QWkR6LSiOBzGNevyp/9Rg==
X-Received: by 2002:a1c:7d4d:: with SMTP id y74mr4723689wmc.73.1600262614834; 
 Wed, 16 Sep 2020 06:23:34 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a17sm35597406wra.24.2020.09.16.06.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 06:23:33 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E560D1FF7E;
 Wed, 16 Sep 2020 14:23:32 +0100 (BST)
References: <20200916122648.17468-1-alex.bennee@linaro.org>
 <20200916122648.17468-8-alex.bennee@linaro.org>
 <CAFEAcA_UEoe2H5zc=L1T3p31FoxKSfG0mRznN-68FQmGTp3+pg@mail.gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 7/8] gitlab: create a build-deprecated target
In-reply-to: <CAFEAcA_UEoe2H5zc=L1T3p31FoxKSfG0mRznN-68FQmGTp3+pg@mail.gmail.com>
Date: Wed, 16 Sep 2020 14:23:32 +0100
Message-ID: <87imcdzwh7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Da?= =?utf-8?Q?ud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 16 Sep 2020 at 13:27, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> These targets might be deprecated but we should keep them building
>> before the final axe comes down. Lets keep them all in one place and
>> don't hold up the CI if they do fail. They are either poorly tested or
>> already flaky anyway.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Acked-by: Thomas Huth <thuth@redhat.com>
>> Message-Id: <20200915134317.11110-8-alex.bennee@linaro.org>
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index 72e8604579ee..f027b55aef15 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -254,6 +254,16 @@ build-clang:
>>        ppc-softmmu s390x-softmmu arm-linux-user
>>      MAKE_CHECK_ARGS: check
>>
>> +# These targets are on the way out
>> +build-deprecated:
>> +  <<: *native_build_job_definition
>> +  variables:
>> +    IMAGE: debian-all-test-cross
>> +    CONFIGURE_ARGS: --disable-docs --disable-tools --disable-system
>> +    MAKE_CHECK_ARGS: check-tcg
>> +    TARGETS: ppc64abi32-linux-user tilegx-linux-user
>> +  allow_failure: true
>
> It's kind of awkward to have the CI config need to be updated when
> we mark a config as deprecated. Can we have something so that
> the CI just arranges to build all of the deprecated targets?

You mean a configure --enable-deprecated-targets?

>
> (As demonstration, this list is missing unicore32, which is also
> deprecated.)

That was fixed up in the next patch.

> Also, "allow_failure: true" seems wrong to me. These targets
> are only deprecated, which means we promise that the feature
> should still work (to whatever extent it already did) for the 2
> releases in which it is deprecated. We want our CI to tell us
> if it fails to compile or fails tests, because we would need to
> fix those bugs for a release.

I can revert that bit.

--=20
Alex Benn=C3=A9e

