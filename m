Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521E1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 19:44:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09F4424679
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 19:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bn7DSBbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F4424679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwAIn-0002pv-1h
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 14:44:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59313)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1iwAIC-0002RD-Hu
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:43:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1iwAIA-0003O2-V1
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:43:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29512
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1iwAIA-0003Nq-Ri
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580154206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aMu2gsEgEkEk3HWSoC+1EhF9YCd0ttBqcqXN1dJmDe8=;
 b=Bn7DSBbtA6O4JIjdmXP0k4pHk+BojL1J+qijT5H/kc0Ac7j6o3k3HHo+vyGjnaM8qlqtUN
 qGmEiS3uQE0w4xiJePsk0SRgrg+sCJYNiESc3HQ7PqYGsqxfBgYdNOqwYRM6HPnebfG+Ug
 fVQf2ToX11Iak/k2OyS0LrAH9waMyWA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-pVydKkjLOauB6Yebb0zwnw-1; Mon, 27 Jan 2020 14:43:19 -0500
Received: by mail-wm1-f71.google.com with SMTP id t17so1807375wmi.7
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 11:43:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=aMu2gsEgEkEk3HWSoC+1EhF9YCd0ttBqcqXN1dJmDe8=;
 b=lYdb9xqQ4tOtnoza7ovAv2O/0r1URReuwZX0iyakzDUo8wJtftZElj3zb399Cg5Hr+
 pxJD/s/IJ4MHZ3SEvl7LfvWqxlugLIqXocZUyQBmjtQely5DsH4rbbyzc9t/8wWFGnTY
 V1N9+PuMblv7ANxN7NYafjBjpmNQjx5kOVsmAZVRIV8aiv+b3E2lkjLmSZl/3Eu4jXyS
 /pfPm/QZQzYjfinsxWgnYj7ouszqp59efRbmlm0IbmXYGtFRo66edu982h5KHYlENAMC
 UwzaFP+cD54LB+Cc7iDzEQFhLlLG8yDHu7QzJYiTwxafYdHbS+0LC6pJu/tnbz2ppX5q
 wkvA==
X-Gm-Message-State: APjAAAVZPzMFkkIAGy3Jqz1KgeSrpV3DcZJQ6rRDVvC1GTG8oZELaAkJ
 zqua0a5sUY7ZVP8zo5Vc384xhnuoV934Jp72dN82kIArptLOLBsF0LQmm7deoKVbGDSxZyiCv/p
 8PFKEySzn20km/PsS9N/mjMuB2VCJrWM=
X-Received: by 2002:a7b:c459:: with SMTP id l25mr239801wmi.17.1580154198384;
 Mon, 27 Jan 2020 11:43:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqye0pPBJE+6qCABT4hnUU+gE+yo/mar4klmRyCV4HkivMBpDjBzsLQi3jubiZ+W35cqpPB6ijOIa3cHoP2Tc+s=
X-Received: by 2002:a7b:c459:: with SMTP id l25mr239778wmi.17.1580154198139;
 Mon, 27 Jan 2020 11:43:18 -0800 (PST)
MIME-Version: 1.0
References: <20200124204026.2107-1-alex.bennee@linaro.org>
 <20200124204026.2107-13-alex.bennee@linaro.org>
 <066bd5bc-c6b8-33fe-bcd9-2d4e7172d72d@redhat.com>
