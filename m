Received: from eggs.gnu.org ([2001:4830:134:3::10]:54284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cHIsI-0004RI-3T
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 18:22:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cHIsG-0003WA-AO
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 18:22:14 -0500
Message-ID: <1481757657.22744.10.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Thu, 15 Dec 2016 10:20:57 +1100
In-Reply-To: <20161214062008.GI32647@umbus>
References: <20161212040603.27295-1-david@gibson.dropbear.id.au>
	<20161212040603.27295-4-david@gibson.dropbear.id.au>
	<1481693457.1555.25.camel@gmail.com> <20161214062008.GI32647@umbus>
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: paulus@samba.org, agraf@suse.de, mdroth@linux.vnet.ibm.com, thuth@redhat.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Wed, 2016-12-14 at 17:20 +1100, David Gibson wrote:
> On Wed, Dec 14, 2016 at 04:30:57PM +1100, Suraj Jitindar Singh wrote:
> > 
> > On Mon, 2016-12-12 at 15:06 +1100, David Gibson wrote:
> [snip]
> > 
> > > 
> > > +    if (!(pte0 & HPTE64_V_VALID) || !(pte0 & HPTE64_V_BOLTED)) {
> > > +        return H_SUCCESS;
> > > +    }
> > > +
> > > +    pte1 = ppc_hash64_load_hpte1(cpu, token, slot);
> > > +
> > > +    shift = ppc_hash64_hpte_page_shift_noslb(cpu, pte0, pte1);
> > > +    assert(shift); /* H_ENTER should never have allowed a bad
> > > encoding */
> > > +    avpn = HPTE64_V_AVPN_VAL(pte0) & ~(((1ULL << shift) - 1) >>
> > > 23);
> > > +
> > > +    if (pte0 & HPTE64_V_SECONDARY) {
> > > +        pteg = ~pteg;
> > > +    }
> > > +
> > The hash calculation below is pretty hard to follow... That being
> > said
> > I don't really see a nicer way of structuring it. I guess you just
> > have
> > to wade through the ISA if you actually want to understand what's
> > happening here (which I assume most people won't bother with).
> Yeah, the hash calculation is always hard to follow.  Here it's
> particularly bad because we're essentially doing two: one backwards
> and one forwards.  Unless someone has a great suggestion, I don't
> really see a way to make this obvious.
> 
> > 
> > > 
> > > +    if ((pte0 & HPTE64_V_SSIZE) == HPTE64_V_SSIZE_256M) {
> > > +        uint64_t offset, vsid;
> > > +
> > > +        /* We only have 28 - 23 bits of offset in avpn */
> > > +        offset = (avpn & 0x1f) << 23;
> > > +        vsid = avpn >> 5;
> > > +        /* We can find more bits from the pteg value */
> > > +        if (shift < 23) {
> > > +            offset |= ((vsid ^ pteg) & old_hash_mask) << shift;
> > > +        }
> > > +
> > > +        hash = vsid ^ (offset >> shift);
> > > +    } else if ((pte0 & HPTE64_V_SSIZE) == HPTE64_V_SSIZE_1T) {
> > > +        uint64_t offset, vsid;
> > > +
> > > +        /* We only have 40 - 23 bits of seg_off in avpn */
> > > +        offset = (avpn & 0x1ffff) << 23;
> > > +        vsid = avpn >> 17;
> > > +        if (shift < 23) {
> > > +            offset |= ((vsid ^ (vsid << 25) ^ pteg) &
> > > old_hash_mask)
> > > << shift;
> > > +        }
> > > +
> > > +        hash = vsid ^ (vsid << 25) ^ (offset >> shift);
> > > +    } else {
> > > +        error_report("rehash_pte: Bad segment size in HPTE");
> > > +        return H_HARDWARE;
> > > +    }
> > > +
> > > +    new_pteg = hash & new_hash_mask;
> > > +    if (pte0 & HPTE64_V_SECONDARY) {
> > > +        assert(~pteg == (hash & old_hash_mask));
> > > +        new_pteg = ~new_pteg;
> > > +    } else {
> > > +        assert(pteg == (hash & old_hash_mask));
> > > +    }
> > > +    assert((oldsize != newsize) || (pteg == new_pteg));
> > > +    replace_pte0 = new_hpte_load0(new, new_pteg, slot);
> > > +    if (replace_pte0 & HPTE64_V_VALID) {
> > > +        assert(newsize < oldsize);
> > > +        if (replace_pte0 & HPTE64_V_BOLTED) {
> > Aren't both of these checks for BOLTED redundant? We know that we
> > are
> > only rehashing ptes which are both valid and bolted, otherwise we
> > would
> > have returned at *** above. Thus the new hpt will only contain
> > invalid
> > entries or valid && bolted entries, we don't need to check if
> > replace_pte is bolted if we know it's valid. Similarly we know the
> > one
> > we are replacing it with is bolted, otherwise we wouldn't have
> > bothered
> > rehashing it. Thus it's pretty much sufficient to check
> > replace_pte0
> > && HPTE64_V_VALID == 1 which implies a bolted collision
> > irrespective.
> Ah, so, technically, yes it's redundant.  I'd prefer to leave it as
> is, in case we ever implement a version which also rehashes non-
> bolted
> entries.  As it is we could do that simply by changing the test at
> the
> top, without needing a synchronized change here
Sounds good, may as well keep it as is then to make future updates
easier.
> 
> > 
> > > 
> > > +            if (pte0 & HPTE64_V_BOLTED) {
> > > +                /* Bolted collision, nothing we can do */
> > > +                return H_PTEG_FULL;
> > > +            } else {
> > > +                /* Discard this hpte */
> > > +                return H_SUCCESS;
> > > +            }
> > > +        }
> > Is there any reason the rehashed pte has to go into the same slot
> > it
> > came out of? Isn't it valid to search all of the slots of the new
> > pteg
> > for an empty (invalid) one and put it in the first empty space?
> > Just
> > because the current slot already contains a bolted entry doesn't
> > mean
> > we can't put it in another slot, right?
> Not in practice.  The guest is allowed to keep track of which slot it
> loaded an HPTE into and use that for later updates or invalidates -
> Linux guests do this in practice.  Because of that the PAPR ACR
> explicitly says the resize must preserve hash slots.
> 
> I theory we could implement a variant which didn't do this, but I
> doubt we'll ever want to because it will be much, much harder to work
> with on the guest side.
Didn't manage to get hold of the ACR so didn't realise slots had to be
preserved. Seems like if you have a bolted collision you would want to
just use a different slot rather than fail the whole rehash. But I
didn't realise guests tracked the slot either so this is probably
difficult to change.
> 
> > 
> > > 
> > > +    }
> > > +
> > > +    new_hpte_store(new, new_pteg, slot, pte0, pte1);
> > > +    return H_SUCCESS;
> > > +}
> > > +
> > > +static int rehash_hpt(PowerPCCPU *cpu,
> > > +                      void *old, uint64_t oldsize,
> > > +                      void *new, uint64_t newsize)
> > > +{
> > > +    CPUPPCState *env = &cpu->env;
> > > +    uint64_t n_ptegs = oldsize >> 7;
> > > +    uint64_t pteg;
> > > +    int slot;
> > > +    int rc;
> > > +
> > > +    assert(env->external_htab == old);
> > > +
> > > +    for (pteg = 0; pteg < n_ptegs; pteg++) {
> > Can we rename token to pteg_[base_]addr or something? Token is
> > very...
> > generic
> So the value returned here is supposed to be opaque, and only passed
> back to the accessor helpers.  It returns different things depending
> on if we have an external HPT, or an internal HPT (virtual bare metal
> machine).  Hence the generic name.
> 
> > 
> > > 
> > > +        uint64_t token = ppc_hash64_start_access(cpu, pteg *
> > > HPTES_PER_GROUP);
> > > +
> > > +        if (!token) {
> > > +            return H_HARDWARE;
> > > +        }
> > > +
> > > +        for (slot = 0; slot < HPTES_PER_GROUP; slot++) {
> > > +            rc = rehash_hpte(cpu, token, old, oldsize, new,
> > > newsize,
> > > +                             pteg, slot);
> > > +            if (rc != H_SUCCESS) {
> > > +                ppc_hash64_stop_access(cpu, token);
> > > +                return rc;
> > > +            }
> > > +        }
> > > +        ppc_hash64_stop_access(cpu, token);
> > > +    }
> > > +
> > > +    return H_SUCCESS;
> > > +}
> > > +
> > > +static void pivot_hpt(CPUState *cs, run_on_cpu_data arg)
> > > +{
> > > +    sPAPRMachineState *spapr = SPAPR_MACHINE(arg.host_ptr);
> > > +    PowerPCCPU *cpu = POWERPC_CPU(cs);
> > > +
> > > +    cpu_synchronize_state(cs);
> > > +    ppc_hash64_set_external_hpt(cpu, spapr->htab, spapr-
> > > >htab_shift,
> > > +                                &error_fatal);
> > >  }
> > >  
> > >  static target_ulong h_resize_hpt_commit(PowerPCCPU *cpu,
> > > @@ -378,13 +678,52 @@ static target_ulong
> > > h_resize_hpt_commit(PowerPCCPU *cpu,
> > >  {
> > >      target_ulong flags = args[0];
> > >      target_ulong shift = args[1];
> > > +    sPAPRPendingHPT *pending = spapr->pending_hpt;
> > > +    int rc;
> > > +    size_t newsize;
> > >  
> > >      if (spapr->resize_hpt == SPAPR_RESIZE_HPT_DISABLED) {
> > >          return H_AUTHORITY;
> > >      }
> > >  
> > >      trace_spapr_h_resize_hpt_commit(flags, shift);
> > > -    return H_HARDWARE;
> > > +
> > > +    if (flags != 0) {
> > > +        return H_PARAMETER;
> > > +    }
> > > +
> > > +    if (!pending || (pending->shift != shift)) {
> > > +        /* no matching prepare */
> > > +        return H_CLOSED;
> > > +    }
> > > +
> > > +    if (!pending->complete) {
> > > +        /* prepare has not completed */
> > > +        return H_BUSY;
> > > +    }
> > > +
> > > +    newsize = 1ULL << pending->shift;
> > > +    rc = rehash_hpt(cpu, spapr->htab, HTAB_SIZE(spapr),
> > > +                    pending->hpt, newsize);
> > > +    if (rc == H_SUCCESS) {
> > > +        CPUState *cs;
> > > +
> > > +        qemu_vfree(spapr->htab);
> > > +        spapr->htab = pending->hpt;
> > > +        spapr->htab_shift = pending->shift;
> > > +
> > > +        CPU_FOREACH(cs) {
> > > +            run_on_cpu(cs, pivot_hpt,
> > > RUN_ON_CPU_HOST_PTR(spapr));
> > > +        }
> > > +
> > > +        pending->hpt = NULL; /* so it's not free()d */
> > > +    }
> > > +
> > > +    /* Clean up */
> > > +    spapr->pending_hpt = NULL;
> > > +    free_pending_hpt(pending);
> > > +
> > > +    return rc;
> > >  }
> > >  
> > >  static target_ulong h_set_sprg0(PowerPCCPU *cpu,
> > > sPAPRMachineState
> > > *spapr,
> > > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > > index d2c758b..954bada 100644
> > > --- a/include/hw/ppc/spapr.h
> > > +++ b/include/hw/ppc/spapr.h
> > > @@ -14,6 +14,7 @@ struct sPAPRNVRAM;
> > >  typedef struct sPAPRConfigureConnectorState
> > > sPAPRConfigureConnectorState;
> > >  typedef struct sPAPREventLogEntry sPAPREventLogEntry;
> > >  typedef struct sPAPREventSource sPAPREventSource;
> > > +typedef struct sPAPRPendingHPT sPAPRPendingHPT;
> > >  
> > >  #define HPTE64_V_HPTE_DIRTY     0x0000000000000040ULL
> > >  #define SPAPR_ENTRY_POINT       0x100
> > > @@ -72,6 +73,8 @@ struct sPAPRMachineState {
> > >      sPAPRResizeHPT resize_hpt;
> > >      void *htab;
> > >      uint32_t htab_shift;
> > > +    sPAPRPendingHPT *pending_hpt; /* in-progress resize */
> > > +
> > >      hwaddr rma_size;
> > >      int vrma_adjust;
> > >      ssize_t rtas_size;
> > > @@ -627,6 +630,7 @@ void
> > > spapr_hotplug_req_remove_by_count_indexed(sPAPRDRConnectorType
> > > drc_type,
> > >                                                 uint32_t count,
> > > uint32_t index);
> > >  void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int
> > > *fdt_offset,
> > >                                      sPAPRMachineState *spapr);
> > > +int spapr_hpt_shift_for_ramsize(uint64_t ramsize);
> > >  
> > >  /* rtas-configure-connector state */
> > >  struct sPAPRConfigureConnectorState {
> > > @@ -674,4 +678,6 @@ int spapr_rng_populate_dt(void *fdt);
> > >  
> > >  void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data
> > > arg);
> > >  
> > > +#define HTAB_SIZE(spapr)        (1ULL << ((spapr)->htab_shift))
> > > +
> > >  #endif /* HW_SPAPR_H */
> > > diff --git a/target-ppc/mmu-hash64.h b/target-ppc/mmu-hash64.h
> > > index ab5d347..4a1b781 100644
> > > --- a/target-ppc/mmu-hash64.h
> > > +++ b/target-ppc/mmu-hash64.h
> > > @@ -60,11 +60,15 @@ void ppc_hash64_update_rmls(CPUPPCState
> > > *env);
> > >  #define HASH_PTE_SIZE_64        16
> > >  #define HASH_PTEG_SIZE_64       (HASH_PTE_SIZE_64 *
> > > HPTES_PER_GROUP)
> > >  
> > > +#define HPTE64_V_SSIZE          SLB_VSID_B
> > > +#define HPTE64_V_SSIZE_256M     SLB_VSID_B_256M
> > > +#define HPTE64_V_SSIZE_1T       SLB_VSID_B_1T
> > >  #define HPTE64_V_SSIZE_SHIFT    62
> > >  #define HPTE64_V_AVPN_SHIFT     7
> > >  #define HPTE64_V_AVPN           0x3fffffffffffff80ULL
> > >  #define HPTE64_V_AVPN_VAL(x)    (((x) & HPTE64_V_AVPN) >>
> > > HPTE64_V_AVPN_SHIFT)
> > >  #define HPTE64_V_COMPARE(x, y)  (!(((x) ^ (y)) &
> > > 0xffffffffffffff83ULL))
> > > +#define HPTE64_V_BOLTED         0x0000000000000010ULL
> > >  #define HPTE64_V_LARGE          0x0000000000000004ULL
> > >  #define HPTE64_V_SECONDARY      0x0000000000000002ULL
> > >  #define HPTE64_V_VALID          0x0000000000000001ULL
