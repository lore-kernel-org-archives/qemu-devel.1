Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017E5C41514
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:22:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C413B2067D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tWBhB5rK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C413B2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxVon-0004Yn-5E
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 08:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50146)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hxVoL-00048J-Pk
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:21:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hxVoK-0004Ux-M9
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:21:57 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43270)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hxVoK-0004UF-EH
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:21:56 -0400
Received: by mail-wr1-x442.google.com with SMTP id y8so1613571wrn.10
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 05:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Acb3mV+sdo/k55ac5fn/Gut/2pLZQvVX62U8b0yURy0=;
 b=tWBhB5rK8Kz36HEX5kfU2hVZGAedxhJOqmTJ+y5yITRG+k2MZxoOV5hQNaxGS0gI9o
 MflcD5OXpC3PJyKjnSGxvtspTHGm52oeQ2eT1c+vtznX0komA023tJQHxEs1oZExYA08
 VaNXQMtvfaj70ojzyw5muG2DiqvugtWVHG+UYdCnOCiu89ukI4e4vtMMZ+K0hkHZgr99
 7erRHjuBZADDGE3i6uDHVUGPNRirClddawpO1V+ppHI6xYZXrnoMkDb4mxuMlRwMjFdu
 GMXtTl/d11P1tH2ZLM+WvopOWICF88H8c31RndRQFztAy2AVPQrrq1xDnXPPloAh73d+
 j6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Acb3mV+sdo/k55ac5fn/Gut/2pLZQvVX62U8b0yURy0=;
 b=t0Ry49N/FShcnIsVbEkac3dXhSNsuB7NoAR9cMiD6ZFsXXVLmOhtpvRKILpw6pUHYv
 4/WqOZD7NDS3BVMUGDU9tuCISDNzSjoXviCtBywjD+2y3wncIhmZ4SMd541ydCxG+LkY
 SdZFBopm4T8JNdqOw2NLuW6EWvbCViQ/j8ii9Blc7URcHkZjZtSNrrCNLV/lQTwCfH0o
 R+v9aznIPq4xJEZ0o9z/JOiDVCBZ/keCQ/krsUV9sTsPMAvKSnJqQypHNjdjHi4v0w/5
 fVq36WBoVZyV8DBzfqFtgSLqgEoy/87gbG2Q2s6hfOfE25l6IQ7NNW8qjJ5NOIomlCzt
 sIBg==
X-Gm-Message-State: APjAAAXG2AtzpyfUx2qI8bknY7FLPpUIeIrxB55BdrmsXvBQj58RIWay
 VXC3QfFEcgSN7MzseyHs4RVi1w==
X-Google-Smtp-Source: APXvYqx6hd5kVXEir2jCZQkvXsBz8Oi0BbxuXed0GTWRPG3jbHZzKIXmICx1SvgyykrADbH5bMnHXw==
X-Received: by 2002:a05:6000:1186:: with SMTP id
 g6mr48049021wrx.17.1565698915039; 
 Tue, 13 Aug 2019 05:21:55 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id n14sm213490659wra.75.2019.08.13.05.21.54
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 13 Aug 2019 05:21:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0BFDC1FF87;
 Tue, 13 Aug 2019 13:21:54 +0100 (BST)
References: <1564481593-776647-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <573f907d-5016-60c1-c727-c5444a418e1b@virtuozzo.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
In-reply-to: <573f907d-5016-60c1-c727-c5444a418e1b@virtuozzo.com>
Date: Tue, 13 Aug 2019 13:21:54 +0100
Message-ID: <8736i5ntlp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH] Fix: fp-test uninitialized member
 floatX::exp
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "cota@braap.org" <cota@braap.org>,
 "jhauser@eecs.berkeley.edu" <jhauser@eecs.berkeley.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Andrey Shinkevich <andrey.shinkevich@virtuozzo.com> writes:

> PINGING...

Sorry about the delay. I did attempt see if the existing code threw up
any errors when built with clang's undefined sanitizer. I think this is
because xPtr->exp will only get read if none of the xPtr->isFOO returns
false. In all those cases xPtr->exp is set.

What pointed you towards this missing initialisations?

>
> On 30/07/2019 13:13, Andrey Shinkevich wrote:
>> Not all the paths in the functions, such as f16ToFloatX(), initialize
>> the member 'exp' of the structure floatX.
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   source/slowfloat.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/tests/fp/berkeley-testfloat-3/source/slowfloat.c b/tests/fp=
/berkeley-testfloat-3/source/slowfloat.c
>> index 4e84656..6e0f0a6 100644
>> --- a/tests/fp/berkeley-testfloat-3/source/slowfloat.c
>> +++ b/tests/fp/berkeley-testfloat-3/source/slowfloat.c
>> @@ -623,6 +623,7 @@ static void f16ToFloatX( float16_t a, struct floatX =
*xPtr )
>>       xPtr->isInf =3D false;
>>       xPtr->isZero =3D false;
>>       xPtr->sign =3D ((uiA & 0x8000) !=3D 0);
>> +    xPtr->exp =3D 0;
>>       exp =3D uiA>>10 & 0x1F;
>>       sig64 =3D uiA & 0x03FF;
>>       sig64 <<=3D 45;
>> @@ -759,6 +760,7 @@ static void f32ToFloatX( float32_t a, struct floatX =
*xPtr )
>>       xPtr->isInf =3D false;
>>       xPtr->isZero =3D false;
>>       xPtr->sign =3D ((uiA & 0x80000000) !=3D 0);
>> +    xPtr->exp =3D 0;
>>       exp =3D uiA>>23 & 0xFF;
>>       sig64 =3D uiA & 0x007FFFFF;
>>       sig64 <<=3D 32;
>> @@ -895,6 +897,7 @@ static void f64ToFloatX( float64_t a, struct floatX =
*xPtr )
>>       xPtr->isInf =3D false;
>>       xPtr->isZero =3D false;
>>       xPtr->sign =3D ((uiA & UINT64_C( 0x8000000000000000 )) !=3D 0);
>> +    xPtr->exp =3D 0;
>>       exp =3D uiA>>52 & 0x7FF;
>>       sig64 =3D uiA & UINT64_C( 0x000FFFFFFFFFFFFF );
>>       if ( exp =3D=3D 0x7FF ) {
>> @@ -1220,6 +1223,7 @@ static void f128MToFloatX( const float128_t *aPtr,=
 struct floatX *xPtr )
>>       xPtr->isZero =3D false;
>>       uiA64 =3D uiAPtr->v64;
>>       xPtr->sign =3D ((uiA64 & UINT64_C( 0x8000000000000000 )) !=3D 0);
>> +    xPtr->exp =3D 0;
>>       exp =3D uiA64>>48 & 0x7FFF;
>>       sig.v64 =3D uiA64 & UINT64_C( 0x0000FFFFFFFFFFFF );
>>       sig.v0  =3D uiAPtr->v0;
>>


--
Alex Benn=C3=A9e

