Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7BDC4BA12
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 15:30:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E175D21D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 15:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lpw4RXvn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E175D21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ydP-0007WE-3y
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 10:30:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ycj-0006yQ-Oq
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:29:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6yci-0004ZW-L6
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:29:21 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54603)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6yci-0004XO-FT
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:29:20 -0500
Received: by mail-wm1-x342.google.com with SMTP id z12so3532655wmi.4
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 07:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=PVViuk1sGNWcwDIOClqjjMRfFRRogPERd3vbcJBsvHk=;
 b=Lpw4RXvnLWyNKe6r+bKtKaJ4rRzY3BqjloxB4zPTj5tEKesVAQPTzMil3cACGDHDQp
 3mdxgRHfGbDSr60NKf48pw1BF6CsdNBgad8PvWulVpuD7dhHX8ujTEN4QfkNAT6T3f/D
 NHH2ICbgVY54uyroXK0kT5+7u2KRpW0cIM6U949ppARME+qnc8efKbOFCbn8CtGqBLCi
 uXcAwyavrMq5zasJIZ6kWbqBCcZmqpZp10gvaYEc21MMk6mxpKQgESNmXDn8HrSNUmdL
 rmdmPcZ0aV6RoEk7Mahtifu3+Msfp9Au2iAKEzlYMF8nBSJ8DjpJbvYZ240aKBMlc4mh
 OYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=PVViuk1sGNWcwDIOClqjjMRfFRRogPERd3vbcJBsvHk=;
 b=Mxp1KAM+LCbn5bpwLt2btv0Djz9CItt1zTPl+33EGppPHPbL/zHg88yjZ4MQmzm95z
 D5s8iDNH4/bvnIKfoRCIgl/CixXAIkt/i91hZHtdSN/nlHF6L0eIv91BIZBxVSwiDLpK
 jQ5lG5WycVvFH0X/E6pr5stm2DUB2ojbgm6QjlrSa+LUvzqNTzPuqOtmprHa3ciTCUi9
 ENtwtw8zlv2tV7ZejjCpe1UdT3gvVqMlUkozJF0CkjeQU3DbjyTeyRxw6pAyFvUC9tXq
 mXjkvvrw1647KP8349bZVagNmpPhcqTBoUbhpzvAbB4ewjwJM1RIhm4qhuRXbCrycloU
 +xSQ==
X-Gm-Message-State: APjAAAV1TRyHOQrvYzXeP9Q8L2f2EgSnfmbdzJ8mUIy86qYm/Etmoxxo
 a5gkALZmS9zBfd1Ol8jz9XX0ig==
X-Google-Smtp-Source: APXvYqyLHiu4VYe0ahCe4ZV1lL6KMndXIJc2BorrRpPisD9etgkRUNgPqeEDsce8tf/0Y+tmqtxdXg==
X-Received: by 2002:a1c:5684:: with SMTP id k126mr6266574wmb.181.1582730959166; 
 Wed, 26 Feb 2020 07:29:19 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d4sm3722529wra.14.2020.02.26.07.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 07:29:17 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 07C4F1FF87;
 Wed, 26 Feb 2020 15:29:17 +0000 (GMT)
References: <CAPan3Wq-MVwcJQELP8n+g33CR7tsiGXQ698gA177nd2my9hWCw@mail.gmail.com>
 <20200226101948.786be4b0@redhat.com>
 <CAFEAcA80K+h-nkiHrh15mmgomBaqDpdhRwb34zwKqF31dp3KDw@mail.gmail.com>
 <87k149xwqw.fsf@linaro.org> <20200226154525.5c4c0ac9@redhat.com>
User-agent: mu4e 1.3.8; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: Sudden slowdown of ARM emulation in master
In-reply-to: <20200226154525.5c4c0ac9@redhat.com>
Date: Wed, 26 Feb 2020 15:29:16 +0000
Message-ID: <87blplxt83.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Igor Mammedov <imammedo@redhat.com> writes:

> On Wed, 26 Feb 2020 14:13:11 +0000
> Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>=20
>> > On Wed, 26 Feb 2020 at 09:19, Igor Mammedov <imammedo@redhat.com> wrot=
e:=20=20
>> >>
>> >> On Wed, 26 Feb 2020 00:07:55 +0100
>> >> Niek Linnenbank <nieklinnenbank@gmail.com> wrote:
>> >>=20=20
>> >> > Hello Igor and Paolo,=20=20
>> >>
>> >> does following hack solves issue?
>> >>
>> >> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
>> >> index a08ab11f65..ab2448c5aa 100644
>> >> --- a/accel/tcg/translate-all.c
>> >> +++ b/accel/tcg/translate-all.c
>> >> @@ -944,7 +944,7 @@ static inline size_t size_code_gen_buffer(size_t =
tb_size)
>> >>          /* ??? If we relax the requirement that CONFIG_USER_ONLY use=
 the
>> >>             static buffer, we could size this on RESERVED_VA, on the =
text
>> >>             segment size of the executable, or continue to use the de=
fault.  */
>> >> -        tb_size =3D (unsigned long)(ram_size / 4);
>> >> +        tb_size =3D MAX_CODE_GEN_BUFFER_SIZE;
>> >>  #endif
>> >>      }
>> >>      if (tb_size < MIN_CODE_GEN_BUFFER_SIZE) {=20=20
>> >
>> > Cc'ing Richard to ask: does it still make sense for TCG
>> > to pick a codegen buffer size based on the guest RAM size?=20=20
>>=20
>> Arguably you would never get more than ram_size * tcg gen overhead of
>> active TBs at any one point although you can come up with pathological
>> patterns where only a subset of pages are flushed in and out at a time.
>>=20
>> However the backing for the code is mmap'ed anyway so surely the kernel
>> can work out the kinks here. We will never allocate more than the code
>> generator can generate jumps for anyway.
>>=20
>> Looking at the SoftMMU version of alloc_code_gen_buffer it looks like
>> everything now falls under the:
>>=20
>>   # if defined(__PIE__) || defined(__PIC__)
>>=20
>> leg so there is a bunch of code to be deleted there. The remaining
>> question is what to do for linux-user because there is a bit more logic
>> to deal with some corner cases on the static code generation buffer.
>>=20
>> I'd be tempted to rename DEFAULT_CODE_GEN_BUFFER_SIZE to
>> SMALL_CODE_GEN_BUFFER_SIZE and only bother with a static allocation for
>> 32 bit linux-user hosts. Otherwise why not default to
>> MAX_CODE_GEN_BUFFER_SIZE on 64 bit systems and let the kernel deal with
>> it?
>
> *-user call
>   tcg_exec_init(0);
> which in in the end results in
>   DEFAULT_CODE_GEN_BUFFER_SIZE -> DEFAULT_CODE_GEN_BUFFER_SIZE_1
>
> so for *-user cases we can just always call
>    code_gen_alloc(DEFAULT_CODE_GEN_BUFFER_SIZE)
<snip>

I've gone for a variation of that, coming to a mailing list near you
real soon now ;-)

--=20
Alex Benn=C3=A9e

