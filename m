Received: from eggs.gnu.org ([2001:4830:134:3::10]:36433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cc0re-00067A-Jf
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:23:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cc0rc-00029k-Rs
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:23:10 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:37095)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1cc0rc-00025G-44
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:23:08 -0500
Date: Fri, 10 Feb 2017 12:20:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170210012017.GW27610@umbus.fritz.box>
References: <1486456099-7345-1-git-send-email-peterx@redhat.com>
	<1486456099-7345-9-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2DJuma0xDHN2clgl"
Content-Disposition: inline
In-Reply-To: <1486456099-7345-9-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 08/17] intel_iommu: convert dbg macros
 to trace for trans
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


--2DJuma0xDHN2clgl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 04:28:10PM +0800, Peter Xu wrote:
> Another patch to convert the DPRINTF() stuffs. This patch focuses on the
> address translation path and caching.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/i386/intel_iommu.c | 69 ++++++++++++++++++---------------------------=
------
>  hw/i386/trace-events  | 10 ++++++++
>  2 files changed, 34 insertions(+), 45 deletions(-)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 08e43b6..ad304f6 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -260,11 +260,9 @@ static void vtd_update_iotlb(IntelIOMMUState *s, uin=
t16_t source_id,
>      uint64_t *key =3D g_malloc(sizeof(*key));
>      uint64_t gfn =3D vtd_get_iotlb_gfn(addr, level);
> =20
> -    VTD_DPRINTF(CACHE, "update iotlb sid 0x%"PRIx16 " iova 0x%"PRIx64
> -                " slpte 0x%"PRIx64 " did 0x%"PRIx16, source_id, addr, sl=
pte,
> -                domain_id);
> +    trace_vtd_iotlb_page_update(source_id, addr, slpte, domain_id);
>      if (g_hash_table_size(s->iotlb) >=3D VTD_IOTLB_MAX_SIZE) {
> -        VTD_DPRINTF(CACHE, "iotlb exceeds size limit, forced to reset");
> +        trace_vtd_iotlb_reset("iotlb exceeds size limit");
>          vtd_reset_iotlb(s);
>      }
> =20
> @@ -505,8 +503,7 @@ static int vtd_get_root_entry(IntelIOMMUState *s, uin=
t8_t index,
> =20
>      addr =3D s->root + index * sizeof(*re);
>      if (dma_memory_read(&address_space_memory, addr, re, sizeof(*re))) {
> -        VTD_DPRINTF(GENERAL, "error: fail to access root-entry at 0x%"PR=
Ix64
> -                    " + %"PRIu8, s->root, index);
> +        trace_vtd_re_invalid(re->rsvd, re->val);
>          re->val =3D 0;
>          return -VTD_FR_ROOT_TABLE_INV;
>      }
> @@ -524,15 +521,10 @@ static int vtd_get_context_entry_from_root(VTDRootE=
ntry *root, uint8_t index,
>  {
>      dma_addr_t addr;
> =20
> -    if (!vtd_root_entry_present(root)) {
> -        VTD_DPRINTF(GENERAL, "error: root-entry is not present");
> -        return -VTD_FR_ROOT_ENTRY_P;
> -    }
> +    /* we have checked that root entry is present */
>      addr =3D (root->val & VTD_ROOT_ENTRY_CTP) + index * sizeof(*ce);
>      if (dma_memory_read(&address_space_memory, addr, ce, sizeof(*ce))) {
> -        VTD_DPRINTF(GENERAL, "error: fail to access context-entry at 0x%=
"PRIx64
> -                    " + %"PRIu8,
> -                    (uint64_t)(root->val & VTD_ROOT_ENTRY_CTP), index);
> +        trace_vtd_re_invalid(root->rsvd, root->val);
>          return -VTD_FR_CONTEXT_TABLE_INV;
>      }
>      ce->lo =3D le64_to_cpu(ce->lo);
> @@ -704,12 +696,11 @@ static int vtd_dev_to_context_entry(IntelIOMMUState=
 *s, uint8_t bus_num,
>      }
> =20
>      if (!vtd_root_entry_present(&re)) {
> -        VTD_DPRINTF(GENERAL, "error: root-entry #%"PRIu8 " is not presen=
t",
> -                    bus_num);
> +        /* Not error - it's okay we don't have root entry. */
> +        trace_vtd_re_not_present(bus_num);
>          return -VTD_FR_ROOT_ENTRY_P;
>      } else if (re.rsvd || (re.val & VTD_ROOT_ENTRY_RSVD)) {
> -        VTD_DPRINTF(GENERAL, "error: non-zero reserved field in root-ent=
ry "
> -                    "hi 0x%"PRIx64 " lo 0x%"PRIx64, re.rsvd, re.val);
> +        trace_vtd_re_invalid(re.rsvd, re.val);
>          return -VTD_FR_ROOT_ENTRY_RSVD;
>      }
> =20
> @@ -719,22 +710,17 @@ static int vtd_dev_to_context_entry(IntelIOMMUState=
 *s, uint8_t bus_num,
>      }
> =20
>      if (!vtd_context_entry_present(ce)) {
> -        VTD_DPRINTF(GENERAL,
> -                    "error: context-entry #%"PRIu8 "(bus #%"PRIu8 ") "
> -                    "is not present", devfn, bus_num);
> +        /* Not error - it's okay we don't have context entry. */
> +        trace_vtd_ce_not_present(bus_num, devfn);
>          return -VTD_FR_CONTEXT_ENTRY_P;
>      } else if ((ce->hi & VTD_CONTEXT_ENTRY_RSVD_HI) ||
>                 (ce->lo & VTD_CONTEXT_ENTRY_RSVD_LO)) {
> -        VTD_DPRINTF(GENERAL,
> -                    "error: non-zero reserved field in context-entry "
> -                    "hi 0x%"PRIx64 " lo 0x%"PRIx64, ce->hi, ce->lo);
> +        trace_vtd_ce_invalid(ce->hi, ce->lo);
>          return -VTD_FR_CONTEXT_ENTRY_RSVD;
>      }
>      /* Check if the programming of context-entry is valid */
>      if (!vtd_is_level_supported(s, vtd_get_level_from_context_entry(ce))=
) {
> -        VTD_DPRINTF(GENERAL, "error: unsupported Address Width value in "
> -                    "context-entry hi 0x%"PRIx64 " lo 0x%"PRIx64,
> -                    ce->hi, ce->lo);
> +        trace_vtd_ce_invalid(ce->hi, ce->lo);
>          return -VTD_FR_CONTEXT_ENTRY_INV;
>      } else {
>          switch (ce->lo & VTD_CONTEXT_ENTRY_TT) {
> @@ -743,9 +729,7 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *=
s, uint8_t bus_num,
>          case VTD_CONTEXT_TT_DEV_IOTLB:
>              break;
>          default:
> -            VTD_DPRINTF(GENERAL, "error: unsupported Translation Type in=
 "
> -                        "context-entry hi 0x%"PRIx64 " lo 0x%"PRIx64,
> -                        ce->hi, ce->lo);
> +            trace_vtd_ce_invalid(ce->hi, ce->lo);
>              return -VTD_FR_CONTEXT_ENTRY_INV;
>          }
>      }
> @@ -825,9 +809,8 @@ static void vtd_do_iommu_translate(VTDAddressSpace *v=
td_as, PCIBus *bus,
>      /* Try to fetch slpte form IOTLB */
>      iotlb_entry =3D vtd_lookup_iotlb(s, source_id, addr);
>      if (iotlb_entry) {
> -        VTD_DPRINTF(CACHE, "hit iotlb sid 0x%"PRIx16 " iova 0x%"PRIx64
> -                    " slpte 0x%"PRIx64 " did 0x%"PRIx16, source_id, addr,
> -                    iotlb_entry->slpte, iotlb_entry->domain_id);
> +        trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->slpte,
> +                                 iotlb_entry->domain_id);
>          slpte =3D iotlb_entry->slpte;
>          reads =3D iotlb_entry->read_flags;
>          writes =3D iotlb_entry->write_flags;
> @@ -836,10 +819,9 @@ static void vtd_do_iommu_translate(VTDAddressSpace *=
vtd_as, PCIBus *bus,
>      }
>      /* Try to fetch context-entry from cache first */
>      if (cc_entry->context_cache_gen =3D=3D s->context_cache_gen) {
> -        VTD_DPRINTF(CACHE, "hit context-cache bus %d devfn %d "
> -                    "(hi %"PRIx64 " lo %"PRIx64 " gen %"PRIu32 ")",
> -                    bus_num, devfn, cc_entry->context_entry.hi,
> -                    cc_entry->context_entry.lo, cc_entry->context_cache_=
gen);
> +        trace_vtd_iotlb_cc_hit(bus_num, devfn, cc_entry->context_entry.h=
i,
> +                               cc_entry->context_entry.lo,
> +                               cc_entry->context_cache_gen);
>          ce =3D cc_entry->context_entry;
>          is_fpd_set =3D ce.lo & VTD_CONTEXT_ENTRY_FPD;
>      } else {
> @@ -848,19 +830,16 @@ static void vtd_do_iommu_translate(VTDAddressSpace =
*vtd_as, PCIBus *bus,
>          if (ret_fr) {
>              ret_fr =3D -ret_fr;
>              if (is_fpd_set && vtd_is_qualified_fault(ret_fr)) {
> -                VTD_DPRINTF(FLOG, "fault processing is disabled for DMA "
> -                            "requests through this context-entry "
> -                            "(with FPD Set)");
> +                trace_vtd_fault_disabled();
>              } else {
>                  vtd_report_dmar_fault(s, source_id, addr, ret_fr, is_wri=
te);
>              }
>              return;
>          }
>          /* Update context-cache */
> -        VTD_DPRINTF(CACHE, "update context-cache bus %d devfn %d "
> -                    "(hi %"PRIx64 " lo %"PRIx64 " gen %"PRIu32 "->%"PRIu=
32 ")",
> -                    bus_num, devfn, ce.hi, ce.lo,
> -                    cc_entry->context_cache_gen, s->context_cache_gen);
> +        trace_vtd_iotlb_cc_update(bus_num, devfn, ce.hi, ce.lo,
> +                                  cc_entry->context_cache_gen,
> +                                  s->context_cache_gen);
>          cc_entry->context_entry =3D ce;
>          cc_entry->context_cache_gen =3D s->context_cache_gen;
>      }
> @@ -870,8 +849,7 @@ static void vtd_do_iommu_translate(VTDAddressSpace *v=
td_as, PCIBus *bus,
>      if (ret_fr) {
>          ret_fr =3D -ret_fr;
>          if (is_fpd_set && vtd_is_qualified_fault(ret_fr)) {
> -            VTD_DPRINTF(FLOG, "fault processing is disabled for DMA requ=
ests "
> -                        "through this context-entry (with FPD Set)");
> +            trace_vtd_fault_disabled();
>          } else {
>              vtd_report_dmar_fault(s, source_id, addr, ret_fr, is_write);
>          }
> @@ -1031,6 +1009,7 @@ static uint64_t vtd_context_cache_invalidate(IntelI=
OMMUState *s, uint64_t val)
> =20
>  static void vtd_iotlb_global_invalidate(IntelIOMMUState *s)
>  {
> +    trace_vtd_iotlb_reset("global invalidation recved");
>      vtd_reset_iotlb(s);
>  }
> =20
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index 02aeaab..88ad5e4 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -20,6 +20,16 @@ vtd_inv_desc_wait_sw(uint64_t addr, uint32_t data) "wa=
it invalidate status write
>  vtd_inv_desc_wait_irq(const char *msg) "%s"
>  vtd_inv_desc_wait_invalid(uint64_t hi, uint64_t lo) "invalid wait desc h=
i 0x%"PRIx64" lo 0x%"PRIx64
>  vtd_inv_desc_wait_write_fail(uint64_t hi, uint64_t lo) "write fail for w=
ait desc hi 0x%"PRIx64" lo 0x%"PRIx64
> +vtd_re_not_present(uint8_t bus) "Root entry bus %"PRIu8" not present"
> +vtd_re_invalid(uint64_t hi, uint64_t lo) "invalid root entry hi 0x%"PRIx=
64" lo 0x%"PRIx64
> +vtd_ce_not_present(uint8_t bus, uint8_t devfn) "Context entry bus %"PRIu=
8" devfn %"PRIu8" not present"
> +vtd_ce_invalid(uint64_t hi, uint64_t lo) "invalid context entry hi 0x%"P=
RIx64" lo 0x%"PRIx64
> +vtd_iotlb_page_hit(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t=
 domain) "IOTLB page hit sid 0x%"PRIx16" iova 0x%"PRIx64" slpte 0x%"PRIx64"=
 domain 0x%"PRIx16
> +vtd_iotlb_page_update(uint16_t sid, uint64_t addr, uint64_t slpte, uint1=
6_t domain) "IOTLB page update sid 0x%"PRIx16" iova 0x%"PRIx64" slpte 0x%"P=
RIx64" domain 0x%"PRIx16
> +vtd_iotlb_cc_hit(uint8_t bus, uint8_t devfn, uint64_t high, uint64_t low=
, uint32_t gen) "IOTLB context hit bus 0x%"PRIx8" devfn 0x%"PRIx8" high 0x%=
"PRIx64" low 0x%"PRIx64" gen %"PRIu32
> +vtd_iotlb_cc_update(uint8_t bus, uint8_t devfn, uint64_t high, uint64_t =
low, uint32_t gen1, uint32_t gen2) "IOTLB context update bus 0x%"PRIx8" dev=
fn 0x%"PRIx8" high 0x%"PRIx64" low 0x%"PRIx64" gen %"PRIu32" -> gen %"PRIu32
> +vtd_iotlb_reset(const char *reason) "IOTLB reset (reason: %s)"
> +vtd_fault_disabled(void) "Fault processing disabled for context entry"
> =20
>  # hw/i386/amd_iommu.c
>  amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write a=
t addr 0x%"PRIx64" +  offset 0x%"PRIx32

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2DJuma0xDHN2clgl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYnRVRAAoJEGw4ysog2bOSMpwP/iEC1AomSNSV//N9PNPj+MJN
4Yfz2/SaJFeufKiGvhm2k0zGox2Tu7aw/KkX/INDUwpc+Y3bQ28ObBxiCfPE9ct9
MtYOQTrgMkZT6jgYzxPo9F01cv7GmIXeVbx9OwRlNu+iJvc4BGwG9He9mS5yBp2b
ir21+8nNAnD3HCpBbWT+S8LnShZY4v5+JrqoZeeOipaP0Uwx6LPFYibfeeCjASq0
mn8PX+fOYkf+Lg9UmXpNVfcWn4+b0rhTOD00VXMQ35Grz1FmGzRD5EQb5Yprdn5i
o98ZEcTntUCHEamYI4f1l1Zp5JXHoMg35TxAiYUod+jE6aOPO+VNt5JnX99MP38X
G4CiNnr2eNbZI9k0HFJSPK45PeiMHJ5tMbQSZc+1twbXVq1n478syekZkbmgT8u5
ppb/b5GXm3o8+r5HUezZdEblWZFO0I7LL9lwtPpgk8iQdqJZ+20QX+GlyBQkqT5z
8MZdIAUZJmHYcIRb5FOedJFCYuDyxWM5cbfBYQyYGRLd/TWIIrzAQDcDDkc8wQ3o
KZt1OVj1gEUKJy0mtlhE+s9mhGRLf/snxlnV8UXSvZKip5fcX5uJO853cEhkEw3T
/OPgFiA7MbpkIFAqRdm8TMvVoAi/t7pYqwlEdz//mgN14/TGnN61CUBCWdgomJXY
NMatLPXU1gL/+Kn/5TMy
=TsjL
-----END PGP SIGNATURE-----

--2DJuma0xDHN2clgl--
