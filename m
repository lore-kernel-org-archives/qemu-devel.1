Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CACC742C2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 14:36:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 993B4206B8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 14:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993B4206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50119 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlwev-0002uD-OA
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 10:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45090)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hlwbZ-000689-89
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:32:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hlwbX-0001zo-GC
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:32:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36318)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hlwbX-0001zX-8K
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:32:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 875E7C04AC70;
 Fri, 12 Jul 2019 14:32:54 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.36.118.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 75A126092E;
 Fri, 12 Jul 2019 14:32:52 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 12 Jul 2019 16:32:05 +0200
Message-Id: <20190712143207.4214-18-quintela@redhat.com>
In-Reply-To: <20190712143207.4214-1-quintela@redhat.com>
References: <20190712143207.4214-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 12 Jul 2019 14:32:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 17/19] kvm: Support KVM_CLEAR_DIRTY_LOG
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 kvm@vger.kernel.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Xu <peterx@redhat.com>

Firstly detect the interface using KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2
and mark it.  When failed to enable the new feature we'll fall back to
the old sync.

Provide the log_clear() hook for the memory listeners for both address
spaces of KVM (normal system memory, and SMM) and deliever the clear
message to kernel.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20190603065056.25211-11-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 accel/kvm/kvm-all.c    | 182 +++++++++++++++++++++++++++++++++++++++++
 accel/kvm/trace-events |   1 +
 2 files changed, 183 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 621c9a43ab..35ea3cb624 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -91,6 +91,7 @@ struct KVMState
     int many_ioeventfds;
     int intx_set_mask;
     bool sync_mmu;
+    bool manual_dirty_log_protect;
     /* The man page (and posix) say ioctl numbers are signed int, but
      * they're not.  Linux, glibc and *BSD all treat ioctl numbers as
      * unsigned, and treating them as signed here can break things */
@@ -560,6 +561,159 @@ out:
     return ret;
 }
