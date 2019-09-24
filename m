Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC179C432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:47:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AA3C214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA3C214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCn2M-0006yf-11
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 11:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iCm6o-0007ro-N4
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 10:48:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iCm6n-0003wD-6s
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 10:48:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45780)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1iCm6m-0003ve-Uw; Tue, 24 Sep 2019 10:48:05 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 41CDE7DD11;
 Tue, 24 Sep 2019 14:48:04 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 953AF10013D9;
 Tue, 24 Sep 2019 14:48:02 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 1/4] kvm: extract kvm_log_clear_one_slot
Date: Tue, 24 Sep 2019 10:47:48 -0400
Message-Id: <20190924144751.24149-2-imammedo@redhat.com>
In-Reply-To: <20190924144751.24149-1-imammedo@redhat.com>
References: <20190924144751.24149-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 24 Sep 2019 14:48:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com, peterx@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

We may need to clear the dirty bitmap for more than one KVM memslot.
First do some code movement with no semantic change.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c | 102 ++++++++++++++++++++++++--------------------
 1 file changed, 56 insertions(+), 46 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b09bad0804..e9e6086c09 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -575,55 +575,13 @@ out:
 #define KVM_CLEAR_LOG_ALIGN  (qemu_real_host_page_size << KVM_CLEAR_LOG_SHIFT)
 #define KVM_CLEAR_LOG_MASK   (-KVM_CLEAR_LOG_ALIGN)
 
-/**
- * kvm_physical_log_clear - Clear the kernel's dirty bitmap for range
- *
- * NOTE: this will be a no-op if we haven't enabled manual dirty log
- * protection in the host kernel because in that case this operation
- * will be done within log_sync().
- *
- * @kml:     the kvm memory listener
- * @section: the memory range to clear dirty bitmap
- */
-static int kvm_physical_log_clear(KVMMemoryListener *kml,
-                                  MemoryRegionSection *section)
+static int kvm_log_clear_one_slot(KVMSlot *mem, int as_id, uint64_t start, uint64_t size)
 {
     KVMState *s = kvm_state;
+    uint64_t end, bmap_start, start_delta, bmap_npages;
     struct kvm_clear_dirty_log d;
-    uint64_t start, end, bmap_start, start_delta, bmap_npages, size;
     unsigned long *bmap_clear = NULL, psize = qemu_real_host_page_size;
-    KVMSlot *mem = NULL;
-    int ret, i;
-
-    if (!s->manual_dirty_log_protect) {
-        /* No need to do explicit clear */
-        return 0;
-    }
-
-    start = section->offset_within_address_space;
-    size = int128_get64(section->size);
-
-    if (!size) {
-        /* Nothing more we can do... */
-        return 0;
-    }
-
-    kvm_slots_lock(kml);
-
-    /* Find any possible slot that covers the section */
-    for (i = 0; i < s->nr_slots; i++) {
-        mem = &kml->slots[i];
-        if (mem->start_addr <= start &&
-            start + size <= mem->start_addr + mem->memory_size) {
-            break;
-        }
-    }
-
-    /*
-     * We should always find one memslot until this point, otherwise
-     * there could be something wrong from the upper layer
-     */
-    assert(mem && i != s->nr_slots);
+    int ret;
 
     /*
      * We need to extend either the start or the size or both to
@@ -694,7 +652,7 @@ static int kvm_physical_log_clear(KVMMemoryListener *kml,
     /* It should never overflow.  If it happens, say something */
     assert(bmap_npages <= UINT32_MAX);
     d.num_pages = bmap_npages;
-    d.slot = mem->slot | (kml->as_id << 16);
+    d.slot = mem->slot | (as_id << 16);
 
     if (kvm_vm_ioctl(s, KVM_CLEAR_DIRTY_LOG, &d) == -1) {
         ret = -errno;
@@ -717,6 +675,58 @@ static int kvm_physical_log_clear(KVMMemoryListener *kml,
                  size / psize);
     /* This handles the NULL case well */
     g_free(bmap_clear);
+    return ret;
+}
+
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
+    KVMState *s = kvm_state;
+    uint64_t start, size;
+    KVMSlot *mem = NULL;
+    int ret, i;
+
+    if (!s->manual_dirty_log_protect) {
+        /* No need to do explicit clear */
+        return 0;
+    }
+
+    start = section->offset_within_address_space;
+    size = int128_get64(section->size);
+
+    if (!size) {
+        /* Nothing more we can do... */
+        return 0;
+    }
+
+    kvm_slots_lock(kml);
+
+    /* Find any possible slot that covers the section */
+    for (i = 0; i < s->nr_slots; i++) {
+        mem = &kml->slots[i];
+        if (mem->start_addr <= start &&
+            start + size <= mem->start_addr + mem->memory_size) {
+            break;
+        }
+    }
+
+    /*
+     * We should always find one memslot until this point, otherwise
+     * there could be something wrong from the upper layer
+     */
+    assert(mem && i != s->nr_slots);
+    ret = kvm_log_clear_one_slot(mem, kml->as_id, start, size);
 
     kvm_slots_unlock(kml);
 
-- 
2.18.1


