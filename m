Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A01DC33CB1
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 18:05:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DD4820684
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 18:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jCuagk3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD4820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itEwe-0005hJ-4v
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 13:05:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itEvk-00059C-PG
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 13:04:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itEvj-0005uA-5m
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 13:04:12 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53559
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itEvj-0005tu-2Z
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 13:04:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579457050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VKpRt6WXMiAtRDpyYcjqqPoBX+R7zBEtvktmFhFji/0=;
 b=jCuagk3xuN2+b5f2uqnSYRs6XWXZySsQI+TFxVLKgOrF5tLhxcG7VlzIi5u0NGgm/hwZGj
 cs4O5j8pn/oiYJdJBeCNqj+xtI0GsptLuViTmfYFkTcXVE98l49YIAAHMU15DJFjce0rES
 xdz5Smnv7XJ6nO9+0gzcauDtY+eL0nc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-PTsRViiUPSev4l9BYoNbsg-1; Sun, 19 Jan 2020 13:04:08 -0500
Received: by mail-wr1-f72.google.com with SMTP id u12so13012771wrt.15
 for <qemu-devel@nongnu.org>; Sun, 19 Jan 2020 10:04:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IafRIbDewu+M7dVHNRNXVWJPVzzMRLLzuBNgYEE88/I=;
 b=rKC1PTfCDJMd7p7YrXrUXC0bgvpFltolCups76EVzsWJZReqWS0hjXh4IDhpgc7TAZ
 69OaSy0QNTA9EeRUgxe5IqCcccWNuckIEQPtjFvS9BwNqwh9+KG5kYf6K6bAxu0atPll
 wL8sCD1RhURss+fpSREyFzjBjks6F7vsD0UqiyBZA7m3iVQMVU2mKEEB0GwzcJkTOxrI
 y/xfzvBY7BNbqW1P0LEFfnWdcD2IPU5ulQqECW6RQMsCoohMkrEEWoJWZ64Ruk/rZ9uy
 tf6XSM8Aj4viFAft2412kzULWKnQgFXY2tOpP/JKv84MnGtvgSP5zbeR0qn/dq+IdKaC
 LkHA==
X-Gm-Message-State: APjAAAUJfQuHUuk0DwS2YrMKNn5wK+BJ2aLUztJApMwJxBaHatl1jigM
 Wgr1/krcAZGuNU6yxJUoOsvIp+p0f6gykrYCWmSGKnB/hRsmndyikFeERjAO020WO7szCcU38ze
 31a9B7B7Ud0b4xeQ=
X-Received: by 2002:a1c:1d16:: with SMTP id d22mr15182914wmd.158.1579457047218; 
 Sun, 19 Jan 2020 10:04:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqyw9nFoXr8iF5XkIIrmFsqe597UtZMY9Ur3q9pWlHfXzXaQsesuNGCUPPev8ZCaYSVsRR3akQ==
X-Received: by 2002:a1c:1d16:: with SMTP id d22mr15182900wmd.158.1579457046972; 
 Sun, 19 Jan 2020 10:04:06 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id q3sm1307685wmc.47.2020.01.19.10.04.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Jan 2020 10:04:06 -0800 (PST)
Subject: Re: [PATCH v4 02/20] hw/arm: add Xunlong Orange Pi PC machine
To: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-devel@nongnu.org
References: <20200119005102.3847-1-nieklinnenbank@gmail.com>
 <20200119005102.3847-3-nieklinnenbank@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6dd9ce64-8126-2849-fcf1-fff71582b8f9@redhat.com>
Date: Sun, 19 Jan 2020 19:04:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200119005102.3847-3-nieklinnenbank@gmail.com>
Content-Language: en-US
X-MC-Unique: PTsRViiUPSev4l9BYoNbsg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, b.galvani@gmail.com,
 qemu-arm@nongnu.org, imammedo@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/19/20 1:50 AM, Niek Linnenbank wrote:
