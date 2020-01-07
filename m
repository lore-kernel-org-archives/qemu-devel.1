Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24332C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0BBB2187F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f/zmM2/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0BBB2187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioqDu-0005IE-2O
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:52:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iopB6-0007ye-Aw
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:45:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iopB4-0005P2-Sb
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:45:47 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43495)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iopB4-0005OI-Hj
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:45:46 -0500
Received: by mail-wr1-x443.google.com with SMTP id d16so53979815wre.10
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 05:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=BfVg/WfB/npygxZ7/2hzRL6di2s8nJIO/3FCAV+HBXo=;
 b=f/zmM2/89ZBOc/ZBkTdNjUJ0qKPzzmlATj0Q7KipQpGLtto4nGwEN8vF3YrzvWZGyn
 Gi787c9smeoy1njzw5Cxge9WzPGXVB5K3/MJXYNrUXSMAVQ6lh9e75OvOEn+gckm+vuC
 NTs/Z35knaI0/Dpw0IF4rnaySYeSTyJw/6WpdRgjWMualUZvfMWaHUCH0Ilt3lEwriFn
 02A9uGeL0PmRPQ4rqhr67ZDT4ssIvWmO9FeAakGlNQID/Ey4Xass8ONPl+YjVWrSQ29B
 X6LY5FM9qBPC+beTn2MDW/9Hbhclw60SUojPuwPEVVjxdGHhOndBzd8oVUZYsQWB0/oX
 kxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=BfVg/WfB/npygxZ7/2hzRL6di2s8nJIO/3FCAV+HBXo=;
 b=NCjez2pUSuPPlnh1BQWjqNpflhjSP+AOmUIMyNzPWhBt/41+HbJhzr48MGdKAGdrhF
 mRlbtWz8T9YTg32hLc74LJ8PsXCLmWsdBX05mVh7nSjYIcERVoNyX2GPDuURlDJBhvex
 g6yWE4R5Y1kfgx0z2ThCSK3r344a7wkjOu2oK+vO6n5SXnQJcXNT4yeDzsFa/N3lDqZ/
 CorxrLUx+zHF4WqLoubnvrEq2iNtd2M9yH9n8p9+tOgyDPxtX/PIeM35CN4UTQN5qhKr
 4my59BcOVvJrlt8lByyEfnsOoeF1avFLaRH9Fmi1KmZ/Qbvke9FMefX4r2cdmE+5FIfN
 Du1Q==
X-Gm-Message-State: APjAAAXlPHugiBvHuIaBtAQGuHVB+mho4v3WTcBPNx/t9eS7TPOgi8ns
 swh/hM4ZxzyzAOovaypqDNXkAw==
X-Google-Smtp-Source: APXvYqziXbxFqLBJWCg0c+Jw4pP/R31MntQtcV+17gHQg+ds2IUNvFx1YHil6NriT3g3RPkvHvnhkA==
X-Received: by 2002:adf:a141:: with SMTP id r1mr110862171wrr.285.1578404745311; 
 Tue, 07 Jan 2020 05:45:45 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n8sm77098417wrx.42.2020.01.07.05.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 05:45:44 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9563F1FF87;
 Tue,  7 Jan 2020 13:45:43 +0000 (GMT)
References: <20191218223441.23852-1-richard.henderson@linaro.org>
 <20191218223441.23852-8-richard.henderson@linaro.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 7/7] configure: Support -static-pie if requested
In-reply-to: <20191218223441.23852-8-richard.henderson@linaro.org>
Date: Tue, 07 Jan 2020 13:45:43 +0000
Message-ID: <87ftgr4by0.fsf@linaro.org>
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
Cc: berrange@redhat.com, i@maskray.me, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Recent toolchains support static and pie at the same time.
>
> As with normal dynamic builds, allow --static to default to PIE
> if supported by the toolchain.  Allow --enable/--disable-pie to
> override the default.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
> v2: Fix --disable-pie --static
> ---
>  configure | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/configure b/configure
> index f6ff079fab..55586c5498 100755
> --- a/configure
> +++ b/configure
> @@ -1024,7 +1024,6 @@ for opt do
>    ;;
>    --static)
>      static=3D"yes"
> -    LDFLAGS=3D"-static $LDFLAGS"
>      QEMU_PKG_CONFIG_FLAGS=3D"--static $QEMU_PKG_CONFIG_FLAGS"
>    ;;
>    --mandir=3D*) mandir=3D"$optarg"
> @@ -2000,11 +1999,6 @@ if test "$static" =3D "yes" ; then
>    if test "$modules" =3D "yes" ; then
>      error_exit "static and modules are mutually incompatible"
>    fi
> -  if test "$pie" =3D "yes" ; then
> -    error_exit "static and pie are mutually incompatible"
> -  else
> -    pie=3D"no"
> -  fi
>  fi
>=20=20
>  # Unconditional check for compiler __thread support
> @@ -2035,7 +2029,18 @@ if compile_prog "-Werror -fno-pie" "-no-pie"; then
>    LDFLAGS_NOPIE=3D"-no-pie"
>  fi
>=20=20
> -if test "$pie" =3D "no"; then
> +if test "$static" =3D "yes"; then
> +  if test "$pie" !=3D "no" && compile_prog "-fPIE -DPIE" "-static-pie"; =
then
> +    QEMU_CFLAGS=3D"-fPIE -DPIE $QEMU_CFLAGS"
> +    LDFLAGS=3D"-static-pie $LDFLAGS"
> +    pie=3D"yes"
> +  elif test "$pie" =3D "yes"; then
> +    error_exit "-static-pie not available due to missing toolchain suppo=
rt"
> +  else
> +    LDFLAGS=3D"-static $LDFLAGS"
> +    pie=3D"no"
> +  fi
> +elif test "$pie" =3D "no"; then
>    QEMU_CFLAGS=3D"$CFLAGS_NOPIE $QEMU_CFLAGS"
>    LDFLAGS=3D"$LDFLAGS_NOPIE $LDFLAGS"
>  elif compile_prog "-fPIE -DPIE" "-pie"; then


--=20
Alex Benn=C3=A9e