=20
+/* Alignment requirement for KVM_CLEAR_DIRTY_LOG - 64 pages */
+#define KVM_CLEAR_LOG_SHIFT  6
+#define KVM_CLEAR_LOG_ALIGN  (qemu_real_host_page_size << KVM_CLEAR_LOG_=
SHIFT)
+#define KVM_CLEAR_LOG_MASK   (-KVM_CLEAR_LOG_ALIGN)
+
+/**
+ * kvm_physical_log_clear - Clear the kernel's dirty bitmap for range
+ *
+ * NOTE: this will be a no-op if we haven't enabled manual dirty log
+ * protection in the host kernel because in that case this operation
+ * will be done within log_sync().
+ *
+ * @kml:     the kvm memory listener
+ * @section: the memory range to clear dirty bitmap
+ */
+static int kvm_physical_log_clear(KVMMemoryListener *kml,
+                                  MemoryRegionSection *section)
+{
+    KVMState *s =3D kvm_state;
+    struct kvm_clear_dirty_log d;
+    uint64_t start, end, bmap_start, start_delta, bmap_npages, size;
+    unsigned long *bmap_clear =3D NULL, psize =3D qemu_real_host_page_si=
ze;
+    KVMSlot *mem =3D NULL;
+    int ret, i;
+
+    if (!s->manual_dirty_log_protect) {
+        /* No need to do explicit clear */
+        return 0;
+    }
+
+    start =3D section->offset_within_address_space;
+    size =3D int128_get64(section->size);
+
+    if (!size) {
+        /* Nothing more we can do... */
+        return 0;
+    }
+
+    kvm_slots_lock(kml);
+
+    /* Find any possible slot that covers the section */
+    for (i =3D 0; i < s->nr_slots; i++) {
+        mem =3D &kml->slots[i];
+        if (mem->start_addr <=3D start &&
+            start + size <=3D mem->start_addr + mem->memory_size) {
+            break;
+        }
+    }
+
+    /*
+     * We should always find one memslot until this point, otherwise
+     * there could be something wrong from the upper layer
+     */
+    assert(mem && i !=3D s->nr_slots);
+
+    /*
+     * We need to extend either the start or the size or both to
+     * satisfy the KVM interface requirement.  Firstly, do the start
+     * page alignment on 64 host pages
+     */
+    bmap_start =3D (start - mem->start_addr) & KVM_CLEAR_LOG_MASK;
+    start_delta =3D start - mem->start_addr - bmap_start;
+    bmap_start /=3D psize;
+
+    /*
+     * The kernel interface has restriction on the size too, that either=
:
+     *
+     * (1) the size is 64 host pages aligned (just like the start), or
+     * (2) the size fills up until the end of the KVM memslot.
+     */
+    bmap_npages =3D DIV_ROUND_UP(size + start_delta, KVM_CLEAR_LOG_ALIGN=
)
+        << KVM_CLEAR_LOG_SHIFT;
+    end =3D mem->memory_size / psize;
+    if (bmap_npages > end - bmap_start) {
+        bmap_npages =3D end - bmap_start;
+    }
+    start_delta /=3D psize;
+
+    /*
+     * Prepare the bitmap to clear dirty bits.  Here we must guarantee
+     * that we won't clear any unknown dirty bits otherwise we might
+     * accidentally clear some set bits which are not yet synced from
+     * the kernel into QEMU's bitmap, then we'll lose track of the
+     * guest modifications upon those pages (which can directly lead
+     * to guest data loss or panic after migration).
+     *
+     * Layout of the KVMSlot.dirty_bmap:
+     *
+     *                   |<-------- bmap_npages -----------..>|
+     *                                                     [1]
+     *                     start_delta         size
+     *  |----------------|-------------|------------------|------------|
+     *  ^                ^             ^                               ^
+     *  |                |             |                               |
+     * start          bmap_start     (start)                         end
+     * of memslot                                             of memslot
+     *
+     * [1] bmap_npages can be aligned to either 64 pages or the end of s=
lot
+     */
+
+    assert(bmap_start % BITS_PER_LONG =3D=3D 0);
+    /* We should never do log_clear before log_sync */
+    assert(mem->dirty_bmap);
+    if (start_delta) {
+        /* Slow path - we need to manipulate a temp bitmap */
+        bmap_clear =3D bitmap_new(bmap_npages);
+        bitmap_copy_with_src_offset(bmap_clear, mem->dirty_bmap,
+                                    bmap_start, start_delta + size / psi=
ze);
+        /*
+         * We need to fill the holes at start because that was not
+         * specified by the caller and we extended the bitmap only for
+         * 64 pages alignment
+         */
+        bitmap_clear(bmap_clear, 0, start_delta);
+        d.dirty_bitmap =3D bmap_clear;
+    } else {
+        /* Fast path - start address aligns well with BITS_PER_LONG */
+        d.dirty_bitmap =3D mem->dirty_bmap + BIT_WORD(bmap_start);
+    }
+
+    d.first_page =3D bmap_start;
+    /* It should never overflow.  If it happens, say something */
+    assert(bmap_npages <=3D UINT32_MAX);
+    d.num_pages =3D bmap_npages;
+    d.slot =3D mem->slot | (kml->as_id << 16);
+
+    if (kvm_vm_ioctl(s, KVM_CLEAR_DIRTY_LOG, &d) =3D=3D -1) {
+        ret =3D -errno;
+        error_report("%s: KVM_CLEAR_DIRTY_LOG failed, slot=3D%d, "
+                     "start=3D0x%"PRIx64", size=3D0x%"PRIx32", errno=3D%=
d",
+                     __func__, d.slot, (uint64_t)d.first_page,
+                     (uint32_t)d.num_pages, ret);
+    } else {
+        ret =3D 0;
+        trace_kvm_clear_dirty_log(d.slot, d.first_page, d.num_pages);
+    }
+
+    /*
+     * After we have updated the remote dirty bitmap, we update the
+     * cached bitmap as well for the memslot, then if another user
+     * clears the same region we know we shouldn't clear it again on
+     * the remote otherwise it's data loss as well.
+     */
+    bitmap_clear(mem->dirty_bmap, bmap_start + start_delta,
+                 size / psize);
+    /* This handles the NULL case well */
+    g_free(bmap_clear);
+
+    kvm_slots_unlock(kml);
+
+    return ret;
+}
+
 static void kvm_coalesce_mmio_region(MemoryListener *listener,
                                      MemoryRegionSection *secion,
                                      hwaddr start, hwaddr size)
