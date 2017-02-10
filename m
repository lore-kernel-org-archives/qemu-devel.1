Received: from eggs.gnu.org ([2001:4830:134:3::10]:39497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cc17r-0000jD-8R
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:39:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cc17k-0007dR-9c
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:39:50 -0500
Received: from ozlabs.org ([103.22.144.67]:34245)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1cc17j-0007cV-Je
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:39:48 -0500
Date: Fri, 10 Feb 2017 13:36:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170210023646.GE27610@umbus.fritz.box>
References: <1486456099-7345-1-git-send-email-peterx@redhat.com>
	<1486456099-7345-16-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NJ3lxSTgSwfmyg6j"
Content-Disposition: inline
In-Reply-To: <1486456099-7345-16-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 15/17] intel_iommu: provide its own
 replay() callback
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


--NJ3lxSTgSwfmyg6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 04:28:17PM +0800, Peter Xu wrote:
> The default replay() don't work for VT-d since vt-d will have a huge
> default memory region which covers address range 0-(2^64-1). This will
> normally consumes a lot of time (which looks like a dead loop).
>=20
> The solution is simple - we don't walk over all the regions. Instead, we
> jump over the regions when we found that the page directories are empty.
> It'll greatly reduce the time to walk the whole region.
>=20
> To achieve this, we provided a page walk helper to do that, invoking
> corresponding hook function when we found an page we are interested in.
> vtd_page_walk_level() is the core logic for the page walking. It's
> interface is designed to suite further use case, e.g., to invalidate a
> range of addresses.
>=20
> Reviewed-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

For small values of reviewed:

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

The concept is sensible and there's nothing obviously wrong.  But, I'm
not familiar enough with the VT-d page table format to check the code
in detail.

