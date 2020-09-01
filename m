Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D1EC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:31:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEBC420767
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H6xWMce5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEBC420767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7Je-0008An-SM
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kD77e-0007GD-3Y
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:18:54 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37842)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kD77c-0004wk-5m
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:18:53 -0400
Received: by mail-wm1-x342.google.com with SMTP id a9so1332936wmm.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 07:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=0Yb+Gltctf3/JM710JiMDsXtRc9hl66wMufskZvdTd8=;
 b=H6xWMce5rXWEFMHoMfVztBVfH1DRt1+VrPvtL/Xxv2Uo2N69L1hH+yp9Alum5OWsyt
 W8Wh6QUq1wbYXweJgW3FPZk8vmdms7gAxtD9wXmxQGJWT9Ia3etTDe1kDp2Nro9c2mey
 dwmXw4Ri0wr0Y97i9wY9Oh7euSaHzTcCFUqB1j9xIQmcvx8o+f3YzrLs4yKd/rXvF99w
 oLU9FKaJQQF95P8yrVBdt95Dw6x5qSdvcr5GM3CgJSgQa87b65+pNAxT8aEzQh6YlkkF
 rmaX1jka345zsCMVhf0jJU+Gg+ndUx+dpwPZYmFefUHuA5ZqtV8bvTPRVMRK+VbndHW/
 Zlaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=0Yb+Gltctf3/JM710JiMDsXtRc9hl66wMufskZvdTd8=;
 b=W4H7hx3oDrigt2j/b5WvXaTpQlxTZx6KHn4hHSjkYRync9yN2mazM7lcaNJmzlE3kL
 TQ54ZmYVE/Xg0j0iEg9z8NdGdCw+G5PVGE+F2m7NzWypiRMLtjnlQe3G0P1ixowCaXFe
 Uo6N3nvlGQa9LeSjS+w9LCHFBncQhY32DuZ/HB59Ovp+5e6HuMHOG4+CPNrrSNaPSikY
 DAR5H+BIyMeHhOrK7T8g64kEKNZjGmfDkbrizeWNixmgMx3ewi9AKhOOL0qaEMuZV3PY
 SeUaPe8TXn4oFTWOIEI9EpiaM2EmtMtTeK/hkrwMfr/XpvtgV9WJ+05RXsYxQBx1xLUN
 2scg==
X-Gm-Message-State: AOAM531n2t9gxOiKnlFrjDBGy526WyZ8M8eM+9KETyAm3p1F+DGJbT78
 YOxEZ/M2CLsugK1Y6hSe9un3Jw==
X-Google-Smtp-Source: ABdhPJwLIVxOUIzl8JO2MTe5DWUUVIURMya3/FFV7kBrQv518cFJ5+ZRpo1nqlwncqRWqn3Q/Hkrwg==
X-Received: by 2002:a1c:678a:: with SMTP id b132mr2137993wmc.10.1598969930180; 
 Tue, 01 Sep 2020 07:18:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v128sm2159526wme.2.2020.09.01.07.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 07:18:48 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1F2621FF7E;
 Tue,  1 Sep 2020 15:18:48 +0100 (BST)
References: <20200901133050.381844-1-berrange@redhat.com>
 <20200901133050.381844-2-berrange@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 1/2] crypto: fix build with gcrypt enabled
In-reply-to: <20200901133050.381844-2-berrange@redhat.com>
Date: Tue, 01 Sep 2020 15:18:48 +0100
Message-ID: <875z8x60mv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> If nettle is disabled and gcrypt enabled, the compiler and linker flags
> needed for gcrypt are not passed.
>
> Gnutls was also not added as a dependancy when gcrypt is enabled.
>
> Attempting to add the library dependencies at the same time as the
> source dependencies is error prone, as there are alot of different
> rules for picking which sources to use, and some of the source files
> use code level conditionals intead. It is thus clearer to add the
> library dependencies separately.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

