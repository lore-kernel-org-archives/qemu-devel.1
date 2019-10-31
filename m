Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAD8CA9EC3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 08:08:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C91C12083E
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 08:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cemu9skb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91C12083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQ5VJ-0007yA-T3
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 04:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54459)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iQ5TI-0006bn-E8
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 04:06:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iQ5TG-0001Sm-VL
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 04:06:20 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36572)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iQ5TG-0001Ex-Nu
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 04:06:18 -0400
Received: by mail-wr1-x444.google.com with SMTP id w18so5147472wrt.3
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 01:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=uSU1Hfe4ZJeOSsSuq0fFiJDWHiNZAyaavATff2dhEpA=;
 b=cemu9skbjQrL8AYObqe/gyaEw1ewN/Iq7b7uqgSCURpiwafNDAEfb3k+XA9Qbk6Q1/
 eqLM3jB6AzkBEIGzhPz83TmsbovF2AFdva0F66g3RKTuHpZ3TB1TqqCP0EYTVPJvptn8
 lUHfByDSsC97CIAy3hq8HC3EPJtDUvwOCWhiKvg0traVyv7wczHTnkxiv0aI0mO8s77M
 Dzq8UXIm4XTmGFy/yDiTJG9EaQ8VnVlKq0F+HmTrEHLcEPN6h2KqyghSY2rprRJ6oU8U
 Ocp8XA26kyNkgiggy5x9osIDNmBkAHvV6WDGZhkzqbVFWXbgKB5Mlbb1qd/DxDKLDBBG
 qg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=uSU1Hfe4ZJeOSsSuq0fFiJDWHiNZAyaavATff2dhEpA=;
 b=UuRoG9Yx14q4CHkKUZCW9bOmX6/D/8oxkr/umjHZkJQZMrzt4Q8K6RGFVvij7oa/1x
 TD4SpRreaE5L84RvK0iEJqZ00y/S93tU4C5Q801lHkawrVEKkWIFgoCFthQFougYEANt
 vZgYCPCjaIDMMd3qJHGz8B7MuDHz+BsH0NjfgdsdEVRduz6DuJRYgcigBDE/D1TOOEk9
 +e4unnc/QaJ107AehkRFcNRg1ngyxY8Tn/sMy0XFm6l5w03d0FBzaXYlXF2YNnXwTCqG
 eQ455MJRFeCxiyWBSQffwDslKptun597teK/+R/nBZEH6OtpBviWvz8a0aSn3xF0VPRt
 IiOQ==
X-Gm-Message-State: APjAAAUV9wKfnf8x4zl4m5PE9d8rW22ykB3AhGIyMK0WRUiRB9HXnDTj
 6GAfzHB73DA/9qpLeUSKlgx5Mg==
X-Google-Smtp-Source: APXvYqwi93SCNhvX5XjN1aX/ZCrj5BQWAjcwC3q2FQ5JDg6Uiwe0ZNZOtaPQjz+FIYeEWQFbX7Np+A==
X-Received: by 2002:adf:e286:: with SMTP id v6mr4238886wri.241.1572509175755; 
 Thu, 31 Oct 2019 01:06:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g14sm3432003wro.33.2019.10.31.01.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2019 01:06:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E6B8B1FF87;
 Thu, 31 Oct 2019 08:06:13 +0000 (GMT)
References: <20191028181643.5143-12-laurent@vivier.eu>
 <20191029232320.12419-1-crosa@redhat.com>
 <20191029232320.12419-2-crosa@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] Acceptance test: cancel test if m68k kernel
 packages goes missing
In-reply-to: <20191029232320.12419-2-crosa@redhat.com>
Date: Thu, 31 Oct 2019 08:06:13 +0000
Message-ID: <87eeyt8hl6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
 Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Cleber Rosa <crosa@redhat.com> writes:

> The Linux kernel that is extracted from a Debian package for the q800
> machine test is hosted on a "pool" location.  AFAICT, it gets updated
> without too much ceremony, and I don't see any archival location that
> is stable enough.
>
> For now, to avoid test errors, let's cancel the test if fetching the
> package fails.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/acceptance/boot_linux_console.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index df27813c78..c439fd90fc 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -387,7 +387,10 @@ class BootLinuxConsole(Test):
>          deb_url =3D ('http://ftp.ports.debian.org/debian-ports/pool-m68k=
/main'
>                     '/l/linux/kernel-image-5.2.0-2-m68k-di_5.2.9-2_m68k.u=
deb')
>          deb_hash =3D '0797e05129595f22f3c0142db5e199769a723bf9'
> -        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> +        try:
> +            deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> +        except OSError as exp:
> +            self.cancel(exp)
>          kernel_path =3D self.extract_from_deb(deb_path,
>                                              '/boot/vmlinux-5.2.0-2-m68k')


--
Alex Benn=C3=A9e

