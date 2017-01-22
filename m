Received: from eggs.gnu.org ([2001:4830:134:3::10]:43418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cVD0g-0000Mb-On
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 02:56:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cVD0d-0006un-ME
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 02:56:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cVD0d-0006uj-DB
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 02:56:19 -0500
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
	<1484917736-32056-16-git-send-email-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f2cceaa6-b3cf-9ed1-2c9c-f9222a0ab7ce@redhat.com>
Date: Sun, 22 Jan 2017 15:56:10 +0800
MIME-Version: 1.0
In-Reply-To: <1484917736-32056-16-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v4 15/20] intel_iommu: provide its own
 replay() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, alex.williamson@redhat.com, bd.aviv@gmail.com



On 2017=E5=B9=B401=E6=9C=8820=E6=97=A5 21:08, Peter Xu wrote:
> The default replay() don't work for VT-d since vt-d will have a huge
> default memory region which covers address range 0-(2^64-1). This will
> normally consumes a lot of time (which looks like a dead loop).
>
> The solution is simple - we don't walk over all the regions. Instead, w=
e
> jump over the regions when we found that the page directories are empty=
.
> It'll greatly reduce the time to walk the whole region.
>
> To achieve this, we provided a page walk helper to do that, invoking
> corresponding hook function when we found an page we are interested in.
> vtd_page_walk_level() is the core logic for the page walking. It's
> interface is designed to suite further use case, e.g., to invalidate a
> range of addresses.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/i386/intel_iommu.c | 216 +++++++++++++++++++++++++++++++++++++++++=
+++++++--
>   hw/i386/trace-events  |   7 ++
>   include/exec/memory.h |   2 +
>   3 files changed, 220 insertions(+), 5 deletions(-)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 6f5f68a..f9c5142 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -598,6 +598,22 @@ static inline uint32_t vtd_get_agaw_from_context_e=
ntry(VTDContextEntry *ce)
>       return 30 + (ce->hi & VTD_CONTEXT_ENTRY_AW) * 9;
>   }
>  =20
> +static inline uint64_t vtd_iova_limit(VTDContextEntry *ce)
> +{
> +    uint32_t ce_agaw =3D vtd_get_agaw_from_context_entry(ce);
> +    return 1ULL << MIN(ce_agaw, VTD_MGAW);
> +}
> +
> +/* Return true if IOVA passes range check, otherwise false. */
> +static inline bool vtd_iova_range_check(uint64_t iova, VTDContextEntry=
 *ce)
