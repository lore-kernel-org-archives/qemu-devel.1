Received: from eggs.gnu.org ([2001:4830:134:3::10]:60593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cJ9He-0004sx-PV
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 20:32:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cJ9Hb-0008Qo-Ms
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 20:32:02 -0500
Received: from ozlabs.org ([103.22.144.67]:47783)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1cJ9Ha-0008Ok-KP
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 20:31:59 -0500
Date: Tue, 20 Dec 2016 10:30:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161219233012.GF23176@umbus.fritz.box>
References: <1482158486-18597-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cz6wLo+OExbGG7q/"
Content-Disposition: inline
In-Reply-To: <1482158486-18597-1-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] intel_iommu: allow dynamic switch of IOMMU
 region
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


--cz6wLo+OExbGG7q/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 19, 2016 at 10:41:26PM +0800, Peter Xu wrote:
> This is preparation work to finally enabled dynamic switching ON/OFF for
> VT-d protection. The old VT-d codes is using static IOMMU region, and
> that won't satisfy vfio-pci device listeners.
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
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/i386/intel_iommu.c         | 75 +++++++++++++++++++++++++++++++++++++=
+++---
>  hw/i386/trace-events          |  3 ++
>  include/hw/i386/intel_iommu.h |  2 ++
>  3 files changed, 76 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 5f3e351..75a3f4e 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1179,9 +1179,42 @@ static void vtd_handle_gcmd_sirtp(IntelIOMMUState =
*s)
>      vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_IRTPS);
>  }
> =20
> +static void vtd_switch_address_space(IntelIOMMUState *s, bool enabled)
> +{
> +    GHashTableIter iter;
> +    VTDBus *vtd_bus;
> +    VTDAddressSpace *as;
> +    int i;
> +
> +    g_hash_table_iter_init(&iter, s->vtd_as_by_busptr);
> +    while (g_hash_table_iter_next (&iter, NULL, (void**)&vtd_bus)) {
> +        for (i =3D 0; i < X86_IOMMU_PCI_DEVFN_MAX; i++) {
> +            as =3D vtd_bus->dev_as[i];
> +            if (as =3D=3D NULL) {
> +                continue;
> +            }
> +            trace_vtd_switch_address_space(pci_bus_num(vtd_bus->bus),
> +                                           VTD_PCI_SLOT(i), VTD_PCI_FUNC=
(i),
> +                                           enabled);
> +            if (enabled) {
> +                memory_region_add_subregion_overlap(&as->root, 0,
> +                                                    &as->iommu, 2);
> +            } else {
> +                memory_region_del_subregion(&as->root, &as->iommu);

Why not use memory_region_set_enabled() rather than actually
adding/deleting the subregion?

> +            }
> +        }
> +    }
> +}
> +
>  /* Handle Translation Enable/Disable */
>  static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
>  {
> +    bool old =3D s->dmar_enabled;
> +
> +    if (old =3D=3D en) {
> +        return;
> +    }
> +
>      VTD_DPRINTF(CSR, "Translation Enable %s", (en ? "on" : "off"));
> =20
>      if (en) {
> @@ -1196,6 +1229,8 @@ static void vtd_handle_gcmd_te(IntelIOMMUState *s, =
bool en)
>          /* Ok - report back to driver */
>          vtd_set_clear_mask_long(s, DMAR_GSTS_REG, VTD_GSTS_TES, 0);
>      }
> +
> +    vtd_switch_address_space(s, en);
>  }
> =20
>  /* Handle Interrupt Remap Enable/Disable */
> @@ -2343,15 +2378,47 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState =
*s, PCIBus *bus, int devfn)
>          vtd_dev_as->devfn =3D (uint8_t)devfn;
>          vtd_dev_as->iommu_state =3D s;
>          vtd_dev_as->context_cache_entry.context_cache_gen =3D 0;
> +
> +        /*
> +         * When DMAR is disabled, memory region relationships looks
> +         * like:
> +         *
> +         * 0000000000000000-ffffffffffffffff (prio 0, RW): vtd_root
> +         *  0000000000000000-ffffffffffffffff (prio 1, RW): vtd_sys_alias
> +         *  00000000fee00000-00000000feefffff (prio 64, RW): intel_iommu=
_ir
> +         *
> +         * When DMAR is disabled, it becomes:
> +         *
> +         * 0000000000000000-ffffffffffffffff (prio 0, RW): vtd_root
> +         *  0000000000000000-ffffffffffffffff (prio 2, RW): intel_iommu
> +         *  0000000000000000-ffffffffffffffff (prio 1, RW): vtd_sys_alias
> +         *  00000000fee00000-00000000feefffff (prio 64, RW): intel_iommu=
_ir
> +         *
> +         * The intel_iommu region is dynamically added/removed.
> +         */
>          memory_region_init_iommu(&vtd_dev_as->iommu, OBJECT(s),
>                                   &s->iommu_ops, "intel_iommu", UINT64_MA=
X);

I'm almost certain UINT64_MAX is wrong here.  For one thing it would
collide with PCI BARs.  For another, I can't imagine that the IOMMU
page tables can really span an entire 2^64 space.

> +        memory_region_init_alias(&vtd_dev_as->sys_alias, OBJECT(s),
> +                                 "vtd_sys_alias", get_system_memory(),
> +                                 0, memory_region_size(get_system_memory=
()));

