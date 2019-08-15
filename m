Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01098C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 15:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFC2120665
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 15:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fewraTod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC2120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyI1X-0003dA-L6
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 11:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1hyI0W-0002ic-5k
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 11:49:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hyI0S-0005ed-Rw
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 11:49:43 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37000)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hyI0S-0005eP-Iw
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 11:49:40 -0400
Received: by mail-wm1-x342.google.com with SMTP id z23so1655329wmf.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 08:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=kAcsRGp19GHmWwtwmf9lkSCYRgJI/U1CoUufy6uOgYk=;
 b=fewraTodSNckaSSFddi+V1++sD/uN6zLi63Yb4qav4V4XbG/CZLKNRc3oxLzKTP0Ak
 qjPoO+/zL48orM5rrU/tqjIhTIDkXSeOg1rF7zGBd/RR6GW1exdHlqrzE1QbpuyyPZtq
 9htopwSXWkPOndiobBAfC1b7aI+Ewha9IcIob2xFyc2WWkm0y/EPH9t9pJgwk4S0MzSx
 VBMZBdKMIYKlrIL51XM7U52lkwB4ZvBtmnc2LVWTjp9FObF103jcCcwqInewRQ0P5YYL
 93ft7dRj59RHnk6wEZgTO1Tgq8E7T765lmQXSFmYiBhIYQvnkt/EaUFK2DBC6U5NtTA8
 9n5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=kAcsRGp19GHmWwtwmf9lkSCYRgJI/U1CoUufy6uOgYk=;
 b=Ql9PdVb2S601iqMJxKYh5KumydGUcvz1ffqZ02vETfRU5tdEf7hpHt4bY0fek89lqe
 8MC9Rj2p60kD3Xh04rSgV2pX6qFsZi+LIR1F0lmkvIQ9t77G0ITpUf0AaU7+/+UKHnLq
 5trjzeYWVpT4o1izsDSgUfCwr4PtokwBPgux5hR4TVMj0Irxya6fO7jeguiPUCC9XM4a
 B5SOPXd7/FTwmbpI7Jp5xza73nyWqmV1TSJY+fHFq2w7TEtYns88I4aV4WKUfkUbWvaC
 aVJfoiS/DGmq9HHjSSWvGC9pXlrXYyOb8Dd3BmbjXOL8h4cQCkD+RJxgPvEC00jvLDGA
 csow==
X-Gm-Message-State: APjAAAXGLq5syIa3KDa45w8Q/JlwwQJ8gTek0GnABcPtw/jyXxWUCip9
 XeKRnqw2pFNKGre5Kj9CmTvdRg==
X-Google-Smtp-Source: APXvYqzl1UHJ5+QjPyIcbxEGjhoMHXEb0KxaungiZ9jRTvxWTZq5oCg3C4bE20bXhCqFVl6gS9ItOA==
X-Received: by 2002:a7b:c453:: with SMTP id l19mr3320711wmi.106.1565884179136; 
 Thu, 15 Aug 2019 08:49:39 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id q18sm4420246wrw.36.2019.08.15.08.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2019 08:49:38 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CA91F1FF87;
 Thu, 15 Aug 2019 16:49:37 +0100 (BST)
References: <20190813124946.25322-1-alex.bennee@linaro.org>
 <20190813124946.25322-5-alex.bennee@linaro.org>
 <CAL1e-=g4Cxd74r3NyShEPpFEqx2JoT2x75zLeUXejgVgtVjSHA@mail.gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
In-reply-to: <CAL1e-=g4Cxd74r3NyShEPpFEqx2JoT2x75zLeUXejgVgtVjSHA@mail.gmail.com>
Date: Thu, 15 Aug 2019 16:49:37 +0100
Message-ID: <87mugamnse.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v3 04/13] fpu: use min/max values from
 stdint.h for integral overflow
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
Cc: Peter Maydell <peter.maydell@linaro.org>, armbru@redhat.com,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aleksandar Markovic <aleksandar.m.mail@gmail.com> writes:

