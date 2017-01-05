Received: from eggs.gnu.org ([2001:4830:134:3::10]:54949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1cOylB-0006Nb-7Q
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 22:30:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1cOyl8-0001eZ-2r
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 22:30:37 -0500
Received: from mga14.intel.com ([192.55.52.115]:51165)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1cOyl7-0001eA-NU
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 22:30:33 -0500
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Thu, 5 Jan 2017 03:30:28 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190BF810D@SHSMSX101.ccr.corp.intel.com>
References: <1482400096-23078-1-git-send-email-peterx@redhat.com>
In-Reply-To: <1482400096-23078-1-git-send-email-peterx@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3] intel_iommu: allow dynamic switch of
 IOMMU region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Lan, Tianyu" <tianyu.lan@intel.com>, "mst@redhat.com" <mst@redhat.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "bd.aviv@gmail.com" <bd.aviv@gmail.com>, "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>

> From: Peter Xu [mailto:peterx@redhat.com]
> Sent: Thursday, December 22, 2016 5:48 PM
>=20
> This is preparation work to finally enabled dynamic switching ON/OFF for
> VT-d protection. The old VT-d codes is using static IOMMU region, and
> that won't satisfy vfio-pci device listeners.

Is "IOMMU address space" more accurate than "IOMMU region" here,
based on following description and actual code?

>=20
> Let me explain.
>=20
> vfio-pci devices depend on the memory region listener and IOMMU replay
> mechanism to make sure the device mapping is coherent with the guest
> even if there are domain switches. And there are two kinds of domain
> switches:
>=20
>   (1) switch from domain A -> B
>   (2) switch from domain A -> no domain (e.g., turn DMAR off)
>=20
> Case (1) is handled by the context entry invalidation handling by the
> VT-d replay logic. What the replay function should do here is to replay
> the existing page mappings in domain B.
>=20
> However for case (2), we don't want to replay any domain mappings - we
> just need the default GPA->HPA mappings (the address_space_memory
> mapping). And this patch helps on case (2) to build up the mapping
> automatically by leveraging the vfio-pci memory listeners.
>=20
> Another important thing that this patch does is to seperate
> IR (Interrupt Remapping) from DMAR (DMA Remapping). IR region should not
> depend on the DMAR region (like before this patch). It should be a
> standalone region, and it should be able to be activated without
> DMAR (which is a common behavior of Linux kernel - by default it enables
> IR while disabled DMAR).

Not just because Linux kernel behavior. It's the spec behavior - IR
and DMAR can be enabled/disabled separately. :-)

>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> v3:
> - fix another trivial style issue patchew reported but I missed in v2
>=20
> v2:
> - fix issues reported by patchew
> - switch domain by enable/disable memory regions [David]
> - provide vtd_switch_address_space{_all}()
> - provide a better comment on the memory regions
>=20
> test done: with intel_iommu device, boot vm with/without
> "intel_iommu=3Don" parameter.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/i386/intel_iommu.c         | 79
> ++++++++++++++++++++++++++++++++++++++++---
>  hw/i386/trace-events          |  3 ++
>  include/hw/i386/intel_iommu.h |  2 ++
>  3 files changed, 80 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 5f3e351..2710ee774 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -35,6 +35,7 @@
>  #include "sysemu/kvm.h"
>  #include "hw/i386/apic_internal.h"
>  #include "kvm_i386.h"
> +#include "trace.h"
>=20
>  /*#define DEBUG_INTEL_IOMMU*/
>  #ifdef DEBUG_INTEL_IOMMU
> @@ -1179,9 +1180,49 @@ static void vtd_handle_gcmd_sirtp(IntelIOMMUState =
*s)
>      vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_IRTPS);
>  }
>=20
> +static void vtd_switch_address_space(VTDAddressSpace *as, bool iommu_ena=
bled)
> +{
> +    assert(as);
> +
> +    trace_vtd_switch_address_space(pci_bus_num(as->bus),
> +                                   VTD_PCI_SLOT(as->devfn),
> +                                   VTD_PCI_FUNC(as->devfn),
> +                                   iommu_enabled);
> +
> +    /* Turn off first then on the other */
> +    if (iommu_enabled) {
> +        memory_region_set_enabled(&as->sys_alias, false);
> +        memory_region_set_enabled(&as->iommu, true);
> +    } else {
> +        memory_region_set_enabled(&as->iommu, false);
> +        memory_region_set_enabled(&as->sys_alias, true);
> +    }
> +}
> +
> +static void vtd_switch_address_space_all(IntelIOMMUState *s, bool enable=
d)
> +{
> +    GHashTableIter iter;
> +    VTDBus *vtd_bus;
> +    int i;
> +
> +    g_hash_table_iter_init(&iter, s->vtd_as_by_busptr);
> +    while (g_hash_table_iter_next(&iter, NULL, (void **)&vtd_bus)) {
> +        for (i =3D 0; i < X86_IOMMU_PCI_DEVFN_MAX; i++) {
> +            if (!vtd_bus->dev_as[i]) {
> +                continue;
> +            }
> +            vtd_switch_address_space(vtd_bus->dev_as[i], enabled);
> +        }
> +    }
> +}
> +
>  /* Handle Translation Enable/Disable */
>  static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
>  {
> +    if (s->dmar_enabled =3D=3D en) {
> +        return;
> +    }
> +
>      VTD_DPRINTF(CSR, "Translation Enable %s", (en ? "on" : "off"));
>=20
>      if (en) {
> @@ -1196,6 +1237,8 @@ static void vtd_handle_gcmd_te(IntelIOMMUState *s, =
bool en)
>          /* Ok - report back to driver */
>          vtd_set_clear_mask_long(s, DMAR_GSTS_REG, VTD_GSTS_TES, 0);
>      }
> +
> +    vtd_switch_address_space_all(s, en);
>  }

