Received: from eggs.gnu.org ([2001:4830:134:3::10]:37264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gNc0l-0007lc-G3
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 06:10:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gNc0k-0005xJ-0j
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 06:10:07 -0500
Date: Fri, 16 Nov 2018 12:09:48 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181116120948.7ce7bcd5@redhat.com>
In-Reply-To: <20181105014047.26447-23-sameo@linux.intel.com>
References: <20181105014047.26447-1-sameo@linux.intel.com>
	<20181105014047.26447-23-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 22/24] hw: pci-host: piix: Return PCI
 host pointer instead of PCI bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Auger Eric <eric.auger@redhat.com>, Andrew Jones <drjones@redhat.com>

On Mon,  5 Nov 2018 02:40:45 +0100
Samuel Ortiz <sameo@linux.intel.com> wrote:

All remaining patches a bit out of proper order,
they should be around patch 12/24 where you started to touch MCFG code.

> For building the MCFG table, we need to track a given machine
> type PCI host pointer, and we can't get it from the bus pointer alone.
> As piix returns a PCI bus pointer, we simply modify its builder to
> return a PCI host pointer instead.
PC machine doesn't build MCFG so we don't really need it to provide
this pointer, having this patch doesn't hurt but I'm not sure we
need it.

CCing ARM folks since we are talking about generalizing MCFG table generation.

we have following invariants wrt using MCFG:

   pc [pci_host != NULL] -> bail out early + do not build MCFG

   pc [pci_host == NULL] -> would explode if not only for [has_acpi_build = false] guard
                            should be: do not even call acpi_get_mcfg().

   q35 [pci_host == NULL] -> not valid combo and must assert

   q35 [pci_host != NULL && mcfg_base != PCIE_BASE_ADDR_UNMAPPED]
        generate MCFG using mcfg_base/size

   q35 [pci_host != NULL && mcfg_base == PCIE_BASE_ADDR_UNMAPPED]
        generate place-holder 'QEMU' table for legacy machine versions without
        resizable MemoryRegion support.
        Mapped/not mapped could be dynamic accross reboots, so we need
        access to PCIE(pci_host) to fetch current values.

   arm/virt gpex [memmap[ecam_id].base/size] do build MCFG
        hacked up variant that doesn't use pci_host mcfg_base/size fields
        not sure if it's possible to disable ecam as on q35 (does it need any fixing?)
        we should fix arm/virt to use pci-host mcfg_base/size so we
        could reuse properties PCIE_HOST_MCFG_BASE/PCIE_HOST_MCFG_SIZE
        on ARM and generic build_mcfg()

So we have quite a mess here, the current acpi_get_mcfg() does 2 things
  1. indirectly checks that pci_host is PCI-E (presence of PCIE_HOST_MCFG_BASE property)
  2. fetches mcfg_base/size if it's PCI-E host

and i386/build_mcfg() is called only when #1 is true

As far as see we use pci_host only to fetch mcfg_base/size and not for anything
else.
Maybe as refactoring plan we should"
 * pass to acpi_setup(PCIHostState* pcie_host) as an argument pcie host pointer,
   which for PC will be NULL and for the rest set it to q35/gxpe/... PCI-E host.
 * call build_mcfg() if pcie_host != NULL
   (no more indirect guessing using PCIE_HOST_MCFG_BASE property presence)
 * move MCFG/QEMU table signature decision out of build_mcfg() and pass
   it as argument 'build_mcfg(...,char *mcfg_signature)'. It moves out masking
   table quirk into caller, where q35 can decide to change signature
   if ECAM is not mapped. The rest (arm|i386/virt) will always pass 'MCFG'.
   Or even better if ecam is mapped, create MCFG (with masking trick if q35
   machine is old and do not support resizable MemoryRegions).

> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  include/hw/i386/pc.h | 21 +++++++++++----------
>  hw/i386/pc_piix.c    | 18 +++++++++++-------
>  hw/pci-host/piix.c   | 24 ++++++++++++------------
>  3 files changed, 34 insertions(+), 29 deletions(-)
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 8e5f1464eb..b6b79e146d 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -244,16 +244,17 @@ typedef struct PCII440FXState PCII440FXState;
>   */
>  #define RCR_IOPORT 0xcf9
>  
> -PCIBus *i440fx_init(const char *host_type, const char *pci_type,
> -                    PCII440FXState **pi440fx_state, int *piix_devfn,
> -                    ISABus **isa_bus, qemu_irq *pic,
> -                    MemoryRegion *address_space_mem,
> -                    MemoryRegion *address_space_io,
> -                    ram_addr_t ram_size,
> -                    ram_addr_t below_4g_mem_size,
> -                    ram_addr_t above_4g_mem_size,
> -                    MemoryRegion *pci_memory,
> -                    MemoryRegion *ram_memory);
> +struct PCIHostState *i440fx_init(const char *host_type, const char *pci_type,
> +                                 PCII440FXState **pi440fx_state,
> +                                 int *piix_devfn,
> +                                 ISABus **isa_bus, qemu_irq *pic,
> +                                 MemoryRegion *address_space_mem,
> +                                 MemoryRegion *address_space_io,
> +                                 ram_addr_t ram_size,
> +                                 ram_addr_t below_4g_mem_size,
> +                                 ram_addr_t above_4g_mem_size,
> +                                 MemoryRegion *pci_memory,
> +                                 MemoryRegion *ram_memory);
>  
>  /* piix4.c */
>  extern PCIDevice *piix4_dev;
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 0620d10715..f5b139a3eb 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -32,6 +32,7 @@
>  #include "hw/display/ramfb.h"
>  #include "hw/smbios/smbios.h"
>  #include "hw/pci/pci.h"
> +#include "hw/pci/pci_host.h"
>  #include "hw/pci/pci_ids.h"
>  #include "hw/usb.h"
>  #include "net/net.h"
> @@ -75,6 +76,7 @@ static void pc_init1(MachineState *machine,
>      MemoryRegion *system_memory = get_system_memory();
>      MemoryRegion *system_io = get_system_io();
>      int i;
> +    struct PCIHostState *pci_host;
>      PCIBus *pci_bus;
>      ISABus *isa_bus;
>      PCII440FXState *i440fx_state;
> @@ -196,15 +198,17 @@ static void pc_init1(MachineState *machine,
>      }
>  
>      if (pcmc->pci_enabled) {
> -        pci_bus = i440fx_init(host_type,
> -                              pci_type,
> -                              &i440fx_state, &piix3_devfn, &isa_bus, pcms->gsi,
> -                              system_memory, system_io, machine->ram_size,
> -                              acpi_conf->below_4g_mem_size,
> -                              acpi_conf->above_4g_mem_size,
> -                              pci_memory, ram_memory);
> +        pci_host = i440fx_init(host_type,
> +                               pci_type,
> +                               &i440fx_state, &piix3_devfn, &isa_bus, pcms->gsi,
> +                               system_memory, system_io, machine->ram_size,
> +                               acpi_conf->below_4g_mem_size,
> +                               acpi_conf->above_4g_mem_size,
> +                               pci_memory, ram_memory);
> +        pci_bus = pci_host->bus;
>          pcms->bus = pci_bus;
>      } else {
> +        pci_host = NULL;
>          pci_bus = NULL;
>          i440fx_state = NULL;
>          isa_bus = isa_bus_new(NULL, get_system_memory(), system_io,
> diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
> index 658460264b..4a412db44c 100644
> --- a/hw/pci-host/piix.c
> +++ b/hw/pci-host/piix.c
> @@ -342,17 +342,17 @@ static void i440fx_realize(PCIDevice *dev, Error **errp)
>      }
>  }
>  
> -PCIBus *i440fx_init(const char *host_type, const char *pci_type,
> -                    PCII440FXState **pi440fx_state,
> -                    int *piix3_devfn,
> -                    ISABus **isa_bus, qemu_irq *pic,
> -                    MemoryRegion *address_space_mem,
> -                    MemoryRegion *address_space_io,
> -                    ram_addr_t ram_size,
> -                    ram_addr_t below_4g_mem_size,
> -                    ram_addr_t above_4g_mem_size,
> -                    MemoryRegion *pci_address_space,
> -                    MemoryRegion *ram_memory)
> +struct PCIHostState *i440fx_init(const char *host_type, const char *pci_type,
> +                                 PCII440FXState **pi440fx_state,
> +                                 int *piix3_devfn,
> +                                 ISABus **isa_bus, qemu_irq *pic,
> +                                 MemoryRegion *address_space_mem,
> +                                 MemoryRegion *address_space_io,
> +                                 ram_addr_t ram_size,
> +                                 ram_addr_t below_4g_mem_size,
> +                                 ram_addr_t above_4g_mem_size,
> +                                 MemoryRegion *pci_address_space,
> +                                 MemoryRegion *ram_memory)
>  {
>      DeviceState *dev;
>      PCIBus *b;
> @@ -442,7 +442,7 @@ PCIBus *i440fx_init(const char *host_type, const char *pci_type,
>  
>      i440fx_update_memory_mappings(f);
>  
> -    return b;
> +    return s;
>  }
>  
>  /* PIIX3 PCI to ISA bridge */
