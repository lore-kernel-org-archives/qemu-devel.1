Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67070C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 18:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 368C421835
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 18:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ltxuZ1im"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368C421835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuLDC-0002gj-HT
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 13:58:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iuLCV-00024z-Ni
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 13:58:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iuLCU-0007TQ-L5
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 13:58:03 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38213)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iuLCU-0007Sf-EJ
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 13:58:02 -0500
Received: by mail-wm1-x343.google.com with SMTP id u2so194791wmc.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 10:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=IyMCrqDYd6pbZwcTUxv13hXHPLpC8hOdgV24Pd3ffQw=;
 b=ltxuZ1imAnesjoERiQqc+UeYWetarqdYxjnkJbCAGt4YIlQGbzGt7mGLahOEtNp+oU
 PE1QHABRWJHRldebX7noDMCg2sjel6nbCj8p9dZrBwT5S6rb68VWGm5qkkKurG/4qPAn
 WAVbUm975nPiwoHeOeSzhurrBpyGgNUfS57I+02a7pFHbU2Jmk1ByR8GE+S45baLzrqm
 PnwXPadcJ6KxJSS6VDmSYzrmSTHM/wFsIhDY7o1JQGbixTT3omsQ6KOS72itfZ0k1Fa9
 +NrkR4INxbx3zRUgD4Jw133V4cNPWPANi3WZ1dN4zEr5JAB0BJ3eTrkGjmrLww7YL8X+
 bGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=IyMCrqDYd6pbZwcTUxv13hXHPLpC8hOdgV24Pd3ffQw=;
 b=Mjj3F0WhWIs36vKIOA1ElYm1wXuQ6uqnvSBHzvwfga8ZS5puP+kIJqGE26A1FoN619
 UjxcoSpVLL5VPO77RYBxJhYx1pEmAqbdIzid+cUknaonB0MptmD7T3b3z8WQ30rwHl2f
 /8ZGwv16DnD05knouD1iySQ7AdXkoiNfHZixo40l3Z6+Wo+vt57JdNMauruVw8/u8PoK
 ef4i2Hf8tsMpH/WH/ZXfmK6d36WK5yd9HuySiRVCgAOOZcMsm9yqpKlut6ciywr583oT
 Sc/1scNYb8WeO5x1CDnaSaCCLMvSdcGCp/fVKfYWPUPZaoHQ3+leFSETSp/Jvud7h6HT
 yRSw==
X-Gm-Message-State: APjAAAX3zEuDMOSmYEoQjJXWxPM2ZEWwgCQ48qg7CDkFYFfHAk3ynVhj
 iQE7BBvGtourO+u1KxsUuEHcQA==
X-Google-Smtp-Source: APXvYqygEsijd0JQ2X90HeQZhGei83voXrwSQzK+o5mTPfna1oanBaE6OM3/CFzk8ulvMwXXpqcJ0w==
X-Received: by 2002:a7b:cd11:: with SMTP id f17mr4301315wmj.48.1579719481286; 
 Wed, 22 Jan 2020 10:58:01 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t25sm5192072wmj.19.2020.01.22.10.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 10:58:00 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AD1741FF87;
 Wed, 22 Jan 2020 18:57:59 +0000 (GMT)
References: <20200116141511.16849-1-peter.maydell@linaro.org>
 <20200116141511.16849-3-peter.maydell@linaro.org>
 <CAFEAcA80NezC=oXMWNmbKTGWp2_xJVS1MFeOe58d3wMrH1mQug@mail.gmail.com>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/3] docs: Create stub system manual
In-reply-to: <CAFEAcA80NezC=oXMWNmbKTGWp2_xJVS1MFeOe58d3wMrH1mQug@mail.gmail.com>
Date: Wed, 22 Jan 2020 18:57:59 +0000
Message-ID: <87h80nz5c8.fsf@linaro.org>
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 16 Jan 2020 at 14:15, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>>
>> We want a user-facing manual which contains system emulation
>> documentation. Create an empty one which we can populate.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  Makefile              | 10 +++++++++-
>>  docs/system/conf.py   | 15 +++++++++++++++
>>  docs/system/index.rst | 16 ++++++++++++++++
>>  3 files changed, 40 insertions(+), 1 deletion(-)
>>  create mode 100644 docs/system/conf.py
>>  create mode 100644 docs/system/index.rst
>
> I think this may have crossed in the post with the
> commit adding index.html.in. Anyway, here's the obvious
> fixup, which I plan to squash into this patch without
> doing a respin unless there's some other respin needed:
>
> diff --git a/docs/index.html.in b/docs/index.html.in
> index 94eb782cf7e..573c543c02b 100644
> --- a/docs/index.html.in
> +++ b/docs/index.html.in
> @@ -11,6 +11,7 @@
>              <li><a href=3D"qemu-qmp-ref.html">QMP Reference Manual</a></=
li>
>              <li><a href=3D"qemu-ga-ref.html">Guest Agent Protocol
> Reference</a></li>
>              <li><a href=3D"interop/index.html">System Emulation
> Management and Interoperability Guide</a></li>
> +            <li><a href=3D"system/index.html">System Emulation User's
> Guide</a></li>
>              <li><a href=3D"specs/index.html">System Emulation Guest
> Hardware Specifications</a></li>
>          </ul>
>      </body>


This didn't seem to make a difference on readthedocs so I assume this is
for different tooling?

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e

