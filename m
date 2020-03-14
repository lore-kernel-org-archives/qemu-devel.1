Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93407C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 15:27:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52D252076A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 15:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T1FdWBxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52D252076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD8hT-0003Ur-Gf
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 11:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jD8gp-0002u8-6x
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 11:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jD8gn-00052l-UX
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 11:27:02 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52529)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jD8gn-00050R-M5
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 11:27:01 -0400
Received: by mail-wm1-x342.google.com with SMTP id 11so13009209wmo.2
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 08:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=8urM7fjhYUuOPh9InO+PZN7OPZ1xSvShLOU4AUd2NuY=;
 b=T1FdWBxWhgMhm+C3uX9/tOuSi9T8RA8DrZuPRyU85PpbUdUpvRC7TALNYv19zndLkG
 iDMd+K2+/rSqd43/I76F9Nj/3eDa03rZebMUuWl8SOOVqifKcHUDdUk/wd11PdU4nzas
 Z0yPr382skpHLl8fA4UItsQowJI0pXJ4iZNk9h8msy9oJ7+IrKOhtzXNxUgUL4I3isw3
 SIaDvQNFPsWJ/xE3NsaogogQCYlblxLfaAuNZsqH/rby1NGClBP2I7QQGpjIw9/O45R/
 mykatcq3WIkJd9PbmoxkT8OO1LLw9h/SouGA0gNDerDDduQY3Pvr/og399OBwa5qbxzp
 7TpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=8urM7fjhYUuOPh9InO+PZN7OPZ1xSvShLOU4AUd2NuY=;
 b=b/PgwWWXnERgAmaD1BfJbrScIhbRSjOUkbML+CqxhzJ2Zv9OSB/VKIsD1uBA9ibkAu
 5tHlfKO5JyuFtI5RYDqdGVKmWwJHPmFMsbGY0LcPWe+SdrMUFqTexh2Lyt942Vd1mjmJ
 DOUYPpr/XsjUJUcvibzXE3tU16wda8WevwDW+CPj7AmRnYVlhqNLLV0L+8zZAYmSZto5
 fU+MOW+xC0KaytvME1svWwm3zfxdMiH0mFIMWyOvxq3OBo3EinSVM/5l9Pcid5T0mmui
 2pWA2CUkgzNEN21NtYwA6XQfYZxxiwfiy7C4NiCpX7CRmBn9N26H9srQ+DVlJxcnKrI7
 gJiA==
X-Gm-Message-State: ANhLgQ3GUcmX+XHvgWx8vW9vr3wAfQimjCguJKiHYYwIBtUkXbRV/EZ6
 BnopstdQ9xa9mtBhVgGszuvTYA==
X-Google-Smtp-Source: ADFU+vusAQy0G9cVtT7//VB2EXBhsHs1mIHYtUfRX8qdxiSoMMUTlF7CNPbIP4B6DTAOS7FADFZcdQ==
X-Received: by 2002:a7b:c0c7:: with SMTP id s7mr16558733wmh.187.1584199620197; 
 Sat, 14 Mar 2020 08:27:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m11sm37950077wrn.92.2020.03.14.08.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Mar 2020 08:26:58 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9CD2C1FF7E;
 Sat, 14 Mar 2020 15:26:57 +0000 (GMT)
References: <20200312193616.438922-1-crosa@redhat.com>
 <20200312193616.438922-3-crosa@redhat.com>
User-agent: mu4e 1.3.9; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH 2/5] tests/docker: make "buildah bud" output similar to
 "docker build"
In-reply-to: <20200312193616.438922-3-crosa@redhat.com>
Date: Sat, 14 Mar 2020 15:26:57 +0000
Message-ID: <87h7yrneim.fsf@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Erik Skultety <eskultet@redhat.com>, Wainer Moschetta <wmoschet@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Cleber Rosa <crosa@redhat.com> writes:

> Podman users will most often be using buildah to build containers.
> Among the differences between "buildah bud|build-using-dockerfile" and
> a traditional "docker build" is that buildah does not run a container
> during build.
>
> To the best of my knowledge and experiments, this means that runtime
> variables, such as ENV from one base image will not propagate into
> another.  The end result is that the location for the cross compiler
> binaries, defined in the base "qemu/debian9-mxe" image, are not passed
> through this image.  Consequently, the cross compilers are not on PATH
> and the build fails.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/docker/dockerfiles/debian-win32-cross.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/docker/dockerfiles/debian-win32-cross.docker b/tests/d=
ocker/dockerfiles/debian-win32-cross.docker
> index 9d7053e59d..d16d6431bc 100644
> --- a/tests/docker/dockerfiles/debian-win32-cross.docker
> +++ b/tests/docker/dockerfiles/debian-win32-cross.docker
> @@ -9,7 +9,7 @@ MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20=20
>  ENV TARGET i686
>=20=20
> -ENV PATH $PATH:/usr/lib/mxe/usr/$TARGET-w64-mingw32.shared/bin
> +ENV PATH $PATH:/usr/lib/mxe/usr/bin:/usr/lib/mxe/usr/$TARGET-w64-mingw32=
.shared/bin
>=20=20
>  ENV PKG_CONFIG_PATH \
>      $PKG_CONFIG_PATH:/usr/lib/mxe/usr/$TARGET-w64-mingw32.shared/lib/pkg=
config


--=20
Alex Benn=C3=A9e

