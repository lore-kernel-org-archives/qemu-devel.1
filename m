Received: from eggs.gnu.org ([2001:4830:134:3::10]:38668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1d0Kmw-0002Wa-2o
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 00:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1d0Kmr-0003zW-UO
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 00:30:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:28463)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1d0Kmr-0003zF-J0
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 00:30:45 -0400
From: "Liu, Yi L" <yi.l.liu@intel.com>
Date: Tue, 18 Apr 2017 04:30:40 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439054049@shsmsx102.ccr.corp.intel.com>
References: <1492428730-13438-1-git-send-email-peterx@redhat.com>
	<1492428730-13438-8-git-send-email-peterx@redhat.com>
In-Reply-To: <1492428730-13438-8-git-send-email-peterx@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 7/7] intel_iommu: support passthrough
 (PT)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Lan, Tianyu" <tianyu.lan@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

> -----Original Message-----
> From: Qemu-devel [mailto:qemu-devel-bounces+yi.l.liu=3Dintel.com@nongnu.o=
rg] On
> Behalf Of Peter Xu
> Sent: Monday, April 17, 2017 7:32 PM
> To: qemu-devel@nongnu.org
> Cc: Lan, Tianyu <tianyu.lan@intel.com>; Michael S . Tsirkin <mst@redhat.c=
om>;
> Jason Wang <jasowang@redhat.com>; peterx@redhat.com; Marcel Apfelbaum
> <marcel@redhat.com>; David Gibson <david@gibson.dropbear.id.au>
> Subject: [Qemu-devel] [PATCH v2 7/7] intel_iommu: support passthrough (PT=
)
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/i386/intel_iommu.c          | 109 +++++++++++++++++++++++++++++++++--=
------
>  hw/i386/intel_iommu_internal.h |   1 +
>  hw/i386/trace-events           |   1 +
>  hw/i386/x86-iommu.c            |   1 +
>  include/hw/i386/x86-iommu.h    |   1 +
>  5 files changed, 93 insertions(+), 20 deletions(-)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c index
> 05ae631..deb2007 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -872,7 +872,7 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *=
s,
> uint8_t bus_num,
>      } else {
>          switch (vtd_ce_get_type(ce)) {
>          case VTD_CONTEXT_TT_MULTI_LEVEL:
> -            /* fall through */
> +        case VTD_CONTEXT_TT_PASS_THROUGH:
>          case VTD_CONTEXT_TT_DEV_IOTLB:
>              break;
>          default:
> @@ -883,6 +883,73 @@ static int vtd_dev_to_context_entry(IntelIOMMUState =
*s,
> uint8_t bus_num,
>      return 0;
>  }
>=20
> +/* Fetch translation type for specific device. Returns <0 if error
> + * happens, otherwise return the shifted type to check against
> + * VTD_CONTEXT_TT_*. */
> +static int vtd_dev_get_trans_type(VTDAddressSpace *as) {
> +    IntelIOMMUState *s;
> +    VTDContextEntry ce;
> +    int ret;
> +
> +    s =3D as->iommu_state;
> +
> +    ret =3D vtd_dev_to_context_entry(s, pci_bus_num(as->bus),
> +                                   as->devfn, &ce);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    return vtd_ce_get_type(&ce);
> +}
> +
> +static bool vtd_dev_pt_enabled(VTDAddressSpace *as) {
> +    int ret;
> +
> +    assert(as);
> +
> +    ret =3D vtd_dev_get_trans_type(as);
> +    if (ret < 0) {
> +        /*
> +         * Possibly failed to parse the context entry for some reason
> +         * (e.g., during init, or any guest configuration errors on
> +         * context entries). We should assume PT not enabled for
> +         * safety.
> +         */
> +        return false;
> +    }
> +
> +    return ret =3D=3D VTD_CONTEXT_TT_PASS_THROUGH; }
> +
> +static void vtd_switch_address_space(VTDAddressSpace *as) {
> +    bool use_iommu;
> +
> +    assert(as);
> +
> +    use_iommu =3D as->iommu_state->dmar_enabled;
> +    if (use_iommu) {
> +        /* Further checks per-device configuration */
> +        use_iommu &=3D !vtd_dev_pt_enabled(as);
> +    }
> +
> +    trace_vtd_switch_address_space(pci_bus_num(as->bus),
> +                                   VTD_PCI_SLOT(as->devfn),
> +                                   VTD_PCI_FUNC(as->devfn),
> +                                   use_iommu);

Hi Peter,

Skip address space switching is a good idea to support Passthru mode.
However, without the address space, the vfio notifier would not be
registered, thus vIOMMU emulator has no way to connect to host. It is
no harm if there is only map/unmap notifier. But if we have more notifiers
other than map/unmap, it may be a problem.

I think we need to reconsider it here.=20

Regards,
Yi L
> +    /* Turn off first then on the other */
> +    if (use_iommu) {
> +        memory_region_set_enabled(&as->sys_alias, false);
> +        memory_region_set_enabled(&as->iommu, true);
> +    } else {
> +        memory_region_set_enabled(&as->iommu, false);
> +        memory_region_set_enabled(&as->sys_alias, true);
> +    }
> +}
> +
>  static inline uint16_t vtd_make_source_id(uint8_t bus_num, uint8_t devfn=
)  {
>      return ((bus_num & 0xffUL) << 8) | (devfn & 0xffUL); @@ -991,6 +1058=
,18 @@
> static void vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>          cc_entry->context_cache_gen =3D s->context_cache_gen;
>      }
>=20
> +    /*
> +     * We don't need to translate for pass-through context entries.
> +     * Also, let's ignore IOTLB caching as well for PT devices.
> +     */
> +    if (vtd_ce_get_type(&ce) =3D=3D VTD_CONTEXT_TT_PASS_THROUGH) {
> +        entry->translated_addr =3D entry->iova;
> +        entry->addr_mask =3D VTD_PAGE_SIZE - 1;
> +        entry->perm =3D IOMMU_RW;
> +        trace_vtd_translate_pt(source_id, entry->iova);
> +        return;
> +    }
> +
>      ret_fr =3D vtd_iova_to_slpte(&ce, addr, is_write, &slpte, &level,
>                                 &reads, &writes);
>      if (ret_fr) {
> @@ -1135,6 +1214,11 @@ static void
> vtd_context_device_invalidate(IntelIOMMUState *s,
>                                               VTD_PCI_FUNC(devfn_it));
>                  vtd_as->context_cache_entry.context_cache_gen =3D 0;
>                  /*
> +                 * Do switch address space when needed, in case if the
> +                 * device passthrough bit is switched.
> +                 */
> +                vtd_switch_address_space(vtd_as);
> +                /*
>                   * So a device is moving out of (or moving into) a
>                   * domain, a replay() suites here to notify all the
>                   * IOMMU_NOTIFIER_MAP registers about this change.
> @@ -1366,25 +1450,6 @@ static void vtd_handle_gcmd_sirtp(IntelIOMMUState =
*s)
>      vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_IRTPS);  }
>=20
> -static void vtd_switch_address_space(VTDAddressSpace *as) -{
> -    assert(as);
> -
> -    trace_vtd_switch_address_space(pci_bus_num(as->bus),
> -                                   VTD_PCI_SLOT(as->devfn),
> -                                   VTD_PCI_FUNC(as->devfn),
> -                                   as->iommu_state->dmar_enabled);
> -
> -    /* Turn off first then on the other */
> -    if (as->iommu_state->dmar_enabled) {
> -        memory_region_set_enabled(&as->sys_alias, false);
> -        memory_region_set_enabled(&as->iommu, true);
> -    } else {
> -        memory_region_set_enabled(&as->iommu, false);
> -        memory_region_set_enabled(&as->sys_alias, true);
> -    }
> -}
> -
>  static void vtd_switch_address_space_all(IntelIOMMUState *s)  {
>      GHashTableIter iter;
> @@ -2849,6 +2914,10 @@ static void vtd_init(IntelIOMMUState *s)
>          s->ecap |=3D VTD_ECAP_DT;
>      }
>=20
> +    if (x86_iommu->pt_supported) {
> +        s->ecap |=3D VTD_ECAP_PT;
> +    }
> +
>      if (s->caching_mode) {
>          s->cap |=3D VTD_CAP_CM;
>      }
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_interna=
l.h index
> 29d6707..0e73a65 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -187,6 +187,7 @@
>  /* Interrupt Remapping support */
>  #define VTD_ECAP_IR                 (1ULL << 3)
>  #define VTD_ECAP_EIM                (1ULL << 4)
> +#define VTD_ECAP_PT                 (1ULL << 6)
>  #define VTD_ECAP_MHMV               (15ULL << 20)
>=20
>  /* CAP_REG */
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events index 04a6980..8=
67ad0b
> 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -38,6 +38,7 @@ vtd_page_walk_skip_perm(uint64_t iova, uint64_t next) "=
Page
> walk skip iova 0x%"P  vtd_page_walk_skip_reserve(uint64_t iova, uint64_t =
next)
> "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to rsrv set"
>  vtd_switch_address_space(uint8_t bus, uint8_t slot, uint8_t fn, bool on)
> "Device %02x:%02x.%x switching address space (iommu enabled=3D%d)"
>  vtd_as_unmap_whole(uint8_t bus, uint8_t slot, uint8_t fn, uint64_t iova,=
 uint64_t
> size) "Device %02x:%02x.%x start 0x%"PRIx64" size 0x%"PRIx64
> +vtd_translate_pt(uint16_t sid, uint64_t addr) "source id 0x%"PRIu16",
> +iova 0x%"PRIx64
>=20
>  # hw/i386/amd_iommu.c
>  amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write a=
t addr
> 0x%"PRIx64" +  offset 0x%"PRIx32 diff --git a/hw/i386/x86-iommu.c b/hw/i3=
86/x86-
> iommu.c index 02b8825..293caf8 100644
> --- a/hw/i386/x86-iommu.c
> +++ b/hw/i386/x86-iommu.c
> @@ -91,6 +91,7 @@ static void x86_iommu_realize(DeviceState *dev, Error *=
*errp)
> static Property x86_iommu_properties[] =3D {
>      DEFINE_PROP_BOOL("intremap", X86IOMMUState, intr_supported, false),
>      DEFINE_PROP_BOOL("device-iotlb", X86IOMMUState, dt_supported, false)=
,
> +    DEFINE_PROP_BOOL("pt", X86IOMMUState, pt_supported, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>=20
> diff --git a/include/hw/i386/x86-iommu.h b/include/hw/i386/x86-iommu.h in=
dex
> 361c07c..ef89c0c 100644
> --- a/include/hw/i386/x86-iommu.h
> +++ b/include/hw/i386/x86-iommu.h
> @@ -74,6 +74,7 @@ struct X86IOMMUState {
>      SysBusDevice busdev;
>      bool intr_supported;        /* Whether vIOMMU supports IR */
>      bool dt_supported;          /* Whether vIOMMU supports DT */
> +    bool pt_supported;          /* Whether vIOMMU supports pass-through =
*/
>      IommuType type;             /* IOMMU type - AMD/Intel     */
>      QLIST_HEAD(, IEC_Notifier) iec_notifiers; /* IEC notify list */  };
> --
> 2.7.4
>=20
