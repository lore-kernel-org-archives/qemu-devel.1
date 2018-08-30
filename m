Received: from eggs.gnu.org ([2001:4830:134:3::10]:54700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1fvPCj-0006mW-2e
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:49:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1fvOxf-00079m-13
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:34:22 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ybettan@redhat.com>) id 1fvOxe-00079P-NG
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:34:18 -0400
Received: by mail-ed1-f68.google.com with SMTP id u1-v6so6690755eds.1
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 08:34:17 -0700 (PDT)
References: <20180828072426.45103-1-ybettan@redhat.com>
	<20180829134030.5a631d61.cohuck@redhat.com>
From: Yoni Bettan <ybettan@redhat.com>
Message-ID: <db7c4e36-f8ec-9282-268a-4e782c2c2142@redhat.com>
Date: Thu, 30 Aug 2018 18:34:14 +0300
MIME-Version: 1.0
In-Reply-To: <20180829134030.5a631d61.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>



On 8/29/18 2:40 PM, Cornelia Huck wrote:
> On Tue, 28 Aug 2018 10:24:26 +0300
> Yoni Bettan <ybettan@redhat.com> wrote:

Thanks you for your review!
>
>>      - this is a simple example of how to write a pci device that supports
>>        portio, mmio, irq and dma
> Do you also plan to add example code for MSI(-X)?
>
> [Not just asking because s390 only supports MSI-X. Honestly :)]

For now my main focus is to finish the virtIO device ASAP, so adding 
MSI-X support is in low priority.
But if it is a deal breaker for this patch to be accepted I will add it.
In both cases I have no problem to add MSI-X support later because the 
main purpose is to have an example device describing "the right way",
so, after you bring it to my attention in my opinion, MSI-X support 
should be added.
I will mention that subject on V2 and see what others think about it.
>
>> Signed-off-by: Yoni Bettan <ybettan@redhat.com>
>> ---
>>   hw/pci/Makefile.objs |   1 +
>>   hw/pci/pci_example.c | 309 +++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 310 insertions(+)
>>   create mode 100644 hw/pci/pci_example.c
>>
> (...)
>
>> diff --git a/hw/pci/pci_example.c b/hw/pci/pci_example.c
>> new file mode 100644
>> index 0000000000..326c9b7fa1
>> --- /dev/null
>> +++ b/hw/pci/pci_example.c
>> @@ -0,0 +1,309 @@
>> +#include "qemu/osdep.h"
>> +#include "hw/pci/pci.h"
>> +
>> +#define TYPE_PCI_EXAMPLE "pci-example"
>> +
>> +#define PCI_EXAMPLE(obj)  \
>> +    OBJECT_CHECK(PCIExampleDevState, (obj), TYPE_PCI_EXAMPLE)
>> +
>> +
>> +#define ERROR -1
> It's probably not a good idea to obfuscate the return code. Either
> return -1, or a proper error code.

You are right, this will be repaired.
In addition another problem here is that a negative value is returned 
from functions that returns uint64_t so I will need to repair it anyway.
>
>> +#define BLOCK_SIZE 64
>> +#define EXAMPLE_MMIO_SIZE BLOCK_SIZE
>> +#define EXAMPLE_PIO_SIZE BLOCK_SIZE
>> +#define DMA_BUFF_SIZE 4096
>> +
>> +/*---------------------------------------------------------------------------*/
>> +/*                                 PCI Struct                                */
>> +/*---------------------------------------------------------------------------*/
>> +
>> +typedef struct PCIExampleDevState {
>> +    /*< private >*/
>> +    PCIDevice parent_obj;
>> +    /*< public >*/
>> +
>> +    /* memory region */
>> +    MemoryRegion portio;
>> +    MemoryRegion mmio;
>> +    MemoryRegion irqio;
>> +    MemoryRegion dmaio;
>> +
>> +    /* data registers */
>> +    uint64_t memData, ioData, dmaPhisicalBase;
> I think we want this to be mem_data, io_data, and dma_physical_base
> instead.

You are right, after reading 
https://github.com/portante/qemu/blob/master/CODING_STYLE I have notice 
that and this will be updated in V2.
>
>> +
>> +    qemu_irq irq;
>> +    /* for the driver to determine if this device caused the interrupt */
>> +    uint64_t threwIrq;
> Same here (threw_irq).

Same as above.
>
>> +
>> +} PCIExampleDevState;
>> +
>> +
>> +/*---------------------------------------------------------------------------*/
>> +/*                         Read/Write functions                              */
>> +/*---------------------------------------------------------------------------*/
>> +
>> +/* do nothing because the mmio read is done from DMA buffer */
>> +static uint64_t pci_example_mmio_read(void *opaque, hwaddr addr, unsigned size)
>> +{
>> +    return ERROR;
>> +}
>> +
>> +static void
>> +pci_example_mmio_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
> I think our preferred style is to keep return value and function name
> on the same line and add line breaks in the parameter list, if needed.
> (Some more occurrences further down.)

