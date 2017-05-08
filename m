Received: from eggs.gnu.org ([2001:4830:134:3::10]:47509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d7bc6-00061F-64
	for qemu-devel@nongnu.org; Mon, 08 May 2017 01:53:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d7bc2-0003w4-1Z
	for qemu-devel@nongnu.org; Mon, 08 May 2017 01:53:42 -0400
Date: Mon, 8 May 2017 15:53:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170508055324.GF25748@umbus.fritz.box>
References: <20170505101930.45837-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="juZjCTNxrMaZdGZC"
Content-Disposition: inline
In-Reply-To: <20170505101930.45837-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v6] memory/iommu: QOM'fy IOMMU
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>


--juZjCTNxrMaZdGZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2017 at 08:19:30PM +1000, Alexey Kardashevskiy wrote:
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

With the caveat that this will conflict with Peter Xu's outstanding
patches which adjust the semantics of the IOMMU translate function.

> ---
> Changes:
> v6:
> * s/\<iommumr\>/iommu_mr/g
>=20
> v5:
> * fixed sparc64, first time in many years did run "./configure" without
> --target-list :-D Sorry for the noise though :(
>=20
> v4:
> * fixed alpha, mips64el and sparc
>=20
> v3:
> * rebased on sha1 81b2d5ceb0
>=20
> v2:
> * added mr->is_iommu
> * updated i386/x86_64/s390/sun
> ---
>  hw/s390x/s390-pci-bus.h       |   2 +-
>  include/exec/memory.h         |  77 +++++++++++++++++++-------
>  include/hw/i386/intel_iommu.h |   2 +-
>  include/hw/mips/mips.h        |   2 +-
>  include/hw/ppc/spapr.h        |   3 +-
>  include/hw/vfio/vfio-common.h |   2 +-
>  include/qemu/typedefs.h       |   1 +
>  exec.c                        |  16 +++---
>  hw/alpha/typhoon.c            |   8 ++-
>  hw/dma/rc4030.c               |   8 +--
>  hw/i386/amd_iommu.c           |   9 +--
>  hw/i386/intel_iommu.c         |  17 +++---
>  hw/mips/mips_jazz.c           |   2 +-
>  hw/pci-host/apb.c             |   6 +-
>  hw/ppc/spapr_iommu.c          |  20 ++++---
>  hw/s390x/s390-pci-bus.c       |   6 +-
>  hw/s390x/s390-pci-inst.c      |   8 +--
>  hw/vfio/common.c              |  12 ++--
>  hw/vfio/spapr.c               |   3 +-
>  memory.c                      | 124 +++++++++++++++++++++++++++++-------=
------
>  20 files changed, 213 insertions(+), 115 deletions(-)
>=20
> diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
> index cf142a3e68..6a599ed353 100644
> --- a/hw/s390x/s390-pci-bus.h
> +++ b/hw/s390x/s390-pci-bus.h
> @@ -266,7 +266,7 @@ typedef struct S390PCIIOMMU {
>      S390PCIBusDevice *pbdev;
>      AddressSpace as;
>      MemoryRegion mr;
> -    MemoryRegion iommu_mr;
> +    IOMMUMemoryRegion iommu_mr;
>      bool enabled;
>      uint64_t g_iota;
>      uint64_t pba;
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 99e0f54d86..3638089c1d 100644
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
> @@ -186,15 +190,16 @@ typedef struct MemoryRegionIOMMUOps MemoryRegionIOM=
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
>      /* Set this up to provide customized IOMMU replay function */
> -    void (*replay)(MemoryRegion *iommu, IOMMUNotifier *notifier);
> +    void (*replay)(IOMMUMemoryRegion *iommu, IOMMUNotifier *notifier);
>  };
> =20
>  typedef struct CoalescedMemoryRange CoalescedMemoryRange;
> @@ -216,7 +221,6 @@ struct MemoryRegion {
>      uint8_t dirty_log_mask;
>      RAMBlock *ram_block;
>      Object *owner;
> -    const MemoryRegionIOMMUOps *iommu_ops;
> =20
>      const MemoryRegionOps *ops;
>      void *opaque;
> @@ -239,6 +243,13 @@ struct MemoryRegion {
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
> @@ -579,19 +590,40 @@ static inline void memory_region_init_reservation(M=
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
> + * @iommu_mr: the #IOMMUMemoryRegion to be initialized
> + * @owner: the object that tracks the region's reference count
> + * @ops: a function that translates addresses into the @target region
> + * @name: used for debugging; not visible to the user or ABI
> + * @size: size of the region.
> + */
> +void memory_region_init_iommu_type(const char *mrtypename,
> +                                   IOMMUMemoryRegion *iommu_mr,
> +                                   Object *owner,
> +                                   const MemoryRegionIOMMUOps *ops,
> +                                   const char *name,
> +                                   uint64_t size);
> +
> +/**
>   * memory_region_init_iommu: Initialize a memory region that translates
>   * addresses
>   *
>   * An IOMMU region translates addresses and forwards accesses to a target
>   * memory region.
>   *
> - * @mr: the #MemoryRegion to be initialized
> + * @iommu_mr: the #IOMMUMemoryRegion to be initialized
>   * @owner: the object that tracks the region's reference count
>   * @ops: a function that translates addresses into the @target region
>   * @name: used for debugging; not visible to the user or ABI
>   * @size: size of the region.
>   */
> -void memory_region_init_iommu(MemoryRegion *mr,
> +void memory_region_init_iommu(IOMMUMemoryRegion *iommu_mr,
>                                struct Object *owner,
>                                const MemoryRegionIOMMUOps *ops,
>                                const char *name,
> @@ -646,20 +678,25 @@ static inline bool memory_region_is_romd(MemoryRegi=
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
> @@ -667,9 +704,9 @@ static inline bool memory_region_is_iommu(MemoryRegio=
n *mr)
>   *
>   * Returns minimum supported page size for an iommu.
>   *
> - * @mr: the memory region being queried
> + * @iommu_mr: the memory region being queried
>   */
> -uint64_t memory_region_iommu_get_min_page_size(MemoryRegion *mr);
> +uint64_t memory_region_iommu_get_min_page_size(IOMMUMemoryRegion *iommu_=
mr);
> =20
>  /**
>   * memory_region_notify_iommu: notify a change in an IOMMU translation e=
ntry.
> @@ -683,12 +720,12 @@ uint64_t memory_region_iommu_get_min_page_size(Memo=
ryRegion *mr);
>   * Note: for any IOMMU implementation, an in-place mapping change
>   * should be notified with an UNMAP followed by a MAP.
>   *
> - * @mr: the memory region that was changed
> + * @iommu_mr: the memory region that was changed
>   * @entry: the new entry in the IOMMU translation table.  The entry
>   *         replaces all old entries for the same virtual I/O address ran=
ge.
>   *         Deleted entries have .@perm =3D=3D 0.
>   */
> -void memory_region_notify_iommu(MemoryRegion *mr,
> +void memory_region_notify_iommu(IOMMUMemoryRegion *iommu_mr,
>                                  IOMMUTLBEntry entry);
> =20
>  /**
> @@ -723,21 +760,21 @@ void memory_region_register_iommu_notifier(MemoryRe=
gion *mr,
>   * a notifier with the minimum page granularity returned by
>   * mr->iommu_ops->get_page_size().
>   *
> - * @mr: the memory region to observe
> + * @iommu_mr: the memory region to observe
>   * @n: the notifier to which to replay iommu mappings
>   * @is_write: Whether to treat the replay as a translate "write"
>   *     through the iommu
>   */
> -void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
> +void memory_region_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifi=
er *n,
>                                  bool is_write);
> =20
>  /**
>   * memory_region_iommu_replay_all: replay existing IOMMU translations
>   * to all the notifiers registered.
>   *
> - * @mr: the memory region to observe
> + * @iommu_mr: the memory region to observe
>   */
> -void memory_region_iommu_replay_all(MemoryRegion *mr);
> +void memory_region_iommu_replay_all(IOMMUMemoryRegion *iommu_mr);
> =20
>  /**
>   * memory_region_unregister_iommu_notifier: unregister a notifier for
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 3e51876b75..45fba4ff97 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -83,7 +83,7 @@ struct VTDAddressSpace {
>      PCIBus *bus;
>      uint8_t devfn;
>      AddressSpace as;
> -    MemoryRegion iommu;
> +    IOMMUMemoryRegion iommu;
>      MemoryRegion root;
>      MemoryRegion sys_alias;
>      MemoryRegion iommu_ir;      /* Interrupt region: 0xfeeXXXXX */
> diff --git a/include/hw/mips/mips.h b/include/hw/mips/mips.h
> index e0065ce808..0af4c3d5d7 100644
> --- a/include/hw/mips/mips.h
> +++ b/include/hw/mips/mips.h
> @@ -18,6 +18,6 @@ typedef struct rc4030DMAState *rc4030_dma;
>  void rc4030_dma_read(void *dma, uint8_t *buf, int len);
>  void rc4030_dma_write(void *dma, uint8_t *buf, int len);
> =20
> -DeviceState *rc4030_init(rc4030_dma **dmas, MemoryRegion **dma_mr);
> +DeviceState *rc4030_init(rc4030_dma **dmas, IOMMUMemoryRegion **dma_mr);
> =20
>  #endif
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 5802f888c3..011858afb1 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -589,7 +589,8 @@ struct sPAPRTCETable {
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
> index f08d327aec..f9906b28fd 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -46,6 +46,7 @@ typedef struct MachineState MachineState;
>  typedef struct MemoryListener MemoryListener;
>  typedef struct MemoryMappingList MemoryMappingList;
>  typedef struct MemoryRegion MemoryRegion;
> +typedef struct IOMMUMemoryRegion IOMMUMemoryRegion;
>  typedef struct MemoryRegionCache MemoryRegionCache;
>  typedef struct MemoryRegionSection MemoryRegionSection;
>  typedef struct MigrationIncomingState MigrationIncomingState;
> diff --git a/exec.c b/exec.c
> index eac6085760..d30262c182 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -468,20 +468,20 @@ IOMMUTLBEntry address_space_get_iotlb_entry(Address=
Space *as, hwaddr addr,
>  {
>      IOMMUTLBEntry iotlb =3D {0};
>      MemoryRegionSection *section;
> -    MemoryRegion *mr;
> +    IOMMUMemoryRegion *iommu_mr;
> =20
>      for (;;) {
>          AddressSpaceDispatch *d =3D atomic_rcu_read(&as->dispatch);
>          section =3D address_space_lookup_region(d, addr, false);
>          addr =3D addr - section->offset_within_address_space
>                 + section->offset_within_region;
> -        mr =3D section->mr;
> =20
> -        if (!mr->iommu_ops) {
> +        iommu_mr =3D memory_region_get_iommu(section->mr);
> +        if (!iommu_mr) {
>              break;
>          }
> =20
> -        iotlb =3D mr->iommu_ops->translate(mr, addr, is_write);
> +        iotlb =3D iommu_mr->iommu_ops->translate(iommu_mr, addr, is_writ=
e);
>          if (!(iotlb.perm & (1 << is_write))) {
>              iotlb.target_as =3D NULL;
>              break;
> @@ -503,17 +503,19 @@ MemoryRegion *address_space_translate(AddressSpace =
*as, hwaddr addr,
>      IOMMUTLBEntry iotlb;
>      MemoryRegionSection *section;
>      MemoryRegion *mr;
> +    IOMMUMemoryRegion *iommu_mr;
> =20
>      for (;;) {
>          AddressSpaceDispatch *d =3D atomic_rcu_read(&as->dispatch);
>          section =3D address_space_translate_internal(d, addr, &addr, ple=
n, true);
>          mr =3D section->mr;
> =20
> -        if (!mr->iommu_ops) {
> +        iommu_mr =3D memory_region_get_iommu(mr);
> +        if (!iommu_mr) {
>              break;
>          }
> =20
> -        iotlb =3D mr->iommu_ops->translate(mr, addr, is_write);
> +        iotlb =3D iommu_mr->iommu_ops->translate(iommu_mr, addr, is_writ=
e);
>          addr =3D ((iotlb.translated_addr & ~iotlb.addr_mask)
>                  | (addr & iotlb.addr_mask));
>          *plen =3D MIN(*plen, (addr | iotlb.addr_mask) - addr + 1);
> @@ -544,7 +546,7 @@ address_space_translate_for_iotlb(CPUState *cpu, int =
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
> diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
> index f50f5cf186..1ee9e7a969 100644
> --- a/hw/alpha/typhoon.c
> +++ b/hw/alpha/typhoon.c
> @@ -41,7 +41,7 @@ typedef struct TyphoonPchip {
>      MemoryRegion reg_conf;
> =20
>      AddressSpace iommu_as;
> -    MemoryRegion iommu;
> +    IOMMUMemoryRegion iommu;
> =20
>      uint64_t ctl;
>      TyphoonWindow win[4];
> @@ -663,7 +663,8 @@ static bool window_translate(TyphoonWindow *win, hwad=
dr addr,
>  /* Handle PCI-to-system address translation.  */
>  /* TODO: A translation failure here ought to set PCI error codes on the
>     Pchip and generate a machine check interrupt.  */
> -static IOMMUTLBEntry typhoon_translate_iommu(MemoryRegion *iommu, hwaddr=
 addr,
> +static IOMMUTLBEntry typhoon_translate_iommu(IOMMUMemoryRegion *iommu,
> +                                             hwaddr addr,
>                                               bool is_write)
>  {
>      TyphoonPchip *pchip =3D container_of(iommu, TyphoonPchip, iommu);
> @@ -893,7 +894,8 @@ PCIBus *typhoon_init(ram_addr_t ram_size, ISABus **is=
a_bus,
>      /* Host memory as seen from the PCI side, via the IOMMU.  */
>      memory_region_init_iommu(&s->pchip.iommu, OBJECT(s), &typhoon_iommu_=
ops,
>                               "iommu-typhoon", UINT64_MAX);
> -    address_space_init(&s->pchip.iommu_as, &s->pchip.iommu, "pchip0-pci"=
);
> +    address_space_init(&s->pchip.iommu_as, MEMORY_REGION(&s->pchip.iommu=
),
> +                       "pchip0-pci");
>      pci_setup_iommu(b, typhoon_pci_dma_iommu, s);
> =20
>      /* Pchip0 PCI special/interrupt acknowledge, 0x801.F800.0000, 64MB. =
 */
> diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
> index 0080141905..16f13883f3 100644
> --- a/hw/dma/rc4030.c
> +++ b/hw/dma/rc4030.c
> @@ -90,7 +90,7 @@ typedef struct rc4030State
>      qemu_irq jazz_bus_irq;
> =20
>      /* whole DMA memory region, root of DMA address space */
> -    MemoryRegion dma_mr;
> +    IOMMUMemoryRegion dma_mr;
>      AddressSpace dma_as;
> =20
>      MemoryRegion iomem_chipset;
> @@ -488,7 +488,7 @@ static const MemoryRegionOps jazzio_ops =3D {
>      .endianness =3D DEVICE_NATIVE_ENDIAN,
>  };
> =20
> -static IOMMUTLBEntry rc4030_dma_translate(MemoryRegion *iommu, hwaddr ad=
dr,
> +static IOMMUTLBEntry rc4030_dma_translate(IOMMUMemoryRegion *iommu, hwad=
dr addr,
>                                            bool is_write)
>  {
>      rc4030State *s =3D container_of(iommu, rc4030State, dma_mr);
> @@ -679,7 +679,7 @@ static void rc4030_realize(DeviceState *dev, Error **=
errp)
> =20
>      memory_region_init_iommu(&s->dma_mr, o, &rc4030_dma_ops,
>                               "rc4030.dma", UINT32_MAX);
> -    address_space_init(&s->dma_as, &s->dma_mr, "rc4030-dma");
> +    address_space_init(&s->dma_as, MEMORY_REGION(&s->dma_mr), "rc4030-dm=
a");
>  }
> =20
>  static void rc4030_unrealize(DeviceState *dev, Error **errp)
> @@ -717,7 +717,7 @@ static void rc4030_register_types(void)
> =20
>  type_init(rc4030_register_types)
> =20
> -DeviceState *rc4030_init(rc4030_dma **dmas, MemoryRegion **dma_mr)
> +DeviceState *rc4030_init(rc4030_dma **dmas, IOMMUMemoryRegion **dma_mr)
>  {
>      DeviceState *dev;
> =20
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index f86a40aa30..46ba34a733 100644
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
> @@ -1045,7 +1045,8 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *b=
us, void *opaque, int devfn)
> =20
>          memory_region_init_iommu(&iommu_as[devfn]->iommu, OBJECT(s),
>                                   &s->iommu_ops, "amd-iommu", UINT64_MAX);
> -        address_space_init(&iommu_as[devfn]->as, &iommu_as[devfn]->iommu,
> +        address_space_init(&iommu_as[devfn]->as,
> +                           MEMORY_REGION(&iommu_as[devfn]->iommu),
>                             "amd-iommu");
>      }
>      return &iommu_as[devfn]->as;
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
> index 02f047c8e3..adad2e7293 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1205,7 +1205,7 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUS=
tate *s, uint16_t domain_id)
>  static int vtd_page_invalidate_notify_hook(IOMMUTLBEntry *entry,
>                                             void *private)
>  {
> -    memory_region_notify_iommu((MemoryRegion *)private, *entry);
> +    memory_region_notify_iommu((IOMMUMemoryRegion *)private, *entry);
>      return 0;
>  }
> =20
> @@ -1373,9 +1373,9 @@ static void vtd_switch_address_space(VTDAddressSpac=
e *as)
>      /* Turn off first then on the other */
>      if (as->iommu_state->dmar_enabled) {
>          memory_region_set_enabled(&as->sys_alias, false);
> -        memory_region_set_enabled(&as->iommu, true);
> +        memory_region_set_enabled(MEMORY_REGION(&as->iommu), true);
>      } else {
> -        memory_region_set_enabled(&as->iommu, false);
> +        memory_region_set_enabled(MEMORY_REGION(&as->iommu), false);
>          memory_region_set_enabled(&as->sys_alias, true);
>      }
>  }
> @@ -2220,7 +2220,7 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
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
> @@ -2252,7 +2252,7 @@ static IOMMUTLBEntry vtd_iommu_translate(MemoryRegi=
on *iommu, hwaddr addr,
>      return ret;
>  }
> =20
> -static void vtd_iommu_notify_flag_changed(MemoryRegion *iommu,
> +static void vtd_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
>                                            IOMMUNotifierFlag old,
>                                            IOMMUNotifierFlag new)
>  {
> @@ -2695,7 +2695,8 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s=
, PCIBus *bus, int devfn)
>          memory_region_add_subregion_overlap(&vtd_dev_as->root, 0,
>                                              &vtd_dev_as->sys_alias, 1);
>          memory_region_add_subregion_overlap(&vtd_dev_as->root, 0,
> -                                            &vtd_dev_as->iommu, 1);
> +                                            MEMORY_REGION(&vtd_dev_as->i=
ommu),
> +                                            1);
>          vtd_switch_address_space(vtd_dev_as);
>      }
>      return vtd_dev_as;
> @@ -2775,9 +2776,9 @@ static int vtd_replay_hook(IOMMUTLBEntry *entry, vo=
id *private)
>      return 0;
>  }
> =20
> -static void vtd_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n)
> +static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier =
*n)
>  {
> -    VTDAddressSpace *vtd_as =3D container_of(mr, VTDAddressSpace, iommu);
> +    VTDAddressSpace *vtd_as =3D container_of(iommu_mr, VTDAddressSpace, =
iommu);
>      IntelIOMMUState *s =3D vtd_as->iommu_state;
>      uint8_t bus_n =3D pci_bus_num(vtd_as->bus);
>      VTDContextEntry ce;
> diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
> index 1cef581878..1f69322c15 100644
> --- a/hw/mips/mips_jazz.c
> +++ b/hw/mips/mips_jazz.c
> @@ -130,7 +130,7 @@ static void mips_jazz_init(MachineState *machine,
>      CPUMIPSState *env;
>      qemu_irq *i8259;
>      rc4030_dma *dmas;
> -    MemoryRegion *rc4030_dma_mr;
> +    IOMMUMemoryRegion *rc4030_dma_mr;
>      MemoryRegion *isa_mem =3D g_new(MemoryRegion, 1);
>      MemoryRegion *isa_io =3D g_new(MemoryRegion, 1);
>      MemoryRegion *rtc =3D g_new(MemoryRegion, 1);
> diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
> index 653e711121..1029fb0e5a 100644
> --- a/hw/pci-host/apb.c
> +++ b/hw/pci-host/apb.c
> @@ -123,7 +123,7 @@ do { printf("IOMMU: " fmt , ## __VA_ARGS__); } while =
(0)
> =20
>  typedef struct IOMMUState {
>      AddressSpace iommu_as;
> -    MemoryRegion iommu;
> +    IOMMUMemoryRegion iommu;
> =20
>      uint64_t regs[IOMMU_NREGS];
>  } IOMMUState;
> @@ -208,7 +208,7 @@ static AddressSpace *pbm_pci_dma_iommu(PCIBus *bus, v=
oid *opaque, int devfn)
>  }
> =20
>  /* Called from RCU critical section */
> -static IOMMUTLBEntry pbm_translate_iommu(MemoryRegion *iommu, hwaddr add=
r,
> +static IOMMUTLBEntry pbm_translate_iommu(IOMMUMemoryRegion *iommu, hwadd=
r addr,
>                                           bool is_write)
>  {
>      IOMMUState *is =3D container_of(iommu, IOMMUState, iommu);
> @@ -699,7 +699,7 @@ PCIBus *pci_apb_init(hwaddr special_base,
> =20
>      memory_region_init_iommu(&is->iommu, OBJECT(dev), &pbm_iommu_ops,
>                               "iommu-apb", UINT64_MAX);
> -    address_space_init(&is->iommu_as, &is->iommu, "pbm-as");
> +    address_space_init(&is->iommu_as, MEMORY_REGION(&is->iommu), "pbm-as=
");
>      pci_setup_iommu(phb->bus, pbm_pci_dma_iommu, is);
> =20
>      /* APB secondary busses */
> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> index 29c80bb3c8..99732bf24d 100644
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
> @@ -348,9 +351,10 @@ void spapr_tce_table_enable(sPAPRTCETable *tcet,
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
> @@ -359,8 +363,8 @@ void spapr_tce_table_disable(sPAPRTCETable *tcet)
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
> index a8a1bab50a..9bda89eb12 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -356,7 +356,7 @@ out:
>      return pte;
>  }
> =20
> -static IOMMUTLBEntry s390_translate_iommu(MemoryRegion *mr, hwaddr addr,
> +static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr =
addr,
>                                            bool is_write)
>  {
>      uint64_t pte;
> @@ -525,14 +525,14 @@ void s390_pci_iommu_enable(S390PCIIOMMU *iommu)
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
> index 314a9cbad4..b82cab9f6c 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -563,7 +563,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint=
8_t r2)
>      S390PCIIOMMU *iommu;
>      hwaddr start, end;
>      IOMMUTLBEntry entry;
> -    MemoryRegion *mr;
> +    IOMMUMemoryRegion *iommu_mr;
> =20
>      cpu_synchronize_state(CPU(cpu));
> =20
> @@ -622,9 +622,9 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint=
8_t r2)
>          goto out;
>      }
> =20
> -    mr =3D &iommu->iommu_mr;
> +    iommu_mr =3D &iommu->iommu_mr;
>      while (start < end) {
> -        entry =3D mr->iommu_ops->translate(mr, start, 0);
> +        entry =3D iommu_mr->iommu_ops->translate(iommu_mr, start, 0);
> =20
>          if (!entry.translated_addr) {
>              pbdev->state =3D ZPCI_FS_ERROR;
> @@ -635,7 +635,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint=
8_t r2)
>              goto out;
>          }
> =20
> -        memory_region_notify_iommu(mr, entry);
> +        memory_region_notify_iommu(iommu_mr, entry);
>          start +=3D entry.addr_mask + 1;
>      }
> =20
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 6b33b9f55d..8689ab7535 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -465,6 +465,7 @@ static void vfio_listener_region_add(MemoryListener *=
listener,
> =20
>      if (memory_region_is_iommu(section->mr)) {
>          VFIOGuestIOMMU *giommu;
> +        IOMMUMemoryRegion *iommu_mr =3D IOMMU_MEMORY_REGION(section->mr);
> =20
>          trace_vfio_listener_region_add_iommu(iova, end);
>          /*
> @@ -474,7 +475,7 @@ static void vfio_listener_region_add(MemoryListener *=
listener,
>           * device emulation the VFIO iommu handles to use).
>           */
>          giommu =3D g_malloc0(sizeof(*giommu));
> -        giommu->iommu =3D section->mr;
> +        giommu->iommu =3D iommu_mr;
>          giommu->iommu_offset =3D section->offset_within_address_space -
>                                 section->offset_within_region;
>          giommu->container =3D container;
> @@ -487,7 +488,7 @@ static void vfio_listener_region_add(MemoryListener *=
listener,
>                              int128_get64(llend));
>          QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
> =20
> -        memory_region_register_iommu_notifier(giommu->iommu, &giommu->n);
> +        memory_region_register_iommu_notifier(section->mr, &giommu->n);
>          memory_region_iommu_replay(giommu->iommu, &giommu->n, false);
> =20
>          return;
> @@ -555,9 +556,9 @@ static void vfio_listener_region_del(MemoryListener *=
listener,
>          VFIOGuestIOMMU *giommu;
> =20
>          QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
> -            if (giommu->iommu =3D=3D section->mr &&
> +            if (MEMORY_REGION(giommu->iommu) =3D=3D section->mr &&
>                  giommu->n.start =3D=3D section->offset_within_region) {
> -                memory_region_unregister_iommu_notifier(giommu->iommu,
> +                memory_region_unregister_iommu_notifier(section->mr,
>                                                          &giommu->n);
>                  QLIST_REMOVE(giommu, giommu_next);
>                  g_free(giommu);
> @@ -1147,7 +1148,8 @@ static void vfio_disconnect_container(VFIOGroup *gr=
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
> index 4409bcc0d7..32fd6a9b54 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -143,7 +143,8 @@ int vfio_spapr_create_window(VFIOContainer *container,
>                               hwaddr *pgsize)
>  {
>      int ret;
> -    unsigned pagesize =3D memory_region_iommu_get_min_page_size(section-=
>mr);
> +    IOMMUMemoryRegion *iommu_mr =3D IOMMU_MEMORY_REGION(section->mr);
> +    unsigned pagesize =3D memory_region_iommu_get_min_page_size(iommu_mr=
);
>      unsigned entries, pages;
>      struct vfio_iommu_spapr_tce_create create =3D { .argsz =3D sizeof(cr=
eate) };
> =20
> diff --git a/memory.c b/memory.c
> index b727f5ec0e..630bfc51e1 100644
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
> +                                   IOMMUMemoryRegion *iommu_mr,
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
> +    object_initialize(iommu_mr, instance_size, mrtypename);
> +    mr =3D MEMORY_REGION(iommu_mr);
> +    memory_region_do_init(mr, owner, name, size);
> +    iommu_mr->iommu_ops =3D ops,
>      mr->terminates =3D true;  /* then re-forwards */
> -    QLIST_INIT(&mr->iommu_notify);
> -    mr->iommu_notify_flags =3D IOMMU_NOTIFIER_NONE;
> +    QLIST_INIT(&iommu_mr->iommu_notify);
> +    iommu_mr->iommu_notify_flags =3D IOMMU_NOTIFIER_NONE;
> +}
> +
> +void memory_region_init_iommu(IOMMUMemoryRegion *iommu_mr,
> +                              Object *owner,
> +                              const MemoryRegionIOMMUOps *ops,
> +                              const char *name,
> +                              uint64_t size)
> +{
> +    memory_region_init_iommu_type(TYPE_IOMMU_MEMORY_REGION, iommu_mr,
> +                                  owner, ops, name, size);
>  }
> =20
>  static void memory_region_finalize(Object *obj)
> @@ -1578,64 +1609,68 @@ bool memory_region_is_logging(MemoryRegion *mr, u=
int8_t client)
>      return memory_region_get_dirty_log_mask(mr) & (1 << client);
>  }
> =20
> -static void memory_region_update_iommu_notify_flags(MemoryRegion *mr)
> +static void memory_region_update_iommu_notify_flags(IOMMUMemoryRegion *i=
ommu_mr)
>  {
>      IOMMUNotifierFlag flags =3D IOMMU_NOTIFIER_NONE;
>      IOMMUNotifier *iommu_notifier;
> =20
> -    IOMMU_NOTIFIER_FOREACH(iommu_notifier, mr) {
> +    IOMMU_NOTIFIER_FOREACH(iommu_notifier, iommu_mr) {
>          flags |=3D iommu_notifier->notifier_flags;
>      }
> =20
> -    if (flags !=3D mr->iommu_notify_flags &&
> -        mr->iommu_ops->notify_flag_changed) {
> -        mr->iommu_ops->notify_flag_changed(mr, mr->iommu_notify_flags,
> -                                           flags);
> +    if (flags !=3D iommu_mr->iommu_notify_flags &&
> +        iommu_mr->iommu_ops->notify_flag_changed) {
> +        iommu_mr->iommu_ops->notify_flag_changed(iommu_mr,
> +                                                iommu_mr->iommu_notify_f=
lags,
> +                                                flags);
>      }
> =20
> -    mr->iommu_notify_flags =3D flags;
> +    iommu_mr->iommu_notify_flags =3D flags;
>  }
> =20
>  void memory_region_register_iommu_notifier(MemoryRegion *mr,
>                                             IOMMUNotifier *n)
>  {
> +    IOMMUMemoryRegion *iommu_mr;
> +
>      if (mr->alias) {
>          memory_region_register_iommu_notifier(mr->alias, n);
>          return;
>      }
> =20
>      /* We need to register for at least one bitfield */
> +    iommu_mr =3D IOMMU_MEMORY_REGION(mr);
>      assert(n->notifier_flags !=3D IOMMU_NOTIFIER_NONE);
>      assert(n->start <=3D n->end);
> -    QLIST_INSERT_HEAD(&mr->iommu_notify, n, node);
> -    memory_region_update_iommu_notify_flags(mr);
> +    QLIST_INSERT_HEAD(&iommu_mr->iommu_notify, n, node);
> +    memory_region_update_iommu_notify_flags(iommu_mr);
>  }
> =20
> -uint64_t memory_region_iommu_get_min_page_size(MemoryRegion *mr)
> +uint64_t memory_region_iommu_get_min_page_size(IOMMUMemoryRegion *iommu_=
mr)
>  {
> -    assert(memory_region_is_iommu(mr));
> -    if (mr->iommu_ops && mr->iommu_ops->get_min_page_size) {
> -        return mr->iommu_ops->get_min_page_size(mr);
> +    if (iommu_mr->iommu_ops && iommu_mr->iommu_ops->get_min_page_size) {
> +        return iommu_mr->iommu_ops->get_min_page_size(iommu_mr);
>      }
>      return TARGET_PAGE_SIZE;
>  }
> =20
> -void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
> +void memory_region_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifi=
er *n,
>                                  bool is_write)
>  {
> +    MemoryRegion *mr =3D MEMORY_REGION(iommu_mr);
>      hwaddr addr, granularity;
>      IOMMUTLBEntry iotlb;
> =20
>      /* If the IOMMU has its own replay callback, override */
> -    if (mr->iommu_ops->replay) {
> -        mr->iommu_ops->replay(mr, n);
> +    if (iommu_mr->iommu_ops->replay) {
> +        iommu_mr->iommu_ops->replay(iommu_mr, n);
>          return;
>      }
> =20
> -    granularity =3D memory_region_iommu_get_min_page_size(mr);
> +    granularity =3D memory_region_iommu_get_min_page_size(iommu_mr);
> =20
>      for (addr =3D 0; addr < memory_region_size(mr); addr +=3D granularit=
y) {
> -        iotlb =3D mr->iommu_ops->translate(mr, addr, is_write);
> +        iotlb =3D iommu_mr->iommu_ops->translate(iommu_mr, addr, is_writ=
e);
>          if (iotlb.perm !=3D IOMMU_NONE) {
>              n->notify(n, &iotlb);
>          }
> @@ -1648,24 +1683,27 @@ void memory_region_iommu_replay(MemoryRegion *mr,=
 IOMMUNotifier *n,
>      }
>  }
> =20
> -void memory_region_iommu_replay_all(MemoryRegion *mr)
> +void memory_region_iommu_replay_all(IOMMUMemoryRegion *iommu_mr)
>  {
>      IOMMUNotifier *notifier;
> =20
> -    IOMMU_NOTIFIER_FOREACH(notifier, mr) {
> -        memory_region_iommu_replay(mr, notifier, false);
> +    IOMMU_NOTIFIER_FOREACH(notifier, iommu_mr) {
> +        memory_region_iommu_replay(iommu_mr, notifier, false);
>      }
>  }
> =20
>  void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
>                                               IOMMUNotifier *n)
>  {
> +    IOMMUMemoryRegion *iommu_mr;
> +
>      if (mr->alias) {
>          memory_region_unregister_iommu_notifier(mr->alias, n);
>          return;
>      }
>      QLIST_REMOVE(n, node);
> -    memory_region_update_iommu_notify_flags(mr);
> +    iommu_mr =3D IOMMU_MEMORY_REGION(mr);
> +    memory_region_update_iommu_notify_flags(iommu_mr);
>  }
> =20
>  void memory_region_notify_one(IOMMUNotifier *notifier,
> @@ -1693,14 +1731,14 @@ void memory_region_notify_one(IOMMUNotifier *noti=
fier,
>      }
>  }
> =20
> -void memory_region_notify_iommu(MemoryRegion *mr,
> +void memory_region_notify_iommu(IOMMUMemoryRegion *iommu_mr,
>                                  IOMMUTLBEntry entry)
>  {
>      IOMMUNotifier *iommu_notifier;
> =20
> -    assert(memory_region_is_iommu(mr));
> +    assert(memory_region_is_iommu(MEMORY_REGION(iommu_mr)));
> =20
> -    IOMMU_NOTIFIER_FOREACH(iommu_notifier, mr) {
> +    IOMMU_NOTIFIER_FOREACH(iommu_notifier, iommu_mr) {
>          memory_region_notify_one(iommu_notifier, &entry);
>      }
>  }
> @@ -2709,9 +2747,17 @@ static const TypeInfo memory_region_info =3D {
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

--juZjCTNxrMaZdGZC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZEAfRAAoJEGw4ysog2bOScikP/RbYbJaCiv7rFniOlwaRPNVB
s4Z34BFZ+Q/dgkV3Uw41pEzY9JuaYLi+HQld5Hw5J1ghVd6Ipg61BICOyY+LaGKt
lVeedmGPQM2utang3yXX5nOPwsyDQ37Vwi/qgFqca9z1r3NKYPdiJtZ6w2csxv2f
A5N8njGSy/Pqk7jdl66d37XxXcmD+UPua474SC3zBoXOMjVdWBVkrZRM/XkdD269
MUbEUWC3NUKTUcPRWacJ/bzcKxsGxbtnmsP0eWVsCAY5ZSknLd5qYp8HiLQv76CG
2Exfm9jCOCS35Js3L+79vQlJXSFN1DJ3XJH7ZU5Zt1P5W70vviOe1DzU2gGX4EqY
FU9Y3Jy35ldrJn01eijzfwOpb+NFO73vXqZoGgeUqp/Sp+DG3u0aLH6ZIWc4TOIU
ADrlplCqtHN11fH7837clygBArWs3d3ETHDfRch/QxO2OGW6qGVb28TINGJKKl7P
QPCNOdgDCAh/S7nzuT4Xdub5Wz9qorvbY0zUDx8OjOhL8EihgCLm+odF5j8MmEuq
eKO72fAM+1VBbDEl9M6VY7uPU2ngq+QR8LERKaLhUJLzaxVFQWFjjI5YZN/86R/O
xBO5eMwNhZ5cMzxUmx6Lmyx9i8vY3b/ZYDAYmCnhhBkT0J5/2DUN2dtohP+vLJAw
5LAE5aKCUbk/dpyRhpAT
=GhDo
-----END PGP SIGNATURE-----

--juZjCTNxrMaZdGZC--
