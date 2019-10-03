Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA9DC10F14
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 00:00:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9739C208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 00:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H40JfbAu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9739C208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGB1Z-00047z-O1
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 20:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iGAfi-0005uC-5d
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:38:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iGAff-0007Qe-V3
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:38:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37574
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iGAff-0007QW-S9
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1570145887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DRTZigKCEY4opWJBLHi11l/zrCItDh8Z1O0Kg5+OawA=;
 b=H40JfbAuirE8uoW2rHeUdzL1OC2+densMtyhw/KGUx6pO8P8AuLp2XTWsR/lAVKt3+vgG7
 ki/ztCJZ8BPLMj7kBduvm2+1qwjB0J1P7zbkYrJfjaxNVeP00BMF/+1mP9+Zb2CFfVK0Ur
 2LSr9vCoAELJ3xUlIppbntVlW6yX0qw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-PnM_V3V-MfG76MRQPiY7Eg-1; Thu, 03 Oct 2019 19:38:04 -0400
Received: by mail-wr1-f69.google.com with SMTP id t11so1823224wro.10
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 16:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZIP0ODjDWHxED5SbJ/GsbdeKZ47VF2Eyu5DtWpV0WjY=;
 b=dM2rLaMnBMJHmMLHWRXA3gu/97hpEwEofF1RjOxyQbnnEMdDeTPPKavwNiQWpifGSo
 Y7nw5VCrhLoYTaUkuKDU1TpjhEi1cOQgxsFa0OLqZ/+WqRSETya7MamXuyNln5QvrTCp
 KZuOpMnvkdQ8lk3RpackJtJnZDIIYPQoMkY0KuaJHxsrDPypinuBpknqdBYZ4jHyPR7J
 RdhLA0g1T1oTh8MopmqfsG+gXq2MCuJ0zQM8BIseajpDuGmX9T+GgT8vv6qKOvK5cBkn
 D5pBshOOTbYIsT9W2dZEtireMDMZ+X5AOmQ3/zeGI339vjAZUU/RZNDEbEAcSUQSBflv
 oyNg==
X-Gm-Message-State: APjAAAUXkFASSSHm63CT4FtAWcDvmYUBxOIwqsI5Nb+k1ESggCEPn4eR
 UapTxWVY+emqkDGuHzdL1Yq/fMdL/8sA0xnBos+fd39OrvFUVGtMFfqrtlUcyJpDxVs5bzjypC8
 iHznjJwepGd3xVKE=
X-Received: by 2002:a5d:670c:: with SMTP id o12mr9370771wru.103.1570145883062; 
 Thu, 03 Oct 2019 16:38:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxLf2UYSYmJZeZKivO2/5mCjYVxETiLRIHANyAIviHJhdN2IXJjRhNGBsAl8t9BzNkM1in/kg==
X-Received: by 2002:a5d:670c:: with SMTP id o12mr9370764wru.103.1570145882854; 
 Thu, 03 Oct 2019 16:38:02 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id j26sm6242833wrd.2.2019.10.03.16.38.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2019 16:38:02 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2 12/15] target/arm/arm-semi: Factor out
 implementation of SYS_FLEN
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190916141544.17540-1-peter.maydell@linaro.org>
 <20190916141544.17540-13-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <05e204c1-2aa3-7f77-1354-16d9239a901f@redhat.com>
