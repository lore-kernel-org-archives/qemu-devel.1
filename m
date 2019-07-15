Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E5CC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:27:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0520E217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cBacO19Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0520E217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn1wU-0001SD-U6
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 10:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33609)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hn1wI-0000xe-8t
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:26:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hn1wH-0003uP-1d
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:26:50 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44960)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hn1wG-0003tk-Oj
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:26:48 -0400
Received: by mail-wr1-x444.google.com with SMTP id p17so17310001wrf.11
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 07:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=xidU/GH85Ja4Rud7Iin5N5XoJbOSfDZco9pJa91b46w=;
 b=cBacO19Q1OgjiE6t6Qb569/HleHBpXI2ZZamDFwHd6jJKeXjgQFIQ6/JbZvoohTc4l
 J9RShcia9lQ9Ox5LTUR0bok8iP2PjPQ4vFn70AE8gH0lWzOjg53UVJsGLEWsS+NnKNjj
 aBL/lQZagKB6vo0j4rJagzpIJ1Oqk0PQ5k0qrJJ4InHLzBASthB3pTCdG394qBAlAqHi
 N+W/J2m7Iddp3AnC7mJoxjXFVywi7lmVOZtCzjpRuebFNCI4A/bZm7S3bqUUwUGoiYUr
 urLEQjgTpEx0JV7hbwVANW6qAz1Mls7tZQOIvEKj8N2fTVtMFdTkA4+cmUU+6I8I41g4
 Zgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=xidU/GH85Ja4Rud7Iin5N5XoJbOSfDZco9pJa91b46w=;
 b=gpJ1SgGD4EsjU4mc/f/FV8ggXs+M5Zu8TUhKyneC4NqziyL2S7vzSvzZwU9k+I5Smx
 J2X0M9odAzUZrjJ3VOQGOAftoB0jDsWbd9RNo3sI6CVbjI69hRd5AoFBBNTGC/Q1Nih8
 Jr4r4m4j+lZsfybKGuSWUa0D/mj9Ib9J8VVUm70VhIRbqJv/Fb4fvaZqNYmWHqL05G0v
 bopx0HSO9Q00YSPNjEMhsxLtiNBexGcXS3PlOxRybIGwvhkHC8+Oq0EoSbaJdsfuUz28
 EaKbX+/jUJu75YIfzd5C+1vHHe+89kq49/TPW2d3HohOxbQFUdEamTktKLVxMRU7+KWO
 pwgg==
X-Gm-Message-State: APjAAAWiWI8S/vVqT1GqMaGmx+q2//pmX/6rfbAbkQ8G+1NRNEkJ2HzM
 pYOHI/aXe0VL8vrvIFlxTGeZkA==
X-Google-Smtp-Source: APXvYqym43iedSNGzzpJ92pMAGhJKJ8VAOOyNozAdgHDQXFryx4tq2hOT03bUSLHgC4trcADtVI0Kw==
X-Received: by 2002:a5d:4205:: with SMTP id n5mr22041060wrq.52.1563200807364; 
 Mon, 15 Jul 2019 07:26:47 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id s10sm21287724wmf.8.2019.07.15.07.26.46
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 15 Jul 2019 07:26:46 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 680C01FF87;
 Mon, 15 Jul 2019 15:26:46 +0100 (BST)
References: <20190713163558.13204-1-philmd@redhat.com>
 <20190713163558.13204-3-philmd@redhat.com>
User-agent: mu4e 1.3.3; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
In-reply-to: <20190713163558.13204-3-philmd@redhat.com>
Date: Mon, 15 Jul 2019 15:26:46 +0100
Message-ID: <87k1cjv0ex.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH 2/3] tests/docker: Install the NSIS tools
 in the MXE images
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
Cc: Fam Zheng <fam@euphon.net>, Stefan Weil <sw@weilnetz.de>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> This fixes:
>
>   $ make installer

