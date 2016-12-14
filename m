Received: from eggs.gnu.org ([2001:4830:134:3::10]:53810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cH2Ap-0000kh-8W
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 00:32:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cH2Am-0006Z7-PJ
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 00:32:15 -0500
Message-ID: <1481693457.1555.25.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Wed, 14 Dec 2016 16:30:57 +1100
In-Reply-To: <20161212040603.27295-4-david@gibson.dropbear.id.au>
References: <20161212040603.27295-1-david@gibson.dropbear.id.au>
	<20161212040603.27295-4-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv3 3/5] pseries: Implement HPT resizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, thuth@redhat.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Mon, 2016-12-12 at 15:06 +1100, David Gibson wrote:
> This patch implements hypercalls allowing a PAPR guest to resize its
> own
> hash page table.  This will eventually allow for more flexible memory
> hotplug.
> 
> The implementation is partially asynchronous, handled in a special
> thread
> running the hpt_prepare_thread() function.  The state of a pending
> resize
> is stored in SPAPR_MACHINE->pending_hpt.
> 
> The H_RESIZE_HPT_PREPARE hypercall will kick off creation of a new
> HPT, or,
> if one is already in progress, monitor it for completion.  If there
> is an
> existing HPT resize in progress that doesn't match the size specified
> in
> the call, it will cancel it, replacing it with a new one matching the
> given size.
> 
> The H_RESIZE_HPT_COMMIT completes transition to a resized HPT, and
> can only
> be called successfully once H_RESIZE_HPT_PREPARE has successfully
> completed initialization of a new HPT.  The guest must ensure that
> there
> are no concurrent accesses to the existing HPT while this is called
> (this
> effectively means stop_machine() for Linux guests).
> 
> For now H_RESIZE_HPT_COMMIT goes through the whole old HPT, rehashing
> each
> HPTE into the new HPT.  This can have quite high latency, but it
> seems to
> be of the order of typical migration downtime latencies for HPTs of
> size
> up to ~2GiB (which would be used in a 256GiB guest).
> 
> In future we probably want to move more of the rehashing to the
> "prepare"
> phase, by having H_ENTER and other hcalls update both current and
> pending HPTs.  That's a project for another day, but should be
> possible
> without any changes to the guest interface.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c          |   4 +-
>  hw/ppc/spapr_hcall.c    | 345
> +++++++++++++++++++++++++++++++++++++++++++++++-
>  include/hw/ppc/spapr.h  |   6 +
>  target-ppc/mmu-hash64.h |   4 +
>  4 files changed, 353 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 846ce51..d057031 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -93,8 +93,6 @@
>  
>  #define PHANDLE_XICP            0x00001111
>  
> -#define HTAB_SIZE(spapr)        (1ULL << ((spapr)->htab_shift))
> -
>  static XICSState *try_create_xics(const char *type, int nr_servers,
>                                    int nr_irqs, Error **errp)
>  {
> @@ -1055,7 +1053,7 @@ static void close_htab_fd(sPAPRMachineState
> *spapr)
>      spapr->htab_fd = -1;
>  }
>  
> -static int spapr_hpt_shift_for_ramsize(uint64_t ramsize)
> +int spapr_hpt_shift_for_ramsize(uint64_t ramsize)
>  {
>      int shift;
>  
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 72a9c4d..1e89061 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -2,6 +2,7 @@
>  #include "qapi/error.h"
>  #include "sysemu/sysemu.h"
>  #include "qemu/log.h"
> +#include "qemu/error-report.h"
>  #include "cpu.h"
>  #include "exec/exec-all.h"
>  #include "helper_regs.h"
> @@ -355,20 +356,319 @@ static target_ulong h_read(PowerPCCPU *cpu,
> sPAPRMachineState *spapr,
>      return H_SUCCESS;
>  }
>  
> +struct sPAPRPendingHPT {
> +    /* These fields are read-only after initialization */
> +    int shift;
> +    QemuThread thread;
> +
> +    /* These fields are protected by the BQL */
> +    bool complete;
> +
> +    /* These fields are private to the preparation thread if
> +     * !complete, otherwise protected by the BQL */
> +    int ret;
> +    void *hpt;
> +};
> +
> +static void free_pending_hpt(sPAPRPendingHPT *pending)
> +{
> +    if (pending->hpt) {
> +        qemu_vfree(pending->hpt);
> +    }
> +
> +    g_free(pending);
> +}
> +
> +static void *hpt_prepare_thread(void *opaque)
> +{
> +    sPAPRPendingHPT *pending = opaque;
> +    size_t size = 1ULL << pending->shift;
> +
> +    pending->hpt = qemu_memalign(size, size);
> +    if (pending->hpt) {
> +        memset(pending->hpt, 0, size);
> +        pending->ret = H_SUCCESS;
> +    } else {
> +        pending->ret = H_NO_MEM;
> +    }
> +
> +    qemu_mutex_lock_iothread();
> +
> +    if (SPAPR_MACHINE(qdev_get_machine())->pending_hpt == pending) {
> +        /* Ready to go */
> +        pending->complete = true;
> +    } else {
> +        /* We've been cancelled, clean ourselves up */
> +        free_pending_hpt(pending);
> +    }
> +
> +    qemu_mutex_unlock_iothread();
> +    return NULL;
> +}
> +
> +/* Must be called with BQL held */
> +static void cancel_hpt_prepare(sPAPRMachineState *spapr)
> +{
> +    sPAPRPendingHPT *pending = spapr->pending_hpt;
> +
> +    /* Let the thread know it's cancelled */
> +    spapr->pending_hpt = NULL;
> +
> +    if (!pending) {
> +        /* Nothing to do */
> +        return;
> +    }
> +
> +    if (!pending->complete) {
> +        /* thread will clean itself up */
> +        return;
> +    }
> +
> +    free_pending_hpt(pending);
> +}
> +
> +static int build_dimm_list(Object *obj, void *opaque)
> +{
> +    GSList **list = opaque;
> +
> +    if (object_dynamic_cast(obj, TYPE_PC_DIMM)) {
> +        DeviceState *dev = DEVICE(obj);
> +        if (dev->realized) { /* only realized DIMMs matter */
> +            *list = g_slist_prepend(*list, dev);
> +        }
> +    }
> +
> +    object_child_foreach(obj, build_dimm_list, opaque);
> +    return 0;
> +}
> +
> +static ram_addr_t get_current_ram_size(void)
> +{
> +    GSList *list = NULL, *item;
> +    ram_addr_t size = ram_size;
> +
> +    build_dimm_list(qdev_get_machine(), &list);
> +    for (item = list; item; item = g_slist_next(item)) {
> +        Object *obj = OBJECT(item->data);
> +        if (!strcmp(object_get_typename(obj), TYPE_PC_DIMM)) {
> +            size += object_property_get_int(obj, PC_DIMM_SIZE_PROP,
> +                                            &error_abort);
> +        }
> +    }
> +    g_slist_free(list);
> +
> +    return size;
> +}
> +
>  static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
>                                           sPAPRMachineState *spapr,
>                                           target_ulong opcode,
>                                           target_ulong *args)
>  {
>      target_ulong flags = args[0];
> -    target_ulong shift = args[1];
> +    int shift = args[1];
> +    sPAPRPendingHPT *pending = spapr->pending_hpt;
>  
>      if (spapr->resize_hpt == SPAPR_RESIZE_HPT_DISABLED) {
>          return H_AUTHORITY;
>      }
>  
>      trace_spapr_h_resize_hpt_prepare(flags, shift);
> -    return H_HARDWARE;
> +
> +    if (flags != 0) {
> +        return H_PARAMETER;
> +    }
> +
> +    if (shift && ((shift < 18) || (shift > 46))) {
> +        return H_PARAMETER;
> +    }
> +
> +    if (pending) {
> +        /* something already in progress */
> +        if (pending->shift == shift) {
> +            /* and it's suitable */
> +            if (pending->complete) {
> +                return pending->ret;
> +            } else {
> +                return H_LONG_BUSY_ORDER_100_MSEC;
> +            }
> +        }
> +
> +        /* not suitable, cancel and replace */
> +        cancel_hpt_prepare(spapr);
> +    }
> +
> +    if (!shift) {
> +        /* nothing to do */
> +        return H_SUCCESS;
> +    }
> +
> +    /* start new prepare */
> +
> +    /* We only allow the guest to allocate an HPT one order above
> what
> +     * we'd normally give them (to stop a small guest claiming a
> huge
> +     * chunk of resources in the HPT */
> +    if (shift > (spapr_hpt_shift_for_ramsize(get_current_ram_size())
> + 1)) {
> +        return H_RESOURCE;
> +    }
> +
> +    pending = g_new0(sPAPRPendingHPT, 1);
> +    pending->shift = shift;
> +    pending->ret = H_HARDWARE;
> +
> +    qemu_thread_create(&pending->thread, "sPAPR HPT prepare",
> +                       hpt_prepare_thread, pending,
> QEMU_THREAD_DETACHED);
> +
> +    spapr->pending_hpt = pending;
> +
> +    /* In theory we could estimate the time more accurately based on
> +     * the new size, but there's not much point */
> +    return H_LONG_BUSY_ORDER_100_MSEC;
> +}
> +
> +static uint64_t new_hpte_load0(void *htab, uint64_t pteg, int slot)
> +{
> +    uint8_t *addr = htab;
> +
> +    addr += pteg * HASH_PTEG_SIZE_64;
> +    addr += slot * HASH_PTE_SIZE_64;
> +    return  ldq_p(addr);
> +}
> +
> +static void new_hpte_store(void *htab, uint64_t pteg, int slot,
> +                           uint64_t pte0, uint64_t pte1)
> +{
> +    uint8_t *addr = htab;
> +
> +    addr += pteg * HASH_PTEG_SIZE_64;
> +    addr += slot * HASH_PTE_SIZE_64;
> +
> +    stq_p(addr, pte0);
> +    stq_p(addr + HASH_PTE_SIZE_64/2, pte1);
> +}
> +
> +static int rehash_hpte(PowerPCCPU *cpu, uint64_t token,
> +                       void *old, uint64_t oldsize,
> +                       void *new, uint64_t newsize,
Can we call these old_hpt and new_hpt?
> +                       uint64_t pteg, int slot)
> +{
> +    uint64_t old_hash_mask = (oldsize >> 7) - 1;
> +    uint64_t new_hash_mask = (newsize >> 7) - 1;
> +    target_ulong pte0 = ppc_hash64_load_hpte0(cpu, token, slot);
> +    target_ulong pte1;
> +    uint64_t avpn;
> +    unsigned shift;
Can we call this base_pg_shift or at least add a comment:
/* Base Virtual Page Shift */ or something?
Took me a while to work out what *shift* this actually was...
> +    uint64_t hash, new_pteg, replace_pte0;
> +
*** (referenced below)
> +    if (!(pte0 & HPTE64_V_VALID) || !(pte0 & HPTE64_V_BOLTED)) {
> +        return H_SUCCESS;
> +    }
> +
> +    pte1 = ppc_hash64_load_hpte1(cpu, token, slot);
> +
> +    shift = ppc_hash64_hpte_page_shift_noslb(cpu, pte0, pte1);
> +    assert(shift); /* H_ENTER should never have allowed a bad
> encoding */
> +    avpn = HPTE64_V_AVPN_VAL(pte0) & ~(((1ULL << shift) - 1) >> 23);
> +
> +    if (pte0 & HPTE64_V_SECONDARY) {
> +        pteg = ~pteg;
> +    }
> +
The hash calculation below is pretty hard to follow... That being said
I don't really see a nicer way of structuring it. I guess you just have
to wade through the ISA if you actually want to understand what's
happening here (which I assume most people won't bother with).
> +    if ((pte0 & HPTE64_V_SSIZE) == HPTE64_V_SSIZE_256M) {
> +        uint64_t offset, vsid;
> +
> +        /* We only have 28 - 23 bits of offset in avpn */
> +        offset = (avpn & 0x1f) << 23;
> +        vsid = avpn >> 5;
> +        /* We can find more bits from the pteg value */
> +        if (shift < 23) {
> +            offset |= ((vsid ^ pteg) & old_hash_mask) << shift;
> +        }
> +
> +        hash = vsid ^ (offset >> shift);
> +    } else if ((pte0 & HPTE64_V_SSIZE) == HPTE64_V_SSIZE_1T) {
> +        uint64_t offset, vsid;
> +
> +        /* We only have 40 - 23 bits of seg_off in avpn */
> +        offset = (avpn & 0x1ffff) << 23;
> +        vsid = avpn >> 17;
> +        if (shift < 23) {
> +            offset |= ((vsid ^ (vsid << 25) ^ pteg) & old_hash_mask)
> << shift;
> +        }
> +
> +        hash = vsid ^ (vsid << 25) ^ (offset >> shift);
> +    } else {
> +        error_report("rehash_pte: Bad segment size in HPTE");
> +        return H_HARDWARE;
> +    }
> +
> +    new_pteg = hash & new_hash_mask;
> +    if (pte0 & HPTE64_V_SECONDARY) {
> +        assert(~pteg == (hash & old_hash_mask));
> +        new_pteg = ~new_pteg;
> +    } else {
> +        assert(pteg == (hash & old_hash_mask));
> +    }
> +    assert((oldsize != newsize) || (pteg == new_pteg));
> +    replace_pte0 = new_hpte_load0(new, new_pteg, slot);
> +    if (replace_pte0 & HPTE64_V_VALID) {
> +        assert(newsize < oldsize);
> +        if (replace_pte0 & HPTE64_V_BOLTED) {
Aren't both of these checks for BOLTED redundant? We know that we are
only rehashing ptes which are both valid and bolted, otherwise we would
have returned at *** above. Thus the new hpt will only contain invalid
entries or valid && bolted entries, we don't need to check if
replace_pte is bolted if we know it's valid. Similarly we know the one
we are replacing it with is bolted, otherwise we wouldn't have bothered
rehashing it. Thus it's pretty much sufficient to check replace_pte0
&& HPTE64_V_VALID == 1 which implies a bolted collision irrespective.
> +            if (pte0 & HPTE64_V_BOLTED) {
> +                /* Bolted collision, nothing we can do */
> +                return H_PTEG_FULL;
> +            } else {
> +                /* Discard this hpte */
> +                return H_SUCCESS;
> +            }
> +        }
Is there any reason the rehashed pte has to go into the same slot it
came out of? Isn't it valid to search all of the slots of the new pteg
for an empty (invalid) one and put it in the first empty space? Just
because the current slot already contains a bolted entry doesn't mean
we can't put it in another slot, right?
> +    }
> +
> +    new_hpte_store(new, new_pteg, slot, pte0, pte1);
> +    return H_SUCCESS;
> +}
> +
> +static int rehash_hpt(PowerPCCPU *cpu,
> +                      void *old, uint64_t oldsize,
> +                      void *new, uint64_t newsize)
> +{
> +    CPUPPCState *env = &cpu->env;
> +    uint64_t n_ptegs = oldsize >> 7;
> +    uint64_t pteg;
> +    int slot;
> +    int rc;
> +
> +    assert(env->external_htab == old);
> +
> +    for (pteg = 0; pteg < n_ptegs; pteg++) {
Can we rename token to pteg_[base_]addr or something? Token is very...
generic
> +        uint64_t token = ppc_hash64_start_access(cpu, pteg *
> HPTES_PER_GROUP);
> +
> +        if (!token) {
> +            return H_HARDWARE;
> +        }
> +
> +        for (slot = 0; slot < HPTES_PER_GROUP; slot++) {
> +            rc = rehash_hpte(cpu, token, old, oldsize, new, newsize,
> +                             pteg, slot);
> +            if (rc != H_SUCCESS) {
> +                ppc_hash64_stop_access(cpu, token);
> +                return rc;
> +            }
> +        }
> +        ppc_hash64_stop_access(cpu, token);
> +    }
> +
> +    return H_SUCCESS;
> +}
> +
> +static void pivot_hpt(CPUState *cs, run_on_cpu_data arg)
> +{
> +    sPAPRMachineState *spapr = SPAPR_MACHINE(arg.host_ptr);
> +    PowerPCCPU *cpu = POWERPC_CPU(cs);
> +
> +    cpu_synchronize_state(cs);
> +    ppc_hash64_set_external_hpt(cpu, spapr->htab, spapr->htab_shift,
> +                                &error_fatal);
>  }
>  
>  static target_ulong h_resize_hpt_commit(PowerPCCPU *cpu,
> @@ -378,13 +678,52 @@ static target_ulong
> h_resize_hpt_commit(PowerPCCPU *cpu,
>  {
>      target_ulong flags = args[0];
>      target_ulong shift = args[1];
> +    sPAPRPendingHPT *pending = spapr->pending_hpt;
> +    int rc;
> +    size_t newsize;
>  
>      if (spapr->resize_hpt == SPAPR_RESIZE_HPT_DISABLED) {
>          return H_AUTHORITY;
>      }
>  
>      trace_spapr_h_resize_hpt_commit(flags, shift);
> -    return H_HARDWARE;
> +
> +    if (flags != 0) {
> +        return H_PARAMETER;
> +    }
> +
> +    if (!pending || (pending->shift != shift)) {
> +        /* no matching prepare */
> +        return H_CLOSED;
> +    }
> +
> +    if (!pending->complete) {
> +        /* prepare has not completed */
> +        return H_BUSY;
> +    }
> +
> +    newsize = 1ULL << pending->shift;
> +    rc = rehash_hpt(cpu, spapr->htab, HTAB_SIZE(spapr),
> +                    pending->hpt, newsize);
> +    if (rc == H_SUCCESS) {
> +        CPUState *cs;
> +
> +        qemu_vfree(spapr->htab);
> +        spapr->htab = pending->hpt;
> +        spapr->htab_shift = pending->shift;
> +
> +        CPU_FOREACH(cs) {
> +            run_on_cpu(cs, pivot_hpt, RUN_ON_CPU_HOST_PTR(spapr));
> +        }
> +
> +        pending->hpt = NULL; /* so it's not free()d */
> +    }
> +
> +    /* Clean up */
> +    spapr->pending_hpt = NULL;
> +    free_pending_hpt(pending);
> +
> +    return rc;
>  }
>  
>  static target_ulong h_set_sprg0(PowerPCCPU *cpu, sPAPRMachineState
> *spapr,
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index d2c758b..954bada 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -14,6 +14,7 @@ struct sPAPRNVRAM;
>  typedef struct sPAPRConfigureConnectorState
> sPAPRConfigureConnectorState;
>  typedef struct sPAPREventLogEntry sPAPREventLogEntry;
>  typedef struct sPAPREventSource sPAPREventSource;
> +typedef struct sPAPRPendingHPT sPAPRPendingHPT;
>  
>  #define HPTE64_V_HPTE_DIRTY     0x0000000000000040ULL
>  #define SPAPR_ENTRY_POINT       0x100
> @@ -72,6 +73,8 @@ struct sPAPRMachineState {
>      sPAPRResizeHPT resize_hpt;
>      void *htab;
>      uint32_t htab_shift;
> +    sPAPRPendingHPT *pending_hpt; /* in-progress resize */
> +
>      hwaddr rma_size;
>      int vrma_adjust;
>      ssize_t rtas_size;
> @@ -627,6 +630,7 @@ void
> spapr_hotplug_req_remove_by_count_indexed(sPAPRDRConnectorType
> drc_type,
>                                                 uint32_t count,
> uint32_t index);
>  void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
>                                      sPAPRMachineState *spapr);
> +int spapr_hpt_shift_for_ramsize(uint64_t ramsize);
>  
>  /* rtas-configure-connector state */
>  struct sPAPRConfigureConnectorState {
> @@ -674,4 +678,6 @@ int spapr_rng_populate_dt(void *fdt);
>  
>  void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data
> arg);
>  
> +#define HTAB_SIZE(spapr)        (1ULL << ((spapr)->htab_shift))
> +
>  #endif /* HW_SPAPR_H */
> diff --git a/target-ppc/mmu-hash64.h b/target-ppc/mmu-hash64.h
> index ab5d347..4a1b781 100644
> --- a/target-ppc/mmu-hash64.h
> +++ b/target-ppc/mmu-hash64.h
> @@ -60,11 +60,15 @@ void ppc_hash64_update_rmls(CPUPPCState *env);
>  #define HASH_PTE_SIZE_64        16
>  #define HASH_PTEG_SIZE_64       (HASH_PTE_SIZE_64 * HPTES_PER_GROUP)
>  
> +#define HPTE64_V_SSIZE          SLB_VSID_B
> +#define HPTE64_V_SSIZE_256M     SLB_VSID_B_256M
> +#define HPTE64_V_SSIZE_1T       SLB_VSID_B_1T
>  #define HPTE64_V_SSIZE_SHIFT    62
>  #define HPTE64_V_AVPN_SHIFT     7
>  #define HPTE64_V_AVPN           0x3fffffffffffff80ULL
>  #define HPTE64_V_AVPN_VAL(x)    (((x) & HPTE64_V_AVPN) >>
> HPTE64_V_AVPN_SHIFT)
>  #define HPTE64_V_COMPARE(x, y)  (!(((x) ^ (y)) &
> 0xffffffffffffff83ULL))
> +#define HPTE64_V_BOLTED         0x0000000000000010ULL
>  #define HPTE64_V_LARGE          0x0000000000000004ULL
>  #define HPTE64_V_SECONDARY      0x0000000000000002ULL
>  #define HPTE64_V_VALID          0x0000000000000001ULL
