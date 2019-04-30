Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC04C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 03:47:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F00822080C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 03:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F00822080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38589 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLJkH-00065e-4e
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 23:47:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hLJj7-0005Wy-5d
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 23:46:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hLJj3-00033i-Mk
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 23:46:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:44783)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hLJj3-00031f-CW
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 23:46:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	29 Apr 2019 20:46:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,412,1549958400"; d="scan'208";a="153455302"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by FMSMGA003.fm.intel.com with ESMTP; 29 Apr 2019 20:46:31 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 11:44:11 +0800
Message-Id: <20190430034412.12935-3-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190430034412.12935-1-richardw.yang@linux.intel.com>
References: <20190430034412.12935-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.136
Subject: [Qemu-devel] [PATCH 2/3] migration/ram.c: start of
 cpu_physical_memory_sync_dirty_bitmap is always 0
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
Cc: pbonzini@redhat.com, Wei Yang <richardw.yang@linux.intel.com>,
	dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190430034411.AK7iYB4FCjv4zXTH2QC5lm-2cIIJwMYg-e7_F4ayaxo@z>

Since start of cpu_physical_memory_sync_dirty_bitmap is always 0, we can
remove this parameter and simplify the calculation a bit.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 include/exec/ram_addr.h | 15 ++++++---------
 migration/ram.c         |  2 +-
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 9ecd911c3e..3dfb2d52fb 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -409,18 +409,16 @@ static inline void cpu_physical_memory_clear_dirty_range(ram_addr_t start,
 
 static inline
 uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
-                                               ram_addr_t start,
                                                ram_addr_t length,
                                                uint64_t *real_dirty_pages)
 {
     ram_addr_t addr;
-    unsigned long word = BIT_WORD((start + rb->offset) >> TARGET_PAGE_BITS);
+    unsigned long word = BIT_WORD(rb->offset >> TARGET_PAGE_BITS);
     uint64_t num_dirty = 0;
     unsigned long *dest = rb->bmap;
 
-    /* start address and length is aligned at the start of a word? */
-    if (((word * BITS_PER_LONG) << TARGET_PAGE_BITS) ==
-         (start + rb->offset) &&
+    /* offset and length is aligned at the start of a word? */
+    if (((word * BITS_PER_LONG) << TARGET_PAGE_BITS) == (rb->offset) &&
         !(length & ((BITS_PER_LONG << TARGET_PAGE_BITS) - 1))) {
         int k;
         int nr = BITS_TO_LONGS(length >> TARGET_PAGE_BITS);
@@ -428,14 +426,13 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
         unsigned long idx = (word * BITS_PER_LONG) / DIRTY_MEMORY_BLOCK_SIZE;
         unsigned long offset = BIT_WORD((word * BITS_PER_LONG) %
                                         DIRTY_MEMORY_BLOCK_SIZE);
-        unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
 
         rcu_read_lock();
 
         src = atomic_rcu_read(
                 &ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION])->blocks;
 
-        for (k = page; k < page + nr; k++) {
+        for (k = 0; k < nr; k++) {
             if (src[idx][offset]) {
                 unsigned long bits = atomic_xchg(&src[idx][offset], 0);
                 unsigned long new_dirty;
@@ -458,11 +455,11 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
 
         for (addr = 0; addr < length; addr += TARGET_PAGE_SIZE) {
             if (cpu_physical_memory_test_and_clear_dirty(
-                        start + addr + offset,
+                        addr + offset,
                         TARGET_PAGE_SIZE,
                         DIRTY_MEMORY_MIGRATION)) {
                 *real_dirty_pages += 1;
-                long k = (start + addr) >> TARGET_PAGE_BITS;
+                long k = addr >> TARGET_PAGE_BITS;
                 if (!test_and_set_bit(k, dest)) {
                     num_dirty++;
                 }
diff --git a/migration/ram.c b/migration/ram.c
index 9948b2d021..1def8122e9 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1646,7 +1646,7 @@ static void migration_bitmap_sync_range(RAMState *rs, RAMBlock *rb,
                                         ram_addr_t length)
 {
     rs->migration_dirty_pages +=
-        cpu_physical_memory_sync_dirty_bitmap(rb, 0, length,
+        cpu_physical_memory_sync_dirty_bitmap(rb, length,
                                               &rs->num_dirty_pages_period);
 }
 
-- 
2.19.1