We should probably be exercising this via test-mingw (and making it
usable for fedora/debian based mingw build)

>   (cd /tmp/qemu-nsis; \
>            for i in qemu-system-*.exe; do \
>              arch=3D${i%.exe}; \
>              arch=3D${arch#qemu-system-}; \
>              echo Section \"$arch\" Section_$arch; \
>              echo SetOutPath \"\$INSTDIR\"; \
>              echo File \"\${BINDIR}\\$i\"; \
>              echo SectionEnd; \
>            done \
>           ) >/tmp/qemu-nsis/system-emulations.nsh
>   makensis -V2 -NOCD \
>                   -DCONFIG_DOCUMENTATION=3D"y" \
>                    \
>                   -DBINDIR=3D"/tmp/qemu-nsis" \
>                    \
>                   -DSRCDIR=3D"/home/phil/source/qemu" \
>                   -DOUTFILE=3D"qemu-setup-4.0.90.exe" \
>                   -DDISPLAYVERSION=3D"4.0.90" \
>                   /home/phil/source/qemu/qemu.nsi
>   /bin/sh: 1: makensis: not found
>   Makefile:1077: recipe for target 'qemu-setup-4.0.90.exe' failed
>   make: *** [qemu-setup-4.0.90.exe] Error 127
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/docker/dockerfiles/debian-win32-cross.docker | 3 +++
>  tests/docker/dockerfiles/debian-win64-cross.docker | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/tests/docker/dockerfiles/debian-win32-cross.docker b/tests/d=
ocker/dockerfiles/debian-win32-cross.docker
> index c787e43245..77f5cc45e9 100644
> --- a/tests/docker/dockerfiles/debian-win32-cross.docker
> +++ b/tests/docker/dockerfiles/debian-win32-cross.docker
> @@ -9,6 +9,8 @@ MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
>  ENV TARGET i686
>
> +ENV PATH $PATH:/usr/lib/mxe/usr/$TARGET-w64-mingw32.shared/bin
> +
>  RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>      apt-get install -y --no-install-recommends \
>          mxe-$TARGET-w64-mingw32.shared-bzip2 \
> @@ -19,6 +21,7 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>          mxe-$TARGET-w64-mingw32.shared-lzo \
>          mxe-$TARGET-w64-mingw32.shared-nettle \
>          mxe-$TARGET-w64-mingw32.shared-ncurses \
> +        mxe-$TARGET-w64-mingw32.shared-nsis \
>          mxe-$TARGET-w64-mingw32.shared-pixman \
>          mxe-$TARGET-w64-mingw32.shared-pkgconf \
>          mxe-$TARGET-w64-mingw32.shared-pthreads \
> diff --git a/tests/docker/dockerfiles/debian-win64-cross.docker b/tests/d=
ocker/dockerfiles/debian-win64-cross.docker
> index a7068ed6ac..3908c5abc4 100644
> --- a/tests/docker/dockerfiles/debian-win64-cross.docker
> +++ b/tests/docker/dockerfiles/debian-win64-cross.docker
> @@ -9,6 +9,8 @@ MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
>  ENV TARGET x86-64
>
> +ENV PATH $PATH:/usr/lib/mxe/usr/$TARGET-w64-mingw32.shared/bin
> +
>  RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>      apt-get install -y --no-install-recommends \
>          mxe-$TARGET-w64-mingw32.shared-bzip2 \
> @@ -19,6 +21,7 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>          mxe-$TARGET-w64-mingw32.shared-lzo \
>          mxe-$TARGET-w64-mingw32.shared-nettle \
>          mxe-$TARGET-w64-mingw32.shared-ncurses \
> +        mxe-$TARGET-w64-mingw32.shared-nsis \
>          mxe-$TARGET-w64-mingw32.shared-pixman \
>          mxe-$TARGET-w64-mingw32.shared-pkgconf \
>          mxe-$TARGET-w64-mingw32.shared-pthreads \


--
Alex Benn=C3=A9e

