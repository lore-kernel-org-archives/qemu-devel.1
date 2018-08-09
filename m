Received: from eggs.gnu.org ([2001:4830:134:3::10]:37068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnhty-0006Ag-3C
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 06:10:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnhts-0005PJ-D1
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 06:10:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59832 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1fnhts-0005Om-0y
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 06:10:36 -0400
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
	<20180806143412.27722-6-e.emanuelegiuseppe@gmail.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <f5a3c33f-f459-806c-1465-3b5415a5ccc1@redhat.com>
Date: Thu, 9 Aug 2018 12:10:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180806143412.27722-6-e.emanuelegiuseppe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 05/34] tests/qgraph: sdhci driver and
 interface nodes
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
> Add qgraph nodes for sdhci-pci and generic-sdhci (memory mapped) drivers.
> Both drivers implement (produce) the same interface sdhci, that provides the
> readw - readq - writeq functions.
> 
> Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> ---
>  tests/Makefile.include |   1 +
>  tests/libqos/sdhci.c   | 163 +++++++++++++++++++++++++++++++++++++++++
>  tests/libqos/sdhci.h   |  69 +++++++++++++++++
>  3 files changed, 233 insertions(+)
>  create mode 100644 tests/libqos/sdhci.c
>  create mode 100644 tests/libqos/sdhci.h
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 4e7b4bb614..be00fb71ec 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -775,6 +775,7 @@ libqgraph-machines-obj-y = tests/libqos/x86_64_pc-machine.o
>  
>  libqgraph-pci-obj-y = $(libqos-pc-obj-y)
>  libqgraph-pci-obj-y += $(libqgraph-machines-obj-y)
> +libqgraph-pci-obj-y += tests/libqos/sdhci.o

The file also implements memory mapped SDHCI, should we split the file
in two files, one added to libqgraph-pci-obj-y and the other to
check-qtest-arm-y and check-qtest-aarch64-y?