In-Reply-To: <066bd5bc-c6b8-33fe-bcd9-2d4e7172d72d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Mon, 27 Jan 2020 20:43:07 +0100
Message-ID: <CAP+75-WZfOeSDjWH+ikuvOZyLz4P25_rFGsFDkGqAr9WNYkCwQ@mail.gmail.com>
Subject: Re: [PATCH v1 12/13] tests/docker: re-enable cross-compiling for
 x86_64 hosts
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 QEMU Developers <qemu-devel@nongnu.org>
X-MC-Unique: pVydKkjLOauB6Yebb0zwnw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 27, 2020 at 8:38 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
> On 1/24/20 9:40 PM, Alex Benn=C3=A9e wrote:
> > Now we have moved everything around we can re-enable the builds for
> > x86_64. Thanks to the descriptive names we are able to sort out QEMU
> > build and tests build dockerfiles and ensure the correct debian
> > dependencies.
> >
> > Move the fedora, mxe and travis dockerfiles into the x86_64 directory
> > as they cannot be used on other architectures.
> >
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > ---
> >   .../dockerfiles.x86_64/Makefile.include       | 26 ++++++++++++++++++=
+
> >   .../debain10-x86_64-qemu-build.docker         |  1 +
> >   .../debian10-alpha-build-tests.docker         |  1 +
> >   .../debian10-amd64-build-qemu.docker          |  1 +
> >   .../debian10-arm64-build-qemu.docker          |  1 +
> >   .../debian10-armel-build-qemu.docker          |  1 +
> >   .../debian10-armhf-build-qemu.docker          |  1 +
> >   .../debian10-hppa-build-tests.docker          |  1 +
> >   .../debian10-m68k-build-tests.docker          |  1 +
> >   .../debian10-mips-build-qemu.docker           |  1 +
> >   .../debian10-mips64-build-tests.docker        |  1 +
> >   .../debian10-mips64el-build-qemu.docker       |  1 +
> >   .../debian10-mipsel-build-qemu.docker         |  1 +
> >   .../debian10-native-qemu-build.docker         |  1 +
> >   .../debian10-powerpc-build-tests.docker       |  1 +
> >   .../debian10-ppc64-build-tests.docker         |  1 +
> >   .../debian10-ppc64el-build-qemu.docker        |  1 +
> >   .../debian10-riscv64-build-tests.docker       |  1 +
> >   .../debian10-s390x-build-qemu.docker          |  1 +
> >   .../debian10-sh4-build-tests.docker           |  1 +
> >   .../debian10-sparc64-build-tests.docker       |  1 +
> >   .../debian9-mxe-win32-build-qemu.docker       |  0
> >   .../debian9-mxe-win64-build-qemu.docker       |  0
> >   .../debian9-mxe.docker                        |  0
> >   .../debian9-tricore-build-tests.docker        |  1 +
> >   .../debian9-xtensa-build-tests.docker         |  1 +
> >   .../fedora-cris-build-tests.docker            |  1 +
> >   .../fedora-i386-build-tests.docker            |  1 +
> >   .../travis.docker                             |  0
> >   29 files changed, 50 insertions(+)
> >   create mode 100644 tests/docker/dockerfiles.x86_64/Makefile.include
> >   create mode 120000 tests/docker/dockerfiles.x86_64/debain10-x86_64-qe=
mu-build.docker
> >   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-alpha-bui=
ld-tests.docker
> >   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-amd64-bui=
ld-qemu.docker
> >   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-arm64-bui=
ld-qemu.docker
> >   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-armel-bui=
ld-qemu.docker
> >   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-armhf-bui=
ld-qemu.docker
> >   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-hppa-buil=
d-tests.docker
> >   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-m68k-buil=
d-tests.docker
> >   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-mips-buil=
d-qemu.docker
> >   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-mips64-bu=
ild-tests.docker
> >   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-mips64el-=
build-qemu.docker
> >   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-mipsel-bu=
ild-qemu.docker
> >   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-native-qe=
mu-build.docker
> >   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-powerpc-b=
uild-tests.docker
> >   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-ppc64-bui=
ld-tests.docker
> >   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-ppc64el-b=
uild-qemu.docker
> >   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-riscv64-b=
uild-tests.docker
> >   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-s390x-bui=
ld-qemu.docker
> >   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-sh4-build=
-tests.docker
> >   create mode 120000 tests/docker/dockerfiles.x86_64/debian10-sparc64-b=
uild-tests.docker
> >   rename tests/docker/{dockerfiles.cross =3D> dockerfiles.x86_64}/debia=
n9-mxe-win32-build-qemu.docker (100%)
> >   rename tests/docker/{dockerfiles.cross =3D> dockerfiles.x86_64}/debia=
n9-mxe-win64-build-qemu.docker (100%)
> >   rename tests/docker/{dockerfiles =3D> dockerfiles.x86_64}/debian9-mxe=
.docker (100%)
> >   create mode 120000 tests/docker/dockerfiles.x86_64/debian9-tricore-bu=
ild-tests.docker
> >   create mode 120000 tests/docker/dockerfiles.x86_64/debian9-xtensa-bui=
ld-tests.docker
> >   create mode 120000 tests/docker/dockerfiles.x86_64/fedora-cris-build-=
tests.docker
> >   create mode 120000 tests/docker/dockerfiles.x86_64/fedora-i386-build-=
tests.docker
> >   rename tests/docker/{dockerfiles =3D> dockerfiles.x86_64}/travis.dock=
er (100%)
> >
> > diff --git a/tests/docker/dockerfiles.x86_64/Makefile.include b/tests/d=
ocker/dockerfiles.x86_64/Makefile.include
> > new file mode 100644
> > index 0000000000..6237eb500e
> > --- /dev/null
> > +++ b/tests/docker/dockerfiles.x86_64/Makefile.include
> > @@ -0,0 +1,26 @@
> > +# -*- Mode: makefile -*-
> > +#
> > +# x86_64 Containers
> > +#
> > +# This architecture has by far the largest number of cross compilers
> > +# enabled for it.
> > +#
> > +
> > +X86_64_BASE =3D $(DOCKER_BASE)/dockerfiles.x86_64
> > +VPATH +=3D $(X86_64_BASE)
> > +
> > +#
> > +# We have both QEMU build and TEST build containers we can access
> > +#
> > +QEMU_BUILD_CONTAINERS +=3D $(call get-basenames,$(wildcard $(X86_64_BA=
SE)/*-build-qemu.docker))
> > +TEST_BUILD_CONTAINERS +=3D $(call get-basenames,$(wildcard $(X86_64_BA=
SE)/*-build-tests.docker))
> > +
> > +# Generate build-deps based on names
> > +#
> > +# Most of this architecture are based on Debian images
> > +X86_64_CONTAINERS=3D$(call get-basenames,$(wildcard $(X86_64_BASE)/*.d=
ocker))
> > +$(filter-out,debian9,$(X86_64_CONTAINERS)): docker-image-debian9
> > +$(filter-out,debian10,$(X86_64_CONTAINERS)): docker-image-debian10
> > +
> > +# MXE windows cross compilers are all based on stretch
> > +debian9-mxe-%: docker-image-debian9-mxe
> > diff --git a/tests/docker/dockerfiles.x86_64/debain10-x86_64-qemu-build=
.docker b/tests/docker/dockerfiles.x86_64/debain10-x86_64-qemu-build.docker
> > new file mode 120000
> > index 0000000000..cd1caa0704
> > --- /dev/null
> > +++ b/tests/docker/dockerfiles.x86_64/debain10-x86_64-qemu-build.docker
> > @@ -0,0 +1 @@
> > +../dockerfiles/debian10-native-qemu-build.docker
> > \ No newline at end of file
> > diff --git a/tests/docker/dockerfiles.x86_64/debian10-alpha-build-tests=
.docker b/tests/docker/dockerfiles.x86_64/debian10-alpha-build-tests.docker
> > new file mode 120000
> > index 0000000000..614c8525ef
> > --- /dev/null
> > +++ b/tests/docker/dockerfiles.x86_64/debian10-alpha-build-tests.docker
> > @@ -0,0 +1 @@
> > +../dockerfiles.cross/debian10-alpha-build-tests.docker
> > \ No newline at end of file
>
> On Aarch64:
>
> $ make docker-image V=3D1
> ./tests/docker/docker.py --engine auto build qemu:debian10
> ./tests/docker/dockerfiles.multiarch/debian10.docker   --add-current-user
> Sending build context to Docker daemon  3.072kB
> Step 1/5 : FROM debian:buster-slim
> [...]
> Successfully tagged qemu:debian10
> ./tests/docker/docker.py --engine auto build qemu:debian9
> ./tests/docker/dockerfiles.multiarch/debian9.docker   --add-current-user
> Image is up to date.
> make: *** No rule to make target
> 'docker-image-debian10-alpha-test-build', needed by 'docker-image'.  Stop=
.

FWIW:

$ make docker-image -k
  BUILD   debian10
  BUILD   debian10-aarch64-qemu-build
make: *** No rule to make target
'docker-image-debian10-alpha-test-build', needed by 'docker-image'.
make: *** No rule to make target
'docker-image-debian10-x86_64-qemu-build', needed by 'docker-image'.
  BUILD   debian9
make: *** No rule to make target
'docker-image-debian9-armel-qemu-build', needed by 'docker-image'.
make: Target 'docker-image' not remade because of errors.


