Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA249C2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 20:43:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AF1920719
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 20:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XDoPbMmL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF1920719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHCru-0003Ze-Kk
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 16:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jHCqg-0002bD-Aw
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 16:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jHCqb-0004LV-IG
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 16:42:00 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:47242)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jHCqb-0004L3-8o
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 16:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585168916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aR3dkHI5yFyIGhMXB3Nx5eDsWM7JoG8p4SiCSAWEyFo=;
 b=XDoPbMmL7K++FhO3NL9U9aphkhLZQ/lEzr3FRevb1TbwdTSYaSNRFOufvT9MEmym1Ib+Um
 cVhSYXHL8iVDLM83KM+xUo0ONeEb756KI4xz44clCS25uuarHs8E5XN1VOaTJgADIa6oMd
 VKTUQZqxgRbJJP7FPF/WcBPyqL2ZjBc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-wmFmNl88PUWaS1XuBcUBWQ-1; Wed, 25 Mar 2020 16:41:54 -0400
X-MC-Unique: wmFmNl88PUWaS1XuBcUBWQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57002149C0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 20:41:53 +0000 (UTC)
Received: from work-vm (ovpn-114-213.ams2.redhat.com [10.36.114.213])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 470EA19C70;
 Wed, 25 Mar 2020 20:41:46 +0000 (UTC)
Date: Wed, 25 Mar 2020 20:41:44 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH RFC 9/9] KVM: Dirty ring support
Message-ID: <20200325204144.GI2635@work-vm>
References: <20200205141749.378044-1-peterx@redhat.com>
 <20200205141749.378044-10-peterx@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200205141749.378044-10-peterx@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Xu (peterx@redhat.com) wrote:
> KVM dirty ring is a new interface to pass over dirty bits from kernel
> to the userspace.  Instead of using a bitmap for each memory region,
> the dirty ring contains an array of dirtied GPAs to fetch.  For each
> vcpu there will be one dirty ring that binds to it.
>=20
> There're a few major changes comparing to how the old dirty logging
> interface would work:
>=20
>   - Granularity of dirty bits
>=20
>     KVM dirty ring interface does not offer memory region level
>     granularity to collect dirty bits (i.e., per KVM memory slot).
>     Instead the dirty bit is collected globally for all the vcpus at
>     once.  The major effect is on VGA part because VGA dirty tracking
>     is enabled as long as the device is created, also it was in memory
>     region granularity.  Now that operation will be amplified to a VM
>     sync.  Maybe there's smarter way to do the same thing in VGA with
>     the new interface, but so far I don't see it affects much at least
>     on regular VMs.
>=20
>   - Collection of dirty bits
>=20
>     The old dirty logging interface collects KVM dirty bits when
>     synchronizing dirty bits.  KVM dirty ring interface instead used a
>     standalone thread to do that.  So when the other thread (e.g., the
>     migration thread) wants to synchronize the dirty bits, it simply
>     kick the thread and wait until it flushes all the dirty bits to
>     the ramblock dirty bitmap.
>=20
> For more information please refer to the comments in the code.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  accel/kvm/kvm-all.c    | 426 ++++++++++++++++++++++++++++++++++++++++-
>  accel/kvm/trace-events |   7 +
>  include/hw/core/cpu.h  |  10 +
>  3 files changed, 440 insertions(+), 3 deletions(-)
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 6d145a8b98..201617bbb7 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -15,6 +15,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include <sys/ioctl.h>
> +#include <poll.h>
> =20
>  #include <linux/kvm.h>
> =20
> @@ -75,6 +76,47 @@ struct KVMParkedVcpu {
>      QLIST_ENTRY(KVMParkedVcpu) node;
>  };
> =20
> +enum KVMReaperState {
> +    KVM_REAPER_NONE =3D 0,
> +    /* The reaper is sleeping */
> +    KVM_REAPER_WAIT,
> +    /* The reaper is reaping for dirty pages */
> +    KVM_REAPER_REAPING,
> +};

