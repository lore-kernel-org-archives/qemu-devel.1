Received: from eggs.gnu.org ([2001:4830:134:3::10]:41749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cVTki-0000PW-9A
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 20:49:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cVTkf-0006d6-3s
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 20:49:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cVTke-0006cq-Ra
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 20:48:57 -0500
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
	<1484917736-32056-16-git-send-email-peterx@redhat.com>
	<f2cceaa6-b3cf-9ed1-2c9c-f9222a0ab7ce@redhat.com>
	<20170122085118.GA26526@pxdev.xzpeter.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c7265d9c-54e9-f4a2-003d-85c4416c1651@redhat.com>
Date: Mon, 23 Jan 2017 09:48:48 +0800
MIME-Version: 1.0
In-Reply-To: <20170122085118.GA26526@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Peter Xu <peterx@redhat.com>
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, bd.aviv@gmail.com, qemu-devel@nongnu.org, alex.williamson@redhat.com



On 2017=E5=B9=B401=E6=9C=8822=E6=97=A5 16:51, Peter Xu wrote:
> On Sun, Jan 22, 2017 at 03:56:10PM +0800, Jason Wang wrote:
>
> [...]
>
>>> +/**
>>> + * vtd_page_walk_level - walk over specific level for IOVA range
>>> + *
>>> + * @addr: base GPA addr to start the walk
>>> + * @start: IOVA range start address
>>> + * @end: IOVA range end address (start <=3D addr < end)
>>> + * @hook_fn: hook func to be called when detected page
>>> + * @private: private data to be passed into hook func
>>> + * @read: whether parent level has read permission
>>> + * @write: whether parent level has write permission
>>> + * @skipped: accumulated skipped ranges
>> What's the usage for this parameter? Looks like it was never used in t=
his
>> series.
> This was for debugging purpose before, and I kept it in case one day
> it can be used again, considering that will not affect much on the
> overall performance.

I think we usually do not keep debugging codes outside debug macros.

>
>>> + * @notify_unmap: whether we should notify invalid entries
>>> + */
>>> +static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
>>> +                               uint64_t end, vtd_page_walk_hook hook=
_fn,
>>> +                               void *private, uint32_t level,
>>> +                               bool read, bool write, uint64_t *skip=
ped,
>>> +                               bool notify_unmap)
>>> +{
>>> +    bool read_cur, write_cur, entry_valid;
>>> +    uint32_t offset;
>>> +    uint64_t slpte;
>>> +    uint64_t subpage_size, subpage_mask;
>>> +    IOMMUTLBEntry entry;
>>> +    uint64_t iova =3D start;
>>> +    uint64_t iova_next;
>>> +    uint64_t skipped_local =3D 0;
>>> +    int ret =3D 0;
>>> +
>>> +    trace_vtd_page_walk_level(addr, level, start, end);
>>> +
>>> +    subpage_size =3D 1ULL << vtd_slpt_level_shift(level);
>>> +    subpage_mask =3D vtd_slpt_level_page_mask(level);
>>> +
>>> +    while (iova < end) {
>>> +        iova_next =3D (iova & subpage_mask) + subpage_size;
>>> +
>>> +        offset =3D vtd_iova_level_offset(iova, level);
>>> +        slpte =3D vtd_get_slpte(addr, offset);
>>> +
>>> +        /*
>>> +         * When one of the following case happens, we assume the who=
le
>>> +         * range is invalid:
>>> +         *
>>> +         * 1. read block failed
>> Don't get the meaning (and don't see any code relate to this comment).
> I took above vtd_get_slpte() a "read", so I was trying to mean that we
> failed to read the SLPTE due to some reason, we assume the range is
> invalid.

I see, so we'd better move the comment above of vtd_get_slpte().

>
>>> +         * 3. reserved area non-zero
>>> +         * 2. both read & write flag are not set
>> Should be 1,2,3? And the above comment is conflict with the code at le=
ast
>> when notify_unmap is true.
> Yes, okay I don't know why 3 jumped. :(
>
> And yes, I should mention that "both read & write flag not set" only
> suites for page tables here.
>
>>> +         */
>>> +
>>> +        if (slpte =3D=3D (uint64_t)-1) {
>> If this is true, vtd_slpte_nonzero_rsvd(slpte) should be true too I th=
ink?
> Yes, but we are doing two checks here:
>
> - checking against -1 to make sure slpte read success
> - checking against nonzero reserved fields to make sure it follows spec
>
> Imho we should not skip the first check here, only if one day removing
> this may really matter (e.g., for performance reason? I cannot think
> of one yet).

Ok. (return -1 seems not good, but we can address this in the future).

>
>>> +            trace_vtd_page_walk_skip_read(iova, iova_next);
>>> +            skipped_local++;
>>> +            goto next;
>>> +        }
>>> +
>>> +        if (vtd_slpte_nonzero_rsvd(slpte, level)) {
>>> +            trace_vtd_page_walk_skip_reserve(iova, iova_next);
>>> +            skipped_local++;
>>> +            goto next;
>>> +        }
>>> +
>>> +        /* Permissions are stacked with parents' */
>>> +        read_cur =3D read && (slpte & VTD_SL_R);
>>> +        write_cur =3D write && (slpte & VTD_SL_W);
>>> +
>>> +        /*
>>> +         * As long as we have either read/write permission, this is
>>> +         * a valid entry. The rule works for both page or page table=
s.
>>> +         */
>>> +        entry_valid =3D read_cur | write_cur;
>>> +
>>> +        if (vtd_is_last_slpte(slpte, level)) {
>>> +            entry.target_as =3D &address_space_memory;
>>> +            entry.iova =3D iova & subpage_mask;
>>> +            /*
>>> +             * This might be meaningless addr if (!read_cur &&
>>> +             * !write_cur), but after all this field will be
>>> +             * meaningless in that case, so let's share the code to
>>> +             * generate the IOTLBs no matter it's an MAP or UNMAP
>>> +             */
>>> +            entry.translated_addr =3D vtd_get_slpte_addr(slpte);
>>> +            entry.addr_mask =3D ~subpage_mask;
>>> +            entry.perm =3D IOMMU_ACCESS_FLAG(read_cur, write_cur);
>>> +            if (!entry_valid && !notify_unmap) {
>>> +                trace_vtd_page_walk_skip_perm(iova, iova_next);
>>> +                skipped_local++;
>>> +                goto next;
>>> +            }
>> Under which case should we care about unmap here (better with a commen=
t I
>> think)?
> When PSIs are for invalidation, rather than newly mapped entries. In
> that case, notify_unmap will be true, and here we need to notify
> IOMMU_NONE to do the cache flush or unmap.
>
> (this page walk is not only for replaying, it is for cache flushing as
>   well)
>
> Do you have suggestion on the comments?

I think then we'd better move this to patch 18 which will use notify_unma=
p.

>
>>> +            trace_vtd_page_walk_one(level, entry.iova, entry.transla=
ted_addr,
>>> +                                    entry.addr_mask, entry.perm);
>>> +            if (hook_fn) {
>>> +                ret =3D hook_fn(&entry, private);
>> For better performance, we could try to merge adjacent mappings here. =
I
>> think both vfio and vhost support this and it can save a lot of ioctls=
.
> Looks so, and this is in my todo list.
>
> Do you mind I do it later after this series merged? I would really
> appreciate if we can have this codes settled down first (considering
> that this series has been dangling for half a year, or more, startint
> from Aviv's series), and I am just afraid this will led to
> unconvergence of this series (and I believe there are other places
> that can be enhanced in the future as well).

Yes, let's do it on top.

>
>>> +                if (ret < 0) {
>>> +                    error_report("Detected error in page walk hook "
>>> +                                 "function, stop walk.");
>>> +                    return ret;
>>> +                }
>>> +            }
>>> +        } else {
>>> +            if (!entry_valid) {
>>> +                trace_vtd_page_walk_skip_perm(iova, iova_next);
>>> +                skipped_local++;
>>> +                goto next;
>>> +            }
>>> +            trace_vtd_page_walk_level(vtd_get_slpte_addr(slpte), lev=
el - 1,
>>> +                                      iova, MIN(iova_next, end));
>> This looks duplicated?
> I suppose not. The level is different.

Seem not? level - 1 was passed to vtd_page_walk_level() as level which di=
d:

trace_vtd_page_walk_level(addr, level, start, end);


>
>>> +            ret =3D vtd_page_walk_level(vtd_get_slpte_addr(slpte), i=
ova,
>>> +                                      MIN(iova_next, end), hook_fn, =
private,
>>> +                                      level - 1, read_cur, write_cur=
,
>>> +                                      &skipped_local, notify_unmap);
>>> +            if (ret < 0) {
>>> +                error_report("Detected page walk error on addr 0x%"P=
RIx64
>>> +                             " level %"PRIu32", stop walk.", addr, l=
evel - 1);
>> Guest triggered, so better use debug macro or tracepoint.
> Sorry. Will replace all the error_report() in the whole series.
>
>>> +                return ret;
>>> +            }
>>> +        }
>>> +
>>> +next:
>>> +        iova =3D iova_next;
>>> +    }
>>> +
>>> +    if (skipped) {
>>> +        *skipped +=3D skipped_local;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +/**
>>> + * vtd_page_walk - walk specific IOVA range, and call the hook
>>> + *
>>> + * @ce: context entry to walk upon
>>> + * @start: IOVA address to start the walk
>>> + * @end: IOVA range end address (start <=3D addr < end)
>>> + * @hook_fn: the hook that to be called for each detected area
>>> + * @private: private data for the hook function
>>> + */
>>> +static int vtd_page_walk(VTDContextEntry *ce, uint64_t start, uint64=
_t end,
>>> +                         vtd_page_walk_hook hook_fn, void *private)
>>> +{
>>> +    dma_addr_t addr =3D vtd_get_slpt_base_from_context(ce);
>>> +    uint32_t level =3D vtd_get_level_from_context_entry(ce);
>>> +
>>> +    if (!vtd_iova_range_check(start, ce)) {
>>> +        error_report("IOVA start 0x%"PRIx64 " end 0x%"PRIx64" exceed=
s limits",
>>> +                     start, end);
>> Guest triggered, better use debug macro or tracepoint.
> Same.
>
>>> +        return -VTD_FR_ADDR_BEYOND_MGAW;
>>> +    }
>>> +
>>> +    if (!vtd_iova_range_check(end, ce)) {
>>> +        /* Fix end so that it reaches the maximum */
>>> +        end =3D vtd_iova_limit(ce);
>>> +    }
>>> +
>>> +    trace_vtd_page_walk_level(addr, level, start, end);
>> Duplicated with the tracepoint in vtd_page_walk_level() too?
> Nop? This should be the top level.
>
>>> +
>>> +    return vtd_page_walk_level(addr, start, end, hook_fn, private,
>>> +                               level, true, true, NULL, false);
>>> +}
>>> +
>>>   /* Map a device to its corresponding domain (context-entry) */
>>>   static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus=
_num,
>>>                                       uint8_t devfn, VTDContextEntry =
*ce)
>>> @@ -2395,6 +2569,37 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUSta=
te *s, PCIBus *bus, int devfn)
>>>       return vtd_dev_as;
>>>   }
>>> +static int vtd_replay_hook(IOMMUTLBEntry *entry, void *private)
>>> +{
>>> +    memory_region_notify_one((IOMMUNotifier *)private, entry);
>>> +    return 0;
>>> +}
>>> +
>>> +static void vtd_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n)
>>> +{
>>> +    VTDAddressSpace *vtd_as =3D container_of(mr, VTDAddressSpace, io=
mmu);
>>> +    IntelIOMMUState *s =3D vtd_as->iommu_state;
>>> +    uint8_t bus_n =3D pci_bus_num(vtd_as->bus);
>>> +    VTDContextEntry ce;
>>> +
>>> +    if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) =3D=3D=
 0) {
>>> +        /*
>>> +         * Scanned a valid context entry, walk over the pages and
>>> +         * notify when needed.
>>> +         */
>>> +        trace_vtd_replay_ce_valid(bus_n, PCI_SLOT(vtd_as->devfn),
>>> +                                  PCI_FUNC(vtd_as->devfn),
>>> +                                  VTD_CONTEXT_ENTRY_DID(ce.hi),
>>> +                                  ce.hi, ce.lo);
>>> +        vtd_page_walk(&ce, 0, ~0, vtd_replay_hook, (void *)n);
>> ~0ULL?
> Fixing up.
>
> Thanks,
>
> -- peterx
>
