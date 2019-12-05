Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03203C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:32:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6A4722525
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UiAC6+UU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A4722525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icuzo-0000XD-Vs
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 12:32:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icuyr-0008RS-JU
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:31:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icuyq-0000eq-7L
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:31:57 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39200)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icuyp-0000a0-QW
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:31:56 -0500
Received: by mail-wr1-x444.google.com with SMTP id y11so4625491wrt.6
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 09:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=mPR+RnI5ndaYekc/cM5S/YEFXT8srJA+hLrqRZ+HoYE=;
 b=UiAC6+UU0tvF06T6R+TJWNwzBwI1dT+NTdJvlNtacAeXOMXf1X+Ke3oEfnw/E+BBtl
 fRgYzEhNcZ4IIF7RKAhMWHIavbnWfi9uaj+MgRAjItHl9Sk2pWb7KGnfthtXBj4pzvgQ
 p+4ZDcmxI24/g723GlucsIKsU1l/h/dcScKsVJGxNgD7uN5dBMpmr1NguvHHvmPN8u+s
 q4gYho4fTR6pQyflHOZXcQ2bRKQava6AMNDZBpVTESnu9EshFtNDeGiz6m9A+U2DfSsg
 hOuKy+sdPSOle03MsMrUVvCQe72RpyCunXP2G6FDbOnw+9fhNBzg5MR+LrSI1/4DS/Hz
 1Q6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=mPR+RnI5ndaYekc/cM5S/YEFXT8srJA+hLrqRZ+HoYE=;
 b=AUBDoLa/CESStfP78N7NxpaAK5FZNAzrzxYhyD4k/KDuNyybDJHWzoG6fYNWwvDin5
 ONALgq4FaYPjdS57JfLcUvqeDIEPmvh+encOqAv3UnsE94L+vJZ5hk9lcStJ3G2B7yKR
 Wtl3vee1S8xFdTwVcV1Rq+O7xCHpb0roHtjBeodXNXR16O8jZGhUsofNa8rTCgV1AJiI
 GhJ80Aon7DbgfrksKeJ0tAgKxvfCxqYWe8sjhj6EjxsdpS21YH8S09VjCB06vumV0WPd
 RQU5WS8Pn2FjnTzvbkGv81jXM/Nf2UScx/EGh9kFg+cvjjRwGRJR9VGeGWl9z5psv0SD
 M5cw==
X-Gm-Message-State: APjAAAV86woNLrUacQeaa44EECwjqA3MWJdX6/xqWBAYyQEY0sv69cvD
 pR1xemsLHckfODJpWEdOTGdsHw==
X-Google-Smtp-Source: APXvYqz3IVXeR/QTDnfjchFAFmxWU7P0m4RwRTQ9x0iiI2pZCIQMZN1kXq8Jmrel9N1V7Mmm+VpGyw==
X-Received: by 2002:a05:6000:1044:: with SMTP id
 c4mr11767622wrx.204.1575567114457; 
 Thu, 05 Dec 2019 09:31:54 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y10sm515562wmm.3.2019.12.05.09.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2019 09:31:53 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5EE511FF87;
 Thu,  5 Dec 2019 17:31:52 +0000 (GMT)
References: <20191130084602.10818-1-alex.bennee@linaro.org>
 <20191130084602.10818-12-alex.bennee@linaro.org>
 <9362663d-6452-39aa-2a8d-1cfd853d7faa@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 11/14] target/arm: default SVE length to 64 bytes for
 linux-user
In-reply-to: <9362663d-6452-39aa-2a8d-1cfd853d7faa@linaro.org>
Date: Thu, 05 Dec 2019 17:31:52 +0000
Message-ID: <87o8wm7k6v.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 luis.machado@linaro.org, qemu-devel@nongnu.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 11/30/19 8:45 AM, Alex Benn=C3=A9e wrote:
>> The Linux kernel chooses the default of 64 bytes for SVE registers on
>> the basis that it is the largest size that won't grow the signal
>> frame. When debugging larger sizes are also unwieldy in gdb as each
>> zreg will take over a page of terminal to display.
>>=20
>> The user can of course always specify a larger size with the
>> sve-max-vq property on the command line:
>>=20
>>   -cpu max,sve-max-vq=3D16
>>=20
>> This should not make any difference to SVE enabled software as the SVE
>> is of course vector length agnostic.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  target/arm/cpu64.c | 3 +++
>>  1 file changed, 3 insertions(+)
>
> 6 is the largest size that doesn't grow the signal frame.
> I imagine 4 was chosen because that's the only real hw atm.
>
>> +        /* Default sve-max-vq to a reasonable numer */
>> +        cpu->sve_max_vq =3D 4;
>
> I also agree that we should match the kernel, but this is not the right w=
ay.
> Changing max vq is not the same as changing the default vq.
>
> You should change the value of env->vfp.zcr_el[1] in arm_cpu_reset(), and=
 the
> user can increase the length with prctl(2) as they would be able to on re=
al
> hardware that would have support for longer vector lengths.

No the intention is to default to a lower max VQ because...

> Also, I don't think you should mix this up with gdb stuff.

it is what we use for sizing the registers for the gdbstub. The other
option would be to use the effective zcr_el1 value at the time of the
gdbstub connecting but then things will go horribly wrong if the user
execute a prctl and widens their size.

>
>
> r~


--=20
Alex Benn=C3=A9e

