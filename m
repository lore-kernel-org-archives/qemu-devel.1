Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D4BC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 23:26:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9035020735
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 23:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HoaUu0BW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9035020735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcdWh-0000KS-PD
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 19:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jcdRu-0007Rc-4I
 for qemu-devel@nongnu.org; Sat, 23 May 2020 19:21:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52607
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jcdRs-0000Vb-5u
 for qemu-devel@nongnu.org; Sat, 23 May 2020 19:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590276059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=odsL73+Q7FzWnr/03F1vy25OTOWAkSShgRJYyp0wnik=;
 b=HoaUu0BWt2SgZ+sahbytQxux6/YcQ/lrp+lEQR2sbvvrt5R5M38/VWLGQicOLRUsYj08kD
 kD5t1V51KPyUg5ikkpkfiI2Iei10BMKz2X1BJqv701ufl3cwChYTORSJDNjvIPd2gxCsGR
 YnMFQtAxrNOrfokLstVX1Rm+ODSFT/c=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-uxiqqkBaO_m9ykJ_L1C8NQ-1; Sat, 23 May 2020 19:20:57 -0400
X-MC-Unique: uxiqqkBaO_m9ykJ_L1C8NQ-1
Received: by mail-qv1-f72.google.com with SMTP id g15so14139207qvx.6
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 16:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=odsL73+Q7FzWnr/03F1vy25OTOWAkSShgRJYyp0wnik=;
 b=Cyi+JPELLJZGLaf2oA7IVrIZooqQ5TFoFNjZXN18Y9Lc6VY+r/p4UckEkt3ux2gEwT
 pdNNQBINlB9nNzozHVb250u1LEy8/4YkM78lW1jU9jXRB5RgLw4hWc3zwRSUosXql76a
 xxQu8ynBQ/k9wznG5neH2DOfkwY5z98iIlPDwKcxrLzbOKjljy/psfsmTv6B1pD2SgqA
 TxowkVX/PhfHQkDlmjqcd3QReuefavBddEOSUh0WdMBSZgLMVAKTVBVRKNccXIm/9QQY
 vOfm5f3wyQth4H8L83h/n29FGtQEheAkU1Y0AEYvUt+7ZkcQ+/a1aDsHV8F0mV+26m+7
 J5DA==
X-Gm-Message-State: AOAM533c19LqwzutKe/91C0TLdO/ovtxyoVeA4NWb6oG71Huf8fPn7sR
 kf13/rhS2VxLaBJHQBVTEkWzAlAeY2MEFuSMt2NoXfJ3+34JgHtOU/ibfX0JJoXD5gH65wL1ORW
 CmkBJ1c22JcZMBuw=
X-Received: by 2002:a37:5fc4:: with SMTP id
 t187mr19917305qkb.484.1590276056501; 
 Sat, 23 May 2020 16:20:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEevV2OsO28OC8loTw1kMaASS5gPyKN6m4v/j1BfJtleDw39WnffPV7aPC3YbNzJ4Xnoq59g==
X-Received: by 2002:a37:5fc4:: with SMTP id
 t187mr19917287qkb.484.1590276056127; 
 Sat, 23 May 2020 16:20:56 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id m33sm11974235qtb.88.2020.05.23.16.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2020 16:20:55 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v3 11/11] KVM: Dirty ring support
Date: Sat, 23 May 2020 19:20:35 -0400
Message-Id: <20200523232035.1029349-12-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523232035.1029349-1-peterx@redhat.com>
References: <20200523232035.1029349-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/23 19:20:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

KVM dirty ring is a new interface to pass over dirty bits from kernel to the
userspace.  Instead of using a bitmap for each memory region, the dirty ring
contains an array of dirtied GPAs to fetch (in the form of offset in slots).
For each vcpu there will be one dirty ring that binds to it.

kvm_dirty_ring_reap() is the major function to collect dirty rings.  It can be
called either by a standalone reaper thread that runs in the background,
collecting dirty pages for the whole VM.  It can also be called directly by any
thread that has BQL taken.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c    | 331 ++++++++++++++++++++++++++++++++++++++++-
 accel/kvm/trace-events |   7 +
 include/hw/core/cpu.h  |   8 +
 3 files changed, 343 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index dd017d0720..b064e68040 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -15,6 +15,7 @@
 
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
+#include <poll.h>
 
 #include <linux/kvm.h>
 
@@ -76,6 +77,25 @@ struct KVMParkedVcpu {
     QLIST_ENTRY(KVMParkedVcpu) node;
 };
 
