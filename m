Received: from eggs.gnu.org ([2001:4830:134:3::10]:45311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffRQv-0000Dr-2Q
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:58:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffRQu-00013F-0l
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:58:33 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:37583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffRQt-00012r-QB
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:58:31 -0400
Received: by mail-oi0-x242.google.com with SMTP id k81-v6so2582745oib.4
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 07:58:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b6c55b0c843ec3164f86e4b40225be0d5ab5b0fa.1530395710.git.jcd@tribudubois.net>
References: <cover.1530395710.git.jcd@tribudubois.net>
	<b6c55b0c843ec3164f86e4b40225be0d5ab5b0fa.1530395710.git.jcd@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jul 2018 15:58:10 +0100
Message-ID: <CAFEAcA-pdtV-rsPLGBvW8nyk5P1F-WeOWOGMpxVy0AUNgg7LGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/3] i.MX6UL: Add i.MX6UL SOC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>, Andrey Smirnov <andrew.smirnov@gmail.com>

On 30 June 2018 at 22:58, Jean-Christophe Dubois <jcd@tribudubois.net> wrote:
> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
> ---
>  default-configs/arm-softmmu.mak |   1 +
>  hw/arm/Makefile.objs            |   1 +
>  hw/arm/fsl-imx6ul.c             | 649 ++++++++++++++++++++++++++++++++
>  include/hw/arm/fsl-imx6ul.h     | 339 +++++++++++++++++
>  4 files changed, 990 insertions(+)
>  create mode 100644 hw/arm/fsl-imx6ul.c
>  create mode 100644 include/hw/arm/fsl-imx6ul.h
>
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 834d45cfaf..311584fd74 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -133,6 +133,7 @@ CONFIG_FSL_IMX6=y
>  CONFIG_FSL_IMX31=y
>  CONFIG_FSL_IMX25=y
>  CONFIG_FSL_IMX7=y
> +CONFIG_FSL_IMX6UL=y
>
>  CONFIG_IMX_I2C=y
>
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index d51fcecaf2..e419ad040b 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -36,3 +36,4 @@ obj-$(CONFIG_MSF2) += msf2-soc.o msf2-som.o
>  obj-$(CONFIG_IOTKIT) += iotkit.o
>  obj-$(CONFIG_FSL_IMX7) += fsl-imx7.o mcimx7d-sabre.o
>  obj-$(CONFIG_ARM_SMMUV3) += smmu-common.o smmuv3.o
> +obj-$(CONFIG_FSL_IMX6UL) += fsl-imx6ul.o
> diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
> new file mode 100644
> index 0000000000..25d6c3f7c2
> --- /dev/null
> +++ b/hw/arm/fsl-imx6ul.c
> @@ -0,0 +1,649 @@
> +/*
> + * Copyright (c) 2018 Jean-Christophe Dubois <jcd@tribudubois.net>
> + *
> + * i.MX6UL SOC emulation.
> + *
> + * Based on hw/arm/fsl-imx7.c
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu-common.h"
> +#include "hw/arm/fsl-imx6ul.h"
> +#include "hw/misc/unimp.h"
> +#include "sysemu/sysemu.h"
> +#include "qemu/error-report.h"
> +
> +#define NAME_SIZE 20
> +
> +static void fsl_imx6ul_init(Object *obj)
> +{
> +    BusState *sysbus = sysbus_get_default();
> +    FslIMX6ULState *s = FSL_IMX6UL(obj);
> +    char name[NAME_SIZE];
> +    int i;
> +
> +
> +    for (i = 0; i < MIN(smp_cpus, FSL_IMX6UL_NUM_CPUS); i++) {
> +        object_initialize(&s->cpu[i], sizeof(s->cpu[i]),
> +                          ARM_CPU_TYPE_NAME("cortex-a7"));
> +        snprintf(name, NAME_SIZE, "cpu%d", i);
> +        object_property_add_child(obj, name, OBJECT(&s->cpu[i]),
> +                                  &error_fatal);
> +    }


It's been discovered recently that initializing child QOM objects
like this leaks a reference count to them, which can cause crashes
if the device is introspected via the QMP interface.
This has been fixed for various devices including the in-tree FSL
SoC containers in commits 0210b39d0e8..ccf02d73d18 (which just
got pushed to master this afternoon).

Commit e9e4d4d3e18 is the one that fixes fsl-imx6.c, and we should
follow that here. Specifically, rather than separate calls to
object_initialize() and object_property_add_child() we can have
one call to the new object_initialize_child():

   object_initialize_child(obj, name, &s->cpu[i], sizeof(s->cpu[i]),
                           ARM_CPU_TYPE_NAME("cortex-a7"),
                           &error_abort, NULL);

> +
> +    /*
> +     * A7MPCORE
> +     */
> +    object_initialize(&s->a7mpcore, sizeof(s->a7mpcore), TYPE_A15MPCORE_PRIV);
> +    qdev_set_parent_bus(DEVICE(&s->a7mpcore), sysbus);
> +    object_property_add_child(obj, "a7mpcore",
> +                              OBJECT(&s->a7mpcore), &error_fatal);

and for sysbus devices like this there is now a single sysbus_init_child_obj()
which does the work of all three of these calls:

    sysbus_init_child_obj(obj, "a7mpcore", &s->a7mpcore, sizeof(s->a7mpcore),
                          TYPE_A7MPCORE_PRIV);

Similarly with the various other child objects here.

thanks
-- PMM
