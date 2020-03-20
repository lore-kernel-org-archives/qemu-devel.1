Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37D5C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:22:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B6AA20709
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wf8fc8L+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6AA20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFLLc-00038m-QN
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 13:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jFLKz-0002Wm-Fk
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:21:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jFLKy-0007nd-5W
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:21:37 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34614)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jFLKx-0007mb-Uv
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:21:36 -0400
Received: by mail-wr1-x441.google.com with SMTP id z15so8482066wrl.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 10:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=hzpLOqUSNBopjv0pKzF+fI66qNOFTJFKxWO4BRQyU8U=;
 b=Wf8fc8L+iEzJPfg36lQ0opvLxbWDrXP4/DHPDuGMw6ErwOaYE/ruyV34p1CN4naECm
 DZ4tu/od1nLx0Km9RXXjRZJ42qmidjYa7zkQ9CkJnJUzwT0WAyllbif8Mbqi4j5zRGgm
 2UzuELxT/tUvq3AEwINbWmGPwLaQXHMkP5Qc+2skjglb9hciwMaBjYaV9aO6yFeU/BuX
 jqVtjSJZOOcB01K+KA/jVA/aKTMicgiMShUteQb83CKDiHjHN1JL1pp2UPWDK31o50EG
 RWlhB3DPRdfp37+CZY5OYScQBOG2N5i3jJBdLSzRQpYHHjAZBbZ9ktlhCr9qqdknubf5
 i8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=hzpLOqUSNBopjv0pKzF+fI66qNOFTJFKxWO4BRQyU8U=;
 b=F6AEArEG433OkFmDrSDeaPcyRFHqwWu2U97U4J5idywu79iDPxf5wCPQpT/hYKoURY
 ybR7TrC29TVn8rGa48MW0rOu40BHlr8I0EaxZq+HDfB7FNay9LfEGv1RNg1epulQxx91
 n3XQudmlyywQfraR83OiZR/SkWGwyF2gCqj+IFXEy1g1aRQpG6XB2Ehz1o5EpZw8X1zN
 xDAilFGWNTRb9oQAADppP4m9AHQcw/+3G7s7o/iZKQd3eWtNga9Bw2wRp3blBOh7utwr
 GtRuJpEASbzoj+MN/6/0JGmlFoZqmBV+jTfFDZU0ImX2yilH4erpIwhhJGrVSLuIiLiJ
 h3uw==
X-Gm-Message-State: ANhLgQ2VYeOSC61fuUZAhVOMxZ2xwkIXnxCEm0aXTLDqbe2rFm596hKS
 oLLZvprVlOvD2sedBgkpPcgQaw==
X-Google-Smtp-Source: ADFU+vt3C0EECoFCeeysGMq6P2fg2eGPtWhWzaN62wfrE6b6jvaM82I3bCWamu+n0rGVQNIxdBpRRg==
X-Received: by 2002:a05:6000:110:: with SMTP id
 o16mr12935346wrx.296.1584724894218; 
 Fri, 20 Mar 2020 10:21:34 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b5sm9374957wrj.1.2020.03.20.10.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 10:21:32 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6C5B71FF7E;
 Fri, 20 Mar 2020 17:21:31 +0000 (GMT)
References: <20200320114522.16273-1-alex.bennee@linaro.org>
 <CAHiYmc7vOK=DD0Cb623x3PDJW_NS2H+Y79jcWT1Kujxij5Jsrg@mail.gmail.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: Re: [RFC PATCH for 5.0] configure: disable MTTCG for MIPS guests
In-reply-to: <CAHiYmc7vOK=DD0Cb623x3PDJW_NS2H+Y79jcWT1Kujxij5Jsrg@mail.gmail.com>
Date: Fri, 20 Mar 2020 17:21:31 +0000
Message-ID: <871rpnhrhg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>,
 Philippe =?utf-8?Q?Mathieu-Daud?= =?utf-8?Q?=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> writes:

> =D0=BF=D0=B5=D1=82, 20. =D0=BC=D0=B0=D1=80 2020. =D1=83 12:45 Alex Benn=
=C3=A9e <alex.bennee@linaro.org> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>>
>> While debugging check-acceptance failures I found an instability in
>> the mips64el test case. Briefly the test case:
>>
>>   retry.py -n 100 -c -- ./mips64el-softmmu/qemu-system-mips64el \
>>     -display none -vga none -serial mon:stdio \
>>     -machine malta -kernel ./vmlinux-4.7.0-rc1.I6400 \
>>     -cpu I6400 -smp 8 -vga std \
>>     -append "printk.time=3D0 clocksource=3DGIC console=3Dtty0 console=3D=
ttyS0 panic=3D-1" \
>>     --no-reboot
>>
>
> Thank for the findings!
>
> Could you perhaps attach or link to "retry.py"?

Sure - it's just a noddy python script which I use for repeated testing:

  https://github.com/stsquad/retry

> Did you run this particular test for the first time now, or it used to
> pass before?

I only noticed it since it was added to check-acceptance and has been
flakey since added I think.

>
> Thanks,
> Aleksandar
>
>> Reports about a 9% failure rate:
>>
>>   Results summary:
>>   0: 91 times (91.00%), avg time 5.547 (0.45 varience/0.67 deviation)
>>   -6: 9 times (9.00%), avg time 3.394 (0.02 varience/0.13 deviation)
>>   Ran command 100 times, 91 passes
>>
>> When re-run with "--accel tcg,thread=3Dsingle" the instability goes
>> away.
>>
>>   Results summary:
>>   0: 100 times (100.00%), avg time 17.318 (249.76 varience/15.80 deviati=
on)
>>   Ran command 100 times, 100 passes
>>
>> Which seems to indicate there is some aspect of the MIPS MTTCG fixes
>> that has been missed. Ideally we would fix that but I'm afraid I don't
>> have time to investigate and am not super familiar with the
>> architecture anyway.
>>
>> I've disabled all the mips guests as I assume it's a fundamental
>> synchronisation primitive that is broken but I haven't tested them all
>> (there are a lot!).
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>> Cc: Aurelien Jarno <aurelien@aurel32.net>
>> Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>  configure | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/configure b/configure
>> index 206d22c5153..002792d21dc 100755
>> --- a/configure
>> +++ b/configure
>> @@ -7832,19 +7832,19 @@ case "$target_name" in
>>      echo "TARGET_ABI32=3Dy" >> $config_target_mak
>>    ;;
>>    mips|mipsel)
>> -    mttcg=3D"yes"
>> +    mttcg=3D"no"
>>      TARGET_ARCH=3Dmips
>>      echo "TARGET_ABI_MIPSO32=3Dy" >> $config_target_mak
>>    ;;
>>    mipsn32|mipsn32el)
>> -    mttcg=3D"yes"
>> +    mttcg=3D"no"
>>      TARGET_ARCH=3Dmips64
>>      TARGET_BASE_ARCH=3Dmips
>>      echo "TARGET_ABI_MIPSN32=3Dy" >> $config_target_mak
>>      echo "TARGET_ABI32=3Dy" >> $config_target_mak
>>    ;;
>>    mips64|mips64el)
>> -    mttcg=3D"yes"
>> +    mttcg=3D"no"
>>      TARGET_ARCH=3Dmips64
>>      TARGET_BASE_ARCH=3Dmips
>>      echo "TARGET_ABI_MIPSN64=3Dy" >> $config_target_mak
>> --
>> 2.20.1
>>


--=20
Alex Benn=C3=A9e

