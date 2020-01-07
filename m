Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668E0C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:20:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3494C2072A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QYKY1xHz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3494C2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioomb-0005fG-9Z
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 08:20:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ioois-00081I-0y
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:16:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iooiq-0006a5-Ms
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:16:37 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33383)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iooiq-0006Zb-FL
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:16:36 -0500
Received: by mail-wr1-x443.google.com with SMTP id b6so53937100wrq.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 05:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=wz+ab3yKTTG2QO/JQK25iGQwFvyEHf5eNj4sMASafjA=;
 b=QYKY1xHzQucUpyJ3hDxzAppttyLVMuHCH3480wC1fXtUuUawvUB7SPvfMz48uplY/r
 TDD3iaGlENl3sG0Jh48QgzfI3c7HHbjcr6mLKblKl26mp7EoiCuPJYrEDpjn/lDXaAsY
 XkdRAusiQ8x+GO9IVg1xRjRUbfT5gkJzAYF5Ba52HnRenJgr7RvIn2zYQzurvyUT7bw2
 hv1+QJFaYsuC7QxBnNRXPKyRaZgdwf1rDa5GrQ0HCGbQpHn9hWtbUNmRfFChyzc5Bkpq
 KH/MnyEY75nPTYt+ZkVT25ecL0Kv77atSdqVMWrKFlVpLSHyGn1HM0P/Otmhrmbg1/6I
 oCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=wz+ab3yKTTG2QO/JQK25iGQwFvyEHf5eNj4sMASafjA=;
 b=AlSYRcm++HzAzRnqFODNgymRpH+gVZYm8LSLStEx6Wal11jkzowPb0YG45Twd0Hvnj
 O7S2TJ29ZqiAgBINf+cldQkStgHuG+fQoAEELDe5z3HGIKD2Gnmp2oWZaCAKTdyio+/x
 pSRrKO8pP90l/XvCC+qof9OiDH53MigZywC4xi7US9ImmSsKh9NIwocByQvfJUsexsyu
 UV//VKlVqGxz22Vu1wJ+iv+EkdDWzP5ORQsQO04Y1sb59tkJmnbO8Xej4+rVbrqE2e06
 PoVigZYzsMhkNuJ9iHyByA0F21AtlfEUS4BwCaqMnuOFhFMigvE5a0P3FoFzeJLuyJ/7
 1FDA==
X-Gm-Message-State: APjAAAW53wE4q75BxzeUQieCzcbHDh4u2GKU4AsTVDd4XRvJCsZ8Hm+3
 XsOhp4YLjSV28xSHdPQOS9ORkQ==
X-Google-Smtp-Source: APXvYqzxcmfQ/KV64Jzsbpy57fizc03+wRm4K7fr4FajQvSWUpL2eANyjSQJFu0lnnVN/giuAz7zzw==
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr102620578wrr.32.1578402994948; 
 Tue, 07 Jan 2020 05:16:34 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f17sm26925561wmc.8.2020.01.07.05.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 05:16:33 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C7B341FF87;
 Tue,  7 Jan 2020 13:16:32 +0000 (GMT)
References: <20191218223441.23852-1-richard.henderson@linaro.org>
 <20191218223441.23852-5-richard.henderson@linaro.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 4/7] configure: Always detect -no-pie toolchain support
In-reply-to: <20191218223441.23852-5-richard.henderson@linaro.org>
Date: Tue, 07 Jan 2020 13:16:32 +0000
Message-ID: <87o8vf4dan.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: berrange@redhat.com, Thomas Huth <thuth@redhat.com>, i@maskray.me,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> The CFLAGS_NOPIE and LDFLAGS_NOPIE variables are used
> in pc-bios/optionrom/Makefile, which has nothing to do
> with the PIE setting of the main qemu executables.
>
> This overrides any operating system default to build
> all executables as PIE, which is important for ROMs.

But if the compiler doesn't support no-pie it just keeps going on.
Should the sub-build be bailing if _NOPIE is empty?

>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  configure | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/configure b/configure
> index 99faf64a74..7a646ec007 100755
> --- a/configure
> +++ b/configure
> @@ -2018,26 +2018,24 @@ if ! compile_prog "-Werror" "" ; then
>  	"Thread-Local Storage (TLS). Please upgrade to a version that does."
>  fi
>=20=20
> -if test "$pie" !=3D "no" ; then
> -  cat > $TMPC << EOF
> +cat > $TMPC << EOF
>=20=20
>  #ifdef __linux__
>  #  define THREAD __thread
>  #else
>  #  define THREAD
>  #endif
> -
>  static THREAD int tls_var;
> -
>  int main(void) { return tls_var; }
> -
>  EOF
> -  # check we support --no-pie first...
> -  if compile_prog "-Werror -fno-pie" "-no-pie"; then
> -    CFLAGS_NOPIE=3D"-fno-pie"
> -    LDFLAGS_NOPIE=3D"-nopie"
> -  fi
>=20=20
> +# Check we support --no-pie first; we will need this for building ROMs.
> +if compile_prog "-Werror -fno-pie" "-no-pie"; then
> +  CFLAGS_NOPIE=3D"-fno-pie"
> +  LDFLAGS_NOPIE=3D"-no-pie"
> +fi
> +
> +if test "$pie" !=3D "no" ; then
>    if compile_prog "-fPIE -DPIE" "-pie"; then
>      QEMU_CFLAGS=3D"-fPIE -DPIE $QEMU_CFLAGS"
>      LDFLAGS=3D"-pie $LDFLAGS"


--=20
Alex Benn=C3=A9e

