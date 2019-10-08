Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E646C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:36:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3779B21835
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W/9go3AS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3779B21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHrXc-0004Bj-BG
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 11:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iHrUY-0002P4-7n
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:33:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iHrUW-0002Lv-3F
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:33:38 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38954)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iHrUV-0002KG-SF
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:33:36 -0400
Received: by mail-wm1-x342.google.com with SMTP id v17so3591438wml.4
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 08:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=mDOcQmPtLUpUGIcrrYPFCPnMuA6mGl9Vl6I4vdY6RTw=;
 b=W/9go3ASjwyEs2nZuB20buh6iPif9TEf372TNe7CsrA/JOgW4tC0eEKxdur5UixHge
 fFXZhT1BvIMJrCvPM1XUV5E2YQXXJHK8muFyCUrrbtFM6rqJlsaAku0PpQIP077Gsniu
 NH5znVw5miP543rLbai4NarVlyoKAngVIz55fd55EG/YQMPp09u1HoBEiodSa0lclawS
 SiyoF3S1KkZJLPrkXD+uRXzlPG3TSBLahAvz17+D53YIhmYu8BLh5B1flesZIDC8Kxjd
 wmgIcK+XJX8ZIMHTA+A/sf02aT9Kr8kXJpzuLSfz7rNagURFL/G/wn5yv99vsoUU9LDB
 QVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=mDOcQmPtLUpUGIcrrYPFCPnMuA6mGl9Vl6I4vdY6RTw=;
 b=ZttFM2XRevLhWnQDKSzKdQz/cG08dGGnSH891/H7fz1CpMWiwRJvCiA8ScbHZcBsBa
 FX3FdKxJhf2Af7sp2HAD6xuwyvngogjD0Ya/JhQRZSBFGMlV8l6C5qPIkFNZ744npLGE
 0dGpP9q5q6BjD28UrFnb/oqbL/7VmneopeFXLRRXd0l6oaAbYFCrJouCLhnjR7UMb7nG
 uoMqjT5bgz5fOsHbpHEMb/FnX0niljOvd4836U/B8CjXSkk3BieKBmKGHpDxpw1t4qik
 R5G4MX0UgyJCDpOZjyUKhaMsQ0MLkB3ShZ7zl5JKH88c3KXFlWgPYmV86XS8SwkXtDuQ
 E3HA==
X-Gm-Message-State: APjAAAWYQKf16T4Fcbj/xvj+TDOFC1yvKMNvJWzDoSMFTUtZez6+g7f6
 uwvJZmIW0Dl0AscVWTN8vZtIHg==
X-Google-Smtp-Source: APXvYqxzjKoA3xJ/FYKRb1Bf7OGhOfQPQzmbQKfi89lUcjqcGyG0HbtVh/5VruaXoW4x6u0WK5NS8g==
X-Received: by 2002:a05:600c:143:: with SMTP id
 w3mr4047174wmm.35.1570548814723; 
 Tue, 08 Oct 2019 08:33:34 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t13sm46878630wra.70.2019.10.08.08.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 08:33:34 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6CC8F1FF87;
 Tue,  8 Oct 2019 16:33:33 +0100 (BST)
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-16-f4bug@amsat.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
Subject: Re: [PATCH 15/19] tests/boot_linux_console: Extract the gunzip()
 helper
In-reply-to: <20190926173428.10713-16-f4bug@amsat.org>
Date: Tue, 08 Oct 2019 16:33:33 +0100
Message-ID: <87o8yri75e.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?utf-8?Q?Zolt=C3=A1n?= Baldaszti <bztemail@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Philippe =?utf-8?Q?Mathieu-Dau?= =?utf-8?Q?d=C3=A9?= <f4bug@amsat.org>,
 Esteban Bosse <estebanbosse@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> We are going to use the same pattern. Instead of keeping
> copy/pasting this code, extract as a local function.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/acceptance/boot_linux_console.py | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 8a9a314ab4..079590f0c8 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -19,6 +19,11 @@ from avocado.utils import process
>  from avocado.utils import archive
>
>
> +def gunzip(in_pathname_gz, out_pathname):
> +    with gzip.open(in_pathname_gz, 'rb') as f_in:
> +        with open(out_pathname, 'wb') as f_out:
> +            shutil.copyfileobj(f_in, f_out)
> +
>  class BootLinuxConsole(Test):
>      """
>      Boots a Linux kernel and checks that the console is operational and =
the
> @@ -166,10 +171,7 @@ class BootLinuxConsole(Test):
>          initrd_hash =3D 'bf806e17009360a866bf537f6de66590de349a99'
>          initrd_path_gz =3D self.fetch_asset(initrd_url, asset_hash=3Dini=
trd_hash)
>          initrd_path =3D self.workdir + "rootfs.cpio"
> -
> -        with gzip.open(initrd_path_gz, 'rb') as f_in:
> -            with open(initrd_path, 'wb') as f_out:
> -                shutil.copyfileobj(f_in, f_out)
> +        gunzip(initrd_path_gz, initrd_path)
>
>          self.vm.set_machine('malta')
>          self.vm.set_console()


--
Alex Benn=C3=A9e