No problem, I prefer this style to.
>
>> +{
>> +    PCIExampleDevState *pms = (PCIExampleDevState *)opaque;
> peds? ped_state? (I'm not sure pms <-> PCIExampleDevState is obvious;
> I'm not sure either whether my suggestions are better :)

This device originally was called PCIMulDevState since it just multiply 
a number, before submitting the patch I changed it to PCIExampleDevState 
but forgot to update the variables names :)
I will repair that.
>
>> +    PCIDevice *pciDev = (PCIDevice *)opaque;
> pci_dev is better, I think. Also, I'd probably refer to pms->parent_obj
> (maybe call that one pci_device instead?) instead of casting.

I will update the name to fit to the coding style. About referencing to 
parent_obj I need to look again at the code to understand why I did it 
that way.
>
>> +
>> +    if (size != 1) {
>> +        return;
>> +    }
>> +
>> +    /* compute the result */
>> +    pms->memData = val * 2;
>> +
>> +    /* write the result directly to phisical memory */
>> +    cpu_physical_memory_write(pms->dmaPhisicalBase, &pms->memData,
>> +            DMA_BUFF_SIZE);
> Indentation seems off.

How would you have done it otherwise ? this is a simple "Enter" when 80 
characters are reached.
>
>> +
>> +    /* raise an IRQ to notify DMA has finished  */
>> +    pms->threwIrq = 1;
>> +    pci_irq_assert(pciDev);
>> +}
> (...)
>
>> +/* do nothing because physical DMA buffer addres is onlyt set and don't need to
>> + * be red */
> s/addres/address/
> s/onlyt/only/
> s/don't/doesn't/
> s/red/read/

Sorry for that, I didn't run spell check.
>
> Also, we prefer the
>
> /*
>   * comment style
>   */
>
> if it can't fit on one line.
>
> (...)

Got it.
>
>> +/*---------------------------------------------------------------------------*/
>> +/*                             PCI functions                                 */
>> +/*---------------------------------------------------------------------------*/
>> +
>> +/* this is called when lunching the vm with "-device <device name>" */
> s/lunching/launching/
>
> Although that's simply the normal realization process, which could also
> be triggered by hotplug.

I will add this in the comment.
>
>> +static void pci_example_realize(PCIDevice *pciDev, Error **errp)
>> +{
>> +   PCIExampleDevState *d = PCI_EXAMPLE(pciDev);
> Here you use "d" as a variable name, which arguably might be better
> than any of the suggestions above :)

I will make it generic and give a purposeful name :)
>
>> +   uint8_t *pciCond = pciDev->config;
>> +
>> +   d->threwIrq = 0;
>> +
>> +   /* initiallise the memory region of the CPU to the device */
> s/initiallise/initialize/

