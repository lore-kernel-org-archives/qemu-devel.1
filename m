Received: from eggs.gnu.org ([2001:4830:134:3::10]:32845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fxLT7-0008B2-HO
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 20:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fxLT6-000312-2y
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 20:14:49 -0400
MIME-Version: 1.0
In-Reply-To: <20180820120213.11095-5-e.emanuelegiuseppe@gmail.com>
References: <20180820120213.11095-1-e.emanuelegiuseppe@gmail.com>
	<20180820120213.11095-5-e.emanuelegiuseppe@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Sep 2018 17:14:09 -0700
Message-ID: <CAKmqyKNgXntW8yHewetCDj-S-uiiVN+XV0dmNKV2=bUiCC=kzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 04/16] test/qgraph: aarch64/xlnx-zcu102
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
> Add xlnx-zcu102 machine to the graph. This machine contains generic-sdhci, so
> its constructor must take care of setting it properly when called.
>
> Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/Makefile.include             |  1 +
>  tests/libqos/xlnx-zcu102-machine.c | 83 ++++++++++++++++++++++++++++++
>  tests/sdhci-test.c                 | 51 ------------------
>  3 files changed, 84 insertions(+), 51 deletions(-)
>  create mode 100644 tests/libqos/xlnx-zcu102-machine.c
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index d559218b1c..bad4de3d61 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -765,6 +765,7 @@ libqgraph-arm-machines-obj-y += tests/libqos/xilinx-zynq-a9-machine.o
>  libqgraph-machines-obj-y = $(libqgraph-arm-machines-obj-y)
>  libqgraph-machines-obj-y += tests/libqos/x86_64_pc-machine.o
>  libqgraph-machines-obj-y += tests/libqos/ppc64_pseries-machine.o
> +libqgraph-machines-obj-y += tests/libqos/xlnx-zcu102-machine.o
>
>  libqgraph-virtio-obj-y = tests/libqos/virtio-serial.o
>  libqgraph-virtio-obj-y += tests/libqos/virtio-9p.o
> diff --git a/tests/libqos/xlnx-zcu102-machine.c b/tests/libqos/xlnx-zcu102-machine.c
> new file mode 100644
> index 0000000000..9932cf39a8
> --- /dev/null
> +++ b/tests/libqos/xlnx-zcu102-machine.c
> @@ -0,0 +1,83 @@
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
> +typedef struct QXlnx_zcu102Machine QXlnx_zcu102Machine;
> +
> +struct QXlnx_zcu102Machine {
> +    QOSGraphObject obj;
> +    QGuestAllocator *alloc;
> +    QSDHCI_MemoryMapped sdhci;
> +};
> +
> +static void xlnx_zcu102_destructor(QOSGraphObject *obj)
> +{
> +    g_free(obj);
> +}
> +
> +static void *xlnx_zcu102_get_driver(void *object, const char *interface)
> +{
> +    QXlnx_zcu102Machine *machine = object;
> +    if (!g_strcmp0(interface, "memory")) {
> +        return &machine->alloc;
> +    }
> +
> +    fprintf(stderr, "%s not present in aarch64/xlnx-zcu102\n", interface);
> +    g_assert_not_reached();
> +}
> +
> +static QOSGraphObject *xlnx_zcu102_get_device(void *obj, const char *device)
> +{
> +    QXlnx_zcu102Machine *machine = obj;
> +    if (!g_strcmp0(device, "generic-sdhci")) {
> +        return &machine->sdhci.obj;
> +    }
> +
> +    fprintf(stderr, "%s not present in aarch64/xlnx-zcu102\n", device);
> +    g_assert_not_reached();
> +}
> +
> +static void *qos_create_machine_aarch64_xlnx_zcu102(void)
> +{
> +    QXlnx_zcu102Machine *machine = g_new0(QXlnx_zcu102Machine, 1);
> +
> +    machine->obj.get_device = xlnx_zcu102_get_device;
> +    machine->obj.get_driver = xlnx_zcu102_get_driver;
> +    machine->obj.destructor = xlnx_zcu102_destructor;
> +    /* Datasheet: UG1085 (v1.7) */
> +    qos_init_sdhci_smm(&machine->sdhci, 0xff160000, &(QSDHCIProperties) {
> +        .version = 3,
> +        .baseclock = 0,
> +        .capab.sdma = true,
> +        .capab.reg = 0x280737ec6481
> +    });
> +    return &machine->obj;
> +}
> +
> +static void xlnx_zcu102_register_nodes(void)
> +{
> +    qos_node_create_machine("aarch64/xlnx-zcu102", qos_create_machine_aarch64_xlnx_zcu102);
> +    qos_node_contains("aarch64/xlnx-zcu102", "generic-sdhci", NULL);
> +}
> +
> +libqos_init(xlnx_zcu102_register_nodes);
> diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
> index 0a8efd8554..deb42be493 100644
> --- a/tests/sdhci-test.c
> +++ b/tests/sdhci-test.c
> @@ -22,57 +22,6 @@ FIELD(SDHC_CAPAB, SDR,                      32, 3); /* since v3 */
>  FIELD(SDHC_CAPAB, DRIVER,                   36, 3); /* since v3 */
>  #define SDHC_HCVER                      0xFE
>
> -/**
> - * Old sdhci_t structure:
> - *
> -    struct sdhci_t {
> -        const char *arch, *machine;
> -        struct {
> -            uintptr_t addr;
> -            uint8_t version;
> -            uint8_t baseclock;
> -            struct {
> -                bool sdma;
> -                uint64_t reg;
> -            } capab;
> -        } sdhci;
> -        struct {
> -            uint16_t vendor_id, device_id;
> -        } pci;
> -    }
> - *
> - * implemented drivers:
> - *
> -    PC via PCI
> -        { "x86_64", "pc",
> -            {-1,         2, 0,  {1, 0x057834b4} },
> -            .pci = { PCI_VENDOR_ID_REDHAT, PCI_DEVICE_ID_REDHAT_SDHCI } },
> -
> -    BCM2835
> -        { "arm",    "raspi2",
> -            {0x3f300000, 3, 52, {0, 0x052134b4} } },
> -
> -    Exynos4210
> -        { "arm",    "smdkc210",
> -            {0x12510000, 2, 0,  {1, 0x5e80080} } },
> -
> -    i.MX 6
> -        { "arm",    "sabrelite",
> -            {0x02190000, 3, 0,  {1, 0x057834b4} } },
> -
> -    Zynq-7000
> -        { "arm",    "xilinx-zynq-a9",   Datasheet: UG585 (v1.12.1)
> -            {0xe0100000, 2, 0,  {1, 0x69ec0080} } },
> -
> - *
> - * FIXME: the following drivers are missing:
> - *
> -
> -    ZynqMP
> -        { "aarch64", "xlnx-zcu102",     Datasheet: UG1085 (v1.7)
> -            {0xff160000, 3, 0,  {1, 0x280737ec6481} } },
> - */
> -
>  static void check_specs_version(QSDHCI *s, uint8_t version)
>  {
>      uint32_t v;
> --
> 2.17.1
>
>
