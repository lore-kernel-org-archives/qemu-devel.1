Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D295FC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 22:46:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AC412053B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 22:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPFTqHe8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC412053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipK5e-0007B7-HY
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 17:46:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ipK4H-00062Y-7a
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 17:44:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ipK4F-0006dS-CJ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 17:44:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26092
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ipK4F-0006br-8R
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 17:44:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578523486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c71nBxylHzZYuZ8vIDD7+D96UGKhe4+R058NoEMUCKk=;
 b=bPFTqHe84p24oavHJtdd/+iU+7oUJ5DFGPZ92MAkbfA2g1YJOxsBV1UT5sP5pscaNBCtaL
 A4yNbsnQ81O7zLtQs/cBpqs5+lVhjBRMODksIRc+1LSxe4/95CYWEG1UB8oYggRFWnw8pN
 S2h/RGiHeOP1Jh/dqYpT0STWsrzooD4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-AERF7iIaO7GoOOHf_HI2bQ-1; Wed, 08 Jan 2020 17:44:44 -0500
Received: by mail-wr1-f69.google.com with SMTP id t3so2004406wrm.23
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 14:44:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aMfzobTzZlw3/yKsPC6q6tLJaCo/BlLxYCg7dNg72Zs=;
 b=BXGfjFEFiT6N90OCqgAanYwRefMZ+UX5vGxUWyIkRqaHVjUCl6EBQDdj4Y4Lq3W2Z0
 vGD0XF6ebsA4f9GNWvqd0OSpaGeaKmIDvOzi65+U3gMvAnADkN/y9C+lV6i1pKfIoAiH
 Vfz+wmx5WFb97aLZ7cqUVeA7kI3k/7RMPRirGUVsb2b6Szw1/jAUVQv4ZF1lgZwF/KcY
 CWvvg037Vy8YpNQl0xecjL5i+A+peZWRdKx23SvjuBKNXBsRpixznSVts4cReG/vuJjy
 PWHsSvYq9MhvE/xSNkbjoypaD2q/yYE3ocjNXMy4cop07QMedWiL4Bjx7m3E7H09KY9K
 aCrw==
X-Gm-Message-State: APjAAAX47rGjx3XS97x0xlQY0XPYoHQ9fFpX6yo1VzpaleQG6+5knubq
 7zRAt7G/tQm7t0RKKpZf1wgrdclXCb5dDuCx6fjkOoL2Y9YXy0WeJS2oGPN91EKk0KIOjVkyM/+
 3oB/4EAPBLgeMZgE=
X-Received: by 2002:a1c:f719:: with SMTP id v25mr958960wmh.116.1578523483503; 
 Wed, 08 Jan 2020 14:44:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqxFUKdiOXRsQypJkcQqPdFfVtSoi3cVgr36Znc7KFZ+KfC5G3oBWyaoHleFESNISjgXv2GQsA==
X-Received: by 2002:a1c:f719:: with SMTP id v25mr958947wmh.116.1578523483185; 
 Wed, 08 Jan 2020 14:44:43 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id s15sm5924629wrp.4.2020.01.08.14.44.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2020 14:44:42 -0800 (PST)
Subject: Re: [PATCH v3 02/17] hw/arm: add Xunlong Orange Pi PC machine
To: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-devel@nongnu.org
References: <20200108200020.4745-1-nieklinnenbank@gmail.com>
 <20200108200020.4745-3-nieklinnenbank@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c41068dc-7684-3da2-e53e-649e3e4aded1@redhat.com>
Date: Wed, 8 Jan 2020 23:44:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108200020.4745-3-nieklinnenbank@gmail.com>
Content-Language: en-US
X-MC-Unique: AERF7iIaO7GoOOHf_HI2bQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/8/20 9:00 PM, Niek Linnenbank wrote:
> The Xunlong Orange Pi PC is an Allwinner H3 System on Chip
> based embedded computer with mainline support in both U-Boot
> and Linux. The board comes with a Quad Core Cortex A7 @ 1.3GHz,
> 512MB RAM, 100Mbit ethernet, USB, SD/MMC, USB, HDMI and
> various other I/O. This commit add support for the Xunlong
> Orange Pi PC machine.
>=20
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> Tested-by: KONRAD Frederic <frederic.konrad@adacore.com>
> ---
>   hw/arm/orangepi.c    | 93 ++++++++++++++++++++++++++++++++++++++++++++
>   MAINTAINERS          |  1 +
>   hw/arm/Makefile.objs |  2 +-
>   3 files changed, 95 insertions(+), 1 deletion(-)
>   create mode 100644 hw/arm/orangepi.c
>=20
> diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> new file mode 100644
> index 0000000000..051184f14f
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
> +    .board_id =3D -1,

Since you use a dtb, I suppose Linux ignores this board_id.

Nitpick, you can set this here:

        .nb_cpus =3D AW_H3_NUM_CPUS,

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

I'd do the bios check first, as it is cheap and avoid allocating RAM + H3:

        /* Load target kernel or start using BootROM */
        if (bios_name) {
            error_report("BIOS not supported for this machine");
            exit(1);
        }

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
> +    object_property_set_int(OBJECT(s->h3), 24000000, "clk1-freq",

I find 24 * 1000 * 1000 easier to review.

> +                            &error_abort);
> +
> +    /* Mark H3 object realized */
> +    object_property_set_bool(OBJECT(s->h3), true, "realized", &error_abo=
rt);
> +
> +    /* SDRAM */
> +    if (machine->ram_size !=3D 1 * GiB) {
> +        error_report("Requested ram size is not supported for this machi=
ne: "
> +                     "restricted to 1GiB");

Maybe easier as "This machine can only be used with 1GiB of RAM"

> +        exit(1);
> +    }
> +    memory_region_allocate_system_memory(&s->sdram, NULL, "sdram",
> +                                         machine->ram_size);
> +    memory_region_add_subregion(get_system_memory(), s->h3->memmap[AW_H3=
_SDRAM],
> +                                &s->sdram);
> +
> +    /* Load target kernel or start using BootROM */
> +    if (bios_name) {
> +        error_report("BIOS not supported for this machine");
> +        exit(1);
> +    }
> +    orangepi_binfo.loader_start =3D s->h3->memmap[AW_H3_SDRAM];
> +    orangepi_binfo.ram_size =3D machine->ram_size;
> +    orangepi_binfo.nb_cpus  =3D AW_H3_NUM_CPUS;
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
> index dc2d7991bf..6e1b92b5fa 100644
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
> index 956e496052..8d5ea453d5 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -34,7 +34,7 @@ obj-$(CONFIG_DIGIC) +=3D digic.o
>   obj-$(CONFIG_OMAP) +=3D omap1.o omap2.o
>   obj-$(CONFIG_STRONGARM) +=3D strongarm.o
>   obj-$(CONFIG_ALLWINNER_A10) +=3D allwinner-a10.o cubieboard.o
> -obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3.o
> +obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3.o orangepi.o
>   obj-$(CONFIG_RASPI) +=3D bcm2835_peripherals.o bcm2836.o raspi.o
>   obj-$(CONFIG_STM32F205_SOC) +=3D stm32f205_soc.o
>   obj-$(CONFIG_XLNX_ZYNQMP_ARM) +=3D xlnx-zynqmp.o xlnx-zcu102.o
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


