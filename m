Received: from eggs.gnu.org ([2001:4830:134:3::10]:48111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gMW5l-0000rn-I8
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 05:38:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gMW5h-0006bf-99
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 05:38:45 -0500
Date: Tue, 13 Nov 2018 11:38:24 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20181113103824.GF1148@toto>
References: <20181110081147.4027-1-luc.michel@greensocs.com>
	<20181110081147.4027-2-luc.michel@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181110081147.4027-2-luc.michel@greensocs.com>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v5 01/16] hw/cpu: introduce CPU
 clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, alistair@alistair23.me, mark.burton@greensocs.com, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, saipava@xilinx.com, edgari@xilinx.com, qemu-arm@nongnu.org

On Sat, Nov 10, 2018 at 09:11:32AM +0100, Luc Michel wrote:
> This commit adds the cpu-cluster type. It aims at gathering CPUs from
> the same cluster in a machine.
> 
> For now it only has a `cluster-id` property.
> 
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  include/hw/cpu/cluster.h | 38 ++++++++++++++++++++++++++
>  hw/cpu/cluster.c         | 59 ++++++++++++++++++++++++++++++++++++++++
>  MAINTAINERS              |  2 ++
>  hw/cpu/Makefile.objs     |  2 +-
>  4 files changed, 100 insertions(+), 1 deletion(-)
>  create mode 100644 include/hw/cpu/cluster.h
>  create mode 100644 hw/cpu/cluster.c
> 
> diff --git a/include/hw/cpu/cluster.h b/include/hw/cpu/cluster.h
> new file mode 100644
> index 0000000000..11f50d5f6b
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
> +#ifndef HW_CPU_CLUSTER_H
> +#define HW_CPU_CLUSTER_H
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
> index 0000000000..e0ffd76152
> --- /dev/null
> +++ b/hw/cpu/cluster.c
> @@ -0,0 +1,59 @@
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
> +#include "qemu/osdep.h"
> +#include "hw/cpu/cluster.h"
> +#include "qapi/error.h"
> +#include "qemu/module.h"
> +
> +static void cpu_cluster_init(Object *obj)
> +{
> +    static uint32_t cluster_id_auto_increment;
> +    CPUClusterState *cluster = CPU_CLUSTER(obj);
> +
> +    cluster->cluster_id = cluster_id_auto_increment++;
> +}
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
> +    .instance_init = cpu_cluster_init,
> +    .class_init = cpu_cluster_class_init,
> +};
> +
> +static void cpu_cluster_register_types(void)
> +{
> +    type_register_static(&cpu_cluster_type_info);
> +}
> +
> +type_init(cpu_cluster_register_types)
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 126fe0be7e..8e20b0e672 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1022,11 +1022,13 @@ Machine core
>  M: Eduardo Habkost <ehabkost@redhat.com>
>  M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>  S: Supported
>  F: hw/core/machine.c
>  F: hw/core/null-machine.c
> +F: hw/cpu/cluster.c
>  F: include/hw/boards.h
> +F: include/hw/cpu/cluster.h
>  T: git git://github.com/ehabkost/qemu.git machine-next
>  
>  Xtensa Machines
>  ---------------
>  sim
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
