Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D46DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 15:08:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3442223133
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 15:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ap1bCHSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3442223133
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3hV6-0002Iy-5Y
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 11:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3hUY-0001tW-4N
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 11:07:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38975
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3hUW-0006vV-9f
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 11:07:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596726455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Yd8B73Gw4cOJwIA3rbelMxUQY6v/oFJycgT7kd1G4t0=;
 b=Ap1bCHSelXpBFUcJPaAgbstUoH2SZA//ND+lz5iUcT5rE82Q0oT1SX600k1UlzuqhjJ4T9
 GhWIXFunzigEC4ON7Y2fcgP8bt81EV/fNPVGpFqdjddbFIk4fbCl9O/f88E4N4gkOOZtdP
 TadRgCTnhaV35yL/y7ZOv9zScGK9KR8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-5BHE227dPBW-_IqzT6kkOw-1; Thu, 06 Aug 2020 11:07:34 -0400
X-MC-Unique: 5BHE227dPBW-_IqzT6kkOw-1
Received: by mail-wm1-f69.google.com with SMTP id t26so4257037wmn.4
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 08:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Yd8B73Gw4cOJwIA3rbelMxUQY6v/oFJycgT7kd1G4t0=;
 b=uArm2NnGJM5VZcA9i/ihe/2BGA+8YaKW29f8RzJp95j1shDnrVUTmlDj4Wl3reHj9G
 /N//FbfDX10pmdq5OXUM5/lThKiH6agBLhxZKSpBjUdBia4UX6Q3s4s362RtTrE5xuc8
 4S18c6OUSYfSLzJ94fqWbp+TWEEJfe54yuUOMqErrjhzuYqqGoXors9X+04vS4PqvIEk
 XPpqyNrJPR16RxFeJEdTkUvAHh00bLr6SnKErTrgZPvC7Df+8o2G2SDxja8n+DO9zvDv
 v3uQNSSRJcRcqqzsmkx1ICci8GyuM55cvEPJ6sI6RMr+osqBneN8PKpe3TzTCOgN/yZP
 pS2w==
X-Gm-Message-State: AOAM531mo8TqO1K2bogpnGwKAKzrbRzZ7e3mKuNOXgtSc8vpUU6xQ1vD
 XxfJiGWQWeRX6SOGVvG0OCnxai7whsj7bW8Wnsqv+vt02yKUw1iZ6K5xpiLfngUyEJC0+8cwypS
 DR0AnBXBQVXGQFnk=
X-Received: by 2002:a05:600c:2209:: with SMTP id
 z9mr8239110wml.70.1596726449682; 
 Thu, 06 Aug 2020 08:07:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziGvcqE5SO06uolnSmfdOH1E9nr0Mf0aFSikuEB+fz5ePyxZ//CU9I4E4/mDnfW+SjLnQY4Q==
X-Received: by 2002:a05:600c:2209:: with SMTP id
 z9mr8239077wml.70.1596726449359; 
 Thu, 06 Aug 2020 08:07:29 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id i7sm7068637wrs.25.2020.08.06.08.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 08:07:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2] exec: Remove MemoryRegion::global_locking field
Date: Thu,  6 Aug 2020 17:07:26 +0200
Message-Id: <20200806150726.962-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 05:03:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Bulekov <alxndr@bu.edu>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Last uses of memory_region_clear_global_locking() have been
removed in commit 7070e085d4 ("acpi: mark PMTIMER as unlocked")
and commit 08565552f7 ("cputlb: Move NOTDIRTY handling from I/O
path to TLB path").
Remove memory_region_clear_global_locking() and the now unused
'global_locking' field in MemoryRegion.

Reported-by: Alexander Bulekov <alxndr@bu.edu>
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/exec/memory.h | 14 --------------
 accel/tcg/cputlb.c    |  4 ++--
 exec.c                |  2 +-
 softmmu/memory.c      |  6 ------
 4 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 307e527835..bb84283376 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -377,7 +377,6 @@ struct MemoryRegion {
     bool nonvolatile;
     bool rom_device;
     bool flush_coalesced_mmio;
-    bool global_locking;
     uint8_t dirty_log_mask;
     bool is_iommu;
     RAMBlock *ram_block;
@@ -1711,19 +1710,6 @@ void memory_region_set_flush_coalesced(MemoryRegion *mr);
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
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 5698292749..9ddf2b8dfa 100644
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
index 6f381f98e2..05cfc34b6c 100644
--- a/exec.c
+++ b/exec.c
@@ -3135,7 +3135,7 @@ static bool prepare_mmio_access(MemoryRegion *mr)
     bool unlocked = !qemu_mutex_iothread_locked();
     bool release_lock = false;
 
-    if (unlocked && mr->global_locking) {
+    if (unlocked) {
         qemu_mutex_lock_iothread();
         unlocked = false;
         release_lock = true;
diff --git a/softmmu/memory.c b/softmmu/memory.c
index af25987518..2303747feb 100644
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
2.21.3


