Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A9FC3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:52:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4139A20732
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JKpC+uuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4139A20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9rrY-000369-EB
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 09:52:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j9rqn-0002FR-9x
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:51:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j9rqm-0007M2-0g
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:51:49 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33458)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j9rql-0007K7-Q1
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:51:47 -0500
Received: by mail-wr1-x444.google.com with SMTP id x7so7393766wrr.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 06:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=AV9DKZeo5XSlqfQw6OOTSdxsG7ZkNypj7VbKwVF7WlQ=;
 b=JKpC+uuDYOGdZ2QCnk3pS9RGzl96baZ/9HH+LveIzjwk2uG0GowsfaZVskbeOGCuCa
 8g51UdpmgvG2rMvQo2LzUxcBoGr3VmXw7Swgr1ShPS7WM1umA03XR02T4E8zJIBwhAFe
 k88zwwoQmw+glShc1p1MRgLhMjYucAc9yiWIb173/xsMrIHne5Y8+MLFT/V/qzH1Y8wG
 5vOIvKZdCYIEzmAs8TLlwmAkuh9tHAW3bU3za+wY+qzQh8rRTFVB0PrboQimODk68pj7
 jajl5NNgcyH6+RNP9FYWbGcr4Km5+nJY490Fd8BeF9VtdLAT8BvWk9MzfYmhOWljtAQU
 jBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=AV9DKZeo5XSlqfQw6OOTSdxsG7ZkNypj7VbKwVF7WlQ=;
 b=ZoI5lN42dPbz0CdMo3XXwi1FP0E8q1oSMNUGQjaxtNCtRyyaIwtmx75atAogtegBLP
 CpeEPX9hu3dK3hRWoSpli9JzqTxUg+BgOpdf8IfQRuSqDbTlD4RT9BMw/S7H40CerAht
 MzFShFx3B3AzIPcKI0Cw1d66VbsXRcZIC/wQ6fW435AcilMjYWsoQwPL90+0xaBCx8z6
 dkxF9g2eT9rNAqaFhZ2u0pv1icdGHzQ83oYjWuVIZ4ieZxMhJ6rLSpqNLzivAMB+qq4+
 pJtmxyr2/89ID+U82UCZ3DWYEIg9/TosKpo9dVDxHFLwEV0vCQmiUzEj+v7/sXfasav8
 IWkg==
X-Gm-Message-State: ANhLgQ3aDkDrG2SUvwUqJlcTcdlpYLp2whWvbbHEwkB/bLZMvIZGeJDn
 nuS8dBTE8xy0WRWJ/pZplLKqWQ==
X-Google-Smtp-Source: ADFU+vs4gER01xiqr0PXQuia5/QLQ/d5QIEZ2w8vDTM2kZf21sV+FG80kwtAKk4gpShXSZHaqUSrmw==
X-Received: by 2002:adf:fa43:: with SMTP id y3mr10423901wrr.404.1583419905864; 
 Thu, 05 Mar 2020 06:51:45 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o26sm9083457wmc.33.2020.03.05.06.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 06:51:44 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D4C801FF87;
 Thu,  5 Mar 2020 14:51:43 +0000 (GMT)
References: <20200305103427.157658-1-quintela@redhat.com>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH] configure: Improve zstd test
In-reply-to: <20200305103427.157658-1-quintela@redhat.com>
Date: Thu, 05 Mar 2020 14:51:43 +0000
Message-ID: <87imji6eio.fsf@linaro.org>
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Juan Quintela <quintela@redhat.com> writes:

> There were one error on the test (missing an s for --exists).
> But we really need a recent zstd (0.8.1).
> That version was released in 2016, so it is newer that some of our travis
> images.  Just check for the version that we need.
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  configure | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index 7b373bc0bb..1bf48df1ef 100755
> --- a/configure
> +++ b/configure
> @@ -2464,7 +2464,8 @@ fi
>  # zstd check
>=20=20
>  if test "$zstd" !=3D "no" ; then
> -    if $pkg_config --exist libzstd ; then
> +    libzstd_minver=3D"0.8.1"
> +    if $pkg_config --atleast-version=3D$libzstd_minver libzstd ; then
>          zstd_cflags=3D"$($pkg_config --cflags libzstd)"
>          zstd_libs=3D"$($pkg_config --libs libzstd)"
>          LIBS=3D"$zstd_libs $LIBS"

Hmm still breaks with:

   make docker-test-build@ubuntu J=3D9 V=3D1

