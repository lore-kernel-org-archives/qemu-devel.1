Received: from eggs.gnu.org ([2001:4830:134:3::10]:52569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1curxW-0004dM-1W
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 22:43:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1curxS-0005jz-B3
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 22:43:10 -0400
Date: Mon, 3 Apr 2017 12:26:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170403022622.GC12906@umbus.fritz.box>
References: <20170401123741.38469-1-aik@ozlabs.ru>
	<20170401123741.38469-2-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ABTtc+pdwF7KHXCz"
Content-Disposition: inline
In-Reply-To: <20170401123741.38469-2-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [RFC PATCH qemu v3 1/4] memory/iommu: QOM'fy IOMMU
 MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--ABTtc+pdwF7KHXCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 01, 2017 at 11:37:38PM +1100, Alexey Kardashevskiy wrote:
> This defines new QOM object - IOMMUMemoryRegion - with MemoryRegion
> as a parent.
>=20
> This moves IOMMU-related fields from MR to IOMMU MR. However to avoid
> dymanic QOM casting in fast path (address_space_translate, etc),
> this adds an @is_iommu boolean flag to MR and provides new helper to
> do simple cast to IOMMU MR - memory_region_get_iommu. The flag
> is set in the instance init callback. This defines
> memory_region_is_iommu as memory_region_get_iommu()!=3DNULL.
>=20
> This switches MemoryRegion to IOMMUMemoryRegion in most places except
> the ones where MemoryRegion may be an alias.
>=20
> This defines memory_region_init_iommu_type() to allow creating
> IOMMUMemoryRegion subclasses. In order to support custom QOM type,
> this splits memory_region_init() to object_initialize() +
> memory_region_do_init.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Changes:
> v3:
> * added mr->is_iommu
> * updated i386/x86_64/s390/sun
> ---
>  hw/s390x/s390-pci-bus.h       |   2 +-
>  include/exec/memory.h         |  64 ++++++++++++++++++------
>  include/hw/i386/intel_iommu.h |   2 +-
>  include/hw/ppc/spapr.h        |   3 +-
>  include/hw/vfio/vfio-common.h |   2 +-
>  include/qemu/typedefs.h       |   1 +
>  exec.c                        |  16 +++---
>  hw/dma/sun4m_iommu.c          |   2 +-
>  hw/i386/amd_iommu.c           |  11 ++--
>  hw/i386/intel_iommu.c         |  14 +++---
>  hw/ppc/spapr_iommu.c          |  20 +++++---
>  hw/s390x/s390-pci-bus.c       |   6 +--
>  hw/s390x/s390-pci-inst.c      |   8 +--
>  hw/vfio/common.c              |  12 +++--
>  hw/vfio/spapr.c               |   3 +-
>  memory.c                      | 114 +++++++++++++++++++++++++++++-------=
------
>  16 files changed, 188 insertions(+), 92 deletions(-)
>=20
> diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
> index dcbf4820c9..441ddbedcb 100644
> --- a/hw/s390x/s390-pci-bus.h
> +++ b/hw/s390x/s390-pci-bus.h
> @@ -267,7 +267,7 @@ typedef struct S390PCIIOMMU {
>      S390PCIBusDevice *pbdev;
>      AddressSpace as;
>      MemoryRegion mr;
> -    MemoryRegion iommu_mr;
> +    IOMMUMemoryRegion iommu_mr;
>      bool enabled;
>      uint64_t g_iota;
>      uint64_t pba;
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index e39256ad03..29d59f4f7f 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -37,6 +37,10 @@
>  #define MEMORY_REGION(obj) \
>          OBJECT_CHECK(MemoryRegion, (obj), TYPE_MEMORY_REGION)
> =20
> +#define TYPE_IOMMU_MEMORY_REGION "qemu:iommu-memory-region"
> +#define IOMMU_MEMORY_REGION(obj) \
> +        OBJECT_CHECK(IOMMUMemoryRegion, (obj), TYPE_IOMMU_MEMORY_REGION)
> +
>  typedef struct MemoryRegionOps MemoryRegionOps;
>  typedef struct MemoryRegionMmio MemoryRegionMmio;
> =20
> @@ -167,11 +171,12 @@ typedef struct MemoryRegionIOMMUOps MemoryRegionIOM=
MUOps;
> =20
>  struct MemoryRegionIOMMUOps {
>      /* Return a TLB entry that contains a given address. */
> -    IOMMUTLBEntry (*translate)(MemoryRegion *iommu, hwaddr addr, bool is=
_write);
> +    IOMMUTLBEntry (*translate)(IOMMUMemoryRegion *iommu, hwaddr addr,
> +                               bool is_write);
>      /* Returns minimum supported page size */
> -    uint64_t (*get_min_page_size)(MemoryRegion *iommu);
> +    uint64_t (*get_min_page_size)(IOMMUMemoryRegion *iommu);
>      /* Called when IOMMU Notifier flag changed */
> -    void (*notify_flag_changed)(MemoryRegion *iommu,
> +    void (*notify_flag_changed)(IOMMUMemoryRegion *iommu,
>                                  IOMMUNotifierFlag old_flags,
>                                  IOMMUNotifierFlag new_flags);
>  };
> @@ -195,7 +200,6 @@ struct MemoryRegion {
>      uint8_t dirty_log_mask;
>      RAMBlock *ram_block;
>      Object *owner;
> -    const MemoryRegionIOMMUOps *iommu_ops;
> =20
>      const MemoryRegionOps *ops;
>      void *opaque;
> @@ -218,6 +222,13 @@ struct MemoryRegion {
>      const char *name;
>      unsigned ioeventfd_nb;
>      MemoryRegionIoeventfd *ioeventfds;
> +    bool is_iommu;
> +};
> +
> +struct IOMMUMemoryRegion {
> +    MemoryRegion parent_obj;
> +
> +    const MemoryRegionIOMMUOps *iommu_ops;
>      QLIST_HEAD(, IOMMUNotifier) iommu_notify;
>      IOMMUNotifierFlag iommu_notify_flags;
>  };
> @@ -555,19 +566,39 @@ static inline void memory_region_init_reservation(M=
emoryRegion *mr,
>  }
> =20
>  /**
> + * memory_region_init_iommu_type: Initialize a memory region of a custom=
 type
> + * that translates addresses
> + *
> + * An IOMMU region translates addresses and forwards accesses to a target
> + * memory region.
> + *
> + * @typename: QOM class name
> + * @mr: the #IOMMUMemoryRegion to be initialized
> + * @owner: the object that tracks the region's reference count
> + * @ops: a function that translates addresses into the @target region
> + * @name: used for debugging; not visible to the user or ABI
> + * @size: size of the region.
> + */
> +void memory_region_init_iommu_type(const char *mrtypename,
> +                                   IOMMUMemoryRegion *iommumr,
> +                                   Object *owner,
> +                                   const MemoryRegionIOMMUOps *ops,
> +                                   const char *name,
> +                                   uint64_t size);
> +/**
>   * memory_region_init_iommu: Initialize a memory region that translates
>   * addresses
>   *
>   * An IOMMU region translates addresses and forwards accesses to a target
>   * memory region.
>   *
> - * @mr: the #MemoryRegion to be initialized
> + * @mr: the #IOMMUMemoryRegion to be initialized
>   * @owner: the object that tracks the region's reference count
>   * @ops: a function that translates addresses into the @target region
>   * @name: used for debugging; not visible to the user or ABI
>   * @size: size of the region.
>   */
> -void memory_region_init_iommu(MemoryRegion *mr,
> +void memory_region_init_iommu(IOMMUMemoryRegion *iommumr,
>                                struct Object *owner,
>                                const MemoryRegionIOMMUOps *ops,
>                                const char *name,
> @@ -622,20 +653,25 @@ static inline bool memory_region_is_romd(MemoryRegi=
on *mr)
>  }
> =20
>  /**
> - * memory_region_is_iommu: check whether a memory region is an iommu
> + * memory_region_get_iommu: check whether a memory region is an iommu
>   *
> - * Returns %true is a memory region is an iommu.
> + * Returns pointer to IOMMUMemoryRegion if a memory region is an iommu,
> + * otherwise NULL.
>   *
>   * @mr: the memory region being queried
>   */
> -static inline bool memory_region_is_iommu(MemoryRegion *mr)
> +static inline IOMMUMemoryRegion *memory_region_get_iommu(MemoryRegion *m=
r)
>  {
>      if (mr->alias) {
> -        return memory_region_is_iommu(mr->alias);
> +        return memory_region_get_iommu(mr->alias);
>      }
> -    return mr->iommu_ops;
> +    if (mr->is_iommu) {
> +        return (IOMMUMemoryRegion *) mr;
> +    }
> +    return NULL;
>  }
> =20
> +#define memory_region_is_iommu(mr) (memory_region_get_iommu(mr) !=3D NUL=
L)
> =20
>  /**
>   * memory_region_iommu_get_min_page_size: get minimum supported page size
> @@ -645,7 +681,7 @@ static inline bool memory_region_is_iommu(MemoryRegio=
n *mr)
>   *
>   * @mr: the memory region being queried
>   */
> -uint64_t memory_region_iommu_get_min_page_size(MemoryRegion *mr);
> +uint64_t memory_region_iommu_get_min_page_size(IOMMUMemoryRegion *mr);
> =20
>  /**
>   * memory_region_notify_iommu: notify a change in an IOMMU translation e=
ntry.
> @@ -664,7 +700,7 @@ uint64_t memory_region_iommu_get_min_page_size(Memory=
Region *mr);
>   *         replaces all old entries for the same virtual I/O address ran=
ge.
>   *         Deleted entries have .@perm =3D=3D 0.
>   */
> -void memory_region_notify_iommu(MemoryRegion *mr,
> +void memory_region_notify_iommu(IOMMUMemoryRegion *mr,
>                                  IOMMUTLBEntry entry);
> =20
>  /**
> @@ -689,7 +725,7 @@ void memory_region_register_iommu_notifier(MemoryRegi=
on *mr,
>   * @is_write: Whether to treat the replay as a translate "write"
>   *     through the iommu
>   */
> -void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
> +void memory_region_iommu_replay(IOMMUMemoryRegion *mr, IOMMUNotifier *n,
>                                  bool is_write);
> =20
>  /**
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index fe645aa93a..34f1b61957 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -82,7 +82,7 @@ struct VTDAddressSpace {
>      PCIBus *bus;
>      uint8_t devfn;
>      AddressSpace as;
> -    MemoryRegion iommu;
> +    IOMMUMemoryRegion iommu;
>      MemoryRegion iommu_ir;      /* Interrupt region: 0xfeeXXXXX */
>      IntelIOMMUState *iommu_state;
>      VTDContextCacheEntry context_cache_entry;
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index e27de64d31..6997ed7e98 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -590,7 +590,8 @@ struct sPAPRTCETable {
>      bool bypass;
>      bool need_vfio;
>      int fd;
> -    MemoryRegion root, iommu;
> +    MemoryRegion root;
> +    IOMMUMemoryRegion iommu;
>      struct VIOsPAPRDevice *vdev; /* for @bypass migration compatibility =
only */
>      QLIST_ENTRY(sPAPRTCETable) list;
>  };
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index c582de18c9..7a4135ae6f 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -94,7 +94,7 @@ typedef struct VFIOContainer {
> =20
>  typedef struct VFIOGuestIOMMU {
>      VFIOContainer *container;
> -    MemoryRegion *iommu;
> +    IOMMUMemoryRegion *iommu;
>      hwaddr iommu_offset;
>      IOMMUNotifier n;
>      QLIST_ENTRY(VFIOGuestIOMMU) giommu_next;
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index e95f28cfec..b45f71ec11 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -45,6 +45,7 @@ typedef struct MachineState MachineState;
>  typedef struct MemoryListener MemoryListener;
>  typedef struct MemoryMappingList MemoryMappingList;
>  typedef struct MemoryRegion MemoryRegion;
> +typedef struct IOMMUMemoryRegion IOMMUMemoryRegion;
>  typedef struct MemoryRegionCache MemoryRegionCache;
>  typedef struct MemoryRegionSection MemoryRegionSection;
>  typedef struct MigrationIncomingState MigrationIncomingState;
> diff --git a/exec.c b/exec.c
> index e57a8a2178..bbd8df7a9d 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -462,20 +462,20 @@ IOMMUTLBEntry address_space_get_iotlb_entry(Address=
Space *as, hwaddr addr,
>  {
>      IOMMUTLBEntry iotlb =3D {0};
>      MemoryRegionSection *section;
> -    MemoryRegion *mr;
> +    IOMMUMemoryRegion *iommumr;
> =20
>      for (;;) {
>          AddressSpaceDispatch *d =3D atomic_rcu_read(&as->dispatch);
>          section =3D address_space_lookup_region(d, addr, false);
>          addr =3D addr - section->offset_within_address_space
>                 + section->offset_within_region;
> -        mr =3D section->mr;
> =20
> -        if (!mr->iommu_ops) {
> +        iommumr =3D memory_region_get_iommu(section->mr);
> +        if (!iommumr) {
>              break;
>          }
> =20
> -        iotlb =3D mr->iommu_ops->translate(mr, addr, is_write);
> +        iotlb =3D iommumr->iommu_ops->translate(iommumr, addr, is_write);
>          if (!(iotlb.perm & (1 << is_write))) {
>              iotlb.target_as =3D NULL;
>              break;
> @@ -497,17 +497,19 @@ MemoryRegion *address_space_translate(AddressSpace =
*as, hwaddr addr,
>      IOMMUTLBEntry iotlb;
>      MemoryRegionSection *section;
>      MemoryRegion *mr;
> +    IOMMUMemoryRegion *iommumr;
> =20
>      for (;;) {
>          AddressSpaceDispatch *d =3D atomic_rcu_read(&as->dispatch);
>          section =3D address_space_translate_internal(d, addr, &addr, ple=
n, true);
>          mr =3D section->mr;
> =20
> -        if (!mr->iommu_ops) {
> +        iommumr =3D memory_region_get_iommu(mr);
> +        if (!iommumr) {
>              break;
>          }
> =20
> -        iotlb =3D mr->iommu_ops->translate(mr, addr, is_write);
> +        iotlb =3D iommumr->iommu_ops->translate(iommumr, addr, is_write);
>          addr =3D ((iotlb.translated_addr & ~iotlb.addr_mask)
>                  | (addr & iotlb.addr_mask));
>          *plen =3D MIN(*plen, (addr | iotlb.addr_mask) - addr + 1);
> @@ -538,7 +540,7 @@ address_space_translate_for_iotlb(CPUState *cpu, int =
asidx, hwaddr addr,
> =20
>      section =3D address_space_translate_internal(d, addr, xlat, plen, fa=
lse);
> =20
> -    assert(!section->mr->iommu_ops);
> +    assert(!memory_region_is_iommu(section->mr));
>      return section;
>  }
>  #endif
> diff --git a/hw/dma/sun4m_iommu.c b/hw/dma/sun4m_iommu.c
> index b3cbc54c23..539115b629 100644
> --- a/hw/dma/sun4m_iommu.c
> +++ b/hw/dma/sun4m_iommu.c
> @@ -134,7 +134,7 @@
>  typedef struct IOMMUState {
>      SysBusDevice parent_obj;
> =20
> -    MemoryRegion iomem;
> +    IOMMUMemoryRegion iomem;
>      uint32_t regs[IOMMU_NREGS];
>      hwaddr iostart;
>      qemu_irq irq;
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index f86a40aa30..e76c29aec6 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -51,7 +51,7 @@ struct AMDVIAddressSpace {
>      uint8_t bus_num;            /* bus number                           =
*/
>      uint8_t devfn;              /* device function                      =
*/
>      AMDVIState *iommu_state;    /* AMDVI - one per machine              =
*/
> -    MemoryRegion iommu;         /* Device's address translation region  =
*/
> +    IOMMUMemoryRegion iommu;    /* Device's address translation region  =
*/
>      MemoryRegion iommu_ir;      /* Device's interrupt remapping region  =
*/
>      AddressSpace as;            /* device's corresponding address space =
*/
>  };
> @@ -986,7 +986,7 @@ static inline bool amdvi_is_interrupt_addr(hwaddr add=
r)
>      return addr >=3D AMDVI_INT_ADDR_FIRST && addr <=3D AMDVI_INT_ADDR_LA=
ST;
>  }
> =20
> -static IOMMUTLBEntry amdvi_translate(MemoryRegion *iommu, hwaddr addr,
> +static IOMMUTLBEntry amdvi_translate(IOMMUMemoryRegion *iommu, hwaddr ad=
dr,
>                                       bool is_write)
>  {
>      AMDVIAddressSpace *as =3D container_of(iommu, AMDVIAddressSpace, iom=
mu);
> @@ -1045,8 +1045,9 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *b=
us, void *opaque, int devfn)
> =20
>          memory_region_init_iommu(&iommu_as[devfn]->iommu, OBJECT(s),
>                                   &s->iommu_ops, "amd-iommu", UINT64_MAX);
> -        address_space_init(&iommu_as[devfn]->as, &iommu_as[devfn]->iommu,
> -                           "amd-iommu");
> +	address_space_init(&iommu_as[devfn]->as,
> +			   MEMORY_REGION(&iommu_as[devfn]->iommu),
> +			   "amd-iommu");
>      }
>      return &iommu_as[devfn]->as;
>  }
> @@ -1066,7 +1067,7 @@ static const MemoryRegionOps mmio_mem_ops =3D {
>      }
>  };
> =20
> -static void amdvi_iommu_notify_flag_changed(MemoryRegion *iommu,
> +static void amdvi_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
>                                              IOMMUNotifierFlag old,
>                                              IOMMUNotifierFlag new)
>  {
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 22d8226e43..233fa75b64 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1457,7 +1457,8 @@ static bool vtd_process_device_iotlb_desc(IntelIOMM=
UState *s,
>      entry.iova =3D addr;
>      entry.perm =3D IOMMU_NONE;
>      entry.translated_addr =3D 0;
> -    memory_region_notify_iommu(entry.target_as->root, entry);
> +    memory_region_notify_iommu(memory_region_get_iommu(entry.target_as->=
root),
> +			       entry);
> =20
>  done:
>      return true;
> @@ -1968,7 +1969,7 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
>      }
>  }
> =20
> -static IOMMUTLBEntry vtd_iommu_translate(MemoryRegion *iommu, hwaddr add=
r,
> +static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryRegion *iommu, hwadd=
r addr,
>                                           bool is_write)
>  {
>      VTDAddressSpace *vtd_as =3D container_of(iommu, VTDAddressSpace, iom=
mu);
> @@ -2000,7 +2001,7 @@ static IOMMUTLBEntry vtd_iommu_translate(MemoryRegi=
on *iommu, hwaddr addr,
>      return ret;
>  }
> =20
> -static void vtd_iommu_notify_flag_changed(MemoryRegion *iommu,
> +static void vtd_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
>                                            IOMMUNotifierFlag old,
>                                            IOMMUNotifierFlag new)
>  {
> @@ -2394,10 +2395,11 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState =
*s, PCIBus *bus, int devfn)
>          memory_region_init_io(&vtd_dev_as->iommu_ir, OBJECT(s),
>                                &vtd_mem_ir_ops, s, "intel_iommu_ir",
>                                VTD_INTERRUPT_ADDR_SIZE);
> -        memory_region_add_subregion(&vtd_dev_as->iommu, VTD_INTERRUPT_AD=
DR_FIRST,
> -                                    &vtd_dev_as->iommu_ir);
> +	memory_region_add_subregion(MEMORY_REGION(&vtd_dev_as->iommu),
> +				    VTD_INTERRUPT_ADDR_FIRST,
> +				    &vtd_dev_as->iommu_ir);
>          address_space_init(&vtd_dev_as->as,
> -                           &vtd_dev_as->iommu, name);
> +                           MEMORY_REGION(&vtd_dev_as->iommu), name);
>      }
>      return vtd_dev_as;
>  }
> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> index 9e30e148d6..5051110b9d 100644
> --- a/hw/ppc/spapr_iommu.c
> +++ b/hw/ppc/spapr_iommu.c
> @@ -110,7 +110,8 @@ static void spapr_tce_free_table(uint64_t *table, int=
 fd, uint32_t nb_table)
>  }
> =20
>  /* Called from RCU critical section */
> -static IOMMUTLBEntry spapr_tce_translate_iommu(MemoryRegion *iommu, hwad=
dr addr,
> +static IOMMUTLBEntry spapr_tce_translate_iommu(IOMMUMemoryRegion *iommu,
> +                                               hwaddr addr,
>                                                 bool is_write)
>  {
>      sPAPRTCETable *tcet =3D container_of(iommu, sPAPRTCETable, iommu);
> @@ -150,14 +151,14 @@ static void spapr_tce_table_pre_save(void *opaque)
>                                 tcet->bus_offset, tcet->page_shift);
>  }
> =20
> -static uint64_t spapr_tce_get_min_page_size(MemoryRegion *iommu)
> +static uint64_t spapr_tce_get_min_page_size(IOMMUMemoryRegion *iommu)
>  {
>      sPAPRTCETable *tcet =3D container_of(iommu, sPAPRTCETable, iommu);
> =20
>      return 1ULL << tcet->page_shift;
>  }
> =20
> -static void spapr_tce_notify_flag_changed(MemoryRegion *iommu,
> +static void spapr_tce_notify_flag_changed(IOMMUMemoryRegion *iommu,
>                                            IOMMUNotifierFlag old,
>                                            IOMMUNotifierFlag new)
>  {
> @@ -265,7 +266,9 @@ static int spapr_tce_table_realize(DeviceState *dev)
>      memory_region_init(&tcet->root, tcetobj, tmp, UINT64_MAX);
> =20
>      snprintf(tmp, sizeof(tmp), "tce-iommu-%x", tcet->liobn);
> -    memory_region_init_iommu(&tcet->iommu, tcetobj, &spapr_iommu_ops, tm=
p, 0);
> +    memory_region_init_iommu_type(TYPE_IOMMU_MEMORY_REGION,
> +                                  &tcet->iommu, tcetobj, &spapr_iommu_op=
s,
> +                                  tmp, 0);
> =20
>      QLIST_INSERT_HEAD(&spapr_tce_tables, tcet, list);
> =20
> @@ -341,9 +344,10 @@ void spapr_tce_table_enable(sPAPRTCETable *tcet,
>                                          &tcet->fd,
>                                          tcet->need_vfio);
> =20
> -    memory_region_set_size(&tcet->iommu,
> +    memory_region_set_size(MEMORY_REGION(&tcet->iommu),
>                             (uint64_t)tcet->nb_table << tcet->page_shift);
> -    memory_region_add_subregion(&tcet->root, tcet->bus_offset, &tcet->io=
mmu);
> +    memory_region_add_subregion(&tcet->root, tcet->bus_offset,
> +                                MEMORY_REGION(&tcet->iommu));
>  }
> =20
>  void spapr_tce_table_disable(sPAPRTCETable *tcet)
> @@ -352,8 +356,8 @@ void spapr_tce_table_disable(sPAPRTCETable *tcet)
>          return;
>      }
> =20
> -    memory_region_del_subregion(&tcet->root, &tcet->iommu);
> -    memory_region_set_size(&tcet->iommu, 0);
> +    memory_region_del_subregion(&tcet->root, MEMORY_REGION(&tcet->iommu)=
);
> +    memory_region_set_size(MEMORY_REGION(&tcet->iommu), 0);
> =20
>      spapr_tce_free_table(tcet->table, tcet->fd, tcet->nb_table);
>      tcet->fd =3D -1;
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 69b0291e8a..27e7336a76 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -354,7 +354,7 @@ out:
>      return pte;
>  }
> =20
> -static IOMMUTLBEntry s390_translate_iommu(MemoryRegion *mr, hwaddr addr,
> +static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr =
addr,
>                                            bool is_write)
>  {
>      uint64_t pte;
> @@ -523,14 +523,14 @@ void s390_pci_iommu_enable(S390PCIIOMMU *iommu)
>      memory_region_init_iommu(&iommu->iommu_mr, OBJECT(&iommu->mr),
>                               &s390_iommu_ops, name, iommu->pal + 1);
>      iommu->enabled =3D true;
> -    memory_region_add_subregion(&iommu->mr, 0, &iommu->iommu_mr);
> +    memory_region_add_subregion(&iommu->mr, 0, MEMORY_REGION(&iommu->iom=
mu_mr));
>      g_free(name);
>  }
> =20
>  void s390_pci_iommu_disable(S390PCIIOMMU *iommu)
>  {
>      iommu->enabled =3D false;
> -    memory_region_del_subregion(&iommu->mr, &iommu->iommu_mr);
> +    memory_region_del_subregion(&iommu->mr, MEMORY_REGION(&iommu->iommu_=
mr));
>      object_unparent(OBJECT(&iommu->iommu_mr));
>  }
> =20
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index d2a8c0a083..b4fe4da798 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -561,7 +561,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint=
8_t r2)
>      S390PCIIOMMU *iommu;
>      hwaddr start, end;
>      IOMMUTLBEntry entry;
> -    MemoryRegion *mr;
> +    IOMMUMemoryRegion *iommumr;
> =20
>      cpu_synchronize_state(CPU(cpu));
> =20
> @@ -620,9 +620,9 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint=
8_t r2)
>          goto out;
>      }
> =20
> -    mr =3D &iommu->iommu_mr;
> +    iommumr =3D &iommu->iommu_mr;
>      while (start < end) {
> -        entry =3D mr->iommu_ops->translate(mr, start, 0);
> +        entry =3D iommumr->iommu_ops->translate(iommumr, start, 0);
> =20
>          if (!entry.translated_addr) {
>              pbdev->state =3D ZPCI_FS_ERROR;
> @@ -633,7 +633,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint=
8_t r2)
>              goto out;
>          }
> =20
> -        memory_region_notify_iommu(mr, entry);
> +        memory_region_notify_iommu(iommumr, entry);
>          start +=3D entry.addr_mask + 1;
>      }
> =20
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index f3ba9b9007..ab95db689c 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -465,6 +465,7 @@ static void vfio_listener_region_add(MemoryListener *=
listener,
> =20
>      if (memory_region_is_iommu(section->mr)) {
>          VFIOGuestIOMMU *giommu;
> +        IOMMUMemoryRegion *iommumr =3D IOMMU_MEMORY_REGION(section->mr);
> =20
>          trace_vfio_listener_region_add_iommu(iova, end);
>          /*
> @@ -474,7 +475,7 @@ static void vfio_listener_region_add(MemoryListener *=
listener,
>           * device emulation the VFIO iommu handles to use).
>           */
>          giommu =3D g_malloc0(sizeof(*giommu));
> -        giommu->iommu =3D section->mr;
> +        giommu->iommu =3D iommumr;
>          giommu->iommu_offset =3D section->offset_within_address_space -
>                                 section->offset_within_region;
>          giommu->container =3D container;
> @@ -482,7 +483,7 @@ static void vfio_listener_region_add(MemoryListener *=
listener,
>          giommu->n.notifier_flags =3D IOMMU_NOTIFIER_ALL;
>          QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
> =20
> -        memory_region_register_iommu_notifier(giommu->iommu, &giommu->n);
> +        memory_region_register_iommu_notifier(section->mr, &giommu->n);
>          memory_region_iommu_replay(giommu->iommu, &giommu->n, false);
> =20
>          return;
> @@ -550,8 +551,8 @@ static void vfio_listener_region_del(MemoryListener *=
listener,
>          VFIOGuestIOMMU *giommu;
> =20
>          QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
> -            if (giommu->iommu =3D=3D section->mr) {
> -                memory_region_unregister_iommu_notifier(giommu->iommu,
> +            if (MEMORY_REGION(giommu->iommu) =3D=3D section->mr) {
> +                memory_region_unregister_iommu_notifier(section->mr,
>                                                          &giommu->n);
>                  QLIST_REMOVE(giommu, giommu_next);
>                  g_free(giommu);
> @@ -1141,7 +1142,8 @@ static void vfio_disconnect_container(VFIOGroup *gr=
oup)
>          QLIST_REMOVE(container, next);
> =20
>          QLIST_FOREACH_SAFE(giommu, &container->giommu_list, giommu_next,=
 tmp) {
> -            memory_region_unregister_iommu_notifier(giommu->iommu, &giom=
mu->n);
> +            memory_region_unregister_iommu_notifier(
> +                    MEMORY_REGION(giommu->iommu), &giommu->n);
>              QLIST_REMOVE(giommu, giommu_next);
>              g_free(giommu);
>          }
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 4409bcc0d7..551870d46b 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -143,7 +143,8 @@ int vfio_spapr_create_window(VFIOContainer *container,
>                               hwaddr *pgsize)
>  {
>      int ret;
> -    unsigned pagesize =3D memory_region_iommu_get_min_page_size(section-=
>mr);
> +    IOMMUMemoryRegion *iommumr =3D IOMMU_MEMORY_REGION(section->mr);
> +    unsigned pagesize =3D memory_region_iommu_get_min_page_size(iommumr);
>      unsigned entries, pages;
>      struct vfio_iommu_spapr_tce_create create =3D { .argsz =3D sizeof(cr=
eate) };
> =20
> diff --git a/memory.c b/memory.c
> index 4c95aaf39c..62796536dc 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -975,12 +975,11 @@ static char *memory_region_escape_name(const char *=
name)
>      return escaped;
>  }
> =20
> -void memory_region_init(MemoryRegion *mr,
> -                        Object *owner,
> -                        const char *name,
> -                        uint64_t size)
> +static void memory_region_do_init(MemoryRegion *mr,
> +                                  Object *owner,
> +                                  const char *name,
> +                                  uint64_t size)
>  {
> -    object_initialize(mr, sizeof(*mr), TYPE_MEMORY_REGION);
>      mr->size =3D int128_make64(size);
>      if (size =3D=3D UINT64_MAX) {
>          mr->size =3D int128_2_64();
> @@ -1004,6 +1003,15 @@ void memory_region_init(MemoryRegion *mr,
>      }
>  }
> =20
> +void memory_region_init(MemoryRegion *mr,
> +                        Object *owner,
> +                        const char *name,
> +                        uint64_t size)
> +{
> +    object_initialize(mr, sizeof(*mr), TYPE_MEMORY_REGION);
> +    memory_region_do_init(mr, owner, name, size);
> +}
> +
>  static void memory_region_get_addr(Object *obj, Visitor *v, const char *=
name,
>                                     void *opaque, Error **errp)
>  {
> @@ -1090,6 +1098,13 @@ static void memory_region_initfn(Object *obj)
>                          NULL, NULL, &error_abort);
>  }
> =20
> +static void iommu_memory_region_initfn(Object *obj)
> +{
> +    MemoryRegion *mr =3D MEMORY_REGION(obj);
> +
> +    mr->is_iommu =3D true;
> +}
> +
>  static uint64_t unassigned_mem_read(void *opaque, hwaddr addr,
>                                      unsigned size)
>  {
> @@ -1473,17 +1488,33 @@ void memory_region_init_rom_device(MemoryRegion *=
mr,
>      mr->ram_block =3D qemu_ram_alloc(size, mr, errp);
>  }
> =20
> -void memory_region_init_iommu(MemoryRegion *mr,
> -                              Object *owner,
> -                              const MemoryRegionIOMMUOps *ops,
> -                              const char *name,
> -                              uint64_t size)
> +void memory_region_init_iommu_type(const char *mrtypename,
> +                                   IOMMUMemoryRegion *iommumr,
> +                                   Object *owner,
> +                                   const MemoryRegionIOMMUOps *ops,
> +                                   const char *name,
> +                                   uint64_t size)
>  {
> -    memory_region_init(mr, owner, name, size);
> -    mr->iommu_ops =3D ops,
> +    struct MemoryRegion *mr;
> +    size_t instance_size =3D object_type_get_instance_size(mrtypename);
> +
> +    object_initialize(iommumr, instance_size, mrtypename);
> +    mr =3D MEMORY_REGION(iommumr);
> +    memory_region_do_init(mr, owner, name, size);
> +    iommumr->iommu_ops =3D ops,
>      mr->terminates =3D true;  /* then re-forwards */
> -    QLIST_INIT(&mr->iommu_notify);
> -    mr->iommu_notify_flags =3D IOMMU_NOTIFIER_NONE;
> +    QLIST_INIT(&iommumr->iommu_notify);
> +    iommumr->iommu_notify_flags =3D IOMMU_NOTIFIER_NONE;
> +}
> +
> +void memory_region_init_iommu(IOMMUMemoryRegion *iommumr,
> +                              Object *owner,
> +                              const MemoryRegionIOMMUOps *ops,
> +                              const char *name,
> +                              uint64_t size)
> +{
> +    memory_region_init_iommu_type(TYPE_IOMMU_MEMORY_REGION, iommumr,
> +                                  owner, ops, name, size);
>  }
> =20
>  static void memory_region_finalize(Object *obj)
> @@ -1578,57 +1609,61 @@ bool memory_region_is_logging(MemoryRegion *mr, u=
int8_t client)
>      return memory_region_get_dirty_log_mask(mr) & (1 << client);
>  }
> =20
> -static void memory_region_update_iommu_notify_flags(MemoryRegion *mr)
> +static void memory_region_update_iommu_notify_flags(IOMMUMemoryRegion *i=
ommumr)
>  {
>      IOMMUNotifierFlag flags =3D IOMMU_NOTIFIER_NONE;
>      IOMMUNotifier *iommu_notifier;
> =20
> -    QLIST_FOREACH(iommu_notifier, &mr->iommu_notify, node) {
> +    QLIST_FOREACH(iommu_notifier, &iommumr->iommu_notify, node) {
>          flags |=3D iommu_notifier->notifier_flags;
>      }
> =20
> -    if (flags !=3D mr->iommu_notify_flags &&
> -        mr->iommu_ops->notify_flag_changed) {
> -        mr->iommu_ops->notify_flag_changed(mr, mr->iommu_notify_flags,
> -                                           flags);
> +    if (flags !=3D iommumr->iommu_notify_flags &&
> +        iommumr->iommu_ops->notify_flag_changed) {
> +        iommumr->iommu_ops->notify_flag_changed(iommumr,
> +                                                iommumr->iommu_notify_fl=
ags,
> +                                                flags);
>      }
> =20
> -    mr->iommu_notify_flags =3D flags;
> +    iommumr->iommu_notify_flags =3D flags;
>  }
> =20
>  void memory_region_register_iommu_notifier(MemoryRegion *mr,
>                                             IOMMUNotifier *n)
>  {
> +    IOMMUMemoryRegion *iommumr;
> +
>      if (mr->alias) {
>          memory_region_register_iommu_notifier(mr->alias, n);
>          return;
>      }
> =20
>      /* We need to register for at least one bitfield */
> +    iommumr =3D IOMMU_MEMORY_REGION(mr);
>      assert(n->notifier_flags !=3D IOMMU_NOTIFIER_NONE);
> -    QLIST_INSERT_HEAD(&mr->iommu_notify, n, node);
> -    memory_region_update_iommu_notify_flags(mr);
> +    QLIST_INSERT_HEAD(&iommumr->iommu_notify, n, node);
> +    memory_region_update_iommu_notify_flags(iommumr);
>  }
> =20
> -uint64_t memory_region_iommu_get_min_page_size(MemoryRegion *mr)
> +uint64_t memory_region_iommu_get_min_page_size(IOMMUMemoryRegion *iommum=
r)
>  {
> -    assert(memory_region_is_iommu(mr));
> -    if (mr->iommu_ops && mr->iommu_ops->get_min_page_size) {
> -        return mr->iommu_ops->get_min_page_size(mr);
> +    if (iommumr->iommu_ops && iommumr->iommu_ops->get_min_page_size) {
> +        return iommumr->iommu_ops->get_min_page_size(iommumr);
>      }
>      return TARGET_PAGE_SIZE;
>  }
> =20
> -void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
> +void memory_region_iommu_replay(IOMMUMemoryRegion *iommumr, IOMMUNotifie=
r *n,
>                                  bool is_write)
>  {
> +    MemoryRegion *mr =3D MEMORY_REGION(iommumr);
>      hwaddr addr, granularity;
>      IOMMUTLBEntry iotlb;
> =20
> -    granularity =3D memory_region_iommu_get_min_page_size(mr);
> +    granularity =3D memory_region_iommu_get_min_page_size(iommumr);
> =20
>      for (addr =3D 0; addr < memory_region_size(mr); addr +=3D granularit=
y) {
> -        iotlb =3D mr->iommu_ops->translate(mr, addr, is_write);
> +        iotlb =3D iommumr->iommu_ops->translate(iommumr, addr, is_write);
>          if (iotlb.perm !=3D IOMMU_NONE) {
>              n->notify(n, &iotlb);
>          }
> @@ -1644,21 +1679,24 @@ void memory_region_iommu_replay(MemoryRegion *mr,=
 IOMMUNotifier *n,
>  void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
>                                               IOMMUNotifier *n)
>  {
> +    IOMMUMemoryRegion *iommumr;
> +
>      if (mr->alias) {
>          memory_region_unregister_iommu_notifier(mr->alias, n);
>          return;
>      }
>      QLIST_REMOVE(n, node);
> -    memory_region_update_iommu_notify_flags(mr);
> +    iommumr =3D IOMMU_MEMORY_REGION(mr);
> +    memory_region_update_iommu_notify_flags(iommumr);
>  }
> =20
> -void memory_region_notify_iommu(MemoryRegion *mr,
> +void memory_region_notify_iommu(IOMMUMemoryRegion *iommumr,
>                                  IOMMUTLBEntry entry)
>  {
>      IOMMUNotifier *iommu_notifier;
>      IOMMUNotifierFlag request_flags;
> =20
> -    assert(memory_region_is_iommu(mr));
> +    assert(memory_region_is_iommu(MEMORY_REGION(iommumr)));
> =20
>      if (entry.perm & IOMMU_RW) {
>          request_flags =3D IOMMU_NOTIFIER_MAP;
> @@ -1666,7 +1704,7 @@ void memory_region_notify_iommu(MemoryRegion *mr,
>          request_flags =3D IOMMU_NOTIFIER_UNMAP;
>      }
> =20
> -    QLIST_FOREACH(iommu_notifier, &mr->iommu_notify, node) {
> +    QLIST_FOREACH(iommu_notifier, &iommumr->iommu_notify, node) {
>          if (iommu_notifier->notifier_flags & request_flags) {
>              iommu_notifier->notify(iommu_notifier, &entry);
>          }
> @@ -2660,9 +2698,17 @@ static const TypeInfo memory_region_info =3D {
>      .instance_finalize  =3D memory_region_finalize,
>  };
> =20
> +static const TypeInfo iommu_memory_region_info =3D {
> +    .parent             =3D TYPE_MEMORY_REGION,
> +    .name               =3D TYPE_IOMMU_MEMORY_REGION,
> +    .instance_size      =3D sizeof(IOMMUMemoryRegion),
> +    .instance_init      =3D iommu_memory_region_initfn,
> +};
> +
>  static void memory_register_types(void)
>  {
>      type_register_static(&memory_region_info);
> +    type_register_static(&iommu_memory_region_info);
>  }
> =20
>  type_init(memory_register_types)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ABTtc+pdwF7KHXCz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY4bLOAAoJEGw4ysog2bOSFlwP/1eU3LFMA+Eh+d415GKVL9H5
lAnv2CpXfKB95bfDNAfquOCxZiYN5a7pR7FcFKp8r4vNWq14t7o7Oa9T4FGNPTHT
m683FWGanXNYhsjk6TnMhMLRjvivjdowMmLYPaQKU4zbkRRYyVilWunvNgSFOhit
eqLDbXY20x2pI6++G+WBvwpepu+cjviJI+HlkX52ztsesacWClhefQfQ3kBZtFjH
PLx03kHQudK32zFpnPdB6K9Cb+4UTi2FbIzq8Ql4cuqSeCr2Ghfl0DiorR3Fv1YX
JEnJ07k8orayzMl4+VMX50ajvPYJMZmwXx18PGpSqvTrqfl7klvdFjbPoNDJHby1
0l2AusVxsazTyvHxkIQFmFOjXqZ8xhQJgLyu1ZxJpMq4KktRWaUxQE+WxoCmNMUf
/vcmteHoAvZqDSpWYu5z5ULDCOVCOv0BjB5LIFsvag0C6AkPmodLbM1ilFKYrAF+
tPnpWKIQ7Px+ZtFHqLG6AFfYKoYf0ZhDbTRkA22exSuGGP+EfJqMcEVZ6CD0ZIlF
bEdVTojO0/iAJbAb9O12TjSQaeZTpjslTzVFRXXCGMw2nxa2j/8ykQ1SQ5Hy50wX
z+AC6BrEvGo9ohfC2qETZcnTA4raMio7Lpr3QXoaGKkUGIpoR6YhZecpg/c7TkkJ
2swNRwvtZ5X3xhsaoasX
=ng9Z
-----END PGP SIGNATURE-----

--ABTtc+pdwF7KHXCz--
