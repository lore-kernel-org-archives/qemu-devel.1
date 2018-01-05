Received: from eggs.gnu.org ([2001:4830:134:3::10]:43037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eXLFf-0002LE-Qb
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 01:13:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eXLFc-0005bD-BC
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 01:13:11 -0500
Received: from iserv.reactos.org ([2a01:4f8:221:4c5::3]:45486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1eXLFb-0005Xf-ID
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 01:13:08 -0500
References: <20171229142922.31701-1-hpoussin@reactos.org>
	<20171229142922.31701-8-hpoussin@reactos.org>
	<20180105011517-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <b6ec32b8-6bec-7b01-32c3-4a3473aa2435@reactos.org>
Date: Fri, 5 Jan 2018 07:13:03 +0100
MIME-Version: 1.0
In-Reply-To: <20180105011517-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 07/16] piix4: add a i8259 interrupt
 controller as specified in datasheet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Le 05/01/2018 à 00:21, Michael S. Tsirkin a écrit :
> On Fri, Dec 29, 2017 at 03:29:13PM +0100, Hervé Poussineau wrote:
>> Add ISA irqs as piix4 gpio in, and CPU interrupt request as piix4 gpio out.
>> Remove i8259 instanciated in malta board, to not have it twice.
>>
>> We can also remove the now unused piix4_init() function.
>>
>> Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
>> ---
>>   hw/isa/piix4.c       | 40 +++++++++++++++++++++++++++++-----------
>>   hw/mips/mips_malta.c | 28 ++++++++++++----------------
>>   include/hw/i386/pc.h |  1 -
>>   3 files changed, 41 insertions(+), 28 deletions(-)
>>
>> diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
>> index 7c83e7c23d..eb2f730fff 100644
>> --- a/hw/isa/piix4.c
>> +++ b/hw/isa/piix4.c
>> @@ -34,6 +34,8 @@ PCIDevice *piix4_dev;
>>   
>>   typedef struct PIIX4State {
>>       PCIDevice dev;
>> +    qemu_irq cpu_intr;
>> +    qemu_irq *isa;
>>   
>>       /* Reset Control Register */
>>       MemoryRegion rcr_mem;
>> @@ -92,6 +94,18 @@ static const VMStateDescription vmstate_piix4 = {
>>       }
>>   };
>>   
>> +static void piix4_request_i8259_irq(void *opaque, int irq, int level)
>> +{
>> +    PIIX4State *s = opaque;
>> +    qemu_set_irq(s->cpu_intr, level);
>> +}
>> +
>> +static void piix4_set_i8259_irq(void *opaque, int irq, int level)
>> +{
>> +    PIIX4State *s = opaque;
>> +    qemu_set_irq(s->isa[irq], level);
>> +}
>> +
>>   static void piix4_rcr_write(void *opaque, hwaddr addr, uint64_t val,
>>                               unsigned int len)
>>   {
>> @@ -120,28 +134,32 @@ static void piix4_realize(PCIDevice *pci, Error **errp)
>>   {
>>       DeviceState *dev = DEVICE(pci);
>>       PIIX4State *s = DO_UPCAST(PIIX4State, dev, pci);
>> +    ISABus *isa_bus;
>> +    qemu_irq *i8259_out_irq;
>>   
>> -    if (!isa_bus_new(dev, pci_address_space(pci),
>> -                     pci_address_space_io(pci), errp)) {
>> +    isa_bus = isa_bus_new(dev, pci_address_space(pci),
>> +                          pci_address_space_io(pci), errp);
>> +    if (!isa_bus) {
>>           return;
>>       }
>>   
>> +    qdev_init_gpio_in_named(dev, piix4_set_i8259_irq, "isa", ISA_NUM_IRQS);
>> +    qdev_init_gpio_out_named(dev, &s->cpu_intr, "intr", 1);
>> +
>>       memory_region_init_io(&s->rcr_mem, OBJECT(dev), &piix4_rcr_ops, s,
>>                             "reset-control", 1);
>>       memory_region_add_subregion_overlap(pci_address_space_io(pci), 0xcf9,
>>                                           &s->rcr_mem, 1);
>>   
>> -    piix4_dev = pci;
>> -    qemu_register_reset(piix4_reset, s);
>> -}
>> +    /* initialize i8259 pic */
>> +    i8259_out_irq = qemu_allocate_irqs(piix4_request_i8259_irq, s, 1);
>> +    s->isa = i8259_init(isa_bus, *i8259_out_irq);
>>   
>> -int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn)
>> -{
>> -    PCIDevice *d;
>> +    /* initialize ISA irqs */
>> +    isa_bus_irqs(isa_bus, s->isa);
>>   
>> -    d = pci_create_simple_multifunction(bus, devfn, true, "PIIX4");
>> -    *isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(d), "isa.0"));
>> -    return d->devfn;
>> +    piix4_dev = pci;
>> +    qemu_register_reset(piix4_reset, s);
>>   }
>>   
>>   static void piix4_class_init(ObjectClass *klass, void *data)
>> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
>> index 37f19428d6..043fe40bce 100644
>> --- a/hw/mips/mips_malta.c
>> +++ b/hw/mips/mips_malta.c
>> @@ -96,7 +96,7 @@ typedef struct {
>>       SysBusDevice parent_obj;
>>   
>>       MIPSCPSState *cps;
>> -    qemu_irq *i8259;
>> +    qemu_irq i8259[16];
>>   } MaltaState;
>>   
>>   static ISADevice *pit;
>> @@ -998,8 +998,8 @@ void mips_malta_init(MachineState *machine)
>>       int64_t kernel_entry, bootloader_run_addr;
>>       PCIBus *pci_bus;
>>       ISABus *isa_bus;
>> -    qemu_irq *isa_irq;
>>       qemu_irq cbus_irq, i8259_irq;
>> +    PCIDevice *pci;
>>       int piix4_devfn;
>>       I2CBus *smbus;
>>       int i;
>> @@ -1180,28 +1180,24 @@ void mips_malta_init(MachineState *machine)
>>       /* Board ID = 0x420 (Malta Board with CoreLV) */
>>       stl_p(memory_region_get_ram_ptr(bios_copy) + 0x10, 0x00000420);
>>   
>> -    /*
>> -     * We have a circular dependency problem: pci_bus depends on isa_irq,
>> -     * isa_irq is provided by i8259, i8259 depends on ISA, ISA depends
>> -     * on piix4, and piix4 depends on pci_bus.  To stop the cycle we have
>> -     * qemu_irq_proxy() adds an extra bit of indirection, allowing us
>> -     * to resolve the isa_irq -> i8259 dependency after i8259 is initialized.
>> -     */
>> -    isa_irq = qemu_irq_proxy(&s->i8259, 16);
>> -
>>       /* Northbridge */
>> -    pci_bus = gt64120_register(isa_irq);
>> +    pci_bus = gt64120_register(s->i8259);
>>   
>>       /* Southbridge */
>>       ide_drive_get(hd, ARRAY_SIZE(hd));
>>   
>> -    piix4_devfn = piix4_init(pci_bus, &isa_bus, 80);
>> +    pci = pci_create_simple_multifunction(pci_bus, PCI_DEVFN(10, 0),
>> +                                          true, "PIIX4");
>> +    dev = DEVICE(pci);
>> +    isa_bus = ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
>> +    piix4_devfn = pci->devfn;
>>   
>>       /* Interrupt controller */
>> -    /* The 8259 is attached to the MIPS CPU INT0 pin, ie interrupt 2 */
>> -    s->i8259 = i8259_init(isa_bus, i8259_irq);
>> +    qdev_connect_gpio_out_named(dev, "intr", 0, i8259_irq);
>> +    for (i = 0; i < 16; i++) {
>> +        s->i8259[i] = qdev_get_gpio_in_named(dev, "isa", i);
>> +    }
>>   
>> -    isa_bus_irqs(isa_bus, s->i8259);
>>       pci_piix4_ide_init(pci_bus, hd, piix4_devfn + 1);
>>       pci_create_simple(pci_bus, piix4_devfn + 2, "piix4-usb-uhci");
>>       smbus = piix4_pm_init(pci_bus, piix4_devfn + 3, 0x1100,
>> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>> index 6f77eb0665..3308ab4b93 100644
>> --- a/include/hw/i386/pc.h
>> +++ b/include/hw/i386/pc.h
>> @@ -300,7 +300,6 @@ PCIBus *i440fx_init(const char *host_type, const char *pci_type,
>>   PCIBus *find_i440fx(void);
>>   /* piix4.c */
>>   extern PCIDevice *piix4_dev;
>> -int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn);
>>   
>>   /* pc_sysfw.c */
>>   void pc_system_firmware_init(MemoryRegion *rom_memory,
> 
> And please drop the pc.h include from mips_malta.c and piix.c

I can't remove it from piix4.c due to a call to i8259_init() and I can't remove it from mips_malta.c due to a call to piix4_pm_init().
I suppose that's a work for later.

> 
>> -- 
>> 2.11.0
> 
