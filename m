Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD120C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 779B920842
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sRjzzTUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 779B920842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8j64-0000DA-NF
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 06:18:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8j5O-00085I-JV
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:18:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8j5L-0004b0-Fd
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:18:10 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38915)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8j5L-0004an-4x
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:18:07 -0500
Received: by mail-wr1-x441.google.com with SMTP id y17so12082994wrn.6
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 03:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=LMC6Wz87yHAwlLy4e/dbJp7wjJvq3UjVDeryA/NNdzY=;
 b=sRjzzTUdUKFgmAWB+M4TKjsobpXCM7WovlqZPgxSX5VyjRHAY/sLGt591LC2Im7ycf
 Qu1FjELpxdat/srWdtjUS0u0mfAy1EpM8xeesFaclJr2J59zJGLWSxsgLi7n5CGhGYNo
 MpPNy5QbRAEtBl/Bu+o7cazvs4PuZ+DW0f/JhUTUrvd17ivKHHj4NuIBVRPkO24+YZxU
 9pBOMMenSblU7pkrgjEKwfWHkUdwV1T9vFwTfjZhPOmnlulnTj3FaL99i5Qsc0GPAhVW
 D1C5oLcyuVqorkwkB5mJUN4C2u9loQnQlhwQQvPjLhGKvma2gTqIKiUMWkQO2qTwZ2gq
 qmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=LMC6Wz87yHAwlLy4e/dbJp7wjJvq3UjVDeryA/NNdzY=;
 b=eZGM4Xc7otehx1Gr4yu+krN8qq5vqSxmsDQc8nZ0lA7T/YWBxvoZ6D3IHwiRgFTYOU
 lWCQMil+PX7xkssqbuP0CINBqOK7xxV6I8ZHTz56f6+1RyrXPoYX4rktKRX38c6dbl96
 bFB3t/M+zMURd2lXFJuVVyoGbq2jdVHm/hC3lYWgBVRUlYh4aMYLyjLi8+LV//vU+x7y
 V4KIiKZn6HQmbzQyfvds6cZjfxR28FPzrpBaW5a0L7VgqYWcFdohF0OJVg4Qlt1101YG
 gJPLsq6PasaTf+qzB5x1qZmq2Jc4M8Ka7EBnZxN5IOFChZ2+uKNUv3JMC4i40LHqddUm
 cUvg==
X-Gm-Message-State: APjAAAUYsKTHvhlCKt4owFVZdyyI/Pw1MRbwYFomQx89fhbsI6hFlu8Q
 pB64NUSQY8rCRvv74o4wMxBayg==
X-Google-Smtp-Source: APXvYqzOk6FMkqCUPYLa8JNZahRhXBqi/s1Q4gtG4cc3d0J/Xlm3rJIRyVDN8YQNAoRi4myfzpfKXg==
X-Received: by 2002:adf:ce06:: with SMTP id p6mr20581633wrn.134.1583147885409; 
 Mon, 02 Mar 2020 03:18:05 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s8sm28687667wrt.57.2020.03.02.03.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 03:18:03 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2C1F41FF87;
 Mon,  2 Mar 2020 11:18:03 +0000 (GMT)
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-5-peter.maydell@linaro.org>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 04/33] qemu-doc: split CPU models doc between MIPS
 and x86 parts
In-reply-to: <20200228153619.9906-5-peter.maydell@linaro.org>
Date: Mon, 02 Mar 2020 11:18:03 +0000
Message-ID: <87zhczatuc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> From: Paolo Bonzini <pbonzini@redhat.com>
>
> The MIPS CPU models end up in the middle of the PC documentation.  Move
> them to a separate file so that they can be placed in the right section.
>
> The man page still includes both x86 and MIPS content.

We really need to flesh that out one day - it's not like ARM hasn't got
it's own tweaks.

>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-id: 20200226113034.6741-5-pbonzini@redhat.com
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  Makefile                                      |  11 +-
>  MAINTAINERS                                   |   3 +-
>  docs/system/cpu-models-mips.texi              | 157 +++++++++++++
>  .../cpu-models-x86.texi}                      | 221 ++----------------
>  docs/system/qemu-cpu-models.texi              |  28 +++

