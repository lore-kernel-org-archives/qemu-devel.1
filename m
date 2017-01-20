Received: from eggs.gnu.org ([2001:4830:134:3::10]:53683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1cUUXs-0001ar-TI
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 03:27:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1cUUXp-0005cN-Lq
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 03:27:40 -0500
Received: from mga06.intel.com ([134.134.136.31]:54281)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1cUUXp-0005bp-8s
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 03:27:37 -0500
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Fri, 20 Jan 2017 08:27:31 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190C14FAA@SHSMSX101.ccr.corp.intel.com>
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-4-git-send-email-peterx@redhat.com>
In-Reply-To: <1484276800-26814-4-git-send-email-peterx@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH RFC v3 03/14] intel_iommu: renaming gpa to
 iova where proper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Lan, Tianyu" <tianyu.lan@intel.com>, "mst@redhat.com" <mst@redhat.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "bd.aviv@gmail.com" <bd.aviv@gmail.com>

> From: Peter Xu [mailto:peterx@redhat.com]
> Sent: Friday, January 13, 2017 11:06 AM
>=20
> There are lots of places in current intel_iommu.c codes that named
> "iova" as "gpa". It is really confusing to use a name "gpa" in these
> places (which is very easily to be understood as "Guest Physical
> Address", while it's not). To make the codes (much) easier to be read, I
> decided to do this once and for all.
>=20
> No functional change is made. Only literal ones.

If looking at VT-d spec (3.2 Domains and Address Translation)

	Remapping hardware treats the address in inbound requests as DMA=20
	Address. Depending on the software usage model, the DMA address=20
	space may be the Guest-Physical Address (GPA) space of the virtual=20
	machine to which the device is assigned, or application Virtual Address=20
	(VA) space defined by the PASID assigned to an application, or some=20
	abstract I/O virtual address (IOVA) space defined by software.

	For simplicity, this document refers to address in requests-without-
	PASID as GPA, and address in requests-with-PASID as Virtual Address=20
	(VA) (or Guest Virtual Address (GVA), if such request is from a device=20
	assigned to a virtual machine). The translated address is referred to as=20
	HPA.

It will add more readability if similar comment is added in this file - you
can say choosing iova to represent address in requests-without-PASID.

>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/i386/intel_iommu.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 77d467a..275c3db 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -259,7 +259,7 @@ static void vtd_update_iotlb(IntelIOMMUState *s, uint=
16_t
> source_id,
>      uint64_t *key =3D g_malloc(sizeof(*key));
>      uint64_t gfn =3D vtd_get_iotlb_gfn(addr, level);
>=20
> -    VTD_DPRINTF(CACHE, "update iotlb sid 0x%"PRIx16 " gpa 0x%"PRIx64
> +    VTD_DPRINTF(CACHE, "update iotlb sid 0x%"PRIx16 " iova 0x%"PRIx64
>                  " slpte 0x%"PRIx64 " did 0x%"PRIx16, source_id, addr, sl=
pte,
>                  domain_id);
>      if (g_hash_table_size(s->iotlb) >=3D VTD_IOTLB_MAX_SIZE) {
> @@ -575,12 +575,12 @@ static uint64_t vtd_get_slpte(dma_addr_t base_addr,=
 uint32_t
> index)
>      return slpte;
>  }
>=20
> -/* Given a gpa and the level of paging structure, return the offset of c=
urrent
> - * level.
> +/* Given an iova and the level of paging structure, return the offset
> + * of current level.
>   */
> -static inline uint32_t vtd_gpa_level_offset(uint64_t gpa, uint32_t level=
)
> +static inline uint32_t vtd_iova_level_offset(uint64_t iova, uint32_t lev=
el)
>  {
> -    return (gpa >> vtd_slpt_level_shift(level)) &
> +    return (iova >> vtd_slpt_level_shift(level)) &
>              ((1ULL << VTD_SL_LEVEL_BITS) - 1);
>  }
>=20
> @@ -628,10 +628,10 @@ static bool vtd_slpte_nonzero_rsvd(uint64_t slpte, =
uint32_t
> level)
>      }
>  }
>=20
> -/* Given the @gpa, get relevant @slptep. @slpte_level will be the last l=
evel
> +/* Given the @iova, get relevant @slptep. @slpte_level will be the last =
level
>   * of the translation, can be used for deciding the size of large page.
>   */
> -static int vtd_gpa_to_slpte(VTDContextEntry *ce, uint64_t gpa, bool is_w=
rite,
> +static int vtd_gpa_to_slpte(VTDContextEntry *ce, uint64_t iova, bool is_=
write,
>                              uint64_t *slptep, uint32_t *slpte_level,
>                              bool *reads, bool *writes)
>  {
> @@ -642,11 +642,11 @@ static int vtd_gpa_to_slpte(VTDContextEntry *ce, ui=
nt64_t gpa,
> bool is_write,
>      uint32_t ce_agaw =3D vtd_get_agaw_from_context_entry(ce);
>      uint64_t access_right_check;
>=20
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
>=20
> @@ -654,13 +654,13 @@ static int vtd_gpa_to_slpte(VTDContextEntry *ce, ui=
nt64_t gpa,
> bool is_write,
>      access_right_check =3D is_write ? VTD_SL_W : VTD_SL_R;
>=20
>      while (true) {
> -        offset =3D vtd_gpa_level_offset(gpa, level);
> +        offset =3D vtd_iova_level_offset(iova, level);
>          slpte =3D vtd_get_slpte(addr, offset);
>=20
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
64_t gpa,
> bool is_write,
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
td_as,
> PCIBus *bus,
>      /* Try to fetch slpte form IOTLB */
>      iotlb_entry =3D vtd_lookup_iotlb(s, source_id, addr);
>      if (iotlb_entry) {
> -        VTD_DPRINTF(CACHE, "hit iotlb sid 0x%"PRIx16 " gpa 0x%"PRIx64
> +        VTD_DPRINTF(CACHE, "hit iotlb sid 0x%"PRIx16 " iova 0x%"PRIx64
>                      " slpte 0x%"PRIx64 " did 0x%"PRIx16, source_id, addr=
,
>                      iotlb_entry->slpte, iotlb_entry->domain_id);
>          slpte =3D iotlb_entry->slpte;
> @@ -2025,7 +2025,7 @@ static IOMMUTLBEntry vtd_iommu_translate(MemoryRegi=
on
> *iommu, hwaddr addr,
>                             is_write, &ret);
>      VTD_DPRINTF(MMU,
>                  "bus %"PRIu8 " slot %"PRIu8 " func %"PRIu8 " devfn %"PRI=
u8
> -                " gpa 0x%"PRIx64 " hpa 0x%"PRIx64, pci_bus_num(vtd_as->b=
us),
> +                " iova 0x%"PRIx64 " hpa 0x%"PRIx64, pci_bus_num(vtd_as->=
bus),
>                  VTD_PCI_SLOT(vtd_as->devfn), VTD_PCI_FUNC(vtd_as->devfn)=
,
>                  vtd_as->devfn, addr, ret.translated_addr);
>      return ret;
> --
> 2.7.4
