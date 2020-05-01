Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2464AC4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 02:01:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EA4B2073E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 02:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxKzBoeM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA4B2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUKz6-0000o5-H7
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 22:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <programmingkidx@gmail.com>) id 1jUKxm-0008R8-Gv
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 21:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <programmingkidx@gmail.com>) id 1jUKxl-0007oe-Cw
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 21:59:38 -0400
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e]:37504)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <programmingkidx@gmail.com>)
 id 1jUKxk-0007e2-St; Thu, 30 Apr 2020 21:59:36 -0400
Received: by mail-qv1-xf2e.google.com with SMTP id y19so4167640qvv.4;
 Thu, 30 Apr 2020 18:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=mTsfa5Ja2VbAdGKmOV1URdfdZt3Cw1qxXqDWjvkogEk=;
 b=CxKzBoeMsYhBRaPBHXtwZyxkUiD6cPlXSN0EqpH+dNS4fH+0guEN0YvEE6muYiJjjB
 mWt+V1ejiGxeE4nXiNJkrsids7XmnPgs9n/ERancY7XQva1kduvGR7fq26BFxvi+nAsr
 aO8jp+1j7yxCpwAERBtSFj8qhC+1ZWSSvQJ8hXMsTdn68gM93kz5o1tKa/0KNSZqcDzn
 TumZaIElhTu+uUI8g0cHbWwIF/d1AwF5dXGeVM2l66+kXugwxKnpRtba5fUCgCR9S1VR
 wpGinX9kSu+QS/WGy1K6XGm+RJvxUHtbwNA2SNRA0Y1olhKqnFOqvWXgDHGn+pX+dxqU
 18lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=mTsfa5Ja2VbAdGKmOV1URdfdZt3Cw1qxXqDWjvkogEk=;
 b=F1Hgj1B3iAyq3VVIlGF1VNb0IiB+8mNZ+YSBCNLDfQsWpBnD2iFRH7WkT6gK2+tEy+
 9ag/+8ZhhfsEzc2gsIFYE12lqsbVGlgwtitI24kB3TWQ4rbdd+aGRN28/iAlOiom2mDq
 8P7EvktjEWIklGDFe4WosQnTE1TwChF5mVVmdQ15ZZABrt0CwSR6WVwO+fh+D1uPYZpB
 W1g+Z6GfLnhyNxxxcojq/H5jdgpdBN9AdurNLEciHFMeE9adVHbAfd12UnBnQfhOQ3Jv
 +WzG6Xg0O3ei5LYk21M/+P8PlCpa5bR/36fGsmvRov8ICgfRSGQNZqxBWvAOWJJTrtvt
 SVyg==
X-Gm-Message-State: AGi0PuaE774Pd+UEHzdl+xFzHcW04nrgFzZPw+VFze3egzhuBcCeu+8Q
 X2U3TijD/5uNZ6jU+0PyUEU=
X-Google-Smtp-Source: APiQypKQjLnEHNanSmcZ6O/gYtEwWbak0rr24gNSa7p5Tp9tIr1O23h9L8Uq2hNhSM9Y4Lps2iEFxw==
X-Received: by 2002:a05:6214:287:: with SMTP id
 l7mr1952237qvv.38.1588298371107; 
 Thu, 30 Apr 2020 18:59:31 -0700 (PDT)
Received: from [192.168.0.6] (d149-67-30-58.try.wideopenwest.com.
 [67.149.58.30])
 by smtp.gmail.com with ESMTPSA id h23sm1676689qkk.90.2020.04.30.18.59.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 30 Apr 2020 18:59:30 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: About hardfloat in ppc
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <AM4PR07MB3506C091776962655FCE11E9CAAA0@AM4PR07MB3506.eurprd07.prod.outlook.com>
Date: Thu, 30 Apr 2020 21:59:27 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <FEA0FBA9-F5B7-4995-A2F3-5D8053637379@gmail.com>
References: <CAE2XoE-ZSgtceSe5wYDm3cXf8+hTvJhD5PqZSrrFW5625LcSWg@mail.gmail.com>
 <87lfmhl0xa.fsf@linaro.org>
 <alpine.BSF.2.22.395.2004271212520.94232@zero.eik.bme.hu>
 <87imhlkwun.fsf@linaro.org>
 <CAE2XoE9hiw-ri66_xp3qNa5_Wx8ZfsQB9mqJdYR8VRm-KW830g@mail.gmail.com>
 <87ftcoknvu.fsf@linaro.org>
 <AM4PR07MB350653D5961DFCE441646131CAAD0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <871ro6ld2f.fsf@linaro.org>
 <AM4PR07MB350673696C7DE2CA16C9C685CAAD0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <87sggmjgit.fsf@linaro.org>
 <CAE2XoE8wFK1nOq3YXhB=iqTvqSDQk7Zzd35Tjzdd==v8ouMijA@mail.gmail.com>
 <43ac337c-752a-7151-1e88-de01949571de@linaro.org>
 <CAE2XoE-f_rkcnpQO1cHPUgdaWNAOvBRyUX1aj27UePd0Hkr=KQ@mail.gmail.com>
 <alpine.BSF.2.22.395.2004301721420.29315@zero.eik.bme.hu>
 <AM4PR07MB3506C091776962655FCE11E9CAAA0@AM4PR07MB3506.eurprd07.prod.outlook.com>
