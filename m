Received: from eggs.gnu.org ([2001:4830:134:3::10]:60777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eGa5x-0001SA-Jr
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 19:37:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eGa5u-00081E-Fk
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 19:37:53 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:45181)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eGa5u-00081A-Ag
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 19:37:50 -0500
Received: by mail-qt0-x242.google.com with SMTP id r37so4916226qtj.12
	for <qemu-devel@nongnu.org>; Sun, 19 Nov 2017 16:37:50 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1510926167-23326-5-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a72d2e68-bb54-3200-0289-ec380fc4ed4d@amsat.org>
Date: Sun, 19 Nov 2017 21:37:47 -0300
MIME-Version: 1.0
In-Reply-To: <1510926167-23326-5-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 04/15] sun4u: remove pci_ebus_init()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, atar4qemu@gmail.com

On 11/17/2017 10:42 AM, Mark Cave-Ayland wrote:
> This is initialisation that should really take place in the ebus realize
> function. As part of this we also rework the ebus IRQ mapping so that
> instead of having to pass in the array of pbm_irqs, we obtain a reference
> to them by looking up the APB device during ebus realize.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/pci-host/apb.c         |    4 +---
>  hw/sparc64/sun4u.c        |   29 ++++++++++++++---------------
>  include/hw/pci-host/apb.h |    3 +--
>  3 files changed, 16 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
> index f743a4e..b0f80f6 100644
> --- a/hw/pci-host/apb.c
> +++ b/hw/pci-host/apb.c
> @@ -614,8 +614,7 @@ static void apb_pci_bridge_realize(PCIDevice *dev, Error **errp)
>  
>  PCIBus *pci_apb_init(hwaddr special_base,
>                       hwaddr mem_base,
> -                     qemu_irq *ivec_irqs, PCIBus **busA, PCIBus **busB,
> -                     qemu_irq **pbm_irqs)
> +                     qemu_irq *ivec_irqs, PCIBus **busA, PCIBus **busB)
>  {
>      DeviceState *dev;
>      SysBusDevice *s;
> @@ -646,7 +645,6 @@ PCIBus *pci_apb_init(hwaddr special_base,
>      memory_region_init(&d->pci_mmio, OBJECT(s), "pci-mmio", 0x100000000ULL);
>      memory_region_add_subregion(get_system_memory(), mem_base, &d->pci_mmio);
>  
> -    *pbm_irqs = d->pbm_irqs;
>      d->ivec_irqs = ivec_irqs;
>  
>      pci_create_simple(phb->bus, 0, "pbm-pci");
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 63b4aaa..f3203ea 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -230,21 +230,11 @@ static void isa_irq_handler(void *opaque, int n, int level)
>  }
>  
>  /* EBUS (Eight bit bus) bridge */
> -static ISABus *
> -pci_ebus_init(PCIDevice *pci_dev, qemu_irq *irqs)
> -{
> -    qemu_irq *isa_irq;
> -    ISABus *isa_bus;
> -
> -    isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
> -    isa_irq = qemu_allocate_irqs(isa_irq_handler, irqs, 16);
> -    isa_bus_irqs(isa_bus, isa_irq);
> -    return isa_bus;
> -}
> -
>  static void ebus_realize(PCIDevice *pci_dev, Error **errp)
>  {
>      EbusState *s = EBUS(pci_dev);
> +    APBState *apb;
> +    qemu_irq *isa_irq;
>  
>      s->isa_bus = isa_bus_new(DEVICE(pci_dev), get_system_memory(),
>                               pci_address_space_io(pci_dev), errp);
> @@ -253,6 +243,15 @@ static void ebus_realize(PCIDevice *pci_dev, Error **errp)
>          return;
>      }
>  
> +    apb = APB_DEVICE(object_resolve_path_type("", TYPE_APB, NULL));

:)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +    if (!apb) {
> +        error_setg(errp, "unable to locate APB PCI host bridge");
> +        return;
> +    }
> +
> +    isa_irq = qemu_allocate_irqs(isa_irq_handler, apb->pbm_irqs, 16);
> +    isa_bus_irqs(s->isa_bus, isa_irq);
> +
>      pci_dev->config[0x04] = 0x06; // command = bus master, pci mem
>      pci_dev->config[0x05] = 0x00;
>      pci_dev->config[0x06] = 0xa0; // status = fast back-to-back, 66MHz, no error
> @@ -443,7 +442,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>      PCIDevice *ebus, *pci_dev;
>      ISABus *isa_bus;
>      SysBusDevice *s;
> -    qemu_irq *ivec_irqs, *pbm_irqs;
> +    qemu_irq *ivec_irqs;
>      DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>      DriveInfo *fd[MAX_FD];
>      DeviceState *dev;
> @@ -462,7 +461,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>  
>      ivec_irqs = qemu_allocate_irqs(sparc64_cpu_set_ivec_irq, cpu, IVEC_MAX);
>      pci_bus = pci_apb_init(APB_SPECIAL_BASE, APB_MEM_BASE, ivec_irqs, &pci_busA,
> -                           &pci_busB, &pbm_irqs);
> +                           &pci_busB);
>  
>      /* Only in-built Simba PBMs can exist on the root bus, slot 0 on busA is
>         reserved (leaving no slots free after on-board devices) however slots
> @@ -474,7 +473,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>      ebus = pci_create_multifunction(pci_busA, PCI_DEVFN(1, 0), true, TYPE_EBUS);
>      qdev_init_nofail(DEVICE(ebus));
>  
> -    isa_bus = pci_ebus_init(ebus, pbm_irqs);
> +    isa_bus = EBUS(ebus)->isa_bus;
>  
>      i = 0;
>      if (hwdef->console_serial_base) {
> diff --git a/include/hw/pci-host/apb.h b/include/hw/pci-host/apb.h
> index 5d39c03..35d7d5a 100644
> --- a/include/hw/pci-host/apb.h
> +++ b/include/hw/pci-host/apb.h
> @@ -91,6 +91,5 @@ typedef struct PBMPCIBridge {
>  
>  PCIBus *pci_apb_init(hwaddr special_base,
>                       hwaddr mem_base,
> -                     qemu_irq *ivec_irqs, PCIBus **bus2, PCIBus **bus3,
> -                     qemu_irq **pbm_irqs);
> +                     qemu_irq *ivec_irqs, PCIBus **bus2, PCIBus **bus3);
>  #endif
> 