+enum KVMDirtyRingReaperState {
+    KVM_DIRTY_RING_REAPER_NONE = 0,
+    /* The reaper is sleeping */
+    KVM_DIRTY_RING_REAPER_WAIT,
+    /* The reaper is reaping for dirty pages */
+    KVM_DIRTY_RING_REAPER_REAPING,
+};
+
+/*
+ * KVM reaper instance, responsible for collecting the KVM dirty bits
+ * via the dirty ring.
+ */
+struct KVMDirtyRingReaper {
+    /* The reaper thread */
+    QemuThread reaper_thr;
+    volatile uint64_t reaper_iteration; /* iteration number of reaper thr */
+    volatile enum KVMDirtyRingReaperState reaper_state; /* reap thr state */
+};
+
 struct KVMState
 {
     AccelState parent_obj;
@@ -131,6 +151,7 @@ struct KVMState
     bool kvm_dirty_ring_enabled;    /* Whether KVM dirty ring is enabled */
     uint64_t kvm_dirty_ring_size;   /* Size of the per-vcpu dirty ring */
     uint32_t kvm_dirty_gfn_count;   /* Number of dirty GFNs per ring */
+    struct KVMDirtyRingReaper reaper;
 };
 
 KVMState *kvm_state;
@@ -362,6 +383,13 @@ int kvm_destroy_vcpu(CPUState *cpu)
         goto err;
     }
 
+    if (cpu->kvm_dirty_gfns) {
+        ret = munmap(cpu->kvm_dirty_gfns, s->kvm_dirty_ring_size);
+        if (ret < 0) {
+            goto err;
+        }
+    }
+
     vcpu = g_malloc0(sizeof(*vcpu));
     vcpu->vcpu_id = kvm_arch_vcpu_id(cpu);
     vcpu->kvm_fd = cpu->kvm_fd;
@@ -426,6 +454,19 @@ int kvm_init_vcpu(CPUState *cpu)
             (void *)cpu->kvm_run + s->coalesced_mmio * PAGE_SIZE;
     }
 
+    if (s->kvm_dirty_ring_enabled) {
+        /* Use MAP_SHARED to share pages with the kernel */
+        cpu->kvm_dirty_gfns = mmap(NULL, s->kvm_dirty_ring_size,
+                                   PROT_READ | PROT_WRITE, MAP_SHARED,
+                                   cpu->kvm_fd,
+                                   PAGE_SIZE * KVM_DIRTY_LOG_PAGE_OFFSET);
+        if (cpu->kvm_dirty_gfns == MAP_FAILED) {
+            ret = -errno;
+            DPRINTF("mmap'ing vcpu dirty gfns failed: %d\n", ret);
+            goto err;
+        }
+    }
+
     ret = kvm_arch_init_vcpu(cpu);
 err:
     return ret;
@@ -539,6 +580,11 @@ static void kvm_slot_sync_dirty_pages(KVMSlot *slot)
     cpu_physical_memory_set_dirty_lebitmap(slot->dirty_bmap, start, pages);
 }
 
+static void kvm_slot_reset_dirty_pages(KVMSlot *slot)
+{
+    memset(slot->dirty_bmap, 0, slot->dirty_bmap_size);
+}
+
 #define ALIGN(x, y)  (((x)+(y)-1) & ~((y)-1))
 
 /* Allocate the dirty bitmap for a slot  */
@@ -582,6 +628,170 @@ static void kvm_slot_get_dirty_log(KVMState *s, KVMSlot *slot)
     }
 }
 
