Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E6DC10F14
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 00:09:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 670E72086A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 00:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKwMt0jj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670E72086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGBAL-0008MY-UF
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 20:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iGAcz-0004LT-0H
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iGAct-0004zv-RB
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:35:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20485
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iGAct-0004uz-M6
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1570145711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sOvhPRusDmCI4J7IVheey5VuuQLAXmPPq1tVH797yok=;
 b=dKwMt0jjaW5z0FapOfvrjAAenlqfK50/3c0ALa7dKdLcuA9HU2PsOUkAFyyfA9WVuSLVXb
 KzwEnl3HZp01ncSk7xePYK8kk/gMvM8WggtC3JU1JMigzU6EiXAnQpjrn5jhTrYu6XNtTp
 c2XN/GIyqtKaNQ0YaN4jyrCr+TIIDRM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-AhIWZPwwO82IzOeLQV2xOg-1; Thu, 03 Oct 2019 19:35:09 -0400
Received: by mail-wm1-f72.google.com with SMTP id j125so1781239wmj.6
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 16:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vmgiPbey/LFCJ/olGtfJQvC5DWR8VyYkW2zYHXYykko=;
 b=Ea1C7y77CxXc4maSLDDKwqNZS70FIKuSmPaTsaWtVVVuvOwVPBPW+HmOT1qd0kajFQ
 cIbZ6VMuiQ3ySG64QIHqoQvKAfIgdEO2Q0m1X+/xeqaLorJY3aHNHW7v3l0Vvk4AukhV
 YpjFk1msLcG5X2h3tiZ80STU40Pvf2dFdJ3iwooAv+4vN7qzBtFkhfsT0hIq0C6LWZCw
 ECU9q6aDZ+QMg+h5BihtN5BVDpjEbAZn/GSxgzNXjMgNZJ9PvT1s4mc8LVb/5kHTgc+T
 Mk4QicBy5pNgNUTclIMaic+tubAMmT6NGXGcdTdj5+4hUKJQe0XKsBbigWdPEXWai1Eh
 KDCQ==
X-Gm-Message-State: APjAAAWEfmhGjLZmjSa6Z7XcvyDu0eyXC2kHvIEfVwmDuw5DZbcTqqGT
 BSCEnteTzG9H97iIP5s962xJLTk/OqYFRMSxEahYf0MqTt4HsCIcxxzyPxJfsUEF4WDFQvhh/yf
 RpzrKn93+cLMZZWg=
X-Received: by 2002:adf:e951:: with SMTP id m17mr8902598wrn.154.1570145708068; 
 Thu, 03 Oct 2019 16:35:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzTqDx/iHP62IWUmP6+NWsK+6exUcLupPID4zV/OPX+ALrfKvEmsx+QSInsbedQy1lD/5XMow==
X-Received: by 2002:adf:e951:: with SMTP id m17mr8902528wrn.154.1570145706949; 
 Thu, 03 Oct 2019 16:35:06 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id 59sm3997667wrc.23.2019.10.03.16.35.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2019 16:35:06 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2 09/15] target/arm/arm-semi: Factor out
 implementation of SYS_READ
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190916141544.17540-1-peter.maydell@linaro.org>
 <20190916141544.17540-10-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9131951e-06ad-059e-c68b-18ea6b9b71b4@redhat.com>
