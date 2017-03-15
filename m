Received: from eggs.gnu.org ([2001:4830:134:3::10]:58689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1coFQX-0006M1-CO
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 16:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1coFQS-00069z-Qp
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 16:21:45 -0400
Received: from mx3-phx2.redhat.com ([209.132.183.24]:46865)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1coFQS-00068t-GT
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 16:21:40 -0400
Date: Wed, 15 Mar 2017 16:21:38 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1466597512.4602267.1489609298091.JavaMail.zimbra@redhat.com>
In-Reply-To: <4712D8F4B26E034E80552F30A67BE0B1A16F14@ORSMSX112.amr.corp.intel.com>
References: <1489158897-9206-1-git-send-email-yang.zhong@intel.com>
	<4712D8F4B26E034E80552F30A67BE0B1A0F91A@ORSMSX112.amr.corp.intel.com>
	<920352018.1797331.1489251855464.JavaMail.zimbra@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1A13045@ORSMSX112.amr.corp.intel.com>
	<991a0f3d-5e1f-d17c-a8f3-a42c02ac2f17@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1A1561C@ORSMSX112.amr.corp.intel.com>
	<f05fe113-c286-19b0-f5bc-ee2c1ea05568@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1A16F14@ORSMSX112.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/2] reduce qemu's heap Rss size from
 12252kB to 2752KB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Xu <anthony.xu@intel.com>
Cc: Yang Zhong <yang.zhong@intel.com>, Chao P Peng <chao.p.peng@intel.com>, qemu-devel@nongnu.org



----- Original Message -----
> From: "Anthony Xu" <anthony.xu@intel.com>
> To: "Paolo Bonzini" <pbonzini@redhat.com>
> Cc: "Yang Zhong" <yang.zhong@intel.com>, "Chao P Peng" <chao.p.peng@intel.com>, qemu-devel@nongnu.org
> Sent: Wednesday, March 15, 2017 8:05:48 PM
> Subject: Re: [Qemu-devel] [PATCH v1 2/2] reduce qemu's heap Rss size from 12252kB to 2752KB
> 
> > The first unref is done after as->current_map is overwritten.
> > as->current_map is accessed under RCU, so it needs call_rcu.  It
> > balances the initial reference that is present since flatview_init.
> 
> Got it, thanks for explanation.
> 
> > > but it is not clear to me, is this a bug or by design? Is
> > > flatview_destroy called
> > in current thread
> > > or RCU thread?
> > 
> > You cannot know, because there are also other callers of
> > address_space_get_flatview.  Usually it's from the RCU thread.
> 
> If it is from current thread, do we need to check if the global lock is
> acquired?
> As you mentioned flatview_unref may call memory_region_unref.

No, you don't need to check it.  Most functions (in this case,
memory_region_transaction_commit) can only be called under the global lock.
In fact, only address_space_read/write/ld*/st*, plus memory_region_find can
be called without the global lock.

> In the comments of memory_region_finalize
> "   /* We know the region is not visible in any address space (it
>      * does not have a container and cannot be a root either because
>      * it has no references,
> "
> 
> We know the memory region is not a root region, and the memory region has
> already been removed from address space even it has sub regions.
> memory_region_transaction_commit should be called when the
> memory region is removed from address space.
> memory_region_transaction_commit seems not be needed in
> memory_region_finalize.
> Let me know if you think otherwise.

Yes, you can replace memory_region_del_subregion in memory_region_finalize
with special code that does

    assert(!mr->enabled);
    assert(subregion->container == mr);
    subregion->container = NULL;
    QTAILQ_REMOVE(&mr->subregions, subregion, subregions_link);
    memory_region_unref(subregion);

The last four lines are shared with memory_region_del_subregion, so please
factor them in a new function, for example memory_region_del_subregion_internal.

> > > How about fall back to synchronize_rcu?
> > 
> > I'm afraid it would be too slow, but you can test.
> 
> It is not slow, the contention is not high. Yes we can test.

It's not a matter of contention.  It's a matter of how long an RCU
critical section can be---not just at startup, but at any point
during QEMU execution.

Have you tried tcmalloc or jemalloc?  They use the brk region
less and sometimes are more aggressive in releasing mmap-ed memory
areas.

> Please review below patch, MemoryRegion is protected by RCU.