> 13.08.2019. 14.52, "Alex Benn=C3=A9e" <alex.bennee@linaro.org> =D1=98=D0=
=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>>
>> Remove some more use of LIT64 while making the meaning more clear. We
>> also avoid the need of casts as the results by definition fit into the
>> return type.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  fpu/softfloat.c | 30 ++++++++++++++----------------
>>  1 file changed, 14 insertions(+), 16 deletions(-)
>>
>> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
>> index 9e57b7b5933..a1e1e9a8559 100644
>> --- a/fpu/softfloat.c
>> +++ b/fpu/softfloat.c
>> @@ -3444,9 +3444,7 @@ static int64_t roundAndPackInt64(flag zSign,
> uint64_t absZ0, uint64_t absZ1,
>>      if ( z && ( ( z < 0 ) ^ zSign ) ) {
>>   overflow:
>>          float_raise(float_flag_invalid, status);
>> -        return
>> -              zSign ? (int64_t) LIT64( 0x8000000000000000 )
>> -            : LIT64( 0x7FFFFFFFFFFFFFFF );
>> +        return zSign ? INT64_MIN : INT64_MAX;
>>      }
>
> In function roundAndPavkInt32 tgere is a following segment:
>
>     if ( ( absZ>>32 ) || ( z && ( ( z < 0 ) ^ zSign ) ) ) {
>         float_raise(float_flag_invalid, status);
>         return zSign ? (int32_t) 0x80000000 : 0x7FFFFFFF;
>     }
>
> Perhaps replace these constants with INT32_MIN, INT32_MAX, for similar
> reasons, in the same or a separate patch?

Yeah that was missed seeing as I picked up one of the INT32 cases later on.

>
> Aleksandar
>
>
>>      if (absZ1) {
>>          status->float_exception_flags |=3D float_flag_inexact;
>> @@ -3497,7 +3495,7 @@ static int64_t roundAndPackUint64(flag zSign,
> uint64_t absZ0,
>>          ++absZ0;
>>          if (absZ0 =3D=3D 0) {
>>              float_raise(float_flag_invalid, status);
>> -            return LIT64(0xFFFFFFFFFFFFFFFF);
>> +            return UINT64_MAX;
>>          }
>>          absZ0 &=3D ~(((uint64_t)(absZ1<<1) =3D=3D 0) & roundNearestEven=
);
>>      }
>> @@ -5518,9 +5516,9 @@ int64_t floatx80_to_int64(floatx80 a, float_status
> *status)
>>          if ( shiftCount ) {
>>              float_raise(float_flag_invalid, status);
>>              if (!aSign || floatx80_is_any_nan(a)) {
>> -                return LIT64( 0x7FFFFFFFFFFFFFFF );
>> +                return INT64_MAX;
>>              }
>> -            return (int64_t) LIT64( 0x8000000000000000 );
>> +            return INT64_MIN;
>>          }
>>          aSigExtra =3D 0;
>>      }
>> @@ -5561,10 +5559,10 @@ int64_t floatx80_to_int64_round_to_zero(floatx80
> a, float_status *status)
>>          if ( ( a.high !=3D 0xC03E ) || aSig ) {
>>              float_raise(float_flag_invalid, status);
>>              if ( ! aSign || ( ( aExp =3D=3D 0x7FFF ) && aSig ) ) {
>> -                return LIT64( 0x7FFFFFFFFFFFFFFF );
>> +                return INT64_MAX;
>>              }
>>          }
>> -        return (int64_t) LIT64( 0x8000000000000000 );
>> +        return INT64_MIN;
>>      }
>>      else if ( aExp < 0x3FFF ) {
>>          if (aExp | aSig) {
>> @@ -6623,7 +6621,7 @@ int32_t float128_to_int32_round_to_zero(float128 a,
> float_status *status)
>>      if ( ( z < 0 ) ^ aSign ) {
>>   invalid:
>>          float_raise(float_flag_invalid, status);
>> -        return aSign ? (int32_t) 0x80000000 : 0x7FFFFFFF;
>> +        return aSign ? INT32_MIN : INT32_MAX;
>>      }
>>      if ( ( aSig0<<shiftCount ) !=3D savedASig ) {
>>          status->float_exception_flags |=3D float_flag_inexact;
>> @@ -6662,9 +6660,9 @@ int64_t float128_to_int64(float128 a, float_status
> *status)
>>                        && ( aSig1 || ( aSig0 !=3D LIT64( 0x0001000000000=
000
> ) ) )
>>                      )
>>                 ) {
>> -                return LIT64( 0x7FFFFFFFFFFFFFFF );
>> +                return INT64_MAX;
>>              }
>> -            return (int64_t) LIT64( 0x8000000000000000 );
>> +            return INT64_MIN;
>>          }
>>          shortShift128Left( aSig0, aSig1, - shiftCount, &aSig0, &aSig1 );
>>      }
>> @@ -6710,10 +6708,10 @@ int64_t float128_to_int64_round_to_zero(float128
> a, float_status *status)
>>              else {
>>                  float_raise(float_flag_invalid, status);
>>                  if ( ! aSign || ( ( aExp =3D=3D 0x7FFF ) && ( aSig0 | a=
Sig1
> ) ) ) {
>> -                    return LIT64( 0x7FFFFFFFFFFFFFFF );
>> +                    return INT64_MAX;
>>                  }
>>              }
>> -            return (int64_t) LIT64( 0x8000000000000000 );
>> +            return INT64_MIN;
>>          }
>>          z =3D ( aSig0<<shiftCount ) | ( aSig1>>( ( - shiftCount ) & 63 =
) );
>>          if ( (uint64_t) ( aSig1<<shiftCount ) ) {
>> @@ -6764,19 +6762,19 @@ uint64_t float128_to_uint64(float128 a,
> float_status *status)
>>      if (aSign && (aExp > 0x3FFE)) {
>>          float_raise(float_flag_invalid, status);
>>          if (float128_is_any_nan(a)) {
>> -            return LIT64(0xFFFFFFFFFFFFFFFF);
>> +            return UINT64_MAX;
>>          } else {
>>              return 0;
>>          }
>>      }
>>      if (aExp) {
>> -        aSig0 |=3D LIT64(0x0001000000000000);
>> +        aSig0 |=3D UINT64_C(0x0001000000000000);
>>      }
>>      shiftCount =3D 0x402F - aExp;
>>      if (shiftCount <=3D 0) {
>>          if (0x403E < aExp) {
>>              float_raise(float_flag_invalid, status);
>> -            return LIT64(0xFFFFFFFFFFFFFFFF);
>> +            return UINT64_MAX;
>>          }
>>          shortShift128Left(aSig0, aSig1, -shiftCount, &aSig0, &aSig1);
>>      } else {
>> --
>> 2.20.1
>>
>>


--
Alex Benn=C3=A9e

