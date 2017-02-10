Received: from eggs.gnu.org ([2001:4830:134:3::10]:39496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cc17r-0000jC-7t
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:39:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cc17l-0007dr-3W
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:39:50 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:34765)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1cc17k-0007cf-9u
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:39:49 -0500
Date: Fri, 10 Feb 2017 13:38:52 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170210023852.GF27610@umbus.fritz.box>
References: <1486456099-7345-1-git-send-email-peterx@redhat.com>
	<1486456099-7345-17-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kRoubgraN86rDphl"
Content-Disposition: inline
In-Reply-To: <1486456099-7345-17-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 16/17] intel_iommu: allow dynamic switch
 of IOMMU region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com


--kRoubgraN86rDphl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 04:28:18PM +0800, Peter Xu wrote:
> This is preparation work to finally enabled dynamic switching ON/OFF for
> VT-d protection. The old VT-d codes is using static IOMMU address space,
> and that won't satisfy vfio-pci device listeners.
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
>=20
> Reviewed-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

As with the previous patch the description sounds sensible, but I
don't know VT-d well enough to review the details.  With that caveat

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/i386/intel_iommu.c         | 78 +++++++++++++++++++++++++++++++++++++=
+++---
>  hw/i386/trace-events          |  2 +-
>  include/hw/i386/intel_iommu.h |  2 ++
>  3 files changed, 77 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index f8d5713..4fe161f 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1291,9 +1291,49 @@ static void vtd_handle_gcmd_sirtp(IntelIOMMUState =
*s)
>      vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_IRTPS);
>  }
> =20
> +static void vtd_switch_address_space(VTDAddressSpace *as)
> +{
> +    assert(as);
> +
> +    trace_vtd_switch_address_space(pci_bus_num(as->bus),
> +                                   VTD_PCI_SLOT(as->devfn),
> +                                   VTD_PCI_FUNC(as->devfn),
> +                                   as->iommu_state->dmar_enabled);
> +
> +    /* Turn off first then on the other */
> +    if (as->iommu_state->dmar_enabled) {
> +        memory_region_set_enabled(&as->sys_alias, false);
> +        memory_region_set_enabled(&as->iommu, true);
> +    } else {
> +        memory_region_set_enabled(&as->iommu, false);
> +        memory_region_set_enabled(&as->sys_alias, true);
> +    }
> +}
> +
> +static void vtd_switch_address_space_all(IntelIOMMUState *s)
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
> +            vtd_switch_address_space(vtd_bus->dev_as[i]);
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
> =20
>      if (en) {
> @@ -1308,6 +1348,8 @@ static void vtd_handle_gcmd_te(IntelIOMMUState *s, =
bool en)
>          /* Ok - report back to driver */
>          vtd_set_clear_mask_long(s, DMAR_GSTS_REG, VTD_GSTS_TES, 0);
>      }
> +
> +    vtd_switch_address_space_all(s);
>  }
> =20
>  /* Handle Interrupt Remap Enable/Disable */
> @@ -2529,15 +2571,43 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState =
*s, PCIBus *bus, int devfn)
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
> -        memory_region_add_subregion(&vtd_dev_as->iommu, VTD_INTERRUPT_AD=
DR_FIRST,
> -                                    &vtd_dev_as->iommu_ir);
> -        address_space_init(&vtd_dev_as->as,
> -                           &vtd_dev_as->iommu, name);
> +        memory_region_init(&vtd_dev_as->root, OBJECT(s),
> +                           "vtd_root", UINT64_MAX);
> +        memory_region_add_subregion_overlap(&vtd_dev_as->root,
> +                                            VTD_INTERRUPT_ADDR_FIRST,
> +                                            &vtd_dev_as->iommu_ir, 64);
> +        address_space_init(&vtd_dev_as->as, &vtd_dev_as->root, name);
> +        memory_region_add_subregion_overlap(&vtd_dev_as->root, 0,
> +                                            &vtd_dev_as->sys_alias, 1);
> +        memory_region_add_subregion_overlap(&vtd_dev_as->root, 0,
> +                                            &vtd_dev_as->iommu, 1);
> +        vtd_switch_address_space(vtd_dev_as);
>      }
>      return vtd_dev_as;
>  }
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index 463db0d..ebb650b 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -4,7 +4,6 @@
>  x86_iommu_iec_notify(bool global, uint32_t index, uint32_t mask) "Notify=
 IEC invalidation: global=3D%d index=3D%" PRIu32 " mask=3D%" PRIu32