That seems to fix some of the container based builds.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  configure          |  2 ++
>  crypto/meson.build | 42 +++++++++++++++++++++++++++++++-----------
>  meson.build        |  5 +++++
>  3 files changed, 38 insertions(+), 11 deletions(-)
>
> diff --git a/configure b/configure
> index 8dc981684b..3dc2431722 100755
> --- a/configure
> +++ b/configure
> @@ -6979,6 +6979,8 @@ if test "$gcrypt" =3D "yes" ; then
>    if test "$gcrypt_hmac" =3D "yes" ; then
>      echo "CONFIG_GCRYPT_HMAC=3Dy" >> $config_host_mak
>    fi
> +  echo "GCRYPT_CFLAGS=3D$gcrypt_cflags" >> $config_host_mak
> +  echo "GCRYPT_LIBS=3D$gcrypt_libs" >> $config_host_mak
>  fi
>  if test "$nettle" =3D "yes" ; then
>    echo "CONFIG_NETTLE=3Dy" >> $config_host_mak
> diff --git a/crypto/meson.build b/crypto/meson.build
> index 18da7c8541..f6f5ce1ecd 100644
> --- a/crypto/meson.build
> +++ b/crypto/meson.build
> @@ -23,24 +23,35 @@ crypto_ss.add(files(
>    'tlssession.c',
>  ))
>=20=20
> -if 'CONFIG_GCRYPT' in config_host
> -  wo_nettle =3D files('hash-gcrypt.c', 'pbkdf-gcrypt.c')
> +if 'CONFIG_NETTLE' in config_host
> +  crypto_ss.add(files('hash-nettle.c', 'hmac-nettle.c', 'pbkdf-nettle.c'=
))
> +elif 'CONFIG_GCRYPT' in config_host
> +  crypto_ss.add(files('hash-gcrypt.c', 'pbkdf-gcrypt.c'))
> +  if 'CONFIG_GCRYPT_HMAC' in config_host
> +    crypto_ss.add(files('hmac-gcrypt.c'))
> +  else
> +    crypto_ss.add(files('hmac-glib.c'))
> +  endif
>  else
> -  wo_nettle =3D files('hash-glib.c', 'pbkdf-stub.c')
> -endif
> -if 'CONFIG_GCRYPT_HMAC' not in config_host
> -  wo_nettle +=3D files('hmac-glib.c')
> +  crypto_ss.add(files('hash-glib.c', 'hmac-glib.c', 'pbkdf-stub.c'))
>  endif
> -crypto_ss.add(when: [nettle, 'CONFIG_NETTLE'],
> -             if_true: files('hash-nettle.c', 'hmac-nettle.c', 'pbkdf-net=
tle.c'),
> -             if_false: wo_nettle)
>=20=20
>  crypto_ss.add(when: 'CONFIG_SECRET_KEYRING', if_true: files('secret_keyr=
ing.c'))
>  crypto_ss.add(when: 'CONFIG_QEMU_PRIVATE_XTS', if_true: files('xts.c'))
> -crypto_ss.add(when: 'CONFIG_GCRYPT_HMAC', if_true: files('hmac-gcrypt.c'=
))
>  crypto_ss.add(when: 'CONFIG_AF_ALG', if_true: files('afalg.c', 'cipher-a=
falg.c', 'hash-afalg.c'))
>  crypto_ss.add(when: 'CONFIG_GNUTLS', if_true: files('tls-cipher-suites.c=
'))
>=20=20
> +if 'CONFIG_NETTLE' in config_host
> +  crypto_ss.add(nettle)
> +elif 'CONFIG_GCRYPT' in config_host
> +  crypto_ss.add(gcrypt)
> +endif
> +
> +if 'CONFIG_GNUTLS' in config_host
> +  crypto_ss.add(gnutls)
> +endif
> +
> +
>  crypto_ss =3D crypto_ss.apply(config_host, strict: false)
>  libcrypto =3D static_library('crypto', crypto_ss.sources() + genh,
>                             dependencies: [crypto_ss.dependencies()],
> @@ -52,12 +63,21 @@ crypto =3D declare_dependency(link_whole: libcrypto,
>=20=20
>  util_ss.add(files('aes.c'))
>  util_ss.add(files('init.c'))
> +
>  if 'CONFIG_GCRYPT' in config_host
>    util_ss.add(files('random-gcrypt.c'))
>  elif 'CONFIG_GNUTLS' in config_host
> -  util_ss.add(files('random-gnutls.c'), gnutls)
> +  util_ss.add(files('random-gnutls.c'))
>  elif 'CONFIG_RNG_NONE' in config_host
>    util_ss.add(files('random-none.c'))
>  else
>    util_ss.add(files('random-platform.c'))
>  endif
> +
> +if 'CONFIG_GCRYPT' in config_host
> +  util_ss.add(gcrypt)
> +endif
> +
> +if 'CONFIG_GNUTLS' in config_host
> +  util_ss.add(gnutls)
> +endif
> diff --git a/meson.build b/meson.build
> index 1e7aee85e3..bc6aac4ce7 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -114,6 +114,11 @@ urcubp =3D not_found
>  if 'CONFIG_TRACE_UST' in config_host
>    urcubp =3D declare_dependency(link_args: config_host['URCU_BP_LIBS'].s=
plit())
>  endif
> +gcrypt =3D not_found
> +if 'CONFIG_GCRYPT' in config_host
> +  gcrypt =3D declare_dependency(compile_args: config_host['GCRYPT_CFLAGS=
'].split(),
> +                              link_args: config_host['GCRYPT_LIBS'].spli=
t())
> +endif
>  nettle =3D not_found
>  if 'CONFIG_NETTLE' in config_host
>    nettle =3D declare_dependency(compile_args: config_host['NETTLE_CFLAGS=
'].split(),


--=20
Alex Benn=C3=A9e