> +{
> +    /*
> +     * Check if @iova is above 2^X-1, where X is the minimum of MGAW
> +     * in CAP_REG and AW in context-entry.
> +     */
> +    return !(iova & ~(vtd_iova_limit(ce) - 1));
> +}
> +
>   static const uint64_t vtd_paging_entry_rsvd_field[] =3D {
>       [0] =3D ~0ULL,
>       /* For not large page */
> @@ -633,13 +649,9 @@ static int vtd_gpa_to_slpte(VTDContextEntry *ce, u=
int64_t iova, bool is_write,
>       uint32_t level =3D vtd_get_level_from_context_entry(ce);
>       uint32_t offset;
>       uint64_t slpte;
> -    uint32_t ce_agaw =3D vtd_get_agaw_from_context_entry(ce);
>       uint64_t access_right_check;
>  =20
> -    /* Check if @iova is above 2^X-1, where X is the minimum of MGAW
> -     * in CAP_REG and AW in context-entry.
> -     */
> -    if (iova & ~((1ULL << MIN(ce_agaw, VTD_MGAW)) - 1)) {
> +    if (!vtd_iova_range_check(iova, ce)) {
>           trace_vtd_err("IOVA exceeds limits");
>           return -VTD_FR_ADDR_BEYOND_MGAW;
>       }
> @@ -681,6 +693,168 @@ static int vtd_gpa_to_slpte(VTDContextEntry *ce, =
uint64_t iova, bool is_write,
>       }
>   }
>  =20
> +typedef int (*vtd_page_walk_hook)(IOMMUTLBEntry *entry, void *private)=
;
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

What's the usage for this parameter? Looks like it was never used in=20
this series.

> + * @notify_unmap: whether we should notify invalid entries
> + */
> +static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
> +                               uint64_t end, vtd_page_walk_hook hook_f=
n,
> +                               void *private, uint32_t level,
> +                               bool read, bool write, uint64_t *skippe=
d,
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

Don't get the meaning (and don't see any code relate to this comment).

> +         * 3. reserved area non-zero
> +         * 2. both read & write flag are not set

Should be 1,2,3? And the above comment is conflict with the code at=20
least when notify_unmap is true.

> +         */
> +
> +        if (slpte =3D=3D (uint64_t)-1) {

If this is true, vtd_slpte_nonzero_rsvd(slpte) should be true too I think=
?

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

Under which case should we care about unmap here (better with a comment=20
I think)?

> +            trace_vtd_page_walk_one(level, entry.iova, entry.translate=
d_addr,
> +                                    entry.addr_mask, entry.perm);
> +            if (hook_fn) {
> +                ret =3D hook_fn(&entry, private);

For better performance, we could try to merge adjacent mappings here. I=20
think both vfio and vhost support this and it can save a lot of ioctls.

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
> +            trace_vtd_page_walk_level(vtd_get_slpte_addr(slpte), level=
 - 1,
> +                                      iova, MIN(iova_next, end));

This looks duplicated?

> +            ret =3D vtd_page_walk_level(vtd_get_slpte_addr(slpte), iov=
a,
> +                                      MIN(iova_next, end), hook_fn, pr=
ivate,
> +                                      level - 1, read_cur, write_cur,
> +                                      &skipped_local, notify_unmap);
> +            if (ret < 0) {
> +                error_report("Detected page walk error on addr 0x%"PRI=
x64
> +                             " level %"PRIu32", stop walk.", addr, lev=
el - 1);

Guest triggered, so better use debug macro or tracepoint.

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
> + * @end: IOVA range end address (start <=3D addr < end)
> + * @hook_fn: the hook that to be called for each detected area
> + * @private: private data for the hook function
> + */
> +static int vtd_page_walk(VTDContextEntry *ce, uint64_t start, uint64_t=
 end,
> +                         vtd_page_walk_hook hook_fn, void *private)
> +{
> +    dma_addr_t addr =3D vtd_get_slpt_base_from_context(ce);
> +    uint32_t level =3D vtd_get_level_from_context_entry(ce);
> +
> +    if (!vtd_iova_range_check(start, ce)) {
> +        error_report("IOVA start 0x%"PRIx64 " end 0x%"PRIx64" exceeds =
limits",
> +                     start, end);

Guest triggered, better use debug macro or tracepoint.

> +        return -VTD_FR_ADDR_BEYOND_MGAW;
> +    }
> +
> +    if (!vtd_iova_range_check(end, ce)) {
> +        /* Fix end so that it reaches the maximum */
> +        end =3D vtd_iova_limit(ce);
> +    }
> +
> +    trace_vtd_page_walk_level(addr, level, start, end);

Duplicated with the tracepoint in vtd_page_walk_level() too?

> +
> +    return vtd_page_walk_level(addr, start, end, hook_fn, private,
> +                               level, true, true, NULL, false);
> +}
> +
>   /* Map a device to its corresponding domain (context-entry) */
>   static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_n=
um,
>                                       uint8_t devfn, VTDContextEntry *c=
e)
> @@ -2395,6 +2569,37 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState=
 *s, PCIBus *bus, int devfn)
>       return vtd_dev_as;
>   }
>  =20
> +static int vtd_replay_hook(IOMMUTLBEntry *entry, void *private)
> +{
> +    memory_region_notify_one((IOMMUNotifier *)private, entry);
> +    return 0;
> +}
> +
> +static void vtd_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n)
> +{
> +    VTDAddressSpace *vtd_as =3D container_of(mr, VTDAddressSpace, iomm=
u);
> +    IntelIOMMUState *s =3D vtd_as->iommu_state;
> +    uint8_t bus_n =3D pci_bus_num(vtd_as->bus);
> +    VTDContextEntry ce;
> +
> +    if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) =3D=3D =
0) {
> +        /*
> +         * Scanned a valid context entry, walk over the pages and
> +         * notify when needed.
> +         */
> +        trace_vtd_replay_ce_valid(bus_n, PCI_SLOT(vtd_as->devfn),
> +                                  PCI_FUNC(vtd_as->devfn),
> +                                  VTD_CONTEXT_ENTRY_DID(ce.hi),
> +                                  ce.hi, ce.lo);
> +        vtd_page_walk(&ce, 0, ~0, vtd_replay_hook, (void *)n);

~0ULL?

> +    } else {
> +        trace_vtd_replay_ce_invalid(bus_n, PCI_SLOT(vtd_as->devfn),
> +                                    PCI_FUNC(vtd_as->devfn));
> +    }
> +
> +    return;
> +}
> +
>   /* Do the initialization. It will also be called when reset, so pay
>    * attention when adding new initialization stuff.
>    */
> @@ -2409,6 +2614,7 @@ static void vtd_init(IntelIOMMUState *s)
>  =20
>       s->iommu_ops.translate =3D vtd_iommu_translate;
>       s->iommu_ops.notify_flag_changed =3D vtd_iommu_notify_flag_change=
d;
> +    s->iommu_ops.replay =3D vtd_iommu_replay;
>       s->root =3D 0;
>       s->root_extended =3D false;
>       s->dmar_enabled =3D false;
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index a273980..a3e1a9d 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -31,6 +31,13 @@ vtd_iotlb_page_update(uint16_t sid, uint64_t addr, u=
int64_t slpte, uint16_t doma
>   vtd_iotlb_cc_hit(uint8_t bus, uint8_t devfn, uint64_t high, uint64_t =
low, uint32_t gen) "IOTLB context hit bus 0x%"PRIx8" devfn 0x%"PRIx8" hig=
h 0x%"PRIx64" low 0x%"PRIx64" gen %"PRIu32
>   vtd_iotlb_cc_update(uint8_t bus, uint8_t devfn, uint64_t high, uint64=
_t low, uint32_t gen1, uint32_t gen2) "IOTLB context update bus 0x%"PRIx8=
" devfn 0x%"PRIx8" high 0x%"PRIx64" low 0x%"PRIx64" gen %"PRIu32" -> gen =
%"PRIu32
>   vtd_iotlb_reset(const char *reason) "IOTLB reset (reason: %s)"
> +vtd_replay_ce_valid(uint8_t bus, uint8_t dev, uint8_t fn, uint16_t dom=
ain, uint64_t hi, uint64_t lo) "replay valid context device %02"PRIx8":%0=
2"PRIx8".%02"PRIx8" domain 0x%"PRIx16" hi 0x%"PRIx64" lo 0x%"PRIx64
> +vtd_replay_ce_invalid(uint8_t bus, uint8_t dev, uint8_t fn) "replay in=
valid context device %02"PRIx8":%02"PRIx8".%02"PRIx8
> +vtd_page_walk_level(uint64_t addr, uint32_t level, uint64_t start, uin=
t64_t end) "walk (base=3D0x%"PRIx64", level=3D%"PRIu32") iova range 0x%"P=
RIx64" - 0x%"PRIx64
> +vtd_page_walk_one(uint32_t level, uint64_t iova, uint64_t gpa, uint64_=
t mask, int perm) "detected page level 0x%"PRIx32" iova 0x%"PRIx64" -> gp=
a 0x%"PRIx64" mask 0x%"PRIx64" perm %d"
> +vtd_page_walk_skip_read(uint64_t iova, uint64_t next) "Page walk skip =
iova 0x%"PRIx64" - 0x%"PRIx64" due to unable to read"
> +vtd_page_walk_skip_perm(uint64_t iova, uint64_t next) "Page walk skip =
iova 0x%"PRIx64" - 0x%"PRIx64" due to perm empty"
> +vtd_page_walk_skip_reserve(uint64_t iova, uint64_t next) "Page walk sk=
ip iova 0x%"PRIx64" - 0x%"PRIx64" due to rsrv set"
>  =20
>   # hw/i386/amd_iommu.c
>   amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to writ=
e at addr 0x%"PRIx64" +  offset 0x%"PRIx32
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index bb4e654..9fd3232 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -59,6 +59,8 @@ typedef enum {
>       IOMMU_RW   =3D 3,
>   } IOMMUAccessFlags;
>  =20
> +#define IOMMU_ACCESS_FLAG(r, w) (((r) ? IOMMU_RO : 0) | ((w) ? IOMMU_W=
O : 0))
> +
>   struct IOMMUTLBEntry {
>       AddressSpace    *target_as;
>       hwaddr           iova;
