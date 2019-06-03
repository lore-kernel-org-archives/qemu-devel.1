Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749FCC04AB6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 06:58:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48A7727C6B
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 06:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A7727C6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58767 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXgvb-0004qt-CP
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 02:58:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hXgoR-0007bV-0n
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:51:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hXgoP-00028w-Um
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:51:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hXgoP-00027q-Oz
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:51:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0F2993082B13
	for <qemu-devel@nongnu.org>; Mon,  3 Jun 2019 06:51:17 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-15-205.nay.redhat.com [10.66.15.205])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 03F5D648AA;
	Mon,  3 Jun 2019 06:51:14 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 14:50:50 +0800
Message-Id: <20190603065056.25211-6-peterx@redhat.com>
In-Reply-To: <20190603065056.25211-1-peterx@redhat.com>
References: <20190603065056.25211-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Mon, 03 Jun 2019 06:51:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 05/11] memory: Pass mr into
 snapshot_and_clear_dirty
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	peterx@redhat.com, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Also we change the 2nd parameter of it to be the relative offset
within the memory region. This is to be used in follow up patches.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 exec.c                  | 3 ++-
 include/exec/ram_addr.h | 2 +-
 memory.c                | 3 +--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/exec.c b/exec.c
index 4e734770c2..815e4f48b9 100644
--- a/exec.c
+++ b/exec.c
@@ -1387,9 +1387,10 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
 }
 
 DirtyBitmapSnapshot *cpu_physical_memory_snapshot_and_clear_dirty
-     (ram_addr_t start, ram_addr_t length, unsigned client)
+    (MemoryRegion *mr, hwaddr offset, hwaddr length, unsigned client)
 {
     DirtyMemoryBlocks *blocks;
+    ram_addr_t start = memory_region_get_ram_addr(mr) + offset;
     unsigned long align = 1UL << (TARGET_PAGE_BITS + BITS_PER_LEVEL);
     ram_addr_t first = QEMU_ALIGN_DOWN(start, align);
     ram_addr_t last  = QEMU_ALIGN_UP(start + length, align);
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 79e70a96ee..a4456f3615 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -403,7 +403,7 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
                                               unsigned client);
 
 DirtyBitmapSnapshot *cpu_physical_memory_snapshot_and_clear_dirty
-    (ram_addr_t start, ram_addr_t length, unsigned client);
+    (MemoryRegion *mr, hwaddr offset, hwaddr length, unsigned client);
 
 bool cpu_physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
                                             ram_addr_t start,
diff --git a/memory.c b/memory.c
index cff0ea8f40..84bba7b65c 100644
--- a/memory.c
+++ b/memory.c
@@ -2071,8 +2071,7 @@ DirtyBitmapSnapshot *memory_region_snapshot_and_clear_dirty(MemoryRegion *mr,
 {
     assert(mr->ram_block);
     memory_region_sync_dirty_bitmap(mr);
-    return cpu_physical_memory_snapshot_and_clear_dirty(
-                memory_region_get_ram_addr(mr) + addr, size, client);
+    return cpu_physical_memory_snapshot_and_clear_dirty(mr, addr, size, client);
 }
 
 bool memory_region_snapshot_get_dirty(MemoryRegion *mr, DirtyBitmapSnapshot *snap,
-- 
2.17.1


