Received: from eggs.gnu.org ([2001:4830:134:3::10]:50994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1calvI-00070R-F9
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:13:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1calvF-00035W-BY
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:13:48 -0500
Received: from 16.mo3.mail-out.ovh.net ([188.165.56.217]:54926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1calvF-00034W-2x
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:13:45 -0500
Received: from player693.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 34A2EA1A20
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 17:13:42 +0100 (CET)
References: <1485424060-12217-1-git-send-email-fred.konrad@greensocs.com>
	<1485424060-12217-8-git-send-email-fred.konrad@greensocs.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a88df8a3-948f-1d4c-13eb-3e4a37e6cc62@kaod.org>
Date: Mon, 6 Feb 2017 17:13:35 +0100
MIME-Version: 1.0
In-Reply-To: <1485424060-12217-8-git-send-email-fred.konrad@greensocs.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2 07/10] introduce fixed-clock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: fred.konrad@greensocs.com, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, mark.burton@greensocs.com, alistair.francis@xilinx.com

On 01/26/2017 10:47 AM, fred.konrad@greensocs.com wrote:
> From: KONRAD Frederic <fred.konrad@greensocs.com>
> 
> This is a fixed clock device.
> It justs behave as an empty device with a parametrable output rate.
> 
> Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
> ---
>  hw/misc/Makefile.objs         |  1 +
>  hw/misc/fixed-clock.c         | 88 +++++++++++++++++++++++++++++++++++++++++++
>  include/hw/misc/fixed-clock.h | 30 +++++++++++++++
>  3 files changed, 119 insertions(+)
>  create mode 100644 hw/misc/fixed-clock.c
>  create mode 100644 include/hw/misc/fixed-clock.h
> 
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index 1a89615..2670c2d 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -53,3 +53,4 @@ obj-$(CONFIG_EDU) += edu.o
>  obj-$(CONFIG_HYPERV_TESTDEV) += hyperv_testdev.o
>  obj-$(CONFIG_AUX) += auxbus.o
>  obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o
> +obj-y += fixed-clock.o
> diff --git a/hw/misc/fixed-clock.c b/hw/misc/fixed-clock.c
> new file mode 100644
> index 0000000..aa124d8
> --- /dev/null
> +++ b/hw/misc/fixed-clock.c
> @@ -0,0 +1,88 @@
> +/*
> + * Fixed clock
> + *
> + *  Copyright (C) 2016 : GreenSocs Ltd
> + *      http://www.greensocs.com/ , email: info@greensocs.com
> + *
> + *  Frederic Konrad   <fred.konrad@greensocs.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/qdev.h"
> +#include "hw/misc/fixed-clock.h"
> +#include "qemu/qemu-clock.h"
> +#include "qapi/error.h"
> +
> +#ifndef DEBUG_FIXED_CLOCK
> +#define DEBUG_FIXED_CLOCK 0
> +#endif
> +
> +#define DPRINTF(fmt, ...) do {                                               \
> +    if (DEBUG_FIXED_CLOCK) {                                                 \
> +        qemu_log(__FILE__": " fmt , ## __VA_ARGS__);                         \
> +    }                                                                        \
> +} while (0);
> +
> +typedef struct {
> +    DeviceState parent_obj;
> +
> +    uint32_t rate;
> +    struct qemu_clk out;

This really feels redundant. See my previous suggestion.

Thanks,

C. 

> +} FixedClock;
> +
> +static Property fixed_clock_properties[] = {
> +    DEFINE_PROP_UINT32("rate", FixedClock, rate, 0),
> +    DEFINE_PROP_END_OF_LIST()
> +};
> +
> +static void fixed_clock_realizefn(DeviceState *dev, Error **errp)
> +{
> +    FixedClock *s = FIXED_CLOCK(dev);
> +
> +    qemu_clk_update_rate(&s->out, s->rate);
> +}
> +
> +static void fixed_clock_instance_init(Object *obj)
> +{
> +    FixedClock *s = FIXED_CLOCK(obj);
> +
> +    object_initialize(&s->out, sizeof(s->out), TYPE_CLOCK);
> +    qemu_clk_device_add_clock(DEVICE(obj), &s->out, "clk_out");
> +}
> +
> +static void fixed_clock_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = fixed_clock_realizefn;
> +    dc->props = fixed_clock_properties;
> +}
> +
> +static const TypeInfo fixed_clock_info = {
> +    .name          = TYPE_FIXED_CLOCK,
> +    .parent        = TYPE_DEVICE,
> +    .instance_size = sizeof(FixedClock),
> +    .instance_init = fixed_clock_instance_init,
> +    .class_init    = fixed_clock_class_init,
> +};
> +
> +static void fixed_clock_register_types(void)
> +{
> +    type_register_static(&fixed_clock_info);
> +}
> +
> +type_init(fixed_clock_register_types);
> diff --git a/include/hw/misc/fixed-clock.h b/include/hw/misc/fixed-clock.h
> new file mode 100644
> index 0000000..1376444
> --- /dev/null
> +++ b/include/hw/misc/fixed-clock.h
> @@ -0,0 +1,30 @@
> +/*
> + * Fixed clock
> + *
> + *  Copyright (C) 2016 : GreenSocs Ltd
> + *      http://www.greensocs.com/ , email: info@greensocs.com
> + *
> + *  Frederic Konrad   <fred.konrad@greensocs.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + *
> + */
> +
> +#ifndef FIXED_CLOCK_H
> +#define FIXED_CLOCK_H
> +
> +#define TYPE_FIXED_CLOCK "fixed-clock"
> +#define FIXED_CLOCK(obj) OBJECT_CHECK(FixedClock, (obj), TYPE_FIXED_CLOCK)
> +
> +#endif /* FIXED_CLOCK_H */
> 
