Received: from eggs.gnu.org ([2001:4830:134:3::10]:41558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dVxV7-0004iW-0g
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:07:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dVxV2-0003vQ-1n
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:07:08 -0400
Received: from chuckie.co.uk ([82.165.15.123]:41153
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dVxV1-0003uy-NJ
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:07:03 -0400
References: <1499810007-28613-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1499810007-28613-9-git-send-email-mark.cave-ayland@ilande.co.uk>
	<CACXAS8CPyt1u3YFGLdFEF9NNtvDEE2WhuhUmzL7uEiio88ZJ7g@mail.gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <9d5ee7f6-a4bd-c285-1380-10c5088e599d@ilande.co.uk>
Date: Fri, 14 Jul 2017 11:06:54 +0100
MIME-Version: 1.0
In-Reply-To: <CACXAS8CPyt1u3YFGLdFEF9NNtvDEE2WhuhUmzL7uEiio88ZJ7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 8/8] sun4u: move in-built devices behind
 PCI bridge A
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 12/07/17 10:59, Artyom Tarasenko wrote:

> On Tue, Jul 11, 2017 at 11:53 PM, Mark Cave-Ayland
> <mark.cave-ayland@ilande.co.uk> wrote:
>> This switches the sun4u model to being much closer to a real Ultra 5.
>>
>> Since the existing code previously bypassed the PCI bridge interrupt
>> swizzling, reorganise the interrupt mapping functions so that
>> pci_pbm_map_irq() is used by the PCI bridges and pci_apb_map_irq() is
>> used by the PCI host bridge.
>>
>> As part of this change we also combine the "onboard" NIC and the ebus into
>> a single multi-function device as done on a real Ultra 5.
> 
> While they are combined on a real Ultra 5, it has a different NIC.
> Are the guest OSes smart enough to use NE2000 as an onboard device?

Yes, since the ne2000 is the default NIC unless you explicitly change it
on the command line - in which case I think it's fairly safe to assume
that you know what you're doing ;)

At some point I'll come up with a proper hme device as not all OSs
enable the ne2000 driver by default by SPARC, which should get
networking going for pretty much all SPARC64 OSs.

>> Finally we mark the physically unavailable slots (plus slot 0 in busA) as
>> reserved to ensure that users can't plug devices into non-existent slots
>> which will break interrupt routing.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  hw/pci-host/apb.c  |   35 +++++++++++++++++++++++++++--------
>>  hw/sparc64/sun4u.c |   25 ++++++++++++++++++++-----
>>  2 files changed, 47 insertions(+), 13 deletions(-)
>>
>> diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
>> index f9badad..5000432 100644
>> --- a/hw/pci-host/apb.c
>> +++ b/hw/pci-host/apb.c
>> @@ -601,16 +601,35 @@ static uint64_t apb_pci_config_read(void *opaque, hwaddr addr,
>>  /* The APB host has an IRQ line for each IRQ line of each slot.  */
>>  static int pci_apb_map_irq(PCIDevice *pci_dev, int irq_num)
>>  {
>> -    return ((pci_dev->devfn & 0x18) >> 1) + irq_num;
>> +    /* Return the irq as swizzled by the PBM */
>> +    return irq_num;
>>  }
>>
>>  static int pci_pbm_map_irq(PCIDevice *pci_dev, int irq_num)
>>  {
>> +    PBMPCIBridge *br = PBM_PCI_BRIDGE(pci_bridge_get_device(
>> +                           PCI_BUS(qdev_get_parent_bus(DEVICE(pci_dev)))));
>> +
>>      int bus_offset;
>> -    if (pci_dev->devfn & 1)
>> -        bus_offset = 16;
>> -    else
>> -        bus_offset = 0;
>> +    if (br->busA) {
>> +        bus_offset = 0x0;
>> +
>> +        /* The on-board devices have fixed (legacy) OBIO intnos */
>> +        switch (PCI_SLOT(pci_dev->devfn)) {
>> +        case 1:
>> +            /* Onboard NIC */
>> +            return 0x21;
>> +        case 3:
>> +            /* Onboard IDE */
>> +            return 0x20;
>> +
>> +        default:
>> +            /* Normal intno, fall through */
>> +            break;
>> +        }
>> +    } else {
>> +        bus_offset = 0x10;
>> +    }
>>      return (bus_offset + (PCI_SLOT(pci_dev->devfn) << 2) + irq_num) & 0x1f;
>>  }
>>
>> @@ -692,7 +711,7 @@ PCIBus *pci_apb_init(hwaddr special_base,
>>      d = APB_DEVICE(dev);
>>      phb = PCI_HOST_BRIDGE(dev);
>>      phb->bus = pci_register_bus(DEVICE(phb), "pci",
>> -                                pci_apb_set_irq, pci_pbm_map_irq, d,
>> +                                pci_apb_set_irq, pci_apb_map_irq, d,
>>                                  &d->pci_mmio,
>>                                  get_system_io(),
>>                                  0, 32, TYPE_PCI_BUS);
>> @@ -726,14 +745,14 @@ PCIBus *pci_apb_init(hwaddr special_base,
>>      pci_dev = pci_create_multifunction(phb->bus, PCI_DEVFN(1, 0), true,
>>                                     TYPE_PBM_PCI_BRIDGE);
>>      br = PCI_BRIDGE(pci_dev);
>> -    pci_bridge_map_irq(br, "pciB", pci_apb_map_irq);
>> +    pci_bridge_map_irq(br, "pciB", pci_pbm_map_irq);
>>      qdev_init_nofail(&pci_dev->qdev);
>>      *busB = pci_bridge_get_sec_bus(br);
>>
>>      pci_dev = pci_create_multifunction(phb->bus, PCI_DEVFN(1, 1), true,
>>                                     TYPE_PBM_PCI_BRIDGE);
>>      br = PCI_BRIDGE(pci_dev);
>> -    pci_bridge_map_irq(br, "pciA", pci_apb_map_irq);
>> +    pci_bridge_map_irq(br, "pciA", pci_pbm_map_irq);
>>      qdev_prop_set_bit(DEVICE(pci_dev), "busA", true);
>>      qdev_init_nofail(&pci_dev->qdev);
>>      *busA = pci_bridge_get_sec_bus(br);
>> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
>> index 3bb3bf2..b8b96be 100644
>> --- a/hw/sparc64/sun4u.c
>> +++ b/hw/sparc64/sun4u.c
>> @@ -27,6 +27,7 @@
>>  #include "cpu.h"
>>  #include "hw/hw.h"
>>  #include "hw/pci/pci.h"
>> +#include "hw/pci/pci_bus.h"
>>  #include "hw/pci-host/apb.h"
>>  #include "hw/i386/pc.h"
>>  #include "hw/char/serial.h"
>> @@ -42,6 +43,7 @@
>>  #include "hw/nvram/fw_cfg.h"
>>  #include "hw/sysbus.h"
>>  #include "hw/ide.h"
>> +#include "hw/ide/pci.h"
>>  #include "hw/loader.h"
>>  #include "elf.h"
>>  #include "qemu/cutils.h"
>> @@ -448,10 +450,17 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>>      ivec_irqs = qemu_allocate_irqs(sparc64_cpu_set_ivec_irq, cpu, IVEC_MAX);
>>      pci_bus = pci_apb_init(APB_SPECIAL_BASE, APB_MEM_BASE, ivec_irqs, &pci_busA,
>>                             &pci_busB, &pbm_irqs);
>> -    pci_vga_init(pci_bus);
>>
>> -    /* XXX Should be pci_busA */
>> -    ebus = pci_create_simple(pci_bus, -1, "ebus");
>> +    /* Only in-built Simba PBMs can exist on the root bus, slot 0 on busA is
>> +       reserved (leaving no slots free after on-board devices) leaving slots
>> +       0-3 are free on busB 4*/
>> +    pci_bus->slot_reserved_mask = 0xfffffffc;
>> +    pci_busA->slot_reserved_mask = 0xfffffff1;
>> +    pci_busB->slot_reserved_mask = 0xfffffff0;
>> +
>> +    ebus = pci_create_multifunction(pci_busA, PCI_DEVFN(1, 0), true, "ebus");
>> +    qdev_init_nofail(DEVICE(ebus));
>> +
>>      isa_bus = pci_ebus_init(ebus, pbm_irqs);
>>
>>      i = 0;
>> @@ -464,14 +473,20 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>>      serial_hds_isa_init(isa_bus, i, MAX_SERIAL_PORTS);
>>      parallel_hds_isa_init(isa_bus, MAX_PARALLEL_PORTS);
>>
>> -    pci_dev = pci_create(pci_bus, -1, "ne2k_pci");
>> +    pci_dev = pci_create_simple(pci_busA, PCI_DEVFN(2, 0), "VGA");
>> +
>> +    pci_dev = pci_create_multifunction(pci_busA, PCI_DEVFN(1, 1), true,
>> +                                       "ne2k_pci");
>>      dev = &pci_dev->qdev;
>>      qdev_set_nic_properties(dev, &nd_table[0]);
>>      qdev_init_nofail(dev);
>>
>>      ide_drive_get(hd, ARRAY_SIZE(hd));
>>
>> -    pci_cmd646_ide_init(pci_bus, hd, 1);
>> +    pci_dev = pci_create(pci_busA, PCI_DEVFN(3, 0), "cmd646-ide");
>> +    qdev_prop_set_uint32(&pci_dev->qdev, "secondary", 1);
>> +    qdev_init_nofail(&pci_dev->qdev);
>> +    pci_ide_create_devs(pci_dev, hd);
>>
>>      isa_create_simple(isa_bus, "i8042");
>>
>> --
>> 1.7.10.4


ATB,

Mark.
