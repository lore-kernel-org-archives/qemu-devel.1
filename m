Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0041ACA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 15:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79937208E3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 15:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YYnpFfVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79937208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQCUQ-00065k-BU
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 11:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iQCM4-0000rQ-5i
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 11:27:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iQCM1-0002Rm-Cx
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 11:27:18 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51037)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iQCLz-0002Qo-Ri
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 11:27:16 -0400
Received: by mail-wm1-x343.google.com with SMTP id 11so6390562wmk.0
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 08:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=jom4OL7ujMFgl2s8HtwZwKYMiD3VbMFW1UdG7Ehq5Ec=;
 b=YYnpFfVyAB99nP0RBzALunnGN6zvSbH7vPQRQGBhyDcGJ7RSof5WdZBnj1e8jOlz4W
 hVp0sT+kYuidEc7F1jiFOnaclV53eqvEOAk860Ff+DnneZnPHv8RaPTnpdKvK8RORiSO
 nRjQRR17wiKZJZKxkcFNTuE9WpCnkR0wKXiaEHbgYOzZOZDhWtIVRfd+ZaJz322crmi8
 CTG2e3Qiqst2shqOC3C/YTULMVRqxSyl2Dvdxv8YKx/RS1NUA1OaxkTNF/C4+dXH5Y92
 XXOOBuosWaTTkNFrCOCM3ewieirtqngozpinavFUy07OXgr/RuKBcxMSIzrAK9LGBOtI
 pIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=jom4OL7ujMFgl2s8HtwZwKYMiD3VbMFW1UdG7Ehq5Ec=;
 b=ZLPsVEU99xilXdhIkClG29JvD0aTByeh7qtFYZhDsp6QbiEEqJox1YSCvC/pRXqK/I
 6JcZQeSUNgCmrvIvRI/+vEKJETBl4b7DkTgPmBPS2/3Z2Juglo9WSYaL1x2d+wyb6Xj+
 vkQ9Jv0RtE7mWTdOtJyyxSkwEW91Amh2TgI2yfBJ+JkoFrlHHpSXsAuoGvAxvhCq25Wb
 /GfLCiEJ6vKnDxEauv3rxJjv24z5UGINaORKJyxxrZz49kjS85pMY6ICAJ/INqKnS4yF
 RUcHKFE3+91nTt8cHda8B/g/8aL3/PYyjY0/O/Yx0U5qCPjKMbr83rNRIJMaBzpihdVY
 9+Ww==
X-Gm-Message-State: APjAAAXS5DqL3pRsOSuzXUefnSFgcxpCpXot14+4fpMS80qSkr6SC26u
 GmfdiIMkgx0KkL0uRGKfXEKyk/6KWG2AGQ==
X-Google-Smtp-Source: APXvYqwrQJwDmbSEPECQOdf+hUkTlUDhqhvSkwdiCC1xI7A2R169BiQtEQt0k2y28X4r837QNMZl0g==
X-Received: by 2002:a1c:7d95:: with SMTP id y143mr5980516wmc.143.1572535633144; 
 Thu, 31 Oct 2019 08:27:13 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v6sm4852003wru.72.2019.10.31.08.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2019 08:27:12 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 756831FF87;
 Thu, 31 Oct 2019 15:27:11 +0000 (GMT)
References: <20191031140152.19769-1-philmd@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] tests/boot_linux_console: Fetch assets from Debian
 snapshot archives
In-reply-to: <20191031140152.19769-1-philmd@redhat.com>
Date: Thu, 31 Oct 2019 15:27:11 +0000
Message-ID: <87v9s56ils.fsf@linaro.org>
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
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> The kernel packaged was fetched from an unstable repository.
> Use the stable snapshot archive instead.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/acceptance/boot_linux_console.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 4e9ac0ecc3..f5aa87317c 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -479,7 +479,8 @@ class BootLinuxConsole(Test):
>          :avocado: tags=3Darch:m68k
>          :avocado: tags=3Dmachine:q800
>          """
> -        deb_url =3D ('http://ftp.ports.debian.org/debian-ports/pool-m68k=
/main'
> +        deb_url =3D ('https://snapshot.debian.org/archive/debian-ports'
> +                   '/20190922T090906Z/pool-m68k/main'
>                     '/l/linux/kernel-image-5.2.0-2-m68k-di_5.2.9-2_m68k.u=
deb')
>          deb_hash =3D '0797e05129595f22f3c0142db5e199769a723bf9'
>          deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)


--
Alex Benn=C3=A9e

