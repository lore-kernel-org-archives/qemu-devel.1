Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76B2C43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ED2E208DB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VQSLI5zI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED2E208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJfny-0005TK-Fm
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 12:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfHd-0005mV-3d
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 12:00:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36641
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfHQ-0007Vf-Tq
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 12:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600531203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0oqdwKIol3TeyBC9JBnbi8HPeCxqWfu6IT9P7TbZoq0=;
 b=VQSLI5zI/d01/nobfdtw64Hb4qO+i1Joyr3MzfhytZ8Anx3uTJPW1rq6OxoIFZXHiJlUcK
 PWaEqmH7jgnZQRb/+TxsmU1CCvh/HjxybwcQbzN2kncz9ZYld4e6Wb2Nt3xx0bMKFmoHca
 8I+TKDdeEE+/lJUU48eJBuU4lJQD1ig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-ayFlRcZcMi2Ir6mL-v_z1g-1; Sat, 19 Sep 2020 11:59:59 -0400
X-MC-Unique: ayFlRcZcMi2Ir6mL-v_z1g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05F411074644;
 Sat, 19 Sep 2020 15:59:58 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C9DF1002388;
 Sat, 19 Sep 2020 15:59:54 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 55/57] exec: Remove MemoryRegion::global_locking field
Date: Sat, 19 Sep 2020 11:59:14 -0400
Message-Id: <20200919155916.1046398-56-pbonzini@redhat.com>
In-Reply-To: <20200919155916.1046398-1-pbonzini@redhat.com>
References: <20200919155916.1046398-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 11:59:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Last uses of memory_region_clear_global_locking() have been
removed in commit 7070e085d4 ("acpi: mark PMTIMER as unlocked")
and commit 08565552f7 ("cputlb: Move NOTDIRTY handling from I/O
path to TLB path").
Remove memory_region_clear_global_locking() and the now unused
'global_locking' field in MemoryRegion.

Reported-by: Alexander Bulekov <alxndr@bu.edu>
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200806150726.962-1-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/cputlb.c    |  4 ++--
 exec.c                |  2 +-
 include/exec/memory.h | 14 --------------
 softmmu/memory.c      |  6 ------
 4 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 6489abbf8c..4657a3b8a6 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1053,7 +1053,7 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
         cpu_io_recompile(cpu, retaddr);
     }
 
-    if (mr->global_locking && !qemu_mutex_iothread_locked()) {
+    if (!qemu_mutex_iothread_locked()) {
         qemu_mutex_lock_iothread();
         locked = true;
     }
@@ -1114,7 +1114,7 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
      */
     save_iotlb_data(cpu, iotlbentry->addr, section, mr_offset);
 
-    if (mr->global_locking && !qemu_mutex_iothread_locked()) {
+    if (!qemu_mutex_iothread_locked()) {
         qemu_mutex_lock_iothread();
         locked = true;
     }
diff --git a/exec.c b/exec.c
index e34b602bdf..bc55a92292 100644
--- a/exec.c
+++ b/exec.c
@@ -3136,7 +3136,7 @@ static bool prepare_mmio_access(MemoryRegion *mr)
     bool unlocked = !qemu_mutex_iothread_locked();
     bool release_lock = false;
 
-    if (unlocked && mr->global_locking) {
+    if (unlocked) {
         qemu_mutex_lock_iothread();
         unlocked = false;
         release_lock = true;
diff --git a/include/exec/memory.h b/include/exec/memory.h
index ec9edee742..9f6468f346 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -404,7 +404,6 @@ struct MemoryRegion {
     bool nonvolatile;
     bool rom_device;
     bool flush_coalesced_mmio;
-    bool global_locking;
     uint8_t dirty_log_mask;
     bool is_iommu;
     RAMBlock *ram_block;
@@ -1738,19 +1737,6 @@ void memory_region_set_flush_coalesced(MemoryRegion *mr);
  */
 void memory_region_clear_flush_coalesced(MemoryRegion *mr);
 
-/**
- * memory_region_clear_global_locking: Declares that access processing does
- *                                     not depend on the QEMU global lock.
- *
- * By clearing this property, accesses to the memory region will be processed
- * outside of QEMU's global lock (unless the lock is held on when issuing the
- * access request). In this case, the device model implementing the access
- * handlers is responsible for synchronization of concurrency.
- *
- * @mr: the memory region to be updated.
- */
-void memory_region_clear_global_locking(MemoryRegion *mr);
-
 /**
  * memory_region_add_eventfd: Request an eventfd to be triggered when a word
  *                            is written to a location.
diff --git a/softmmu/memory.c b/softmmu/memory.c
index d030eb6f7c..31b0c5250e 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -1221,7 +1221,6 @@ static void memory_region_initfn(Object *obj)
     mr->ops = &unassigned_mem_ops;
     mr->enabled = true;
     mr->romd_mode = true;
-    mr->global_locking = true;
     mr->destructor = memory_region_destructor_none;
     QTAILQ_INIT(&mr->subregions);
     QTAILQ_INIT(&mr->coalesced);
@@ -2277,11 +2276,6 @@ void memory_region_clear_flush_coalesced(MemoryRegion *mr)
     }
 }
 
-void memory_region_clear_global_locking(MemoryRegion *mr)
-{
-    mr->global_locking = false;
-}
-
 static bool userspace_eventfd_warning;
 
 void memory_region_add_eventfd(MemoryRegion *mr,
-- 
2.26.2



