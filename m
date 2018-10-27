Received: from eggs.gnu.org ([2001:4830:134:3::10]:35716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gGKDr-0003Fy-UM
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 04:45:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gGKDo-0002XP-7f
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 04:45:30 -0400
MIME-Version: 1.0
References: <20181026081653.24602-1-luc.michel@greensocs.com>
	<20181026081653.24602-2-luc.michel@greensocs.com>
In-Reply-To: <20181026081653.24602-2-luc.michel@greensocs.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Sat, 27 Oct 2018 09:44:52 +0100
Message-ID: <CAKmqyKNGUAScJbdp4=1_rYXZsQQ+KTVJMM7iyqGu=1J0_KLz0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 01/16] hw/cpu: introduce CPU clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Alistair Francis <alistair@alistair23.me>, Mark Burton <mark.burton@greensocs.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>

On Fri, Oct 26, 2018 at 9:41 AM Luc Michel <luc.michel@greensocs.com> wrote:
>
> This commit adds the cpu-cluster type. It aims at gathering CPUs from
> the same cluster in a machine.
>
> For now it only has a `cluster-id` property.
>
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> ---
>  include/hw/cpu/cluster.h | 38 +++++++++++++++++++++++++++++++
>  hw/cpu/cluster.c         | 49 ++++++++++++++++++++++++++++++++++++++++
>  hw/cpu/Makefile.objs     |  2 +-
>  3 files changed, 88 insertions(+), 1 deletion(-)
>  create mode 100644 include/hw/cpu/cluster.h
>  create mode 100644 hw/cpu/cluster.c
>
> diff --git a/include/hw/cpu/cluster.h b/include/hw/cpu/cluster.h
> new file mode 100644
> index 0000000000..f233a47a4a
> --- /dev/null
> +++ b/include/hw/cpu/cluster.h
> @@ -0,0 +1,38 @@
> +/*
> + * QEMU CPU cluster
> + *
> + * Copyright (c) 2018 GreenSocs SAS
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see
> + * <http://www.gnu.org/licenses/gpl-2.0.html>
> + */
> +#ifndef QEMU_HW_CPU_CLUSTER_H
> +#define QEMU_HW_CPU_CLUSTER_H

You probably don't need the QEMU_ here, it's not ambiguous if this is QEMU :)

> +
> +#include "qemu/osdep.h"
> +#include "hw/qdev.h"
> +
> +#define TYPE_CPU_CLUSTER "cpu-cluster"
> +#define CPU_CLUSTER(obj) \
> +    OBJECT_CHECK(CPUClusterState, (obj), TYPE_CPU_CLUSTER)
> +
> +typedef struct CPUClusterState {
> +    /*< private >*/
> +    DeviceState parent_obj;
> +
> +    /*< public >*/
> +    uint32_t cluster_id;
> +} CPUClusterState;
> +
> +#endif
> diff --git a/hw/cpu/cluster.c b/hw/cpu/cluster.c
> new file mode 100644
> index 0000000000..11121e6f26
> --- /dev/null
> +++ b/hw/cpu/cluster.c
> @@ -0,0 +1,49 @@
> +/*
> + * QEMU CPU cluster
> + *
> + * Copyright (c) 2018 GreenSocs SAS
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see
> + * <http://www.gnu.org/licenses/gpl-2.0.html>
> + */
> +

You should also include the OS deps here (the first include).

After that:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> +#include "hw/cpu/cluster.h"
> +#include "qapi/error.h"
> +#include "qemu/module.h"
> +
> +static Property cpu_cluster_properties[] = {
> +    DEFINE_PROP_UINT32("cluster-id", CPUClusterState, cluster_id, 0),
> +    DEFINE_PROP_END_OF_LIST()
> +};
> +
> +static void cpu_cluster_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->props = cpu_cluster_properties;
> +}
> +
> +static const TypeInfo cpu_cluster_type_info = {
> +    .name = TYPE_CPU_CLUSTER,
> +    .parent = TYPE_DEVICE,
> +    .instance_size = sizeof(CPUClusterState),
> +    .class_init = cpu_cluster_class_init,
> +};
> +
> +static void cpu_cluster_register_types(void)
> +{
> +    type_register_static(&cpu_cluster_type_info);
> +}
> +
> +type_init(cpu_cluster_register_types)
> diff --git a/hw/cpu/Makefile.objs b/hw/cpu/Makefile.objs
> index cd52d20b65..8db9e8a7b3 100644
> --- a/hw/cpu/Makefile.objs
> +++ b/hw/cpu/Makefile.objs
> @@ -1,5 +1,5 @@
>  obj-$(CONFIG_ARM11MPCORE) += arm11mpcore.o
>  obj-$(CONFIG_REALVIEW) += realview_mpcore.o
>  obj-$(CONFIG_A9MPCORE) += a9mpcore.o
>  obj-$(CONFIG_A15MPCORE) += a15mpcore.o
> -common-obj-y += core.o
> +common-obj-y += core.o cluster.o
> --
> 2.19.1
>
>
