Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C13C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:52:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 219F8206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dHSAa+ox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 219F8206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOn8-0007tT-61
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jOOd6-00006a-V1
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:41:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jOOd4-000698-QA
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:41:44 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:38787)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jOMSG-0005Xt-Oc
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 10:22:25 -0400
Received: by mail-wm1-x331.google.com with SMTP id g12so6315386wmh.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 07:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=GOpTAY0k5RMFo/Qav5YEUcG24sEmHhOzhSfAslWJhP0=;
 b=dHSAa+oxSTdwDO75ckb2CciVbxmM8V6oUFnXZRbM3i7Q3WMr62yXHYpZ3gM2fxvPPe
 w3yYU8JC6msumMvnLitfJ7S6ZjoDAnbMfo9UBZsrConZXrj0wF+bgnOs+o4NrQIftd+j
 za6XlPgZSj+deSGyAjmJ+8EqBZY+K6MP2nNz/Is+y6FiMWp2ZtV6blp6nfz7cEn27x8v
 FABkSBHREJin/EoTwIlZJck7FrEwWqyr3la6hnx0pSBUrURGEHW7VSGQkhEZIX7hYELu
 /fHC22Z4X+k+J21BN3ESqhfOco5n+EWzK/zkSpwC3ZjesYmCn4cAKXfDINAnP7TJRSaZ
 s2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=GOpTAY0k5RMFo/Qav5YEUcG24sEmHhOzhSfAslWJhP0=;
 b=IvNzY02G0PIBdhgOvYEOPJaHdjoBvd9wZ5fmMrY6VWjthEt39MzHB5e74n6o8xFiXN
 CNsZfpMu0Kj0WinV5DnxK/7a2kA8EbcF/Vs9OH5BqUOvc/OEiHYp6YEwAx+RAZuGL0ju
 R12qQpZIoXwzfBDFpp49puEcdf2F+valwXZDVHoLN/mxADhgBMVt7I6p6l4uMEkgdSyp
 L9GM21OyDUXUXshXGjrwsqtu2tVzLLHUsP/n8bbeFt0Dqqb+60s2FLyv/8UwpDCeCK5N
 2LhtpEKXAawufDfTYdxXmGlVQhw6f3tGsRLt9VJ6mTzX2s7Ajy4tLL0z7RLOTaq1HRIT
 lJMQ==
X-Gm-Message-State: AGi0Pub6jwFyz4fWgcxPHqZYf8jicxospex5oM9pWpgm681ozkcm3RAC
 t73+DQTkpmwQa0J1coxtj9ajnw==
X-Google-Smtp-Source: APiQypJQ9MZpkuexgoHPcE4IEmRN5ziRDmW3Krz6NbvbudpriumRxibvBDj7GYvqmjQxKYiAWUvdzw==
X-Received: by 2002:a05:600c:20c6:: with SMTP id
 y6mr94207wmm.131.1586874143212; 
 Tue, 14 Apr 2020 07:22:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a1sm10094358wrn.80.2020.04.14.07.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 07:22:21 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4D9FB1FF7E;
 Tue, 14 Apr 2020 15:22:19 +0100 (BST)
References: <20200414102427.7459-1-philmd@redhat.com>
 <CAFEAcA-PyMisjC25CSGyU5-ASjaAd7gQMabzMCR=uvudSBk-Fw@mail.gmail.com>
 <357e2335-b00f-cd28-4ade-d6286ace144f@redhat.com>
 <CAFEAcA8BgkqNQToJZy0=SOSxF2QWgxrP79Gj1qaVUm5xdvm65A@mail.gmail.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH-for-5.0] gdbstub: Do not use memset() on GByteArray
In-reply-to: <CAFEAcA8BgkqNQToJZy0=SOSxF2QWgxrP79Gj1qaVUm5xdvm65A@mail.gmail.com>
Date: Tue, 14 Apr 2020 15:22:19 +0100
Message-ID: <87d08a9mg4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 14 Apr 2020 at 12:05, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>> > The other implementation option here would be
>> >
>> >       guint oldlen =3D array->len;
>> >       g_byte_array_set_size(array, oldlen + len);
>> >       memset(array->data + oldlen, 0, len);
>>
>> I thought about it but I'd rather not access GByteArray internals.
>
> AIUI ->len and ->data are not internals -- they're
> in the documentation as "public fields" and the code
> example for GByteArray directly accesses ->data.

They are - and I do it in a few places in the gdbstub when it's easier
than going long form. FWIW I prefer Peter's formulation.

> (Contrast GBytes, where there are no defined public
> fields and instead there are functions g_bytes_get_data
> and g_bytes_get_size.)
>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e