> =20
>  # hw/i386/intel_iommu.c
> -vtd_switch_address_space(uint8_t bus, uint8_t slot, uint8_t fn, bool on)=
 "Device %02x:%02x.%x switching address space (iommu enabled=3D%d)"
>  vtd_inv_desc(const char *type, uint64_t hi, uint64_t lo) "invalidate des=
c type %s high 0x%"PRIx64" low 0x%"PRIx64
>  vtd_inv_desc_invalid(uint64_t hi, uint64_t lo) "invalid inv desc hi 0x%"=
PRIx64" lo 0x%"PRIx64
>  vtd_inv_desc_cc_domain(uint16_t domain) "context invalidate domain 0x%"P=
RIx16
> @@ -37,6 +36,7 @@ vtd_page_walk_one(uint32_t level, uint64_t iova, uint64=
_t gpa, uint64_t mask, in
>  vtd_page_walk_skip_read(uint64_t iova, uint64_t next) "Page walk skip io=
va 0x%"PRIx64" - 0x%"PRIx64" due to unable to read"
>  vtd_page_walk_skip_perm(uint64_t iova, uint64_t next) "Page walk skip io=
va 0x%"PRIx64" - 0x%"PRIx64" due to perm empty"
>  vtd_page_walk_skip_reserve(uint64_t iova, uint64_t next) "Page walk skip=
 iova 0x%"PRIx64" - 0x%"PRIx64" due to rsrv set"
> +vtd_switch_address_space(uint8_t bus, uint8_t slot, uint8_t fn, bool on)=
 "Device %02x:%02x.%x switching address space (iommu enabled=3D%d)"
> =20
>  # hw/i386/amd_iommu.c
>  amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write a=
t addr 0x%"PRIx64" +  offset 0x%"PRIx32
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index fe645aa..8f212a1 100644
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

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kRoubgraN86rDphl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYnSe8AAoJEGw4ysog2bOSCnQP/jtDEqjXWOimEJzfN6upi14p
nFCurPyYfBtu4p+MNUF1nU9fk5SDnYvL7+mV5fJ+jy4rvK8f0jbpn4b+wPR4arPX
9Qy25cE/Np1H9oZqO/mw3X7871W5/KIGhoE92b/5Om/4AsULsodBQ8rKmpol4jhO
Q7D+ChLxswqqRttgbvuyU2hkxr+TcG4CCbJUXdMn9oyKRZKieYNl87DPDrQLXutP
M7rUf7SqnVu4BYTmKP9Et3D/nb3S6puRhqqpgkBqSenfjOAQD9hRwrcw7ILH7RlG
tkrY0QJVogPuHg8Rk2GUheywQbKPoiSKxxORwlqLR1P/kMSRh+wLtx41KPP1OnGn
W3oCkbJt0tAzdMvlW0m/oXXdXbkH/JDuxRmZrer8L/QEmk0cfmNTbZndn6AOASca
smY1Y+17PlEwDi7TrNS3xANFj5VWaF55dkPOQpev1i38dEEIgcBy27stLfcfDgFE
1du2wB4d4iP3xKjIkUyJ9IHwRUtS2gAY+1e+cCMViOd4pP61JXr2LvvBHS0hSAwA
srMKC660cbYsvlU3TV0oqJ3xcjlOuBh9epa+kEdCqCmZt2IZjT7Ilvge+8UD+JLr
wDOXykSIu0H/moarpx7riTBpWo987BdGlkm+V1IkGCDoJ1kBTxtZjkgMfp6MA+Js
7M8lnKwiRVgI+YL+2aRu
=Oj/5
-----END PGP SIGNATURE-----

--kRoubgraN86rDphl--
