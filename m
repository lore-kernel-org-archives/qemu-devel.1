Received: from eggs.gnu.org ([2001:4830:134:3::10]:39722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fv0CV-0006j9-6Z
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 09:08:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fv0CR-0000vV-U7
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 09:07:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fv0CR-0000uB-JZ
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 09:07:55 -0400
Date: Wed, 29 Aug 2018 10:07:48 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180829130748.GK5675@localhost.localdomain>
References: <20180828072426.45103-1-ybettan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828072426.45103-1-ybettan@redhat.com>
Subject: Re: [Qemu-devel] [RFC V1] hw/pci/pci_example.c : Added a new pci
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yoni Bettan <ybettan@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Hi,

Thanks for the patch.

On Tue, Aug 28, 2018 at 10:24:26AM +0300, Yoni Bettan wrote:
>     - this is a simple example of how to write a pci device that supports
>       portio, mmio, irq and dma

Can we have some documentation on what are the goals of the
example device, and what exactly it does?


> 
> Signed-off-by: Yoni Bettan <ybettan@redhat.com>
> ---
>  hw/pci/Makefile.objs |   1 +
>  hw/pci/pci_example.c | 309 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 310 insertions(+)
>  create mode 100644 hw/pci/pci_example.c
> 
> diff --git a/hw/pci/Makefile.objs b/hw/pci/Makefile.objs
> index 9f905e6344..e684b72f90 100644
> --- a/hw/pci/Makefile.objs
> +++ b/hw/pci/Makefile.objs
> @@ -4,6 +4,7 @@ common-obj-$(CONFIG_PCI) += shpc.o
>  common-obj-$(CONFIG_PCI) += slotid_cap.o
>  common-obj-$(CONFIG_PCI) += pci_host.o pcie_host.o
>  common-obj-$(CONFIG_PCI) += pcie.o pcie_aer.o pcie_port.o
> +common-obj-$(CONFIG_PCI) += pci_example.o

I am wondering how we can guarantee nobody will break the example
code while not including it by default on production builds.
Maybe disabling the device by default, adding a ./configure
--enable-examples option, and adding it to one of the test cases
on .travis.yml?

>  
>  common-obj-$(call lnot,$(CONFIG_PCI)) += pci-stub.o
>  common-obj-$(CONFIG_ALL) += pci-stub.o
> diff --git a/hw/pci/pci_example.c b/hw/pci/pci_example.c
> new file mode 100644
> index 0000000000..326c9b7fa1
> --- /dev/null
> +++ b/hw/pci/pci_example.c
> @@ -0,0 +1,309 @@
> +#include "qemu/osdep.h"
> +#include "hw/pci/pci.h"
> +

Being an example device, it would be nice to explain what these
two macros are used for.


> +#define TYPE_PCI_EXAMPLE "pci-example"
> +
> +#define PCI_EXAMPLE(obj)  \
> +    OBJECT_CHECK(PCIExampleDevState, (obj), TYPE_PCI_EXAMPLE)
> +
> +

One line descriptions of the meaning of the macros below would be
nice to have.

> +#define ERROR -1

I'm not sure we need this macro.  Additional comments below where
the macro is actually used.


> +#define BLOCK_SIZE 64
> +#define EXAMPLE_MMIO_SIZE BLOCK_SIZE
> +#define EXAMPLE_PIO_SIZE BLOCK_SIZE

I don't see BLOCK_SIZE being used anywhere in the code.  Wouldn't
it be more readable if you just did:

  #define EXAMPLE_MMIO_SIZE 64
  #define EXAMPLE_PIO_SIZE  64

> +#define DMA_BUFF_SIZE 4096

I suggest DMA_BUF_SIZE, as "buf" is a more usual abbreviation for
"buffer".

> +
> +/*---------------------------------------------------------------------------*/
> +/*                                 PCI Struct                                */
> +/*---------------------------------------------------------------------------*/
> +
> +typedef struct PCIExampleDevState {
> +    /*< private >*/
> +    PCIDevice parent_obj;

One line description of what parent_obj is, or a pointer to QOM
documentation explaining it would be nice.

> +    /*< public >*/
> +
> +    /* memory region */

This comment seems redundant: the words "memory region" are
already spelled 4 times below.

> +    MemoryRegion portio;
> +    MemoryRegion mmio;
> +    MemoryRegion irqio;
> +    MemoryRegion dmaio;
> +
> +    /* data registers */
> +    uint64_t memData, ioData, dmaPhisicalBase;

Can we have a one-line description of each of the registers?

> +
> +    qemu_irq irq;
> +    /* for the driver to determine if this device caused the interrupt */
> +    uint64_t threwIrq;
> +
> +} PCIExampleDevState;
> +
> +
> +/*---------------------------------------------------------------------------*/
> +/*                         Read/Write functions                              */
> +/*---------------------------------------------------------------------------*/
> +
> +/* do nothing because the mmio read is done from DMA buffer */
> +static uint64_t pci_example_mmio_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    return ERROR;

You can't return a negative value from a uint64_t function.  What
exactly you are trying to communicate to the caller by returning
0xffffffffffffffff here?

Same problem below[5].

> +}
> +
> +static void
> +pci_example_mmio_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
> +{
> +    PCIExampleDevState *pms = (PCIExampleDevState *)opaque;

You can write this as:
    PCIExampleDevState *pms = opaque;

Same below[1].


> +    PCIDevice *pciDev = (PCIDevice *)opaque;

I suggest using PCI_DEVICE(pms) here and below[2].


> +
> +    if (size != 1) {
> +        return;
> +    }

Why you want to support only 1-byte writes?

> +
> +    /* compute the result */
> +    pms->memData = val * 2;
> +
> +    /* write the result directly to phisical memory */
> +    cpu_physical_memory_write(pms->dmaPhisicalBase, &pms->memData,
> +            DMA_BUFF_SIZE);
> +
> +    /* raise an IRQ to notify DMA has finished  */
> +    pms->threwIrq = 1;
> +    pci_irq_assert(pciDev);
> +}
> +
> +static uint64_t pci_example_pio_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    PCIExampleDevState *pms = (PCIExampleDevState *)opaque;

