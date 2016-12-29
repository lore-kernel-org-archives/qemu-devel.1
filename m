Received: from eggs.gnu.org ([2001:4830:134:3::10]:57891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1cMVIF-0004lV-Qn
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 02:38:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1cMVIC-0006em-LG
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 02:38:31 -0500
Received: from mga09.intel.com ([134.134.136.24]:35552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1cMVIC-0006dx-AN
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 02:38:28 -0500
From: "Liu, Yi L" <yi.l.liu@intel.com>
Date: Thu, 29 Dec 2016 07:38:20 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257438FEF883@shsmsx102.ccr.corp.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC PATCH 11/13] intel_iommu: provide its own
 replay() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "', Peter Xu'" <peterx@redhat.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>, "'bd.aviv@gmail.com'" <bd.aviv@gmail.com>

> The default replay() don't work for VT-d since vt-d will have a huge
> default memory region which covers address range 0-(2^64-1). This will
> normally bring a dead loop when guest starts.
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
> Signed-off-by: Peter Xu <address@hidden>
> ---
>  hw/i386/intel_iommu.c | 212 ++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  hw/i386/trace-events  |   8 ++
>  include/exec/memory.h |   2 +
>  3 files changed, 217 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 46b8a2f..2fcd7af 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -620,6 +620,22 @@ static inline uint32_t=20
> vtd_get_agaw_from_context_entry(VTDContextEntry *ce)
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
> @@ -656,13 +672,9 @@ static int vtd_iova_to_slpte(VTDContextEntry *ce, ui=
nt64_t=20
> iova,
>      uint32_t level =3D vtd_get_level_from_context_entry(ce);
>      uint32_t offset;
>      uint64_t slpte;
> -    uint32_t ce_agaw =3D vtd_get_agaw_from_context_entry(ce);
>      uint64_t access_right_check =3D 0;
> =20
> -    /* Check if @iova is above 2^X-1, where X is the minimum of MGAW
> -     * in CAP_REG and AW in context-entry.
> -     */
> -    if (iova & ~((1ULL << MIN(ce_agaw, VTD_MGAW)) - 1)) {
> +    if (!vtd_iova_range_check(iova, ce)) {
>          error_report("IOVA 0x%"PRIx64 " exceeds limits", iova);
>          return -VTD_FR_ADDR_BEYOND_MGAW;
>      }
> @@ -718,6 +730,166 @@ static int vtd_iova_to_slpte(VTDContextEntry *ce,=20
> uint64_t iova,
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
> + * @skipped: accumulated skipped ranges
> + * @notify_unmap: whether we should notify invalid entries
> + */
> +static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
> +                               uint64_t end, vtd_page_walk_hook hook_fn,
> +                               void *private, uint32_t level,
> +                               bool read, bool write, uint64_t *skipped,
> +                               bool notify_unmap)
> +{
> +    bool read_cur, write_cur, entry_valid;
> +    uint32_t offset;
> +    uint64_t slpte;
> +    uint64_t subpage_size, subpage_mask;
> +    IOMMUTLBEntry entry;
> +    uint64_t iova =3D start;
> +    uint64_t iova_next;
> +    uint64_t skipped_local =3D 0;
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
> +        /*
> +         * When one of the following case happens, we assume the whole
> +         * range is invalid:
> +         *
> +         * 1. read block failed
> +         * 3. reserved area non-zero
> +         * 2. both read & write flag are not set
> +         */
> +
> +        if (slpte =3D=3D (uint64_t)-1) {
> +            trace_vtd_page_walk_skip_read(iova, iova_next);
> +            skipped_local++;
> +            goto next;
> +        }
> +
> +        if (vtd_slpte_nonzero_rsvd(slpte, level)) {
> +            trace_vtd_page_walk_skip_reserve(iova, iova_next);
> +            skipped_local++;
> +            goto next;
> +        }
> +
> +        /* Permissions are stacked with parents' */
> +        read_cur =3D read && (slpte & VTD_SL_R);
> +        write_cur =3D write && (slpte & VTD_SL_W);
> +
> +        /*
> +         * As long as we have either read/write permission, this is
> +         * a valid entry. The rule works for both page or page tables.
> +         */
> +        entry_valid =3D read_cur | write_cur;
> +
> +        if (vtd_is_last_slpte(slpte, level)) {
> +            entry.target_as =3D &address_space_memory;
> +            entry.iova =3D iova & subpage_mask;
> +            /*
> +             * This might be meaningless addr if (!read_cur &&
> +             * !write_cur), but after all this field will be
> +             * meaningless in that case, so let's share the code to
> +             * generate the IOTLBs no matter it's an MAP or UNMAP
> +             */
> +            entry.translated_addr =3D vtd_get_slpte_addr(slpte);
> +            entry.addr_mask =3D ~subpage_mask;
> +            entry.perm =3D IOMMU_ACCESS_FLAG(read_cur, write_cur);
> +            if (!entry_valid && !notify_unmap) {
> +                trace_vtd_page_walk_skip_perm(iova, iova_next);
> +                skipped_local++;
> +                goto next;
> +            }
> +            trace_vtd_page_walk_one(level, entry.iova, addr,
> +                                    entry.addr_mask, entry.perm);
> +            if (hook_fn) {
> +                ret =3D hook_fn(&entry, private);
> +                if (ret < 0) {
> +                    error_report("Detected error in page walk hook "
> +                                 "function, stop walk.");
> +                    return ret;
> +                }
> +            }
> +        } else {
> +            if (!entry_valid) {
> +                trace_vtd_page_walk_skip_perm(iova, iova_next);
> +                skipped_local++;
> +                goto next;
> +            }
> +            ret =3D vtd_page_walk_level(vtd_get_slpte_addr(slpte), iova,
> +                                      MIN(iova_next, end), hook_fn, priv=
ate,
> +                                      level - 1, read_cur, write_cur,
> +                                      &skipped_local, notify_unmap);
> +            if (ret < 0) {
> +                error_report("Detected page walk error on addr 0x%"PRIx6=
4
> +                             " level %"PRIu32", stop walk.", addr, level=
 - 1);
> +                return ret;
> +            }
> +        }
> +
> +next:
> +        iova =3D iova_next;
> +    }
> +
> +    if (skipped) {
> +        *skipped +=3D skipped_local;
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
> + * @end: size of the IOVA range to walk over
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
> +        error_report("IOVA start 0x%"PRIx64 " end 0x%"PRIx64" exceeds li=
mits",
> +                     start, end);
> +        return -VTD_FR_ADDR_BEYOND_MGAW;
> +    }
> +
> +    if (!vtd_iova_range_check(end, ce)) {
> +        /* Fix end so that it reaches the maximum */
> +        end =3D vtd_iova_limit(ce);
> +    }
> +
> +    trace_vtd_page_walk(ce->hi, ce->lo, start, end);
> +
> +    return vtd_page_walk_level(addr, start, end, hook_fn, private,
> +                               level, true, true, NULL, false);
> +}
> +
>  /* Map a device to its corresponding domain (context-entry) */
>  static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
>                                      uint8_t devfn, VTDContextEntry *ce)
> @@ -2430,6 +2602,35 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *=
s,=20
> PCIBus *bus, int devfn)
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
> +    VTDAddressSpace *vtd_as =3D container_of(mr, VTDAddressSpace, iommu)=
;
> +    IntelIOMMUState *s =3D vtd_as->iommu_state;
> +    uint8_t bus_n =3D pci_bus_num(vtd_as->bus);
> +    VTDContextEntry ce;
> +
> +    if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) =3D=3D 0)=
 {

Hi Peter,

Again I'd like to give my cheers on this patch set.

Hereby, I have a minor concern on this part.
The replay would be performed in vfio_listener_region_add() when device is
assigned. Since guest is just started, so there will be no valid context en=
try for the
assigned device. So there will be no vtd_page_walk. Thus no change to SL pa=
ge
table in host. The SL page table would still be a IOVA->HPA mapping. It's t=
rue
that the gIOVA->HPA mapping can be built by page map/unmap when guest
trying to issue dma. So it is just ok without relpay in the beginning. Hot =
plug should
be all the same. I guess it is the design here?

However, it may be incompatible with a future work in which we expose an
vIOMMU to guest but guest disable IOVA usage. In this scenario, the SL page
table in host would be a GPA->HPA instead of a gIOVA->HPA mapping. It would
rely on memory_replay to build a GPA->HPA mapping. If I'm correct, I think =
it
would be expected to have a replay in the time device is assigned.

Regards,
Yi L
