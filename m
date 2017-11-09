Received: from eggs.gnu.org ([2001:4830:134:3::10]:38302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eCkbK-0001kR-Fo
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 06:02:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eCkbH-0002cN-9F
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 06:02:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1eCkbH-0002cD-0R
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 06:02:23 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0856D2D5A02
	for <qemu-devel@nongnu.org>; Thu,  9 Nov 2017 11:02:22 +0000 (UTC)
References: <20171108144809.56305-1-marcel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <bb3fdd1b-a1bf-51cf-284c-69eedef0ccde@redhat.com>
Date: Thu, 9 Nov 2017 12:02:10 +0100
MIME-Version: 1.0
In-Reply-To: <20171108144809.56305-1-marcel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V3] hw/pci-host: Fix x86 Host Bridges 64bit
 PCI hole
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, mst@redhat.com, kraxel@redhat.com, imammedo@redhat.com, pbonzini@redhat.com

On 11/08/17 15:48, Marcel Apfelbaum wrote:
> Currently there is no MMIO range over 4G
> reserved for PCI hotplug. Since the 32bit PCI hole
> depends on the number of cold-plugged PCI devices
> and other factors, it is very possible is too small
> to hotplug PCI devices with large BARs.
> 
> Fix it by reserving 2G for I4400FX chipset
> in order to comply with older Win32 Guest OSes
> and 32G for Q35 chipset.
> 
> Note this is a regression since prev QEMU versions had
> some range reserved for 64bit PCI hotplug.
> 
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> ---
> 
> V2 -> V3:
>  - Addressed Gerd's and others comments and re-enabled the pci-hole64-size
>    property defaulting it to 2G for I440FX and 32g for Q35.
>  - Even if the new defaults of pci-hole64-size will appear in "info qtree"
>    also for older machines, the property was not implemented so
>    no changes will be visible to guests.
> 
> V1 -> V2:
>  Addressed Igor's comments:
>     - aligned the hole64 start to 1Gb
>      (I think all the computations took care of it already,
>       but it can't hurt)
>     - Init compat props to "off" instead of "false"
> 
> Thanks,
> Marcel 
> 
> 
> hw/i386/pc.c              | 18 ++++++++++++++++++
>  hw/pci-host/piix.c        | 13 ++++++++++++-
>  hw/pci-host/q35.c         | 17 +++++++++++++++--
>  include/hw/i386/pc.h      | 10 +++++++++-
>  include/hw/pci-host/q35.h |  1 +
>  5 files changed, 55 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index e11a65b545..af3177cca5 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1448,6 +1448,24 @@ void pc_memory_init(PCMachineState *pcms,
>      pcms->ioapic_as = &address_space_memory;
>  }
>  
> +uint64_t pc_pci_hole64_start(void)
> +{
> +    PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
> +    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
> +    uint64_t hole64_start = 0;
> +
> +    if (pcmc->has_reserved_memory && pcms->hotplug_memory.base) {
> +        hole64_start = pcms->hotplug_memory.base;
> +        if (!pcmc->broken_reserved_end) {
> +            hole64_start += memory_region_size(&pcms->hotplug_memory.mr);
> +        }
> +    } else {
> +        hole64_start = 0x100000000ULL + pcms->above_4g_mem_size;
> +    }
> +
> +    return ROUND_UP(hole64_start, 1ULL << 30);
> +}
> +
>  qemu_irq pc_allocate_cpu_irq(void)
>  {
>      return qemu_allocate_irq(pic_irq_request, NULL, 0);
> diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
> index a7e2256870..e033ee7df8 100644
> --- a/hw/pci-host/piix.c
> +++ b/hw/pci-host/piix.c
> @@ -50,6 +50,7 @@ typedef struct I440FXState {
>      PCIHostState parent_obj;
>      Range pci_hole;
>      uint64_t pci_hole64_size;
> +    bool pci_hole64_fix;
>      uint32_t short_root_bus;
>  } I440FXState;
>  
> @@ -243,11 +244,15 @@ static void i440fx_pcihost_get_pci_hole64_start(Object *obj, Visitor *v,
>                                                  void *opaque, Error **errp)
>  {
>      PCIHostState *h = PCI_HOST_BRIDGE(obj);
> +    I440FXState *s = I440FX_PCI_HOST_BRIDGE(obj);
>      Range w64;
>      uint64_t value;
>  
>      pci_bus_get_w64_range(h->bus, &w64);
>      value = range_is_empty(&w64) ? 0 : range_lob(&w64);
> +    if (!value && s->pci_hole64_fix) {
> +        value = pc_pci_hole64_start();
> +    }
>      visit_type_uint64(v, name, &value, errp);
>  }
>  
> @@ -256,11 +261,16 @@ static void i440fx_pcihost_get_pci_hole64_end(Object *obj, Visitor *v,
>                                                Error **errp)
>  {
>      PCIHostState *h = PCI_HOST_BRIDGE(obj);
> +    I440FXState *s = I440FX_PCI_HOST_BRIDGE(obj);
> +    uint64_t hole64_start = pc_pci_hole64_start();
>      Range w64;
>      uint64_t value;
>  
>      pci_bus_get_w64_range(h->bus, &w64);
>      value = range_is_empty(&w64) ? 0 : range_upb(&w64) + 1;
> +    if (s->pci_hole64_fix && value < (hole64_start + s->pci_hole64_size)) {
> +        value = hole64_start + s->pci_hole64_size;
> +    }
>      visit_type_uint64(v, name, &value, errp);
>  }
>  
> @@ -863,8 +873,9 @@ static const char *i440fx_pcihost_root_bus_path(PCIHostState *host_bridge,
>  
>  static Property i440fx_props[] = {
>      DEFINE_PROP_SIZE(PCI_HOST_PROP_PCI_HOLE64_SIZE, I440FXState,
> -                     pci_hole64_size, DEFAULT_PCI_HOLE64_SIZE),
> +                     pci_hole64_size, 1ULL << 31),
>      DEFINE_PROP_UINT32("short_root_bus", I440FXState, short_root_bus, 0),
> +    DEFINE_PROP_BOOL("x-pci-hole64-fix", I440FXState, pci_hole64_fix, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index ddaa7d1b44..f95337c13a 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -104,11 +104,15 @@ static void q35_host_get_pci_hole64_start(Object *obj, Visitor *v,
>                                            Error **errp)
>  {
>      PCIHostState *h = PCI_HOST_BRIDGE(obj);
> +    Q35PCIHost *s = Q35_HOST_DEVICE(obj);
>      Range w64;
>      uint64_t value;
>  
>      pci_bus_get_w64_range(h->bus, &w64);
>      value = range_is_empty(&w64) ? 0 : range_lob(&w64);
> +    if (!value && s->pci_hole64_fix) {
> +        value = pc_pci_hole64_start();
> +    }
>      visit_type_uint64(v, name, &value, errp);
>  }
>  
> @@ -117,11 +121,16 @@ static void q35_host_get_pci_hole64_end(Object *obj, Visitor *v,
>                                          Error **errp)
>  {
>      PCIHostState *h = PCI_HOST_BRIDGE(obj);
> +    Q35PCIHost *s = Q35_HOST_DEVICE(obj);
> +    uint64_t hole64_start = pc_pci_hole64_start();
>      Range w64;
>      uint64_t value;
>  
>      pci_bus_get_w64_range(h->bus, &w64);
>      value = range_is_empty(&w64) ? 0 : range_upb(&w64) + 1;
> +    if (s->pci_hole64_fix && value < (hole64_start + s->mch.pci_hole64_size)) {
> +        value = hole64_start + s->mch.pci_hole64_size;
> +    }
>      visit_type_uint64(v, name, &value, errp);
>  }
>  
> @@ -136,13 +145,15 @@ static void q35_host_get_mmcfg_size(Object *obj, Visitor *v, const char *name,
>  static Property q35_host_props[] = {
>      DEFINE_PROP_UINT64(PCIE_HOST_MCFG_BASE, Q35PCIHost, parent_obj.base_addr,
>                          MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT),
> +    /* The default value is overriden in q35_host_initfn */
>      DEFINE_PROP_SIZE(PCI_HOST_PROP_PCI_HOLE64_SIZE, Q35PCIHost,
> -                     mch.pci_hole64_size, DEFAULT_PCI_HOLE64_SIZE),
> +                     mch.pci_hole64_size, 1ULL << 35),
>      DEFINE_PROP_UINT32("short_root_bus", Q35PCIHost, mch.short_root_bus, 0),
>      DEFINE_PROP_SIZE(PCI_HOST_BELOW_4G_MEM_SIZE, Q35PCIHost,
>                       mch.below_4g_mem_size, 0),
>      DEFINE_PROP_SIZE(PCI_HOST_ABOVE_4G_MEM_SIZE, Q35PCIHost,
>                       mch.above_4g_mem_size, 0),
> +    DEFINE_PROP_BOOL("x-pci-hole64-fix", Q35PCIHost, pci_hole64_fix, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> @@ -174,7 +185,9 @@ static void q35_host_initfn(Object *obj)
>      object_property_add_child(OBJECT(s), "mch", OBJECT(&s->mch), NULL);
>      qdev_prop_set_int32(DEVICE(&s->mch), "addr", PCI_DEVFN(0, 0));
>      qdev_prop_set_bit(DEVICE(&s->mch), "multifunction", false);
> -
> +    /* mch's object_initialize resets the default value, set it again */
> +    qdev_prop_set_uint64(DEVICE(s), PCI_HOST_PROP_PCI_HOLE64_SIZE,
> +                         1ULL << 35);
>      object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
>                          q35_host_get_pci_hole_start,
>                          NULL, NULL, NULL, NULL);
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 087d184ef5..ef438bd765 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -238,7 +238,6 @@ void pc_guest_info_init(PCMachineState *pcms);
>  #define PCI_HOST_PROP_PCI_HOLE64_SIZE  "pci-hole64-size"
>  #define PCI_HOST_BELOW_4G_MEM_SIZE     "below-4g-mem-size"
>  #define PCI_HOST_ABOVE_4G_MEM_SIZE     "above-4g-mem-size"
> -#define DEFAULT_PCI_HOLE64_SIZE (~0x0ULL)
>  
>  
>  void pc_pci_as_mapping_init(Object *owner, MemoryRegion *system_memory,
> @@ -249,6 +248,7 @@ void pc_memory_init(PCMachineState *pcms,
>                      MemoryRegion *system_memory,
>                      MemoryRegion *rom_memory,
>                      MemoryRegion **ram_memory);
> +uint64_t pc_pci_hole64_start(void);
>  qemu_irq pc_allocate_cpu_irq(void);
>  DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus);
>  void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
> @@ -375,6 +375,14 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
>          .driver   = TYPE_X86_CPU,\
>          .property = "x-hv-max-vps",\
>          .value    = "0x40",\
> +    },{\
> +        .driver   = "i440FX-pcihost",\
> +        .property = "x-pci-hole64-fix",\
> +        .value    = "off",\
> +    },{\
> +        .driver   = "q35-pcihost",\
> +        .property = "x-pci-hole64-fix",\
> +        .value    = "off",\
>      },
>  
>  #define PC_COMPAT_2_9 \
> diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
> index 58983c00b3..8f4ddde393 100644
> --- a/include/hw/pci-host/q35.h
> +++ b/include/hw/pci-host/q35.h
> @@ -68,6 +68,7 @@ typedef struct Q35PCIHost {
>      PCIExpressHost parent_obj;
>      /*< public >*/
>  
> +    bool pci_hole64_fix;
>      MCHPCIState mch;
>  } Q35PCIHost;
>  
> 

This is a tricky patch, I stared at it for long. I also re-read the v1
discussion.

Two "logic improvements" I could imagine are:

(1) Failing the "hole64_end" getter functions -- via errp -- if the
user-set pci_hole64_size property is zero (because otherwise we could
configure a zero-sized 64-bit hole if the guest didn't configure any),

(2) in the "hole64_end" getter functions, perhaps we want to round up
the pci_hole64_size property to a multiple of 1GB.

But, we can also say that setting sensible values for the property is
the responsibility of the user / management layer. So I'll leave (1)
and/or (2) up to you.


(3) An idea for the property defaults: you remove
DEFAULT_PCI_HOLE64_SIZE, which is cool. How about introducing (in the
proper header files)

#define DEFAULT_I440FX_PCI_HOLE64_SIZE (1ULL << 31)
#define DEFAULT_Q35_PCI_HOLE64_SIZE    (1ULL << 35)

The main reason for my suggestion is that (1ULL << 35) is used twice in
the code, for an obscure qdev/qom reason. The comments definitely help,
so keep them, but a greppable macro would help even more, IMO.

And, once we add DEFAULT_Q35_PCI_HOLE64_SIZE, we should add
DEFAULT_I440FX_PCI_HOLE64_SIZE too, for consistency.

Anyway, I'll leave this up to you as well.


(4) I also have a suggestion for the commit message: please move the
paragraph that starts with

  "Even if the new defaults..."

from the v2->v3 changelog to the commit message proper. IMO it is
important information.


With (4) addressed:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks!
Laszlo
