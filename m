Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17600C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 22:47:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D35AE20717
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 22:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IvyNtdT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D35AE20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihi6m-00050J-0m
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 17:47:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihi5S-00040e-Iz
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 17:46:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihi5R-0002gn-GI
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 17:46:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29707
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihi5R-0002g3-Cd
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 17:46:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576709192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tLMnf+phD1Je4suXOfo0y99dB9IYDnnBH8maU5Pl4Zc=;
 b=IvyNtdT9W0uOnQeZFRB4jAUNuKS+j2iv7JhYiiNCXQxfFtZ5ueYF1VcukMb51r5URELX5i
 wcT8ccL1EeusvhbqS14gi7XNZtjkzIkDgaJyDGMTqwYtveIlfHrENeP/0Xke9Tfk5rI2E+
 i2evK30T9JDW9m3IAFajSbMU+/ViKzQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-rLqqADhFOhKJJWibkk8E4Q-1; Wed, 18 Dec 2019 17:46:31 -0500
Received: by mail-wr1-f70.google.com with SMTP id l20so1481121wrc.13
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 14:46:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NDer1aNmkVVmNnOi/Mb1kj/48RcxFBrg/M/D+gV88Cs=;
 b=LmLaU/tS1AfU7RW6Jx/LcqNP08TwfWaMrmzHrcme1V6RRo/8iPZCJ/teeAQA2GRMaG
 Pz4r5+WWCD1MNj8FuVhkfIl4LOt5GsHPJYkS7JTVhIAQrZLKRgMKxtREq1cmCdplbkuM
 fLCCGE5WOkml0js/3X6Fz6vMwcf6hREMt/8oeS+bUrRf3QDzS4miH7fUsdzE/7LhK+Yf
 6N45VyuW/zNTZKZr0VMfyaPR12RBbIU76pZ1Gfg8i1EopHUv7gXdjoNWL5YWBaWio0h+
 ziC1Y8UIc9cRJnc6WK53eejjPWmSgBEfTmDv2um3dBfpm4kpCQPyq2K4iwo7oCn51cy0
 00jQ==
X-Gm-Message-State: APjAAAUBeYNzjclQ5ltL4rxhiTMU9cYu4oQaUNtToYiCgaSBrGDX1aWi
 7oImqfy9RJDxQCNCLaM1lB7ffSt/UmKg/m2iIp0SdZlXS9Or3IWDdEsu88qjb9e9GE68z3vP9Ie
 51olak8zFsxAeG5s=
X-Received: by 2002:a05:600c:2283:: with SMTP id
 3mr6130324wmf.100.1576709189866; 
 Wed, 18 Dec 2019 14:46:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqzqPWVrczQc2Qu5bpVM91nWw6qv0FR2WdcLMGGMMQonQmrwuIe17c+UONyLN8n9LSsD7gXu5A==
X-Received: by 2002:a05:600c:2283:: with SMTP id
 3mr6130310wmf.100.1576709189674; 
 Wed, 18 Dec 2019 14:46:29 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id n14sm3958722wmi.26.2019.12.18.14.46.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 14:46:29 -0800 (PST)
Subject: Re: [PATCH v2 5/7] configure: Unnest detection of -z, relro and -z,
 now
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191218223441.23852-1-richard.henderson@linaro.org>
 <20191218223441.23852-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d6e9a554-cd86-fbe0-deea-2e7c4ad38ac2@redhat.com>
Date: Wed, 18 Dec 2019 23:46:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218223441.23852-6-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: rLqqADhFOhKJJWibkk8E4Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: i@maskray.me, berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/18/19 11:34 PM, Richard Henderson wrote:
> There is nothing about these options that is related to PIE.
> Use them unconditionally.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Do not split into two tests.
> ---
>   configure | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/configure b/configure
> index 7a646ec007..2503288654 100755
> --- a/configure
> +++ b/configure
> @@ -2040,9 +2040,6 @@ if test "$pie" !=3D "no" ; then
>       QEMU_CFLAGS=3D"-fPIE -DPIE $QEMU_CFLAGS"
>       LDFLAGS=3D"-pie $LDFLAGS"
>       pie=3D"yes"
> -    if compile_prog "" "-Wl,-z,relro -Wl,-z,now" ; then
> -      LDFLAGS=3D"-Wl,-z,relro -Wl,-z,now $LDFLAGS"
> -    fi
>     else
>       if test "$pie" =3D "yes"; then
>         error_exit "PIE not available due to missing toolchain support"
> @@ -2053,6 +2050,12 @@ if test "$pie" !=3D "no" ; then
>     fi
>   fi
>  =20
> +# Detect support for PT_GNU_RELRO + DT_BIND_NOW.
> +# The combination is known as "full relro", because .got is read-only to=
o.
> +if compile_prog "" "-Wl,-z,relro -Wl,-z,now" ; then
> +  LDFLAGS=3D"-Wl,-z,relro -Wl,-z,now $LDFLAGS"
> +fi
> +
>   ##########################################
>   # __sync_fetch_and_and requires at least -march=3Di486. Many toolchains
>   # use i686 as default anyway, but for those that don't, an explicit
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