>  check-unit-y += tests/test-qgraph$(EXESUF)
>  tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
> diff --git a/tests/libqos/sdhci.c b/tests/libqos/sdhci.c
> new file mode 100644
> index 0000000000..f5eb2c5459
> --- /dev/null
> +++ b/tests/libqos/sdhci.c
> @@ -0,0 +1,163 @@
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
> +#include "pci.h"
> +#include "sdhci.h"
> +#include "hw/pci/pci.h"
> +
> +static void set_qsdhci_fields(QSDHCI *s, uint8_t version, uint8_t baseclock,
> +                              bool sdma, uint64_t reg)
> +{
> +    s->props.version = version;
> +    s->props.baseclock = baseclock;
> +    s->props.capab.sdma = sdma;
> +    s->props.capab.reg = reg;
> +}
> +
...
> +static void sdhci_mm_writeq(QSDHCI *s, uint32_t reg, uint64_t val)
> +{
> +    QSDHCI_MemoryMapped *smm = container_of(s, QSDHCI_MemoryMapped, sdhci);
> +    qtest_writeq(global_qtest, smm->addr + reg, val);
> +}
> +
> +static void *sdhci_mm_get_driver(void *obj, const char *interface)
> +{
> +    QSDHCI_MemoryMapped *spci = obj;

You should call it "smm" rather than "spci"

> +    if (!g_strcmp0(interface, "sdhci")) {
> +        return &spci->sdhci;
> +    }
> +    printf("%s not present in generic-sdhci\n", interface);

fprintf(stderr, ....

> +    abort();

g_assert_not_reached()

> +}
> +
> +void qos_init_sdhci_mm(QSDHCI_MemoryMapped *sdhci, uint32_t addr,

To be consistent with previous functions, you should it "smm" rather
than "sdhci".

...
> +/* PCI implementation of QSDHCI */
...
> +
> +static uint64_t sdhci_readq(QSDHCI *s, uint32_t reg)

"sdhci_pci_readq()"

> +{
> +    QSDHCI_PCI *spci = container_of(s, QSDHCI_PCI, sdhci);
> +    return qpci_io_readq(&spci->dev, spci->mem_bar, reg);
> +}
> +
> +static void sdhci_writeq(QSDHCI *s, uint32_t reg, uint64_t val)

"sdhci_pci_writeq()"

> +{
> +    QSDHCI_PCI *spci = container_of(s, QSDHCI_PCI, sdhci);
> +    return qpci_io_writeq(&spci->dev, spci->mem_bar, reg, val);
> +}
> +
> +static void *sdhci_pci_get_driver(void *object, const char *interface)
> +{
> +    QSDHCI_PCI *spci = object;
> +    if (!g_strcmp0(interface, "sdhci")) {
> +        return &spci->sdhci;
> +    }
> +
> +    printf("%s not present in sdhci-pci\n", interface);

fprintf(stderr, ...

> +    abort();

g_assert_not_reached()

> +}
> +
> +static void sdhci_start_hw(QOSGraphObject *obj)

perhaps you can call this "sdhci_pci_start_hw()"?

> +{
> +    QSDHCI_PCI *spci = (QSDHCI_PCI *)obj;
> +    qpci_device_enable(&spci->dev);
> +}
> +
> +static void sdhci_destroy(QOSGraphObject *obj)

"sdhci_pci_destructor()"?

> +{
> +    QSDHCI_PCI *spci = (QSDHCI_PCI *)obj;
> +    qpci_iounmap(&spci->dev, spci->mem_bar);
> +    g_free(spci);
> +}
> +
> +static void *sdhci_pci_create(void *pci_bus, QGuestAllocator *alloc, void *addr)
> +{
> +    QSDHCI_PCI *spci = g_new0(QSDHCI_PCI, 1);
> +    QPCIBus *bus = pci_bus;
> +    uint64_t barsize;
> +
> +    qpci_device_init(&spci->dev, bus, addr);
> +    spci->mem_bar = qpci_iomap(&spci->dev, 0, &barsize);
> +    spci->sdhci.readw = sdhci_pci_readw;
> +    spci->sdhci.readq = sdhci_readq;

 ... = sdhci_pci_readq;

> +    spci->sdhci.writeq = sdhci_writeq;

 ... = sdhci_pci_writeq;

> +    set_qsdhci_fields(&spci->sdhci, 2, 0, 1, 0x057834b4);
> +
> +    spci->obj.get_driver = sdhci_pci_get_driver;
> +    spci->obj.start_hw = sdhci_start_hw;
> +    spci->obj.destructor = sdhci_destroy;
> +    return &spci->obj;
> +}
> +
> +static void qsdhci(void)
> +{
> +    QPCIAddress addr = {
> +        .devfn = QPCI_DEVFN(4, 0),
> +        .vendor_id = PCI_VENDOR_ID_REDHAT,
> +        .device_id = PCI_DEVICE_ID_REDHAT_SDHCI,
> +    };
> +
> +    QOSGraphEdgeOptions opts = {
> +        .extra_device_opts = "addr=04.0",
> +    };
> +
> +    /* generic-sdhci */
> +    qos_node_create_driver("generic-sdhci", NULL);
> +    qos_node_produces("generic-sdhci", "sdhci");
> +
> +    /* sdhci-pci */
> +    add_qpci_address(&opts, &addr);
> +    qos_node_create_driver("sdhci-pci", sdhci_pci_create);
> +    qos_node_produces("sdhci-pci", "sdhci");
> +    qos_node_consumes("sdhci-pci", "pci-bus", &opts);
> +
> +}
> +
> +libqos_init(qsdhci);

Perhaps we can have two functions qsdhci_mm_register_nodes() and
qsdhci_pci_register_nodes(), with two libqos_init() and split the file
in two files sdhci_pci.c and sdhci_mm.c?

Thanks,
Laurent
