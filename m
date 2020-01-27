Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFDFC33CB1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 19:40:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A7E324679
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 19:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSknMuwG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7E324679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwAFP-00085F-PU
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 14:40:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwADL-0005ox-UK
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:38:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwADJ-0004fS-KJ
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:38:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26147
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwADJ-0004fE-Fm
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:38:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580153905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qkMecImG3rMWf8+JBYkWZB7fvAqcQupl2je140SFll4=;
 b=JSknMuwGR+yGrt7ZSc72KL8IeZQmqibBM9noz5sKX2GU+y6xlvrwTeABN7675PKo0osGBi
 rmp09QKNvBV5Gb9ldYmDJYDGr5CeXqYZ/B3nmKCFwH+DFcawc8qXn3GwX1Zwi/+b13axBd
 VDL//KSddeyuZTt+aTZRgm2Qx2o8+UA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-Y5YeObU0N16drQSwvvvCOQ-1; Mon, 27 Jan 2020 14:38:23 -0500
Received: by mail-wm1-f71.google.com with SMTP id b133so1962071wmb.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 11:38:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tQTITZqzuIkj8lv/WQX/4kxGZwtENH88gD7RT9uFXM0=;
 b=g3Z1xO1k/StzCRE910qwyl6fCsVTzBViasWytIesvGullXgGcJxp9paQWRr+ee2NRx
 b60ApGVpqeJrykdFCLsyPwUxVI3wGyVaSTAlZR5oFPVe1EYglC9Ia8ieyyzS5ubo+d7P
 Ykg486q9oZ7l6pvdp/dzfUV0H6tXSi/R6Rxe2x7IOqSvOD5cCDxHBs1UBlThO7NpMm1c
 lSjPgk8WLJZ/rUR6swEpjJ9UHChH64SwWnlMUixnZEIPuvjCxshONeCRGAseH6CDQ5cX
 hxPJBEk/oIcLCVBXOLEQw+KQLrINO0hjvAdDWFW2sg6i7CmYvPlF7Upm9zP6LmmRkO09
 wz1A==
X-Gm-Message-State: APjAAAWKMyn2S+AswboWqaLdNC+X9QmiZPKDLWVXeby457vdenWg0pGU
 CGRTZaV6yR6qIoFX3spbTO/QlHFfTCQXcCVaL7BG6QqR7zV9UA7sR+nxat4TfNRQDP60AvgVNCT
 Up97/0drNrrfIe5o=
X-Received: by 2002:a5d:6406:: with SMTP id z6mr23684903wru.294.1580153902160; 
 Mon, 27 Jan 2020 11:38:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqypeDYvs5GLo1ml+LSDAk5KqB41jR2B2BwpSP06+s/+7mLEE35gsMkuofWbqjfclkQ6AX/EyA==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr23684857wru.294.1580153901744; 
 Mon, 27 Jan 2020 11:38:21 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id f12sm19511587wmj.10.2020.01.27.11.38.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2020 11:38:21 -0800 (PST)
Subject: Re: [PATCH v1 12/13] tests/docker: re-enable cross-compiling for
 x86_64 hosts
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200124204026.2107-1-alex.bennee@linaro.org>
 <20200124204026.2107-13-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <066bd5bc-c6b8-33fe-bcd9-2d4e7172d72d@redhat.com>