I strongly suspect using memory_region_size(get_system_memory()) is
also incorrect here.  System memory has size UINT64_MAX, but I'll bet
you you can't actually access all of that via PCI space (again, it
would collide with actual PCI BARs).  I also suspect you can't reach
CPU MMIO regions via the PCI DMA space.

So, I think you should find out what this limit actually is and
restrict the alias to that window.

>          memory_region_init_io(&vtd_dev_as->iommu_ir, OBJECT(s),
>                                &vtd_mem_ir_ops, s, "intel_iommu_ir",
>                                VTD_INTERRUPT_ADDR_SIZE);
> -        memory_region_add_subregion(&vtd_dev_as->iommu, VTD_INTERRUPT_AD=
DR_FIRST,
> -                                    &vtd_dev_as->iommu_ir);
> -        address_space_init(&vtd_dev_as->as,
> -                           &vtd_dev_as->iommu, "intel_iommu");
> +        memory_region_init(&vtd_dev_as->root, OBJECT(s),
> +                           "vtd_root", UINT64_MAX);
> +        memory_region_add_subregion_overlap(&vtd_dev_as->root,
> +                                            VTD_INTERRUPT_ADDR_FIRST,
> +                                            &vtd_dev_as->iommu_ir, 64);
> +        address_space_init(&vtd_dev_as->as, &vtd_dev_as->root, name);
> +        memory_region_add_subregion_overlap(&vtd_dev_as->root, 0,
> +                                            &vtd_dev_as->sys_alias, 1);
> +        if (s->dmar_enabled) {
> +            memory_region_add_subregion_overlap(&vtd_dev_as->root, 0,
> +                                                &vtd_dev_as->iommu, 2);
> +        }

Hmm.  You have the IOMMU translated region overlaying the
direct-mapped alias.  You enable and disable the IOMMU subregion, but
you always leave the direct mapping enabled.  You might get away with
this because the size of the IOMMU region is UINT64_MAX, which will
overlay everything - but as above, I think that's wrong.  If that's
changed then guest devices may be able to access portions of the raw
address space outside the IOMMU mapped region, which could break the
guest's expectations of device isolation.

I think it would be much safer to disable the system memory alias when
the IOMMU is enabled.

> +        trace_vtd_switch_address_space(pci_bus_num(vtd_bus->bus),
> +                                       VTD_PCI_SLOT(devfn), VTD_PCI_FUNC=
(devfn),
> +                                       s->dmar_enabled);
>      }
>      return vtd_dev_as;
>  }
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index d2b4973..aee93bb 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -10,6 +10,9 @@ xen_pv_mmio_write(uint64_t addr) "WARNING: write to Xen=
 PV Device MMIO space (ad
>  # hw/i386/x86-iommu.c
>  x86_iommu_iec_notify(bool global, uint32_t index, uint32_t mask) "Notify=
 IEC invalidation: global=3D%d index=3D%" PRIu32 " mask=3D%" PRIu32
> =20
> +# hw/i386/intel_iommu.c
> +vtd_switch_address_space(uint8_t bus, uint8_t slot, uint8_t fn, bool on)=
 "Device %02x:%02x.%x switching address space (iommu enabled=3D%d)"
> +
>  # hw/i386/amd_iommu.c
>  amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write a=
t addr 0x%"PRIx64" +  offset 0x%"PRIx32
>  amdvi_cache_update(uint16_t domid, uint8_t bus, uint8_t slot, uint8_t fu=
nc, uint64_t gpa, uint64_t txaddr) " update iotlb domid 0x%"PRIx16" devid: =
%02x:%02x.%x gpa 0x%"PRIx64" hpa 0x%"PRIx64
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
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

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cz6wLo+OExbGG7q/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYWG2BAAoJEGw4ysog2bOSg6wQANiO0P/q1uT9khKQ+14MMJtt
xmVvvnKKeZ+tmi1d9jpJte27PlSnGIOVbCt78brNBAwavo1VKbnRoOcz1gizaVyA
tSKSWyzMAyDhtwOhVAmlOw83YYVWRJRLnpbhZQQEs/zRQkVXTlOT90jUlQspghO5
Ie0GluMxzYVL5zrvzBHknf6eemNMtmAje3cLH/jr1JPRtlhjmflJQBIJk+NG1Mk0
JWkgy+gD5WdyVDf8GG0sGsb5gre+TimYzfIlcmFp1P+WJ+T7cv0HeTKs4oxWZEo4
rT2qEuNooN541V3tDSgj7YzZIWfqo6E+kHbP9K+5Vz1HXlADU0She39wOM6UFlY/
Ek7o6OHVaS/1qe9c92eMgixqsW0GEgx1yBAKgTDLHD5xuwVgfGdS9C+MDlmIsqzs
G9NHbxWoj2FxldNXlcqkC0ETQCSY3xDa2y0Rqg2YUbeNrCDUIvUycrsI8+rkkmM/
3+8VmeDHOlExIYI1hnWFg2sJq16oXFQMQQemb14r32iTe+NuqtHa8ntHgwwyMN0F
bblFAKBrfYw9VlQvcertui+yzlvqP8YIj8dIixj4nnsjUSN2upOJEz2iI9m8Zj3l
5fjKvxzmU+z8lqtAS+TeACBUxeMyrvLAVilBJyh+U8wHW4QDwMAu4Iy0NhRmKCfI
Qa4OYPp4tObmweNk8Heb
=hXFh
-----END PGP SIGNATURE-----

--cz6wLo+OExbGG7q/--