To: Dino Papararo <skizzato73@msn.com>
X-Mailer: Apple Mail (2.3273)
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=programmingkidx@gmail.com; helo=mail-qv1-xf2e.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::f2e
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?utf-8?B?Iue9l+WLh+WImihZb25nZ2FuZyBMdW8pIg==?= <luoyonggang@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> On Apr 30, 2020, at 12:34 PM, Dino Papararo <skizzato73@msn.com> =
wrote:
>=20
> Maybe the fastest way to implement hardfloats for ppc could be run =
them by default and until some fpu instruction request for FPSCR =
register.
> At this time probably we want to check for some exception.. so QEMU =
could come back to last fpu instruction executed and re-execute it in =
softfloat taking care this time of FPSCR flags, then continue in =
hardfloats unitl another instruction looking for FPSCR register and so =
on..
>=20
> Dino

That sounds like a good idea.

> -----Messaggio originale-----
> Da: BALATON Zoltan <balaton@eik.bme.hu>=20
> Inviato: gioved=C3=AC 30 aprile 2020 17:36
> A: =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyonggang@gmail.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>; Dino Papararo =
<skizzato73@msn.com>; qemu-devel@nongnu.org; Programmingkid =
<programmingkidx@gmail.com>; qemu-ppc@nongnu.org; Howard Spoelstra =
<hsp.cat7@gmail.com>; Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Oggetto: Re: R: R: About hardfloat in ppc
>=20
> On Thu, 30 Apr 2020, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
>> I propose a new way to computing the float flags, We preserve a  =
float=20
>> computing cash typedef struct FpRecord {  uint8_t op;
>> float32 A;
>> float32 B;
>> }  FpRecord;
>> FpRecord fp_cache[1024];
>> int fp_cache_length;
>> uint32_t fp_exceptions;
>>=20
>> 1. For each new fp operation we push it to the  fp_cache, 2. Once we=20=

>> read the fp_exceptions , then we re-compute the fp_exceptions by=20
>> re-running the fp FpRecord sequence.
>> and clear  fp_cache_length.
>> 3. If we clear the fp_exceptions , then we set fp_cache_length to 0=20=

>> and clear  fp_exceptions.
>> 4. If the  fp_cache are full, then we re-compute the fp_exceptions by=20=

>> re-running the fp FpRecord sequence.
>>=20
>> Would this be a general method to use hard-float?
>> The consued time should be  2*hard_float.
>> Considerating read fp_exceptions are rare, then the amortized time=20
>> complexity would be 1 * hard_float.
>=20
> It's hard to guess what the hit rate of such cache would be and if =
it's low then managing the cache is probably more expensive than running =
with softfloat. So to evaluate any proposed patch we also need some =
benchmarks which we can experiment with to tell if the results are good =
or not otherwise we're just guessing. Are there some existing tests and =
benchmarks that we can use? Alex mentioned fp-bench I think and to =
evaluate the correctness of the FP implementation I've seen this other
> conversation:
>=20
> https://lists.nongnu.org/archive/html/qemu-devel/2020-04/msg05107.html
> https://lists.nongnu.org/archive/html/qemu-devel/2020-04/msg05126.html
>=20
> Is that something we can use for PPC as well to check the correctness?
>=20
> So I think before implementing any potential solution that came up in =
this brainstorming the first step would be to get and compile (or write =
if not
> available) some tests and benchmarks:
>=20
> 1. testing host behaviour for inexact and compare that for different =
archs 2. some FP tests that can be used to compare results with QEMU and =
real CPU to check correctness of emulation (if these check for inexact =
differences then could be used instead of 1.) 3. some benchmarks to =
evaluate QEMU performance (these could be same as FP tests or some real =
world FP heavy applications).
>=20
> Then we can see if the proposed solution is faster and still correct.
>=20
> Regards,
> BALATON Zoltan