Date: Mon, 27 Jan 2020 20:38:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200124204026.2107-13-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: Y5YeObU0N16drQSwvvvCOQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/24/20 9:40 PM, Alex Benn=C3=A9e wrote:
> Now we have moved everything around we can re-enable the builds for
> x86_64. Thanks to the descriptive names we are able to sort out QEMU
> build and tests build dockerfiles and ensure the correct debian
> dependencies.
>=20
> Move the fedora, mxe and travis dockerfiles into the x86_64 directory
> as they cannot be used on other architectures.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   .../dockerfiles.x86_64/Makefile.include       | 26 +++++++++++++++++++
>   .../debain10-x86_64-qemu-build.docker         |  1 +
>   .../debian10-alpha-build-tests.docker         |  1 +
>   .../debian10-amd64-build-qemu.docker          |  1 +
>   .../debian10-arm64-build-qemu.docker          |  1 +
>   .../debian10-armel-build-qemu.docker          |  1 +
>   .../debian10-armhf-build-qemu.docker          |  1 +
>   .../debian10-hppa-build-tests.docker          |  1 +
>   .../debian10-m68k-build-tests.docker          |  1 +
>   .../debian10-mips-build-qemu.docker           |  1 +
>   .../debian10-mips64-build-tests.docker        |  1 +
>   .../debian10-mips64el-build-qemu.docker       |  1 +
>   .../debian10-mipsel-build-qemu.docker         |  1 +
>   .../debian10-native-qemu-build.docker         |  1 +
>   .../debian10-powerpc-build-tests.docker       |  1 +
>   .../debian10-ppc64-build-tests.docker         |  1 +
>   .../debian10-ppc64el-build-qemu.docker        |  1 +
>   .../debian10-riscv64-build-tests.docker       |  1 +
>   .../debian10-s390x-build-qemu.docker          |  1 +
>   .../debian10-sh4-build-tests.docker           |  1 +
>   .../debian10-sparc64-build-tests.docker       |  1 +
>   .../debian9-mxe-win32-build-qemu.docker       |  0
>   .../debian9-mxe-win64-build-qemu.docker       |  0
>   .../debian9-mxe.docker                        |  0
>   .../debian9-tricore-build-tests.docker        |  1 +
>   .../debian9-xtensa-build-tests.docker         |  1 +
>   .../fedora-cris-build-tests.docker            |  1 +
>   .../fedora-i386-build-tests.docker            |  1 +
>   .../travis.docker                             |  0
>   29 files changed, 50 insertions(+)
>   create mode 100644 tests/docker/dockerfiles.x86_64/Makefile.include
>   create mode 120000 tests/docker/dockerfiles.x86_64/debain10-x86_64-qemu=
-build.docker
>   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-alpha-build=
-tests.docker
>   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-amd64-build=
-qemu.docker
>   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-arm64-build=
-qemu.docker
>   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-armel-build=
-qemu.docker
>   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-armhf-build=
-qemu.docker
>   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-hppa-build-=
tests.docker
>   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-m68k-build-=
tests.docker
>   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-mips-build-=
qemu.docker
>   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-mips64-buil=
d-tests.docker
>   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-mips64el-bu=
ild-qemu.docker
>   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-mipsel-buil=
d-qemu.docker
>   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-native-qemu=
-build.docker
>   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-powerpc-bui=
ld-tests.docker
>   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-ppc64-build=
-tests.docker
>   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-ppc64el-bui=
ld-qemu.docker
>   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-riscv64-bui=
ld-tests.docker
>   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-s390x-build=
-qemu.docker
>   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-sh4-build-t=
ests.docker
>   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-sparc64-bui=
ld-tests.docker
>   rename tests/docker/{dockerfiles.cross =3D> dockerfiles.x86_64}/debian9=
-mxe-win32-build-qemu.docker (100%)
>   rename tests/docker/{dockerfiles.cross =3D> dockerfiles.x86_64}/debian9=
-mxe-win64-build-qemu.docker (100%)
>   rename tests/docker/{dockerfiles =3D> dockerfiles.x86_64}/debian9-mxe.d=
ocker (100%)
>   create mode 120000 tests/docker/dockerfiles.x86_64/debian9-tricore-buil=
d-tests.docker
>   create mode 120000 tests/docker/dockerfiles.x86_64/debian9-xtensa-build=
-tests.docker
>   create mode 120000 tests/docker/dockerfiles.x86_64/fedora-cris-build-te=
sts.docker
>   create mode 120000 tests/docker/dockerfiles.x86_64/fedora-i386-build-te=
sts.docker
>   rename tests/docker/{dockerfiles =3D> dockerfiles.x86_64}/travis.docker=
 (100%)
