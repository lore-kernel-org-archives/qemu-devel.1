Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A26C32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 23:59:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2494520842
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 23:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GrNC553h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2494520842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGB0g-0003au-Ff
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 19:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iGAc5-00048N-Px
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:34:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iGAby-0004KV-4g
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:34:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40036
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iGAbP-0003vj-Uf
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1570145622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ncD+GIq+W9TQMVOQtOXuiMziZEZ6DuqaNnsravIvYNs=;
 b=GrNC553hlEv8QWR2bnLyCEGDXNciw0JGbm0ID/PvpCQiQ0fPNIH3/WGoUfCCJDAyfIRMrd
 cfm+q4EhrvBL6qolMuQX4r+ce4hHr87kBnMzbM1ITSVKPmHCrKNtlouX5sgBroyCkQHzMk
 9uOnt//mcHvUGp0beCAb4ioEesu2Mus=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-634MWuf5PR6yXpCUYe51Zg-1; Thu, 03 Oct 2019 19:33:36 -0400
Received: by mail-wr1-f72.google.com with SMTP id m14so1814448wru.17
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 16:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2OXZied8K+dE+da8q1xBCh960/6kRu+OEosH48qhxHc=;
 b=fNuQ2LTAGSCsPJ4Hdf1OjL2IFPq+fJRsBfA6DCCcESogPpvf3w8Wm3I3TrvslwVza3
 C7phNkyKSrPVnQDs3ARtQHWhEgdlHLMoQsg3DkHDtxOAJHXAcMl88FGtd/Y0icX2XetY
 fhlb7At1ZFPF2zOhnLb+VSCJQMwJ34oB02FiYZ7vEDzXrLE37/9WBwF/aB3aC2BiNg0w
 EmkmcF8XrRVFmXMsWsPi4V1cMcHUUk/U2zMhPmUAhypfPbdtK61SrJesdLL56FpG4YfZ
 IdXUyp1AATmeHBWT3fuNC9sNE03Y+yLxeK44r0XOcFyG8Y5NZcpySAawEaMB/tc1ErBC
 X51A==
X-Gm-Message-State: APjAAAUE76IEHe7/YTXeTlfiYyPwkhzHklRf7RjeYt2ZGilWeFVbX5/p
 SRC9WN6Y2VbebtoeZmhFdYrAHVYWFlYAUcdXoknZD2ZoyjuIc036NuYj/JwXQBpk/NcgjWjNelm
 XpJQAln9oqUtixr0=
X-Received: by 2002:a7b:c35a:: with SMTP id l26mr8864688wmj.81.1570145615650; 
 Thu, 03 Oct 2019 16:33:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwhyvZnn3Y4sK991iS9YYd4ha8RYjss5QkQYeGxsCWL2f6dzYKf20uwwMuJ2mKUyQZ50whu2A==
X-Received: by 2002:a7b:c35a:: with SMTP id l26mr8864680wmj.81.1570145615407; 
 Thu, 03 Oct 2019 16:33:35 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id a3sm6652758wmc.3.2019.10.03.16.33.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2019 16:33:34 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2 08/15] target/arm/arm-semi: Factor out
 implementation of SYS_WRITE
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190916141544.17540-1-peter.maydell@linaro.org>
 <20190916141544.17540-9-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <674d0aff-71c7-f613-2a62-3fbaffda1da1@redhat.com>
Date: Fri, 4 Oct 2019 01:33:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190916141544.17540-9-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: 634MWuf5PR6yXpCUYe51Zg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/19 4:15 PM, Peter Maydell wrote:
> Factor out the implementation of SYS_WRITE via the
> new function tables.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   target/arm/arm-semi.c | 51 ++++++++++++++++++++++++++++---------------
>   1 file changed, 33 insertions(+), 18 deletions(-)
>=20
> diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
> index e5f1e2aaaf2..c21cbb97bc1 100644
> --- a/target/arm/arm-semi.c
> +++ b/target/arm/arm-semi.c
> @@ -384,6 +384,8 @@ static target_ulong arm_gdb_syscall(ARMCPU *cpu, gdb_=
syscall_complete_cb cb,
>    * setting the guest errno if appropriate.
>    */
>   typedef uint32_t sys_closefn(ARMCPU *cpu, GuestFD *gf);
> +typedef uint32_t sys_writefn(ARMCPU *cpu, GuestFD *gf,
> +                             target_ulong buf, uint32_t len);
>  =20
>   static uint32_t host_closefn(ARMCPU *cpu, GuestFD *gf)
>   {
> @@ -392,21 +394,51 @@ static uint32_t host_closefn(ARMCPU *cpu, GuestFD *=
gf)
>       return set_swi_errno(env, close(gf->hostfd));
>   }
>  =20
> +static uint32_t host_writefn(ARMCPU *cpu, GuestFD *gf,
> +                             target_ulong buf, uint32_t len)
> +{
> +    uint32_t ret;
> +    CPUARMState *env =3D &cpu->env;
> +    char *s =3D lock_user(VERIFY_READ, buf, len, 1);
> +    if (!s) {
> +        /* Return bytes not written on error */
> +        return len;
> +    }
> +    ret =3D set_swi_errno(env, write(gf->hostfd, s, len));
> +    unlock_user(s, buf, 0);
> +    if (ret =3D=3D (uint32_t)-1) {
> +        ret =3D 0;
> +    }
> +    /* Return bytes not written */
> +    return len - ret;
> +}
> +
>   static uint32_t gdb_closefn(ARMCPU *cpu, GuestFD *gf)
>   {
>       return arm_gdb_syscall(cpu, arm_semi_cb, "close,%x", gf->hostfd);
>   }
>  =20
> +static uint32_t gdb_writefn(ARMCPU *cpu, GuestFD *gf,
> +                            target_ulong buf, uint32_t len)
> +{
> +    arm_semi_syscall_len =3D len;
> +    return arm_gdb_syscall(cpu, arm_semi_cb, "write,%x,%x,%x",
> +                           gf->hostfd, buf, len);
> +}
> +
>   typedef struct GuestFDFunctions {
>       sys_closefn *closefn;
> +    sys_writefn *writefn;
>   } GuestFDFunctions;
>  =20
>   static const GuestFDFunctions guestfd_fns[] =3D {
>       [GuestFDHost] =3D {
>           .closefn =3D host_closefn,
> +        .writefn =3D host_writefn,
>       },
>       [GuestFDGDB] =3D {
>           .closefn =3D gdb_closefn,
> +        .writefn =3D gdb_writefn,
>       },
>   };
>  =20
> @@ -539,24 +571,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>               return set_swi_errno(env, -1);
>           }
>  =20
> -        if (use_gdb_syscalls()) {
> -            arm_semi_syscall_len =3D len;
> -            return arm_gdb_syscall(cpu, arm_semi_cb, "write,%x,%x,%x",
> -                                   gf->hostfd, arg1, len);
> -        } else {
> -            s =3D lock_user(VERIFY_READ, arg1, len, 1);
> -            if (!s) {
> -                /* Return bytes not written on error */
> -                return len;
> -            }
> -            ret =3D set_swi_errno(env, write(gf->hostfd, s, len));
> -            unlock_user(s, arg1, 0);
> -            if (ret =3D=3D (uint32_t)-1) {
> -                ret =3D 0;
> -            }
> -            /* Return bytes not written */
> -            return len - ret;
> -        }
> +        return guestfd_fns[gf->type].writefn(cpu, gf, arg1, len);
>       case TARGET_SYS_READ:
>           GET_ARG(0);
>           GET_ARG(1);
>=20


