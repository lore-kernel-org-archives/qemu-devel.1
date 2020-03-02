Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572BEC3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:32:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22D002166E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XP2EdppT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D002166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8jJg-0002bj-8q
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 06:32:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35427)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8jIS-0001Gq-7d
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:31:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8jIQ-00088E-Re
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:31:40 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35281)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8jIQ-00086C-Kt
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:31:38 -0500
Received: by mail-wm1-x341.google.com with SMTP id m3so10327522wmi.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 03:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=CS4ydOHOrHkqjl/s1M/+WnZB1nFFN4bwGfzSWC2J4ek=;
 b=XP2EdppT6rZ0r1vSiF6LjZGpOyUhYUypuGficxJrjImymbq8cqAujeAHObp/K101Of
 MVQiRNa72qdPDa0y9uoN4NpzyU/AEO11M+NKIi2eANEXQBCD+SpjY1gijWZWwg0xAft4
 F6XNgFWVM3frG6syda6VNTr/ALCpVIBngaoSGKE6L3YLatcsTLLwqtfAK1I+5FONPTSe
 zI1teP/qRZqK46B5ekt3hW2qcGLt5NBicD4kNkEZbb70Dc50qwRnT94yyfQ9rNqCGB0d
 eBoTz7RlfQ0j59KzrtlrgqMTgBBwZ0CUdXYEVr4p7yOiGXSc5sC1GLYxOAYKNV8wXnPT
 KgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=CS4ydOHOrHkqjl/s1M/+WnZB1nFFN4bwGfzSWC2J4ek=;
 b=qudRqqjsNTms/11xjZgooqpK5vdjzSfHHQruTkPJgU5ZTQbpTvBPJna56e54K4FYlO
 /GVxWqL03zRfYu8TqvQo8eWZ1FCeDjZyqaeEUmpnr0qiANFRA0Md8WnXi9dDiKJj3haG
 QbiuZKVWRewrk3FN5nGg+TmyZBSmyIl4A1dcwk1+Cin8Rtwfr0R0vtuyRT71Z4lcVlkg
 uKgm/rYFbPEIZ/9ak/6YCxJLWTospSP/fDC4gSZbiul4TEV1Vm4SzmkhqO9KWgljz/yS
 dkblMTrhR3HCnFv45cBJrRqeSbn4RIWjOKuHvwBY+B4tW5/j6hqiFg9gTpIiQB1MTN2B
 /hrw==
X-Gm-Message-State: ANhLgQ1ipD8KtpHGaBe4EFGlw4vYJVlI1eP15RvtUwh673E3s8CTxwwr
 MKAD7kUlZZLCGxvvC0NICKgJuqdqwB4=