I will run set spell on the whole file.
>
>> +   memory_region_init_io(&d->mmio, OBJECT(d), &pci_example_mmio_ops, d,
>> +           "pci-example-mmio", EXAMPLE_MMIO_SIZE);
>> +
>> +   memory_region_init_io(&d->portio, OBJECT(d), &pci_example_pio_ops, d,
>> +           "pci-example-portio", EXAMPLE_PIO_SIZE);
>> +
>> +   memory_region_init_io(&d->irqio, OBJECT(d), &pci_example_irqio_ops, d,
>> +           "pci-example-irqio", EXAMPLE_PIO_SIZE);
>> +
>> +   memory_region_init_io(&d->dmaio, OBJECT(d), &pci_example_dma_ops, d,
>> +           "pci-example-dma-base", EXAMPLE_MMIO_SIZE);
>> +
>> +   /* alocate BARs */
> s/alocate/allocate/

Same.
>
>> +   pci_register_bar(pciDev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &d->mmio);
>> +   pci_register_bar(pciDev, 1, PCI_BASE_ADDRESS_SPACE_IO, &d->portio);
>> +   pci_register_bar(pciDev, 2, PCI_BASE_ADDRESS_SPACE_IO, &d->irqio);
>> +   pci_register_bar(pciDev, 3, PCI_BASE_ADDRESS_SPACE_MEMORY, &d->dmaio);
>> +
>> +   /* give interrupt support.
>> +    * a pci device has 4 pin for interrupt, here we use pin A */
>> +   pci_config_set_interrupt_pin(pciCond, 1);
>> +}
>> +
>> +
>> +/* the destructor of pci_example_realize() */
>> +static void pci_example_uninit(PCIDevice *dev)
>> +{
>> +    /* unregister BARs and other stuff */
> Shouldn't the function actually do it, then? :)

Yes it does, it was a prototype but I will make it full for submission.
Thanks for pointing on this one.
>
>> +}
>> +
>> +
>> +/* class constructor */
>> +static void pci_example_class_init(ObjectClass *klass, void *data)
>> +{
>> +   /* sort of dynamic cast */
>> +   DeviceClass *dc = DEVICE_CLASS(klass);
>> +   PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>> +
>> +   k->realize = pci_example_realize;
>> +   k->exit = pci_example_uninit;
>> +
>> +   /* some regular IDs in HEXA */
>> +   k->vendor_id = PCI_VENDOR_ID_REDHAT;
>> +   k->device_id = PCI_DEVICE_ID_REDHAT_TEST;
>> +   k->class_id = PCI_CLASS_OTHERS;
>> +
>> +   /* set the device bitmap category */
>> +   set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>> +
>> +   k->revision = 0x00;
>> +   dc->desc = "PCI Example Device";
>> +}
>> +
>> +/*---------------------------------------------------------------------------*/
>> +/*                            QEMU overhead                                  */
> Lol :)
>
>> +/*---------------------------------------------------------------------------*/
>> +
>> +
>> +/* Contains all the informations of the device we are creating.
>> + * class_init will be called when we are defining our device. */
>> +static const TypeInfo pci_example_info = {
>> +    .name           = TYPE_PCI_EXAMPLE,
>> +    .parent         = TYPE_PCI_DEVICE,
>> +    .instance_size  = sizeof(PCIExampleDevState),
>> +    .class_init     = pci_example_class_init,
>> +    .interfaces     = (InterfaceInfo[]) {
>> +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
>> +        { },
>> +    },
>> +};
>> +
>> +
>> +/* function called before the qemu main it will define our device */
> "Define our device type; this is done during startup of QEMU"
>
> ?

This is a pretty good suggestion!
>
>> +static void pci_example_register_types(void)
>> +{
>> +    type_register_static(&pci_example_info);
>> +}
>> +
>> +/* make qemu register our device at qemu-booting */
> I don't think you need this comment here as well (the type_init and the
> function kind of form one logical unit.)

No problem, I will remove it.
>
>> +type_init(pci_example_register_types)
>> +
>> +
>> +
> I think the basic structure looks sound; I've focused on style
> questions as this is supposed to be an example for others to copy from.
> I'll leave the pci details to people more versed in pci :)

Thanks again for this review!
Yoni
