Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1C5C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:33:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A667A21A49
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="heBdtpaV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A667A21A49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAugc-0007xI-Op
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 07:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59967)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iAucQ-0003sp-K3
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iAucO-0003g9-Pv
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:29:02 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43564)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iAucO-0003ff-GK
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:29:00 -0400
Received: by mail-wr1-x443.google.com with SMTP id q17so2684981wrx.10
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 04:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=3VSlKKNw5EpL9Fi4aF6CtAPG6bR3KVIOfeYUVZua+a0=;
 b=heBdtpaVW3d33q0NoKJ4/oJweg6uAk6yyL/rFj8Ru94EhrJRIW43Zrnyn1/r9NSm/h
 5alddaG2Jt0FmDVsYi9YfY96OlJJCLJP3wCuBMC1POOaRJXNyUwLe4lha/XNlJ73Q5Mr
 N8Og01Tr06n/NbyLzOfJ9plzGIjeKzoqlfHVO/1wEDhCLMsJrwBuCnbBjkGjmK/M/tFU
 saO2NgSBkstDzissIg9yuCqBABC4wEV+kvr6zRNdiBMqZ+FsR99B2B0mVU/8tWHWsmjz
 G8qmM0MLnHrqJsEnB20/TXgD828xbWav2PmQrRimZxvvTJ129MT1XGCI/7UH6tLh2c7r
 qopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=3VSlKKNw5EpL9Fi4aF6CtAPG6bR3KVIOfeYUVZua+a0=;
 b=ZAGxcJt/8aNe0S9GnTvT4JfU2a14wWa88e9oLfL67BTHYMI/C/zeNKu9xhM3jO/MRp
 GvxbvLWm1HOY8JXsOrj8BvxIUtZ3dm4DRA65rvHKz1Ja1LdWL1xePRS6xGy9zztLvpUc
 w7ovH0SC2HiybBm0E00pZQkpI4QIaPfNhCE6dRPUDFMqUs8U62MD4lYHLCHJVIaOjOs6
 Cbt39e4VbmsWdD2xH6IUeu19IrphG9sZ0awTFUOzoJp57v3EFUkGSUc4Qw6c0xUmNocS
 0hgWwh2kanP9D69IiSKeEiCKLeNg1S9YOroYtR9o/Wzml8zspbvlfMZ/FxDvQvWXvyq5
 ZsXQ==
X-Gm-Message-State: APjAAAUWc89sgZq0Qb5iGCmPUHAmQ1r8WkBeHntE3lwp2m9DsHnmW5d3
 5aL+J1TJVamDPQB5kLviiJmMHg==
X-Google-Smtp-Source: APXvYqyGqvGuTmq1DXnyIEhojHqpmNblLoG+lbwdaHdm7n7bPXRoAXvFINzLTq0keRkW2ZplS8Rn4A==
X-Received: by 2002:a5d:4985:: with SMTP id r5mr6677105wrq.139.1568892539181; 
 Thu, 19 Sep 2019 04:28:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q192sm7110465wme.23.2019.09.19.04.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 04:28:58 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D8FD91FF87;
 Thu, 19 Sep 2019 12:28:57 +0100 (BST)
References: <20190919105932.19412-1-philmd@redhat.com>
 <20190919105932.19412-2-philmd@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
In-reply-to: <20190919105932.19412-2-philmd@redhat.com>
Date: Thu, 19 Sep 2019 12:28:57 +0100
Message-ID: <87pnjwzfra.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 1/2] tests/docker: Add
 fedora-win10sdk-cross image
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
Cc: Fam Zheng <fam@euphon.net>, Lucian Petrut <lpetrut@cloudbasesolutions.com>,
 Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org,
 Justin Terry <juterry@microsoft.com>, Ilias Maratos <i.maratos@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/docker/Makefile.include                 |  1 +
>  .../dockerfiles/fedora-win10sdk-cross.docker  | 21 +++++++++++++++++++
>  2 files changed, 22 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/fedora-win10sdk-cross.docker
>
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 50a400b573..0df72a810b 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -125,6 +125,7 @@ docker-image-debian-ppc64-cross: docker-image-debian10
>  docker-image-debian-riscv64-cross: docker-image-debian10
>  docker-image-debian-sh4-cross: docker-image-debian10
>  docker-image-debian-sparc64-cross: docker-image-debian10
> +docker-image-fedora-win10sdk-cross: docker-image-fedora
>
>  docker-image-travis: NOUSER=3D1
>
> diff --git a/tests/docker/dockerfiles/fedora-win10sdk-cross.docker b/test=
s/docker/dockerfiles/fedora-win10sdk-cross.docker
> new file mode 100644
> index 0000000000..1aafdad483
> --- /dev/null
> +++ b/tests/docker/dockerfiles/fedora-win10sdk-cross.docker
> @@ -0,0 +1,21 @@
> +#
> +# Docker MinGW64 cross-compiler target with WHPX header installed
> +#
> +# This docker target builds on the Fedora 30 base image.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +FROM qemu:fedora
> +
> +# Install headers extracted by the Android folks from the win10sdk.iso:
> +# https://developer.microsoft.com/en-us/windows/downloads/windows-10-sdk
> +ENV WIN10SDK_INCDIR /usr/local/include/win10sdk
> +RUN mkdir ${WIN10SDK_INCDIR} && \
> +    for hdr in WinHvEmulation.h WinHvPlatformDefs.h WinHvPlatform.h; do \
> +        curl -s "https://android.googlesource.com/platform/prebuilts/gcc=
/linux-x86/host/x86_64-w64-mingw32-4.8/+/1bde9c3b14f3a3b081ada6e32da9f28706=
71b46f/x86_64-w64-mingw32/include/${hdr}?format=3DTEXT" | base64 --decode >=
 ${WIN10SDK_INCDIR}/${hdr}; \
> +    done

Hmm I guess this is a stable URL as Google never deletes anything?

> +
> +ENV QEMU_CONFIGURE_OPTS ${QEMU_CONFIGURE_OPTS} \
> +    --cross-prefix=3Dx86_64-w64-mingw32- \
> +    --extra-cflags=3D"-I ${WIN10SDK_INCDIR}" --disable-werror \
> +    --enable-hax --enable-whpx


--
Alex Benn=C3=A9e

