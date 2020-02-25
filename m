Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF60C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:06:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58A0A2176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EFJ2KeEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A0A2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Zug-0001lM-AT
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:06:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZKm-0001KE-00
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:29:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZKk-0008Ba-PQ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:29:07 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42784)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6ZKk-0008B0-HZ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:29:06 -0500
Received: by mail-wr1-x442.google.com with SMTP id p18so10865707wre.9
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=5WxDWJthdvA1X7L0L1YFPMv5HWuuoeCHVHj6QeQTNh4=;
 b=EFJ2KeEbPMk5V6nPRoEUcBEyxv/FmM823G/vM6Sg8l/3GoGMz6w8KdR1VGak9uuMtL
 NtF8xeSMwg7zb+oiv7LwGJTwoo6oMwZP99EJd0HT9/NOthg6sSZZhmoA5+qnxEQtfird
 o0aefk/G7oYCLoA0Uimq9lvCC+eW1ebm0bMxGl5/hixc3/LbWwKXWboptTKpwP1XfIeS
 bLhojPsmvQsUHd8xp3lAiaIwwxh/TaHlAtea+8CN1ntYU6Ksw4a0gHCP96v5kgb7WRwI
 W2ki9VfuJvioKq01fNqzpyTrQC1JbYAfdOaGZjTWWkRr2U97PdTz8hrk/kNdTE/MPvLV
 45lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=5WxDWJthdvA1X7L0L1YFPMv5HWuuoeCHVHj6QeQTNh4=;
 b=TFtqLc+wAXt2EqFLk26i+phwcQXavdn0VdX6AsmGXXZzYlT2nLJ6Kn/WmvgTDGLslF
 OUqdNrOOlvPSUapGVtTYXglNnRCebUx9VG8SHur9WLhVmGrdwsPLwwiKcXpWckrRAAeb
 sIytC4FbdIyXQvx8WazEdR5jZxrMLG1YQ6Yubecc0wDHLxtTAAVASxkbfK1y9IiYMGgQ
 su3pUlkrb4Zy6nclI+v3V2y0RneoHSWiwsxj2fYGmrZkx3os6ilZb7w7wYnxpqMKnLfF
 2D0SLI5bRx8TwPm273k/NfCxh1sGdFAWmo+I7SecIJ7yJuh/3DPOg/5T5bWdnQhV+Kq5
 nDWw==
X-Gm-Message-State: APjAAAWFCo0BqW8j5pK0fbSjJkqYxxXSWZM+IqoesS7SHuSPfgCoU0tj
 60WHD4ebtKwhciJ+6zGZ8Pfn+w==
X-Google-Smtp-Source: APXvYqxzG8GUuGzlTcSyVRVp4TP1D2M2bAYtEkIc753RFtPsADGAW0naTedCPF75CMy7OhnuoHP76g==
X-Received: by 2002:adf:8b59:: with SMTP id v25mr76054513wra.419.1582633744786; 
 Tue, 25 Feb 2020 04:29:04 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y185sm4147347wmg.2.2020.02.25.04.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 04:29:03 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C56E81FF87;
 Tue, 25 Feb 2020 12:29:02 +0000 (GMT)
References: <20200218142018.7224-1-philmd@redhat.com>
 <20200218142018.7224-4-philmd@redhat.com>
User-agent: mu4e 1.3.8; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH RESEND 3/3] .travis.yml: Test building with Xcode 11.3
In-reply-to: <20200218142018.7224-4-philmd@redhat.com>
Date: Tue, 25 Feb 2020 12:29:02 +0000
Message-ID: <874kvezw8h.fsf@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> We currently run a CI job on macOS Mojave with Xcode 10.
>
> QEMU policy is to support the two last major OS releases.
> Add a job building on macOS Catalina, which comes with Xcode 11.
>
> Split the target list in two, as we don't need to cover twice the
> same targets.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  .travis.yml | 36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index a2a7fd0dd1..d02a477623 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -269,9 +269,10 @@ matrix:
>=20=20
>      # MacOSX builds - cirrus.yml also tests some MacOS builds including =
latest Xcode
>=20=20
> +    # On macOS Mojave, the SDK comes bundled with Xcode 10.
>      - name: "OSX Xcode 10.3"
>        env:
> -        - CONFIG=3D"--target-list=3Di386-softmmu,ppc-softmmu,ppc64-softm=
mu,m68k-softmmu,x86_64-softmmu --extra-cflags=3D-I/usr/local/opt/ncurses/in=
clude --extra-ldflags=3D-L/usr/local/opt/ncurses/lib"
> +        - CONFIG=3D"--target-list=3Di386-softmmu,ppc-softmmu,ppc64-softm=
mu,m68k-softmmu --extra-cflags=3D-I/usr/local/opt/ncurses/include --extra-l=
dflags=3D-L/usr/local/opt/ncurses/lib"
>        os: osx
>        osx_image: xcode10.3
>        compiler: clang
> @@ -301,6 +302,39 @@ matrix:
>          - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.=
log && exit 1; }
>=20=20
>=20=20
> +    # On macOS Catalina, the SDK comes bundled with Xcode 11.
> +    - name: "OSX Xcode 11.3"
> +      env:
> +        - CONFIG=3D"--target-list=3Darm-softmmu,ppc64-softmmu,x86_64-sof=
tmmu --extra-cflags=3D-I/usr/local/opt/ncurses/include --extra-ldflags=3D-L=
/usr/local/opt/ncurses/lib"
> +      os: osx
> +      osx_image: xcode11.3

Are we duplicating what the latest Xcode on Cirrus is here?

--=20
Alex Benn=C3=A9e

