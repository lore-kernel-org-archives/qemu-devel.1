Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42C8C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:11:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8674224249
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IoWIJMAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8674224249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icvbF-0008VZ-IJ
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 13:11:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icvOm-0003jA-Bq
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:58:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icvOl-0005WM-1D
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:58:44 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35900)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icvOk-0005Qz-Pi
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:58:42 -0500
Received: by mail-wm1-x344.google.com with SMTP id p17so4675399wma.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 09:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=zMecNqqSJ4VYfE/rNTGUDOH12wNz/+QCGWYMWDkatnw=;
 b=IoWIJMAifHTwtkmnO6vgnTrUBLDmvpqfdgd3vANXlY6EOX2nIMI7et2D9rrSR7Z3uF
 MGE7TZCLiyhBhevScAUidT+i0b6bftMNaCMmm49DFyGzUdUMv7Yu835B6CN/N05LnT+a
 jXKKjKAOLi7716w7VNPdYIAWyjtfdfFstFFjaOeAsB3Z7k3GzxETo+c8Qr9+c07A88Ni
 e+ZIy2OdK1zKG8RD1dsMDHIE2k0SH24Qhi2qaHSY4WSxDAXTddB6PXjw7zX6O/J8/RI8
 DNoIOSBjIsJ2NTDlxMu645yMtyP9e54O0MK6EppBSZruRRc17T2rZbv853M0Q8+A4AUe
 dmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=zMecNqqSJ4VYfE/rNTGUDOH12wNz/+QCGWYMWDkatnw=;
 b=YlNMHQfHdN3fznYJyqUukchsVyaQioaFgNEn/8pugHBTd6WCQj5bqOtJ5aQmJwrP6J
 nlD8nImJQMqa2aWaIKcGnIzNK415WuWsixo8TirLWj6O4oyjG1nZXv7wBkop5bGXhMYq
 QFHgptbc6Ly4u5W+dTuw0nLruiyWZfo4aOUK8OVEqpOkrZWYA8cnwrV0QVxvsUCiE0XF
 /AJ9KD7mLqBVpv0xfxuWytQQdXeAjV7/DEQQu0raNZqeyM/q8l67pVww9c5TYdUo/L7i
 UrkoEgNAOQ4i2uWH99Lmof7mpV2CY8ieWh2z6KzNzz637FBBXwrhhW2IuX5HkYpzA1lI
 WZMg==
X-Gm-Message-State: APjAAAVOIqycit8S8NQXfFj7MOtKyyixy4Wpeke4X6FMB9S9sELCVJMp
 HSxK8YP5caK3BRghN0CT95hZ/w==
X-Google-Smtp-Source: APXvYqxV8LbcaCOV6vBjSzDSswM/k2nv1dJvpI8Xxj3yxlJsl6ZqXbbW2HF1okJelzOr+87AlL1gyw==
X-Received: by 2002:a05:600c:249:: with SMTP id 9mr6329166wmj.2.1575568721311; 
 Thu, 05 Dec 2019 09:58:41 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t5sm13215195wrr.35.2019.12.05.09.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2019 09:58:39 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3E09E1FF87;
 Thu,  5 Dec 2019 17:58:39 +0000 (GMT)
References: <20191130084602.10818-1-alex.bennee@linaro.org>
 <20191130084602.10818-7-alex.bennee@linaro.org>
 <987465d3-3b13-e675-9622-c13e2d5205c2@redhat.com>
 <42017B4E-E961-494C-A505-FCDA74EFB265@arm.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alan Hayward <Alan.Hayward@arm.com>
Subject: Re: [PATCH v2 06/14] target/arm: use gdb_get_reg helpers
In-reply-to: <42017B4E-E961-494C-A505-FCDA74EFB265@arm.com>
Date: Thu, 05 Dec 2019 17:58:39 +0000
Message-ID: <87lfrq7iy8.fsf@linaro.org>
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
Cc: "damien.hedde@greensocs.com" <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Luis Machado <luis.machado@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "open list:ARM
 TCG CPUs" <qemu-arm@nongnu.org>, nd <nd@arm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alan Hayward <Alan.Hayward@arm.com> writes:

>> On 1 Dec 2019, at 20:05, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>=
 wrote:
>>=20
>> On 11/30/19 9:45 AM, Alex Benn=C3=A9e wrote:
>>> This is cleaner than poking memory directly and will make later
>>> clean-ups easier.
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> ---
>>> v2
>>>   - make sure we pass hi/lo correctly as quads are stored in LE order
>>> ---
>>>  target/arm/helper.c | 18 +++++++-----------
>>>  1 file changed, 7 insertions(+), 11 deletions(-)
>>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>>> index 0bf8f53d4b8..0ac950d6c71 100644
>>> --- a/target/arm/helper.c
>>> +++ b/target/arm/helper.c
>>> @@ -105,21 +105,17 @@ static int aarch64_fpu_gdb_get_reg(CPUARMState *e=
nv, uint8_t *buf, int reg)
>>>  {
>>>      switch (reg) {
>>>      case 0 ... 31:
>>> -        /* 128 bit FP register */
>>> -        {
>>> -            uint64_t *q =3D aa64_vfp_qreg(env, reg);
>>> -            stq_le_p(buf, q[0]);
>>> -            stq_le_p(buf + 8, q[1]);
>>> -            return 16;
>>> -        }
>>> +    {
>>> +        /* 128 bit FP register - quads are in LE order */
>>=20
>> Oh, this was always wrong on BE :(
>
> Am I right in thinking this patch correctly matches the SVE BE changes fr=
om June?
>
> Specifically, this patch:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2019-June/657826.ht=
ml

Not quite. This is just taking into account the way we store the data
internally in cpu.h. The gdb_get_reg128 helper will then ensure stuff is
in target endian format which is what gdbstub defines.

There aren't any actual kernel to userspace transfers going on here.

>
>
> Alan.
>
>>=20
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>=20
>>> +        uint64_t *q =3D aa64_vfp_qreg(env, reg);
>>> +        return gdb_get_reg128(buf, q[1], q[0]);
>>> +    }
>>>      case 32:
>>>          /* FPSR */
>>> -        stl_p(buf, vfp_get_fpsr(env));
>>> -        return 4;
>>> +        return gdb_get_reg32(buf, vfp_get_fpsr(env));
>>>      case 33:
>>>          /* FPCR */
>>> -        stl_p(buf, vfp_get_fpcr(env));
>>> -        return 4;
>>> +        return gdb_get_reg32(buf,vfp_get_fpcr(env));
>>>      default:
>>>          return 0;
>>>      }


--=20
Alex Benn=C3=A9e