With:

  FY_SOURCE=3D2 -g   -c -o monitor/qmp.o /tmp/qemu-test/src/monitor/qmp.c
  /tmp/qemu-test/src/migration/multifd-zstd.c: In function 'zstd_send_prepa=
re':
  /tmp/qemu-test/src/migration/multifd-zstd.c:125:9: error: unknown type na=
me 'ZSTD_EndDirective'; did you mean 'ZSTD_DDict'?
           ZSTD_EndDirective flush =3D ZSTD_e_continue;
           ^~~~~~~~~~~~~~~~~
           ZSTD_DDict
  /tmp/qemu-test/src/migration/multifd-zstd.c:125:35: error: 'ZSTD_e_contin=
ue' undeclared (first use in this function); did you mean 'g_timer_continue=
'?
           ZSTD_EndDirective flush =3D ZSTD_e_continue;
                                     ^~~~~~~~~~~~~~~
                                     g_timer_continue
  /tmp/qemu-test/src/migration/multifd-zstd.c:125:35: note: each undeclared=
 identifier is reported only once for each function it appears in
  /tmp/qemu-test/src/migration/multifd-zstd.c:128:21: error: 'ZSTD_e_flush'=
 undeclared (first use in this function); did you mean 'ZSTD_DCtx_s'?
               flush =3D ZSTD_e_flush;
                       ^~~~~~~~~~~~
                       ZSTD_DCtx_s
  /tmp/qemu-test/src/migration/multifd-zstd.c:143:19: error: implicit decla=
ration of function 'ZSTD_compressStream2'; did you mean 'ZSTD_compressStrea=
m'? [-Werror=3Dimplicit-fun
  ction-declaration]
               ret =3D ZSTD_compressStream2(z->zcs, &z->out, &z->in, flush);
                     ^~~~~~~~~~~~~~~~~~~~
                     ZSTD_compressStream
  /tmp/qemu-test/src/migration/multifd-zstd.c:143:19: error: nested extern =
declaration of 'ZSTD_compressStream2' [-Werror=3Dnested-externs]
  cc1: all warnings being treated as errors
  make: *** [/tmp/qemu-test/src/rules.mak:69: migration/multifd-zstd.o] Err=
or 1
  make: *** Waiting for unfinished jobs....
  rm tests/qemu-iotests/socket_scm_helper.o

Running manually you get:

  14:48:20 [alex@zen:~/l/q/b/all] review/misc-bits|=E2=80=A6 1 + docker run=
 --rm -it qemu:ubuntu pkg-config --exists libzstd
  14:48:24 [alex@zen:~/l/q/b/all] review/misc-bits|=E2=80=A6 + echo $status
  0
  14:48:28 [alex@zen:~/l/q/b/all] review/misc-bits|=E2=80=A6 + docker run -=
-rm -it qemu:ubuntu pkg-config --atleast-version=3D"0.8.1" libzstd
  14:48:52 [alex@zen:~/l/q/b/all] review/misc-bits|=E2=80=A6 + echo $status
  0
  14:49:33 [alex@zen:~/l/q/b/all] review/misc-bits|=E2=80=A6 + docker run -=
-rm -it qemu:ubuntu pkg-config --cflags libzstd

  14:49:45 [alex@zen:~/l/q/b/all] review/misc-bits|=E2=80=A6 + docker run -=
-rm -it qemu:ubuntu pkg-config --libs libzstd
  -lzstd
  14:51:14 [alex@zen:~/l/q/b/all] review/misc-bits|=E2=80=A6 + docker run -=
-rm -it qemu:ubuntu dpkg --status libzstd-dev
  Package: libzstd-dev
  Status: install ok installed
  Priority: optional
  Section: libdevel
  Installed-Size: 985
  Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
  Architecture: amd64
  Multi-Arch: same
  Source: libzstd
  Version: 1.3.8+dfsg-3
  Depends: libzstd1 (=3D 1.3.8+dfsg-3)
  Description: fast lossless compression algorithm -- development files
   Zstd, short for Zstandard, is a fast lossless compression algorithm, tar=
geting
   real-time compression scenarios at zlib-level compression ratio.
   .
   This package contains the headers and static library.
  Original-Maintainer: Debian Med Packaging Team <debian-med-packaging@list=
s.alioth.debian.org>
  Homepage: https://github.com/facebook/zstd


--=20
Alex Benn=C3=A9e

