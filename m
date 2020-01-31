Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35214C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 00:24:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B226220661
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 00:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cNx7yB6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B226220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixK6J-0005yS-LY
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 19:23:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36714)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixK5e-0005KK-9I
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 19:23:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixK5d-0004gI-2S
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 19:23:18 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38093
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixK5c-0004fD-VK
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 19:23:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580430195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rvM5r+BgVvgMAZOVi+gBzXAAQkBAaLPP+OCAGN//Jo4=;
 b=cNx7yB6xQZEazi1tQ2q3YyGgliILG+CJQq/vrvIapkTIcJ0L9YJvw+U8UCIw5vA0jYNhWq
 /Dt6vYBLNFJ5bzpOHQa/qn8TLobpv3eW6VHOWbII4/CUEd24FH876JWtzNsSs7DzqkL2Ei
 MRYZlxtKqHLzYeK6gr0NDvEzFtyEkkQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-3bVuelC7P9OrL_jo8ZeR3g-1; Thu, 30 Jan 2020 19:23:13 -0500
Received: by mail-wm1-f72.google.com with SMTP id y24so1389310wmj.8
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 16:23:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FB9VzJKjO1Yhj/auCqoDgpsaOJlVz56zwljL/Lk96BU=;
 b=YSszj5i5slWJu6yoZSuWYgR7LxCNzVdh4WUFDFiKdAf/rwuy+SD3gdoXdFpvQPtfi1
 MdxPLsYnOTm+W0kS+rgoE5FWJQTjHntcqyr+oJ1G9dq/s1G+NeS1ulIuh9M6heyBLVHd
 1NVjqu3oT2ZHZ0Cx+llIzt6gonolBvcc3kwRST9QqAIHJ0nYJXvgpjo/Y2oW3yssgzbK
 dJBPD+h/1zcNPQJeKuRORA4RSgmUBOvkYkn2BYU/hdWODqzzndok3YChq2ngoN1B18be
 yHP8Kzms9eNY3zB0tqh9J20QLff7Y9vKafygec7HGLhOaf/E9L2iIlppjH3vhXAyWNyB
 wTNQ==
X-Gm-Message-State: APjAAAXceJxIRlXT5PNFP/F4iGicWfDSiY+HAesmh2KbkxY7yjmC4SUi
 w1yZYGqMx8c7SVRHoutGT50q9XZ1pE/nz5OJEfzw0+jxF3MNQVSRH/A9CC6RUaRw5Z6d3IINx19
 EVKuB14wxyw8k574=
X-Received: by 2002:a7b:cf01:: with SMTP id l1mr8179347wmg.86.1580430192548;
 Thu, 30 Jan 2020 16:23:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqwwudNFkU1carj48yAoqbUK5pnI32BWH7wq1Pt3Y00TThXBbLT+bKTvdsPd7Wne1IACBydCTA==
X-Received: by 2002:a7b:cf01:: with SMTP id l1mr8179325wmg.86.1580430192301;
 Thu, 30 Jan 2020 16:23:12 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id r14sm6832977wrj.26.2020.01.30.16.23.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 16:23:11 -0800 (PST)
Subject: Re: [PATCH rc4 20/29] target/avr: Register AVR support with the rest
 of QEMU
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1580428993-4767-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580428993-4767-21-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2bf92b9e-7a1f-57a1-d9a3-d0afb6990e70@redhat.com>
Date: Fri, 31 Jan 2020 01:23:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1580428993-4767-21-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
X-MC-Unique: 3bVuelC7P9OrL_jo8ZeR3g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Michael Rolnik <mrolnik@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/31/20 1:03 AM, Aleksandar Markovic wrote:
> From: Michael Rolnik <mrolnik@gmail.com>
>=20
> Add AVR related definitions into QEMU.
>=20
> [AM: Remove word 'Atmel' from filenames and all elements of code]
> Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>=20
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> ---
>   arch_init.c                |  2 ++
>   include/disas/dis-asm.h    | 19 +++++++++++++++++++
>   include/sysemu/arch_init.h |  1 +
>   qapi/machine.json          |  3 ++-
>   4 files changed, 24 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch_init.c b/arch_init.c
> index 705d0b9..6a74116 100644
> --- a/arch_init.c
> +++ b/arch_init.c
> @@ -89,6 +89,8 @@ int graphic_depth =3D 32;
>   #define QEMU_ARCH QEMU_ARCH_UNICORE32
>   #elif defined(TARGET_XTENSA)
>   #define QEMU_ARCH QEMU_ARCH_XTENSA
> +#elif defined(TARGET_AVR)
> +#define QEMU_ARCH QEMU_ARCH_AVR
>   #endif
>  =20
>   const uint32_t arch_type =3D QEMU_ARCH;
> diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
> index f87f468..a36e658 100644
> --- a/include/disas/dis-asm.h
> +++ b/include/disas/dis-asm.h
> @@ -211,6 +211,25 @@ enum bfd_architecture
>   #define bfd_mach_m32r          0  /* backwards compatibility */
>     bfd_arch_mn10200,    /* Matsushita MN10200 */
>     bfd_arch_mn10300,    /* Matsushita MN10300 */
> +  bfd_arch_avr,        /* AVR microcontrollers */
> +#define bfd_mach_avr1       1
> +#define bfd_mach_avr2       2
> +#define bfd_mach_avr25      25
> +#define bfd_mach_avr3       3
> +#define bfd_mach_avr31      31
> +#define bfd_mach_avr35      35
> +#define bfd_mach_avr4       4
> +#define bfd_mach_avr5       5
> +#define bfd_mach_avr51      51
> +#define bfd_mach_avr6       6
> +#define bfd_mach_avrtiny    100
> +#define bfd_mach_avrxmega1  101
> +#define bfd_mach_avrxmega2  102
> +#define bfd_mach_avrxmega3  103
> +#define bfd_mach_avrxmega4  104
> +#define bfd_mach_avrxmega5  105
> +#define bfd_mach_avrxmega6  106
> +#define bfd_mach_avrxmega7  107

I think the changes in include/disas/dis-asm.h should go in patch #6=20
"target/avr: Add defintions of AVR core types" where the definitions are=20
used:

   const char *avr_flags_to_cpu_type(uint32_t flags, const char=20
*def_cpu_type)
   {
       switch (flags & EF_AVR_MACH) {
       case bfd_mach_avr1:
           return AVR_CPU_TYPE_NAME("avr1");

>     bfd_arch_cris,       /* Axis CRIS */
>   #define bfd_mach_cris_v0_v10   255
>   #define bfd_mach_cris_v32      32
> diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
> index 62c6fe4..893df26 100644
> --- a/include/sysemu/arch_init.h
> +++ b/include/sysemu/arch_init.h
> @@ -24,6 +24,7 @@ enum {
>       QEMU_ARCH_NIOS2 =3D (1 << 17),
>       QEMU_ARCH_HPPA =3D (1 << 18),
>       QEMU_ARCH_RISCV =3D (1 << 19),
> +    QEMU_ARCH_AVR =3D (1 << 20),
>   };
>  =20
>   extern const uint32_t arch_type;
> diff --git a/qapi/machine.json b/qapi/machine.json
> index b3d30bc..f2dc385 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -21,11 +21,12 @@
>   #        is true even for "qemu-system-x86_64".
>   #
>   # ppcemb: dropped in 3.1
> +# avr: since 5.0
>   #
>   # Since: 3.0
>   ##
>   { 'enum' : 'SysEmuTarget',
> -  'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
> +  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'cris', 'hppa', 'i386', '=
lm32',
>                'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
>                'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
>                'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
>=20


