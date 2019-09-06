Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092F5C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 13:18:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9936206BB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 13:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CjOWjawg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9936206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6E80-0001ls-1n
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 09:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i6E6M-0000qi-9i
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 09:16:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i6E6H-0001lm-M8
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 09:16:31 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55366)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i6E6H-0001g0-8y
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 09:16:29 -0400
Received: by mail-wm1-x344.google.com with SMTP id g207so6466281wmg.5
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 06:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=hbaExxadqMYBHdluaOpKu9JfRoq9G1pOGEiAk/nTcIM=;
 b=CjOWjawgeztgRgZPbZPpx63Vb8CrLvO9hVy9i7sbV5mkl37pJt8YyLpmh9St6wYE/A
 KMHSF2/ytxGvmqwFI3g5O5iMB1pk92W+DnXCbUZRPLsdL1gutCsmBAW9GJ88rpooSJnR
 epAklUbwD1en8DVxqz6ssxS7I2YxkCeWENJ3ool+dVVZHW7c+QrIvSIQCWD3YEwP7FA/
 iiEdVkIddblqmr/NU1Hw/xjoMMqCeFUJDqRZql21/eACNKzSICxUdzmIbYHohOeSr84E
 eZr0AWlZ/doMpAr4+Jt3nRrQTj7Pfocn6ODJbU7+P1FVVcU57ItX1phmlMZdULAkU5MN
 G69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=hbaExxadqMYBHdluaOpKu9JfRoq9G1pOGEiAk/nTcIM=;
 b=Mdb3kfylIhvfwt5NQ8iYSJPRwQryhRmb3MK77Yex7Lxbx/KZa6MRIHYN1VPeDowE3I
 ZRWU00lN7PQnX5QVCdOIpTUYseZUD6nfyYWNQJmewKvlXIi2ZZyenyzJVuym7cI2eGep
 r/Ypdhp7fljQKCPjZtXhsyFZT8MKAJS0SEx2uLT9/6HjqzDFJemGcabrHsG+hwJXZlP4
 ikmIjZkkSd9f58FG28O6ysusPEWqf16ys79Z4VVre2TUIoNr5TCmYfXJgX0QXeoY78tm
 droqQZVvkZozK4ZhvTVb83yXpuiL+DRyHHEZKXGTUvsh6baxzjLC8rwEWeLWlnYNeHXB
 ilUg==
X-Gm-Message-State: APjAAAUoNO+B8NAdf7aykfyT1FseTP11KgdLZGJJ1BcHGBSG5zSrIvkw
 A7SW9BNqlOqSmaMJk5QBjKOIGA==
X-Google-Smtp-Source: APXvYqz3KrZG03LObFxee/SLCEcMOCvwYUKHBl+s7XFdAKlotXr7ozUh7KkrnC/F9sB7Rwm8gPrb7w==
X-Received: by 2002:a1c:7d8e:: with SMTP id y136mr7055212wmc.83.1567775786003; 
 Fri, 06 Sep 2019 06:16:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i9sm1882843wmf.14.2019.09.06.06.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2019 06:16:25 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BE0911FF87;
 Fri,  6 Sep 2019 14:16:24 +0100 (BST)
References: <20190906124706.19145-1-alex.bennee@linaro.org>
 <20190906124706.19145-3-alex.bennee@linaro.org>
 <CAFEAcA84VXqw+ZGP9Nv=Wy069ZU_C0WkVdv0h28GVbnzyx6w6w@mail.gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <CAFEAcA84VXqw+ZGP9Nv=Wy069ZU_C0WkVdv0h28GVbnzyx6w6w@mail.gmail.com>
Date: Fri, 06 Sep 2019 14:16:24 +0100
Message-ID: <87a7bhzhsn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v3 2/4] target/arm: handle A-profile
 semihosting at translate time
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 6 Sep 2019 at 13:47, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> As for the other semihosting calls we can resolve this at translate
>> time.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>> ---
>> v2
>>   - update for change to gen_exception_internal_insn API
>> v3
>>   - update for decode tree, merge T32 & A32 commits
>>   - dropped r-b due to changes
>> ---
>>  target/arm/translate.c | 19 +++++++++++++++----
>>  1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/arm/translate.c b/target/arm/translate.c
>> index 4cda7812bcb..ed4a97cfb44 100644
>> --- a/target/arm/translate.c
>> +++ b/target/arm/translate.c
>> @@ -10222,14 +10222,25 @@ static bool trans_CBZ(DisasContext *s, arg_CBZ=
 *a)
>>  }
>>
>>  /*
>> - * Supervisor call
>> + * Supervisor call - both T32 & A32 come here so we need to check
>> + * which mode we are in when checking for semihosting.
>>   */
>>
>>  static bool trans_SVC(DisasContext *s, arg_SVC *a)
>>  {
>> -    gen_set_pc_im(s, s->base.pc_next);
>> -    s->svc_imm =3D a->imm;
>> -    s->base.is_jmp =3D DISAS_SWI;
>> +    const uint32_t semihost_imm =3D s->thumb ? 0xab : 0x123456;
>> +
>> +    if (semihosting_enabled() &&
>> +#ifndef CONFIG_USER_ONLY
>> +        s->current_el !=3D 0 &&
>> +#endif
>> +        (a->imm =3D=3D semihost_imm)) {
>> +        gen_exception_internal_insn(s, s->base.pc_next, EXCP_SEMIHOST);
>> +    } else {
>> +        gen_set_pc_im(s, s->base.pc_next);
>> +        s->svc_imm =3D a->imm;
>> +        s->base.is_jmp =3D DISAS_SWI;
>> +    }
>>      return true;
>>  }
>
> Doesn't this accidentally enable semihosting via SVC for
> M-profile ?

We must have done that before then. Just gate it with &&
!arm_dc_feature(s, ARM_FEATURE_M) then?

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e