Removing transaction begin/commit in memory_region_finalize makes
little sense because memory_region_del_subregion calls those two
functions again.  See above for an alternative.  Apart from this,
the patch is at least correct, though I'm not sure it's a good
idea (synchronize_rcu needs testing).  I'm not sure I understand the
address_space_write change).

Paolo

> Thanks,
> Anthony
> 
> 
> 
> diff --git a/exec.c b/exec.c
> index a22f5a0..6631668 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2521,7 +2521,8 @@ static void mem_commit(MemoryListener *listener)
> 
>      atomic_rcu_set(&as->dispatch, next);
>      if (cur) {
> -        call_rcu(cur, address_space_dispatch_free, rcu);
> +        synchronize_rcu();
> +        address_space_dispatch_free(cur);
>      }
>  }
> 
> @@ -2567,7 +2568,8 @@ void address_space_destroy_dispatch(AddressSpace *as)
> 
>      atomic_rcu_set(&as->dispatch, NULL);
>      if (d) {
> -        call_rcu(d, address_space_dispatch_free, rcu);
> +        synchronize_rcu();
> +        address_space_dispatch_free(d);
>      }
>  }
> 
> @@ -2712,19 +2714,22 @@ static bool prepare_mmio_access(MemoryRegion *mr)
>      return release_lock;
>  }
> 
> -/* Called within RCU critical section.  */
> -static MemTxResult address_space_write_continue(AddressSpace *as, hwaddr
> addr,
> -                                                MemTxAttrs attrs,
> -                                                const uint8_t *buf,
> -                                                int len, hwaddr addr1,
> -                                                hwaddr l, MemoryRegion *mr)
> +MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
> +                  MemTxAttrs attrs, const uint8_t *buf, int len)
>  {
>      uint8_t *ptr;
>      uint64_t val;
> +    hwaddr l=len;
> +    hwaddr addr1;
> +    MemoryRegion *mr;
>      MemTxResult result = MEMTX_OK;
>      bool release_lock = false;
> 
>      for (;;) {
> +        rcu_read_lock();
> +        mr = address_space_translate(as, addr, &addr1, &l, true);
> +        memory_region_ref(mr);
> +        rcu_read_unlock();
>          if (!memory_access_is_direct(mr, true)) {
>              release_lock |= prepare_mmio_access(mr);
>              l = memory_access_size(mr, l, addr1);
> @@ -2764,7 +2769,7 @@ static MemTxResult
> address_space_write_continue(AddressSpace *as, hwaddr addr,
>              memcpy(ptr, buf, l);
>              invalidate_and_set_dirty(mr, addr1, l);
>          }
> -
> +        memory_region_unref(mr);
>          if (release_lock) {
>              qemu_mutex_unlock_iothread();
>              release_lock = false;
> @@ -2779,27 +2784,6 @@ static MemTxResult
> address_space_write_continue(AddressSpace *as, hwaddr addr,
>          }
> 
>          l = len;
> -        mr = address_space_translate(as, addr, &addr1, &l, true);
> -    }
> -
> -    return result;
> -}
> -
> -MemTxResult address_space_write(AddressSpace *as, hwaddr addr, MemTxAttrs
> attrs,
> -                                const uint8_t *buf, int len)
> -{
> -    hwaddr l;
> -    hwaddr addr1;
> -    MemoryRegion *mr;
> -    MemTxResult result = MEMTX_OK;
> -
> -    if (len > 0) {
> -        rcu_read_lock();
> -        l = len;
> -        mr = address_space_translate(as, addr, &addr1, &l, true);
> -        result = address_space_write_continue(as, addr, attrs, buf, len,
> -                                              addr1, l, mr);
> -        rcu_read_unlock();
>      }
> 
>      return result;
> diff --git a/memory.c b/memory.c
> index 64b0a60..d12437c 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1505,13 +1505,10 @@ static void memory_region_finalize(Object *obj)
>       * and cause an infinite loop.
>       */
>      mr->enabled = false;
> -    memory_region_transaction_begin();
>      while (!QTAILQ_EMPTY(&mr->subregions)) {
>          MemoryRegion *subregion = QTAILQ_FIRST(&mr->subregions);
>          memory_region_del_subregion(mr, subregion);
>      }
> -    memory_region_transaction_commit();
> -
>      mr->destructor(mr);
>      memory_region_clear_coalescing(mr);
>      g_free((char *)mr->name);
> 
> 
> 