That probably needs to be KVMDirtyRingReaperState
given there are many things that could be reaped.

> +/*
> + * KVM reaper instance, responsible for collecting the KVM dirty bits
> + * via the dirty ring.
> + */
> +struct KVMDirtyRingReaper {
> +    /* The reaper thread */
> +    QemuThread reaper_thr;
> +    /*
> +     * Telling the reaper thread to wakeup.  This should be used as a
> +     * generic interface to kick the reaper thread, like, in vcpu
> +     * threads where it gets a exit due to ring full.
> +     */
> +    EventNotifier reaper_event;

I think I'd just used a simple semaphore for this type of thing.

> +    /*
> +     * This should only be used when someone wants to do synchronous
> +     * flush of the dirty ring buffers.  Logically we can achieve this
> +     * even with the reaper_event only, however that'll make things
> +     * complicated.  This extra event can make the sync procedure easy
> +     * and clean.
> +     */
> +    EventNotifier reaper_flush_event;
> +    /*
> +     * Used in pair with reaper_flush_event, that the sem will be
> +     * posted to notify that the previous flush event is handled by
> +     * the reaper thread.
> +     */
> +    QemuSemaphore reaper_flush_sem;
> +    /* Iteration number of the reaper thread */
> +    volatile uint64_t reaper_iteration;
> +    /* Status of the reaper thread */
> +    volatile enum KVMReaperState reaper_state;
> +};
> +
>  struct KVMState
>  {
>      AccelState parent_obj;
> @@ -121,7 +163,6 @@ struct KVMState
>      void *memcrypt_handle;
>      int (*memcrypt_encrypt_data)(void *handle, uint8_t *ptr, uint64_t le=
n);
> =20
> -    /* For "info mtree -f" to tell if an MR is registered in KVM */
>      int nr_as;
>      struct KVMAs {
>          KVMMemoryListener *ml;
> @@ -129,6 +170,7 @@ struct KVMState
>      } *as;
>      int kvm_dirty_ring_size;
>      int kvm_dirty_gfn_count;    /* If nonzero, then kvm dirty ring enabl=
ed */
> +    struct KVMDirtyRingReaper reaper;
>  };
> =20
>  KVMState *kvm_state;
> @@ -348,6 +390,11 @@ int kvm_destroy_vcpu(CPUState *cpu)
>          goto err;
>      }
> =20
> +    ret =3D munmap(cpu->kvm_dirty_gfns, s->kvm_dirty_ring_size);
> +    if (ret < 0) {
> +        goto err;
> +    }
> +
>      vcpu =3D g_malloc0(sizeof(*vcpu));
>      vcpu->vcpu_id =3D kvm_arch_vcpu_id(cpu);
>      vcpu->kvm_fd =3D cpu->kvm_fd;
> @@ -391,6 +438,7 @@ int kvm_init_vcpu(CPUState *cpu)
>      cpu->kvm_fd =3D ret;
>      cpu->kvm_state =3D s;
>      cpu->vcpu_dirty =3D true;
> +    qemu_sem_init(&cpu->kvm_dirty_ring_avail, 0);
> =20
>      mmap_size =3D kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
>      if (mmap_size < 0) {
> @@ -412,6 +460,18 @@ int kvm_init_vcpu(CPUState *cpu)
>              (void *)cpu->kvm_run + s->coalesced_mmio * PAGE_SIZE;
>      }
> =20
> +    if (s->kvm_dirty_gfn_count) {
> +        cpu->kvm_dirty_gfns =3D mmap(NULL, s->kvm_dirty_ring_size,
> +                                   PROT_READ | PROT_WRITE, MAP_SHARED,

Is the MAP_SHARED required?

> +                                   cpu->kvm_fd,
> +                                   PAGE_SIZE * KVM_DIRTY_LOG_PAGE_OFFSET=
);
> +        if (cpu->kvm_dirty_gfns =3D=3D MAP_FAILED) {
> +            ret =3D -errno;
> +            DPRINTF("mmap'ing vcpu dirty gfns failed\n");

Include errno?

> +            goto err;
> +        }
> +    }
> +
>      ret =3D kvm_arch_init_vcpu(cpu);
>  err:
>      return ret;
> @@ -525,6 +585,11 @@ static void kvm_slot_sync_dirty_pages(KVMSlot *slot)
>      cpu_physical_memory_set_dirty_lebitmap(slot->dirty_bmap, start, page=
s);
>  }
> =20
> +static void kvm_slot_reset_dirty_pages(KVMSlot *slot)
> +{
> +    memset(slot->dirty_bmap, 0, slot->dirty_bmap_size);
> +}
> +
>  #define ALIGN(x, y)  (((x)+(y)-1) & ~((y)-1))
> =20
>  /* Allocate the dirty bitmap for a slot  */
> @@ -1100,6 +1165,305 @@ out:
>      kvm_slots_unlock(kml);
>  }
> =20
> +static void kvm_dirty_ring_reaper_kick(void)
> +{
> +    trace_kvm_dirty_ring_reaper_kick("any");
> +    event_notifier_set(&kvm_state->reaper.reaper_event);
> +}
> +
> +static void kvm_dirty_ring_reaper_kick_flush(void)
> +{
> +    trace_kvm_dirty_ring_reaper_kick("flush");
> +    event_notifier_set(&kvm_state->reaper.reaper_flush_event);
> +}
> +
> +/* Should be with all slots_lock held for the address spaces */
> +static void kvm_dirty_ring_mark_page(KVMState *s, uint32_t as_id,
> +                                     uint32_t slot_id, uint64_t offset)
> +{
> +    KVMMemoryListener *kml;
> +    KVMSlot *mem;
> +
> +    assert(as_id < s->nr_as);
> +    /* These fields shouldn't change after VM inits */
> +    kml =3D s->as[as_id].ml;
> +    mem =3D &kml->slots[slot_id];
> +    set_bit(offset, mem->dirty_bmap);
> +}
> +
> +static bool dirty_gfn_is_dirtied(struct kvm_dirty_gfn *gfn)
> +{
> +    return gfn->flags =3D=3D KVM_DIRTY_GFN_F_DIRTY;
> +}
> +
> +static void dirty_gfn_set_collected(struct kvm_dirty_gfn *gfn)
> +{
> +    gfn->flags =3D KVM_DIRTY_GFN_F_RESET;
> +}
> +
> +/* Should be with all slots_lock held for the address spaces */
> +static uint32_t kvm_dirty_ring_reap_one(KVMState *s, CPUState *cpu)
> +{
> +    struct kvm_dirty_gfn *dirty_gfns =3D cpu->kvm_dirty_gfns, *cur;
> +    uint32_t gfn_count =3D s->kvm_dirty_gfn_count;
> +    uint32_t count =3D 0, fetch =3D cpu->kvm_fetch_index;
> +
> +    assert(dirty_gfns && gfn_count);
> +
> +    trace_kvm_dirty_ring_reap_vcpu(cpu->cpu_index);
> +
> +    while (true) {
> +        cur =3D &dirty_gfns[fetch % gfn_count];
> +        if (!dirty_gfn_is_dirtied(cur)) {
> +            break;
> +        }
> +        trace_kvm_dirty_ring_page(cpu->cpu_index, fetch, cur->offset);
> +        kvm_dirty_ring_mark_page(s, cur->slot >> 16, cur->slot & 0xffff,
> +                                 cur->offset);
> +        dirty_gfn_set_collected(cur);
> +        fetch++;
> +        count++;
> +    }
> +    cpu->kvm_fetch_index =3D fetch;
> +
> +    return count;
> +}
> +
> +static uint64_t kvm_dirty_ring_reap(KVMState *s)
> +{
> +    KVMMemoryListener *kml;
> +    int ret, i, locked_count =3D s->nr_as;
> +    CPUState *cpu;
> +    uint64_t total =3D 0;
> +
> +    /*
> +     * We need to lock all kvm slots for all address spaces here,
> +     * because:
> +     *
> +     * (1) We need to mark dirty for dirty bitmaps in multiple slots
> +     *     and for tons of pages, so it's better to take the lock here
> +     *     once rather than once per page.  And more importantly,
> +     *
> +     * (2) We must _NOT_ publish dirty bits to the other threads
> +     *     (e.g., the migration thread) via the kvm memory slot dirty
> +     *     bitmaps before correctly re-protect those dirtied pages.
> +     *     Otherwise we can have potential risk of data corruption if
> +     *     the page data is read in the other thread before we do
> +     *     reset below.
> +     */
> +    for (i =3D 0; i < s->nr_as; i++) {
> +        kml =3D s->as[i].ml;
> +        if (!kml) {
> +            /*
> +             * This is tricky - we grow s->as[] dynamically now.  Take
> +             * care of that case.  We also assumed the as[] will fill
> +             * one by one starting from zero.  Without this, we race
> +             * with register_smram_listener.
> +             *
> +             * TODO: make all these prettier...
> +             */
> +            locked_count =3D i;
> +            break;
> +        }
> +        kvm_slots_lock(kml);
> +    }
> +
> +    CPU_FOREACH(cpu) {
> +        total +=3D kvm_dirty_ring_reap_one(s, cpu);
> +    }
> +
> +    if (total) {
> +        ret =3D kvm_vm_ioctl(s, KVM_RESET_DIRTY_RINGS);
> +        assert(ret =3D=3D total);
> +    }
> +
> +    /* Unlock whatever locks that we have locked */
> +    for (i =3D 0; i < locked_count; i++) {
> +        kvm_slots_unlock(s->as[i].ml);
> +    }
> +
> +    CPU_FOREACH(cpu) {
> +        if (cpu->kvm_dirty_ring_full) {
> +            qemu_sem_post(&cpu->kvm_dirty_ring_avail);
> +        }

Why do you need to wait until here - couldn't you release
each vcpu after you've reaped it?

> +    }
> +
> +    return total;
> +}
> +
> +static void do_kvm_cpu_synchronize_kick(CPUState *cpu, run_on_cpu_data a=
rg)
> +{
> +    /* No need to do anything */
> +}
> +
> +/*
> + * Kick all vcpus out in a synchronized way.  When returned, we
> + * guarantee that every vcpu has been kicked and at least returned to
> + * userspace once.
> + */
> +static void kvm_cpu_synchronize_kick_all(void)
> +{
> +    CPUState *cpu;
> +
> +    CPU_FOREACH(cpu) {
> +        run_on_cpu(cpu, do_kvm_cpu_synchronize_kick, RUN_ON_CPU_NULL);
> +    }
> +}
> +
> +/*
> + * Flush all the existing dirty pages to the KVM slot buffers.  When
> + * this call returns, we guarantee that all the touched dirty pages
> + * before calling this function have been put into the per-kvmslot
> + * dirty bitmap.
> + *
> + * To achieve this, we need to:
> + *
> + * (1) Kick all vcpus out, this will make sure that we flush all the
> + *     dirty buffers that potentially in the hardware (PML) into the
> + *     dirty rings, after that,
> + *
> + * (2) Kick the reaper thread and make sure it reaps all the dirty
> + *     page that is in the dirty rings.
> + *
> + * This function must be called with BQL held.
> + */
> +static void kvm_dirty_ring_flush(struct KVMDirtyRingReaper *r)
> +{
> +    uint64_t iteration;
> +
> +    trace_kvm_dirty_ring_flush(0);
> +
> +    /*
> +     * The function needs to be serialized.  Since this function
> +     * should always be with BQL held, serialization is guaranteed.
> +     * However, let's be sure of it.
> +     */
> +    assert(qemu_mutex_iothread_locked());
> +
> +    /*
> +     * First make sure to flush the hardware buffers by kicking all
> +     * vcpus out in a synchronous way.
> +     */
> +    kvm_cpu_synchronize_kick_all();
> +
> +    iteration =3D r->reaper_iteration;
> +
> +    /*
> +     * Kick the reaper to collect data.  Here we must make sure that
> +     * it goes over a complete WAIT->REAPING->WAIT period so that we
> +     * know the reaper has collected all the dirty pages even in the
> +     * hardware buffers we just flushed.  To achieve this, we kick the
> +     * flush_event.
> +     */
> +    kvm_dirty_ring_reaper_kick_flush();
> +    qemu_sem_wait(&r->reaper_flush_sem);
> +
> +    /* When reach here, we must have finished at least one iteration */
> +    assert(r->reaper_iteration > iteration);
> +
> +    trace_kvm_dirty_ring_flush(1);
> +}
> +
> +static void *kvm_dirty_ring_reaper_thread(void *data)
> +{
> +    KVMState *s =3D data;
> +    struct KVMDirtyRingReaper *r =3D &s->reaper;
> +    struct pollfd *pfd =3D g_new0(struct pollfd, 2);
> +    uint64_t count;
> +    int64_t stamp;
> +    int ret;
> +
> +    rcu_register_thread();
> +
> +    trace_kvm_dirty_ring_reaper("init");
> +
> +    pfd[0].fd =3D event_notifier_get_fd(&r->reaper_event);
> +    pfd[0].events =3D POLLIN;
> +    pfd[1].fd =3D event_notifier_get_fd(&r->reaper_flush_event);
> +    pfd[1].events =3D POLLIN;
> +
> +    while (true) {
> +        bool flush_requested =3D false;
> +
> +        r->reaper_state =3D KVM_REAPER_WAIT;
> +        trace_kvm_dirty_ring_reaper("wait");
> +        /*
> +         * TODO: provide a smarter timeout rather than a constant?  If
> +         * this timeout is too small it could eat a lot of CPU
> +         * resource, however if too big then VGA could be less
> +         * responsive.  30ms is a value that is not too small so it
> +         * won't eat much CPU, while the VGA can still get ~30Hz
> +         * refresh rate.
> +         */
> +        ret =3D poll(pfd, 2, 30);
> +        trace_kvm_dirty_ring_reaper("wakeup");
> +        r->reaper_state =3D KVM_REAPER_REAPING;
> +
> +        if (ret =3D=3D -1) {
> +            error_report("%s: poll() failed: %s", __func__, strerror(err=
no));
> +            break;
> +        }
> +
> +        /*
> +         * Note: we only handle one request at a time.  Also, we'll
> +         * clear the event flag before we reap, so each SET to the
> +         * event will guarantee that another full-reap procedure will
> +         * happen.
> +         */
> +        if (pfd[0].revents) {
> +            ret =3D event_notifier_test_and_clear(&r->reaper_event);
> +            assert(ret);
> +        } else if (pfd[1].revents) {
> +            ret =3D event_notifier_test_and_clear(&r->reaper_flush_event=
);
> +            assert(ret);
> +            flush_requested =3D true;
> +        }
> +
> +        stamp =3D get_clock();
> +        count =3D kvm_dirty_ring_reap(s);
> +        stamp =3D get_clock() - stamp;
> +
> +        r->reaper_iteration++;
> +
> +        if (count) {
> +            trace_kvm_dirty_ring_reaper_iterate(r->reaper_iteration,
> +                                                count, stamp / 1000);
> +        }
> +
> +        /*
> +         * If this iteration is to handle a flush event, wakeup the
> +         * requester of the flush
> +         */
> +        if (flush_requested) {
> +            qemu_sem_post(&r->reaper_flush_sem);
> +        }
> +    }
> +
> +    trace_kvm_dirty_ring_reaper("exit");
> +
> +    rcu_unregister_thread();
> +
> +    return NULL;
> +}
> +
> +static int kvm_dirty_ring_reaper_init(KVMState *s)
> +{
> +    struct KVMDirtyRingReaper *r =3D &s->reaper;
> +    int ret;
> +
> +    ret =3D event_notifier_init(&r->reaper_event, false);
> +    assert(ret =3D=3D 0);
> +    ret =3D event_notifier_init(&r->reaper_flush_event, false);
> +    assert(ret =3D=3D 0);
> +    qemu_sem_init(&r->reaper_flush_sem, 0);
> +
> +    qemu_thread_create(&r->reaper_thr, "kvm-reaper",
> +                       kvm_dirty_ring_reaper_thread,
> +                       s, QEMU_THREAD_JOINABLE);

That's marked as joinable - does it ever get joined?
If the reaper thread does exit on error (I can only see the poll
failure?) - what happens elsewhere - will things still try and kick it?

Dave

> +
> +    return 0;
> +}
> +
>  static void kvm_region_add(MemoryListener *listener,
>                             MemoryRegionSection *section)
>  {
> @@ -1128,6 +1492,36 @@ static void kvm_log_sync(MemoryListener *listener,
>      kvm_slots_unlock(kml);
>  }
> =20
> +static void kvm_log_sync_global(MemoryListener *l)
> +{
> +    KVMMemoryListener *kml =3D container_of(l, KVMMemoryListener, listen=
er);
> +    KVMState *s =3D kvm_state;
> +    KVMSlot *mem;
> +    int i;
> +
> +    /* Flush all kernel dirty addresses into KVMSlot dirty bitmap */
> +    kvm_dirty_ring_flush(&s->reaper);
> +
> +    /*
> +     * TODO: make this faster when nr_slots is big while there are
> +     * only a few used slots (small VMs).
> +     */
> +    kvm_slots_lock(kml);
> +    for (i =3D 0; i < s->nr_slots; i++) {
> +        mem =3D &kml->slots[i];
> +        if (mem->memory_size && mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
> +            kvm_slot_sync_dirty_pages(mem);
> +            /*
> +             * This is not needed by KVM_GET_DIRTY_LOG because the
> +             * ioctl will unconditionally overwrite the whole region.
> +             * However kvm dirty ring has no such side effect.
> +             */
> +            kvm_slot_reset_dirty_pages(mem);
> +        }
> +    }
> +    kvm_slots_unlock(kml);
> +}
> +
>  static void kvm_log_clear(MemoryListener *listener,
>                            MemoryRegionSection *section)
>  {
> @@ -1234,10 +1628,17 @@ void kvm_memory_listener_register(KVMState *s, KV=
MMemoryListener *kml,
>      kml->listener.region_del =3D kvm_region_del;
>      kml->listener.log_start =3D kvm_log_start;
>      kml->listener.log_stop =3D kvm_log_stop;
> -    kml->listener.log_sync =3D kvm_log_sync;
> -    kml->listener.log_clear =3D kvm_log_clear;
>      kml->listener.priority =3D 10;
> =20
> +    if (s->kvm_dirty_gfn_count) {
> +        /* KVM dirty ring enabled */
> +        kml->listener.log_sync_global =3D kvm_log_sync_global;
> +    } else {
> +        /* KVM dirty logging enabled */
> +        kml->listener.log_sync =3D kvm_log_sync;
> +        kml->listener.log_clear =3D kvm_log_clear;
> +    }
> +
>      memory_listener_register(&kml->listener, as);
> =20
>      for (i =3D 0; i < s->nr_as; ++i) {
> @@ -2120,6 +2521,13 @@ static int kvm_init(MachineState *ms)
>          qemu_balloon_inhibit(true);
>      }
> =20
> +    if (s->kvm_dirty_gfn_count) {
> +        ret =3D kvm_dirty_ring_reaper_init(s);
> +        if (ret) {
> +            goto err;
> +        }
> +    }
> +
>      return 0;
> =20
>  err:
> @@ -2427,6 +2835,18 @@ int kvm_cpu_exec(CPUState *cpu)
>          case KVM_EXIT_INTERNAL_ERROR:
>              ret =3D kvm_handle_internal_error(cpu, run);
>              break;
> +        case KVM_EXIT_DIRTY_RING_FULL:
> +            /*
> +             * We shouldn't continue if the dirty ring of this vcpu is
> +             * still full.  Got kicked by KVM_RESET_DIRTY_RINGS.
> +             */
> +            trace_kvm_dirty_ring_full(cpu->cpu_index);
> +            cpu->kvm_dirty_ring_full =3D true;
> +            kvm_dirty_ring_reaper_kick();
> +            qemu_sem_wait(&cpu->kvm_dirty_ring_avail);
> +            cpu->kvm_dirty_ring_full =3D false;
> +            ret =3D 0;
> +            break;
>          case KVM_EXIT_SYSTEM_EVENT:
>              switch (run->system_event.type) {
>              case KVM_SYSTEM_EVENT_SHUTDOWN:
> diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
> index 4fb6e59d19..17d6b6a154 100644
> --- a/accel/kvm/trace-events
> +++ b/accel/kvm/trace-events
> @@ -16,4 +16,11 @@ kvm_set_ioeventfd_mmio(int fd, uint64_t addr, uint32_t=
 val, bool assign, uint32_
>  kvm_set_ioeventfd_pio(int fd, uint16_t addr, uint32_t val, bool assign, =
uint32_t size, bool datamatch) "fd: %d @0x%x val=3D0x%x assign: %d size: %d=
 match: %d"
>  kvm_set_user_memory(uint32_t slot, uint32_t flags, uint64_t guest_phys_a=
ddr, uint64_t memory_size, uint64_t userspace_addr, int ret) "Slot#%d flags=
=3D0x%x gpa=3D0x%"PRIx64 " size=3D0x%"PRIx64 " ua=3D0x%"PRIx64 " ret=3D%d"
>  kvm_clear_dirty_log(uint32_t slot, uint64_t start, uint32_t size) "slot#=
%"PRId32" start 0x%"PRIx64" size 0x%"PRIx32
> +kvm_dirty_ring_full(int id) "vcpu %d"
> +kvm_dirty_ring_reap_vcpu(int id) "vcpu %d"
> +kvm_dirty_ring_page(int vcpu, uint32_t slot, uint64_t offset) "vcpu %d f=
etch %"PRIu32" offset 0x%"PRIx64
> +kvm_dirty_ring_reaper(const char *s) "%s"
> +kvm_dirty_ring_reaper_iterate(uint64_t iter, uint64_t count, int64_t t) =
"iteration %"PRIu64" reaped %"PRIu64" pages (took %"PRIi64" us)"
> +kvm_dirty_ring_reaper_kick(const char *reason) "%s"
> +kvm_dirty_ring_flush(int finished) "%d"
> =20
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 73e9a869a4..a7cddb7b40 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -342,6 +342,11 @@ struct qemu_work_item;
>   * @ignore_memory_transaction_failures: Cached copy of the MachineState
>   *    flag of the same name: allows the board to suppress calling of the
>   *    CPU do_transaction_failed hook function.
> + * @kvm_dirty_ring_full:
> + *   Whether the kvm dirty ring of this vcpu is soft-full.
> + * @kvm_dirty_ring_avail:
> + *   Semaphore to be posted when the kvm dirty ring of the vcpu is
> + *   available again.
>   *
>   * State of one CPU core or thread.
>   */
> @@ -409,9 +414,14 @@ struct CPUState {
>       */
>      uintptr_t mem_io_pc;
> =20
> +    /* Only used in KVM */
>      int kvm_fd;
>      struct KVMState *kvm_state;
>      struct kvm_run *kvm_run;
> +    struct kvm_dirty_gfn *kvm_dirty_gfns;
> +    uint32_t kvm_fetch_index;
> +    QemuSemaphore kvm_dirty_ring_avail;
> +    bool kvm_dirty_ring_full;
> =20
>      /* Used for events with 'vcpu' and *without* the 'disabled' properti=
es */
>      DECLARE_BITMAP(trace_dstate_delayed, CPU_TRACE_DSTATE_MAX_EVENTS);
> --=20
> 2.24.1
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


