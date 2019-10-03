Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62603C10F14
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 00:10:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 286F22086A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 00:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BzfuI4T4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286F22086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGBB7-0000ab-43
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 20:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iGAa1-00035e-9r
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:32:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iGAZz-0002mb-GN
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:32:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40738
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iGAZy-0002hL-7B
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1570145531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X++9C+o63TLz2yiBE4eVu8eFHPYuFJf499i6Z8ZrnAE=;
 b=BzfuI4T4iQoLrEGKsaG43mlTcATK6auN7LgZZinch8cgD9mG8p76GCvZJh9QiuipgevbXY
 gpE3t8zJMXqpMPPox3Q2ULJJYG2UNjiiJXWPLEQvq+TfM8ewKyYvrXU6gRm+p6TElKA1Yx
 83szwSL+k/hd/clpvmxQy8D3laibcTI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-RlGk3HSWMUGLGefc7ellXA-1; Thu, 03 Oct 2019 19:32:08 -0400
Received: by mail-wr1-f69.google.com with SMTP id t11so1816835wro.10
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 16:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6fg+tL8hdMuSlCATnh5vXBFe8nhdX3zEsZie5KLf89k=;
 b=GGHa9MRX5U8dKkCtJHtpaT1Lmok3j3R8o6Z0Ljge6QYDzMxKzvyn+kIezcOEB1UjIz
 uvVPuwFuUullcHh7RmKWNiK00IF+SS7PCdl2kL8Kz85BFUhyiiT1LxMdojrnUngNhXYA
 bAXlZ45dWODQtBkbHdgSbbQ7ggFPGNrjqfPjkw00iYnzGhwUmlgFby2df6aqpl0cPizm
 gZi91rdwa/+fG1EBeDxUUzygKtEXT2IybzsJ1toq3da9ErvlqN2p7GuPGKpu8PvLmpnu
 4YIChVU17XsrgKRnSHn+iVm1G0KjVxQs7H04HqoEcx+8qYytQVufhaWID402s3iFsnCG
 fHDA==
X-Gm-Message-State: APjAAAVrhtHxiJpuIkce131QpmyrHlZH+VySuRW34Vo6yommtMOEUMYx
 xri6G5OKVQN7UHZTdlwt3GC9gTyaVyrP2XdpM6nBgVpTQejthcismjYvOUA/DyzSBfb9vVuzsrB
 RuerH7s7v7WhLJrQ=
X-Received: by 2002:a5d:51d1:: with SMTP id n17mr415034wrv.85.1570145527442;
 Thu, 03 Oct 2019 16:32:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyV164HHUw3+MnqRy9NnCtezStk4ZWBQxrbwl/a+sfec4RrTv4r+821tPgL+sApXCs8V9+pnw==
X-Received: by 2002:a5d:51d1:: with SMTP id n17mr415024wrv.85.1570145527218;
 Thu, 03 Oct 2019 16:32:07 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id t123sm6570271wma.40.2019.10.03.16.32.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2019 16:32:06 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2 07/15] target/arm/arm-semi: Factor out
 implementation of SYS_CLOSE
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190916141544.17540-1-peter.maydell@linaro.org>
 <20190916141544.17540-8-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <84350edd-f5e7-cf9a-5cfe-c5caf603f492@redhat.com>
Date: Fri, 4 Oct 2019 01:32:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190916141544.17540-8-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: RlGk3HSWMUGLGefc7ellXA-1
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
> Currently for the semihosting calls which take a file descriptor
> (SYS_CLOSE, SYS_WRITE, SYS_READ, SYS_ISTTY, SYS_SEEK, SYS_FLEN)
> we have effectively two implementations, one for real host files
> and one for when we indirect via the gdbstub. We want to add a
> third one to deal with the magic :semihosting-features file.
>=20
> Instead of having a three-way if statement in each of these
> cases, factor out the implementation of the calls to separate
> functions which we dispatch to via function pointers selected
> via the GuestFDType for the guest fd.
>=20
> In this commit, we set up the framework for the dispatch,
> and convert the SYS_CLOSE call to use it.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   target/arm/arm-semi.c | 44 ++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 37 insertions(+), 7 deletions(-)
>=20
> diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
> index 02cd673d47d..e5f1e2aaaf2 100644
> --- a/target/arm/arm-semi.c
> +++ b/target/arm/arm-semi.c
> @@ -109,6 +109,7 @@ static int open_modeflags[12] =3D {
>   typedef enum GuestFDType {
>       GuestFDUnused =3D 0,
>       GuestFDHost =3D 1,
> +    GuestFDGDB =3D 2,
>   } GuestFDType;
>  =20
>   /*
> @@ -172,14 +173,14 @@ static GuestFD *do_get_guestfd(int guestfd)
>   /*
>    * Associate the specified guest fd (which must have been
>    * allocated via alloc_fd() and not previously used) with
> - * the specified host fd.
> + * the specified host/gdb fd.
>    */
>   static void associate_guestfd(int guestfd, int hostfd)
>   {
>       GuestFD *gf =3D do_get_guestfd(guestfd);
>  =20
>       assert(gf);
> -    gf->type =3D GuestFDHost;
> +    gf->type =3D use_gdb_syscalls() ? GuestFDGDB : GuestFDHost;
>       gf->hostfd =3D hostfd;
>   }
>  =20
> @@ -376,6 +377,39 @@ static target_ulong arm_gdb_syscall(ARMCPU *cpu, gdb=
_syscall_complete_cb cb,
>       return is_a64(env) ? env->xregs[0] : env->regs[0];
>   }
>  =20
> +/*
> + * Types for functions implementing various semihosting calls
> + * for specific types of guest file descriptor. These must all
> + * do the work and return the required return value for the guest,
> + * setting the guest errno if appropriate.
> + */
> +typedef uint32_t sys_closefn(ARMCPU *cpu, GuestFD *gf);
> +
> +static uint32_t host_closefn(ARMCPU *cpu, GuestFD *gf)
> +{
> +    CPUARMState *env =3D &cpu->env;
> +
> +    return set_swi_errno(env, close(gf->hostfd));
> +}
> +
> +static uint32_t gdb_closefn(ARMCPU *cpu, GuestFD *gf)
> +{
> +    return arm_gdb_syscall(cpu, arm_semi_cb, "close,%x", gf->hostfd);
> +}
> +
> +typedef struct GuestFDFunctions {
> +    sys_closefn *closefn;
> +} GuestFDFunctions;
> +
> +static const GuestFDFunctions guestfd_fns[] =3D {
> +    [GuestFDHost] =3D {
> +        .closefn =3D host_closefn,
> +    },
> +    [GuestFDGDB] =3D {
> +        .closefn =3D gdb_closefn,
> +    },
> +};
> +
>   /* Read the input value from the argument block; fail the semihosting
>    * call if the memory read fails.
>    */
> @@ -485,11 +519,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>               return set_swi_errno(env, -1);
>           }
>  =20
> -        if (use_gdb_syscalls()) {
> -            ret =3D arm_gdb_syscall(cpu, arm_semi_cb, "close,%x", gf->ho=
stfd);
> -        } else {
> -            ret =3D set_swi_errno(env, close(gf->hostfd));
> -        }
> +        ret =3D guestfd_fns[gf->type].closefn(cpu, gf);
>           dealloc_guestfd(arg0);
>           return ret;
>       case TARGET_SYS_WRITEC:
>=20


