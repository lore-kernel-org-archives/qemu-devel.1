Received: from eggs.gnu.org ([2001:4830:134:3::10]:56476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnSRE-0008SP-7A
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 13:40:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnSR9-0002HO-9c
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 13:40:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47654 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1fnSR9-0002HG-2R
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 13:39:55 -0400
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
	<20180806143412.27722-4-e.emanuelegiuseppe@gmail.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <938f8b05-a687-8595-5452-8ec5abf7414c@redhat.com>
Date: Wed, 8 Aug 2018 19:39:51 +0200
MIME-Version: 1.0
In-Reply-To: <20180806143412.27722-4-e.emanuelegiuseppe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 03/34] tests/qgraph: pci-pc driver and
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
> Add pci-bus-pc node, move QPCIBusPC struct declaration in its header
> (since it will be needed by other drivers) and introduce a setter method
> for drivers that do not need to allocate but have to initialize QPCIBusPC.
> 
> Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> ---
>  tests/Makefile.include |  4 +++-
>  tests/libqos/pci-pc.c  | 41 +++++++++++++++++++++++++++++-------
>  tests/libqos/pci-pc.h  | 15 ++++++++++++-
>  tests/libqos/pci.c     | 48 +++++++++++++++++++++++++++++++++++++++---
>  tests/libqos/pci.h     | 15 +++++++++++++
>  5 files changed, 110 insertions(+), 13 deletions(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index eabf9ed8b4..f04f9fbc3a 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -771,11 +771,13 @@ libqos-imx-obj-y = $(libqos-obj-y) tests/libqos/i2c-imx.o
>  libqos-usb-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/usb.o
>  libqos-virtio-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/virtio.o tests/libqos/virtio-pci.o tests/libqos/virtio-mmio.o tests/libqos/malloc-generic.o
>  
> +libqgraph-pci-obj-y = $(libqos-pc-obj-y)
> +
>  check-unit-y += tests/test-qgraph$(EXESUF)
>  tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
>  
>  check-qtest-pci-y += tests/qos-test$(EXESUF)
> -tests/qos-test$(EXESUF): tests/qos-test.o $(libqgraph-obj-y)
> +tests/qos-test$(EXESUF): tests/qos-test.o $(libqgraph-pci-obj-y)
>  
>  tests/qmp-test$(EXESUF): tests/qmp-test.o
>  tests/device-introspect-test$(EXESUF): tests/device-introspect-test.o
> diff --git a/tests/libqos/pci-pc.c b/tests/libqos/pci-pc.c
> index 83a3a32129..f5fb94eabc 100644
> --- a/tests/libqos/pci-pc.c
> +++ b/tests/libqos/pci-pc.c
> @@ -18,15 +18,9 @@
>  
>  #include "qemu-common.h"
>  
> -
>  #define ACPI_PCIHP_ADDR         0xae00
>  #define PCI_EJ_BASE             0x0008
>  
> -typedef struct QPCIBusPC
> -{
> -    QPCIBus bus;
> -} QPCIBusPC;
> -
>  static uint8_t qpci_pc_pio_readb(QPCIBus *bus, uint32_t addr)
>  {
>      return inb(addr);
> @@ -115,12 +109,23 @@ static void qpci_pc_config_writel(QPCIBus *bus, int devfn, uint8_t offset, uint3
>      outl(0xcfc, value);
>  }
>  
> -QPCIBus *qpci_pc_new(QTestState *qts, QGuestAllocator *alloc)
> +static void *qpci_get_driver(void *obj, const char *interface)
>  {
> -    QPCIBusPC *ret = g_new0(QPCIBusPC, 1);
> +    QPCIBusPC *qpci = obj;
> +    if (!g_strcmp0(interface, "pci-bus")) {
> +        return &qpci->bus;
> +    }
> +    printf("%s not present in pci-bus-pc\n", interface);

fprintf(stderr, ...) ?

> +    abort();

You should use g_assert_not_reached().

> +}
>  
> +void qpci_init_pc(QPCIBusPC *ret, QTestState *qts, QGuestAllocator *alloc)
> +{
>      assert(qts);
>  
> +    /* tests can use pci-bus */
> +    ret->bus.has_buggy_msi = FALSE;

I think you should introduce the field has_buggy_msi when it will be
really needed: with patch 09/34 adn pci-spapr.

> +
>      ret->bus.pio_readb = qpci_pc_pio_readb;
>      ret->bus.pio_readw = qpci_pc_pio_readw;
>      ret->bus.pio_readl = qpci_pc_pio_readl;
> @@ -147,11 +152,23 @@ QPCIBus *qpci_pc_new(QTestState *qts, QGuestAllocator *alloc)
>      ret->bus.mmio_alloc_ptr = 0xE0000000;
>      ret->bus.mmio_limit = 0x100000000ULL;
>  
> +    ret->obj.get_driver = qpci_get_driver;
> +}
> +
> +QPCIBus *qpci_pc_new(QTestState *qts, QGuestAllocator *alloc)

As I said for 02/34, I think qpci_new_pc() should be a better name to
like the one we have for qpci_free_pc().

> +{
> +    QPCIBusPC *ret = g_new0(QPCIBusPC, 1);

perhaps you can rename "ret" to "qpci"?

> +    qpci_init_pc(ret, qts, alloc);
> +
>      return &ret->bus;
>  }
>  
>  void qpci_free_pc(QPCIBus *bus)
>  {
> +    if (!bus) {
> +        return;
> +    }
> +
>      QPCIBusPC *s = container_of(bus, QPCIBusPC, bus);

Generally, gcc doesn't like to mix declarations and instructions. I
think something like this would be nicer:

    QPCIBusPC *s;

    if (!bus) {
        return;
    }
    s = container_of(bus, QPCIBusPC, bus);

>  
>      g_free(s);
> @@ -176,3 +193,11 @@ void qpci_unplug_acpi_device_test(const char *id, uint8_t slot)
>  
>      qmp_eventwait("DEVICE_DELETED");
>  }
> +
> +static void qpci_pc(void)

This name is not very clear, for the qemu part, type_init() is generally
used with XXX_register_types name.

Perhaps you can use something like "qpci_pc_register_nodes" name?

> +{
> +    qos_node_create_driver("pci-bus-pc", NULL);
> +    qos_node_produces("pci-bus-pc", "pci-bus");
> +}
> +
> +libqos_init(qpci_pc);
> diff --git a/tests/libqos/pci-pc.h b/tests/libqos/pci-pc.h
> index 88be29eaf3..a3754c1c86 100644
> --- a/tests/libqos/pci-pc.h
> +++ b/tests/libqos/pci-pc.h
> @@ -15,9 +15,22 @@
>  
>  #include "libqos/pci.h"
>  #include "libqos/malloc.h"
> +#include "libqos/qgraph.h"
>  
> +typedef struct QPCIBusPC {
> +    QOSGraphObject obj;
> +    QPCIBus bus;
> +} QPCIBusPC;
> +
> +/* qpci_init_pc():
> + * this function initialize an already allocated
> + * QPCIBusPC object.
> + *
> + * @ret must be a valid QPCIBusPC * pointer.
> + */
> +void qpci_init_pc(QPCIBusPC *ret, QTestState *qts, QGuestAllocator *alloc);
>  /* qpci_pc_new():
> -* this function creates a new QPCIBusPC object,
> + * this function creates a new QPCIBusPC object,
>   * and properly initialize its fields.
>   *
>   * returns the QPCIBus *bus field of a newly
> diff --git a/tests/libqos/pci.c b/tests/libqos/pci.c
> index 0b73cb23d0..91440ece5c 100644
> --- a/tests/libqos/pci.c
> +++ b/tests/libqos/pci.c
> @@ -15,6 +15,7 @@
>  
>  #include "hw/pci/pci_regs.h"
>  #include "qemu/host-utils.h"
> +#include "libqos/qgraph.h"
>  
>  void qpci_device_foreach(QPCIBus *bus, int vendor_id, int device_id,
>                           void (*func)(QPCIDevice *dev, int devfn, void *data),
> @@ -50,15 +51,31 @@ void qpci_device_foreach(QPCIBus *bus, int vendor_id, int device_id,
>      }
>  }
>  
> -QPCIDevice *qpci_device_find(QPCIBus *bus, int devfn)
> +bool qpci_has_buggy_msi(QPCIDevice *dev)
>  {
> -    QPCIDevice *dev;
> +    return dev->bus->has_buggy_msi;
> +}

As above, introduce this when you need it.

> -    dev = g_malloc0(sizeof(*dev));
> +/* returns TRUE if everything goes fine, FALSE if not */
> +static bool qpci_device_set(QPCIDevice *dev, QPCIBus *bus, int devfn)
> +{
>      dev->bus = bus;
>      dev->devfn = devfn;
>  
>      if (qpci_config_readw(dev, PCI_VENDOR_ID) == 0xFFFF) {
> +        return FALSE;
> +    }

I think what we check here is to see if the PCI device is available.
0xFFFF means there is a problem.

I think you should add a function "qpci_device_available(devn, bus)"

> +
> +    return TRUE;
> +}
> +
> +QPCIDevice *qpci_device_find(QPCIBus *bus, int devfn)
> +{
> +    QPCIDevice *dev;
> +
> +    dev = g_malloc0(sizeof(*dev));
> +
> +    if (!qpci_device_set(dev, bus, devfn)) {
>          g_free(dev);
>          return NULL;
>      }
> @@ -66,6 +83,21 @@ QPCIDevice *qpci_device_find(QPCIBus *bus, int devfn)
>      return dev;
>  }
>  
> +void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, QPCIAddress *addr)
> +{
> +    uint16_t vendor_id, device_id;
> +
> +    if (!qpci_device_set(dev, bus, addr->devfn)) {
> +        printf("PCI Device not found\n");
> +        abort();
> +    }

so, here, you should use qpci_device_set() and qpci_device_available()...

> +
> +    vendor_id = qpci_config_readw(dev, PCI_VENDOR_ID);

or you can only check vendor_id to see it is 0xffff or not...

> +    device_id = qpci_config_readw(dev, PCI_DEVICE_ID);
> +    g_assert(vendor_id == addr->vendor_id);

that should be in fact detected by this g_assert().

> +    g_assert(device_id == addr->device_id);
> +}
> +
>  void qpci_device_enable(QPCIDevice *dev)
>  {
>      uint16_t cmd;
> @@ -402,3 +434,13 @@ void qpci_plug_device_test(const char *driver, const char *id,
>      qtest_qmp_device_add(driver, id, "'addr': '%d'%s%s", slot,
>                           opts ? ", " : "", opts ? opts : "");
>  }
> +
> +void add_qpci_address(QOSGraphEdgeOptions *opts, QPCIAddress *addr)
> +{
> +    if (!addr || !opts) {
> +        return;
> +    }

Should it be an error case and fails (g_assert())?

> +
> +    opts->arg = addr;
> +    opts->size_arg = sizeof(QPCIAddress);
> +}
> diff --git a/tests/libqos/pci.h b/tests/libqos/pci.h
> index 429c382282..5fb3c550c5 100644
> --- a/tests/libqos/pci.h
> +++ b/tests/libqos/pci.h
> @@ -14,6 +14,7 @@
>  #define LIBQOS_PCI_H
>  
>  #include "libqtest.h"
> +#include "libqos/qgraph.h"
>  
>  #define QPCI_PIO_LIMIT    0x10000
>  
> @@ -22,6 +23,7 @@
>  typedef struct QPCIDevice QPCIDevice;
>  typedef struct QPCIBus QPCIBus;
>  typedef struct QPCIBar QPCIBar;
> +typedef struct QPCIAddress QPCIAddress;
>  
>  struct QPCIBus {
>      uint8_t (*pio_readb)(QPCIBus *bus, uint32_t addr);
> @@ -51,6 +53,8 @@ struct QPCIBus {
>      QTestState *qts;
>      uint16_t pio_alloc_ptr;
>      uint64_t mmio_alloc_ptr, mmio_limit;
> +    bool has_buggy_msi; /* TRUE for spapr, FALSE for pci */

as above, introduce it when you need it.

> +
>  };
>  
>  struct QPCIBar {
> @@ -66,10 +70,19 @@ struct QPCIDevice
>      uint64_t msix_table_off, msix_pba_off;
>  };
>  
> +struct QPCIAddress {
> +    uint32_t devfn;
> +    uint16_t vendor_id;
> +    uint16_t device_id;
> +};
> +
>  void qpci_device_foreach(QPCIBus *bus, int vendor_id, int device_id,
>                           void (*func)(QPCIDevice *dev, int devfn, void *data),
>                           void *data);
>  QPCIDevice *qpci_device_find(QPCIBus *bus, int devfn);
> +void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, QPCIAddress *addr);
> +/* returns the bus has_buggy_msi flag */
> +bool qpci_has_buggy_msi(QPCIDevice *dev);
>  
>  void qpci_device_enable(QPCIDevice *dev);
>  uint8_t qpci_find_capability(QPCIDevice *dev, uint8_t id);
> @@ -112,4 +125,6 @@ QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr);
>  void qpci_plug_device_test(const char *driver, const char *id,
>                             uint8_t slot, const char *opts);
>  void qpci_unplug_acpi_device_test(const char *id, uint8_t slot);
> +
> +void add_qpci_address(QOSGraphEdgeOptions *opts, QPCIAddress *addr);
>  #endif
> 
