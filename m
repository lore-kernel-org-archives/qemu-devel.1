Return-Path: <SRS0=YGca=2Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1FBC2D0C2
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2020 11:27:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 729CE217F4
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2020 11:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MP6vut1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729CE217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inhb0-0000t9-Kb
	for qemu-devel@archiver.kernel.org; Sat, 04 Jan 2020 06:27:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1inha7-0000RX-VT
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 06:27:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1inha6-0007DG-Mv
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 06:26:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49837
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1inha6-0007CI-Ec
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 06:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578137217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IonCWIyG2gexegsKcCi5eF5Q1Rg6NkbQFpbZ47bcw9A=;
 b=MP6vut1yTDEfiKdO05AiZvsLa+ctAyGRk2KrwlbympkqBM1ihPR7N2ONVw7BaYi2NqtP1E
 IInHqdxwAlazyg8fb+rw3POpMqdq7tpav9VwLeREG4Rw90FhIux8yFPl72FxWp+wTbxUee
 ODyu1YQdEVBkbG6A9+jRHJoVAPZy4VQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-STg_W9pVNaezPAkkFxNrow-1; Sat, 04 Jan 2020 06:26:52 -0500
Received: by mail-wr1-f72.google.com with SMTP id j13so10186941wrr.20
 for <qemu-devel@nongnu.org>; Sat, 04 Jan 2020 03:26:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=35JzhMTPLgTFcVA1q6MHO9ZuMGoYv2iYAYmzJtFYhSY=;
 b=H5VfRmTf/5Sa07vdtNUTQ+xyzVapqoTwJSzYGVMP7D0TEyA/CX5eoYRPcsXay9dusc
 LTft9g4nJNZIkBnOq/Oha+y+8bFaXRtJbCcw6J21QTaPakul4mEu3jUUnjibOuOgLFBj
 /PkRp8Dy45M2gdP38KSRHVO36q28suNid0V7V3nOtEAHfXnEfT3aQg5WPPOyndXhv/DY
 sAwADLshfA7kqkaj5ppu47ij0CrXBMniGtBuHjCBb5Y97EV+Rdl0iHT+aNfx/m3QNYZq
 lfGVVxVl8ovBQuEUyePh6+/33wVgDuGjVKonn3+XrrzSj5eJW1vYp6//VneiISCTtrV1
 X9rw==
X-Gm-Message-State: APjAAAV/tMlRmz9iehOAYH9KO5QayhyiUU1HuR1BjvkkJ+Z44CkZGlRQ
 MqlFNfEAfzfnieu/v9+VHngD231I+YfAQ7QuwWeFnHKGy3OJRpk8S/e4J8kpT9otPa4pr5wbemd
 pPAK4d8+Fb+7uhdE=
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr25226385wmj.90.1578137211080; 
 Sat, 04 Jan 2020 03:26:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqxbDd4ArCwUA8eO4tuE7a5Ut178Y43I6xlEHAxDMz52SR24/cbPjP95eQ+sWHT3aZ91hYHf6w==
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr25226375wmj.90.1578137210889; 
 Sat, 04 Jan 2020 03:26:50 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id t8sm62169316wrp.69.2020.01.04.03.26.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jan 2020 03:26:50 -0800 (PST)
Subject: Re: [PATCH 2/3] capstone: Enable disassembly for s390x
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-s390x <qemu-s390x@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20200103212500.14384-1-richard.henderson@linaro.org>
 <20200103212500.14384-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ef288915-88cf-c498-3dc8-6c26d5817567@redhat.com>
Date: Sat, 4 Jan 2020 12:26:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200103212500.14384-3-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: STg_W9pVNaezPAkkFxNrow-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/3/20 10:24 PM, Richard Henderson wrote:
> Enable s390x, aka SYSZ, in the git submodule build.
> Set the capstone parameters for both s390x host and guest.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

I'm fine with this patch because I don't use the s390 disas often.
For the S390 experts, my previous analysis is here:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg667954.html

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   Makefile           | 1 +
>   disas.c            | 3 +++
>   target/s390x/cpu.c | 4 ++++
>   3 files changed, 8 insertions(+)
>=20
> diff --git a/Makefile b/Makefile
> index 12e129ac9d..df1c692ccd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -504,6 +504,7 @@ CAP_CFLAGS +=3D -DCAPSTONE_USE_SYS_DYN_MEM
>   CAP_CFLAGS +=3D -DCAPSTONE_HAS_ARM
>   CAP_CFLAGS +=3D -DCAPSTONE_HAS_ARM64
>   CAP_CFLAGS +=3D -DCAPSTONE_HAS_POWERPC
> +CAP_CFLAGS +=3D -DCAPSTONE_HAS_SYSZ
>   CAP_CFLAGS +=3D -DCAPSTONE_HAS_X86
>  =20
>   .PHONY: capstone/all
> diff --git a/disas.c b/disas.c
> index 3937da6157..845c40fca8 100644
> --- a/disas.c
> +++ b/disas.c
> @@ -660,6 +660,9 @@ void disas(FILE *out, void *code, unsigned long size)
>       print_insn =3D print_insn_m68k;
>   #elif defined(__s390__)
>       print_insn =3D print_insn_s390;
> +    s.info.cap_arch =3D CS_ARCH_SYSZ;
> +    s.info.cap_insn_unit =3D 2;
> +    s.info.cap_insn_split =3D 6;
>   #elif defined(__hppa__)
>       print_insn =3D print_insn_hppa;
>   #endif
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 625daeedd1..1734ad9c3a 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -43,6 +43,7 @@
>   #include "sysemu/tcg.h"
>   #endif
>   #include "fpu/softfloat-helpers.h"
> +#include "disas/capstone.h"
>  =20
>   #define CR0_RESET       0xE0UL
>   #define CR14_RESET      0xC2000000UL;
> @@ -162,6 +163,9 @@ static void s390_cpu_disas_set_info(CPUState *cpu, di=
sassemble_info *info)
>   {
>       info->mach =3D bfd_mach_s390_64;
>       info->print_insn =3D print_insn_s390;
> +    info->cap_arch =3D CS_ARCH_SYSZ;
> +    info->cap_insn_unit =3D 2;
> +    info->cap_insn_split =3D 6;
>   }
>  =20
>   static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
>=20


