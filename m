Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D411C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 457E5206F0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RVpy6YSV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 457E5206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iond0-0002v3-6Z
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 07:06:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ionAn-0007jG-GX
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:37:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ionAm-0005Zi-DS
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:37:21 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32235
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ionAm-0005ZO-AE
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:37:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578397039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UBpa3wEC1EXTgCzsrbk0dmd9khCUBUaxbLDkLlm1XTI=;
 b=RVpy6YSVRfw/ZfyapXaSAxU+o6rHvBcK42nAf94Br6eDj0aSSHZdn82O+4a5qdkxRADJXO
 jGAEiwpqrVW9pMFbg6wHBkyiIVUUeSLlv1WrLkUB4b9ikxl1ZXhM2uUcobGU25qAXd8RCZ
 bpnqc29W39dcv3A2zyBqku39s592aRU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-TTaR4tsyNWmci1nOCRqcJQ-1; Tue, 07 Jan 2020 06:37:18 -0500
Received: by mail-wr1-f72.google.com with SMTP id c17so3465405wrp.10
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 03:37:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZtgUgJDOD4fD+dlStELsHBH+3AtHqgzoZaJp5Bc3FZk=;
 b=YnyNIycVS6n4SK8Z6RCT5oFhKicrIq7LBkUOoDYozNpKWzdAtr1nDof93HHbfL3TWb
 yAlfvG0Ku3ingPvPMjF/v1Bv+dBiEsUJ9c561XVbUxAb5bxxTACZL61/sZ4BO3phvpnb
 6YVfKMVsTKb9vRG1WyW/sYnCK+xVNFT1dZHWnVoZasPT14fX3B6zRnpTpyGchnBGVZIx
 0FYed5NhWD0zag1dxior23VeVjBw7JNXL4PvYdCNVYLYIIRMc4bVV/ApVxY2qe8GQqCU
 1TOrE3lWBTg2pGkgv/jnJujjLpXkoT4WWSNhsqhSUbDd2fEt2iTg4t9DPD1ldAKUie+z
 ETzg==
X-Gm-Message-State: APjAAAUZSBs/n/SL5NT8n73s8pUwyWf0x+t5CxsvDh2pTaN4Zf2XfFfK
 XsVQGDVqqAHtjRqWqZ88E/1lj58ZBaFXoENSRHhmyjT3uhipQZF/hUcPKbni9PjwdgHQ/RMqYzM
 OQL50joxmr3EiEZc=
X-Received: by 2002:adf:cf06:: with SMTP id o6mr107701966wrj.349.1578397037348; 
 Tue, 07 Jan 2020 03:37:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqzCKYv1LhslbHW+k4awjnGUZKpY03FhmkoOlUxGLTheGr8dhkh19KdkfXoDOnu/yPhaM7Ivsw==
X-Received: by 2002:adf:cf06:: with SMTP id o6mr107701946wrj.349.1578397037182; 
 Tue, 07 Jan 2020 03:37:17 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id i16sm27174036wmb.36.2020.01.07.03.37.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 03:37:16 -0800 (PST)
Subject: Re: [PATCH v2 3/7] configure: Do not force pie=no for non-x86
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191218223441.23852-1-richard.henderson@linaro.org>
 <20191218223441.23852-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4f4a5331-c2a2-b122-73a9-35afa6bf2926@redhat.com>
Date: Tue, 7 Jan 2020 12:37:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218223441.23852-4-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: TTaR4tsyNWmci1nOCRqcJQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
> PIE is supported on many other hosts besides x86.
>=20
> The default for non-x86 is now the same as x86: pie is used
> if supported, and may be forced via --enable/--disable-pie.
>=20
> The original commit (40d6444e91c) said:
>=20
>    "Non-x86 are not changed, as they require TCG changes"
>=20
> but I think that's wrong -- there's nothing about PIE that
> affects TCG one way or another.
>=20
> Tested on aarch64 (bionic) and ppc64le (centos 7) hosts.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   configure | 10 ----------
>   1 file changed, 10 deletions(-)
>=20
> diff --git a/configure b/configure
> index 30e3875c6b..99faf64a74 100755
> --- a/configure
> +++ b/configure
> @@ -2018,16 +2018,6 @@ if ! compile_prog "-Werror" "" ; then
>   =09"Thread-Local Storage (TLS). Please upgrade to a version that does."
>   fi
>  =20
> -if test "$pie" =3D ""; then
> -  case "$cpu-$targetos" in
> -    i386-Linux|x86_64-Linux|x32-Linux|i386-OpenBSD|x86_64-OpenBSD)
> -      ;;
> -    *)
> -      pie=3D"no"
> -      ;;
> -  esac
> -fi
> -
>   if test "$pie" !=3D "no" ; then
>     cat > $TMPC << EOF
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


