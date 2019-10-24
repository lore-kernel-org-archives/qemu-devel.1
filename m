Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F7ECA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:04:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F66A205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q46PgCoZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F66A205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNhT5-00016Y-C4
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 14:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNhOy-0001Ef-BC
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 14:00:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNhOu-0002Br-HV
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:59:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53292
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNhOu-0002Aq-AD
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571939994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mra5WsFMDMwMaKphhK95i3CcfFGGRS2c1ypwx7gw2+8=;
 b=Q46PgCoZqr0Hlctp32o4/Y5SKf/Y8ZcjwoEYQXNjeMg+ECYdy6Mhxh286mOkaCMwfvKhvf
 vP3ZK/kV58V2FLO2rn4KDaAyFO20thC5uX5QqR7pfAclxeZe42oTLDY3T0aE7GXSWN6TQd
 sQLlptrgpJOPq/7zqVYRKZAPfxxTEJw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-9S7CbDw6NOan1HIkKkOW4w-1; Thu, 24 Oct 2019 13:59:48 -0400
Received: by mail-wm1-f69.google.com with SMTP id z23so1383860wml.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 10:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wtfUwemMHbbCR3o+kWYCbsDa/IiYXq0j8CinEDPTlLo=;
 b=HLdfpVOsgYXlYG1lXnZ9msFN73Zlkln0bb3altBiCc+Aaw0RW3S3DAHdWMy52sBvLf
 BqnCYuDprULD/EwBbKjmEcOgajQ4PupylUCL3XuEnZOsIp2JZy2/suGQeTaO8EUzC4aI
 S6egfRtBODkqAtaK7NrDmBFkP/Zyq1NUJbxlJMVZNGXcRDs0x8QpSeKBIuDUCfHISSVi
 ZFYF2xF0XMNF4S7SlphsGeBFYgwf1YOW1zbADYFq5Tboj9PS9gPtnOEpwMeTOc70Y9cm
 3QCdDhucyJctfQvMkI9CbZvjRMhQukajB/QHJFrAh+uzIkQA0lU0aYuj7GXdzO2hVQT9
 Smkg==
X-Gm-Message-State: APjAAAUT/6nFFbIC305WXy74t5t1YnSNey8dBuSz2KkhByQ220aEgzBH
 AeLDkWQrWIE+ipJOYmMnOjpoWKBOqx27i43DZHbara4F8fZZVBF7f0V3cGTKsJht+UkNAcWHJKg
 XQScGs2BSKGxecSA=
X-Received: by 2002:adf:ea07:: with SMTP id q7mr4873516wrm.102.1571939987499; 
 Thu, 24 Oct 2019 10:59:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwstqnhKvOvRzhfYYrWcopWNGXeQX6iwDzNnzR4g3N3cAoEdkn8sxojNNRst00x46A79vJxnQ==
X-Received: by 2002:adf:ea07:: with SMTP id q7mr4873497wrm.102.1571939987231; 
 Thu, 24 Oct 2019 10:59:47 -0700 (PDT)
Received: from [192.168.1.115] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id g5sm3822944wmg.12.2019.10.24.10.59.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2019 10:59:46 -0700 (PDT)
Subject: Re: [PATCH] travis.yml: enable linux-gcc-debug-tcg cache
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191024160619.14179-1-alex.bennee@linaro.org>
 <4f36130d-f2cc-2432-7098-b73f82c1501e@redhat.com> <877e4um5t7.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <688b8633-72dd-c3d5-019e-4af527a9dc52@redhat.com>
Date: Thu, 24 Oct 2019 19:59:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <877e4um5t7.fsf@linaro.org>
Content-Language: en-US
X-MC-Unique: 9S7CbDw6NOan1HIkKkOW4w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/24/19 7:06 PM, Alex Benn=C3=A9e wrote:
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
>> On 10/24/19 6:06 PM, Alex Benn=C3=A9e wrote:
>>> Create a new cache for the --enable-debug-tcg builds which is separate
>>> from the normal debug builds which generate different code. We also
>>> enable debug-tcg for the new plugins based builds as we want to ensure
>>> any breakage to TCG is picked up by the sanity checks.
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> ---
>>>    .travis.yml | 14 +++++++-------
>>>    1 file changed, 7 insertions(+), 7 deletions(-)
>>> diff --git a/.travis.yml b/.travis.yml
>>> index e3f10a93683..34bc8134f5b 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -135,7 +135,7 @@ matrix:
>>>        # TCG debug can be run just on its own and is mostly agnostic to=
 user/softmmu distinctions
>>>        - env:
>>>            - CONFIG=3D"--enable-debug-tcg --disable-system"
>>> -        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug"
>>> +        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
>>
>> This one runs default TEST_CMD=3D"make check -j3 V=3D1"
>=20
> That does exercise the TCG a little because the various qemu-system-FOO
> builds have some bootcode. However given we exercise the TCG more
> further down we could just drop this matrix entry.

I haven't checked how long takes "make check check-tcg", hopefully we=20
could merge both.

>>>
>>>        - env:
>>> @@ -336,29 +336,29 @@ matrix:
>>>        - env:
>>>            - CONFIG=3D"--disable-system --enable-debug-tcg"
>>>            - TEST_CMD=3D"make -j3 check-tcg V=3D1"
>>
>> And this one "check-tcg", OK.
>> (Maybe we can reorder the $CONFIG arguments so both jobs are more simila=
r).
>>
>> Too bad Travis 'stages' are an enterprise feature:
>>
>> https://docs.travis-ci.com/user/conditional-builds-stages-jobs/#conditio=
nal-stages
>>
>> Because here we are building 2x the same, and cache isn't used.
>=20
> Why isn't the cache used?

IIUC cache aren't shared within the same jobs of a build, but by jobs at=20
build+1.

>>
>> Not this patch problem.
>>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>
>>> -        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
>>> +        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
>>>
>>>        # Run check-tcg against linux-user (with plugins)
>>>        # we skip sparc64-linux-user until it has been fixed somewhat
>>>        - env:
>>> -        - CONFIG=3D"--disable-system --enable-plugins --target-list-ex=
clude=3Dsparc64-linux-user"
>>> +        - CONFIG=3D"--disable-system --enable-plugins --enable-debug-t=
cg --target-list-exclude=3Dsparc64-linux-user"
>>>            - TEST_CMD=3D"make -j3 check-tcg V=3D1"
>>> -        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
>>> +        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
>>>
>>>        # Run check-tcg against softmmu targets
>>>        - env:
>>>            - CONFIG=3D"--enable-debug-tcg --target-list=3Dxtensa-softmm=
u,arm-softmmu,aarch64-softmmu,alpha-softmmu"
>>>            - TEST_CMD=3D"make -j3 check-tcg V=3D1"
>>> -        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
>>> +        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
>>>
>>>        # Run check-tcg against softmmu targets (with plugins)
>>>        - env:
>>> -        - CONFIG=3D"--enable-plugins --target-list=3Dxtensa-softmmu,ar=
m-softmmu,aarch64-softmmu,alpha-softmmu"
>>> +        - CONFIG=3D"--enable-plugins --enable-debug-tcg --target-list=
=3Dxtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
>>>            - TEST_CMD=3D"make -j3 check-tcg V=3D1"
>>> -        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
>>> +        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
>>>
>>>        # Release builds
>>>
>=20
>=20
> --
> Alex Benn=C3=A9e
>=20