>=20
> diff --git a/tests/docker/dockerfiles.x86_64/Makefile.include b/tests/doc=
ker/dockerfiles.x86_64/Makefile.include
> new file mode 100644
> index 0000000000..6237eb500e
> --- /dev/null
> +++ b/tests/docker/dockerfiles.x86_64/Makefile.include
> @@ -0,0 +1,26 @@
> +# -*- Mode: makefile -*-
> +#
> +# x86_64 Containers
> +#
> +# This architecture has by far the largest number of cross compilers
> +# enabled for it.
> +#
> +
> +X86_64_BASE =3D $(DOCKER_BASE)/dockerfiles.x86_64
> +VPATH +=3D $(X86_64_BASE)
> +
> +#
> +# We have both QEMU build and TEST build containers we can access
> +#
> +QEMU_BUILD_CONTAINERS +=3D $(call get-basenames,$(wildcard $(X86_64_BASE=
)/*-build-qemu.docker))
> +TEST_BUILD_CONTAINERS +=3D $(call get-basenames,$(wildcard $(X86_64_BASE=
)/*-build-tests.docker))
> +
> +# Generate build-deps based on names
> +#
> +# Most of this architecture are based on Debian images
> +X86_64_CONTAINERS=3D$(call get-basenames,$(wildcard $(X86_64_BASE)/*.doc=
ker))
> +$(filter-out,debian9,$(X86_64_CONTAINERS)): docker-image-debian9
> +$(filter-out,debian10,$(X86_64_CONTAINERS)): docker-image-debian10
> +
> +# MXE windows cross compilers are all based on stretch
> +debian9-mxe-%: docker-image-debian9-mxe
> diff --git a/tests/docker/dockerfiles.x86_64/debain10-x86_64-qemu-build.d=
ocker b/tests/docker/dockerfiles.x86_64/debain10-x86_64-qemu-build.docker
> new file mode 120000
> index 0000000000..cd1caa0704
> --- /dev/null
> +++ b/tests/docker/dockerfiles.x86_64/debain10-x86_64-qemu-build.docker
> @@ -0,0 +1 @@
> +../dockerfiles/debian10-native-qemu-build.docker
> \ No newline at end of file
> diff --git a/tests/docker/dockerfiles.x86_64/debian10-alpha-build-tests.d=
ocker b/tests/docker/dockerfiles.x86_64/debian10-alpha-build-tests.docker
> new file mode 120000
> index 0000000000..614c8525ef
> --- /dev/null
> +++ b/tests/docker/dockerfiles.x86_64/debian10-alpha-build-tests.docker
> @@ -0,0 +1 @@
> +../dockerfiles.cross/debian10-alpha-build-tests.docker
> \ No newline at end of file

On Aarch64:

$ make docker-image V=3D1
./tests/docker/docker.py --engine auto build qemu:debian10=20
./tests/docker/dockerfiles.multiarch/debian10.docker   --add-current-user
Sending build context to Docker daemon  3.072kB
Step 1/5 : FROM debian:buster-slim
[...]
Successfully tagged qemu:debian10
./tests/docker/docker.py --engine auto build qemu:debian9=20
./tests/docker/dockerfiles.multiarch/debian9.docker   --add-current-user
Image is up to date.
make: *** No rule to make target=20
'docker-image-debian10-alpha-test-build', needed by 'docker-image'.  Stop.

> diff --git a/tests/docker/dockerfiles.x86_64/debian10-amd64-build-qemu.do=
cker b/tests/docker/dockerfiles.x86_64/debian10-amd64-build-qemu.docker
> new file mode 120000
> index 0000000000..81aa695b35
> --- /dev/null
> +++ b/tests/docker/dockerfiles.x86_64/debian10-amd64-build-qemu.docker
> @@ -0,0 +1 @@
> +../dockerfiles.cross/debian10-amd64-build-qemu.docker
> \ No newline at end of file
> diff --git a/tests/docker/dockerfiles.x86_64/debian10-arm64-build-qemu.do=
cker b/tests/docker/dockerfiles.x86_64/debian10-arm64-build-qemu.docker
> new file mode 120000
> index 0000000000..911274674a
> --- /dev/null
> +++ b/tests/docker/dockerfiles.x86_64/debian10-arm64-build-qemu.docker
> @@ -0,0 +1 @@
> +../dockerfiles.cross/debian10-arm64-build-qemu.docker
> \ No newline at end of file
> diff --git a/tests/docker/dockerfiles.x86_64/debian10-armel-build-qemu.do=
cker b/tests/docker/dockerfiles.x86_64/debian10-armel-build-qemu.docker
> new file mode 120000
> index 0000000000..ad6302f721
> --- /dev/null
> +++ b/tests/docker/dockerfiles.x86_64/debian10-armel-build-qemu.docker
> @@ -0,0 +1 @@
> +../dockerfiles.cross/debian10-armel-build-qemu.docker
> \ No newline at end of file
> diff --git a/tests/docker/dockerfiles.x86_64/debian10-armhf-build-qemu.do=
cker b/tests/docker/dockerfiles.x86_64/debian10-armhf-build-qemu.docker
> new file mode 120000
> index 0000000000..a5111afb01
> --- /dev/null
> +++ b/tests/docker/dockerfiles.x86_64/debian10-armhf-build-qemu.docker
> @@ -0,0 +1 @@
> +../dockerfiles.cross/debian10-armhf-build-qemu.docker
> \ No newline at end of file
> diff --git a/tests/docker/dockerfiles.x86_64/debian10-hppa-build-tests.do=
cker b/tests/docker/dockerfiles.x86_64/debian10-hppa-build-tests.docker
> new file mode 120000
> index 0000000000..4ce5da228d
> --- /dev/null
> +++ b/tests/docker/dockerfiles.x86_64/debian10-hppa-build-tests.docker
> @@ -0,0 +1 @@
> +../dockerfiles.cross/debian10-hppa-build-tests.docker
> \ No newline at end of file
> diff --git a/tests/docker/dockerfiles.x86_64/debian10-m68k-build-tests.do=
cker b/tests/docker/dockerfiles.x86_64/debian10-m68k-build-tests.docker
> new file mode 120000
> index 0000000000..402972365f
> --- /dev/null
> +++ b/tests/docker/dockerfiles.x86_64/debian10-m68k-build-tests.docker
> @@ -0,0 +1 @@
> +../dockerfiles.cross/debian10-m68k-build-tests.docker
> \ No newline at end of file
> diff --git a/tests/docker/dockerfiles.x86_64/debian10-mips-build-qemu.doc=
ker b/tests/docker/dockerfiles.x86_64/debian10-mips-build-qemu.docker
> new file mode 120000
> index 0000000000..9b4fc155f3
> --- /dev/null
> +++ b/tests/docker/dockerfiles.x86_64/debian10-mips-build-qemu.docker
> @@ -0,0 +1 @@
> +../dockerfiles.cross/debian10-mips-build-qemu.docker
> \ No newline at end of file
> diff --git a/tests/docker/dockerfiles.x86_64/debian10-mips64-build-tests.=
docker b/tests/docker/dockerfiles.x86_64/debian10-mips64-build-tests.docker
> new file mode 120000
> index 0000000000..89fef7d8ac
> --- /dev/null
> +++ b/tests/docker/dockerfiles.x86_64/debian10-mips64-build-tests.docker
> @@ -0,0 +1 @@
> +../dockerfiles.cross/debian10-mips64-build-tests.docker
> \ No newline at end of file
> diff --git a/tests/docker/dockerfiles.x86_64/debian10-mips64el-build-qemu=
.docker b/tests/docker/dockerfiles.x86_64/debian10-mips64el-build-qemu.dock=
er
> new file mode 120000
> index 0000000000..1ef8ccfec6
> --- /dev/null
> +++ b/tests/docker/dockerfiles.x86_64/debian10-mips64el-build-qemu.docker
> @@ -0,0 +1 @@
> +../dockerfiles.cross/debian10-mips64el-build-qemu.docker
> \ No newline at end of file
> diff --git a/tests/docker/dockerfiles.x86_64/debian10-mipsel-build-qemu.d=
ocker b/tests/docker/dockerfiles.x86_64/debian10-mipsel-build-qemu.docker
> new file mode 120000
> index 0000000000..9c1a090aba
> --- /dev/null
> +++ b/tests/docker/dockerfiles.x86_64/debian10-mipsel-build-qemu.docker
> @@ -0,0 +1 @@
> +../dockerfiles.cross/debian10-mipsel-build-qemu.docker
> \ No newline at end of file
> diff --git a/tests/docker/dockerfiles.x86_64/debian10-native-qemu-build.d=
ocker b/tests/docker/dockerfiles.x86_64/debian10-native-qemu-build.docker
> new file mode 120000
> index 0000000000..cd1caa0704
> --- /dev/null
> +++ b/tests/docker/dockerfiles.x86_64/debian10-native-qemu-build.docker
> @@ -0,0 +1 @@
> +../dockerfiles/debian10-native-qemu-build.docker
> \ No newline at end of file
> diff --git a/tests/docker/dockerfiles.x86_64/debian10-powerpc-build-tests=
.docker b/tests/docker/dockerfiles.x86_64/debian10-powerpc-build-tests.dock=
er
> new file mode 120000
> index 0000000000..2480077366
> --- /dev/null
> +++ b/tests/docker/dockerfiles.x86_64/debian10-powerpc-build-tests.docker
> @@ -0,0 +1 @@
> +../dockerfiles.cross/debian10-powerpc-build-tests.docker
> \ No newline at end of file
> diff --git a/tests/docker/dockerfiles.x86_64/debian10-ppc64-build-tests.d=
ocker b/tests/docker/dockerfiles.x86_64/debian10-ppc64-build-tests.docker
> new file mode 120000
> index 0000000000..e9290dcf63
> --- /dev/null
> +++ b/tests/docker/dockerfiles.x86_64/debian10-ppc64-build-tests.docker
> @@ -0,0 +1 @@
> +../dockerfiles.cross/debian10-ppc64-build-tests.docker
> \ No newline at end of file
> diff --git a/tests/docker/dockerfiles.x86_64/debian10-ppc64el-build-qemu.=
docker b/tests/docker/dockerfiles.x86_64/debian10-ppc64el-build-qemu.docker
> new file mode 120000
> index 0000000000..6c1639cf6d
> --- /dev/null
> +++ b/tests/docker/dockerfiles.x86_64/debian10-ppc64el-build-qemu.docker
> @@ -0,0 +1 @@
> +../dockerfiles.cross/debian10-ppc64el-build-qemu.docker
> \ No newline at end of file
> diff --git a/tests/docker/dockerfiles.x86_64/debian10-riscv64-build-tests=
.docker b/tests/docker/dockerfiles.x86_64/debian10-riscv64-build-tests.dock=
er
> new file mode 120000
> index 0000000000..06493c2663
> --- /dev/null
> +++ b/tests/docker/dockerfiles.x86_64/debian10-riscv64-build-tests.docker
> @@ -0,0 +1 @@
> +../dockerfiles.cross/debian10-riscv64-build-tests.docker
> \ No newline at end of file
> diff --git a/tests/docker/dockerfiles.x86_64/debian10-s390x-build-qemu.do=
cker b/tests/docker/dockerfiles.x86_64/debian10-s390x-build-qemu.docker
> new file mode 120000
> index 0000000000..f08338748e
> --- /dev/null
> +++ b/tests/docker/dockerfiles.x86_64/debian10-s390x-build-qemu.docker
> @@ -0,0 +1 @@
> +../dockerfiles.cross/debian10-s390x-build-qemu.docker
> \ No newline at end of file
> diff --git a/tests/docker/dockerfiles.x86_64/debian10-sh4-build-tests.doc=
ker b/tests/docker/dockerfiles.x86_64/debian10-sh4-build-tests.docker
> new file mode 120000
> index 0000000000..771ac25b23
> --- /dev/null
> +++ b/tests/docker/dockerfiles.x86_64/debian10-sh4-build-tests.docker
> @@ -0,0 +1 @@
> +../dockerfiles.cross/debian10-sh4-build-tests.docker
> \ No newline at end of file
> diff --git a/tests/docker/dockerfiles.x86_64/debian10-sparc64-build-tests=
.docker b/tests/docker/dockerfiles.x86_64/debian10-sparc64-build-tests.dock=
er
> new file mode 120000
> index 0000000000..0187622e06
> --- /dev/null
> +++ b/tests/docker/dockerfiles.x86_64/debian10-sparc64-build-tests.docker
> @@ -0,0 +1 @@
> +../dockerfiles.cross/debian10-sparc64-build-tests.docker
> \ No newline at end of file
> diff --git a/tests/docker/dockerfiles.cross/debian9-mxe-win32-build-qemu.=
docker b/tests/docker/dockerfiles.x86_64/debian9-mxe-win32-build-qemu.docke=
r
> similarity index 100%
> rename from tests/docker/dockerfiles.cross/debian9-mxe-win32-build-qemu.d=
ocker
> rename to tests/docker/dockerfiles.x86_64/debian9-mxe-win32-build-qemu.do=
cker
> diff --git a/tests/docker/dockerfiles.cross/debian9-mxe-win64-build-qemu.=
docker b/tests/docker/dockerfiles.x86_64/debian9-mxe-win64-build-qemu.docke=
r
> similarity index 100%
> rename from tests/docker/dockerfiles.cross/debian9-mxe-win64-build-qemu.d=
ocker
> rename to tests/docker/dockerfiles.x86_64/debian9-mxe-win64-build-qemu.do=
cker
> diff --git a/tests/docker/dockerfiles/debian9-mxe.docker b/tests/docker/d=
ockerfiles.x86_64/debian9-mxe.docker
> similarity index 100%
> rename from tests/docker/dockerfiles/debian9-mxe.docker
> rename to tests/docker/dockerfiles.x86_64/debian9-mxe.docker
> diff --git a/tests/docker/dockerfiles.x86_64/debian9-tricore-build-tests.=
docker b/tests/docker/dockerfiles.x86_64/debian9-tricore-build-tests.docker
> new file mode 120000
> index 0000000000..75f342fc01
> --- /dev/null
> +++ b/tests/docker/dockerfiles.x86_64/debian9-tricore-build-tests.docker
> @@ -0,0 +1 @@
> +../dockerfiles.cross/debian9-tricore-build-tests.docker
> \ No newline at end of file
> diff --git a/tests/docker/dockerfiles.x86_64/debian9-xtensa-build-tests.d=
ocker b/tests/docker/dockerfiles.x86_64/debian9-xtensa-build-tests.docker
> new file mode 120000
> index 0000000000..b531d9332d
> --- /dev/null
> +++ b/tests/docker/dockerfiles.x86_64/debian9-xtensa-build-tests.docker
> @@ -0,0 +1 @@
> +../dockerfiles.cross/debian9-xtensa-build-tests.docker
> \ No newline at end of file
> diff --git a/tests/docker/dockerfiles.x86_64/fedora-cris-build-tests.dock=
er b/tests/docker/dockerfiles.x86_64/fedora-cris-build-tests.docker
> new file mode 120000
> index 0000000000..4f260380a9
> --- /dev/null
> +++ b/tests/docker/dockerfiles.x86_64/fedora-cris-build-tests.docker
> @@ -0,0 +1 @@
> +../dockerfiles.cross/fedora-cris-build-tests.docker
> \ No newline at end of file
> diff --git a/tests/docker/dockerfiles.x86_64/fedora-i386-build-tests.dock=
er b/tests/docker/dockerfiles.x86_64/fedora-i386-build-tests.docker
> new file mode 120000
> index 0000000000..373f15ee40
> --- /dev/null
> +++ b/tests/docker/dockerfiles.x86_64/fedora-i386-build-tests.docker
> @@ -0,0 +1 @@
> +../dockerfiles.cross/fedora-i386-build-qemu.docker
> \ No newline at end of file
> diff --git a/tests/docker/dockerfiles/travis.docker b/tests/docker/docker=
files.x86_64/travis.docker
> similarity index 100%
> rename from tests/docker/dockerfiles/travis.docker
> rename to tests/docker/dockerfiles.x86_64/travis.docker
>=20