[1]

> +
> +    if (size != 1) {
> +        return ERROR;

Same problem as pci_example_mmio_read() above.

> +    }

Same as above: why you want to support only 1-byte reads?  Same
below[3].

> +
> +    return pms->ioData;
> +}
> +
> +static void
> +pci_example_pio_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
> +{
> +    PCIExampleDevState *pms = (PCIExampleDevState *)opaque;

[1]

> +    PCIDevice *pciDev = (PCIDevice *)opaque;

[2]

> +
> +    if (size != 1) {

[3]

> +        return;
> +    }
> +
> +    pms->ioData = val * 2;
> +    pms->threwIrq = 1;
> +    pci_irq_assert(pciDev);
> +}
> +
> +static uint64_t pci_example_irqio_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    PCIExampleDevState *pms = (PCIExampleDevState *)opaque;
> +
> +    if (size != 1) {

[3]

> +        return ERROR;

[5]

> +    }
> +
> +    return pms->threwIrq;
> +}
> +
> +static void
> +pci_example_irqio_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
> +{
> +    PCIExampleDevState *pms = (PCIExampleDevState *)opaque;
> +    PCIDevice *pciDev = (PCIDevice *)opaque;
> +
> +    if (size != 1) {

[3]

> +        return;
> +    }
> +
> +    /* give the ability to assert IRQ , we will use it only to deassert IRQ */
> +    if (val) {
> +        pci_irq_assert(pciDev);
> +        pms->threwIrq = 1;
> +    } else {
> +        pms->threwIrq = 0;
> +        pci_irq_deassert(pciDev);
> +    }
> +}
> +
> +/* do nothing because physical DMA buffer addres is onlyt set and don't need to
> + * be red */
> +static uint64_t
> +pci_example_dma_base_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    return ERROR;

[5]

