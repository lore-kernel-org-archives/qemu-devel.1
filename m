Received: from eggs.gnu.org ([2001:4830:134:3::10]:46027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evLDD-0003zM-SE
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:01:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evLDB-0003O0-O9
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:01:51 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
	<20180306203103.25563-16-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8120d94b-a139-5e67-3328-b2684cdc4c73@amsat.org>
Date: Mon, 12 Mar 2018 12:01:32 +0100
MIME-Version: 1.0
In-Reply-To: <20180306203103.25563-16-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 15/19] uninorth: move PCI IO (ISA) memory
 region into the uninorth device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 03/06/2018 09:30 PM, Mark Cave-Ayland wrote:
> Do this for both the uninorth main and uninorth u3 AGP buses, using the main
> PCI bus for each machine (this ensures the IO addresses still match those
> used by OpenBIOS).
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/pci-host/uninorth.c         | 14 ++++++++++----
>  hw/ppc/mac_newworld.c          | 12 ++++++------
>  include/hw/pci-host/uninorth.h |  1 +
>  3 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
> index e2278fd0f0..3a29a4410e 100644
> --- a/hw/pci-host/uninorth.c
> +++ b/hw/pci-host/uninorth.c
> @@ -127,7 +127,7 @@ static void pci_unin_main_realize(DeviceState *dev, Error **errp)
>                                     pci_unin_set_irq, pci_unin_map_irq,
>                                     s,
>                                     &s->pci_mmio,
> -                                   get_system_io(),
> +                                   &s->pci_io,
>                                     PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
>  
>      pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north-pci");
> @@ -155,6 +155,8 @@ static void pci_unin_main_init(Object *obj)
>  
>      memory_region_init(&s->pci_mmio, OBJECT(s), "unin-pci-mmio",
>                         0x100000000ULL);
> +    memory_region_init_io(&s->pci_io, OBJECT(s), &unassigned_io_ops, obj,
> +                          "unin-pci-isa-mmio", 0x00800000);
>  
>      memory_region_init_alias(&s->pci_hole, OBJECT(s),
>                               "unin-pci-hole", &s->pci_mmio,
> @@ -168,6 +170,7 @@ static void pci_unin_main_init(Object *obj)
>      sysbus_init_mmio(sbd, &h->conf_mem);
>      sysbus_init_mmio(sbd, &h->data_mem);
>      sysbus_init_mmio(sbd, &s->pci_hole);
> +    sysbus_init_mmio(sbd, &s->pci_io);
>  }
>  
>  static void pci_u3_agp_realize(DeviceState *dev, Error **errp)
> @@ -179,7 +182,7 @@ static void pci_u3_agp_realize(DeviceState *dev, Error **errp)
>                                     pci_unin_set_irq, pci_unin_map_irq,
>                                     s,
>                                     &s->pci_mmio,
> -                                   get_system_io(),
> +                                   &s->pci_io,
>                                     PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
>  
>      pci_create_simple(h->bus, PCI_DEVFN(11, 0), "u3-agp");
> @@ -200,6 +203,8 @@ static void pci_u3_agp_init(Object *obj)
>  
>      memory_region_init(&s->pci_mmio, OBJECT(s), "unin-pci-mmio",
>                         0x100000000ULL);
> +    memory_region_init_io(&s->pci_io, OBJECT(s), &unassigned_io_ops, obj,
> +                          "unin-pci-isa-mmio", 0x00800000);
>  
>      memory_region_init_alias(&s->pci_hole, OBJECT(s),
>                               "unin-pci-hole", &s->pci_mmio,
> @@ -213,6 +218,7 @@ static void pci_u3_agp_init(Object *obj)
>      sysbus_init_mmio(sbd, &h->conf_mem);
>      sysbus_init_mmio(sbd, &h->data_mem);
>      sysbus_init_mmio(sbd, &s->pci_hole);
> +    sysbus_init_mmio(sbd, &s->pci_io);
>  }
>  
>  static void pci_unin_agp_realize(DeviceState *dev, Error **errp)
> @@ -224,7 +230,7 @@ static void pci_unin_agp_realize(DeviceState *dev, Error **errp)
>                                     pci_unin_set_irq, pci_unin_map_irq,
>                                     s,
>                                     &s->pci_mmio,
> -                                   get_system_io(),
> +                                   &s->pci_io,
>                                     PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
>  
>      pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north-agp");
> @@ -261,7 +267,7 @@ static void pci_unin_internal_realize(DeviceState *dev, Error **errp)
>                                     pci_unin_set_irq, pci_unin_map_irq,
>                                     s,
>                                     &s->pci_mmio,
> -                                   get_system_io(),
> +                                   &s->pci_io,
>                                     PCI_DEVFN(14, 0), 4, TYPE_PCI_BUS);
>  
>      pci_create_simple(h->bus, PCI_DEVFN(14, 0), "uni-north-internal-pci");
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 5d121a6071..5cb9f9abd0 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -146,7 +146,6 @@ static void ppc_core99_init(MachineState *machine)
>      CPUPPCState *env = NULL;
>      char *filename;
>      qemu_irq *pic, **openpic_irqs;
> -    MemoryRegion *isa = g_new(MemoryRegion, 1);
>      MemoryRegion *unin_memory = g_new(MemoryRegion, 1);
>      int linux_boot, i, j, k;
>      MemoryRegion *ram = g_new(MemoryRegion, 1), *bios = g_new(MemoryRegion, 1);
> @@ -274,11 +273,6 @@ static void ppc_core99_init(MachineState *machine)
>          }
>      }
>  
> -    /* Register 8 MB of ISA IO space */
> -    memory_region_init_alias(isa, NULL, "isa_mmio",
> -                             get_system_io(), 0, 0x00800000);
> -    memory_region_add_subregion(get_system_memory(), 0xf2000000, isa);
> -
>      /* UniN init: XXX should be a real device */
>      memory_region_init_io(unin_memory, NULL, &unin_ops, token, "unin", 0x1000);
>      memory_region_add_subregion(get_system_memory(), 0xf8000000, unin_memory);
> @@ -356,6 +350,9 @@ static void ppc_core99_init(MachineState *machine)
>          /* PCI hole */
>          memory_region_add_subregion(get_system_memory(), 0x80000000ULL,
>                                      sysbus_mmio_get_region(s, 2));
> +        /* Register 8 MB of ISA IO space */
> +        memory_region_add_subregion(get_system_memory(), 0xf2000000,
> +                                    sysbus_mmio_get_region(s, 3));
>          sysbus_mmio_map(s, 0, 0xf0800000);
>          sysbus_mmio_map(s, 1, 0xf0c00000);
>  
> @@ -390,6 +387,9 @@ static void ppc_core99_init(MachineState *machine)
>          /* PCI hole */
>          memory_region_add_subregion(get_system_memory(), 0x80000000ULL,
>                                      sysbus_mmio_get_region(s, 2));
> +        /* Register 8 MB of ISA IO space */
> +        memory_region_add_subregion(get_system_memory(), 0xf2000000,
> +                                    sysbus_mmio_get_region(s, 3));
>          sysbus_mmio_map(s, 0, 0xf2800000);
>          sysbus_mmio_map(s, 1, 0xf2c00000);
>  
> diff --git a/include/hw/pci-host/uninorth.h b/include/hw/pci-host/uninorth.h
> index 6b520e753c..c4771aa7fa 100644
> --- a/include/hw/pci-host/uninorth.h
> +++ b/include/hw/pci-host/uninorth.h
> @@ -48,6 +48,7 @@ typedef struct UNINState {
>      qemu_irq irqs[4];
>      MemoryRegion pci_mmio;
>      MemoryRegion pci_hole;
> +    MemoryRegion pci_io;
>  } UNINState;
>  
>  #endif /* UNINORTH_H */
> 