Date: Fri, 4 Oct 2019 01:35:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190916141544.17540-10-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: AhIWZPwwO82IzOeLQV2xOg-1
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
> Factor out the implementation of SYS_READ via the
> new function tables.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   target/arm/arm-semi.c | 55 +++++++++++++++++++++++++++----------------
>   1 file changed, 35 insertions(+), 20 deletions(-)
>=20
> diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
> index c21cbb97bc1..958083a105c 100644
> --- a/target/arm/arm-semi.c
> +++ b/target/arm/arm-semi.c
> @@ -386,6 +386,8 @@ static target_ulong arm_gdb_syscall(ARMCPU *cpu, gdb_=
syscall_complete_cb cb,
>   typedef uint32_t sys_closefn(ARMCPU *cpu, GuestFD *gf);
>   typedef uint32_t sys_writefn(ARMCPU *cpu, GuestFD *gf,
>                                target_ulong buf, uint32_t len);
> +typedef uint32_t sys_readfn(ARMCPU *cpu, GuestFD *gf,
> +                            target_ulong buf, uint32_t len);
>  =20
>   static uint32_t host_closefn(ARMCPU *cpu, GuestFD *gf)
>   {
> @@ -413,6 +415,27 @@ static uint32_t host_writefn(ARMCPU *cpu, GuestFD *g=
f,
>       return len - ret;
>   }
>  =20
> +static uint32_t host_readfn(ARMCPU *cpu, GuestFD *gf,
> +                            target_ulong buf, uint32_t len)
> +{
> +    uint32_t ret;
> +    CPUARMState *env =3D &cpu->env;
> +    char *s =3D lock_user(VERIFY_WRITE, buf, len, 0);
> +    if (!s) {
> +        /* return bytes not read */
> +        return len;
> +    }
> +    do {
> +        ret =3D set_swi_errno(env, read(gf->hostfd, s, len));
> +    } while (ret =3D=3D -1 && errno =3D=3D EINTR);
> +    unlock_user(s, buf, len);
> +    if (ret =3D=3D (uint32_t)-1) {
> +        ret =3D 0;
> +    }
> +    /* Return bytes not read */
> +    return len - ret;
> +}
> +
>   static uint32_t gdb_closefn(ARMCPU *cpu, GuestFD *gf)
>   {
>       return arm_gdb_syscall(cpu, arm_semi_cb, "close,%x", gf->hostfd);
> @@ -426,19 +449,30 @@ static uint32_t gdb_writefn(ARMCPU *cpu, GuestFD *g=
f,
>                              gf->hostfd, buf, len);
>   }
>  =20
> +static uint32_t gdb_readfn(ARMCPU *cpu, GuestFD *gf,
> +                           target_ulong buf, uint32_t len)
> +{
> +    arm_semi_syscall_len =3D len;
> +    return arm_gdb_syscall(cpu, arm_semi_cb, "read,%x,%x,%x",
> +                           gf->hostfd, buf, len);
> +}
> +
>   typedef struct GuestFDFunctions {
>       sys_closefn *closefn;
>       sys_writefn *writefn;
> +    sys_readfn *readfn;
>   } GuestFDFunctions;
>  =20
>   static const GuestFDFunctions guestfd_fns[] =3D {
>       [GuestFDHost] =3D {
>           .closefn =3D host_closefn,
>           .writefn =3D host_writefn,
> +        .readfn =3D host_readfn,
>       },
>       [GuestFDGDB] =3D {
>           .closefn =3D gdb_closefn,
>           .writefn =3D gdb_writefn,
> +        .readfn =3D gdb_readfn,
>       },
>   };
>  =20
> @@ -584,26 +618,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>               return set_swi_errno(env, -1);
>           }
>  =20
> -        if (use_gdb_syscalls()) {
> -            arm_semi_syscall_len =3D len;
> -            return arm_gdb_syscall(cpu, arm_semi_cb, "read,%x,%x,%x",
> -                                   gf->hostfd, arg1, len);
> -        } else {
> -            s =3D lock_user(VERIFY_WRITE, arg1, len, 0);
> -            if (!s) {
> -                /* return bytes not read */
> -                return len;
> -            }
> -            do {
> -                ret =3D set_swi_errno(env, read(gf->hostfd, s, len));
> -            } while (ret =3D=3D -1 && errno =3D=3D EINTR);
> -            unlock_user(s, arg1, len);
> -            if (ret =3D=3D (uint32_t)-1) {
> -                ret =3D 0;
> -            }
> -            /* Return bytes not read */
> -            return len - ret;
> -        }
> +        return guestfd_fns[gf->type].readfn(cpu, gf, arg1, len);
>       case TARGET_SYS_READC:
>           qemu_log_mask(LOG_UNIMP, "%s: SYS_READC not implemented", __fun=
c__);
>           return 0;
>=20


