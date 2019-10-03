Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A2DC10F14
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 00:20:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43C2120862
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 00:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TRvZHzUe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C2120862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGBKH-0006X1-Fx
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 20:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iGAev-0005IZ-Mi
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:37:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iGAet-0006nP-EQ
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:37:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43353
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iGAer-0006ly-4Z
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1570145835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gk6NROCWpAXErwqeWwHpRsIJUqeAN+w2tOxqkkWL+P4=;
 b=TRvZHzUeos8HXpm2EjUPdm9AnS9WnqAOdy5CpYP+p6iVSZbe+cHIvNtcLA8y2MhARgITIi
 p8PpzcVWfsGPjWZHftCWUNOO5HIx2BfHPKtPy1NTyBxIFgV0hlcVRNbD9oVkIIKh2lgtLP
 iWNkxctQLqKgEq9iQ2BX+BDbLEHxyAI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-WfeMEY08PmOWTZw1GQN5Ag-1; Thu, 03 Oct 2019 19:37:13 -0400
Received: by mail-wr1-f71.google.com with SMTP id w10so1834392wrl.5
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 16:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RjoDOzEi8vQvzx/te10cfe+DFZyreXihMMGG3SIUtsg=;
 b=r50uIlZbJtddX6Fl7TB5uuZvKiEbdQASyzMLvgRWdTjgYg/We8OMS3UrVYoI1DO3xh
 IiuDNka4SNin0zCCbfthEx5QB5AfdJnW/mvclCNN2idnhN1oKKupASq949866OO7B4/6
 cJdgiTt8AqLqRjunJPO1mcWkABt7F8a4f3qnnCNLj/wq3Txv1otM7RXe3b4g1XSMPVfd
 mPpEcf9ofcHwLV36gN7SUwPbn6S5rnt8fEor+R5i2OyR+OfIPKqyQPnRR2YJtdrwK5Vu
 hAx3NGWdqxwolHbXfKWgpA5WzBhKYueHgCVoQw4pF4iHcWUwz3YRSVxAYGapbsROzc0h
 HPGg==
X-Gm-Message-State: APjAAAVtRGt36SxJrGEyTJdMxDfrJbpulpx6Vy+PAac21lRFn04BNMah
 HWSPc+4SlM5xFE9Jiv6M5nEOQe34X5b+Hz7fKGyOmQ9655A83nJZZ3jRDhh+DrEDPd3M9wIhZ22
 mhB8Rby5XyWHteHE=
X-Received: by 2002:a5d:63cb:: with SMTP id c11mr6689901wrw.281.1570145832411; 
 Thu, 03 Oct 2019 16:37:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzYnjAr7PJ5hoW/SmXzkZAGBK7vqHONz2iZWaInFwykqnoWp6Y3Bh1om/ynWJEG+7JeGdN8CA==
X-Received: by 2002:a5d:63cb:: with SMTP id c11mr6689890wrw.281.1570145832170; 
 Thu, 03 Oct 2019 16:37:12 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id c6sm4516543wrm.71.2019.10.03.16.37.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2019 16:37:11 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2 11/15] target/arm/arm-semi: Factor out
 implementation of SYS_SEEK
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190916141544.17540-1-peter.maydell@linaro.org>
 <20190916141544.17540-12-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ffd289df-5298-e159-8ef2-f69cff5ffec4@redhat.com>
Date: Fri, 4 Oct 2019 01:37:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190916141544.17540-12-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: WfeMEY08PmOWTZw1GQN5Ag-1
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
> Factor out the implementation of SYS_SEEK via the new function
> tables.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   target/arm/arm-semi.c | 31 ++++++++++++++++++++++---------
>   1 file changed, 22 insertions(+), 9 deletions(-)
>=20
> diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
> index ecd51338fd3..b5e1d73eb80 100644
> --- a/target/arm/arm-semi.c
> +++ b/target/arm/arm-semi.c
> @@ -389,6 +389,8 @@ typedef uint32_t sys_writefn(ARMCPU *cpu, GuestFD *gf=
,
>   typedef uint32_t sys_readfn(ARMCPU *cpu, GuestFD *gf,
>                               target_ulong buf, uint32_t len);
>   typedef uint32_t sys_isattyfn(ARMCPU *cpu, GuestFD *gf);
> +typedef uint32_t sys_seekfn(ARMCPU *cpu, GuestFD *gf,
> +                            target_ulong offset);
>  =20
>   static uint32_t host_closefn(ARMCPU *cpu, GuestFD *gf)
>   {
> @@ -442,6 +444,16 @@ static uint32_t host_isattyfn(ARMCPU *cpu, GuestFD *=
gf)
>       return isatty(gf->hostfd);
>   }
>  =20
> +static uint32_t host_seekfn(ARMCPU *cpu, GuestFD *gf, target_ulong offse=
t)
> +{
> +    CPUARMState *env =3D &cpu->env;
> +    uint32_t ret =3D set_swi_errno(env, lseek(gf->hostfd, offset, SEEK_S=
ET));
> +    if (ret =3D=3D (uint32_t)-1) {
> +        return -1;
> +    }
> +    return 0;
> +}
> +
>   static uint32_t gdb_closefn(ARMCPU *cpu, GuestFD *gf)
>   {
>       return arm_gdb_syscall(cpu, arm_semi_cb, "close,%x", gf->hostfd);
> @@ -468,11 +480,18 @@ static uint32_t gdb_isattyfn(ARMCPU *cpu, GuestFD *=
gf)
>       return arm_gdb_syscall(cpu, arm_semi_cb, "isatty,%x", gf->hostfd);
>   }
>  =20
> +static uint32_t gdb_seekfn(ARMCPU *cpu, GuestFD *gf, target_ulong offset=
)
> +{
> +    return arm_gdb_syscall(cpu, arm_semi_cb, "lseek,%x,%x,0",
> +                           gf->hostfd, offset);
> +}
> +
>   typedef struct GuestFDFunctions {
>       sys_closefn *closefn;
>       sys_writefn *writefn;
>       sys_readfn *readfn;
>       sys_isattyfn *isattyfn;
> +    sys_seekfn *seekfn;
>   } GuestFDFunctions;
>  =20
>   static const GuestFDFunctions guestfd_fns[] =3D {
> @@ -481,12 +500,14 @@ static const GuestFDFunctions guestfd_fns[] =3D {
>           .writefn =3D host_writefn,
>           .readfn =3D host_readfn,
>           .isattyfn =3D host_isattyfn,
> +        .seekfn =3D host_seekfn,
>       },
>       [GuestFDGDB] =3D {
>           .closefn =3D gdb_closefn,
>           .writefn =3D gdb_writefn,
>           .readfn =3D gdb_readfn,
>           .isattyfn =3D gdb_isattyfn,
> +        .seekfn =3D gdb_seekfn,
>       },
>   };
>  =20
> @@ -656,15 +677,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>               return set_swi_errno(env, -1);
>           }
>  =20
> -        if (use_gdb_syscalls()) {
> -            return arm_gdb_syscall(cpu, arm_semi_cb, "lseek,%x,%x,0",
> -                                   gf->hostfd, arg1);
> -        } else {
> -            ret =3D set_swi_errno(env, lseek(gf->hostfd, arg1, SEEK_SET)=
);
> -            if (ret =3D=3D (uint32_t)-1)
> -              return -1;
> -            return 0;
> -        }
> +        return guestfd_fns[gf->type].seekfn(cpu, gf, arg1);
>       case TARGET_SYS_FLEN:
>           GET_ARG(0);
>  =20
>=20