I wonder if there is something that should go to docs/core? AFAICT the
CPU modelling covers two things:

  - system KVM modelling which deals with feature bits and presenting a
    common base for the purposes of migration

  - TCG modelling which covers what CPUs we can emulate which affects
    both linux-user and system emulation

Anyway we can "fix it in post" as they say in the movies ;-)

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>  qemu-doc.texi                                 |  12 +-
>  6 files changed, 213 insertions(+), 219 deletions(-)
>  create mode 100644 docs/system/cpu-models-mips.texi
>  rename docs/{qemu-cpu-models.texi =3D> system/cpu-models-x86.texi} (71%)
>  create mode 100644 docs/system/qemu-cpu-models.texi
>
> diff --git a/Makefile b/Makefile
> index faa0ffa05b0..f75a7b51938 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -354,7 +354,7 @@ endif
>  DOCS+=3D$(MANUAL_BUILDDIR)/system/qemu-block-drivers.7
>  DOCS+=3Ddocs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt doc=
s/interop/qemu-qmp-ref.7
>  DOCS+=3Ddocs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/=
interop/qemu-ga-ref.7
> -DOCS+=3Ddocs/qemu-cpu-models.7
> +DOCS+=3Ddocs/system/qemu-cpu-models.7
>  DOCS+=3D$(MANUAL_BUILDDIR)/index.html
>  ifdef CONFIG_VIRTFS
>  DOCS+=3D$(MANUAL_BUILDDIR)/tools/virtfs-proxy-helper.1
> @@ -780,7 +780,7 @@ distclean: clean
>  	rm -f docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
>  	rm -f docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
>  	rm -f docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html
> -	rm -f docs/qemu-cpu-models.7
> +	rm -f docs/system/qemu-cpu-models.7
>  	rm -rf .doctrees
>  	$(call clean-manual,devel)
>  	$(call clean-manual,interop)
> @@ -861,7 +861,7 @@ ifdef CONFIG_POSIX
>  	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man7"
>  	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.7 "$(DESTDIR)$(mandir)/man7"
>  	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/system/qemu-block-drivers.7 "$(DESTD=
IR)$(mandir)/man7"
> -	$(INSTALL_DATA) docs/qemu-cpu-models.7 "$(DESTDIR)$(mandir)/man7"
> +	$(INSTALL_DATA) docs/system/qemu-cpu-models.7 "$(DESTDIR)$(mandir)/man7"
>  ifeq ($(CONFIG_TOOLS),y)
>  	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/tools/qemu-img.1 "$(DESTDIR)$(mandir=
)/man1"
>  	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man8"
> @@ -1111,7 +1111,7 @@ docs/interop/qemu-ga-qapi.texi: qga/qapi-generated/=
qga-qapi-doc.texi
>=20=20
>  qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-i=
nfo.texi
>  qemu.1: qemu-option-trace.texi
> -docs/qemu-cpu-models.7: docs/qemu-cpu-models.texi
> +docs/system/qemu-cpu-models.7: docs/system/qemu-cpu-models.texi docs/sys=
tem/cpu-models-x86.texi docs/system/cpu-models-mips.texi
>=20=20
>  html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-=
ref.html sphinxdocs
>  info: qemu-doc.info docs/interop/qemu-qmp-ref.info docs/interop/qemu-ga-=
ref.info
> @@ -1123,7 +1123,8 @@ qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.t=
xt: \
>  	qemu-tech.texi qemu-option-trace.texi \
>  	qemu-deprecated.texi qemu-monitor.texi \
>  	qemu-monitor-info.texi \
> -	docs/qemu-cpu-models.texi docs/security.texi
> +	docs/system/cpu-models-x86.texi docs/system/cpu-models-mips.texi \
> +	docs/security.texi
>=20=20
>  docs/interop/qemu-ga-ref.dvi docs/interop/qemu-ga-ref.html \
>      docs/interop/qemu-ga-ref.info docs/interop/qemu-ga-ref.pdf \
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b66c46dcb9f..8c6d8f533ce 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -215,6 +215,7 @@ S: Maintained
>  F: target/mips/
>  F: default-configs/*mips*
>  F: disas/*mips*
> +F: docs/system/cpu-models-mips.texi
>  F: hw/intc/mips_gic.c
>  F: hw/mips/
>  F: hw/misc/mips_*
> @@ -319,7 +320,7 @@ F: tests/tcg/i386/
>  F: tests/tcg/x86_64/
>  F: hw/i386/
>  F: disas/i386.c
> -F: docs/qemu-cpu-models.texi
> +F: docs/system/cpu-models-x86.texi
>  T: git https://github.com/ehabkost/qemu.git x86-next
>=20=20
>  Xtensa TCG CPUs
> diff --git a/docs/system/cpu-models-mips.texi b/docs/system/cpu-models-mi=
ps.texi
> new file mode 100644
> index 00000000000..6a0370cb693
> --- /dev/null
> +++ b/docs/system/cpu-models-mips.texi
> @@ -0,0 +1,157 @@
> +@node recommendations_cpu_models_MIPS
> +@section Supported CPU model configurations on MIPS hosts
> +
> +QEMU supports variety of MIPS CPU models:
> +
> +@menu
> +* cpu_models_MIPS32::               Supported CPU models for MIPS32 hosts
> +* cpu_models_MIPS64::               Supported CPU models for MIPS64 hosts
> +* cpu_models_nanoMIPS::             Supported CPU models for nanoMIPS ho=
sts
> +* preferred_cpu_models_MIPS::       Preferred CPU models for MIPS hosts
> +@end menu
> +
> +@node cpu_models_MIPS32
> +@subsection Supported CPU models for MIPS32 hosts
> +
> +The following CPU models are supported for use on MIPS32 hosts. Administ=
rators /
> +applications are recommended to use the CPU model that matches the gener=
ation
> +of the host CPUs in use. In a deployment with a mixture of host CPU mode=
ls
> +between machines, if live migration compatibility is required, use the n=
ewest
> +CPU model that is compatible across all desired hosts.
> +
> +@table @option
> +@item @code{mips32r6-generic}
> +
> +MIPS32 Processor (Release 6, 2015)
> +
> +
> +@item @code{P5600}
> +
> +MIPS32 Processor (P5600, 2014)
> +
> +
> +@item @code{M14K}
> +@item @code{M14Kc}
> +
> +MIPS32 Processor (M14K, 2009)
> +
> +
> +@item @code{74Kf}
> +
> +MIPS32 Processor (74K, 2007)
> +
> +
> +@item @code{34Kf}
> +
> +MIPS32 Processor (34K, 2006)
> +
> +
> +@item @code{24Kc}
> +@item @code{24KEc}
> +@item @code{24Kf}
> +
> +MIPS32 Processor (24K, 2003)
> +
> +
> +@item @code{4Kc}
> +@item @code{4Km}
> +@item @code{4KEcR1}
> +@item @code{4KEmR1}
> +@item @code{4KEc}
> +@item @code{4KEm}
> +
> +MIPS32 Processor (4K, 1999)
> +@end table
> +
> +@node cpu_models_MIPS64
> +@subsection Supported CPU models for MIPS64 hosts
> +
> +The following CPU models are supported for use on MIPS64 hosts. Administ=
rators /
> +applications are recommended to use the CPU model that matches the gener=
ation
> +of the host CPUs in use. In a deployment with a mixture of host CPU mode=
ls
> +between machines, if live migration compatibility is required, use the n=
ewest
> +CPU model that is compatible across all desired hosts.
> +
> +@table @option
> +@item @code{I6400}
> +
> +MIPS64 Processor (Release 6, 2014)
> +
> +
> +@item @code{Loongson-2F}
> +
> +MIPS64 Processor (Loongson 2, 2008)
> +
> +
> +@item @code{Loongson-2E}
> +
> +MIPS64 Processor (Loongson 2, 2006)
> +
> +
> +@item @code{mips64dspr2}
> +
> +MIPS64 Processor (Release 2, 2006)
> +
> +
> +@item @code{MIPS64R2-generic}
> +@item @code{5KEc}
> +@item @code{5KEf}
> +
> +MIPS64 Processor (Release 2, 2002)
> +
> +
> +@item @code{20Kc}
> +
> +MIPS64 Processor (20K, 2000)
> +
> +
> +@item @code{5Kc}
> +@item @code{5Kf}
> +
> +MIPS64 Processor (5K, 1999)
> +
> +
> +@item @code{VR5432}
> +
> +MIPS64 Processor (VR, 1998)
> +
> +
> +@item @code{R4000}
> +
> +MIPS64 Processor (MIPS III, 1991)
> +@end table
> +
> +@node cpu_models_nanoMIPS
> +@subsection Supported CPU models for nanoMIPS hosts
> +
> +The following CPU models are supported for use on nanoMIPS hosts. Admini=
strators /
> +applications are recommended to use the CPU model that matches the gener=
ation
> +of the host CPUs in use. In a deployment with a mixture of host CPU mode=
ls
> +between machines, if live migration compatibility is required, use the n=
ewest
> +CPU model that is compatible across all desired hosts.
> +
> +@table @option
> +@item @code{I7200}
> +
> +MIPS I7200 (nanoMIPS, 2018)
> +
> +@end table
> +
> +@node preferred_cpu_models_MIPS
> +@subsection Preferred CPU models for MIPS hosts
> +
> +The following CPU models are preferred for use on different MIPS hosts:
> +
> +@table @option
> +@item @code{MIPS III}
> +R4000
> +
> +@item @code{MIPS32R2}
> +34Kf
> +
> +@item @code{MIPS64R6}
> +I6400
> +
> +@item @code{nanoMIPS}
> +I7200
> +@end table
> diff --git a/docs/qemu-cpu-models.texi b/docs/system/cpu-models-x86.texi
> similarity index 71%
> rename from docs/qemu-cpu-models.texi
> rename to docs/system/cpu-models-x86.texi
> index f88a1def0d0..0cd64b0522e 100644
> --- a/docs/qemu-cpu-models.texi
> +++ b/docs/system/cpu-models-x86.texi
> @@ -1,16 +1,5 @@
> -@c man begin SYNOPSIS
> -QEMU / KVM CPU model configuration
> -@c man end
> -
> -@set qemu_system_x86 qemu-system-x86_64
> -
> -@c man begin DESCRIPTION
> -
> -@menu
> -* recommendations_cpu_models_x86::  Recommendations for KVM CPU model co=
nfiguration on x86 hosts
> -* recommendations_cpu_models_MIPS:: Supported CPU model configurations o=
n MIPS hosts
> -* cpu_model_syntax_apps::           Syntax for configuring CPU models
> -@end menu
> +@node cpu_models_x86
> +@section Recommendations for KVM CPU model configuration on x86 hosts
>=20=20
>  QEMU / KVM virtualization supports two ways to configure CPU models
>=20=20
> @@ -45,9 +34,6 @@ stepping, etc will precisely match the host CPU, as the=
y would with "Host
>  passthrough", but gives much of the benefit of passthrough, while making
>  live migration safe.
>=20=20
> -@node recommendations_cpu_models_x86
> -@subsection Recommendations for KVM CPU model configuration on x86 hosts
> -
>  The information that follows provides recommendations for configuring
>  CPU models on x86 hosts. The goals are to maximise performance, while
>  protecting guest OS against various CPU hardware flaws, and optionally
> @@ -60,10 +46,11 @@ enabling live migration between hosts with heterogene=
ous CPU models.
>  * important_cpu_features_amd_x86::       Important CPU features for AMD =
x86 hosts
>  * default_cpu_models_x86::               Default x86 CPU models
>  * other_non_recommended_cpu_models_x86:: Other non-recommended x86 CPUs
> +* cpu_model_syntax_apps::                Syntax for configuring CPU mode=
ls
>  @end menu
>=20=20
>  @node preferred_cpu_models_intel_x86
> -@subsubsection Preferred CPU models for Intel x86 hosts
> +@subsection Preferred CPU models for Intel x86 hosts
>=20=20
>  The following CPU models are preferred for use on Intel hosts. Administr=
ators /
>  applications are recommended to use the CPU model that matches the gener=
ation
> @@ -136,7 +123,7 @@ Intel Celeron_4x0 (Conroe/Merom Class Core 2, 2006)
>  @end table
>=20=20
>  @node important_cpu_features_intel_x86
> -@subsubsection Important CPU features for Intel x86 hosts
> +@subsection Important CPU features for Intel x86 hosts
>=20=20
>  The following are important CPU features that should be used on Intel x86
>  hosts, when available in the host CPU. Some of them require explicit
> @@ -218,7 +205,7 @@ can be used for guest CPUs.
>=20=20
>=20=20
>  @node preferred_cpu_models_amd_x86
> -@subsubsection Preferred CPU models for AMD x86 hosts
> +@subsection Preferred CPU models for AMD x86 hosts
>=20=20
>  The following CPU models are preferred for use on Intel hosts. Administr=
ators /
>  applications are recommended to use the CPU model that matches the gener=
ation
> @@ -260,7 +247,7 @@ AMD Opteron 240 (Gen 1 Class Opteron, 2004)
>  @end table
>=20=20
>  @node important_cpu_features_amd_x86
> -@subsubsection Important CPU features for AMD x86 hosts
> +@subsection Important CPU features for AMD x86 hosts
>=20=20
>  The following are important CPU features that should be used on AMD x86
>  hosts, when available in the host CPU. Some of them require explicit
> @@ -349,7 +336,7 @@ Note that not all CPU hardware will support this feat=
ure.
>=20=20
>=20=20
>  @node default_cpu_models_x86
> -@subsubsection Default x86 CPU models
> +@subsection Default x86 CPU models
>=20=20
>  The default QEMU CPU models are designed such that they can run on all h=
osts.
>  If an application does not wish to do perform any host compatibility che=
cks
> @@ -372,7 +359,7 @@ qemu64 is used for x86_64 guests and qemu32 is used f=
or i686 guests, when no
>=20=20
>=20=20
>  @node other_non_recommended_cpu_models_x86
> -@subsubsection Other non-recommended x86 CPUs
> +@subsection Other non-recommended x86 CPUs
>=20=20
>  The following CPUs models are compatible with most AMD and Intel x86 hos=
ts, but
>  their usage is discouraged, as they expose a very limited featureset, wh=
ich
> @@ -403,177 +390,13 @@ hardware assisted virtualization, that should thus=
 not be required for
>  running virtual machines.
>  @end table
>=20=20
> -@node recommendations_cpu_models_MIPS
> -@subsection Supported CPU model configurations on MIPS hosts
> -
> -QEMU supports variety of MIPS CPU models:
> -
> -@menu
> -* cpu_models_MIPS32::               Supported CPU models for MIPS32 hosts
> -* cpu_models_MIPS64::               Supported CPU models for MIPS64 hosts
> -* cpu_models_nanoMIPS::             Supported CPU models for nanoMIPS ho=
sts
> -* preferred_cpu_models_MIPS::       Preferred CPU models for MIPS hosts
> -@end menu
> -
> -@node cpu_models_MIPS32
> -@subsubsection Supported CPU models for MIPS32 hosts
> -
> -The following CPU models are supported for use on MIPS32 hosts. Administ=
rators /
> -applications are recommended to use the CPU model that matches the gener=
ation
> -of the host CPUs in use. In a deployment with a mixture of host CPU mode=
ls
> -between machines, if live migration compatibility is required, use the n=
ewest
> -CPU model that is compatible across all desired hosts.
> -
> -@table @option
> -@item @code{mips32r6-generic}
> -
> -MIPS32 Processor (Release 6, 2015)
> -
> -
> -@item @code{P5600}
> -
> -MIPS32 Processor (P5600, 2014)
> -
> -
> -@item @code{M14K}
> -@item @code{M14Kc}
> -
> -MIPS32 Processor (M14K, 2009)
> -
> -
> -@item @code{74Kf}
> -
> -MIPS32 Processor (74K, 2007)
> -
> -
> -@item @code{34Kf}
> -
> -MIPS32 Processor (34K, 2006)
> -
> -
> -@item @code{24Kc}
> -@item @code{24KEc}
> -@item @code{24Kf}
> -
> -MIPS32 Processor (24K, 2003)
> -
> -
> -@item @code{4Kc}
> -@item @code{4Km}
> -@item @code{4KEcR1}
> -@item @code{4KEmR1}
> -@item @code{4KEc}
> -@item @code{4KEm}
> -
> -MIPS32 Processor (4K, 1999)
> -@end table
> -
> -@node cpu_models_MIPS64
> -@subsubsection Supported CPU models for MIPS64 hosts
> -
> -The following CPU models are supported for use on MIPS64 hosts. Administ=
rators /
> -applications are recommended to use the CPU model that matches the gener=
ation
> -of the host CPUs in use. In a deployment with a mixture of host CPU mode=
ls
> -between machines, if live migration compatibility is required, use the n=
ewest
> -CPU model that is compatible across all desired hosts.
> -
> -@table @option
> -@item @code{I6400}
> -
> -MIPS64 Processor (Release 6, 2014)
> -
> -
> -@item @code{Loongson-2F}
> -
> -MIPS64 Processor (Loongson 2, 2008)
> -
> -
> -@item @code{Loongson-2E}
> -
> -MIPS64 Processor (Loongson 2, 2006)
> -
> -
> -@item @code{mips64dspr2}
> -
> -MIPS64 Processor (Release 2, 2006)
> -
> -
> -@item @code{MIPS64R2-generic}
> -@item @code{5KEc}
> -@item @code{5KEf}
> -
> -MIPS64 Processor (Release 2, 2002)
> -
> -
> -@item @code{20Kc}
> -
> -MIPS64 Processor (20K, 2000)
> -
> -
> -@item @code{5Kc}
> -@item @code{5Kf}
> -
> -MIPS64 Processor (5K, 1999)
> -
> -
> -@item @code{VR5432}
> -
> -MIPS64 Processor (VR, 1998)
> -
> -
> -@item @code{R4000}
> -
> -MIPS64 Processor (MIPS III, 1991)
> -@end table
> -
> -@node cpu_models_nanoMIPS
> -@subsubsection Supported CPU models for nanoMIPS hosts
> -
> -The following CPU models are supported for use on nanoMIPS hosts. Admini=
strators /
> -applications are recommended to use the CPU model that matches the gener=
ation
> -of the host CPUs in use. In a deployment with a mixture of host CPU mode=
ls
> -between machines, if live migration compatibility is required, use the n=
ewest
> -CPU model that is compatible across all desired hosts.
> -
> -@table @option
> -@item @code{I7200}
> -
> -MIPS I7200 (nanoMIPS, 2018)
> -
> -@end table
> -
> -@node preferred_cpu_models_MIPS
> -@subsubsection Preferred CPU models for MIPS hosts
> -
> -The following CPU models are preferred for use on different MIPS hosts:
> -
> -@table @option
> -@item @code{MIPS III}
> -R4000
> -
> -@item @code{MIPS32R2}
> -34Kf
> -
> -@item @code{MIPS64R6}
> -I6400
> -
> -@item @code{nanoMIPS}
> -I7200
> -@end table
> -
>  @node cpu_model_syntax_apps
>  @subsection Syntax for configuring CPU models
>=20=20
>  The example below illustrate the approach to configuring the various
> -CPU models / features in QEMU and libvirt
> +CPU models / features in QEMU and libvirt.
>=20=20
> -@menu
> -* cpu_model_syntax_qemu::    QEMU command line
> -* cpu_model_syntax_libvirt:: Libvirt guest XML
> -@end menu
> -
> -@node cpu_model_syntax_qemu
> -@subsubsection QEMU command line
> +QEMU command line:
>=20=20
>  @table @option
>=20=20
> @@ -603,8 +426,8 @@ With feature customization:
>=20=20
>  @end table
>=20=20
> -@node cpu_model_syntax_libvirt
> -@subsubsection Libvirt guest XML
> +
> +Libvirt guest XML:
>=20=20
>  @table @option
>=20=20
> @@ -657,21 +480,3 @@ With feature customization:
>  @end example
>=20=20
>  @end table
> -
> -@c man end
> -
> -@ignore
> -
> -@setfilename qemu-cpu-models
> -@settitle QEMU / KVM CPU model configuration
> -
> -@c man begin SEEALSO
> -The HTML documentation of QEMU for more precise information and Linux
> -user mode emulator invocation.
> -@c man end
> -
> -@c man begin AUTHOR
> -Daniel P. Berrange
> -@c man end
> -
> -@end ignore
> diff --git a/docs/system/qemu-cpu-models.texi b/docs/system/qemu-cpu-mode=
ls.texi
> new file mode 100644
> index 00000000000..f399daf9448
> --- /dev/null
> +++ b/docs/system/qemu-cpu-models.texi
> @@ -0,0 +1,28 @@
> +@c man begin SYNOPSIS
> +QEMU / KVM CPU model configuration
> +@c man end
> +
> +@set qemu_system_x86 qemu-system-x86_64
> +
> +@c man begin DESCRIPTION
> +
> +@include cpu-models-x86.texi
> +@include cpu-models-mips.texi
> +
> +@c man end
> +
> +@ignore
> +
> +@setfilename qemu-cpu-models
> +@settitle QEMU / KVM CPU model configuration
> +
> +@c man begin SEEALSO
> +The HTML documentation of QEMU for more precise information and Linux
> +user mode emulator invocation.
> +@c man end
> +
> +@c man begin AUTHOR
> +Daniel P. Berrange
> +@c man end
> +
> +@end ignore
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index e555dea4ef6..617a701b678 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -139,7 +139,7 @@ accelerator is required to use more than one host CPU=
 for emulation.
>  * pcsys_keys::         Keys in the graphical frontends
>  * mux_keys::           Keys in the character backend multiplexer
>  * pcsys_monitor::      QEMU Monitor
> -* cpu_models::         CPU models
> +* cpu_models_x86::     Supported CPU model configurations on x86 hosts
>  * disk_images::        Disk Images
>  * pcsys_network::      Network emulation
>  * pcsys_other_devs::   Other Devices
> @@ -614,10 +614,7 @@ The monitor understands integers expressions for eve=
ry integer
>  argument. You can use register names to get the value of specifics
>  CPU registers by prefixing them with @emph{$}.
>=20=20
> -@node cpu_models
> -@section CPU models
> -
> -@include docs/qemu-cpu-models.texi
> +@include docs/system/cpu-models-x86.texi
>=20=20
>  @node disk_images
>  @section Disk Images
> @@ -1864,6 +1861,7 @@ Set the emulated machine type. The default is sun4u.
>  @cindex system emulation (MIPS)
>=20=20
>  @menu
> +* recommendations_cpu_models_MIPS:: Supported CPU model configurations o=
n MIPS hosts
>  * nanoMIPS System emulator ::
>  @end menu
>=20=20
> @@ -1980,6 +1978,10 @@ PC style serial port
>  MIPSnet network emulation
>  @end itemize
>=20=20
> +@lowersections
> +@include docs/system/cpu-models-mips.texi
> +@raisesections
> +
>  @node nanoMIPS System emulator
>  @subsection nanoMIPS System emulator
>  @cindex system emulation (nanoMIPS)


--=20
Alex Benn=C3=A9e

