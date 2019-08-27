Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F19C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 16:02:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D08F2070B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 16:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l1DnHRFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D08F2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2dvr-00084L-5Y
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 12:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i2dt0-00061P-80
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 11:59:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i2dsy-0000IQ-K1
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 11:59:57 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55910)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i2dsy-0000I7-BV
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 11:59:56 -0400
Received: by mail-wm1-x344.google.com with SMTP id f72so3655741wmf.5
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 08:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=wro+KVUh19bMF+YIEPirzD72NpB5PGcgzoPg5Po78GA=;
 b=l1DnHRFNZMvrqATEfhyZRqFbCFSrUQFG0VLGQ0YfIV59w5emo0GubnBbGLzZrqTO5r
 L4+jRQ43YkyXZfv44ufd5FsmuC6r+1a2TxqCw0o5E1Z08875ikf7ZJn8vFrSwD1XPC1X
 aV2GIzPHKqu8t67mQH9mTJjw/5gLokLlIaSdCXpUlT4btys4RB/7pdJoPxLPpT58Yqsy
 lPZTa7CoAi8nc46yT0FcNfjEk9qipQjU/6iWd3DqbyYOEZ9BQ9kJ92mfeUix7WjybX4D
 /sHXW5VRi0EldsrOFoa6DxXlQKiRAftGXZ64gW2bHjiZtD1/ldgFejMnM9N9Y9V1GL3C
 sN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=wro+KVUh19bMF+YIEPirzD72NpB5PGcgzoPg5Po78GA=;
 b=PQ15qzVRvjEDc/mLQn2wec9WeoiXJxCTfW8KA/XKQySmaFTiSMuC/ME3ubLm75Hf77
 CA9EEEVOEOU6bdKYMaXSO2kMTo9jplCQ9x/i9Udesfp3lsdyioXbcPCNnlrLULo4sp8A
 EAkCx+4YnTr980laSSxK+oyaEBjyf7EHS+AUOuPco282F1UxCRT2iNE9rppFoNHOs3Bs
 Hf9KQ6M8nuqQQJZ/cmnDFRTrjYor5SL/b5av0VEcue3orWZiW8wa1D1jLHIYAMkXydmM
 gp1A+UAbiCA1PadjWeldasySIS4UgEKIwGVpKyXj/xeEzQ9IROveX4UTruLgqnIaCINv
 q/eA==
X-Gm-Message-State: APjAAAXKfDmdKdI9U9az6BjWvsz5so/8DSRUmSpohazA+B2ZtIFFZSdK
 UmQp1xgKptc6YfqYpR08k0im+1aSpHo=
X-Google-Smtp-Source: APXvYqzOuFL0ZgWtymSBc6nUqHid73jrQhzdM7GdxXl94lltc1BgayAFGves0J7DPvq8oGn/LCmoOA==
X-Received: by 2002:a05:600c:228f:: with SMTP id
 15mr27862132wmf.160.1566921594633; 
 Tue, 27 Aug 2019 08:59:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c15sm52143272wrb.80.2019.08.27.08.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2019 08:59:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4EE2A1FF87;
 Tue, 27 Aug 2019 16:59:53 +0100 (BST)
References: <1564481593-776647-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <573f907d-5016-60c1-c727-c5444a418e1b@virtuozzo.com>
 <8736i5ntlp.fsf@linaro.org>
 <af72d680-f169-bdba-3b6e-d2da6b820aea@virtuozzo.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
In-reply-to: <af72d680-f169-bdba-3b6e-d2da6b820aea@virtuozzo.com>
Date: Tue, 27 Aug 2019 16:59:53 +0100
Message-ID: <87mufu61l2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Denis Lunev <den@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "jhauser@eecs.berkeley.edu" <jhauser@eecs.berkeley.edu>,
 "cota@braap.org" <cota@braap.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Andrey Shinkevich <andrey.shinkevich@virtuozzo.com> writes:

> On 13/08/2019 15:21, Alex Benn=C3=A9e wrote:
>>
>> Andrey Shinkevich <andrey.shinkevich@virtuozzo.com> writes:
>>
>>> PINGING...
>>
>> Sorry about the delay. I did attempt see if the existing code threw up
>> any errors when built with clang's undefined sanitizer. I think this is
>> because xPtr->exp will only get read if none of the xPtr->isFOO returns
>> false. In all those cases xPtr->exp is set.
>>
>> What pointed you towards this missing initialisations?
>>
>
> I am sorry about missing the message. It appeared in other email thread
> where I didn't expect. So, I missed the response.
> When I ran the fp-tests under the Valgrind, I got lots of reports about
> using uninitialized memory. They all disappeared after applying this
> patch. I concluded that there are paths that use xPtr->exp uninitialized.
>
> $ /usr/bin/valgrind --leak-check=3Dno --trace-children=3Dyes
> --keep-stacktraces=3Dalloc-and-free --track-origins=3Dyes
> --log-file=3Dmyqemu-%p.log make check-softfloat

It would be useful to know what tests are being run (V=3D1 will show you).
I can't replicate the failure with:

  valgrind --leak-check=3Dno --trace-children=3Dyes --keep-stacktraces=3Dal=
loc-and-free --track-origins=3Dyes ./fp-test -s -l 2 -r all  f16_to_f32 f16=
_to_f64 f16_to_f128 f32_to_f16 f32_to_f64

