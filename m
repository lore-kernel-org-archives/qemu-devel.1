Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39379C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:14:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04E8D2073D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nXSSbIn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E8D2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iorVR-0001BK-6B
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 11:14:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iorUp-0000Og-NW
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:14:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iorUn-0004Zt-Ff
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:14:18 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43483)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iorUn-0004ZC-97
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:14:17 -0500
Received: by mail-oi1-x241.google.com with SMTP id p125so15935083oif.10
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 08:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Pe1Q+5s/HuqyjI745fEx8zW5ARIcEczfiyXTiyOMXJI=;
 b=nXSSbIn8LovA76t+uFoMey0Gq+VUcwSPmdzIynwAoa/m/r+alForuwGwkdVzIscjjT
 mj5brO5Wae8J4ptDuyXwLrpzfcrQp74mmk9lh/pPdNCCSL+CZMjDAebucktdgXyxNvcE
 gt1+J1O5k2RyuEjRB4p2glYk+RkZF4fqcM7Ay+Y1+wW4Q500Z88GgzNxPHd1SwePNQod
 aI/hox0GphraZwqxZazShi7ShL9l5EswI+gWZb/Ugz82L/mJ4UQzGH3wWtHgB8r6nfeZ
 +AmzImjiEC3f+Iwv49G6lyqS/wLuFpr3Gr7btFGo5t4a7HHcivWt8dztB5hDIt7VBsZC
 XTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Pe1Q+5s/HuqyjI745fEx8zW5ARIcEczfiyXTiyOMXJI=;
 b=LDooxxFzjvokB6AUu0OnOyZesdJ93jy3H6Y+Lxr4T0nqp4ACfxtm/avYBd/WkJORBw
 5yAl+5zGrYwzEfDchcWY65XaiKXcJlb7Z+csQYyYU8h+PyZ0DBERRJYWMzRwUp8woCIH
 XJ8BQOAF80yRHRoWP3SsLF1HssR9aSqbzofrZPyySnMiIXWZdT1VfCGXlseU4THj0JHs
 +A1Kpd0bg6dB741heIP1mIooS6oS/QAcURl7ljdWJ6SkOflkdCk2GAEHXnPhiQAbAaY6
 SS9mGLJfyr7FoI5NlhaM3GFHmYNK7/HOUTtLHqwedRlljcUiNA/wkfMHShkEj8E4SuFl
 GkxQ==
X-Gm-Message-State: APjAAAVthQfzwVzB0BB/DxleLvnFHK25t9rL7G7DLo4JvmHT+qVUSs19
 zpPrWJXxGMfmipx0Jfam1/QNr5bm7AhN1pEIQxpd8w==
X-Google-Smtp-Source: APXvYqw0FAagbl6EuW1/HRl0QoSeC/ria65T7Dlo9ovigOpqjjjaY4JsHUgoPL2ATOZdL/UEmW0ZxUPMkrylJnFwfM4=
X-Received: by 2002:aca:3182:: with SMTP id x124mr296436oix.170.1578413655988; 
 Tue, 07 Jan 2020 08:14:15 -0800 (PST)
MIME-Version: 1.0
References: <20200106144622.1520994-1-marcandre.lureau@redhat.com>
 <20200106144622.1520994-7-marcandre.lureau@redhat.com>
In-Reply-To: <20200106144622.1520994-7-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Jan 2020 16:14:05 +0000
Message-ID: <CAFEAcA8c3A_zXcHRF3kj9z3C2AtLLPatQ=h=NX2+Ywzj+OiyVg@mail.gmail.com>
Subject: Re: [PULL v2 6/9] configure: add GDBUS_CODEGEN
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 Jan 2020 at 14:47, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> gdbus-codegen generated code requires gio-unix on Unix, so add it to
> GIO libs/cflags.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  configure | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/configure b/configure
> index 747d3b4120..0ce2c0354a 100755
> --- a/configure
> +++ b/configure
> @@ -3701,10 +3701,16 @@ if $pkg_config --atleast-version=3D$glib_req_ver =
gio-2.0; then
>      gio=3Dyes
>      gio_cflags=3D$($pkg_config --cflags gio-2.0)
>      gio_libs=3D$($pkg_config --libs gio-2.0)
> +    gdbus_codegen=3D$($pkg_config --variable=3Dgdbus_codegen gio-2.0)
>  else
>      gio=3Dno
>  fi
>
> +if $pkg_config --atleast-version=3D$glib_req_ver gio-unix-2.0; then
> +    gio_cflags=3D"$gio_cflags $($pkg_config --cflags gio-unix-2.0)"
> +    gio_libs=3D"$gio_libs $($pkg_config --libs gio-unix-2.0)"
> +fi
> +
>  # Sanity check that the current size_t matches the
>  # size that glib thinks it should be. This catches
>  # problems on multi-arch where people try to build
> @@ -6904,6 +6910,7 @@ if test "$gio" =3D "yes" ; then
>      echo "CONFIG_GIO=3Dy" >> $config_host_mak
>      echo "GIO_CFLAGS=3D$gio_cflags" >> $config_host_mak
>      echo "GIO_LIBS=3D$gio_libs" >> $config_host_mak
> +    echo "GDBUS_CODEGEN=3D$gdbus_codegen" >> $config_host_mak
>  fi

I've just noticed that this seems to cause problems for
the NetBSD VM, because pkg-config reports a value for
gdbus_codegen which isn't an installed binary:

localhost$ pkg-config --variable=3Dgdbus_codegen gio-2.0
/usr/pkg/bin/gdbus-codegen
localhost$ ls /usr/pkg/bin/gdbus-codegen
ls: /usr/pkg/bin/gdbus-codegen: No such file or directory

I think we need to install the 'gdbus-codegen' package in
our netbsd VM image.

Maybe configure should check that it's actually got
an executable file before trying to use it?

thanks
-- PMM

