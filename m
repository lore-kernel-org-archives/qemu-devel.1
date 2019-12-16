Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2CDC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 19:00:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 797192064B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 19:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWDilNPT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797192064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igvbI-0002jV-I8
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 14:00:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1igvae-0002ID-BB
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 13:59:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1igvab-0006ON-1q
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 13:59:30 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52460
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1igvaa-0006MF-Uc
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 13:59:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576522767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JmN7GHzSnBUERgeq2x7tEFqTgLBqL+ZJxhPxwtiXMFg=;
 b=LWDilNPTI1PUd1Epc3AzS5Srs7AKymUXQy87HPvM6fMPnvlSXaNBGTofjc1MbWqg1ugX2t
 +90GaTgMc+9Rku5LNB4x+N0kv9Ylqwj3Y+qW9LHKFz3QMcB08kAVigs9ro7ELa9vCUTMFY
 ToXAW6s/t06FJGrZsr8DGinfApkrqoI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-1CmUG-YcMniunTaPHF6N4g-1; Mon, 16 Dec 2019 13:59:25 -0500
Received: by mail-wm1-f72.google.com with SMTP id y125so196144wmg.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 10:59:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XRQL2Ip4of8ANJqgvSZKsjSLBE2IwKgg7RobWQJIgb4=;
 b=F2X9qLF9EHuX2lMPhV78C3fVOdtS0KUbj99VBkg/InIMNgcpLnt8ztAJvO86TNU1JA
 NpsJ0pTIeJHfDig5XSjF1bqTbjcwb3xYORC6fqa4Ki12luF0J/IMvPBcT9V3wMe6IB8X
 /bFlV++Guq7aDhAQTQzzqJ0J5y24tYezun6S53ia47NhQpj4Ewumk6SfS8Q7QdSK0OMb
 HFghtbti4tKMDyeOun58ISy1MllOvYhnkNfoObk18xdZCLc1MIxEirLEhiu2S92T9WDV
 UkuDJz1cqA7yHpa2txD5tRVOVtEd7LLZsTbygXIT/KGbtu6gd8/ZHF05VO+Xz/hhRRZ4
 nMbw==
X-Gm-Message-State: APjAAAX7oRyWCDTPmXzkij2fTgPCrXvo39vZufgPQom3rmJdrZcIFU5N
 tI0VbI9z9nSRPS6BoHS3HCw1BFwnnSXvMrsw02wHTyFQAeVfiSxCreHpRv19HhsDo17BmMgA1SF
 bsjxCHspyU4zEVl8=
X-Received: by 2002:adf:eb09:: with SMTP id s9mr33302524wrn.61.1576522764510; 
 Mon, 16 Dec 2019 10:59:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqxivICK9W8g42BXvO9R7oRXocUpwHuNyUq9cTWx9dzDU4ZJWttkyuqn/Yu8TE4hgedyXBh3dg==
X-Received: by 2002:adf:eb09:: with SMTP id s9mr33302501wrn.61.1576522764325; 
 Mon, 16 Dec 2019 10:59:24 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id k8sm22894594wrl.3.2019.12.16.10.59.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2019 10:59:23 -0800 (PST)
Subject: Re: [PATCH v1 01/16] configure: allow disable of cross compilation
 containers
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191216110732.24027-1-alex.bennee@linaro.org>
 <20191216110732.24027-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d64334fe-9e5a-1d90-2005-7bd59eac3cc6@redhat.com>
Date: Mon, 16 Dec 2019 19:59:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216110732.24027-2-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: 1CmUG-YcMniunTaPHF6N4g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 Stefan Weil <sw@weilnetz.de>, richard.henderson@linaro.org, f4bug@amsat.org,
 cota@braap.org, stefanha@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/16/19 12:07 PM, Alex Benn=C3=A9e wrote:
> Our docker infrastructure isn't quite as multiarch as we would wish so
> lets allow the user to disable it if they want. This will allow us to
> use still run check-tcg on non-x86 CI setups.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Stefan Weil <sw@weilnetz.de>
> ---
>   configure              | 8 +++++++-
>   tests/tcg/configure.sh | 6 ++++--
>   2 files changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/configure b/configure
> index 2c72e04d23f..419e1554978 100755
> --- a/configure
> +++ b/configure
> @@ -302,6 +302,7 @@ audio_win_int=3D""
>   libs_qga=3D""
>   debug_info=3D"yes"
>   stack_protector=3D""
> +use_containers=3D"yes"
>  =20
>   if test -e "$source_path/.git"
>   then
> @@ -1539,6 +1540,10 @@ for opt do
>     ;;
>     --disable-plugins) plugins=3D"no"
>     ;;
> +  --enable-containers) use_containers=3D"yes"
> +  ;;
> +  --disable-containers) use_containers=3D"no"
> +  ;;
>     *)
>         echo "ERROR: unknown option $opt"
>         echo "Try '$0 --help' for more information"
> @@ -1722,6 +1727,7 @@ Advanced options (experts only):
>                              track the maximum stack usage of stacks crea=
ted by qemu_alloc_stack
>     --enable-plugins
>                              enable plugins via shared library loading
> +  --disable-containers     don't use containers for cross-building

Maybe we can "(default enabled if detected)" or "(... if docker or=20
podman available)".

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>  =20
>   Optional features, enabled with --enable-FEATURE and
>   disabled with --disable-FEATURE, default is enabled if available:
> @@ -8023,7 +8029,7 @@ done
>   (for i in $cross_cc_vars; do
>     export $i
>   done
> -export target_list source_path
> +export target_list source_path use_containers
>   $source_path/tests/tcg/configure.sh)
>  =20
>   # temporary config to build submodules
> diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
> index 6c4a471aeae..210e68396f2 100755
> --- a/tests/tcg/configure.sh
> +++ b/tests/tcg/configure.sh
> @@ -36,8 +36,10 @@ TMPC=3D"${TMPDIR1}/qemu-conf.c"
>   TMPE=3D"${TMPDIR1}/qemu-conf.exe"
>  =20
>   container=3D"no"
> -if has "docker" || has "podman"; then
> -  container=3D$($python $source_path/tests/docker/docker.py probe)
> +if test $use_containers =3D "yes"; then
> +    if has "docker" || has "podman"; then
> +        container=3D$($python $source_path/tests/docker/docker.py probe)
> +    fi
>   fi
>  =20
>   # cross compilers defaults, can be overridden with --cross-cc-ARCH
>=20


