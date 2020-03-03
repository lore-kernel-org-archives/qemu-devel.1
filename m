Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38DFC3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 11:04:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E8392083E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 11:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xutjj9iG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8392083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j95LM-0004TY-OQ
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 06:04:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j95K1-0002z9-Ti
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 06:02:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j95K0-0001RT-8w
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 06:02:45 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36426)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j95K0-0001R6-0a
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 06:02:44 -0500
Received: by mail-wr1-x442.google.com with SMTP id j16so3792878wrt.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 03:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=1P0ZlxUHohlsrlbPBODtUSaACtCSSMYOYhjWGvBgBXk=;
 b=Xutjj9iGWvUi8uKRZllF0O4xFR6TAkQ9PCf2uHDQuklUbfgmxQMInBYCk0javrhdsJ
 wKftWKwQEB4NA2W0UDyvYed4Z4Z6/O8wZc3gcvOunpXDr1C7yqQUN5YCfQEETB6CmcmI
 9N+HbwW0cy3oUh8Q5zr5fVAHYVsaD5Cpm5fZmK7a3z+vr/IjAsIcRkX1x6EMlaERhLc0
 Sb7+7U+684G13Q9L3IkURMPGkOCkWPMwZfHxez7h1mrgLz6i3T+Ad9BY1FkfGmJsxi/6
 6ynSLsC5Q6tbzMFuE973Ek+wWP5bhac29VNkFa/uWo5yPFUmvUiXaXksH5urMFTnC9fl
 4aQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=1P0ZlxUHohlsrlbPBODtUSaACtCSSMYOYhjWGvBgBXk=;
 b=iRavMhm/8uz3Uy9d/vAQVC4GPfLVitidJz+gjghIA1sOvuXkOTvghU3o8vt2UMldRd
 DBZPNIaKxPTH0e792IEJUsPCseWwM428tit3+KKiupmaz1vr5nacvFijrdAwuGadi8XB
 LJ+Y1fJSbIr/yWnMapojkpapKiZjm1sm+joNaUaGl7ELPfegzQOou+HRZrC/XZ0hjXDj
 c9ITmNPMtogmsAYepMvY2Am5EoK/16BZRC12jYbg+nLwKXR2X1mHz1Ajkf34iiDPzS9j
 8E8+OW6mHCHB2Px52fJFL7vK/yTGB65SowV1B7yzVnldHd1jMLynexWWOpuSCh9R3DHm
 jzSQ==
X-Gm-Message-State: ANhLgQ3CxzHBXsJhu9dpHF1Tcn2062Qz6xAvaYQP60HYYn9jgxvVhecX
 2q/kCb0X7mHvcgEztwhzxJL8Tg==
X-Google-Smtp-Source: ADFU+vuc+0c9m8bZ2CxZF9bsPVJYoCVkpR+l+7F9jGFoJa1tSgxIXRqE/ngn5yG2erAMSuic9lR4bw==
X-Received: by 2002:a5d:4582:: with SMTP id p2mr4991786wrq.80.1583233362808;
 Tue, 03 Mar 2020 03:02:42 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u20sm3148031wmj.14.2020.03.03.03.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2020 03:02:41 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BEBD21FF87;
 Tue,  3 Mar 2020 11:02:40 +0000 (GMT)
References: <20200301215029.15196-1-nieklinnenbank@gmail.com>
 <20200301215029.15196-3-nieklinnenbank@gmail.com>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: Re: [PATCH v6 02/18] hw/arm: add Xunlong Orange Pi PC machine
In-reply-to: <20200301215029.15196-3-nieklinnenbank@gmail.com>
Date: Tue, 03 Mar 2020 11:02:40 +0000
Message-ID: <87sgip7lbj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, qemu-devel@nongnu.org,
 b.galvani@gmail.com, qemu-arm@nongnu.org, imammedo@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Niek Linnenbank <nieklinnenbank@gmail.com> writes:

> The Xunlong Orange Pi PC is an Allwinner H3 System on Chip
> based embedded computer with mainline support in both U-Boot
> and Linux. The board comes with a Quad Core Cortex A7 @ 1.3GHz,
> 1GiB RAM, 100Mbit ethernet, USB, SD/MMC, USB, HDMI and
> various other I/O. This commit add support for the Xunlong
> Orange Pi PC machine.
>
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> Tested-by: KONRAD Frederic <frederic.konrad@adacore.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Acked-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  hw/arm/orangepi.c    | 89 ++++++++++++++++++++++++++++++++++++++++++++
>  MAINTAINERS          |  1 +
>  hw/arm/Makefile.objs |  2 +-
>  3 files changed, 91 insertions(+), 1 deletion(-)
>  create mode 100644 hw/arm/orangepi.c
>
> diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> new file mode 100644
> index 0000000000..19adfca917
> --- /dev/null
> +++ b/hw/arm/orangepi.c
> @@ -0,0 +1,89 @@
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
> +static void orangepi_init(MachineState *machine)
> +{
> +    AwH3State *h3;
> +
> +    /* BIOS is not supported by this board */
> +    if (bios_name) {
> +        error_report("BIOS not supported for this machine");
> +        exit(1);
> +    }
> +
> +    /* This board has fixed size RAM */
> +    if (machine->ram_size !=3D 1 * GiB) {
> +        error_report("This machine can only be used with 1GiB of RAM");
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
> +    h3 =3D AW_H3(object_new(TYPE_AW_H3));
> +
> +    /* Setup timer properties */
> +    object_property_set_int(OBJECT(h3), 32768, "clk0-freq",
> +                            &error_abort);
> +    object_property_set_int(OBJECT(h3), 24 * 1000 * 1000, "clk1-freq",
> +                            &error_abort);
> +
> +    /* Mark H3 object realized */
> +    object_property_set_bool(OBJECT(h3), true, "realized", &error_abort);
> +
> +    /* SDRAM */
> +    memory_region_add_subregion(get_system_memory(), h3->memmap[AW_H3_SD=
RAM],
> +                                machine->ram);
> +
> +    orangepi_binfo.loader_start =3D h3->memmap[AW_H3_SDRAM];
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
> +    mc->default_ram_id =3D "orangepi.ram";
> +}
> +
> +DEFINE_MACHINE("orangepi-pc", orangepi_machine_init)
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d5c0c25cc4..02ecba8d9c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -496,6 +496,7 @@ L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/*/allwinner-h3*
>  F: include/hw/*/allwinner-h3*
> +F: hw/arm/orangepi.c
>=20=20
>  ARM PrimeCell and CMSDK devices
>  M: Peter Maydell <peter.maydell@linaro.org>
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index ae577e875f..534a6a119e 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -35,7 +35,7 @@ obj-$(CONFIG_DIGIC) +=3D digic.o
>  obj-$(CONFIG_OMAP) +=3D omap1.o omap2.o
>  obj-$(CONFIG_STRONGARM) +=3D strongarm.o
>  obj-$(CONFIG_ALLWINNER_A10) +=3D allwinner-a10.o cubieboard.o
> -obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3.o
> +obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3.o orangepi.o
>  obj-$(CONFIG_RASPI) +=3D bcm2835_peripherals.o bcm2836.o raspi.o
>  obj-$(CONFIG_STM32F205_SOC) +=3D stm32f205_soc.o
>  obj-$(CONFIG_STM32F405_SOC) +=3D stm32f405_soc.o


--=20
Alex Benn=C3=A9e