> ---
>  hw/i386/intel_iommu.c | 182 ++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  hw/i386/trace-events  |   7 ++
>  include/exec/memory.h |   2 +
>  3 files changed, 186 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 22d8226..f8d5713 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -595,6 +595,22 @@ static inline uint32_t vtd_get_agaw_from_context_ent=
ry(VTDContextEntry *ce)
>      return 30 + (ce->hi & VTD_CONTEXT_ENTRY_AW) * 9;
>  }
> =20
> +static inline uint64_t vtd_iova_limit(VTDContextEntry *ce)
> +{
> +    uint32_t ce_agaw =3D vtd_get_agaw_from_context_entry(ce);
> +    return 1ULL << MIN(ce_agaw, VTD_MGAW);
> +}
> +
> +/* Return true if IOVA passes range check, otherwise false. */
> +static inline bool vtd_iova_range_check(uint64_t iova, VTDContextEntry *=
ce)
> +{
> +    /*
> +     * Check if @iova is above 2^X-1, where X is the minimum of MGAW
> +     * in CAP_REG and AW in context-entry.
> +     */
> +    return !(iova & ~(vtd_iova_limit(ce) - 1));
> +}
> +
>  static const uint64_t vtd_paging_entry_rsvd_field[] =3D {
>      [0] =3D ~0ULL,
>      /* For not large page */
> @@ -630,13 +646,9 @@ static int vtd_iova_to_slpte(VTDContextEntry *ce, ui=
nt64_t iova, bool is_write,
>      uint32_t level =3D vtd_get_level_from_context_entry(ce);
>      uint32_t offset;
>      uint64_t slpte;
> -    uint32_t ce_agaw =3D vtd_get_agaw_from_context_entry(ce);
>      uint64_t access_right_check;
> =20
> -    /* Check if @iova is above 2^X-1, where X is the minimum of MGAW
> -     * in CAP_REG and AW in context-entry.
> -     */
> -    if (iova & ~((1ULL << MIN(ce_agaw, VTD_MGAW)) - 1)) {
> +    if (!vtd_iova_range_check(iova, ce)) {
>          VTD_DPRINTF(GENERAL, "error: iova 0x%"PRIx64 " exceeds limits", =
iova);
>          return -VTD_FR_ADDR_BEYOND_MGAW;
>      }
> @@ -684,6 +696,134 @@ static int vtd_iova_to_slpte(VTDContextEntry *ce, u=
int64_t iova, bool is_write,
>      }
>  }
> =20
> +typedef int (*vtd_page_walk_hook)(IOMMUTLBEntry *entry, void *private);
> +
> +/**
> + * vtd_page_walk_level - walk over specific level for IOVA range
> + *
> + * @addr: base GPA addr to start the walk
> + * @start: IOVA range start address
> + * @end: IOVA range end address (start <=3D addr < end)
> + * @hook_fn: hook func to be called when detected page
> + * @private: private data to be passed into hook func
> + * @read: whether parent level has read permission
> + * @write: whether parent level has write permission
> + * @notify_unmap: whether we should notify invalid entries
> + */
> +static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
> +                               uint64_t end, vtd_page_walk_hook hook_fn,
> +                               void *private, uint32_t level,
> +                               bool read, bool write, bool notify_unmap)
> +{
> +    bool read_cur, write_cur, entry_valid;
> +    uint32_t offset;
> +    uint64_t slpte;
> +    uint64_t subpage_size, subpage_mask;
> +    IOMMUTLBEntry entry;
> +    uint64_t iova =3D start;
> +    uint64_t iova_next;
> +    int ret =3D 0;
> +
> +    trace_vtd_page_walk_level(addr, level, start, end);
> +
> +    subpage_size =3D 1ULL << vtd_slpt_level_shift(level);
> +    subpage_mask =3D vtd_slpt_level_page_mask(level);
> +
> +    while (iova < end) {
> +        iova_next =3D (iova & subpage_mask) + subpage_size;
> +
> +        offset =3D vtd_iova_level_offset(iova, level);
> +        slpte =3D vtd_get_slpte(addr, offset);
> +
> +        if (slpte =3D=3D (uint64_t)-1) {
> +            trace_vtd_page_walk_skip_read(iova, iova_next);
> +            goto next;
> +        }
> +
> +        if (vtd_slpte_nonzero_rsvd(slpte, level)) {
> +            trace_vtd_page_walk_skip_reserve(iova, iova_next);
> +            goto next;
> +        }
> +
> +        /* Permissions are stacked with parents' */
> +        read_cur =3D read && (slpte & VTD_SL_R);
> +        write_cur =3D write && (slpte & VTD_SL_W);
> +
> +        /*
> +         * As long as we have either read/write permission, this is a
> +         * valid entry. The rule works for both page entries and page
> +         * table entries.
> +         */
> +        entry_valid =3D read_cur | write_cur;
> +
> +        if (vtd_is_last_slpte(slpte, level)) {
> +            entry.target_as =3D &address_space_memory;
> +            entry.iova =3D iova & subpage_mask;
> +            /* NOTE: this is only meaningful if entry_valid =3D=3D true =
*/
> +            entry.translated_addr =3D vtd_get_slpte_addr(slpte);
> +            entry.addr_mask =3D ~subpage_mask;
> +            entry.perm =3D IOMMU_ACCESS_FLAG(read_cur, write_cur);
> +            if (!entry_valid && !notify_unmap) {
> +                trace_vtd_page_walk_skip_perm(iova, iova_next);
> +                goto next;
> +            }
> +            trace_vtd_page_walk_one(level, entry.iova, entry.translated_=
addr,
> +                                    entry.addr_mask, entry.perm);
> +            if (hook_fn) {
> +                ret =3D hook_fn(&entry, private);
> +                if (ret < 0) {
> +                    return ret;
> +                }
> +            }
> +        } else {
> +            if (!entry_valid) {
> +                trace_vtd_page_walk_skip_perm(iova, iova_next);
> +                goto next;
> +            }
> +            ret =3D vtd_page_walk_level(vtd_get_slpte_addr(slpte), iova,
> +                                      MIN(iova_next, end), hook_fn, priv=
ate,
> +                                      level - 1, read_cur, write_cur,
> +                                      notify_unmap);
> +            if (ret < 0) {
> +                return ret;
> +            }
> +        }
> +
> +next:
> +        iova =3D iova_next;
> +    }
> +
> +    return 0;
> +}
> +
> +/**
> + * vtd_page_walk - walk specific IOVA range, and call the hook
> + *
> + * @ce: context entry to walk upon
> + * @start: IOVA address to start the walk
> + * @end: IOVA range end address (start <=3D addr < end)
> + * @hook_fn: the hook that to be called for each detected area
> + * @private: private data for the hook function
> + */
> +static int vtd_page_walk(VTDContextEntry *ce, uint64_t start, uint64_t e=
nd,
> +                         vtd_page_walk_hook hook_fn, void *private)
> +{
> +    dma_addr_t addr =3D vtd_get_slpt_base_from_context(ce);
> +    uint32_t level =3D vtd_get_level_from_context_entry(ce);
> +
> +    if (!vtd_iova_range_check(start, ce)) {
> +        return -VTD_FR_ADDR_BEYOND_MGAW;
> +    }
> +
> +    if (!vtd_iova_range_check(end, ce)) {
> +        /* Fix end so that it reaches the maximum */
> +        end =3D vtd_iova_limit(ce);
> +    }
> +
> +    return vtd_page_walk_level(addr, start, end, hook_fn, private,
> +                               level, true, true, false);
> +}
> +
>  /* Map a device to its corresponding domain (context-entry) */
>  static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
>                                      uint8_t devfn, VTDContextEntry *ce)
> @@ -2402,6 +2542,37 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *=
s, PCIBus *bus, int devfn)
>      return vtd_dev_as;
>  }
> =20
> +static int vtd_replay_hook(IOMMUTLBEntry *entry, void *private)
> +{
> +    memory_region_notify_one((IOMMUNotifier *)private, entry);
> +    return 0;
> +}
> +
> +static void vtd_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n)
> +{
> +    VTDAddressSpace *vtd_as =3D container_of(mr, VTDAddressSpace, iommu);
> +    IntelIOMMUState *s =3D vtd_as->iommu_state;
> +    uint8_t bus_n =3D pci_bus_num(vtd_as->bus);
> +    VTDContextEntry ce;
> +
> +    if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) =3D=3D 0)=
 {
> +        /*
> +         * Scanned a valid context entry, walk over the pages and
> +         * notify when needed.
> +         */
> +        trace_vtd_replay_ce_valid(bus_n, PCI_SLOT(vtd_as->devfn),
> +                                  PCI_FUNC(vtd_as->devfn),
> +                                  VTD_CONTEXT_ENTRY_DID(ce.hi),
> +                                  ce.hi, ce.lo);
> +        vtd_page_walk(&ce, 0, ~0ULL, vtd_replay_hook, (void *)n);
> +    } else {
> +        trace_vtd_replay_ce_invalid(bus_n, PCI_SLOT(vtd_as->devfn),
> +                                    PCI_FUNC(vtd_as->devfn));
> +    }
> +
> +    return;
> +}
> +
>  /* Do the initialization. It will also be called when reset, so pay
>   * attention when adding new initialization stuff.
>   */
> @@ -2416,6 +2587,7 @@ static void vtd_init(IntelIOMMUState *s)
> =20
>      s->iommu_ops.translate =3D vtd_iommu_translate;
>      s->iommu_ops.notify_flag_changed =3D vtd_iommu_notify_flag_changed;
> +    s->iommu_ops.replay =3D vtd_iommu_replay;
>      s->root =3D 0;
>      s->root_extended =3D false;
>      s->dmar_enabled =3D false;
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index 88ad5e4..463db0d 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -30,6 +30,13 @@ vtd_iotlb_cc_hit(uint8_t bus, uint8_t devfn, uint64_t =
high, uint64_t low, uint32
>  vtd_iotlb_cc_update(uint8_t bus, uint8_t devfn, uint64_t high, uint64_t =
low, uint32_t gen1, uint32_t gen2) "IOTLB context update bus 0x%"PRIx8" dev=
fn 0x%"PRIx8" high 0x%"PRIx64" low 0x%"PRIx64" gen %"PRIu32" -> gen %"PRIu32
>  vtd_iotlb_reset(const char *reason) "IOTLB reset (reason: %s)"
>  vtd_fault_disabled(void) "Fault processing disabled for context entry"
> +vtd_replay_ce_valid(uint8_t bus, uint8_t dev, uint8_t fn, uint16_t domai=
n, uint64_t hi, uint64_t lo) "replay valid context device %02"PRIx8":%02"PR=
Ix8".%02"PRIx8" domain 0x%"PRIx16" hi 0x%"PRIx64" lo 0x%"PRIx64
> +vtd_replay_ce_invalid(uint8_t bus, uint8_t dev, uint8_t fn) "replay inva=
lid context device %02"PRIx8":%02"PRIx8".%02"PRIx8
> +vtd_page_walk_level(uint64_t addr, uint32_t level, uint64_t start, uint6=
4_t end) "walk (base=3D0x%"PRIx64", level=3D%"PRIu32") iova range 0x%"PRIx6=
4" - 0x%"PRIx64
> +vtd_page_walk_one(uint32_t level, uint64_t iova, uint64_t gpa, uint64_t =
mask, int perm) "detected page level 0x%"PRIx32" iova 0x%"PRIx64" -> gpa 0x=
%"PRIx64" mask 0x%"PRIx64" perm %d"
> +vtd_page_walk_skip_read(uint64_t iova, uint64_t next) "Page walk skip io=
va 0x%"PRIx64" - 0x%"PRIx64" due to unable to read"
> +vtd_page_walk_skip_perm(uint64_t iova, uint64_t next) "Page walk skip io=
va 0x%"PRIx64" - 0x%"PRIx64" due to perm empty"
> +vtd_page_walk_skip_reserve(uint64_t iova, uint64_t next) "Page walk skip=
 iova 0x%"PRIx64" - 0x%"PRIx64" due to rsrv set"
> =20
>  # hw/i386/amd_iommu.c
>  amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write a=
t addr 0x%"PRIx64" +  offset 0x%"PRIx32
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 30b2a74..267f399 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -55,6 +55,8 @@ typedef enum {
>      IOMMU_RW   =3D 3,
>  } IOMMUAccessFlags;
> =20
> +#define IOMMU_ACCESS_FLAG(r, w) (((r) ? IOMMU_RO : 0) | ((w) ? IOMMU_WO =
: 0))
> +
>  struct IOMMUTLBEntry {
>      AddressSpace    *target_as;
>      hwaddr           iova;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NJ3lxSTgSwfmyg6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYnSc+AAoJEGw4ysog2bOSlyAQAN8XBm1Xwt7eELrlWvfIY9mL
mYpsZbsUTrs1tOctLikNvlrwnplIu7CiDgQ/meLgG5F89Cvu8WEZFYi4djA++KMK
CUl90TZGm4bdWI9Qvp4znodX8mJW34npRLGzH7nC/wWhX/HjkKIxutD/2PV8nIa0
er9WT0FdvCxzDQAbyk9ooDzZT/o0kFnKlLcmFEBXd7wPdbp5ZlPbr3DQw2mlGGmp
P6GDP78khiQa0Njus8W5F5HGqUkh7mNJPcSqeMGf7dI2xdhqMc8npsvLGi9S9jdC
bHHSC0GVgiQpaTuOwv5SdbSh9KwZo3xNK4fWVklVCkv2tjyCthfYhQk37wADAFL9
KEeIcv6O6T/HthfwGVLcf3NngB2mAqkd4hnEkiSFo3KnoVllS1XLNivbyoUFY9YD
E2dsZ2EdVng60Qr7FScAIh510pFxudUM+bUs27/5JZDvuYvkGZBLJUypCsuvoTQP
kXZHY7JHUnOr+RqpyiNjho6Q3gr7sYme/0IL2BneOf7orxuVtcLsJMnvgk66zB0o
C4nFncdKjWF5ddZESFR7W+ydMdmV6Gq8ITumNUyRvqqBCa3nXEpdGrVESQQpDzUJ
zMllC+ukRgxaSC2SslEFvdwrUbNZQ1GMg+w9lnmAHwLHZ3tRfgiSCUXjU3jSOx+5
sOQucxcYESfxBbhneI9b
=jdod
-----END PGP SIGNATURE-----

--NJ3lxSTgSwfmyg6j--