X-Google-Smtp-Source: ADFU+vsduRIUKoLl5ytXw4WWIZJ7nDs6CE8DAGhvrUEyhmdbn4We0spDy4ykXBjmgO76i5SvRBARbQ==
X-Received: by 2002:a7b:c7d0:: with SMTP id z16mr1471295wmk.15.1583148696902; 
 Mon, 02 Mar 2020 03:31:36 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d7sm17476375wmc.6.2020.03.02.03.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 03:31:35 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F3BE11FF87;
 Mon,  2 Mar 2020 11:31:34 +0000 (GMT)
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-12-peter.maydell@linaro.org>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 11/33] qemu-doc: move included files to docs/system
In-reply-to: <20200228153619.9906-12-peter.maydell@linaro.org>
Date: Mon, 02 Mar 2020 11:31:34 +0000
Message-ID: <87imjnat7t.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
> Since qemu-doc.texi is mostly including files from docs/system,
> move the existing include files there for consistency.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-id: 20200226113034.6741-12-pbonzini@redhat.com
> [PMM: update MAINTAINERS line for qemu-option-trace.texi]
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  Makefile                                                  | 8 ++++----
>  MAINTAINERS                                               | 5 +++--
>  qemu-deprecated.texi =3D> docs/system/deprecated.texi       | 0
>  .../system/qemu-option-trace.texi                         | 0
>  docs/{ =3D> system}/security.texi                           | 0
>  qemu-doc.texi                                             | 4 ++--
>  qemu-options.hx                                           | 2 +-
>  7 files changed, 10 insertions(+), 9 deletions(-)
>  rename qemu-deprecated.texi =3D> docs/system/deprecated.texi (100%)
>  rename qemu-option-trace.texi =3D> docs/system/qemu-option-trace.texi (1=
00%)
>  rename docs/{ =3D> system}/security.texi (100%)
>
> diff --git a/Makefile b/Makefile
> index 56382a45936..7e60a435426 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1110,7 +1110,7 @@ docs/interop/qemu-ga-qapi.texi: qga/qapi-generated/=
qga-qapi-doc.texi
>  	@cp -p $< $@
>=20=20
>  qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-i=
nfo.texi
> -qemu.1: qemu-option-trace.texi
> +qemu.1: docs/system/qemu-option-trace.texi
>  docs/system/qemu-cpu-models.7: docs/system/qemu-cpu-models.texi docs/sys=
tem/cpu-models-x86.texi docs/system/cpu-models-mips.texi
>=20=20
>  html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-=
ref.html sphinxdocs
> @@ -1120,8 +1120,7 @@ txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt doc=
s/interop/qemu-ga-ref.txt
>=20=20
>  qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
>  	qemu-options.texi \
> -	qemu-option-trace.texi \
> -	qemu-deprecated.texi qemu-monitor.texi \
> +	qemu-monitor.texi \
>  	qemu-monitor-info.texi \
>          docs/system/quickstart.texi \
>          docs/system/invocation.texi \
> @@ -1140,7 +1139,8 @@ qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.t=
xt: \
>          docs/system/build-platforms.texi \
>          docs/system/license.texi \
>  	docs/system/cpu-models-x86.texi docs/system/cpu-models-mips.texi \
> -	docs/security.texi
> +	docs/system/deprecated.texi docs/system/qemu-option-trace.texi \
> +	docs/system/security.texi
>=20=20
>  docs/interop/qemu-ga-ref.dvi docs/interop/qemu-ga-ref.html \
>      docs/interop/qemu-ga-ref.info docs/interop/qemu-ga-ref.pdf \
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8c6d8f533ce..74b025fb806 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2232,7 +2232,7 @@ M: Stefan Hajnoczi <stefanha@redhat.com>
>  S: Maintained
>  F: trace/
>  F: trace-events
> -F: qemu-option-trace.texi
> +F: docs/system/qemu-option-trace.texi
>  F: scripts/tracetool.py
>  F: scripts/tracetool/
>  F: scripts/qemu-trace-stap*
> @@ -2802,7 +2802,8 @@ F: contrib/gitdm/*
>=20=20
>  Incompatible changes
>  R: libvir-list@redhat.com
> -F: qemu-deprecated.texi
> +F: docs/system/deprecated.texi
> +F: docs/system/deprecated.rst
>=20=20
>  Build System
>  ------------
> diff --git a/qemu-deprecated.texi b/docs/system/deprecated.texi
> similarity index 100%
> rename from qemu-deprecated.texi
> rename to docs/system/deprecated.texi
> diff --git a/qemu-option-trace.texi b/docs/system/qemu-option-trace.texi
> similarity index 100%
> rename from qemu-option-trace.texi
> rename to docs/system/qemu-option-trace.texi
> diff --git a/docs/security.texi b/docs/system/security.texi
> similarity index 100%
> rename from docs/security.texi
> rename to docs/system/security.texi
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index e4bff7edbee..d3e743719ab 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -189,9 +189,9 @@ various targets are mentioned in the following sectio=
ns.
>  @include docs/system/target-m68k.texi
>  @include docs/system/target-xtensa.texi
>=20=20
> -@include docs/security.texi
> +@include docs/system/security.texi
>=20=20
> -@include qemu-deprecated.texi
> +@include docs/system/deprecated.texi
>=20=20
>  @include docs/system/build-platforms.texi
>=20=20
> diff --git a/qemu-options.hx b/qemu-options.hx
> index ac315c1ac45..5fbfa2797cb 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4221,7 +4221,7 @@ HXCOMM This line is not accurate, as some sub-optio=
ns are backend-specific but
>  HXCOMM HX does not support conditional compilation of text.
>  @item -trace [[enable=3D]@var{pattern}][,events=3D@var{file}][,file=3D@v=
ar{file}]
>  @findex -trace
> -@include qemu-option-trace.texi
> +@include docs/system/qemu-option-trace.texi
>  ETEXI
>  DEF("plugin", HAS_ARG, QEMU_OPTION_plugin,
>      "-plugin [file=3D]<file>[,arg=3D<string>]\n"


--=20
Alex Benn=C3=A9e

