Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A5FC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 13:04:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B90320707
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 13:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q8PYrBur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B90320707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY8bn-0001DI-7B
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 08:04:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iY8aq-0000fS-8U
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 08:03:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iY8ao-0006Qi-Fn
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 08:03:24 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:56205)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iY8am-0006QL-QZ
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 08:03:21 -0500
Received: by mail-wm1-x344.google.com with SMTP id b11so7350775wmb.5
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 05:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=fKYzQg02YYFetbyzZrtLe8SNabeDTInfZdu0tYnDe5o=;
 b=q8PYrBurZBJ+KEAxt6m/IKZyoZEWq0Zv6p+DIXHPsROp2Ho4GXHdnBKZ1vesx6gQMM
 WNKPosEcwmFCLvsIWqXt96jM+i9CxRqSowI7M9j5hoDLoR3nRdBHlUzWf3X/l8KruU6f
 LH2QYnroXittCOsqiiiS1t4W6V86CrSNBxsn4+0N8LRPHCK1FAYo8HYpLu4cUMDAC0n6
 VotakIBjuGVrdyTo8ZPOPmuqYd2CCEsJVf2ZOQdktHk2EdvUSbM8oaremUpLtmZV2DXn
 2OdAoAIPzlefC5vCQYIk/f2+k+TWbqJsR7XDvtaUmxgNn/5PcvPiWlo/Jbl78gZu5ZxP
 jYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=fKYzQg02YYFetbyzZrtLe8SNabeDTInfZdu0tYnDe5o=;
 b=TPF98kdhBRLFk/VffpShFtQZE5ATYkyDjzwb4c+DzELjmv/X0MWfN2+MiyKdVxGLa+
 2McVgTrUvAAkeZLUy5lRLaBE43NWGsJT56FfReAmd7aCncDc4JPakUQcCNDBkV/QgO/o
 jlJH8hdkEGjDhjD5Yqf1hD6C8QDQFY8OHMkfuyRQtcq4brgsn74dFcNz6eYt0P+kRrZk
 ZXglMLiJPPxJrzVMLbRCg/ehNAzbv5MzcsvVrHnmsoHKwOi5cQt7xiuTN51uCWv9H8iZ
 5z/33Yf4dbkZCUPOnriyFS7CCur8JgbetzsMUFqfNHlF7UTTvsrJn1gf3m1R1NrwWbKr
 fcyg==
X-Gm-Message-State: APjAAAX9awyszPT9UhUM6PlLvmuCQNySM5nG5hGwDVGXSZsQNRNLDAxf
 fBm774bPfCB4mX1V49qNq8/5fw==
X-Google-Smtp-Source: APXvYqzE/EoNViW9ieatjmWUznk3OjHsUxjlmMXC6c6DnPc56rkmD9MRGDdQQFz0QJNPXe+s0UOFbg==
X-Received: by 2002:a7b:cbc4:: with SMTP id n4mr16011733wmi.118.1574427798855; 
 Fri, 22 Nov 2019 05:03:18 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l10sm8472916wrg.90.2019.11.22.05.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 05:03:16 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EEF131FF87;
 Fri, 22 Nov 2019 13:03:15 +0000 (GMT)
References: <20191122112231.18431-1-alex.bennee@linaro.org>
 <20191122112231.18431-4-alex.bennee@linaro.org>
 <b91b6119-fc01-9cc0-b8cb-730d5484ede4@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v1 3/3] tests/vm/ubuntu: update i386 image to 18.04
In-reply-to: <b91b6119-fc01-9cc0-b8cb-730d5484ede4@redhat.com>
Date: Fri, 22 Nov 2019 13:03:15 +0000
Message-ID: <87eey083n0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Fam Zheng <fam@euphon.net>, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 11/22/19 12:22 PM, Alex Benn=C3=A9e wrote:
>> The current image is broken while running qtests but the bug go away
>> when built with a newer Ubuntu i386 image. I was unable to replicate
>> the crash on Debian Buster for i386 either so I'm concluding it is a
>> distro problem. Let's paper over that crack by updating our 32 bir
>
> typo "our 32 bit"
>
>> test image.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   tests/vm/ubuntu.i386 | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>> diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
>> index 18b1ea2b72c..f611bebdc9d 100755
>> --- a/tests/vm/ubuntu.i386
>> +++ b/tests/vm/ubuntu.i386
>> @@ -66,8 +66,8 @@ class UbuntuX86VM(basevm.BaseVM):
>>         def build_image(self, img):
>>           cimg =3D self._download_with_cache(
>> -            "https://cloud-images.ubuntu.com/releases/16.04/release-201=
90605/ubuntu-16.04-server-cloudimg-i386-disk1.img",
>> -            sha256sum=3D"e30091144c73483822b7c27193e9d47346dd1064229da5=
77c3fedcf943f7cfcc")
>
> This one is in QCow2 format.
>
>> +            "https://cloud-images.ubuntu.com/releases/bionic/release-20=
191114/ubuntu-18.04-server-cloudimg-i386.img",
>> +            sha256sum=3D"28969840626d1ea80bb249c08eef1a4533e8904aa51a32=
7b40f37ac4b4ff04ef")
>
> This one is announced as USB format (ISO) but is in QCow2 format too...
>

heh I never noticed. It worked though ;-)

> Using '18.04' instead of 'bionic' in the URL is not important because
> the information is also in the filename.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks.

>
>>           img_tmp =3D img + ".tmp"
>>           subprocess.check_call(["cp", "-f", cimg, img_tmp])
>>           subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
>>=20


--=20
Alex Benn=C3=A9e