> +}
> +
> +static void
> +pci_example_dma_base_write(void *opaque, hwaddr addr, uint64_t val,
> +        unsigned size)
> +{
> +    PCIExampleDevState *pms = (PCIExampleDevState *)opaque;
> +
> +    if (size != 4) {
> +        return;
> +    }
> +
> +    /* notify the device about the physical address of the DMA buffer that the
> +     * driver has allocated */
> +    switch (addr) {
> +        /* lower bytes */
> +        case(0):
> +            pms->dmaPhisicalBase &= 0xffffffff00000000;
> +            break;
> +
> +        /* upper bytes */
> +        case(4):
> +            val <<= 32;
> +            pms->dmaPhisicalBase &= 0x00000000ffffffff;
> +            break;
> +    }
> +
> +    pms->dmaPhisicalBase |= val;
> +}
> +
> +/*---------------------------------------------------------------------------*/
> +/*                             PCI region ops                                */
> +/*---------------------------------------------------------------------------*/
> +
> +/* callback called when memory region representing the MMIO space is accessed */
> +static const MemoryRegionOps pci_example_mmio_ops = {
> +    .read = pci_example_mmio_read,
> +    .write = pci_example_mmio_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .impl = {
> +        .min_access_size = 1,
> +        .max_access_size = 1,

Now I see you set min/max access size.  Maybe the size checks
above[3] can be asserts?

If I read the documentation correctly, a 64-bit write will become
a series of 1-byte writes, and the device behavior might be
confusing.  Supporting 64-bit writes would probably make it more
intuitive.


> +    },
> +};
> +
> +/* callback called when memory region representing the PIO space is accessed */
> +static const MemoryRegionOps pci_example_pio_ops = {
> +    .read = pci_example_pio_read,
> +    .write = pci_example_pio_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .impl = {
> +        .min_access_size = 1,
> +        .max_access_size = 1,

[3]

> +    },
> +};
> +
> +/* callback called when memory region representing the IRQ space is accessed */
> +static const MemoryRegionOps pci_example_irqio_ops = {
> +    .read = pci_example_irqio_read,
> +    .write = pci_example_irqio_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .impl = {
> +        .min_access_size = 1,
> +        .max_access_size = 1,

[3]

> +    },
> +};
> +
> +/* callback called when memory region representing the DMA space is accessed */
> +static const MemoryRegionOps pci_example_dma_ops = {
> +    .read = pci_example_dma_base_read,
> +    .write = pci_example_dma_base_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,

[3]

> +    },
> +};
> +
> +/*---------------------------------------------------------------------------*/
> +/*                             PCI functions                                 */
> +/*---------------------------------------------------------------------------*/
> +
> +/* this is called when lunching the vm with "-device <device name>" */
> +static void pci_example_realize(PCIDevice *pciDev, Error **errp)
> +{
> +   PCIExampleDevState *d = PCI_EXAMPLE(pciDev);
> +   uint8_t *pciCond = pciDev->config;
> +
> +   d->threwIrq = 0;

Is this really necessary?


> +
> +   /* initiallise the memory region of the CPU to the device */

What does "memory region of the CPU" means?


> +   memory_region_init_io(&d->mmio, OBJECT(d), &pci_example_mmio_ops, d,
> +           "pci-example-mmio", EXAMPLE_MMIO_SIZE);
> +
> +   memory_region_init_io(&d->portio, OBJECT(d), &pci_example_pio_ops, d,
> +           "pci-example-portio", EXAMPLE_PIO_SIZE);
> +
> +   memory_region_init_io(&d->irqio, OBJECT(d), &pci_example_irqio_ops, d,
> +           "pci-example-irqio", EXAMPLE_PIO_SIZE);
> +
> +   memory_region_init_io(&d->dmaio, OBJECT(d), &pci_example_dma_ops, d,
> +           "pci-example-dma-base", EXAMPLE_MMIO_SIZE);

Why you chose to register 64-byte regions instead of a smaller
1, 2, 4, or 8-byte region?

> +
> +   /* alocate BARs */
> +   pci_register_bar(pciDev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &d->mmio);
> +   pci_register_bar(pciDev, 1, PCI_BASE_ADDRESS_SPACE_IO, &d->portio);
> +   pci_register_bar(pciDev, 2, PCI_BASE_ADDRESS_SPACE_IO, &d->irqio);
> +   pci_register_bar(pciDev, 3, PCI_BASE_ADDRESS_SPACE_MEMORY, &d->dmaio);
> +
> +   /* give interrupt support.
> +    * a pci device has 4 pin for interrupt, here we use pin A */
> +   pci_config_set_interrupt_pin(pciCond, 1);
> +}
> +
> +
> +/* the destructor of pci_example_realize() */
> +static void pci_example_uninit(PCIDevice *dev)

I suggest calling it pci_example_exit, as the callback name is
PCIDeviceClass::exit.


> +{
> +    /* unregister BARs and other stuff */

If there's nothing the device needs to do on unrealize, you don't
need an unrealize function at all.

> +}
> +
> +
> +/* class constructor */
> +static void pci_example_class_init(ObjectClass *klass, void *data)
> +{
> +   /* sort of dynamic cast */
> +   DeviceClass *dc = DEVICE_CLASS(klass);
> +   PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> +
> +   k->realize = pci_example_realize;
> +   k->exit = pci_example_uninit;
> +
> +   /* some regular IDs in HEXA */

What "HEXA" means here?

> +   k->vendor_id = PCI_VENDOR_ID_REDHAT;
> +   k->device_id = PCI_DEVICE_ID_REDHAT_TEST;

Hmm, this is the device ID of pci-testdev.  We can't just reuse
it.  Maybe it would be appropriate to use an ID on the
0x10f0-0x10ff range?  I assume it would be appropriate only if
the device is not compiled in by default.

I also wonder if we we could make pci-test our example device
instead of adding a new one.  What I really miss here is some
guide to point people to known-good examples of device emulation
code.  We could do that with a new example device, or choose some
existing good examples and make them better documented.


> +   k->class_id = PCI_CLASS_OTHERS;
> +
> +   /* set the device bitmap category */
> +   set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +
> +   k->revision = 0x00;
> +   dc->desc = "PCI Example Device";
> +}
> +
> +/*---------------------------------------------------------------------------*/
> +/*                            QEMU overhead                                  */
> +/*---------------------------------------------------------------------------*/
> +
> +
> +/* Contains all the informations of the device we are creating.
> + * class_init will be called when we are defining our device. */
> +static const TypeInfo pci_example_info = {
> +    .name           = TYPE_PCI_EXAMPLE,
> +    .parent         = TYPE_PCI_DEVICE,
> +    .instance_size  = sizeof(PCIExampleDevState),
> +    .class_init     = pci_example_class_init,
> +    .interfaces     = (InterfaceInfo[]) {
> +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },

A comment explaining why we have
INTERFACE_CONVENTIONAL_PCI_DEVICE might be useful.

> +        { },
> +    },
> +};
> +
> +
> +/* function called before the qemu main it will define our device */
> +static void pci_example_register_types(void)
> +{
> +    type_register_static(&pci_example_info);
> +}
> +
> +/* make qemu register our device at qemu-booting */
> +type_init(pci_example_register_types)
> +
> +
> +
> -- 
> 2.17.1
> 

-- 
Eduardo