A context entry can be configured as pass-through, meaning no addr
translation for DMAs from this device when IOMMU is globally enabled.
There is no translation structure per se, so 'sys_alias" is also required
in such configuration.

>=20
>  /* Handle Interrupt Remap Enable/Disable */
> @@ -2343,15 +2386,43 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState =
*s,
> PCIBus *bus, int devfn)
>          vtd_dev_as->devfn =3D (uint8_t)devfn;
>          vtd_dev_as->iommu_state =3D s;
>          vtd_dev_as->context_cache_entry.context_cache_gen =3D 0;
> +
> +        /*
> +         * Memory region relationships looks like (Address range shows
> +         * only lower 32 bits to make it short in length...):
> +         *
> +         * |-----------------+-------------------+----------|
> +         * | Name            | Address range     | Priority |
> +         * |-----------------+-------------------+----------+
> +         * | vtd_root        | 00000000-ffffffff |        0 |
> +         * |  intel_iommu    | 00000000-ffffffff |        1 |
> +         * |  vtd_sys_alias  | 00000000-ffffffff |        1 |
> +         * |  intel_iommu_ir | fee00000-feefffff |       64 |
> +         * |-----------------+-------------------+----------|
> +         *
> +         * We enable/disable DMAR by switching enablement for
> +         * vtd_sys_alias and intel_iommu regions. IR region is always
> +         * enabled.
> +         */
>          memory_region_init_iommu(&vtd_dev_as->iommu, OBJECT(s),
>                                   &s->iommu_ops, "intel_iommu", UINT64_MA=
X);
> +        memory_region_init_alias(&vtd_dev_as->sys_alias, OBJECT(s),
> +                                 "vtd_sys_alias", get_system_memory(),
> +                                 0, memory_region_size(get_system_memory=
()));
>          memory_region_init_io(&vtd_dev_as->iommu_ir, OBJECT(s),
>                                &vtd_mem_ir_ops, s, "intel_iommu_ir",
>                                VTD_INTERRUPT_ADDR_SIZE);
> -        memory_region_add_subregion(&vtd_dev_as->iommu,
> VTD_INTERRUPT_ADDR_FIRST,
> -                                    &vtd_dev_as->iommu_ir);
> -        address_space_init(&vtd_dev_as->as,
> -                           &vtd_dev_as->iommu, "intel_iommu");
> +        memory_region_init(&vtd_dev_as->root, OBJECT(s),
> +                           "vtd_root", UINT64_MAX);
> +        memory_region_add_subregion_overlap(&vtd_dev_as->root,
> +                                            VTD_INTERRUPT_ADDR_FIRST,
> +                                            &vtd_dev_as->iommu_ir, 64);
> +        address_space_init(&vtd_dev_as->as, &vtd_dev_as->root, "intel_io=
mmu");
> +        memory_region_add_subregion_overlap(&vtd_dev_as->root, 0,
> +                                            &vtd_dev_as->sys_alias, 1);
> +        memory_region_add_subregion_overlap(&vtd_dev_as->root, 0,
> +                                            &vtd_dev_as->iommu, 1);
> +        vtd_switch_address_space(vtd_dev_as, s->dmar_enabled);
>      }
>      return vtd_dev_as;
>  }
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index d2b4973..aee93bb 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -10,6 +10,9 @@ xen_pv_mmio_write(uint64_t addr) "WARNING: write to Xen=
 PV
> Device MMIO space (ad
>  # hw/i386/x86-iommu.c
>  x86_iommu_iec_notify(bool global, uint32_t index, uint32_t mask) "Notify=
 IEC invalidation:
> global=3D%d index=3D%" PRIu32 " mask=3D%" PRIu32
>=20
> +# hw/i386/intel_iommu.c
> +vtd_switch_address_space(uint8_t bus, uint8_t slot, uint8_t fn, bool on)
> "Device %02x:%02x.%x switching address space (iommu enabled=3D%d)"
> +
>  # hw/i386/amd_iommu.c
>  amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write a=
t addr
> 0x%"PRIx64" +  offset 0x%"PRIx32
>  amdvi_cache_update(uint16_t domid, uint8_t bus, uint8_t slot, uint8_t fu=
nc, uint64_t gpa,
> uint64_t txaddr) " update iotlb domid 0x%"PRIx16" devid: %02x:%02x.%x gpa
> 0x%"PRIx64" hpa 0x%"PRIx64
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.=
h
> index 405c9d1..85c1b9b 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -83,6 +83,8 @@ struct VTDAddressSpace {
>      uint8_t devfn;
>      AddressSpace as;
>      MemoryRegion iommu;
> +    MemoryRegion root;
> +    MemoryRegion sys_alias;
>      MemoryRegion iommu_ir;      /* Interrupt region: 0xfeeXXXXX */
>      IntelIOMMUState *iommu_state;
>      VTDContextCacheEntry context_cache_entry;
> --
> 2.7.4
