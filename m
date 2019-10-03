Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794D1C32792
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 00:17:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44FC820862
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 00:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxFRTuqJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44FC820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGBH7-0004Oj-Ul
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 20:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iGAdx-0004r2-UI
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:36:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iGAdv-00063p-Qc
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:36:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32010
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iGAdP-0005jW-QC
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1570145747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fyCnNaclr1coILkgqFFyMfCkBB0uT3Y7AO7cBo7S4ZY=;
 b=DxFRTuqJPL/Gt/w7H4pIiCxSvNVgsTXcHbDwzsaInxQZptIp5u4y7McW5O/QH0TzIdeQC+
 99WYibk6ZrDbFiDR1PspCo68s/uhqyW3dLmc8xp1OoJ0c/K/1/ZNWfmTPrDm+J/ddGIj1L
 X/7kTkmwQctmqXGs+WK+tBEijgRFCKw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-4kW3MijbOvKsC83lzJAh4w-1; Thu, 03 Oct 2019 19:35:42 -0400
Received: by mail-wr1-f71.google.com with SMTP id z1so1809293wrw.21
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 16:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1KQnw7PBZF8rEylxGzGQfhR2h8Ga9+Dwp53B1SQXiqA=;
 b=fUs+tgiC3+rK75kXkz/mWijCSdOhZ8sNukuFDtZX11GvTobK5GGD+mBBsEUnbVJZo0
 1OE5V/umUJ9Do8QDjpxuZM9puX8XyaulV4G+8d4SA24oj9M+nsCc9HiSGTM9Rv1Q/+WZ
 LjKCv9Flgkv3PylStmktl5/4YIE+XUDAcIFnCCd4cqVVlYDLnki7skfzixNj5jQXRESJ
 BBOQluMWLnZw/xXO+nnbck04fFiMNZEzSOLswYSjJ+i8LtbcIu0nYEdv11RFGbkp6usk
 jBqth6qofFsxn4LFzvUaUo5eHhtSWwkIzxyo+vcEYqysTjUMs3hKg7qJ8q6Z5cqmSG1x
 /qUQ==
X-Gm-Message-State: APjAAAXdWgnmSOeg9PTWX6a5TeRTh+oiZjy3Kk9H76//JTW4hOqC8Z8w
 RK0ROM3GCDQ73guHLgOGSF0t7lcxMvuUjQxMb7Iq0eFMm8BXS33cIlKtMWoqsFbTeVPeoLnXnAF
 3jtSs4Y+sFag6eJE=
X-Received: by 2002:a1c:4485:: with SMTP id r127mr8148528wma.59.1570145741292; 
 Thu, 03 Oct 2019 16:35:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy8x6A6rpU/0ANmmPqoIyuyDKJZwaKUGYw7emWr2/A87J7ZWs6qYAp2Il12lbgTPElnmPf0Yg==
X-Received: by 2002:a1c:4485:: with SMTP id r127mr8148519wma.59.1570145741062; 
 Thu, 03 Oct 2019 16:35:41 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id t17sm7175316wrp.72.2019.10.03.16.35.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2019 16:35:40 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2 10/15] target/arm/arm-semi: Factor out
 implementation of SYS_ISTTY
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190916141544.17540-1-peter.maydell@linaro.org>
 <20190916141544.17540-11-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <20a30b5b-177b-0d24-00bb-6b49305af8a0@redhat.com>
Date: Fri, 4 Oct 2019 01:35:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190916141544.17540-11-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: 4kW3MijbOvKsC83lzJAh4w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/19 4:15 PM, Peter Maydell wrote:
> Factor out the implementation of SYS_ISTTY via the new function
> tables.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   target/arm/arm-semi.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
> index 958083a105c..ecd51338fd3 100644
> --- a/target/arm/arm-semi.c
> +++ b/target/arm/arm-semi.c
> @@ -388,6 +388,7 @@ typedef uint32_t sys_writefn(ARMCPU *cpu, GuestFD *gf=
,
>                                target_ulong buf, uint32_t len);
>   typedef uint32_t sys_readfn(ARMCPU *cpu, GuestFD *gf,
>                               target_ulong buf, uint32_t len);
> +typedef uint32_t sys_isattyfn(ARMCPU *cpu, GuestFD *gf);
>  =20
>   static uint32_t host_closefn(ARMCPU *cpu, GuestFD *gf)
>   {
> @@ -436,6 +437,11 @@ static uint32_t host_readfn(ARMCPU *cpu, GuestFD *gf=
,
>       return len - ret;
>   }
>  =20
> +static uint32_t host_isattyfn(ARMCPU *cpu, GuestFD *gf)
> +{
> +    return isatty(gf->hostfd);
> +}
> +
>   static uint32_t gdb_closefn(ARMCPU *cpu, GuestFD *gf)
>   {
>       return arm_gdb_syscall(cpu, arm_semi_cb, "close,%x", gf->hostfd);
> @@ -457,10 +463,16 @@ static uint32_t gdb_readfn(ARMCPU *cpu, GuestFD *gf=
,
>                              gf->hostfd, buf, len);
>   }
>  =20
> +static uint32_t gdb_isattyfn(ARMCPU *cpu, GuestFD *gf)
> +{
> +    return arm_gdb_syscall(cpu, arm_semi_cb, "isatty,%x", gf->hostfd);
> +}
> +
>   typedef struct GuestFDFunctions {
>       sys_closefn *closefn;
>       sys_writefn *writefn;
>       sys_readfn *readfn;
> +    sys_isattyfn *isattyfn;
>   } GuestFDFunctions;
>  =20
>   static const GuestFDFunctions guestfd_fns[] =3D {
> @@ -468,11 +480,13 @@ static const GuestFDFunctions guestfd_fns[] =3D {
>           .closefn =3D host_closefn,
>           .writefn =3D host_writefn,
>           .readfn =3D host_readfn,
> +        .isattyfn =3D host_isattyfn,
>       },
>       [GuestFDGDB] =3D {
>           .closefn =3D gdb_closefn,
>           .writefn =3D gdb_writefn,
>           .readfn =3D gdb_readfn,
> +        .isattyfn =3D gdb_isattyfn,
>       },
>   };
>  =20
> @@ -631,11 +645,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>               return set_swi_errno(env, -1);
>           }
>  =20
> -        if (use_gdb_syscalls()) {
> -            return arm_gdb_syscall(cpu, arm_semi_cb, "isatty,%x", gf->ho=
stfd);
> -        } else {
> -            return isatty(gf->hostfd);
> -        }
> +        return guestfd_fns[gf->type].isattyfn(cpu, gf);
>       case TARGET_SYS_SEEK:
>           GET_ARG(0);
>           GET_ARG(1);
>=20


