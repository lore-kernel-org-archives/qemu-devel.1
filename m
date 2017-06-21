Received: from eggs.gnu.org ([2001:4830:134:3::10]:55545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dNV1E-0005H3-3W
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 22:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dNV1A-00041q-SR
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 22:05:20 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:35449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dNV1A-00041U-Er
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 22:05:16 -0400
Received: by mail-pg0-x241.google.com with SMTP id f127so24835400pgc.2
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 19:05:15 -0700 (PDT)
References: <20170614063607.47863-1-aik@ozlabs.ru>
	<20170614063607.47863-3-aik@ozlabs.ru>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <653b598c-d838-ee69-5848-ae7ea85f5376@ozlabs.ru>
Date: Wed, 21 Jun 2017 12:05:08 +1000
MIME-Version: 1.0
In-Reply-To: <20170614063607.47863-3-aik@ozlabs.ru>
Content-Type: text/plain; charset=koi8-r
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v8 2/2] memory/iommu: introduce
 IOMMUMemoryRegionClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Xu <peterx@redhat.com>

On 14/06/17 16:36, Alexey Kardashevskiy wrote:
> This finishes QOM'fication of IOMMUMemoryRegion by introducing
> a IOMMUMemoryRegionClass. This also provides a fastpath analog for
> IOMMU_MEMORY_REGION_GET_CLASS().


Ping?


> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  hw/i386/amd_iommu.h           |  3 ---
>  include/exec/memory.h         | 45 +++++++++++++++++++++++++++++++++----------
>  include/hw/i386/intel_iommu.h |  1 -
>  include/hw/ppc/spapr.h        |  4 ++++
>  exec.c                        |  6 ++++--
>  hw/alpha/typhoon.c            | 23 +++++++++++++++++-----
>  hw/dma/rc4030.c               | 26 +++++++++++++++++++------
>  hw/i386/amd_iommu.c           | 26 +++++++++++++++++++++----
>  hw/i386/intel_iommu.c         | 27 +++++++++++++++++++++-----
>  hw/pci-host/apb.c             | 23 +++++++++++++++++-----
>  hw/ppc/spapr_iommu.c          | 26 ++++++++++++++++++-------
>  hw/s390x/s390-pci-bus.c       | 25 ++++++++++++++++++------
>  hw/s390x/s390-pci-inst.c      |  5 ++++-
>  memory.c                      | 36 +++++++++++++++++++---------------
>  14 files changed, 206 insertions(+), 70 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index 0d3dc6a9f2..a5a1c32c8b 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -276,9 +276,6 @@ typedef struct AMDVIState {
>      uint8_t romask[AMDVI_MMIO_SIZE];   /* MMIO read/only mask          */
>      bool mmio_enabled;
>  
> -    /* IOMMU function */
> -    MemoryRegionIOMMUOps iommu_ops;
> -
>      /* for each served device */
>      AMDVIAddressSpace **address_spaces[PCI_BUS_MAX];
>  
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 8aefea3abc..64f6735aaa 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -25,6 +25,7 @@
>  #include "qemu/notify.h"
>  #include "qom/object.h"
>  #include "qemu/rcu.h"
> +#include "hw/qdev-core.h"
>  
>  #define RAM_ADDR_INVALID (~(ram_addr_t)0)
>  
> @@ -38,6 +39,12 @@
>  #define TYPE_IOMMU_MEMORY_REGION "qemu:iommu-memory-region"
>  #define IOMMU_MEMORY_REGION(obj) \
>          OBJECT_CHECK(IOMMUMemoryRegion, (obj), TYPE_IOMMU_MEMORY_REGION)
> +#define IOMMU_MEMORY_REGION_CLASS(klass) \
> +        OBJECT_CLASS_CHECK(IOMMUMemoryRegionClass, (klass), \
> +                         TYPE_IOMMU_MEMORY_REGION)
> +#define IOMMU_MEMORY_REGION_GET_CLASS(obj) \
> +        OBJECT_GET_CLASS(IOMMUMemoryRegionClass, (obj), \
> +                         TYPE_IOMMU_MEMORY_REGION)
>  
>  typedef struct MemoryRegionOps MemoryRegionOps;
>  typedef struct MemoryRegionMmio MemoryRegionMmio;
> @@ -184,9 +191,10 @@ struct MemoryRegionOps {
>      const MemoryRegionMmio old_mmio;
>  };
>  
> -typedef struct MemoryRegionIOMMUOps MemoryRegionIOMMUOps;
> +typedef struct IOMMUMemoryRegionClass {
> +    /* private */
> +    struct DeviceClass parent_class;
>  
> -struct MemoryRegionIOMMUOps {
>      /*
>       * Return a TLB entry that contains a given address. Flag should
>       * be the access permission of this translation operation. We can
> @@ -203,7 +211,7 @@ struct MemoryRegionIOMMUOps {
>                                  IOMMUNotifierFlag new_flags);
>      /* Set this up to provide customized IOMMU replay function */
>      void (*replay)(IOMMUMemoryRegion *iommu, IOMMUNotifier *notifier);
> -};
> +} IOMMUMemoryRegionClass;
>  
>  typedef struct CoalescedMemoryRange CoalescedMemoryRange;
>  typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
> @@ -252,7 +260,6 @@ struct MemoryRegion {
>  struct IOMMUMemoryRegion {
>      MemoryRegion parent_obj;
>  
> -    const MemoryRegionIOMMUOps *iommu_ops;
>      QLIST_HEAD(, IOMMUNotifier) iommu_notify;
>      IOMMUNotifierFlag iommu_notify_flags;
>  };
> @@ -593,21 +600,24 @@ static inline void memory_region_init_reservation(MemoryRegion *mr,
>  }
>  
>  /**
> - * memory_region_init_iommu: Initialize a memory region that translates
> - * addresses
> + * memory_region_init_iommu: Initialize a memory region of a custom type
> + * that translates addresses
>   *
>   * An IOMMU region translates addresses and forwards accesses to a target
>   * memory region.
>   *
> - * @iommu_mr: the #IOMMUMemoryRegion to be initialized
> + * @typename: QOM class name
> + * @_iommu_mr: the #IOMMUMemoryRegion to be initialized
> + * @instance_size: the IOMMUMemoryRegion subclass instance size
>   * @owner: the object that tracks the region's reference count
>   * @ops: a function that translates addresses into the @target region
>   * @name: used for debugging; not visible to the user or ABI
>   * @size: size of the region.
>   */
> -void memory_region_init_iommu(IOMMUMemoryRegion *iommu_mr,
> -                              struct Object *owner,
> -                              const MemoryRegionIOMMUOps *ops,
> +void memory_region_init_iommu(void *_iommu_mr,
> +                              size_t instance_size,
> +                              const char *mrtypename,
> +                              Object *owner,
>                                const char *name,
>                                uint64_t size);
>  
> @@ -678,6 +688,21 @@ static inline IOMMUMemoryRegion *memory_region_get_iommu(MemoryRegion *mr)
>      return NULL;
>  }
>  
> +/**
> + * memory_region_get_iommu_class_nocheck: returns iommu memory region class
> + *   if an iommu or NULL if not
> + *
> + * Returns pointer to IOMMUMemoryRegioniClass if a memory region is an iommu,
> + * otherwise NULL. This is fast path avoinding QOM checking, use with caution.
> + *
> + * @mr: the memory region being queried
> + */
> +static inline IOMMUMemoryRegionClass *memory_region_get_iommu_class_nocheck(
> +        IOMMUMemoryRegion *iommu_mr)
> +{
> +    return (IOMMUMemoryRegionClass *) (((Object *)iommu_mr)->class);
> +}
> +
>  #define memory_region_is_iommu(mr) (memory_region_get_iommu(mr) != NULL)
>  
>  /**
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 45fba4ff97..e5b5a8ff27 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -289,7 +289,6 @@ struct IntelIOMMUState {
>      uint32_t context_cache_gen;     /* Should be in [1,MAX] */
>      GHashTable *iotlb;              /* IOTLB */
>  
> -    MemoryRegionIOMMUOps iommu_ops;
>      GHashTable *vtd_as_by_busptr;   /* VTDBus objects indexed by PCIBus* reference */
>      VTDBus *vtd_as_by_bus_num[VTD_PCI_BUS_MAX]; /* VTDBus objects indexed by bus number */
>      /* list of registered notifiers */
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 6bd338156b..13b2d88330 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -579,6 +579,10 @@ typedef struct sPAPRTCETable sPAPRTCETable;
>  #define SPAPR_TCE_TABLE(obj) \
>      OBJECT_CHECK(sPAPRTCETable, (obj), TYPE_SPAPR_TCE_TABLE)
>  
> +#define TYPE_SPAPR_IOMMU_MEMORY_REGION "qemu:spapr-iommu-memory-region"
> +#define SPAPR_IOMMU_MEMORY_REGION(obj) \
> +        OBJECT_CHECK(IOMMUMemoryRegion, (obj), TYPE_SPAPR_IOMMU_MEMORY_REGION)
> +
>  struct sPAPRTCETable {
>      DeviceState parent;
>      uint32_t liobn;
> diff --git a/exec.c b/exec.c
> index 182cc9b9b9..acba7fc303 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -476,6 +476,7 @@ static MemoryRegionSection address_space_do_translate(AddressSpace *as,
>      IOMMUTLBEntry iotlb;
>      MemoryRegionSection *section;
>      IOMMUMemoryRegion *iommu_mr;
> +    IOMMUMemoryRegionClass *imrc;
>  
>      for (;;) {
>          AddressSpaceDispatch *d = atomic_rcu_read(&as->dispatch);
> @@ -485,9 +486,10 @@ static MemoryRegionSection address_space_do_translate(AddressSpace *as,
>          if (!iommu_mr) {
>              break;
>          }
> +        imrc = memory_region_get_iommu_class_nocheck(iommu_mr);
>  
> -        iotlb = iommu_mr->iommu_ops->translate(iommu_mr, addr, is_write ?
> -                                               IOMMU_WO : IOMMU_RO);
> +        iotlb = imrc->translate(iommu_mr, addr, is_write ?
> +                                IOMMU_WO : IOMMU_RO);
>          addr = ((iotlb.translated_addr & ~iotlb.addr_mask)
>                  | (addr & iotlb.addr_mask));
>          *plen = MIN(*plen, (addr | iotlb.addr_mask) - addr + 1);
> diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
> index dd47b4569f..491433e12f 100644
> --- a/hw/alpha/typhoon.c
> +++ b/hw/alpha/typhoon.c
> @@ -17,6 +17,7 @@
>  
>  
>  #define TYPE_TYPHOON_PCI_HOST_BRIDGE "typhoon-pcihost"
> +#define TYPE_TYPHOON_IOMMU_MEMORY_REGION "typhoon:iommu_memory_region"
>  
>  typedef struct TyphoonCchip {
>      MemoryRegion region;
> @@ -725,10 +726,6 @@ static IOMMUTLBEntry typhoon_translate_iommu(IOMMUMemoryRegion *iommu,
>      return ret;
>  }
>  
> -static const MemoryRegionIOMMUOps typhoon_iommu_ops = {
> -    .translate = typhoon_translate_iommu,
> -};
> -
>  static AddressSpace *typhoon_pci_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>  {
>      TyphoonState *s = opaque;
> @@ -892,7 +889,8 @@ PCIBus *typhoon_init(ram_addr_t ram_size, ISABus **isa_bus,
>      qdev_init_nofail(dev);
>  
>      /* Host memory as seen from the PCI side, via the IOMMU.  */
> -    memory_region_init_iommu(&s->pchip.iommu, OBJECT(s), &typhoon_iommu_ops,
> +    memory_region_init_iommu(&s->pchip.iommu, sizeof(s->pchip.iommu),
> +                             TYPE_TYPHOON_IOMMU_MEMORY_REGION, OBJECT(s),
>                               "iommu-typhoon", UINT64_MAX);
>      address_space_init(&s->pchip.iommu_as, MEMORY_REGION(&s->pchip.iommu),
>                         "pchip0-pci");
> @@ -953,9 +951,24 @@ static const TypeInfo typhoon_pcihost_info = {
>      .class_init    = typhoon_pcihost_class_init,
>  };
>  
> +static void typhoon_iommu_memory_region_class_init(ObjectClass *klass,
> +                                                   void *data)
> +{
> +    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
> +
> +    imrc->translate = typhoon_translate_iommu;
> +}
> +
> +static const TypeInfo typhoon_iommu_memory_region_info = {
> +    .parent = TYPE_IOMMU_MEMORY_REGION,
> +    .name = TYPE_TYPHOON_IOMMU_MEMORY_REGION,
> +    .class_init = typhoon_iommu_memory_region_class_init,
> +};
> +
>  static void typhoon_register_types(void)
>  {
>      type_register_static(&typhoon_pcihost_info);
> +    type_register_static(&typhoon_iommu_memory_region_info);
>  }
>  
>  type_init(typhoon_register_types)
> diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
> index 32c06760ef..6a49e4ef4a 100644
> --- a/hw/dma/rc4030.c
> +++ b/hw/dma/rc4030.c
> @@ -54,6 +54,8 @@ typedef struct dma_pagetable_entry {
>  #define RC4030(obj) \
>      OBJECT_CHECK(rc4030State, (obj), TYPE_RC4030)
>  
> +#define TYPE_RC4030_IOMMU_MEMORY_REGION "rc4030:iommu_memory_region"
> +
>  typedef struct rc4030State
>  {
>      SysBusDevice parent;
> @@ -516,10 +518,6 @@ static IOMMUTLBEntry rc4030_dma_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
>      return ret;
>  }
>  
> -static const MemoryRegionIOMMUOps rc4030_dma_ops = {
> -    .translate = rc4030_dma_translate,
> -};
> -
>  static void rc4030_reset(DeviceState *dev)
>  {
>      rc4030State *s = RC4030(dev);
> @@ -677,8 +675,9 @@ static void rc4030_realize(DeviceState *dev, Error **errp)
>      memory_region_init_io(&s->iomem_jazzio, NULL, &jazzio_ops, s,
>                            "rc4030.jazzio", 0x00001000);
>  
> -    memory_region_init_iommu(&s->dma_mr, o, &rc4030_dma_ops,
> -                             "rc4030.dma", UINT32_MAX);
> +    memory_region_init_iommu(&s->dma_mr, sizeof(s->dma_mr),
> +                             TYPE_RC4030_IOMMU_MEMORY_REGION,
> +                             o, "rc4030.dma", UINT32_MAX);
>      address_space_init(&s->dma_as, MEMORY_REGION(&s->dma_mr), "rc4030-dma");
>  }
>  
> @@ -710,9 +709,24 @@ static const TypeInfo rc4030_info = {
>      .class_init = rc4030_class_init,
>  };
>  
> +static void rc4030_iommu_memory_region_class_init(ObjectClass *klass,
> +                                                  void *data)
> +{
> +    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
> +
> +    imrc->translate = rc4030_dma_translate;
> +}
> +
> +static const TypeInfo rc4030_iommu_memory_region_info = {
> +    .parent = TYPE_IOMMU_MEMORY_REGION,
> +    .name = TYPE_RC4030_IOMMU_MEMORY_REGION,
> +    .class_init = rc4030_iommu_memory_region_class_init,
> +};
> +
>  static void rc4030_register_types(void)
>  {
>      type_register_static(&rc4030_info);
> +    type_register_static(&rc4030_iommu_memory_region_info);
>  }
>  
>  type_init(rc4030_register_types)
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 69e68a3e1b..af19e8ea41 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -25,6 +25,8 @@
>  #include "qemu/error-report.h"
>  #include "trace.h"
>  
> +#define TYPE_AMD_VI_IOMMU_MEMORY_REGION "amd_vi:iommu_memory_region"
> +
>  /* used AMD-Vi MMIO registers */
>  const char *amdvi_mmio_low[] = {
>      "AMDVI_MMIO_DEVTAB_BASE",
> @@ -1044,8 +1046,11 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>          iommu_as[devfn]->devfn = (uint8_t)devfn;
>          iommu_as[devfn]->iommu_state = s;
>  
> -        memory_region_init_iommu(&iommu_as[devfn]->iommu, OBJECT(s),
> -                                 &s->iommu_ops, "amd-iommu", UINT64_MAX);
> +        memory_region_init_iommu(&iommu_as[devfn]->iommu,
> +                                 sizeof(iommu_as[devfn]->iommu),
> +                                 TYPE_AMD_VI_IOMMU_MEMORY_REGION,
> +                                 OBJECT(s),
> +                                 "amd-iommu", UINT64_MAX);
>          address_space_init(&iommu_as[devfn]->as,
>                             MEMORY_REGION(&iommu_as[devfn]->iommu),
>                             "amd-iommu");
> @@ -1086,8 +1091,6 @@ static void amdvi_init(AMDVIState *s)
>  {
>      amdvi_iotlb_reset(s);
>  
> -    s->iommu_ops.translate = amdvi_translate;
> -    s->iommu_ops.notify_flag_changed = amdvi_iommu_notify_flag_changed;
>      s->devtab_len = 0;
>      s->cmdbuf_len = 0;
>      s->cmdbuf_head = 0;
> @@ -1218,10 +1221,25 @@ static const TypeInfo amdviPCI = {
>      .instance_size = sizeof(AMDVIPCIState),
>  };
>  
> +static void amdvi_iommu_memory_region_class_init(ObjectClass *klass, void *data)
> +{
> +    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
> +
> +    imrc->translate = amdvi_translate;
> +    imrc->notify_flag_changed = amdvi_iommu_notify_flag_changed;
> +}
> +
> +static const TypeInfo amdvi_iommu_memory_region_info = {
> +    .parent = TYPE_IOMMU_MEMORY_REGION,
> +    .name = TYPE_AMD_VI_IOMMU_MEMORY_REGION,
> +    .class_init = amdvi_iommu_memory_region_class_init,
> +};
> +
>  static void amdviPCI_register_types(void)
>  {
>      type_register_static(&amdviPCI);
>      type_register_static(&amdvi);
> +    type_register_static(&amdvi_iommu_memory_region_info);
>  }
>  
>  type_init(amdviPCI_register_types);
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index b38d701b32..8aafd6ba5b 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -37,6 +37,8 @@
>  #include "kvm_i386.h"
>  #include "trace.h"
>  
> +#define TYPE_INTEL_VTD_IOMMU_MEMORY_REGION "intel_vtd:iommu_memory_region"
> +
>  /*#define DEBUG_INTEL_IOMMU*/
>  #ifdef DEBUG_INTEL_IOMMU
>  enum {
> @@ -2814,8 +2816,9 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
>           * vtd_sys_alias and intel_iommu regions. IR region is always
>           * enabled.
>           */
> -        memory_region_init_iommu(&vtd_dev_as->iommu, OBJECT(s),
> -                                 &s->iommu_ops, "intel_iommu_dmar",
> +        memory_region_init_iommu(&vtd_dev_as->iommu, sizeof(vtd_dev_as->iommu),
> +                                 TYPE_INTEL_VTD_IOMMU_MEMORY_REGION, OBJECT(s),
> +                                 "intel_iommu_dmar",
>                                   UINT64_MAX);
>          memory_region_init_alias(&vtd_dev_as->sys_alias, OBJECT(s),
>                                   "vtd_sys_alias", get_system_memory(),
> @@ -2953,9 +2956,6 @@ static void vtd_init(IntelIOMMUState *s)
>      memset(s->w1cmask, 0, DMAR_REG_SIZE);
>      memset(s->womask, 0, DMAR_REG_SIZE);
>  
> -    s->iommu_ops.translate = vtd_iommu_translate;
> -    s->iommu_ops.notify_flag_changed = vtd_iommu_notify_flag_changed;
> -    s->iommu_ops.replay = vtd_iommu_replay;
>      s->root = 0;
>      s->root_extended = false;
>      s->dmar_enabled = false;
> @@ -3172,10 +3172,27 @@ static const TypeInfo vtd_info = {
>      .class_init    = vtd_class_init,
>  };
>  
> +static void intel_vtd_iommu_memory_region_class_init(ObjectClass *klass,
> +                                                     void *data)
> +{
> +    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
> +
> +    imrc->translate = vtd_iommu_translate;
> +    imrc->notify_flag_changed = vtd_iommu_notify_flag_changed;
> +    imrc->replay = vtd_iommu_replay;
> +}
> +
> +static const TypeInfo intel_vtd_iommu_memory_region_info = {
> +    .parent = TYPE_IOMMU_MEMORY_REGION,
> +    .name = TYPE_INTEL_VTD_IOMMU_MEMORY_REGION,
> +    .class_init = intel_vtd_iommu_memory_region_class_init,
> +};
> +
>  static void vtd_register_types(void)
>  {
>      VTD_DPRINTF(GENERAL, "");
>      type_register_static(&vtd_info);
> +    type_register_static(&intel_vtd_iommu_memory_region_info);
>  }
>  
>  type_init(vtd_register_types)
> diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
> index 76a56ae29b..f1a854159a 100644
> --- a/hw/pci-host/apb.c
> +++ b/hw/pci-host/apb.c
> @@ -133,6 +133,8 @@ typedef struct IOMMUState {
>  #define APB_DEVICE(obj) \
>      OBJECT_CHECK(APBState, (obj), TYPE_APB)
>  
> +#define TYPE_PBM_IOMMU_MEMORY_REGION "pbm:iommu_memory_region"
> +
>  typedef struct APBState {
>      PCIHostState parent_obj;
>  
> @@ -322,10 +324,6 @@ static IOMMUTLBEntry pbm_translate_iommu(IOMMUMemoryRegion *iommu, hwaddr addr,
>      return ret;
>  }
>  
> -static MemoryRegionIOMMUOps pbm_iommu_ops = {
> -    .translate = pbm_translate_iommu,
> -};
> -
>  static void iommu_config_write(void *opaque, hwaddr addr,
>                                 uint64_t val, unsigned size)
>  {
> @@ -697,7 +695,8 @@ PCIBus *pci_apb_init(hwaddr special_base,
>      is = &d->iommu;
>      memset(is, 0, sizeof(IOMMUState));
>  
> -    memory_region_init_iommu(&is->iommu, OBJECT(dev), &pbm_iommu_ops,
> +    memory_region_init_iommu(&is->iommu, sizeof(is->iommu),
> +                             TYPE_PBM_IOMMU_MEMORY_REGION, OBJECT(dev),
>                               "iommu-apb", UINT64_MAX);
>      address_space_init(&is->iommu_as, MEMORY_REGION(&is->iommu), "pbm-as");
>      pci_setup_iommu(phb->bus, pbm_pci_dma_iommu, is);
> @@ -860,11 +859,25 @@ static const TypeInfo pbm_pci_bridge_info = {
>      .class_init    = pbm_pci_bridge_class_init,
>  };
>  
> +static void pbm_iommu_memory_region_class_init(ObjectClass *klass, void *data)
> +{
> +    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
> +
> +    imrc->translate = pbm_translate_iommu;
> +}
> +
> +static const TypeInfo pbm_iommu_memory_region_info = {
> +    .parent = TYPE_IOMMU_MEMORY_REGION,
> +    .name = TYPE_PBM_IOMMU_MEMORY_REGION,
> +    .class_init = pbm_iommu_memory_region_class_init,
> +};
> +
>  static void pbm_register_types(void)
>  {
>      type_register_static(&pbm_host_info);
>      type_register_static(&pbm_pci_host_info);
>      type_register_static(&pbm_pci_bridge_info);
> +    type_register_static(&pbm_iommu_memory_region_info);
>  }
>  
>  type_init(pbm_register_types)
> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> index 05910a608b..c1cb14b84a 100644
> --- a/hw/ppc/spapr_iommu.c
> +++ b/hw/ppc/spapr_iommu.c
> @@ -248,12 +248,6 @@ static const VMStateDescription vmstate_spapr_tce_table = {
>      }
>  };
>  
> -static MemoryRegionIOMMUOps spapr_iommu_ops = {
> -    .translate = spapr_tce_translate_iommu,
> -    .get_min_page_size = spapr_tce_get_min_page_size,
> -    .notify_flag_changed = spapr_tce_notify_flag_changed,
> -};
> -
>  static int spapr_tce_table_realize(DeviceState *dev)
>  {
>      sPAPRTCETable *tcet = SPAPR_TCE_TABLE(dev);
> @@ -266,7 +260,9 @@ static int spapr_tce_table_realize(DeviceState *dev)
>      memory_region_init(&tcet->root, tcetobj, tmp, UINT64_MAX);
>  
>      snprintf(tmp, sizeof(tmp), "tce-iommu-%x", tcet->liobn);
> -    memory_region_init_iommu(&tcet->iommu, tcetobj, &spapr_iommu_ops, tmp, 0);
> +    memory_region_init_iommu(&tcet->iommu, sizeof(tcet->iommu),
> +                             TYPE_SPAPR_IOMMU_MEMORY_REGION,
> +                             tcetobj, tmp, 0);
>  
>      QLIST_INSERT_HEAD(&spapr_tce_tables, tcet, list);
>  
> @@ -639,9 +635,25 @@ static TypeInfo spapr_tce_table_info = {
>      .class_init = spapr_tce_table_class_init,
>  };
>  
> +static void spapr_iommu_memory_region_class_init(ObjectClass *klass, void *data)
> +{
> +    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
> +
> +    imrc->translate = spapr_tce_translate_iommu;
> +    imrc->get_min_page_size = spapr_tce_get_min_page_size;
> +    imrc->notify_flag_changed = spapr_tce_notify_flag_changed;
> +}
> +
> +static const TypeInfo spapr_iommu_memory_region_info = {
> +    .parent = TYPE_IOMMU_MEMORY_REGION,
> +    .name = TYPE_SPAPR_IOMMU_MEMORY_REGION,
> +    .class_init = spapr_iommu_memory_region_class_init,
> +};
> +
>  static void register_types(void)
>  {
>      type_register_static(&spapr_tce_table_info);
> +    type_register_static(&spapr_iommu_memory_region_info);
>  }
>  
>  type_init(register_types);
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index e4fc82cbe1..6720492d63 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -27,6 +27,8 @@
>  #define DEBUG_S390PCI_BUS  0
>  #endif
>  
> +#define TYPE_S390_IOMMU_MEMORY_REGION "s390:iommu_memory_region"
> +
>  #define DPRINTF(fmt, ...)                                         \
>      do {                                                          \
>          if (DEBUG_S390PCI_BUS) {                                  \
> @@ -407,10 +409,6 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
>      return ret;
>  }
>  
> -static const MemoryRegionIOMMUOps s390_iommu_ops = {
> -    .translate = s390_translate_iommu,
> -};
> -
>  static S390PCIIOMMU *s390_pci_get_iommu(S390pciState *s, PCIBus *bus,
>                                          int devfn)
>  {
> @@ -522,8 +520,9 @@ static const MemoryRegionOps s390_msi_ctrl_ops = {
>  void s390_pci_iommu_enable(S390PCIIOMMU *iommu)
>  {
>      char *name = g_strdup_printf("iommu-s390-%04x", iommu->pbdev->uid);
> -    memory_region_init_iommu(&iommu->iommu_mr, OBJECT(&iommu->mr),
> -                             &s390_iommu_ops, name, iommu->pal + 1);
> +    memory_region_init_iommu(&iommu->iommu_mr, sizeof(iommu->iommu_mr),
> +                             TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&iommu->mr),
> +                             name, iommu->pal + 1);
>      iommu->enabled = true;
>      memory_region_add_subregion(&iommu->mr, 0, MEMORY_REGION(&iommu->iommu_mr));
>      g_free(name);
> @@ -1058,12 +1057,26 @@ static TypeInfo s390_pci_iommu_info = {
>      .instance_size = sizeof(S390PCIIOMMU),
>  };
>  
> +static void s390_iommu_memory_region_class_init(ObjectClass *klass, void *data)
> +{
> +    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
> +
> +    imrc->translate = s390_translate_iommu;
> +}
> +
> +static const TypeInfo s390_iommu_memory_region_info = {
> +    .parent = TYPE_IOMMU_MEMORY_REGION,
> +    .name = TYPE_S390_IOMMU_MEMORY_REGION,
> +    .class_init = s390_iommu_memory_region_class_init,
> +};
> +
>  static void s390_pci_register_types(void)
>  {
>      type_register_static(&s390_pcihost_info);
>      type_register_static(&s390_pcibus_info);
>      type_register_static(&s390_pci_device_info);
>      type_register_static(&s390_pci_iommu_info);
> +    type_register_static(&s390_iommu_memory_region_info);
>  }
>  
>  type_init(s390_pci_register_types)
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index a53c29c487..b7beb8c36a 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -564,6 +564,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
>      hwaddr start, end;
>      IOMMUTLBEntry entry;
>      IOMMUMemoryRegion *iommu_mr;
> +    IOMMUMemoryRegionClass *imrc;
>  
>      cpu_synchronize_state(CPU(cpu));
>  
> @@ -623,8 +624,10 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
>      }
>  
>      iommu_mr = &iommu->iommu_mr;
> +    imrc = IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
> +
>      while (start < end) {
> -        entry = iommu_mr->iommu_ops->translate(iommu_mr, start, IOMMU_NONE);
> +        entry = imrc->translate(iommu_mr, start, IOMMU_NONE);
>  
>          if (!entry.translated_addr) {
>              pbdev->state = ZPCI_FS_ERROR;
> diff --git a/memory.c b/memory.c
> index f55b420d88..20472ca19a 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1488,19 +1488,20 @@ void memory_region_init_rom_device(MemoryRegion *mr,
>      mr->ram_block = qemu_ram_alloc(size, mr, errp);
>  }
>  
> -void memory_region_init_iommu(IOMMUMemoryRegion *iommu_mr,
> +void memory_region_init_iommu(void *_iommu_mr,
> +                              size_t instance_size,
> +                              const char *mrtypename,
>                                Object *owner,
> -                              const MemoryRegionIOMMUOps *ops,
>                                const char *name,
>                                uint64_t size)
>  {
> +    struct IOMMUMemoryRegion *iommu_mr;
>      struct MemoryRegion *mr;
>  
> -    object_initialize(iommu_mr, sizeof(*iommu_mr), TYPE_IOMMU_MEMORY_REGION);
> -    mr = MEMORY_REGION(iommu_mr);
> +    object_initialize(_iommu_mr, instance_size, mrtypename);
> +    mr = MEMORY_REGION(_iommu_mr);
>      memory_region_do_init(mr, owner, name, size);
>      iommu_mr = IOMMU_MEMORY_REGION(mr);
> -    iommu_mr->iommu_ops = ops,
>      mr->terminates = true;  /* then re-forwards */
>      QLIST_INIT(&iommu_mr->iommu_notify);
>      iommu_mr->iommu_notify_flags = IOMMU_NOTIFIER_NONE;
> @@ -1602,16 +1603,16 @@ static void memory_region_update_iommu_notify_flags(IOMMUMemoryRegion *iommu_mr)
>  {
>      IOMMUNotifierFlag flags = IOMMU_NOTIFIER_NONE;
>      IOMMUNotifier *iommu_notifier;
> +    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
>  
>      IOMMU_NOTIFIER_FOREACH(iommu_notifier, iommu_mr) {
>          flags |= iommu_notifier->notifier_flags;
>      }
>  
> -    if (flags != iommu_mr->iommu_notify_flags &&
> -        iommu_mr->iommu_ops->notify_flag_changed) {
> -        iommu_mr->iommu_ops->notify_flag_changed(iommu_mr,
> -                                                iommu_mr->iommu_notify_flags,
> -                                                flags);
> +    if (flags != iommu_mr->iommu_notify_flags && imrc->notify_flag_changed) {
> +        imrc->notify_flag_changed(iommu_mr,
> +                                  iommu_mr->iommu_notify_flags,
> +                                  flags);
>      }
>  
>      iommu_mr->iommu_notify_flags = flags;
> @@ -1637,8 +1638,10 @@ void memory_region_register_iommu_notifier(MemoryRegion *mr,
>  
>  uint64_t memory_region_iommu_get_min_page_size(IOMMUMemoryRegion *iommu_mr)
>  {
> -    if (iommu_mr->iommu_ops && iommu_mr->iommu_ops->get_min_page_size) {
> -        return iommu_mr->iommu_ops->get_min_page_size(iommu_mr);
> +    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
> +
> +    if (imrc->get_min_page_size) {
> +        return imrc->get_min_page_size(iommu_mr);
>      }
>      return TARGET_PAGE_SIZE;
>  }
> @@ -1646,19 +1649,20 @@ uint64_t memory_region_iommu_get_min_page_size(IOMMUMemoryRegion *iommu_mr)
>  void memory_region_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
>  {
>      MemoryRegion *mr = MEMORY_REGION(iommu_mr);
> +    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
>      hwaddr addr, granularity;
>      IOMMUTLBEntry iotlb;
>  
>      /* If the IOMMU has its own replay callback, override */
> -    if (iommu_mr->iommu_ops->replay) {
> -        iommu_mr->iommu_ops->replay(iommu_mr, n);
> +    if (imrc->replay) {
> +        imrc->replay(iommu_mr, n);
>          return;
>      }
>  
>      granularity = memory_region_iommu_get_min_page_size(iommu_mr);
>  
>      for (addr = 0; addr < memory_region_size(mr); addr += granularity) {
> -        iotlb = iommu_mr->iommu_ops->translate(iommu_mr, addr, IOMMU_NONE);
> +        iotlb = imrc->translate(iommu_mr, addr, IOMMU_NONE);
>          if (iotlb.perm != IOMMU_NONE) {
>              n->notify(n, &iotlb);
>          }
> @@ -2738,8 +2742,10 @@ static const TypeInfo memory_region_info = {
>  static const TypeInfo iommu_memory_region_info = {
>      .parent             = TYPE_MEMORY_REGION,
>      .name               = TYPE_IOMMU_MEMORY_REGION,
> +    .class_size         = sizeof(IOMMUMemoryRegionClass),
>      .instance_size      = sizeof(IOMMUMemoryRegion),
>      .instance_init      = iommu_memory_region_initfn,
> +    .abstract           = true,
>  };
>  
>  static void memory_register_types(void)
> 


-- 
Alexey