@@ -894,6 +1048,22 @@ static void kvm_log_sync(MemoryListener *listener,
     }
 }
=20
+static void kvm_log_clear(MemoryListener *listener,
+                          MemoryRegionSection *section)
+{
+    KVMMemoryListener *kml =3D container_of(listener, KVMMemoryListener,=
 listener);
+    int r;
+
+    r =3D kvm_physical_log_clear(kml, section);
+    if (r < 0) {
+        error_report_once("%s: kvm log clear failed: mr=3D%s "
+                          "offset=3D%"HWADDR_PRIx" size=3D%"PRIx64, __fu=
nc__,
+                          section->mr->name, section->offset_within_regi=
on,
+                          int128_get64(section->size));
+        abort();
+    }
+}
+
 static void kvm_mem_ioeventfd_add(MemoryListener *listener,
                                   MemoryRegionSection *section,
                                   bool match_data, uint64_t data,
@@ -985,6 +1155,7 @@ void kvm_memory_listener_register(KVMState *s, KVMMe=
moryListener *kml,
     kml->listener.log_start =3D kvm_log_start;
     kml->listener.log_stop =3D kvm_log_stop;
     kml->listener.log_sync =3D kvm_log_sync;
+    kml->listener.log_clear =3D kvm_log_clear;
     kml->listener.priority =3D 10;
=20
     memory_listener_register(&kml->listener, as);
@@ -1709,6 +1880,17 @@ static int kvm_init(MachineState *ms)
     s->coalesced_pio =3D s->coalesced_mmio &&
                        kvm_check_extension(s, KVM_CAP_COALESCED_PIO);
=20
+    s->manual_dirty_log_protect =3D
+        kvm_check_extension(s, KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2);
+    if (s->manual_dirty_log_protect) {
+        ret =3D kvm_vm_enable_cap(s, KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2, =
0, 1);
+        if (ret) {
+            warn_report("Trying to enable KVM_CAP_MANUAL_DIRTY_LOG_PROTE=
CT2 "
+                        "but failed.  Falling back to the legacy mode. "=
);
+            s->manual_dirty_log_protect =3D false;
+        }
+    }
+
 #ifdef KVM_CAP_VCPU_EVENTS
     s->vcpu_events =3D kvm_check_extension(s, KVM_CAP_VCPU_EVENTS);
 #endif
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index 33c5b1b3af..4fb6e59d19 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -15,4 +15,5 @@ kvm_irqchip_release_virq(int virq) "virq %d"
 kvm_set_ioeventfd_mmio(int fd, uint64_t addr, uint32_t val, bool assign,=
 uint32_t size, bool datamatch) "fd: %d @0x%" PRIx64 " val=3D0x%x assign:=
 %d size: %d match: %d"
 kvm_set_ioeventfd_pio(int fd, uint16_t addr, uint32_t val, bool assign, =
uint32_t size, bool datamatch) "fd: %d @0x%x val=3D0x%x assign: %d size: =
%d match: %d"
 kvm_set_user_memory(uint32_t slot, uint32_t flags, uint64_t guest_phys_a=
ddr, uint64_t memory_size, uint64_t userspace_addr, int ret) "Slot#%d fla=
gs=3D0x%x gpa=3D0x%"PRIx64 " size=3D0x%"PRIx64 " ua=3D0x%"PRIx64 " ret=3D=
%d"
+kvm_clear_dirty_log(uint32_t slot, uint64_t start, uint32_t size) "slot#=
%"PRId32" start 0x%"PRIx64" size 0x%"PRIx32
=20
--=20
2.21.0


