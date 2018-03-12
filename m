Received: from eggs.gnu.org ([2001:4830:134:3::10]:45655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evLBX-0002Xv-IJ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:00:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evLBW-0000HP-EM
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:00:07 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
	<20180306203103.25563-7-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0d2403d3-36ba-030a-3799-b55bef8074d0@amsat.org>
Date: Mon, 12 Mar 2018 11:59:55 +0100
MIME-Version: 1.0
In-Reply-To: <20180306203103.25563-7-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 06/19] uninorth: alter pci_pmac_init() and
 pci_pmac_u3_init() to return uninorth device
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
> This is in preparation for moving the device wiring into the New World machine.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/pci-host/uninorth.c | 16 ++++++++--------
>  hw/ppc/mac.h           | 10 ++++++----
>  hw/ppc/mac_newworld.c  | 10 ++++++++--
>  3 files changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
> index 600d675573..b081e3c153 100644
> --- a/hw/pci-host/uninorth.c
> +++ b/hw/pci-host/uninorth.c
> @@ -166,9 +166,9 @@ static void pci_unin_internal_init(Object *obj)
>      sysbus_init_mmio(sbd, &h->data_mem);
>  }
>  
> -PCIBus *pci_pmac_init(qemu_irq *pic,
> -                      MemoryRegion *address_space_mem,
> -                      MemoryRegion *address_space_io)
> +UNINState *pci_pmac_init(qemu_irq *pic,
> +                         MemoryRegion *address_space_mem,
> +                         MemoryRegion *address_space_io)
>  {
>      DeviceState *dev;
>      SysBusDevice *s;
> @@ -228,12 +228,12 @@ PCIBus *pci_pmac_init(qemu_irq *pic,
>      sysbus_mmio_map(s, 1, 0xf4c00000);
>  #endif
>  
> -    return h->bus;
> +    return d;
>  }
>  
> -PCIBus *pci_pmac_u3_init(qemu_irq *pic,
> -                         MemoryRegion *address_space_mem,
> -                         MemoryRegion *address_space_io)
> +UNINState *pci_pmac_u3_init(qemu_irq *pic,
> +                            MemoryRegion *address_space_mem,
> +                            MemoryRegion *address_space_io)
>  {
>      DeviceState *dev;
>      SysBusDevice *s;
> @@ -265,7 +265,7 @@ PCIBus *pci_pmac_u3_init(qemu_irq *pic,
>  
>      pci_create_simple(h->bus, 11 << 3, "u3-agp");
>  
> -    return h->bus;
> +    return d;
>  }
>  
>  static void unin_main_pci_host_realize(PCIDevice *d, Error **errp)
> diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
> index a02f797598..fcf13cb757 100644
> --- a/hw/ppc/mac.h
> +++ b/hw/ppc/mac.h
> @@ -31,6 +31,8 @@
>  #include "hw/ide/internal.h"
>  #include "hw/input/adb.h"
>  #include "hw/misc/mos6522.h"
> +#include "hw/pci/pci_host.h"
> +#include "hw/pci-host/uninorth.h"
>  
>  /* SMP is not enabled, for now */
>  #define MAX_CPUS 1
> @@ -86,12 +88,12 @@ PCIBus *pci_grackle_init(uint32_t base, qemu_irq *pic,
>                           MemoryRegion *address_space_io);
>  
>  /* UniNorth PCI */
> -PCIBus *pci_pmac_init(qemu_irq *pic,
> -                      MemoryRegion *address_space_mem,
> -                      MemoryRegion *address_space_io);
> -PCIBus *pci_pmac_u3_init(qemu_irq *pic,
> +UNINState *pci_pmac_init(qemu_irq *pic,
>                           MemoryRegion *address_space_mem,
>                           MemoryRegion *address_space_io);
> +UNINState *pci_pmac_u3_init(qemu_irq *pic,
> +                            MemoryRegion *address_space_mem,
> +                            MemoryRegion *address_space_io);
>  
>  /* Mac NVRAM */
>  #define TYPE_MACIO_NVRAM "macio-nvram"
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 3410bb13ad..34908d0dd7 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -152,6 +152,7 @@ static void ppc_core99_init(MachineState *machine)
>      MemoryRegion *ram = g_new(MemoryRegion, 1), *bios = g_new(MemoryRegion, 1);
>      hwaddr kernel_base, initrd_base, cmdline_base = 0;
>      long kernel_size, initrd_size;
> +    UNINState *uninorth_pci;
>      PCIBus *pci_bus;
>      NewWorldMacIOState *macio;
>      MACIOIDEState *macio_ide;
> @@ -345,10 +346,12 @@ static void ppc_core99_init(MachineState *machine)
>  
>      if (PPC_INPUT(env) == PPC_FLAGS_INPUT_970) {
>          /* 970 gets a U3 bus */
> -        pci_bus = pci_pmac_u3_init(pic, get_system_memory(), get_system_io());
> +        uninorth_pci = pci_pmac_u3_init(pic, get_system_memory(),
> +                                        get_system_io());
>          machine_arch = ARCH_MAC99_U3;
>      } else {
> -        pci_bus = pci_pmac_init(pic, get_system_memory(), get_system_io());
> +        uninorth_pci = pci_pmac_init(pic, get_system_memory(),
> +                                     get_system_io());
>          machine_arch = ARCH_MAC99;
>      }
>  
> @@ -361,6 +364,9 @@ static void ppc_core99_init(MachineState *machine)
>          tbfreq = TBFREQ;
>      }
>  
> +    /* init basic PC hardware */
> +    pci_bus = PCI_HOST_BRIDGE(uninorth_pci)->bus;
> +
>      /* MacIO */
>      macio = NEWWORLD_MACIO(pci_create(pci_bus, -1, TYPE_NEWWORLD_MACIO));
>      dev = DEVICE(macio);
> 
