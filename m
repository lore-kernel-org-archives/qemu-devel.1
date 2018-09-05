Received: from eggs.gnu.org ([2001:4830:134:3::10]:59680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fxLQh-0004qP-Oz
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 20:12:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fxLQg-0000kc-GT
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 20:12:19 -0400
MIME-Version: 1.0
In-Reply-To: <20180820120213.11095-4-e.emanuelegiuseppe@gmail.com>
References: <20180820120213.11095-1-e.emanuelegiuseppe@gmail.com>
	<20180820120213.11095-4-e.emanuelegiuseppe@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Sep 2018 17:11:45 -0700
Message-ID: <CAKmqyKO=rPvz=fcgzrSVwjkAOLX1E7ZoYKOYnY-bOJEczVU-bA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 03/16] test/qgraph: arm/xlinx-zynq-a9
 machine node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Qemu-block <qemu-block@nongnu.org>, Amit Shah <amit@kernel.org>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, Greg Kurz <groug@kaod.org>, Keith Busch <keith.busch@intel.com>, "open list:New World" <qemu-ppc@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Mon, Aug 20, 2018 at 5:02 AM, Emanuele Giuseppe Esposito
<e.emanuelegiuseppe@gmail.com> wrote:
> Add xlinx-zynq-a9 machine to the graph. This machine contains generic-sdhci, so
> its constructor must take care of setting it properly when called.
>
> Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/Makefile.include                |  1 +
>  tests/libqos/xilinx-zynq-a9-machine.c | 84 +++++++++++++++++++++++++++
>  tests/sdhci-test.c                    |  8 +--
>  3 files changed, 89 insertions(+), 4 deletions(-)
>  create mode 100644 tests/libqos/xilinx-zynq-a9-machine.c
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 4690d5f5e9..d559218b1c 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -760,6 +760,7 @@ libqgraph-arm-machines-obj-y = tests/libqos/raspi2-machine.o
>  libqgraph-arm-machines-obj-y += tests/libqos/virt-machine.o
>  libqgraph-arm-machines-obj-y += tests/libqos/smdkc210-machine.o
>  libqgraph-arm-machines-obj-y += tests/libqos/sabrelite-machine.o
> +libqgraph-arm-machines-obj-y += tests/libqos/xilinx-zynq-a9-machine.o
>
>  libqgraph-machines-obj-y = $(libqgraph-arm-machines-obj-y)
>  libqgraph-machines-obj-y += tests/libqos/x86_64_pc-machine.o
> diff --git a/tests/libqos/xilinx-zynq-a9-machine.c b/tests/libqos/xilinx-zynq-a9-machine.c
> new file mode 100644
> index 0000000000..025cd80eb2
> --- /dev/null
> +++ b/tests/libqos/xilinx-zynq-a9-machine.c
> @@ -0,0 +1,84 @@
> +/*
> + * libqos driver framework
> + *
> + * Copyright (c) 2018 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License version 2 as published by the Free Software Foundation.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "libqos/malloc.h"
> +#include "libqos/qgraph.h"
> +#include "sdhci.h"
> +
> +typedef struct QXilinx_zynq_a9Machine QXilinx_zynq_a9Machine;
> +
> +struct QXilinx_zynq_a9Machine {
> +    QOSGraphObject obj;
> +    QGuestAllocator *alloc;
> +    QSDHCI_MemoryMapped sdhci;
> +};
> +
> +static void xilinx_zynq_a9_destructor(QOSGraphObject *obj)
> +{
> +    g_free(obj);
> +}
> +
> +static void *xilinx_zynq_a9_get_driver(void *object, const char *interface)
> +{
> +    QXilinx_zynq_a9Machine *machine = object;
> +    if (!g_strcmp0(interface, "memory")) {
> +        return &machine->alloc;
> +    }
> +
> +    fprintf(stderr, "%s not present in arm/xilinx-zynq-a9\n", interface);
> +    g_assert_not_reached();
> +}
> +
> +static QOSGraphObject *xilinx_zynq_a9_get_device(void *obj, const char *device)
> +{
> +    QXilinx_zynq_a9Machine *machine = obj;
> +    if (!g_strcmp0(device, "generic-sdhci")) {
> +        return &machine->sdhci.obj;
> +    }
> +
> +    fprintf(stderr, "%s not present in arm/xilinx-zynq-a9\n", device);
> +    g_assert_not_reached();
> +}
> +
> +static void *qos_create_machine_arm_xilinx_zynq_a9(void)
> +{
> +    QXilinx_zynq_a9Machine *machine = g_new0(QXilinx_zynq_a9Machine, 1);
> +
> +    machine->obj.get_device = xilinx_zynq_a9_get_device;
> +    machine->obj.get_driver = xilinx_zynq_a9_get_driver;
> +    machine->obj.destructor = xilinx_zynq_a9_destructor;
> +    /* Datasheet: UG585 (v1.12.1) */
> +    qos_init_sdhci_smm(&machine->sdhci, 0xe0100000, &(QSDHCIProperties) {
> +        .version = 2,
> +        .baseclock = 0,
> +        .capab.sdma = true,
> +        .capab.reg = 0x69ec0080,
> +    });
> +    return &machine->obj;
> +}
> +
> +static void xilinx_zynq_a9_register_nodes(void)
> +{
> +    qos_node_create_machine("arm/xilinx-zynq-a9",
> +                            qos_create_machine_arm_xilinx_zynq_a9);
> +    qos_node_contains("arm/xilinx-zynq-a9", "generic-sdhci", NULL);
> +}
> +
> +libqos_init(xilinx_zynq_a9_register_nodes);
> diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
> index 31ecc06159..0a8efd8554 100644
> --- a/tests/sdhci-test.c
> +++ b/tests/sdhci-test.c
> @@ -60,14 +60,14 @@ FIELD(SDHC_CAPAB, DRIVER,                   36, 3); /* since v3 */
>          { "arm",    "sabrelite",
>              {0x02190000, 3, 0,  {1, 0x057834b4} } },
>
> - *
> - * FIXME: the following drivers are missing:
> - *
> -
>      Zynq-7000
>          { "arm",    "xilinx-zynq-a9",   Datasheet: UG585 (v1.12.1)
>              {0xe0100000, 2, 0,  {1, 0x69ec0080} } },
>
> + *
> + * FIXME: the following drivers are missing:
> + *
> +
>      ZynqMP
>          { "aarch64", "xlnx-zcu102",     Datasheet: UG1085 (v1.7)
>              {0xff160000, 3, 0,  {1, 0x280737ec6481} } },
> --
> 2.17.1
>
>
