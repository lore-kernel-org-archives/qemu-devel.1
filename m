Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2EEC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:30:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9334D222D9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uLIoPH05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9334D222D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49817 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioprr-0000m7-57
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:29:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ioppO-0006YF-O9
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:27:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ioppL-0005Ox-Sf
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:27:25 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53091)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ioppL-0005NO-DU
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:27:23 -0500
Received: by mail-wm1-x343.google.com with SMTP id p9so19171743wmc.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 06:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=4ay+vpKROKW8EYLuU4VepURpUz6gjW7YvMDbWzGZHs8=;
 b=uLIoPH05ct8NZrBq2LapLTHrRYGLv/T0l+Y8QrOicY0RgNR6iTe4i/qoheTjULrRTH
 28v6UMHa/uWRxcz+7ja9FTcFFlj6J5buGAI8QT0buqCO/1usYRN8llDPs9s56F+7mZqL
 xiWjS9Wg4EbWJUB3avBQ7lVR76YUwnj3X4tW4AVqj8OKWXLtQw1WZG812UXig/aAhivR
 bBNnkhphNygIRCW57/rL89NYVxFX9wUVVyvg+PqdeaPo95UcxodBgWaxYkjT71M2pdDc
 IMRIrK6v0IYqJIGwPES2rDNm0bsjAEi8a86LiMew6eG/urFkVkKIOxzc48QfN0pJW2Iv
 7q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=4ay+vpKROKW8EYLuU4VepURpUz6gjW7YvMDbWzGZHs8=;
 b=T4ZkrTUjyb7BkkJYhFsyZP98HWxgpCU6I/tKjp7QmSI1kp3wAEiG794K+/AyyHFwn0
 0z+cdd4DY4e2T4ZKuFIIeaKDN8S4Yw3zS0hKW9769GzvHadXWNJ+zYFgJVTtmw+PyhMq
 sHlFud8hMdJMRTYM9nYuGgtP/6zBifuy0DnFNxP2rk1wFlKuDi8iMucfLGTuSQ2+nD0l
 /HMLmrRAVBqrN/HnRrMbKBRShEUtZkORKxDqODvpBjO6QKqChvCaXsA1/JWP/3p2xPh+
 tMg0fOve7KbiuCDYZEY6uU/1SAwQyUAlXPXahEuvJ481PhIt6BZEysjMIjyEed0v9V/8
 wBOQ==
X-Gm-Message-State: APjAAAU0kBqzqDibcc2PlR0Ac2uyQgUTvGBnBRDscX0x6wD6s5pqukJ6
 crGgjASXpUOdmqEaPnp4WOJD9A==
X-Google-Smtp-Source: APXvYqwWDqtSMVTvzD8QUx9RWa9s2vyJfwm7HSOJ/y2mqxzL4ShY7poHJ5RdQmIhlsf535z6q/wahg==
X-Received: by 2002:a1c:407:: with SMTP id 7mr39171368wme.29.1578407241276;
 Tue, 07 Jan 2020 06:27:21 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s3sm27196108wmh.25.2020.01.07.06.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 06:27:19 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2A4051FF87;
 Tue,  7 Jan 2020 14:27:19 +0000 (GMT)
References: <20191220132246.6759-1-alex.bennee@linaro.org>
 <20191220132246.6759-6-alex.bennee@linaro.org>
 <09322c6e-74d9-08d0-1138-f2d5581a7244@linaro.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 5/5] tests/tcg: add user version of dumb-as-bricks
 semiconsole test
In-reply-to: <09322c6e-74d9-08d0-1138-f2d5581a7244@linaro.org>
Date: Tue, 07 Jan 2020 14:27:19 +0000
Message-ID: <87d0bv4a0o.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Peter Maydell <peter.maydell@linaro.org>, keithp@keithp.com,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 12/21/19 12:22 AM, Alex Benn=C3=A9e wrote:
>> +#if defined(__arm__)
>> +    register uintptr_t t asm("r0") =3D type;
>> +    register uintptr_t a0 asm("r1") =3D arg0;
>> +    asm("svc 0xab"
>> +        : "=3Dr" (t)
>> +        : "r" (t), "r" (a0));
>
> This is the #ifdef __thumb__ svc code.  Are you enforcing that with
> command-line arguments?

No it is dealing with aarch64 vs 32 bit and the __arm__ is a compiler
symbol.=20

>
> Might as well fix this, then test both arm and thumb.

I've enabled for Aarch64 just like the semihosting test.

>
>
> r~


--=20
Alex Benn=C3=A9e

