Received: from eggs.gnu.org ([2001:4830:134:3::10]:52364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnU6w-0003Vu-P1
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 15:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnU6r-0003SN-Pu
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 15:27:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38138 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1fnU6r-0003Ri-Ji
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 15:27:05 -0400
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
	<20180806143412.27722-5-e.emanuelegiuseppe@gmail.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <5bffcae7-6e0e-f07e-144f-46e2e504f7d6@redhat.com>
Date: Wed, 8 Aug 2018 21:27:02 +0200
MIME-Version: 1.0
In-Reply-To: <20180806143412.27722-5-e.emanuelegiuseppe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 04/34] tests/qgraph: x86_64/pc machine
 node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>

On 06/08/2018 16:33, Emanuele Giuseppe Esposito wrote:
> Add pc machine for the x86_64 QEMU binary. This machine contains an i440FX-pcihost
> driver, that contains itself a pci-bus-pc that produces the pci-bus interface.
> 
> Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> ---
>  tests/Makefile.include           |   3 +
>  tests/libqos/x86_64_pc-machine.c | 110 +++++++++++++++++++++++++++++++
>  2 files changed, 113 insertions(+)
>  create mode 100644 tests/libqos/x86_64_pc-machine.c
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index f04f9fbc3a..4e7b4bb614 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -771,7 +771,10 @@ libqos-imx-obj-y = $(libqos-obj-y) tests/libqos/i2c-imx.o
>  libqos-usb-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/usb.o
>  libqos-virtio-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/virtio.o tests/libqos/virtio-pci.o tests/libqos/virtio-mmio.o tests/libqos/malloc-generic.o
>  
> +libqgraph-machines-obj-y = tests/libqos/x86_64_pc-machine.o
> +
>  libqgraph-pci-obj-y = $(libqos-pc-obj-y)
> +libqgraph-pci-obj-y += $(libqgraph-machines-obj-y)
>  
>  check-unit-y += tests/test-qgraph$(EXESUF)
>  tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
> diff --git a/tests/libqos/x86_64_pc-machine.c b/tests/libqos/x86_64_pc-machine.c
> new file mode 100644
> index 0000000000..e3eddf2eba
> --- /dev/null
> +++ b/tests/libqos/x86_64_pc-machine.c
> @@ -0,0 +1,110 @@
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
> +#include "libqos/qgraph.h"
> +#include "pci-pc.h"
> +#include "malloc-pc.h"
> +
> +typedef struct QX86_64_PCMachine QX86_64_PCMachine;
> +typedef struct i440FX_pcihost i440FX_pcihost;
> +typedef struct QSDHCI_PCI  QSDHCI_PCI;
> +
> +struct i440FX_pcihost {
> +    QOSGraphObject obj;
> +    QPCIBusPC pci;
> +};
> +
> +struct QX86_64_PCMachine {
> +    QOSGraphObject obj;
> +    QGuestAllocator *alloc;
> +    i440FX_pcihost bridge;
> +};
> +
> +/* i440FX_pcihost */
> +
> +static QOSGraphObject *i440FX_host_get_device(void *obj, const char *device)
> +{
> +    i440FX_pcihost *host = obj;
> +    if (!g_strcmp0(device, "pci-bus-pc")) {
> +        return &host->pci.obj;
> +    }
> +    printf("%s not present in i440FX-pcihost\n", device);

fprintf(stderr, ...

> +    abort();

g_assert_not_reached()

> +}
> +
> +static void qos_create_i440FX_host(i440FX_pcihost *host,
> +                                   QGuestAllocator *alloc)
> +{
> +    host->obj.get_device = i440FX_host_get_device;
> +    qpci_init_pc(&host->pci, global_qtest, alloc);
> +}
> +
> +/* x86_64/pc machine */
> +
> +static void pc_destroy(QOSGraphObject *obj)
> +{
> +    QX86_64_PCMachine *machine = (QX86_64_PCMachine *) obj;
> +    pc_alloc_uninit(machine->alloc);
> +    g_free(machine);
> +}
> +
> +static void *pc_get_driver(void *object, const char *interface)
> +{
> +    QX86_64_PCMachine *machine = object;
> +    if (!g_strcmp0(interface, "guest_allocator")) {

Perhaps we can call that "memory"  rather than "guest_allocator", as it
gives access to the memory of the guest?

> +        return machine->alloc;
> +    }
> +
> +    printf("%s not present in x86_64/pc\n", interface);

fprintf(stderr, ...

> +    abort();

g_assert_not_reached()

> +}
> +
> +static QOSGraphObject *pc_get_device(void *obj, const char *device)
> +{
> +    QX86_64_PCMachine *machine = obj;
> +    if (!g_strcmp0(device, "i440FX-pcihost")) {
> +        return &machine->bridge.obj;
> +    }
> +
> +    printf("%s not present in x86_64/pc\n", device);

fprintf(stderr, ...

> +    abort();

g_assert_not_reached()

> +}
> +
> +static void *qos_create_machine_pc(void)
> +{
> +    QX86_64_PCMachine *machine = g_new0(QX86_64_PCMachine, 1);
> +    machine->obj.get_device = pc_get_device;
> +    machine->obj.get_driver = pc_get_driver;
> +    machine->obj.destructor = pc_destroy;
> +    machine->alloc = pc_alloc_init_flags(global_qtest, ALLOC_NO_FLAGS);
> +    qos_create_i440FX_host(&machine->bridge, machine->alloc);
> +
> +    return &machine->obj;
> +}
> +
> +static void pc_machine(void)
> +{
> +    qos_node_create_machine("x86_64/pc", qos_create_machine_pc);
> +    qos_node_create_driver("i440FX-pcihost", NULL);
> +    qos_node_contains("x86_64/pc", "i440FX-pcihost", NULL);
> +    qos_node_contains("i440FX-pcihost", "pci-bus-pc", NULL);

and qos_node_produces("x86_64/pc", "memory");  (or "guest_allocator")?

and perhaps later, a qos_add_test("test-memory-allocator", "memory",
test_memory_allocator, NULL)?

> +}
> +
> +libqos_init(pc_machine);

pc_machine_register_nodes?

Thanks,
Laurent
