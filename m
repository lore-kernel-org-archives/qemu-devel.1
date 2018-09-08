Received: from eggs.gnu.org ([208.118.235.92]:40469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fyb6C-0001AA-Sl
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 07:08:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fyb1O-00005q-VE
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 07:03:24 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180908090820.15591-1-mark.cave-ayland@ilande.co.uk>
	<20180908090820.15591-4-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5847b117-06d5-f584-3582-a522ef89062f@amsat.org>
Date: Sat, 8 Sep 2018 08:03:09 -0300
MIME-Version: 1.0
In-Reply-To: <20180908090820.15591-4-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] 40p: add fixed IRQ routing for LSI
 SCSI device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, hpoussin@reactos.org, david@gibson.dropbear.id.au, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 9/8/18 6:08 AM, Mark Cave-Ayland wrote:
> Whilst the PReP specification describes how all PCI IRQs are routed via IRQ
> 15 on the interrupt controller, the real 40p machine has routing quirk in
> that the LSI SCSI device is routed to IRQ 13.
> 
> This is implemented using a little hack: the existing IRQ routing code uses
> (irq_num + (pci_dev->devfn >> 3)) & 1 to give the PCI interrupt pin, where
> the "& 1" ensures that the only pins A and B (0 and 1) will ever be used.
> 
> Rather than fix the mask to "& 3" we leave the existing routing above as-is
> and then force the LSI SCSI device to use pin C (2). This enables us to
> route pin 2 permanantly to IRQ 13 since the LSI SCSI device will be its
> only user.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/pci-host/prep.c | 35 +++++++++++++++++++++++++++++++++--
>  hw/ppc/prep.c      | 10 +++++++---
>  2 files changed, 40 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
> index b1b6b16bad..87270605b5 100644
> --- a/hw/pci-host/prep.c
> +++ b/hw/pci-host/prep.c
> @@ -58,6 +58,7 @@ typedef struct PRePPCIState {
>  
>      qemu_or_irq *or_irq;
>      qemu_irq pci_irqs[PCI_NUM_PINS];
> +    qemu_irq scsi_irq;
>      PCIBus pci_bus;
>      AddressSpace pci_io_as;
>      MemoryRegion pci_io;
> @@ -192,14 +193,41 @@ static const MemoryRegionOps raven_io_ops = {
>  
>  static int raven_map_irq(PCIDevice *pci_dev, int irq_num)
>  {
> -    return (irq_num + (pci_dev->devfn >> 3)) & 1;
> +    switch (pci_dev->devfn) {
> +    case PCI_DEVFN(1, 0):
> +        /* Whilst legacy PReP machine exists we need to make
> +         * sure that this fixed interrupt routing is 40p only */
> +        if (strcmp(object_get_typename(OBJECT(pci_dev)),
> +                                       "lsi53c810") == 0) {
> +            /* LSI SCSI */
> +            return 2;
> +        } else {
> +            /* Normal PCI IRQ mapping */
> +            return (irq_num + (pci_dev->devfn >> 3)) & 1;
> +        }
> +    default:
> +        /* Normal PCI IRQ mapping */
> +        return (irq_num + (pci_dev->devfn >> 3)) & 1;
> +    }
>  }
>  
>  static void raven_set_irq(void *opaque, int irq_num, int level)
>  {
>      PREPPCIState *s = opaque;
>  
> -    qemu_set_irq(s->pci_irqs[irq_num], level);
> +    if (s->is_legacy_prep) {
> +        qemu_set_irq(s->pci_irqs[irq_num], level);
> +    } else {
> +        switch (irq_num) {
> +        case 2:
> +            /* LSI SCSI */
> +            qemu_set_irq(s->scsi_irq, level);
> +            break;
> +        default:
> +            /* Normal PCI IRQ mapping */
> +            qemu_set_irq(s->pci_irqs[irq_num], level);
> +        }
> +    }
>  }
>  
>  static AddressSpace *raven_pcihost_set_iommu(PCIBus *bus, void *opaque,
> @@ -242,6 +270,9 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
>          for (i = 0; i < PCI_NUM_PINS; i++) {
>              s->pci_irqs[i] = qdev_get_gpio_in(DEVICE(s->or_irq), i);
>          }
> +
> +        /* 40p LSI SCSI has fixed routing via IRQ 13 */
> +        sysbus_init_irq(dev, &s->scsi_irq);
>      }
>  
>      qdev_init_gpio_in(d, raven_change_gpio, 1);
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 615865e46c..0412a56d98 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -626,6 +626,7 @@ static void ibm_40p_init(MachineState *machine)
>      Nvram *m48t59 = NULL;
>      PCIBus *pci_bus;
>      ISABus *isa_bus;
> +    PCIDevice *pci;
>      void *fw_cfg;
>      int i;
>      uint32_t kernel_base = 0, initrd_base = 0;
> @@ -670,6 +671,7 @@ static void ibm_40p_init(MachineState *machine)
>      qdev_connect_gpio_out(dev, 0,
>                            cpu->env.irq_inputs[PPC6xx_INPUT_INT]);
>      sysbus_connect_irq(pcihost, 0, qdev_get_gpio_in(dev, 15));
> +    sysbus_connect_irq(pcihost, 1, qdev_get_gpio_in(dev, 13));
>      isa_bus = ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
>  
>      /* Memory controller */
> @@ -700,9 +702,11 @@ static void ibm_40p_init(MachineState *machine)
>          qdev_prop_set_uint32(dev, "equipment", 0xc0);
>          qdev_init_nofail(dev);
>  
> -        dev = DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(1, 0),
> -                                       "lsi53c810"));
> -        lsi53c8xx_handle_legacy_cmdline(dev);
> +        pci = PCI_DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(1, 0),
> +                                           "lsi53c810"));
> +        /* Interrupt pin C for fixed LSI SCSI IRQ routing */
> +        pci->config[PCI_INTERRUPT_PIN] = 0x3;
> +        lsi53c8xx_handle_legacy_cmdline(DEVICE(pci));
>  
>          /* XXX: s3-trio at PCI_DEVFN(2, 0) */
>          pci_vga_init(pci_bus);
> 
