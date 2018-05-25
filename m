Received: from eggs.gnu.org ([2001:4830:134:3::10]:47789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fMFNE-0003LP-G5
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:16:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fMFMI-0007qm-GE
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:15:23 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:38941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fMFMI-0007pg-1g
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:14:26 -0400
Received: by mail-wm0-x242.google.com with SMTP id f8-v6so16039767wmc.4
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 09:14:25 -0700 (PDT)
References: <20180501142222.19154-1-kbastian@mail.uni-paderborn.de>
	<20180501142222.19154-2-kbastian@mail.uni-paderborn.de>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180501142222.19154-2-kbastian@mail.uni-paderborn.de>
Date: Fri, 25 May 2018 17:14:23 +0100
Message-ID: <87muwnsof4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 01/12] hw/tricore: Add testdevice for
 tests in tests/tcg/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: qemu-devel@nongnu.org


Bastian Koppelmann <kbastian@mail.uni-paderborn.de> writes:

> this device is used to verify the correctness of regression tests by
> allowing guests to write their exit status to this device. This is then
> used by qemu to exit using the written status.

My initial thoughts are this replicates the functionality of
virtio-console for chr-testdev used by kvm-unit-tests
(chardev/testdev.c). But on closer inspection it seems this is a
per-arch thing anyway.

>
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  hw/tricore/Makefile.objs                |  1 +
>  hw/tricore/tricore_testboard.c          |  8 ++++
>  hw/tricore/tricore_testdevice.c         | 81 +++++++++++++++++++++++++++=
++++++
>  include/hw/tricore/tricore_testdevice.h | 38 ++++++++++++++++
>  4 files changed, 128 insertions(+)
>  create mode 100644 hw/tricore/tricore_testdevice.c
>  create mode 100644 include/hw/tricore/tricore_testdevice.h
>
> diff --git a/hw/tricore/Makefile.objs b/hw/tricore/Makefile.objs
> index 435e095cff..9e871a01e2 100644
> --- a/hw/tricore/Makefile.objs
> +++ b/hw/tricore/Makefile.objs
> @@ -1 +1,2 @@
>  obj-y +=3D tricore_testboard.o
> +obj-y +=3D tricore_testdevice.o
> diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboar=
d.c
> index 8e61dfc3e6..ee0a332e12 100644
> --- a/hw/tricore/tricore_testboard.c
> +++ b/hw/tricore/tricore_testboard.c
> @@ -31,6 +31,7 @@
>  #include "exec/address-spaces.h"
>  #include "elf.h"
>  #include "hw/tricore/tricore.h"
> +#include "hw/tricore/tricore_testdevice.h"
>  #include "qemu/error-report.h"
>
>
> @@ -60,6 +61,7 @@ static void tricore_testboard_init(MachineState *machin=
e, int board_id)
>  {
>      TriCoreCPU *cpu;
>      CPUTriCoreState *env;
> +    TriCoreTestDeviceState *test_dev;
>
>      MemoryRegion *sysmem =3D get_system_memory();
>      MemoryRegion *ext_cram =3D g_new(MemoryRegion, 1);
> @@ -91,6 +93,12 @@ static void tricore_testboard_init(MachineState *machi=
ne, int board_id)
>      memory_region_add_subregion(sysmem, 0xf0050000, pcp_data);
>      memory_region_add_subregion(sysmem, 0xf0060000, pcp_text);
>
> +    /* test device */
> +    test_dev =3D g_new(TriCoreTestDeviceState, 1);
> +    object_initialize(test_dev, sizeof(TriCoreTestDeviceState),
> +                      TYPE_TRICORE_TESTDEVICE);
> +    memory_region_add_subregion(sysmem, 0xf0000000, &test_dev->iomem);
> +
>      tricoretb_binfo.ram_size =3D machine->ram_size;
>      tricoretb_binfo.kernel_filename =3D machine->kernel_filename;
>
> diff --git a/hw/tricore/tricore_testdevice.c b/hw/tricore/tricore_testdev=
ice.c
> new file mode 100644
> index 0000000000..ce4c67fcae
> --- /dev/null
> +++ b/hw/tricore/tricore_testdevice.c
> @@ -0,0 +1,81 @@
> +/*
> + *  Copyright (c) 2018 Bastian Koppelmann Paderborn University
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/sysbus.h"
> +#include "hw/tricore/tricore_testdevice.h"
> +
> +static void tricore_testdevice_write(void *opaque, hwaddr offset,
> +                                      uint64_t value, unsigned size)
> +{
> +    exit(value);
> +}
> +
> +static uint64_t tricore_testdevice_read(void *opaque, hwaddr offset,
> +                                         unsigned size)
> +{
> +    return 0xdeadbeef;
> +}
> +
> +static void tricore_testdevice_reset(DeviceState *dev)
> +{
> +}
> +
> +static const MemoryRegionOps tricore_testdevice_ops =3D {
> +    .read =3D tricore_testdevice_read,
> +    .write =3D tricore_testdevice_write,
> +    .valid =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +    },
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +};
> +
> +static void tricore_testdevice_init(Object *obj)
> +{
> +    TriCoreTestDeviceState *s =3D TRICORE_TESTDEVICE(obj);
> +   /* map memory */
> +    memory_region_init_io(&s->iomem, OBJECT(s), &tricore_testdevice_ops,=
 s,
> +                          "tricore_testdevice", 0x4);
> +}
> +
> +static Property tricore_testdevice_properties[] =3D {
> +    DEFINE_PROP_END_OF_LIST()
> +};
> +
> +static void tricore_testdevice_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->props =3D tricore_testdevice_properties;
> +    dc->reset =3D tricore_testdevice_reset;
> +}
> +
> +static const TypeInfo tricore_testdevice_info =3D {
> +    .name          =3D TYPE_TRICORE_TESTDEVICE,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(TriCoreTestDeviceState),
> +    .instance_init =3D tricore_testdevice_init,
> +    .class_init    =3D tricore_testdevice_class_init,
> +};
> +
> +static void tricore_testdevice_register_types(void)
> +{
> +    type_register_static(&tricore_testdevice_info);
> +}
> +
> +type_init(tricore_testdevice_register_types)
> diff --git a/include/hw/tricore/tricore_testdevice.h b/include/hw/tricore=
/tricore_testdevice.h
> new file mode 100644
> index 0000000000..5b2df219e3
> --- /dev/null
> +++ b/include/hw/tricore/tricore_testdevice.h
> @@ -0,0 +1,38 @@
> +/*
> + *  Copyright (c) 2018  Bastian Koppelmann Paderborn University
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
> + */
> +
> +
> +#ifndef HW_TRICORE_TESTDEV_H
> +#define HW_TRICORE_TESTDEV_H
> +
> +#include "hw/sysbus.h"
> +#include "hw/hw.h"
> +
> +#define TYPE_TRICORE_TESTDEVICE "tricore_testdevice"
> +#define TRICORE_TESTDEVICE(obj) \
> +    OBJECT_CHECK(TriCoreTestDeviceState, (obj), TYPE_TRICORE_TESTDEVICE)
> +
> +typedef struct {
> +    /* <private> */
> +    SysBusDevice parent_obj;
> +
> +    /* <public> */
> +    MemoryRegion iomem;
> +
> +} TriCoreTestDeviceState;
> +
> +#endif


--
Alex Benn=C3=A9e
