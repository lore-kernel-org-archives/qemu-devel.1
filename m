Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325B6C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:23:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F10BE20663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cdu0plEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F10BE20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifNVM-0006Cf-2c
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 07:23:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ifNUP-0005TC-ST
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:22:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ifNUK-0006Ji-LB
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:22:41 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54214)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ifNUK-0006HK-CU
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:22:36 -0500
Received: by mail-wm1-x343.google.com with SMTP id n9so2144352wmd.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=t21AsZR2sGE4QRZN4jrEDWdSv4UiQvP/rr3GlqpZQEU=;
 b=cdu0plElofCCmkguV3R8YUuiq2GkULR1a4KYMZOWajNre6pbeHaYtFfTH4WW+4nR3F
 KCuUQo/7vle1z2UEoJsfFqpZeGp7a14/ptQHrxWdmDbJBiorlvbwyMLdpGjMvtZxmetU
 PfudfJmYn4nsFS2QGOpcuHLPdMJqCWVIgvGwnYuMnl/jtM3vpvYhIh6v+CUjoQNl4QWS
 49k7pw+3mlHKCFbJnieTcJsxPXWPXhcCymOoYht/HCAYg9hI4BphvOofsqgLtxJWChAK
 OOA+jvJMED9H2m6zFw2brP6BNMsD/4/IMcVQQ0a/PGEM1MT5iSHfJe2Qa86dkyCeYp4J
 DzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=t21AsZR2sGE4QRZN4jrEDWdSv4UiQvP/rr3GlqpZQEU=;
 b=aPA3v9xABVBZzCkCBknhRT6Qxs8meMAilgUtiRedZp4oQ1tbodDmg/kHAnUwsjwTz4
 bRqVJ1X3RU4YFiZnV4lhXP09ilhAavcZzj4HpVIj2aqQLRIOvteUmrCnCZoTLe4cBKji
 0XWB4vJURRqU9cWmO56m+1cAbzieKbHRUqsmdno5m7D/+0TAEkgqh2ot4MDt6CAir9EV
 oqcvRNqQ2IGIaVTWOAUMChZZmlCvvPddsiHafI6D2/P9/VtX7EVbcgZSUAd581Fuo57N
 qaO/pr1YXKklNHiPU8T5Rhl4o0H2+deuqPlxeHPJ+rFJkxJF5WYbE1uGU9S3IaPg0P8Q
 Gjpw==
X-Gm-Message-State: APjAAAXcHVBCBBhV3rFyupPe2DjhdxDh8D3DZcpQN11KQ0X10XSt7VQt
 VJ0sEDgaquOK4TwB7d+mXzLe1g==
X-Google-Smtp-Source: APXvYqxKLiINSAfVadbqgHzhX99O7GCv5LRS0qq61DU0Pv16jMa8xJBZaOeal3V64CF9QWuksHxwLg==
X-Received: by 2002:a1c:c90e:: with SMTP id f14mr6310970wmb.35.1576153354775; 
 Thu, 12 Dec 2019 04:22:34 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z12sm5966112wmd.16.2019.12.12.04.22.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2019 04:22:33 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6EDAA1FF87;
 Thu, 12 Dec 2019 12:22:32 +0000 (GMT)
References: <20191206140012.15517-1-wainersm@redhat.com>
 <20191206140012.15517-3-wainersm@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH 2/2] .travis.yml: Add kernel build deps for acceptance
 tests
In-reply-to: <20191206140012.15517-3-wainersm@redhat.com>
Date: Thu, 12 Dec 2019 12:22:32 +0000
Message-ID: <87h825bunr.fsf@linaro.org>
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
Cc: fam@euphon.net, qemu-devel@nongnu.org, wrampazz@redhat.com,
 crosa@redhat.com, philmd@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Wainer dos Santos Moschetta <wainersm@redhat.com> writes:

> The tests/acceptance/pvh.py test builds the Linux kernel
> at runtime so it needs dependencies installed in the
> container. Current used container image misses only
> libelf-dev, which is then added with this change.

Hmm I'm not sure about this. Do we really want to building a whole
kernel inside Travis? There must be stable PVH aware distro kernels we
could use for the CI?

>
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>  .travis.yml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/.travis.yml b/.travis.yml
> index 445b0646c1..d8fe98eb63 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -277,6 +277,8 @@ matrix:
>              - python3.5-venv
>              - tesseract-ocr
>              - tesseract-ocr-eng
> +            # Additional kernel build dependencies
> +            - libelf-dev
>=20=20
>=20=20
>      # Using newer GCC with sanitizers


--=20
Alex Benn=C3=A9e

