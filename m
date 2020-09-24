Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DC4C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:05:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30D392067B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A3Xp9N1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D392067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLO8Q-0002W4-16
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 06:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTx-0001Wo-W6
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:24:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24318)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTw-00067o-27
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0oqdwKIol3TeyBC9JBnbi8HPeCxqWfu6IT9P7TbZoq0=;
 b=A3Xp9N1K0C5XAbOtvroixgkf+JUSVnmDExxpScqofm4+zAcDOPlf7HwQCZO7bx29PpHBDf
 OEoyFrcq6nCnC0uoxOaJqVLeLjXE7pp53fq81XZ5GFJdOtD2HREzE+Hj1YB0DK9ba5ew4u
 Pp0aizgvuXKFvVkjBBZsbK18chnWq3w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-pBiIW4bVN2WJY6-9mV_49g-1; Thu, 24 Sep 2020 05:24:01 -0400
X-MC-Unique: pBiIW4bVN2WJY6-9mV_49g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BD2581F00B;
 Thu, 24 Sep 2020 09:24:00 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 111775C269;
 Thu, 24 Sep 2020 09:23:54 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 53/92] exec: Remove MemoryRegion::global_locking field
Date: Thu, 24 Sep 2020 05:22:35 -0400
Message-Id: <20200924092314.1722645-54-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



