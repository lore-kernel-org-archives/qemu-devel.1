Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD760C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:45:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A00B220862
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WodM30LB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00B220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia2Jd-0005Wm-1A
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 13:45:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ia2DA-0000hN-7F
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 13:38:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ia2D6-0001HO-Og
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 13:38:46 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35194)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ia2D4-0001G6-OB
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 13:38:44 -0500
Received: by mail-wr1-x442.google.com with SMTP id s5so27892148wrw.2
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 10:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=WDZ6Fj4H3med+NAezlNWAXwQ9kr/aZJ2bvNRhxJeucc=;
 b=WodM30LBywUmTNPsP7H/gnadl3HmxL8zzfv7x14BlRsxXJpXwXN6b48CKWQU9BENk2
 5Te+uRXaP0rSV7711B0dmH7Km5aYBp7RhGfcjZuBvU4RkKc3A2i7F4UkPbKkDQHYWBFq
 7aWrmtkHltPD2mN2a53vF79b4T+/hZM27UPhOM9MNG2DnRC5FwppP0NGyIcQF+jrblva
 aJqR5CYllAh+ktEvfjNvOwBjsUwBfJVgdSUbOrWct4rxkbiEcYpbjTfoQcfQVLCCBvuQ
 +IHa2vgi22k3DO1Mcm+lgb/IDsPlePcunz3cIt/hycbIxFvzzXLRh0uD/zqC77zsRCTk
 oI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=WDZ6Fj4H3med+NAezlNWAXwQ9kr/aZJ2bvNRhxJeucc=;
 b=IB/u96CrHQsy901/wN3C51txGaEXFVjKTSOU7mIfbRAPzU5Jvp4YEr/flstn0nWbxV
 NJVZtiwZ4817aZCkVoVYXfDsuq3P85DKuHkv74HlkIt+bsYyvwhT9J61gOskg4AM2PRc
 mrRVscy6hzIXjznscRunNHnZNM9N4JUcLg2ZZaomVRIbED6O5lVDlJR/aI2ZTvrycqt1
 DnutGFHbeMl/5IkKKg/ifcCDVg+kEoZVuEHcslwI2f7S6wrZTaE1bnrMrW8l6gi6nqM3
 Bt/4fatQG2Zu5wb+a4YtHelbzjd47RjX3zXgDL8YG/Z1DfCjkx31WzAGLbq+s2Q2wpeq
 Zv5A==
X-Gm-Message-State: APjAAAW3494cGzpYQiDb1B6ZrApseEq2jHH0eyAjttCiCiqoPHkPOl+4
 XEy8tDu9HzxWG6AIl5PCMESf+bVbWRs=
X-Google-Smtp-Source: APXvYqxHAhZI6S3GnIRGUH3YZDr/hAetjw2BH1WEvPyoMVMZ4Rwyd2uqBsS0pgVAnsAVPG7m0YAphw==
X-Received: by 2002:adf:8426:: with SMTP id 35mr43769917wrf.262.1574879917636; 
 Wed, 27 Nov 2019 10:38:37 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s19sm3384369wmc.4.2019.11.27.10.38.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2019 10:38:36 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 06EFA1FF87;
 Wed, 27 Nov 2019 18:38:36 +0000 (GMT)
References: <20191127154857.3590-1-thuth@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] travis.yml: Run tcg tests with tci
In-reply-to: <20191127154857.3590-1-thuth@redhat.com>
Date: Wed, 27 Nov 2019 18:38:35 +0000
Message-ID: <87zhghf9lg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: qemu-trivial@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> So far we only have compile coverage for tci. But since commit
> 2f160e0f9797c7522bfd0d09218d0c9340a5137c ("tci: Add implementation
> for INDEX_op_ld16u_i64") has been included, we can also run the
> x86 TCG tests with tci, so let's enable them in Travis now.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .travis.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index c09b6a0014..b0b634d484 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -218,7 +218,7 @@ matrix:
>      # We manually include builds which we disable "make check" for

this comment is out of date now (or rather has been for a while)

>      - env:
>          - CONFIG=3D"--enable-debug --enable-tcg-interpreter"

Perhaps as linux-user doesn't add much to testing the TCG we could limit
by MAIN_SOFTMMU_TARGETS here?

> -        - TEST_CMD=3D""
> +        - TEST_CMD=3D"make run-tcg-tests-x86_64-softmmu V=3D1"

How about "make check-qtest check-tcg"

Which will exercise the moderate boot code tests of various
architectures as well as x86_64 (if we include the --disable-docker
configure stanza)

>=20=20
>=20=20
>      # We don't need to exercise every backend with every front-end


--=20
Alex Benn=C3=A9e