> The Xunlong Orange Pi PC is an Allwinner H3 System on Chip
> based embedded computer with mainline support in both U-Boot
> and Linux. The board comes with a Quad Core Cortex A7 @ 1.3GHz,
> 1GiB RAM, 100Mbit ethernet, USB, SD/MMC, USB, HDMI and
> various other I/O. This commit add support for the Xunlong
> Orange Pi PC machine.
>=20
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> Tested-by: KONRAD Frederic <frederic.konrad@adacore.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   hw/arm/orangepi.c    | 93 ++++++++++++++++++++++++++++++++++++++++++++
>   MAINTAINERS          |  1 +
>   hw/arm/Makefile.objs |  2 +-
>   3 files changed, 95 insertions(+), 1 deletion(-)
>   create mode 100644 hw/arm/orangepi.c
>=20
> diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> new file mode 100644
> index 0000000000..866f5f7cd6
> --- /dev/null
> +++ b/hw/arm/orangepi.c
> @@ -0,0 +1,93 @@
> +/*
> + * Orange Pi emulation
> + *
> + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "exec/address-spaces.h"
> +#include "qapi/error.h"
> +#include "cpu.h"
> +#include "hw/sysbus.h"
> +#include "hw/boards.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/arm/allwinner-h3.h"
> +#include "sysemu/sysemu.h"
> +
> +static struct arm_boot_info orangepi_binfo =3D {
> +    .nb_cpus =3D AW_H3_NUM_CPUS,
> +};
> +
> +typedef struct OrangePiState {
> +    AwH3State *h3;
> +    MemoryRegion sdram;
> +} OrangePiState;
> +
> +static void orangepi_init(MachineState *machine)
> +{
> +    OrangePiState *s =3D g_new(OrangePiState, 1);
> +
> +    /* BIOS is not supported by this board */
> +    if (bios_name) {
> +        error_report("BIOS not supported for this machine");
> +        exit(1);
> +    }
> +
> +    /* Only allow Cortex-A7 for this board */
> +    if (strcmp(machine->cpu_type, ARM_CPU_TYPE_NAME("cortex-a7")) !=3D 0=
) {
> +        error_report("This board can only be used with cortex-a7 CPU");
> +        exit(1);
> +    }
> +
> +    s->h3 =3D AW_H3(object_new(TYPE_AW_H3));
> +
> +    /* Setup timer properties */
> +    object_property_set_int(OBJECT(s->h3), 32768, "clk0-freq",
> +                            &error_abort);
> +    object_property_set_int(OBJECT(s->h3), 24 * 1000 * 1000, "clk1-freq"=
,
> +                            &error_abort);
> +
> +    /* Mark H3 object realized */
> +    object_property_set_bool(OBJECT(s->h3), true, "realized", &error_abo=
rt);
> +
> +    /* SDRAM */
> +    if (machine->ram_size !=3D 1 * GiB) {
> +        error_report("This machine can only be used with 1GiB of RAM");
> +        exit(1);
> +    }

I'd move this check earlier, eventually between the bios/cpu checks.

> +    memory_region_allocate_system_memory(&s->sdram, NULL, "sdram",
> +                                         machine->ram_size);
> +    memory_region_add_subregion(get_system_memory(), s->h3->memmap[AW_H3=
_SDRAM],
> +                                &s->sdram);
> +
> +    orangepi_binfo.loader_start =3D s->h3->memmap[AW_H3_SDRAM];
> +    orangepi_binfo.ram_size =3D machine->ram_size;
> +    arm_load_kernel(ARM_CPU(first_cpu), machine, &orangepi_binfo);
> +}
> +
> +static void orangepi_machine_init(MachineClass *mc)
> +{
> +    mc->desc =3D "Orange Pi PC";
> +    mc->init =3D orangepi_init;
> +    mc->min_cpus =3D AW_H3_NUM_CPUS;
> +    mc->max_cpus =3D AW_H3_NUM_CPUS;
> +    mc->default_cpus =3D AW_H3_NUM_CPUS;
> +    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a7");
> +    mc->default_ram_size =3D 1 * GiB;
> +}
> +
> +DEFINE_MACHINE("orangepi-pc", orangepi_machine_init)
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 225582704d..e99797eec9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -487,6 +487,7 @@ L: qemu-arm@nongnu.org
>   S: Maintained
>   F: hw/*/allwinner-h3*
>   F: include/hw/*/allwinner-h3*
> +F: hw/arm/orangepi.c
>  =20
>   ARM PrimeCell and CMSDK devices
>   M: Peter Maydell <peter.maydell@linaro.org>
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index ae577e875f..534a6a119e 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -35,7 +35,7 @@ obj-$(CONFIG_DIGIC) +=3D digic.o
>   obj-$(CONFIG_OMAP) +=3D omap1.o omap2.o
>   obj-$(CONFIG_STRONGARM) +=3D strongarm.o
>   obj-$(CONFIG_ALLWINNER_A10) +=3D allwinner-a10.o cubieboard.o
> -obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3.o
> +obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3.o orangepi.o
>   obj-$(CONFIG_RASPI) +=3D bcm2835_peripherals.o bcm2836.o raspi.o
>   obj-$(CONFIG_STM32F205_SOC) +=3D stm32f205_soc.o
>   obj-$(CONFIG_STM32F405_SOC) +=3D stm32f405_soc.o
>=20

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