Date: Fri, 4 Oct 2019 01:38:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190916141544.17540-13-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: PnM_V3V-MfG76MRQPiY7Eg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/19 4:15 PM, Peter Maydell wrote:
> Factor out the implementation of SYS_FLEN via the new
> function tables.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   target/arm/arm-semi.c | 32 ++++++++++++++++++++++----------
>   1 file changed, 22 insertions(+), 10 deletions(-)
>=20
> diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
> index b5e1d73eb80..87c911f0187 100644
> --- a/target/arm/arm-semi.c
> +++ b/target/arm/arm-semi.c
> @@ -391,6 +391,7 @@ typedef uint32_t sys_readfn(ARMCPU *cpu, GuestFD *gf,
>   typedef uint32_t sys_isattyfn(ARMCPU *cpu, GuestFD *gf);
>   typedef uint32_t sys_seekfn(ARMCPU *cpu, GuestFD *gf,
>                               target_ulong offset);
> +typedef uint32_t sys_flenfn(ARMCPU *cpu, GuestFD *gf);
>  =20
>   static uint32_t host_closefn(ARMCPU *cpu, GuestFD *gf)
>   {
> @@ -454,6 +455,17 @@ static uint32_t host_seekfn(ARMCPU *cpu, GuestFD *gf=
, target_ulong offset)
>       return 0;
>   }
>  =20
> +static uint32_t host_flenfn(ARMCPU *cpu, GuestFD *gf)
> +{
> +    CPUARMState *env =3D &cpu->env;
> +    struct stat buf;
> +    uint32_t ret =3D set_swi_errno(env, fstat(gf->hostfd, &buf));
> +    if (ret =3D=3D (uint32_t)-1) {
> +        return -1;
> +    }
> +    return buf.st_size;
> +}
> +
>   static uint32_t gdb_closefn(ARMCPU *cpu, GuestFD *gf)
>   {
>       return arm_gdb_syscall(cpu, arm_semi_cb, "close,%x", gf->hostfd);
> @@ -486,12 +498,19 @@ static uint32_t gdb_seekfn(ARMCPU *cpu, GuestFD *gf=
, target_ulong offset)
>                              gf->hostfd, offset);
>   }
>  =20
> +static uint32_t gdb_flenfn(ARMCPU *cpu, GuestFD *gf)
> +{
> +    return arm_gdb_syscall(cpu, arm_semi_flen_cb, "fstat,%x,%x",
> +                           gf->hostfd, arm_flen_buf(cpu));
> +}
> +
>   typedef struct GuestFDFunctions {
>       sys_closefn *closefn;
>       sys_writefn *writefn;
>       sys_readfn *readfn;
>       sys_isattyfn *isattyfn;
>       sys_seekfn *seekfn;
> +    sys_flenfn *flenfn;
>   } GuestFDFunctions;
>  =20
>   static const GuestFDFunctions guestfd_fns[] =3D {
> @@ -501,6 +520,7 @@ static const GuestFDFunctions guestfd_fns[] =3D {
>           .readfn =3D host_readfn,
>           .isattyfn =3D host_isattyfn,
>           .seekfn =3D host_seekfn,
> +        .flenfn =3D host_flenfn,
>       },
>       [GuestFDGDB] =3D {
>           .closefn =3D gdb_closefn,
> @@ -508,6 +528,7 @@ static const GuestFDFunctions guestfd_fns[] =3D {
>           .readfn =3D gdb_readfn,
>           .isattyfn =3D gdb_isattyfn,
>           .seekfn =3D gdb_seekfn,
> +        .flenfn =3D gdb_flenfn,
>       },
>   };
>  =20
> @@ -687,16 +708,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>               return set_swi_errno(env, -1);
>           }
>  =20
> -        if (use_gdb_syscalls()) {
> -            return arm_gdb_syscall(cpu, arm_semi_flen_cb, "fstat,%x,%x",
> -                                   gf->hostfd, arm_flen_buf(cpu));
> -        } else {
> -            struct stat buf;
> -            ret =3D set_swi_errno(env, fstat(gf->hostfd, &buf));
> -            if (ret =3D=3D (uint32_t)-1)
> -                return -1;
> -            return buf.st_size;
> -        }
> +        return guestfd_fns[gf->type].flenfn(cpu, gf);
>       case TARGET_SYS_TMPNAM:
>           qemu_log_mask(LOG_UNIMP, "%s: SYS_TMPNAM not implemented", __fu=
nc__);
>           return -1;
>=20


