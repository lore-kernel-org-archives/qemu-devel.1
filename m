Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6925BC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E682207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E682207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCm9P-0001mY-88
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 10:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iCm6u-0007ww-9q
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 10:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iCm6t-0003zk-0I
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 10:48:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41050)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1iCm6s-0003zM-NM; Tue, 24 Sep 2019 10:48:10 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 06A37302246D;
 Tue, 24 Sep 2019 14:48:10 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8474910013D9;
 Tue, 24 Sep 2019 14:48:04 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 2/4] kvm: clear dirty bitmaps from all overlapping memslots
Date: Tue, 24 Sep 2019 10:47:49 -0400
Message-Id: <20190924144751.24149-3-imammedo@redhat.com>
In-Reply-To: <20190924144751.24149-1-imammedo@redhat.com>
References: <20190924144751.24149-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 24 Sep 2019 14:48:10 +0000 (UTC)
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

Currently MemoryRegionSection has 1:1 mapping to KVMSlot.
However next patch will allow splitting MemoryRegionSection into
several KVMSlot-s, make sure that kvm_physical_log_slot_clear()
is able to handle such 1:N mapping.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index e9e6086c09..315a91557f 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -588,8 +588,8 @@ static int kvm_log_clear_one_slot(KVMSlot *mem, int as_id, uint64_t start, uint6
      * satisfy the KVM interface requirement.  Firstly, do the start
      * page alignment on 64 host pages
      */
-    bmap_start = (start - mem->start_addr) & KVM_CLEAR_LOG_MASK;
-    start_delta = start - mem->start_addr - bmap_start;
+    bmap_start = start & KVM_CLEAR_LOG_MASK;
+    start_delta = start - bmap_start;
     bmap_start /= psize;
 
     /*
@@ -693,8 +693,8 @@ static int kvm_physical_log_clear(KVMMemoryListener *kml,
                                   MemoryRegionSection *section)
 {
     KVMState *s = kvm_state;
-    uint64_t start, size;
-    KVMSlot *mem = NULL;
+    uint64_t start, size, offset, count;
+    KVMSlot *mem;
     int ret, i;
 
     if (!s->manual_dirty_log_protect) {
@@ -712,22 +712,30 @@ static int kvm_physical_log_clear(KVMMemoryListener *kml,
 
     kvm_slots_lock(kml);
 
-    /* Find any possible slot that covers the section */
     for (i = 0; i < s->nr_slots; i++) {
         mem = &kml->slots[i];
-        if (mem->start_addr <= start &&
-            start + size <= mem->start_addr + mem->memory_size) {
+        /* Discard slots that are empty or do not overlap the section */
+        if (!mem->memory_size ||
+            mem->start_addr > start + size - 1 ||
+            start > mem->start_addr + mem->memory_size - 1) {
+            continue;
+        }
+
+        if (start >= mem->start_addr) {
+            /* The slot starts before section or is aligned to it.  */
+            offset = start - mem->start_addr;
+            count = MIN(mem->memory_size - offset, size);
+        } else {
+            /* The slot starts after section.  */
+            offset = 0;
+            count = MIN(mem->memory_size, size - (mem->start_addr - start));
+        }
+        ret = kvm_log_clear_one_slot(mem, kml->as_id, offset, count);
+        if (ret < 0) {
             break;
         }
     }
 
-    /*
-     * We should always find one memslot until this point, otherwise
-     * there could be something wrong from the upper layer
-     */
-    assert(mem && i != s->nr_slots);
-    ret = kvm_log_clear_one_slot(mem, kml->as_id, start, size);
-
     kvm_slots_unlock(kml);
 
     return ret;
-- 
2.18.1