+/* Should be with all slots_lock held for the address spaces. */
+static void kvm_dirty_ring_mark_page(KVMState *s, uint32_t as_id,
+                                     uint32_t slot_id, uint64_t offset)
+{
+    KVMMemoryListener *kml;
+    KVMSlot *mem;
+
+    if (as_id >= s->nr_as) {
+        return;
+    }
+
+    kml = s->as[as_id].ml;
+    mem = &kml->slots[slot_id];
+
+    if (!mem->memory_size || offset >= (mem->memory_size / TARGET_PAGE_SIZE)) {
+        return;
+    }
+
+    set_bit(offset, mem->dirty_bmap);
+}
+
+static bool dirty_gfn_is_dirtied(struct kvm_dirty_gfn *gfn)
+{
+    return gfn->flags == KVM_DIRTY_GFN_F_DIRTY;
+}
+
+static void dirty_gfn_set_collected(struct kvm_dirty_gfn *gfn)
+{
+    gfn->flags = KVM_DIRTY_GFN_F_RESET;
+}
+
+/*
+ * Should be with all slots_lock held for the address spaces.  It returns the
+ * dirty page we've collected on this dirty ring.
+ */
+static uint32_t kvm_dirty_ring_reap_one(KVMState *s, CPUState *cpu)
+{
+    struct kvm_dirty_gfn *dirty_gfns = cpu->kvm_dirty_gfns, *cur;
+    uint32_t gfn_count = s->kvm_dirty_gfn_count;
+    uint32_t count = 0, fetch = cpu->kvm_fetch_index;
+
+    assert(dirty_gfns && gfn_count);
+    trace_kvm_dirty_ring_reap_vcpu(cpu->cpu_index);
+
+    while (true) {
+        cur = &dirty_gfns[fetch % gfn_count];
+        if (!dirty_gfn_is_dirtied(cur)) {
+            break;
+        }
+        kvm_dirty_ring_mark_page(s, cur->slot >> 16, cur->slot & 0xffff,
+                                 cur->offset);
+        dirty_gfn_set_collected(cur);
+        trace_kvm_dirty_ring_page(cpu->cpu_index, fetch, cur->offset);
+        fetch++;
+        count++;
+    }
+    cpu->kvm_fetch_index = fetch;
+
+    return count;
+}
+
+/* Must be with slots_lock held */
+static uint64_t kvm_dirty_ring_reap_locked(KVMState *s)
+{
+    int ret;
+    CPUState *cpu;
+    uint64_t total = 0;
+    int64_t stamp;
+
+    stamp = get_clock();
+
+    CPU_FOREACH(cpu) {
+        total += kvm_dirty_ring_reap_one(s, cpu);
+    }
+
+    if (total) {
+        ret = kvm_vm_ioctl(s, KVM_RESET_DIRTY_RINGS);
+        assert(ret == total);
+    }
+
+    stamp = get_clock() - stamp;
+
+    if (total) {
+        trace_kvm_dirty_ring_reap(total, stamp / 1000);
+    }
+
+    return total;
+}
+
+/*
+ * Currently for simplicity, we must hold BQL before calling this.  We can
+ * consider to drop the BQL if we're clear with all the race conditions.
+ */
+static uint64_t kvm_dirty_ring_reap(KVMState *s)
+{
+    uint64_t total;
+
+    /*
+     * We need to lock all kvm slots for all address spaces here,
+     * because:
+     *
+     * (1) We need to mark dirty for dirty bitmaps in multiple slots
+     *     and for tons of pages, so it's better to take the lock here
+     *     once rather than once per page.  And more importantly,
+     *
+     * (2) We must _NOT_ publish dirty bits to the other threads
+     *     (e.g., the migration thread) via the kvm memory slot dirty
+     *     bitmaps before correctly re-protect those dirtied pages.
+     *     Otherwise we can have potential risk of data corruption if
+     *     the page data is read in the other thread before we do
+     *     reset below.
+     */
+    kvm_slots_lock();
+    total = kvm_dirty_ring_reap_locked(s);
+    kvm_slots_unlock();
+
+    return total;
+}
+
+static void do_kvm_cpu_synchronize_kick(CPUState *cpu, run_on_cpu_data arg)
+{
+    /* No need to do anything */
+}
+
+/*
+ * Kick all vcpus out in a synchronized way.  When returned, we
+ * guarantee that every vcpu has been kicked and at least returned to
+ * userspace once.
+ */
+static void kvm_cpu_synchronize_kick_all(void)
+{
+    CPUState *cpu;
+
+    CPU_FOREACH(cpu) {
+        run_on_cpu(cpu, do_kvm_cpu_synchronize_kick, RUN_ON_CPU_NULL);
+    }
+}
+
+/*
+ * Flush all the existing dirty pages to the KVM slot buffers.  When
+ * this call returns, we guarantee that all the touched dirty pages
+ * before calling this function have been put into the per-kvmslot
+ * dirty bitmap.
+ *
+ * This function must be called with BQL held.
+ */
+static void kvm_dirty_ring_flush(struct KVMDirtyRingReaper *r)
+{
+    trace_kvm_dirty_ring_flush(0);
+    /*
+     * The function needs to be serialized.  Since this function
+     * should always be with BQL held, serialization is guaranteed.
+     * However, let's be sure of it.
+     */
+    assert(qemu_mutex_iothread_locked());
+    /*
+     * First make sure to flush the hardware buffers by kicking all
+     * vcpus out in a synchronous way.
+     */
+    kvm_cpu_synchronize_kick_all();
+    kvm_dirty_ring_reap(kvm_state);
+    trace_kvm_dirty_ring_flush(1);
+}
+
 /**
  * kvm_physical_sync_dirty_bitmap - Sync dirty bitmap from kernel space
  *
@@ -1103,7 +1313,24 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
                 goto out;
             }
             if (mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
-                kvm_slot_get_dirty_log(kvm_state, mem);
+                /*
+                 * NOTE: We should be aware of the fact that here we're only
+                 * doing a best effort to sync dirty bits.  No matter whether
+                 * we're using dirty log or dirty ring, we ignored two facts:
+                 *
+                 * (1) dirty bits can reside in hardware buffers (PML)
+                 *
+                 * (2) after we collected dirty bits here, pages can be dirtied
+                 * again before we do the final KVM_SET_USER_MEMORY_REGION to
+                 * remove the slot.
+                 *
+                 * Not easy.  Let's cross the fingers until it's fixed.
+                 */
+                if (kvm_state->kvm_dirty_ring_enabled) {
+                    kvm_dirty_ring_reap_locked(kvm_state);
+                } else {
+                    kvm_slot_get_dirty_log(kvm_state, mem);
+                }
                 kvm_slot_sync_dirty_pages(mem);
             }
 
