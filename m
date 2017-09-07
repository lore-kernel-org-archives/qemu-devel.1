Received: from eggs.gnu.org ([2001:4830:134:3::10]:40827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dq58e-0006bk-MB
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:19:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dq58Y-0007lk-4y
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:19:08 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:33774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dq58X-0007kx-Po
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:19:02 -0400
Received: by mail-pf0-x242.google.com with SMTP id h4so491936pfk.0
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 15:19:01 -0700 (PDT)
References: <20170907092010.3605-1-aik@ozlabs.ru>
	<20170907092010.3605-4-aik@ozlabs.ru>
	<7aa3f6a4-b4d7-5b04-1bb4-2c766b8de355@amsat.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <477c18d4-bdfb-2b44-ea52-059a17b0190b@ozlabs.ru>
Date: Fri, 8 Sep 2017 08:18:53 +1000
MIME-Version: 1.0
In-Reply-To: <7aa3f6a4-b4d7-5b04-1bb4-2c766b8de355@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH qemu 3/4] memory: Share flat views and
 dispatch trees between address spaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

On 08/09/17 06:53, Philippe Mathieu-Daudé wrote:
> On 09/07/2017 06:20 AM, Alexey Kardashevskiy wrote:
>> This allows sharing flat views between address spaces when the same root
>> memory region is used when creating a new address space.
>>
>> This adds a global list of flat views and a list of attached address
>> spaces per a flat view. Each address space references a flat view.
>>
>> This hard codes the dispatch tree building instead of doing so via
>> a memory listener.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>
>> This was suggested by Paolo in
>> https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg05011.html
>>
>> I am not putting "Suggested-by" as I want to make sure that this is doing
>> what was actually suggested.
>> ---
>>   include/exec/memory-internal.h |   6 +-
>>   include/exec/memory.h          |   9 +-
>>   exec.c                         |  58 ++--------
>>   hw/pci/pci.c                   |   3 +-
>>   memory.c                       | 253
>> +++++++++++++++++++++++++++--------------
>>   5 files changed, 187 insertions(+), 142 deletions(-)
>>
>> diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
>> index fb467acdba..8516e0b48f 100644
>> --- a/include/exec/memory-internal.h
>> +++ b/include/exec/memory-internal.h
>> @@ -22,9 +22,11 @@
>>   #ifndef CONFIG_USER_ONLY
>>   typedef struct AddressSpaceDispatch AddressSpaceDispatch;
>>   -void address_space_init_dispatch(AddressSpace *as);
>>   void address_space_unregister(AddressSpace *as);
>> -void address_space_destroy_dispatch(AddressSpace *as);
>> +void address_space_dispatch_free(AddressSpaceDispatch *d);
>> +AddressSpaceDispatch *mem_begin(void);
>> +void mem_commit(AddressSpaceDispatch *d);
>> +void mem_add(AddressSpaceDispatch *d, MemoryRegionSection *section);
>>     extern const MemoryRegionOps unassigned_mem_ops;
>>   diff --git a/include/exec/memory.h b/include/exec/memory.h
>> index 83e82e90d5..41ab165302 100644
>> --- a/include/exec/memory.h
>> +++ b/include/exec/memory.h
>> @@ -27,6 +27,7 @@
>>   #include "qemu/rcu.h"
>>   #include "hw/qdev-core.h"
>>   +typedef struct AddressSpaceDispatch AddressSpaceDispatch;
>>   #define RAM_ADDR_INVALID (~(ram_addr_t)0)
>>     #define MAX_PHYS_ADDR_SPACE_BITS 62
>> @@ -312,6 +313,7 @@ struct MemoryListener {
>>   };
>>     AddressSpaceDispatch *address_space_to_dispatch(AddressSpace *as);
>> +MemoryRegion *address_space_root(AddressSpace *as);
>>     /**
>>    * AddressSpace: describes a mapping of addresses to #MemoryRegion objects
>> @@ -320,20 +322,17 @@ struct AddressSpace {
>>       /* All fields are private. */
>>       struct rcu_head rcu;
>>       char *name;
>> -    MemoryRegion *root;
>> -    int ref_count;
>> -    bool malloced;
>>         /* Accessed via RCU.  */
>>       struct FlatView *current_map;
>>         int ioeventfd_nb;
>>       struct MemoryRegionIoeventfd *ioeventfds;
>> -    struct AddressSpaceDispatch *dispatch;
>> -    struct AddressSpaceDispatch *next_dispatch;
>> +
>>       MemoryListener dispatch_listener;
>>       QTAILQ_HEAD(memory_listeners_as, MemoryListener) listeners;
>>       QTAILQ_ENTRY(AddressSpace) address_spaces_link;
>> +    QTAILQ_ENTRY(AddressSpace) flat_view_link;
>>   };
>>     /**
>> diff --git a/exec.c b/exec.c
>> index 66f01f5fce..51243f57f4 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -188,15 +188,12 @@ typedef struct PhysPageMap {
>>   } PhysPageMap;
>>     struct AddressSpaceDispatch {
>> -    struct rcu_head rcu;
>> -
>>       MemoryRegionSection *mru_section;
>>       /* This is a multi-level map on the physical address space.
>>        * The bottom level has pointers to MemoryRegionSections.
>>        */
>>       PhysPageEntry phys_map;
>>       PhysPageMap map;
>> -    AddressSpace *as;
>>   };
>>     typedef struct AddressSpaceDispatch AddressSpaceDispatch;
>> @@ -240,11 +237,6 @@ struct DirtyBitmapSnapshot {
>>       unsigned long dirty[];
>>   };
>>   -AddressSpaceDispatch *address_space_to_dispatch(AddressSpace *as)
>> -{
>> -    return atomic_rcu_read(&as->dispatch);
>> -}
>> -
>>   #endif
>>     #if !defined(CONFIG_USER_ONLY)
>> @@ -1354,10 +1346,8 @@ static void
>> register_multipage(AddressSpaceDispatch *d,
>>       phys_page_set(d, start_addr >> TARGET_PAGE_BITS, num_pages,
>> section_index);
>>   }
>>   -static void mem_add(MemoryListener *listener, MemoryRegionSection
>> *section)
>> +void mem_add(AddressSpaceDispatch *d, MemoryRegionSection *section)
>>   {
>> -    AddressSpace *as = container_of(listener, AddressSpace,
>> dispatch_listener);
>> -    AddressSpaceDispatch *d = as->next_dispatch;
>>       MemoryRegionSection now = *section, remain = *section;
>>       Int128 page_size = int128_make64(TARGET_PAGE_SIZE);
>>   @@ -2680,9 +2670,8 @@ static void io_mem_init(void)
>>                             NULL, UINT64_MAX);
>>   }
>>   -static void mem_begin(MemoryListener *listener)
>> +AddressSpaceDispatch *mem_begin(void)
>>   {
>> -    AddressSpace *as = container_of(listener, AddressSpace,
>> dispatch_listener);
>>       AddressSpaceDispatch *d = g_new0(AddressSpaceDispatch, 1);
>>       uint16_t n;
>>   @@ -2696,27 +2685,19 @@ static void mem_begin(MemoryListener *listener)
>>       assert(n == PHYS_SECTION_WATCH);
>>         d->phys_map  = (PhysPageEntry) { .ptr = PHYS_MAP_NODE_NIL, .skip
>> = 1 };
>> -    as->next_dispatch = d;
>> +
>> +    return d;
>>   }
>>   -static void address_space_dispatch_free(AddressSpaceDispatch *d)
>> +void address_space_dispatch_free(AddressSpaceDispatch *d)
>>   {
>>       phys_sections_free(&d->map);
>>       g_free(d);
>>   }
>>   -static void mem_commit(MemoryListener *listener)
>> +void mem_commit(AddressSpaceDispatch *d)
>>   {
>> -    AddressSpace *as = container_of(listener, AddressSpace,
>> dispatch_listener);
>> -    AddressSpaceDispatch *cur = as->dispatch;
>> -    AddressSpaceDispatch *next = as->next_dispatch;
>> -
>> -    phys_page_compact_all(next, next->map.nodes_nb);
>> -
>> -    atomic_rcu_set(&as->dispatch, next);
>> -    if (cur) {
>> -        call_rcu(cur, address_space_dispatch_free, rcu);
>> -    }
>> +    phys_page_compact_all(d, d->map.nodes_nb);
>>   }
>>     static void tcg_commit(MemoryListener *listener)
>> @@ -2732,39 +2713,16 @@ static void tcg_commit(MemoryListener *listener)
>>        * We reload the dispatch pointer now because
>> cpu_reloading_memory_map()
>>        * may have split the RCU critical section.
>>        */
>> -    d = atomic_rcu_read(&cpuas->as->dispatch);
>> +    d = address_space_to_dispatch(cpuas->as);
>>       atomic_rcu_set(&cpuas->memory_dispatch, d);
>>       tlb_flush(cpuas->cpu);
>>   }
>>   -void address_space_init_dispatch(AddressSpace *as)
>> -{
>> -    as->dispatch = NULL;
>> -    as->dispatch_listener = (MemoryListener) {
>> -        .begin = mem_begin,
>> -        .commit = mem_commit,
>> -        .region_add = mem_add,
>> -        .region_nop = mem_add,
>> -        .priority = 0,
>> -    };
>> -    memory_listener_register(&as->dispatch_listener, as);
>> -}
>> -
>>   void address_space_unregister(AddressSpace *as)
>>   {
>>       memory_listener_unregister(&as->dispatch_listener);
>>   }
>>   -void address_space_destroy_dispatch(AddressSpace *as)
>> -{
>> -    AddressSpaceDispatch *d = as->dispatch;
>> -
>> -    atomic_rcu_set(&as->dispatch, NULL);
>> -    if (d) {
>> -        call_rcu(d, address_space_dispatch_free, rcu);
>> -    }
>> -}
>> -
>>   static void memory_map_init(void)
>>   {
>>       system_memory = g_malloc(sizeof(*system_memory));
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index 258fbe51e2..86b9e419fd 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -88,7 +88,8 @@ static void pci_init_bus_master(PCIDevice *pci_dev)
>>         memory_region_init_alias(&pci_dev->bus_master_enable_region,
>>                                OBJECT(pci_dev), "bus master",
>> -                             dma_as->root, 0,
>> memory_region_size(dma_as->root));
>> +                             address_space_root(dma_as), 0,
>> +                            
>> memory_region_size(address_space_root(dma_as)));
>>       memory_region_set_enabled(&pci_dev->bus_master_enable_region, false);
>>       memory_region_add_subregion(&pci_dev->bus_master_container_region, 0,
>>                                   &pci_dev->bus_master_enable_region);
>> diff --git a/memory.c b/memory.c
>> index c6904a7deb..385a507511 100644
>> --- a/memory.c
>> +++ b/memory.c
>> @@ -47,6 +47,9 @@ static QTAILQ_HEAD(memory_listeners, MemoryListener)
>> memory_listeners
>>   static QTAILQ_HEAD(, AddressSpace) address_spaces
>>       = QTAILQ_HEAD_INITIALIZER(address_spaces);
>>   +static QTAILQ_HEAD(FlatViewList, FlatView) flat_views
>> +    = QTAILQ_HEAD_INITIALIZER(flat_views);
>> +
>>   typedef struct AddrRange AddrRange;
>>     /*
>> @@ -230,6 +233,11 @@ struct FlatView {
>>       FlatRange *ranges;
>>       unsigned nr;
>>       unsigned nr_allocated;
>> +    MemoryRegion *root;
>> +    struct AddressSpaceDispatch *dispatch;
>> +
>> +    QTAILQ_ENTRY(FlatView) flat_views_link;
>> +    QTAILQ_HEAD(address_spaces, AddressSpace) address_spaces;
>>   };
>>     typedef struct AddressSpaceOps AddressSpaceOps;
>> @@ -259,12 +267,19 @@ static bool flatrange_equal(FlatRange *a, FlatRange
>> *b)
>>           && a->readonly == b->readonly;
>>   }
>>   -static void flatview_init(FlatView *view)
>> +static void flatview_ref(FlatView *view);
>> +
>> +static FlatView *flatview_alloc(MemoryRegion *mr_root)
>>   {
>> +    FlatView *view;
>> +
>> +    view = g_new0(FlatView, 1);
>>       view->ref = 1;
>> -    view->ranges = NULL;
>> -    view->nr = 0;
>> -    view->nr_allocated = 0;
>> +    view->root = mr_root;
>> +    memory_region_ref(mr_root);
>> +    QTAILQ_INIT(&view->address_spaces);
>> +
>> +    return view;
>>   }
>>     /* Insert a range into a given position.  Caller is responsible for
>> maintaining
>> @@ -292,6 +307,10 @@ static void flatview_destroy(FlatView *view)
>>           memory_region_unref(view->ranges[i].mr);
>>       }
>>       g_free(view->ranges);
>> +    if (view->dispatch) {
>> +        address_space_dispatch_free(view->dispatch);
>> +    }
>> +    memory_region_unref(view->root);
>>       g_free(view);
>>   }
>>   @@ -303,7 +322,7 @@ static void flatview_ref(FlatView *view)
>>   static void flatview_unref(FlatView *view)
>>   {
>>       if (atomic_fetch_dec(&view->ref) == 1) {
>> -        flatview_destroy(view);
>> +        call_rcu(view, flatview_destroy, rcu);
>>       }
>>   }
>>   @@ -608,7 +627,7 @@ static AddressSpace
>> *memory_region_to_address_space(MemoryRegion *mr)
>>           mr = mr->container;
>>       }
>>       QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
>> -        if (mr == as->root) {
>> +        if (mr == as->current_map->root) {
>>               return as;
>>           }
>>       }
>> @@ -702,23 +721,6 @@ static void render_memory_region(FlatView *view,
>>       }
>>   }
>>   -/* Render a memory topology into a list of disjoint absolute ranges. */
>> -static FlatView *generate_memory_topology(MemoryRegion *mr)
>> -{
>> -    FlatView *view;
>> -
>> -    view = g_new(FlatView, 1);
>> -    flatview_init(view);
>> -
>> -    if (mr) {
>> -        render_memory_region(view, mr, int128_zero(),
>> -                             addrrange_make(int128_zero(),
>> int128_2_64()), false);
>> -    }
>> -    flatview_simplify(view);
>> -
>> -    return view;
>> -}
>> -
>>   static void address_space_add_del_ioeventfds(AddressSpace *as,
>>                                                MemoryRegionIoeventfd
>> *fds_new,
>>                                                unsigned fds_new_nb,
>> @@ -769,12 +771,10 @@ static void
>> address_space_add_del_ioeventfds(AddressSpace *as,
>>       }
>>   }
>>   -static FlatView *address_space_get_flatview(AddressSpace *as)
>> +static FlatView *flatview_get(FlatView *view)
>>   {
>> -    FlatView *view;
>> -
>>       rcu_read_lock();
>> -    view = atomic_rcu_read(&as->current_map);
>> +    view = atomic_rcu_read(&view);
>>       flatview_ref(view);
>>       rcu_read_unlock();
>>       return view;
>> @@ -789,7 +789,7 @@ static void
>> address_space_update_ioeventfds(AddressSpace *as)
>>       AddrRange tmp;
>>       unsigned i;
>>   -    view = address_space_get_flatview(as);
>> +    view = flatview_get(as->current_map);
>>       FOR_EACH_FLAT_RANGE(fr, view) {
>>           for (i = 0; i < fr->mr->ioeventfd_nb; ++i) {
>>               tmp = addrrange_shift(fr->mr->ioeventfds[i].addr,
>> @@ -881,28 +881,89 @@ static void
>> address_space_update_topology_pass(AddressSpace *as,
>>       }
>>   }
>>   -
>> -static void address_space_update_topology(AddressSpace *as)
>> +static FlatView *address_space_update_flatview(FlatView *view)
>>   {
>> -    FlatView *old_view = address_space_get_flatview(as);
>> -    FlatView *new_view = generate_memory_topology(as->root);
>> +    AddressSpace *as, *asnext;
>> +    FlatView *old_view = flatview_get(view);
>> +    MemoryRegion *root = old_view->root;
>> +    FlatView *new_view = flatview_alloc(root);
>> +    unsigned iold, inew;
>> +    FlatRange *frold, *frnew;
>>   -    address_space_update_topology_pass(as, old_view, new_view, false);
>> -    address_space_update_topology_pass(as, old_view, new_view, true);
>> +    if (root) {
>> +        render_memory_region(new_view, root, int128_zero(),
>> +                             addrrange_make(int128_zero(), int128_2_64()),
>> +                             false);
>> +        flatview_simplify(new_view);
>> +    }
>>   -    /* Writes are protected by the BQL.  */
>> -    atomic_rcu_set(&as->current_map, new_view);
>> -    call_rcu(old_view, flatview_unref, rcu);
>> +    new_view->dispatch = mem_begin();
>>   -    /* Note that all the old MemoryRegions are still alive up to this
>> -     * point.  This relieves most MemoryListeners from the need to
>> -     * ref/unref the MemoryRegions they get---unless they use them
>> -     * outside the iothread mutex, in which case precise reference
>> -     * counting is necessary.
>> +    /*
>> +     * FIXME: this is cut-n-paste from address_space_update_topology_pass,
>> +     * simplify it
>>        */
>> +    iold = inew = 0;
>> +    while (iold < old_view->nr || inew < new_view->nr) {
>> +        if (iold < old_view->nr) {
>> +            frold = &old_view->ranges[iold];
>> +        } else {
>> +            frold = NULL;
>> +        }
>> +        if (inew < new_view->nr) {
>> +            frnew = &new_view->ranges[inew];
>> +        } else {
>> +            frnew = NULL;
>> +        }
>> +
>> +        if (frold
>> +            && (!frnew
>> +                || int128_lt(frold->addr.start, frnew->addr.start)
>> +                || (int128_eq(frold->addr.start, frnew->addr.start)
>> +                    && !flatrange_equal(frold, frnew)))) {
>> +            ++iold;
>> +        } else if (frold && frnew && flatrange_equal(frold, frnew)) {
>> +            /* In both and unchanged (except logging may have changed) */
>> +            MemoryRegionSection mrs = section_from_flat_range(frnew,
>> +                    new_view->dispatch);
>> +
>> +            mem_add(new_view->dispatch, &mrs);
>> +
>> +            ++iold;
>> +            ++inew;
>> +        } else {
>> +            /* In new */
>> +            MemoryRegionSection mrs = section_from_flat_range(frnew,
>> +                    new_view->dispatch);
>> +
>> +            mem_add(new_view->dispatch, &mrs);
>> +
>> +            ++inew;
>> +        }
>> +    }
>> +
>> +    mem_commit(new_view->dispatch);
>> +
>> +    QTAILQ_FOREACH(as, &old_view->address_spaces, flat_view_link) {
>> +        address_space_update_topology_pass(as, old_view, new_view, false);
>> +        address_space_update_topology_pass(as, old_view, new_view, true);
>> +    }
>> +
>> +    QTAILQ_FOREACH_SAFE(as, &old_view->address_spaces, flat_view_link,
>> asnext) {
>> +        QTAILQ_REMOVE(&old_view->address_spaces, as, flat_view_link);
>> +        flatview_unref(old_view);
>> +
>> +        atomic_rcu_set(&as->current_map, new_view);
>> +
>> +        flatview_ref(new_view);
>> +        QTAILQ_INSERT_TAIL(&new_view->address_spaces, as, flat_view_link);
>> +
>> +        address_space_update_ioeventfds(as);
>> +    }
>> +
>>       flatview_unref(old_view);
>>   -    address_space_update_ioeventfds(as);
>> +    return new_view;
>>   }
>>     void memory_region_transaction_begin(void)
>> @@ -921,11 +982,31 @@ void memory_region_transaction_commit(void)
>>       --memory_region_transaction_depth;
>>       if (!memory_region_transaction_depth) {
>>           if (memory_region_update_pending) {
>> +            FlatView *view, *vnext;
>> +            struct FlatViewList fwstmp = QTAILQ_HEAD_INITIALIZER(fwstmp);
>> +
>>               MEMORY_LISTENER_CALL_GLOBAL(begin, Forward);
>>   -            QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
>> -                address_space_update_topology(as);
>> +            QTAILQ_FOREACH_SAFE(view, &flat_views, flat_views_link,
>> vnext) {
>> +                FlatView *old_view, *new_view;
>> +
>> +                old_view = flatview_get(view);
>> +                new_view = address_space_update_flatview(old_view);
>> +
>> +                QTAILQ_REMOVE(&flat_views, old_view, flat_views_link);
>> +                flatview_unref(old_view);
>> +                flatview_unref(old_view);
>> +
>> +                QTAILQ_INSERT_HEAD(&fwstmp, new_view, flat_views_link);
>> +
>> +                flatview_unref(new_view);
>>               }
>> +
>> +            QTAILQ_FOREACH_SAFE(view, &fwstmp, flat_views_link, vnext) {
>> +                QTAILQ_REMOVE(&fwstmp, view, flat_views_link);
>> +                QTAILQ_INSERT_HEAD(&flat_views, view, flat_views_link);
>> +            }
>> +
>>               memory_region_update_pending = false;
>>               MEMORY_LISTENER_CALL_GLOBAL(commit, Forward);
>>           } else if (ioeventfd_update_pending) {
>> @@ -1834,7 +1915,7 @@ void memory_region_sync_dirty_bitmap(MemoryRegion *mr)
>>               continue;
>>           }
>>           as = listener->address_space;
>> -        view = address_space_get_flatview(as);
>> +        view = flatview_get(as->current_map);
>>           FOR_EACH_FLAT_RANGE(fr, view) {
>>               if (fr->mr == mr) {
>>                   MemoryRegionSection mrs = section_from_flat_range(fr,
>> @@ -1938,7 +2019,7 @@ static void
>> memory_region_update_coalesced_range_as(MemoryRegion *mr, AddressSpa
>>       AddrRange tmp;
>>       MemoryRegionSection section;
>>   -    view = address_space_get_flatview(as);
>> +    view = flatview_get(as->current_map);
>>       FOR_EACH_FLAT_RANGE(fr, view) {
>>           if (fr->mr == mr) {
>>               section = (MemoryRegionSection) {
>> @@ -2350,7 +2431,7 @@ void memory_global_dirty_log_sync(void)
>>               continue;
>>           }
>>           as = listener->address_space;
>> -        view = address_space_get_flatview(as);
>> +        view = flatview_get(as->current_map);
>>           FOR_EACH_FLAT_RANGE(fr, view) {
>>               if (fr->dirty_log_mask) {
>>                   MemoryRegionSection mrs = section_from_flat_range(fr,
>> @@ -2436,7 +2517,7 @@ static void
>> listener_add_address_space(MemoryListener *listener,
>>           }
>>       }
>>   -    view = address_space_get_flatview(as);
>> +    view = flatview_get(as->current_map);
>>       FOR_EACH_FLAT_RANGE(fr, view) {
>>           MemoryRegionSection section = {
>>               .mr = fr->mr,
>> @@ -2615,67 +2696,72 @@ void
>> memory_region_invalidate_mmio_ptr(MemoryRegion *mr, hwaddr offset,
>>     void address_space_init(AddressSpace *as, MemoryRegion *root, const
>> char *name)
>>   {
>> -    memory_region_ref(root);
>> -    memory_region_transaction_begin();
>> -    as->ref_count = 1;
>> -    as->root = root;
>> -    as->malloced = false;
>> -    as->current_map = g_new(FlatView, 1);
>> -    flatview_init(as->current_map);
>> +    FlatView *view;
>> +
>> +    as->current_map = NULL;
>>       as->ioeventfd_nb = 0;
>>       as->ioeventfds = NULL;
>>       QTAILQ_INIT(&as->listeners);
>>       QTAILQ_INSERT_TAIL(&address_spaces, as, address_spaces_link);
>>       as->name = g_strdup(name ? name : "anonymous");
>> -    address_space_init_dispatch(as);
>> -    memory_region_update_pending |= root->enabled;
>> -    memory_region_transaction_commit();
>> +
>> +    QTAILQ_FOREACH(view, &flat_views, flat_views_link) {
>> +        assert(root);
>> +        if (view->root == root) {
>> +            as->current_map = flatview_get(view);
>> +            break;
>> +        }
>> +    }
>> +
>> +    if (!as->current_map) {
>> +        as->current_map = flatview_alloc(root);
>> +
>> +        QTAILQ_INSERT_TAIL(&flat_views, as->current_map, flat_views_link);
>> +    }
>> +
>> +    QTAILQ_INSERT_TAIL(&as->current_map->address_spaces, as,
>> flat_view_link);
>> +}
>> +
>> +MemoryRegion *address_space_root(AddressSpace *as)
>> +{
>> +    return as->current_map->root;
>> +}
>> +
>> +AddressSpaceDispatch *address_space_to_dispatch(AddressSpace *as)
>> +{
>> +    return atomic_rcu_read(&as->current_map)->dispatch;
>>   }
>>     static void do_address_space_destroy(AddressSpace *as)
>>   {
>> -    bool do_free = as->malloced;
>> +    FlatView *view = flatview_get(as->current_map);
>>   -    address_space_destroy_dispatch(as);
>>       assert(QTAILQ_EMPTY(&as->listeners));
>>   -    flatview_unref(as->current_map);
>> +    QTAILQ_REMOVE(&view->address_spaces, as, flat_view_link);
>> +    flatview_unref(view);
>> +
>> +    flatview_unref(view);


This one removes a reference after unlinking an address space from the
flatview.

> 
> incorrect copy/paste?

Nope, this one pairs flatview_get() from few lines above.


-- 
Alexey
