Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CB3C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:57:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0A9620663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ss8fb6mG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A9620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE8yW-0007WU-U9
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 05:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jE8xd-0006Ma-QY
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:56:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jE8xc-0005xd-FN
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:56:33 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:34643)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jE8xc-0005sF-At
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584438991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LKb9voVP0DcRntiJe2qk76Bv9LmVh1K46wznR3c2LOY=;
 b=Ss8fb6mG3R+FBNTGxJXn3Fk9qd+9rueCxbKAnCI1naWpLltN7AQekRRUUczMPtZFmPP+Q9
 IvnRsthAus3anwq3+l4FmoWjXJJvYQdKHs9dxaPF6h144jXHe0bzhDas4nWrlC71J60cl4
 MYq2C0o3CJFCpTojXZiB5SfldUbEjcE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-O6AHQzM4P7WuMmEVE5n0nQ-1; Tue, 17 Mar 2020 05:56:28 -0400
X-MC-Unique: O6AHQzM4P7WuMmEVE5n0nQ-1
Received: by mail-wm1-f70.google.com with SMTP id n25so5528186wmi.5
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 02:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ULRZbuCwsnyJRRqZMeMEz/jzykrdAzXvpLbJ6qxv3wY=;
 b=j3hWeJ+hrUmihBKiRplcLpwojUDFf+ZobzYdqBgtjw0LQSKgbIQWJ2KmruVTCY+u7a
 VHXgtY/eKKkap6RAQrKxmRiSW5Ib9h27e8a51/gauSagJqyvxf4YBPY1AdqxVj75skRL
 MgowVOct0UVXrr0Ix7V03brkLRwtOK+G52kFD3j/Auw3Lh/on4sRXUnh+ZIsRfPHiPiM
 04NNqDbYzA5OTJycS7ULvAMVc1DkxYFPFXl3MnlKSHMJMdAWrJLAms6A4hHrHlBHQ2rD
 i5e0pE7DwhIN+DPMSPOO701wMmP0TpAPhRpQ2zg3/GDLkEHMYbSajsE7a6MG7kOaF3Dp
 EGPQ==
X-Gm-Message-State: ANhLgQ3jyxCyqOQ30myrDIFscLouzp6ToxGjlY9QEw4A1IteO2hsKSbV
 2CTqkTFVcMDfl0+BeKOCdfHL82+AiZBoV1FrKRCi/VMLMXg5BR0WEseF8041bc3xWEy6LL9hCJh
 p4ao2+AFu6ANwzC8=
X-Received: by 2002:a1c:23d5:: with SMTP id j204mr4651686wmj.59.1584438987450; 
 Tue, 17 Mar 2020 02:56:27 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsick/AaJ59hYzl2j0L4ccWTV4FeDghE+IJhpnzcbkiqWTZGJYVEdLJhu48LbNrsXfGOlW1rQ==
X-Received: by 2002:a1c:23d5:: with SMTP id j204mr4651665wmj.59.1584438987221; 
 Tue, 17 Mar 2020 02:56:27 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id w19sm3242788wmi.0.2020.03.17.02.56.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2020 02:56:26 -0700 (PDT)
Subject: Re: [PATCH v1 19/28] target/arm: don't bother with id_aa64pfr0_read
 for USER_ONLY
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200316172155.971-1-alex.bennee@linaro.org>
 <20200316172155.971-20-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c34eed7d-ee17-b06a-68e4-fecceab4b216@redhat.com>
Date: Tue, 17 Mar 2020 10:56:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316172155.971-20-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 6:21 PM, Alex Benn=C3=A9e wrote:
> For system emulation we need to check the state of the GIC before we
> report the value. However this isn't relevant to exporting of the
> value to linux-user and indeed breaks the exported value as set by
> modify_arm_cp_regs.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>=20
> ---
> v2
>    - extend the ifdef and make type CONST with no accessfn
> ---
>   target/arm/helper.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 7e560ea7db6..d2ec2c53510 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6697,6 +6697,7 @@ static uint64_t id_pfr1_read(CPUARMState *env, cons=
t ARMCPRegInfo *ri)
>       return pfr1;
>   }
>  =20
> +#ifndef CONFIG_USER_ONLY
>   static uint64_t id_aa64pfr0_read(CPUARMState *env, const ARMCPRegInfo *=
ri)
>   {
>       ARMCPU *cpu =3D env_archcpu(env);
> @@ -6707,6 +6708,7 @@ static uint64_t id_aa64pfr0_read(CPUARMState *env, =
const ARMCPRegInfo *ri)
>       }
>       return pfr0;
>   }
> +#endif
>  =20
>   /* Shared logic between LORID and the rest of the LOR* registers.
>    * Secure state has already been delt with.
> @@ -7280,16 +7282,24 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>            * define new registers here.
>            */
>           ARMCPRegInfo v8_idregs[] =3D {
> -            /* ID_AA64PFR0_EL1 is not a plain ARM_CP_CONST because we do=
n't
> -             * know the right value for the GIC field until after we
> -             * define these regs.
> +            /*
> +             * ID_AA64PFR0_EL1 is not a plain ARM_CP_CONST in system
> +             * emulation because we don't know the right value for the
> +             * GIC field until after we define these regs.
>                */
>               { .name =3D "ID_AA64PFR0_EL1", .state =3D ARM_CP_STATE_AA64=
,
>                 .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0, .crm =3D 4, .opc2 =
=3D 0,
> -              .access =3D PL1_R, .type =3D ARM_CP_NO_RAW,
> +              .access =3D PL1_R,
> +#ifdef CONFIG_USER_ONLY
> +              .type =3D ARM_CP_CONST,
> +              .resetvalue =3D cpu->isar.id_aa64pfr0
> +#else
> +              .type =3D ARM_CP_NO_RAW,
>                 .accessfn =3D access_aa64_tid3,
>                 .readfn =3D id_aa64pfr0_read,
> -              .writefn =3D arm_cp_write_ignore },
> +              .writefn =3D arm_cp_write_ignore

I guess this is the implementation of what Peter described here:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg689388.html

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +#endif
> +            },
>               { .name =3D "ID_AA64PFR1_EL1", .state =3D ARM_CP_STATE_AA64=
,
>                 .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0, .crm =3D 4, .opc2 =
=3D 1,
>                 .access =3D PL1_R, .type =3D ARM_CP_CONST,
>=20


