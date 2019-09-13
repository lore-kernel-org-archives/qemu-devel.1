Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC23C4CEC5
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:30:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21F5420640
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jsmcFBYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F5420640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8lek-0007sw-Rr
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 09:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i8ld5-0006V9-A3
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i8ld4-0007TB-Ay
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:28:51 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37277)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i8ld4-0007SP-3Y
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:28:50 -0400
Received: by mail-wm1-x341.google.com with SMTP id r195so2820426wme.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 06:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=4udeLUKboGyQ12jto7cHCku2+XufErIS42HSucLb99c=;
 b=jsmcFBYibb5Z6sMBSPmnd9WR1hh3+I1XF8+WXzMHvWQKjWcmS8N8o4OxqP3QgBgXQU
 ipQLVAqXysP5DDVled/sqDc7GpoXlsDBNJhcq1BRqOG/9qsMhOKUMMGwSGSizI3Rvh5Q
 3h1LXfTbg4PjnbkwUxF46/t8zL/pDdF4rIzjpahci7VHm0234cQMbVL1q3KIid9C7sKO
 abAMYQ/ahXof/y0Otr5mjG/rM7ZGPr74sOFcmEamyx2m3uNcXrqWRxoSsf+2h4sw5sf+
 uBRQyOBUeRg9KwWp2znjTr9Lwrc/JdRkZNLqDhG5dXSn6NTSJHTXJdRU3GJuIRUjQRAp
 T+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=4udeLUKboGyQ12jto7cHCku2+XufErIS42HSucLb99c=;
 b=ucXjoWFoHJtejSB7RsU73PhUQlJdxUTjaxp1LnejBvWuMCpNhwVv94dC5nntnIzJEo
 IuzTG9f8SE/+riWGKruco8RTNj9CQNCgiuk+7hLKS88xunoW8cwKAUjuSu+IlMRAgiTI
 iFdCw6qfmE5QKA7ZCCbdvRquCLZxRd5h1r9IjQYX2SFW9qPbts8q666OziUfLt/f5pE/
 xFmRvd2KEKLxmjtTerxsskbhnNfn4unApcjKEcThbZnGZumJ8pxXx1NbGBKeDfeUg23n
 voXyXYRwNx4uyLTEuzBYCZYXZGxfq1mWzG3B3n7YJ8PmrQ6rr97VrvUTEHc6up9NfNGA
 rE5w==
X-Gm-Message-State: APjAAAWZ7PujSSzWFT8CqmiurYfsaVf6BRUiiKRhxjC6LMJdu1rSjVAv
 kFfcvsUWEAPNRodEXnkYsz0Qfw==
X-Google-Smtp-Source: APXvYqxUVg+MpxQganOirY/MjNrJHOijY8qChhdmxWaG4nDgG7aMlRIlsWLD5KAY7eO/tMLBKTnL+g==
X-Received: by 2002:a7b:cb9a:: with SMTP id m26mr3527976wmi.57.1568381328365; 
 Fri, 13 Sep 2019 06:28:48 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v6sm4037244wma.24.2019.09.13.06.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2019 06:28:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DF8B11FF87;
 Fri, 13 Sep 2019 14:28:46 +0100 (BST)
References: <20190911164959.11003-1-alex.bennee@linaro.org>
 <20190911164959.11003-3-alex.bennee@linaro.org>
 <CAFEAcA8NsdpEMOH1MFDta0LUswyqSDHCgtOh6g5k3+EU0FVuHA@mail.gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <CAFEAcA8NsdpEMOH1MFDta0LUswyqSDHCgtOh6g5k3+EU0FVuHA@mail.gmail.com>
Date: Fri, 13 Sep 2019 14:28:46 +0100
Message-ID: <875zlwz5o1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v5 2/5] target/arm: handle M-profile
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 11 Sep 2019 at 17:50, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> We do this for other semihosting calls so we might as well do it for
>> M-profile as well.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> ---
>> v2
>>   - update for change to gen_exception_internal_insn API
>> v3
>>   - update for decode tree
>> v4
>>   - use !IS_USER
>> ---
>
>> diff --git a/target/arm/translate.c b/target/arm/translate.c
>> index 34bb280e3da..6689acc911e 100644
>> --- a/target/arm/translate.c
>> +++ b/target/arm/translate.c
>> @@ -8424,7 +8424,13 @@ static bool trans_BKPT(DisasContext *s, arg_BKPT =
*a)
>>      if (!ENABLE_ARCH_5) {
>>          return false;
>>      }
>> -    gen_exception_bkpt_insn(s, syn_aa32_bkpt(a->imm, false));
>> +    if (arm_dc_feature(s, ARM_FEATURE_M) &&
>> +        semihosting_enabled() && !IS_USER(s) &&
>> +        (a->imm =3D=3D 0xab)) {
>> +        gen_exception_internal_insn(s, s->base.pc_next, EXCP_SEMIHOST);
>> +    } else {
>> +        gen_exception_bkpt_insn(s, syn_aa32_bkpt(a->imm, false));
>> +    }
>>      return true;
>>  }
>
> This is still disabling semihosting for the linux-user-mode
> build for M-profile, isn't it ?

Sure - as rth suggested. But m-profile doesn't run Linux so why would we
support it in linux-user?

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e

