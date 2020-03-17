Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567F6C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:11:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F6B220735
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pB9zVsZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6B220735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37351 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEFkg-0005BM-9r
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 13:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEFjB-0003QH-PP
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:10:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEFjA-00031x-8j
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:10:05 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42568)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEFj9-0002xS-W8
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:10:04 -0400
Received: by mail-ot1-x341.google.com with SMTP id a2so1577897otq.9
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 10:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Oqf3CeiMURWg/kHx7LuKUIhd9FQXiF+rtMRHXyPHTVg=;
 b=pB9zVsZYazkRv45is+O4KOOSQxAuPbefsApjsxsLKS8oAxBGq9A0YNk+IliO0fFtJA
 WnZqrJvT30Y7N3lxNr3alAPzehxv5YaUznk0h4f1ubi3Yt8gKS9t711t5e7WuKdbNQcR
 l3AE6jBq0+PQUxmUSg0mDBtT2msFASvMcrEdaFuf++3i8NY7h515/JkgZJUAJYbV0LKR
 vcA11NdbgBF23i+YUmI4BQzF6AUCGEtR3vQwHQXAA39E/Se4nKXm/66Xok3FO95Wqbhx
 EDBROkcFuUcjs7RJDBxnnsOi5fZAZ+iD2cEjeDx6lobHmM8b37jyMN4Jd/35akaAHzkT
 6r6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Oqf3CeiMURWg/kHx7LuKUIhd9FQXiF+rtMRHXyPHTVg=;
 b=Z8Xzy8ze/rQhcUrzEC0KlfSNwa5xypt3xi/iYi68/RNF4f87iI6QbjIh56wxozct5+
 yIdsa7YgDch1gvPWbSzgkQ+ZGwEQmY5XdHvUKt6+VqVigP5Gelg8HuGOD0IE/RYtWeX7
 S3FCG10bgcDIf9dLk0p6rFGHmwjiDyKHYJJxgdyKY4AI79rtzSsrKHrbLlqgTWnQ4umT
 yfK/4NmyE/JGcuNHzGwLQ1VsERVWhtFpryT0fJqrC4ICZogwHxGfeY/pGZ1E4GEKSebt
 9iqmwao8UxwMeg0EGCBZC80zIsFQlz1O+y93oVm8PmQji1IjiwFuul2RWd4na7AwIGBf
 m17g==
X-Gm-Message-State: ANhLgQ3ytqNB9raECvWHDbK004VJbPFx+ja+1QJQ8zJ5l8FxM9fRUCeI
 Y2D5n9Sr0hVOKWie0xPzEm5OufwX50OkJVt73sQ90FONghg=
X-Google-Smtp-Source: ADFU+vsx1ta36Oj0674FtqNV05XszdBYzhlNq6irUeBatXAHPnTYWUsT/XFgG84rg8kRbYI41WCjX344smYN5RUiQNc=
X-Received: by 2002:a9d:76c9:: with SMTP id p9mr190372otl.135.1584465003085;
 Tue, 17 Mar 2020 10:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200228092420.103757-1-quintela@redhat.com>
 <20200228092420.103757-7-quintela@redhat.com>
In-Reply-To: <20200228092420.103757-7-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Mar 2020 17:09:51 +0000
Message-ID: <CAFEAcA86cH=XEg5aW8rg1vp9j3Ug=Gozk0m4hYZ-fiQ38J35aw@mail.gmail.com>
Subject: Re: [PULL 06/15] configure: Enable test and libs for zstd
To: Juan Quintela <quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 28 Feb 2020 at 09:28, Juan Quintela <quintela@redhat.com> wrote:
>
> Add it to several build systems to make testing good.
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  .gitlab-ci.yml                                |  1 +
>  .travis.yml                                   |  1 +
>  configure                                     | 30 +++++++++++++++++++
>  tests/docker/dockerfiles/centos7.docker       |  3 +-
>  .../dockerfiles/fedora-i386-cross.docker      |  3 +-
>  tests/docker/dockerfiles/fedora.docker        |  3 +-
>  tests/docker/dockerfiles/ubuntu.docker        |  1 +
>  tests/docker/dockerfiles/ubuntu1804.docker    |  1 +
>  tests/vm/fedora                               |  5 +++-
>  tests/vm/freebsd                              |  3 ++
>  tests/vm/netbsd                               |  3 ++
>  tests/vm/openbsd                              |  3 ++
>  12 files changed, 53 insertions(+), 4 deletions(-)

Hi; this patch changes some .docker files, but it has
put the new line at the bottom of each package list,
rather than at the correct point in the alphabetical
order that the lists are in, for these 3 fedora/centos ones:

> diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dockerfiles/centos7.docker
> index 562d65be9e..cdd72de7eb 100644
> --- a/tests/docker/dockerfiles/centos7.docker
> +++ b/tests/docker/dockerfiles/centos7.docker
> @@ -33,6 +33,7 @@ ENV PACKAGES \
>      tar \
>      vte-devel \
>      xen-devel \
> -    zlib-devel
> +    zlib-devel \
> +    libzstd-devel
>  RUN yum install -y $PACKAGES
>  RUN rpm -q $PACKAGES | sort > /packages.txt
> diff --git a/tests/docker/dockerfiles/fedora-i386-cross.docker b/tests/docker/dockerfiles/fedora-i386-cross.docker
> index 9106cf9ebe..cd16cd1bfa 100644
> --- a/tests/docker/dockerfiles/fedora-i386-cross.docker
> +++ b/tests/docker/dockerfiles/fedora-i386-cross.docker
> @@ -7,7 +7,8 @@ ENV PACKAGES \
>      gnutls-devel.i686 \
>      nettle-devel.i686 \
>      pixman-devel.i686 \
> -    zlib-devel.i686
> +    zlib-devel.i686 \
> +    libzstd-devel.i686
>
>  RUN dnf install -y $PACKAGES
>  RUN rpm -q $PACKAGES | sort > /packages.txt
> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
> index 987a3c170a..a6522228c0 100644
> --- a/tests/docker/dockerfiles/fedora.docker
> +++ b/tests/docker/dockerfiles/fedora.docker
> @@ -92,7 +92,8 @@ ENV PACKAGES \
>      vte291-devel \
>      which \
>      xen-devel \
> -    zlib-devel
> +    zlib-devel \
> +    libzstd-devel
>  ENV QEMU_CONFIGURE_OPTS --python=/usr/bin/python3
>
>  RUN dnf install -y $PACKAGES

The ubuntu ones are OK though:

> diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfiles/ubuntu.docker
> index 4177f33691..b6c7b41ddd 100644
> --- a/tests/docker/dockerfiles/ubuntu.docker
> +++ b/tests/docker/dockerfiles/ubuntu.docker
> @@ -58,6 +58,7 @@ ENV PACKAGES flex bison \
>      libvdeplug-dev \
>      libvte-2.91-dev \
>      libxen-dev \
> +    libzstd-dev \
>      make \
>      python3-yaml \
>      python3-sphinx \
> diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/dockerfiles/ubuntu1804.docker
> index 0766f94cf4..1efedeef99 100644
> --- a/tests/docker/dockerfiles/ubuntu1804.docker
> +++ b/tests/docker/dockerfiles/ubuntu1804.docker
> @@ -44,6 +44,7 @@ ENV PACKAGES flex bison \
>      libvdeplug-dev \
>      libvte-2.91-dev \
>      libxen-dev \
> +    libzstd-dev \
>      make \
>      python3-yaml \
>      python3-sphinx \


Could somebody send a patch that fixes up the ordering,
please?

thanks
-- PMM

