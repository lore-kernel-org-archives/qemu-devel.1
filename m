Received: from eggs.gnu.org ([2001:4830:134:3::10]:53339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHbmg-0002Id-50
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 17:42:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHbmd-0002eh-Ea
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 17:42:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHbmd-0002b0-5t
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 17:42:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id f1-v6so12828447wmg.1
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 14:42:33 -0700 (PDT)
References: <20181026081653.24602-1-luc.michel@greensocs.com>
	<20181026081653.24602-2-luc.michel@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <54d908e0-2704-a3b6-5fb9-9cf751308bdc@redhat.com>
Date: Tue, 30 Oct 2018 22:42:29 +0100
MIME-Version: 1.0
In-Reply-To: <20181026081653.24602-2-luc.michel@greensocs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 01/16] hw/cpu: introduce CPU clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, alistair@alistair23.me, mark.burton@greensocs.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, saipava@xilinx.com, edgari@xilinx.com, qemu-arm@nongnu.org

Hi Luc,

On 26/10/18 10:16, Luc Michel wrote:
> This commit adds the cpu-cluster type. It aims at gathering CPUs from
> the same cluster in a machine.
> 
> For now it only has a `cluster-id` property.
> 
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> ---
>   include/hw/cpu/cluster.h | 38 +++++++++++++++++++++++++++++++
>   hw/cpu/cluster.c         | 49 ++++++++++++++++++++++++++++++++++++++++
>   hw/cpu/Makefile.objs     |  2 +-
>   3 files changed, 88 insertions(+), 1 deletion(-)
>   create mode 100644 include/hw/cpu/cluster.h
>   create mode 100644 hw/cpu/cluster.c
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

32-bit is future proof!

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

Can we unburden the CPU_CLUSTER user of setting the cluster_id?
('qdev_prop_set_uint32(cpu_cluster, "cluster-id", id);' calls in patch #16)

Something like:

static void cpu_cluster_instance_init(Object *obj)
{
     CPUClusterState *s = CPU_CLUSTER(obj);
     static uint32_t cpu_cluster_auto_increment_id;

     s->cluster_id = cpu_cluster_auto_increment_id++;
}

> +static const TypeInfo cpu_cluster_type_info = {
> +    .name = TYPE_CPU_CLUSTER,
> +    .parent = TYPE_DEVICE,
> +    .instance_size = sizeof(CPUClusterState),

        .instance_init = cpu_cluster_instance_init,


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
>   obj-$(CONFIG_ARM11MPCORE) += arm11mpcore.o
>   obj-$(CONFIG_REALVIEW) += realview_mpcore.o
>   obj-$(CONFIG_A9MPCORE) += a9mpcore.o
>   obj-$(CONFIG_A15MPCORE) += a15mpcore.o
> -common-obj-y += core.o
> +common-obj-y += core.o cluster.o
> 
