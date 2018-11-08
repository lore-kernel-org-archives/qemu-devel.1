Received: from eggs.gnu.org ([2001:4830:134:3::10]:37280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gKn5m-0006DN-32
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:23:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gKn5b-0007Na-TR
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:23:34 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1gKn5b-0007Mt-Jx
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:23:27 -0500
Received: by mail-wm1-f66.google.com with SMTP id w7-v6so1869306wmc.1
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 08:23:27 -0800 (PST)
MIME-Version: 1.0
References: <20181106110548.4209-1-luc.michel@greensocs.com>
	<20181106110548.4209-2-luc.michel@greensocs.com>
	<28f0188a-e8fb-ad21-0c1d-9aaa5b81d261@redhat.com>
In-Reply-To: <28f0188a-e8fb-ad21-0c1d-9aaa5b81d261@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Thu, 8 Nov 2018 17:23:14 +0100
Message-ID: <CAP+75-XPStesboG8yybAaknYHg0k6nxwsihJdEVeHJnOJHNKNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 01/16] hw/cpu: introduce CPU clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair@alistair23.me>, Mark Burton <mark.burton@greensocs.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>

On Thu, Nov 8, 2018 at 5:17 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
> On 6/11/18 12:05, Luc Michel wrote:
> > This commit adds the cpu-cluster type. It aims at gathering CPUs from
> > the same cluster in a machine.
> >
> > For now it only has a `cluster-id` property.
> >
> > Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >   include/hw/cpu/cluster.h | 38 ++++++++++++++++++++++++++
> >   hw/cpu/cluster.c         | 59 +++++++++++++++++++++++++++++++++++++++=
+

Eduardo are you OK to cover these files in your "Machine core"
MAINTAINER's section?

> >   hw/cpu/Makefile.objs     |  2 +-
> >   3 files changed, 98 insertions(+), 1 deletion(-)
> >   create mode 100644 include/hw/cpu/cluster.h
> >   create mode 100644 hw/cpu/cluster.c
> >
> > diff --git a/include/hw/cpu/cluster.h b/include/hw/cpu/cluster.h
> > new file mode 100644
> > index 0000000000..0e5f121ec2
> > --- /dev/null
> > +++ b/include/hw/cpu/cluster.h
> > @@ -0,0 +1,38 @@
> > +/*
> > + * QEMU CPU cluster
> > + *
> > + * Copyright (c) 2018 GreenSocs SAS
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version 2
> > + * of the License, or (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, see
> > + * <http://www.gnu.org/licenses/gpl-2.0.html>
> > + */
> > +#ifndef HW_CPU_CLUSTER_H
> > +#define HW_CPU_CLUSTER_H
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/qdev.h"
> > +
> > +#define TYPE_CPU_CLUSTER "cpu-cluster"
> > +#define CPU_CLUSTER(obj) \
> > +    OBJECT_CHECK(CPUClusterState, (obj), TYPE_CPU_CLUSTER)
> > +
> > +typedef struct CPUClusterState {
> > +    /*< private >*/
> > +    DeviceState parent_obj;
> > +
> > +    /*< public >*/
> > +    uint64_t cluster_id;
>
> As it or reducing this type:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> > +} CPUClusterState;
> > +
> > +#endif
> > diff --git a/hw/cpu/cluster.c b/hw/cpu/cluster.c
> > new file mode 100644
> > index 0000000000..a23d55054a
> > --- /dev/null
> > +++ b/hw/cpu/cluster.c
> > @@ -0,0 +1,59 @@
> > +/*
> > + * QEMU CPU cluster
> > + *
> > + * Copyright (c) 2018 GreenSocs SAS
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version 2
> > + * of the License, or (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, see
> > + * <http://www.gnu.org/licenses/gpl-2.0.html>
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/cpu/cluster.h"
> > +#include "qapi/error.h"
> > +#include "qemu/module.h"
> > +
> > +static void cpu_cluster_init(Object *obj)
> > +{
> > +    static uint64_t cluster_id_auto_increment =3D 0;
> > +    CPUClusterState *cluster =3D CPU_CLUSTER(obj);
> > +
> > +    cluster->cluster_id =3D cluster_id_auto_increment++;
> > +}
> > +
> > +static Property cpu_cluster_properties[] =3D {
> > +    DEFINE_PROP_UINT64("cluster-id", CPUClusterState, cluster_id, 0),
> > +    DEFINE_PROP_END_OF_LIST()
> > +};
> > +
> > +static void cpu_cluster_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    dc->props =3D cpu_cluster_properties;
> > +}
> > +
> > +static const TypeInfo cpu_cluster_type_info =3D {
> > +    .name =3D TYPE_CPU_CLUSTER,
> > +    .parent =3D TYPE_DEVICE,
> > +    .instance_size =3D sizeof(CPUClusterState),
> > +    .instance_init =3D cpu_cluster_init,
> > +    .class_init =3D cpu_cluster_class_init,
> > +};
> > +
> > +static void cpu_cluster_register_types(void)
> > +{
> > +    type_register_static(&cpu_cluster_type_info);
> > +}
> > +
> > +type_init(cpu_cluster_register_types)
> > diff --git a/hw/cpu/Makefile.objs b/hw/cpu/Makefile.objs
> > index cd52d20b65..8db9e8a7b3 100644
> > --- a/hw/cpu/Makefile.objs
> > +++ b/hw/cpu/Makefile.objs
> > @@ -1,5 +1,5 @@
> >   obj-$(CONFIG_ARM11MPCORE) +=3D arm11mpcore.o
> >   obj-$(CONFIG_REALVIEW) +=3D realview_mpcore.o
> >   obj-$(CONFIG_A9MPCORE) +=3D a9mpcore.o
> >   obj-$(CONFIG_A15MPCORE) +=3D a15mpcore.o
> > -common-obj-y +=3D core.o
> > +common-obj-y +=3D core.o cluster.o
> >