@@ -1151,6 +1378,51 @@ out:
     kvm_slots_unlock();
 }
 
+static void *kvm_dirty_ring_reaper_thread(void *data)
+{
+    KVMState *s = data;
+    struct KVMDirtyRingReaper *r = &s->reaper;
+
+    rcu_register_thread();
+
+    trace_kvm_dirty_ring_reaper("init");
+
+    while (true) {
+        r->reaper_state = KVM_DIRTY_RING_REAPER_WAIT;
+        trace_kvm_dirty_ring_reaper("wait");
+        /*
+         * TODO: provide a smarter timeout rather than a constant?
+         */
+        sleep(1);
+
+        trace_kvm_dirty_ring_reaper("wakeup");
+        r->reaper_state = KVM_DIRTY_RING_REAPER_REAPING;
+
+        qemu_mutex_lock_iothread();
+        kvm_dirty_ring_reap(s);
+        qemu_mutex_unlock_iothread();
+
+        r->reaper_iteration++;
+    }
+
+    trace_kvm_dirty_ring_reaper("exit");
+
+    rcu_unregister_thread();
+
+    return NULL;
+}
+
+static int kvm_dirty_ring_reaper_init(KVMState *s)
+{
+    struct KVMDirtyRingReaper *r = &s->reaper;
+
+    qemu_thread_create(&r->reaper_thr, "kvm-reaper",
+                       kvm_dirty_ring_reaper_thread,
+                       s, QEMU_THREAD_JOINABLE);
+
+    return 0;
+}
+
 static void kvm_region_add(MemoryListener *listener,
                            MemoryRegionSection *section)
 {
@@ -1179,6 +1451,36 @@ static void kvm_log_sync(MemoryListener *listener,
     kvm_slots_unlock();
 }
 
+static void kvm_log_sync_global(MemoryListener *l)
+{
+    KVMMemoryListener *kml = container_of(l, KVMMemoryListener, listener);
+    KVMState *s = kvm_state;
+    KVMSlot *mem;
+    int i;
+
+    /* Flush all kernel dirty addresses into KVMSlot dirty bitmap */
+    kvm_dirty_ring_flush(&s->reaper);
+
+    /*
+     * TODO: make this faster when nr_slots is big while there are
+     * only a few used slots (small VMs).
+     */
+    kvm_slots_lock();
+    for (i = 0; i < s->nr_slots; i++) {
+        mem = &kml->slots[i];
+        if (mem->memory_size && mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
+            kvm_slot_sync_dirty_pages(mem);
+            /*
+             * This is not needed by KVM_GET_DIRTY_LOG because the
+             * ioctl will unconditionally overwrite the whole region.
+             * However kvm dirty ring has no such side effect.
+             */
+            kvm_slot_reset_dirty_pages(mem);
+        }
+    }
+    kvm_slots_unlock();
+}
+
 static void kvm_log_clear(MemoryListener *listener,
                           MemoryRegionSection *section)
 {
@@ -1285,10 +1587,15 @@ void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
     kml->listener.region_del = kvm_region_del;
     kml->listener.log_start = kvm_log_start;
     kml->listener.log_stop = kvm_log_stop;
-    kml->listener.log_sync = kvm_log_sync;
-    kml->listener.log_clear = kvm_log_clear;
     kml->listener.priority = 10;
 
+    if (s->kvm_dirty_ring_enabled) {
+        kml->listener.log_sync_global = kvm_log_sync_global;
+    } else {
+        kml->listener.log_sync = kvm_log_sync;
+        kml->listener.log_clear = kvm_log_clear;
+    }
+
     memory_listener_register(&kml->listener, as);
 
     for (i = 0; i < s->nr_as; ++i) {
@@ -2180,6 +2487,13 @@ static int kvm_init(MachineState *ms)
         qemu_balloon_inhibit(true);
     }
 
+    if (s->kvm_dirty_ring_enabled) {
+        ret = kvm_dirty_ring_reaper_init(s);
+        if (ret) {
+            goto err;
+        }
+    }
+
     return 0;
 
 err:
@@ -2487,6 +2801,17 @@ int kvm_cpu_exec(CPUState *cpu)
         case KVM_EXIT_INTERNAL_ERROR:
             ret = kvm_handle_internal_error(cpu, run);
             break;
+        case KVM_EXIT_DIRTY_RING_FULL:
+            /*
+             * We shouldn't continue if the dirty ring of this vcpu is
+             * still full.  Got kicked by KVM_RESET_DIRTY_RINGS.
+             */
+            trace_kvm_dirty_ring_full(cpu->cpu_index);
+            qemu_mutex_lock_iothread();
+            kvm_dirty_ring_reap(kvm_state);
+            qemu_mutex_unlock_iothread();
+            ret = 0;
+            break;
         case KVM_EXIT_SYSTEM_EVENT:
             switch (run->system_event.type) {
             case KVM_SYSTEM_EVENT_SHUTDOWN:
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index 4fb6e59d19..89ef99569f 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -16,4 +16,11 @@ kvm_set_ioeventfd_mmio(int fd, uint64_t addr, uint32_t val, bool assign, uint32_
 kvm_set_ioeventfd_pio(int fd, uint16_t addr, uint32_t val, bool assign, uint32_t size, bool datamatch) "fd: %d @0x%x val=0x%x assign: %d size: %d match: %d"
 kvm_set_user_memory(uint32_t slot, uint32_t flags, uint64_t guest_phys_addr, uint64_t memory_size, uint64_t userspace_addr, int ret) "Slot#%d flags=0x%x gpa=0x%"PRIx64 " size=0x%"PRIx64 " ua=0x%"PRIx64 " ret=%d"
 kvm_clear_dirty_log(uint32_t slot, uint64_t start, uint32_t size) "slot#%"PRId32" start 0x%"PRIx64" size 0x%"PRIx32
+kvm_dirty_ring_full(int id) "vcpu %d"
+kvm_dirty_ring_reap_vcpu(int id) "vcpu %d"
+kvm_dirty_ring_page(int vcpu, uint32_t slot, uint64_t offset) "vcpu %d fetch %"PRIu32" offset 0x%"PRIx64
+kvm_dirty_ring_reaper(const char *s) "%s"
+kvm_dirty_ring_reap(uint64_t count, int64_t t) "reaped %"PRIu64" pages (took %"PRIi64" us)"
+kvm_dirty_ring_reaper_kick(const char *reason) "%s"
+kvm_dirty_ring_flush(int finished) "%d"
 
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index a998dc2620..ed8ea59eb5 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -340,6 +340,11 @@ struct qemu_work_item;
  * @ignore_memory_transaction_failures: Cached copy of the MachineState
  *    flag of the same name: allows the board to suppress calling of the
  *    CPU do_transaction_failed hook function.
+ * @kvm_dirty_ring_full:
+ *   Whether the kvm dirty ring of this vcpu is soft-full.
+ * @kvm_dirty_ring_avail:
+ *   Semaphore to be posted when the kvm dirty ring of the vcpu is
+ *   available again.
  *
  * State of one CPU core or thread.
  */
@@ -407,9 +412,12 @@ struct CPUState {
      */
     uintptr_t mem_io_pc;
 
+    /* Only used in KVM */
     int kvm_fd;
     struct KVMState *kvm_state;
     struct kvm_run *kvm_run;
+    struct kvm_dirty_gfn *kvm_dirty_gfns;
+    uint32_t kvm_fetch_index;
 
     /* Used for events with 'vcpu' and *without* the 'disabled' properties */
     DECLARE_BITMAP(trace_dstate_delayed, CPU_TRACE_DSTATE_MAX_EVENTS);
-- 
2.26.2


