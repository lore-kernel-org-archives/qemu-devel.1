Received: from eggs.gnu.org ([2001:4830:134:3::10]:36400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cc0rc-00065g-CT
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:23:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cc0ra-00026m-Up
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:23:08 -0500
Received: from ozlabs.org ([103.22.144.67]:36743)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1cc0ra-00024F-9t
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:23:06 -0500
Date: Fri, 10 Feb 2017 12:17:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170210011706.GU27610@umbus.fritz.box>
References: <1486456099-7345-1-git-send-email-peterx@redhat.com>
	<1486456099-7345-7-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5Dr6Wqe9hdyl7LAI"
Content-Disposition: inline
In-Reply-To: <1486456099-7345-7-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 06/17] intel_iommu: renaming gpa to iova
 where proper
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


--5Dr6Wqe9hdyl7LAI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 04:28:08PM +0800, Peter Xu wrote:
> There are lots of places in current intel_iommu.c codes that named
> "iova" as "gpa". It is really confusing to use a name "gpa" in these
> places (which is very easily to be understood as "Guest Physical
> Address", while it's not). To make the codes (much) easier to be read, I
> decided to do this once and for all.
>=20
> No functional change is made. Only literal ones.
>=20
> Reviewed-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Sounds like a good idea, that would certainly confuse me.

> ---
>  hw/i386/intel_iommu.c | 44 ++++++++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 86d19bb..0c94b79 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -259,7 +259,7 @@ static void vtd_update_iotlb(IntelIOMMUState *s, uint=
16_t source_id,
>      uint64_t *key =3D g_malloc(sizeof(*key));
>      uint64_t gfn =3D vtd_get_iotlb_gfn(addr, level);
> =20
> -    VTD_DPRINTF(CACHE, "update iotlb sid 0x%"PRIx16 " gpa 0x%"PRIx64
> +    VTD_DPRINTF(CACHE, "update iotlb sid 0x%"PRIx16 " iova 0x%"PRIx64
>                  " slpte 0x%"PRIx64 " did 0x%"PRIx16, source_id, addr, sl=
pte,
>                  domain_id);
>      if (g_hash_table_size(s->iotlb) >=3D VTD_IOTLB_MAX_SIZE) {
> @@ -575,12 +575,12 @@ static uint64_t vtd_get_slpte(dma_addr_t base_addr,=
 uint32_t index)
>      return slpte;
>  }
> =20
> -/* Given a gpa and the level of paging structure, return the offset of c=
urrent
> - * level.
> +/* Given an iova and the level of paging structure, return the offset
> + * of current level.
>   */
> -static inline uint32_t vtd_gpa_level_offset(uint64_t gpa, uint32_t level)
> +static inline uint32_t vtd_iova_level_offset(uint64_t iova, uint32_t lev=
el)
>  {
> -    return (gpa >> vtd_slpt_level_shift(level)) &
> +    return (iova >> vtd_slpt_level_shift(level)) &
>              ((1ULL << VTD_SL_LEVEL_BITS) - 1);
>  }
> =20
> @@ -628,12 +628,12 @@ static bool vtd_slpte_nonzero_rsvd(uint64_t slpte, =
uint32_t level)
>      }
>  }
> =20
> -/* Given the @gpa, get relevant @slptep. @slpte_level will be the last l=
evel
> +/* Given the @iova, get relevant @slptep. @slpte_level will be the last =
level
>   * of the translation, can be used for deciding the size of large page.
>   */
> -static int vtd_gpa_to_slpte(VTDContextEntry *ce, uint64_t gpa, bool is_w=
rite,
> -                            uint64_t *slptep, uint32_t *slpte_level,
> -                            bool *reads, bool *writes)
> +static int vtd_iova_to_slpte(VTDContextEntry *ce, uint64_t iova, bool is=
_write,
> +                             uint64_t *slptep, uint32_t *slpte_level,
> +                             bool *reads, bool *writes)
>  {
>      dma_addr_t addr =3D vtd_get_slpt_base_from_context(ce);
>      uint32_t level =3D vtd_get_level_from_context_entry(ce);
> @@ -642,11 +642,11 @@ static int vtd_gpa_to_slpte(VTDContextEntry *ce, ui=
nt64_t gpa, bool is_write,
>      uint32_t ce_agaw =3D vtd_get_agaw_from_context_entry(ce);
>      uint64_t access_right_check;
> =20
> -    /* Check if @gpa is above 2^X-1, where X is the minimum of MGAW in C=
AP_REG
> -     * and AW in context-entry.
> +    /* Check if @iova is above 2^X-1, where X is the minimum of MGAW
> +     * in CAP_REG and AW in context-entry.
>       */
> -    if (gpa & ~((1ULL << MIN(ce_agaw, VTD_MGAW)) - 1)) {
> -        VTD_DPRINTF(GENERAL, "error: gpa 0x%"PRIx64 " exceeds limits", g=
pa);
> +    if (iova & ~((1ULL << MIN(ce_agaw, VTD_MGAW)) - 1)) {
> +        VTD_DPRINTF(GENERAL, "error: iova 0x%"PRIx64 " exceeds limits", =
iova);
>          return -VTD_FR_ADDR_BEYOND_MGAW;
>      }
> =20
> @@ -654,13 +654,13 @@ static int vtd_gpa_to_slpte(VTDContextEntry *ce, ui=
nt64_t gpa, bool is_write,
>      access_right_check =3D is_write ? VTD_SL_W : VTD_SL_R;
> =20
>      while (true) {
> -        offset =3D vtd_gpa_level_offset(gpa, level);
> +        offset =3D vtd_iova_level_offset(iova, level);
>          slpte =3D vtd_get_slpte(addr, offset);
> =20
>          if (slpte =3D=3D (uint64_t)-1) {
>              VTD_DPRINTF(GENERAL, "error: fail to access second-level pag=
ing "
> -                        "entry at level %"PRIu32 " for gpa 0x%"PRIx64,
> -                        level, gpa);
> +                        "entry at level %"PRIu32 " for iova 0x%"PRIx64,
> +                        level, iova);
>              if (level =3D=3D vtd_get_level_from_context_entry(ce)) {
>                  /* Invalid programming of context-entry */
>                  return -VTD_FR_CONTEXT_ENTRY_INV;
> @@ -672,8 +672,8 @@ static int vtd_gpa_to_slpte(VTDContextEntry *ce, uint=
64_t gpa, bool is_write,
>          *writes =3D (*writes) && (slpte & VTD_SL_W);
>          if (!(slpte & access_right_check)) {
>              VTD_DPRINTF(GENERAL, "error: lack of %s permission for "
> -                        "gpa 0x%"PRIx64 " slpte 0x%"PRIx64,
> -                        (is_write ? "write" : "read"), gpa, slpte);
> +                        "iova 0x%"PRIx64 " slpte 0x%"PRIx64,
> +                        (is_write ? "write" : "read"), iova, slpte);
>              return is_write ? -VTD_FR_WRITE : -VTD_FR_READ;
>          }
>          if (vtd_slpte_nonzero_rsvd(slpte, level)) {
> @@ -827,7 +827,7 @@ static void vtd_do_iommu_translate(VTDAddressSpace *v=
td_as, PCIBus *bus,
>      /* Try to fetch slpte form IOTLB */
>      iotlb_entry =3D vtd_lookup_iotlb(s, source_id, addr);
>      if (iotlb_entry) {
> -        VTD_DPRINTF(CACHE, "hit iotlb sid 0x%"PRIx16 " gpa 0x%"PRIx64
> +        VTD_DPRINTF(CACHE, "hit iotlb sid 0x%"PRIx16 " iova 0x%"PRIx64
>                      " slpte 0x%"PRIx64 " did 0x%"PRIx16, source_id, addr,
>                      iotlb_entry->slpte, iotlb_entry->domain_id);
>          slpte =3D iotlb_entry->slpte;
> @@ -867,8 +867,8 @@ static void vtd_do_iommu_translate(VTDAddressSpace *v=
td_as, PCIBus *bus,
>          cc_entry->context_cache_gen =3D s->context_cache_gen;
>      }
> =20
> -    ret_fr =3D vtd_gpa_to_slpte(&ce, addr, is_write, &slpte, &level,
> -                              &reads, &writes);
> +    ret_fr =3D vtd_iova_to_slpte(&ce, addr, is_write, &slpte, &level,
> +                               &reads, &writes);
>      if (ret_fr) {
>          ret_fr =3D -ret_fr;
>          if (is_fpd_set && vtd_is_qualified_fault(ret_fr)) {
> @@ -2033,7 +2033,7 @@ static IOMMUTLBEntry vtd_iommu_translate(MemoryRegi=
on *iommu, hwaddr addr,
>                             is_write, &ret);
>      VTD_DPRINTF(MMU,
>                  "bus %"PRIu8 " slot %"PRIu8 " func %"PRIu8 " devfn %"PRI=
u8
> -                " gpa 0x%"PRIx64 " hpa 0x%"PRIx64, pci_bus_num(vtd_as->b=
us),
> +                " iova 0x%"PRIx64 " hpa 0x%"PRIx64, pci_bus_num(vtd_as->=
bus),
>                  VTD_PCI_SLOT(vtd_as->devfn), VTD_PCI_FUNC(vtd_as->devfn),
>                  vtd_as->devfn, addr, ret.translated_addr);
>      return ret;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5Dr6Wqe9hdyl7LAI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYnRSSAAoJEGw4ysog2bOSW9oQAJZBGZ4LoOIR+IeLloqCMrP9
BcuZub9ZoyCGLox0xCCG2eA4m+f3Av6II12ycDsCqODeGhbzQzUKbrXIwn++9lDu
KURriJuWMv76RT+NcAL//cr8oXNA2YAsgtpIt+ArFDD4N9VlA2387pilJ/vMeX3R
jwkT3N8Z5ZTHS+IggN4p9Y/EvwpGNcRlNdH/PVzMbelBHKAEKYu/d2ITiM6G9ACY
2/TNVblYriYwylxWQNJ91W6o1F0YKMxdkxNnK6inYS2MV2Gpoc7fOzUESfB2qTRq
gSypik9qCE5YgqxQ7lOO5H9jOvcRaryth/yIJYyKzF89a19jCoetcjvF/UewNMJm
J8uJLcMfebtIw0elWymR4yonr8lsB39zFYQXZldoD5Jtb5JQTFXBQ8L74sPpmbGl
k7B4e1VkH0s+PjUAfZiEcEEQqTQDTsVT3Hkd+VaYU6DoFj9ikDy889X2rtUFGHB3
Y9HB+Kc/jzYnRGlf7ZxhOTkCYKAkmrSKkITKn5JY6nodJ4OIncs7H9muadOKQ7Hl
omRbg+K7Lrg98wdbRvHq8dCukQyBQMeX3VUrfPtRzrkhvjOmKVxxp4+SwNMvISXQ
fWSrTOAOGJmhtSZzbma8xHarFdb8L3hDBghtaNc/bqdCDQoiufCOozH4LxhZldAp
0hhNUY/+URt2XzFkbU8N
=sQgr
-----END PGP SIGNATURE-----

--5Dr6Wqe9hdyl7LAI--