>
> =3D=3D720268=3D=3D Conditional jump or move depends on uninitialised valu=
e(s)
> =3D=3D720268=3D=3D    at 0x112C72: floatXRoundToInt (slowfloat.c:1371)
> =3D=3D720268=3D=3D    by 0x115920: slow_f16_roundToInt (slowfloat.c:2408)
> =3D=3D720268=3D=3D    by 0x133A87: test_az_f16_rx (test_az_f16_rx.c:73)
> =3D=3D720268=3D=3D    by 0x10E635: do_testfloat (fp-test.c:304)
> =3D=3D720268=3D=3D    by 0x10FD02: run_test (fp-test.c:1003)
> =3D=3D720268=3D=3D    by 0x10FDA4: main (fp-test.c:1017)
> =3D=3D720268=3D=3D  Uninitialised value was created by a stack allocation
> =3D=3D720268=3D=3D    at 0x1158D3: slow_f16_roundToInt (slowfloat.c:2404)
>
> =3D=3D720311=3D=3D Conditional jump or move depends on uninitialised valu=
e(s)
> =3D=3D720311=3D=3D    at 0x112E54: floatXAdd (slowfloat.c:1411)
> =3D=3D720311=3D=3D    by 0x115A2D: slow_f16_sub (slowfloat.c:2431)
> =3D=3D720311=3D=3D    by 0x133CEC: test_abz_f16 (test_abz_f16.c:70)
> =3D=3D720311=3D=3D    by 0x10E6D5: do_testfloat (fp-test.c:326)
> =3D=3D720311=3D=3D    by 0x10FD02: run_test (fp-test.c:1003)
> =3D=3D720311=3D=3D    by 0x10FDA4: main (fp-test.c:1017)
> =3D=3D720311=3D=3D  Uninitialised value was created by a stack allocation
> =3D=3D720311=3D=3D    at 0x1159C0: slow_f16_sub (slowfloat.c:2425)
>
> =3D=3D720273=3D=3D Conditional jump or move depends on uninitialised valu=
e(s)
> =3D=3D720273=3D=3D    at 0x113D54: floatXEq (slowfloat.c:1661)
> =3D=3D720273=3D=3D    by 0x115EAD: slow_f16_eq_signaling (slowfloat.c:253=
8)
> =3D=3D720273=3D=3D    by 0x1341D3: test_ab_f16_z_bool (test_ab_f16_z_bool=
.c:71)
> =3D=3D720273=3D=3D    by 0x10E7DE: do_testfloat (fp-test.c:358)
> =3D=3D720273=3D=3D    by 0x10FD02: run_test (fp-test.c:1003)
> =3D=3D720273=3D=3D    by 0x10FDA4: main (fp-test.c:1017)
> =3D=3D720273=3D=3D  Uninitialised value was created by a stack allocation
> =3D=3D720273=3D=3D    at 0x115E38: slow_f16_eq_signaling (slowfloat.c:253=
0)
>
> Even if Valgrind is wrong, the purpose of the patch is to reduce the
> number of error reports from the Valgrind to locate other memory serious
> issues, if any.
>
> Andrey
>
>>>
>>> On 30/07/2019 13:13, Andrey Shinkevich wrote:
>>>> Not all the paths in the functions, such as f16ToFloatX(), initialize
>>>> the member 'exp' of the structure floatX.
>>>>
>>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>>> ---
>>>>    source/slowfloat.c | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/tests/fp/berkeley-testfloat-3/source/slowfloat.c b/tests/=
fp/berkeley-testfloat-3/source/slowfloat.c
>>>> index 4e84656..6e0f0a6 100644
>>>> --- a/tests/fp/berkeley-testfloat-3/source/slowfloat.c
>>>> +++ b/tests/fp/berkeley-testfloat-3/source/slowfloat.c
>>>> @@ -623,6 +623,7 @@ static void f16ToFloatX( float16_t a, struct float=
X *xPtr )
>>>>        xPtr->isInf =3D false;
>>>>        xPtr->isZero =3D false;
>>>>        xPtr->sign =3D ((uiA & 0x8000) !=3D 0);
>>>> +    xPtr->exp =3D 0;
>>>>        exp =3D uiA>>10 & 0x1F;
>>>>        sig64 =3D uiA & 0x03FF;
>>>>        sig64 <<=3D 45;
>>>> @@ -759,6 +760,7 @@ static void f32ToFloatX( float32_t a, struct float=
X *xPtr )
>>>>        xPtr->isInf =3D false;
>>>>        xPtr->isZero =3D false;
>>>>        xPtr->sign =3D ((uiA & 0x80000000) !=3D 0);
>>>> +    xPtr->exp =3D 0;
>>>>        exp =3D uiA>>23 & 0xFF;
>>>>        sig64 =3D uiA & 0x007FFFFF;
>>>>        sig64 <<=3D 32;
>>>> @@ -895,6 +897,7 @@ static void f64ToFloatX( float64_t a, struct float=
X *xPtr )
>>>>        xPtr->isInf =3D false;
>>>>        xPtr->isZero =3D false;
>>>>        xPtr->sign =3D ((uiA & UINT64_C( 0x8000000000000000 )) !=3D 0);
>>>> +    xPtr->exp =3D 0;
>>>>        exp =3D uiA>>52 & 0x7FF;
>>>>        sig64 =3D uiA & UINT64_C( 0x000FFFFFFFFFFFFF );
>>>>        if ( exp =3D=3D 0x7FF ) {
>>>> @@ -1220,6 +1223,7 @@ static void f128MToFloatX( const float128_t *aPt=
r, struct floatX *xPtr )
>>>>        xPtr->isZero =3D false;
>>>>        uiA64 =3D uiAPtr->v64;
>>>>        xPtr->sign =3D ((uiA64 & UINT64_C( 0x8000000000000000 )) !=3D 0=
);
>>>> +    xPtr->exp =3D 0;
>>>>        exp =3D uiA64>>48 & 0x7FFF;
>>>>        sig.v64 =3D uiA64 & UINT64_C( 0x0000FFFFFFFFFFFF );
>>>>        sig.v0  =3D uiAPtr->v0;
>>>>
>>
>>
>> --
>> Alex Benn=C3=A9e
>>


--
Alex Benn=C3=A9e

