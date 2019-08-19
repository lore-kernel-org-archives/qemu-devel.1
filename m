Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B00AC3A59B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 06:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2A792087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 06:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A792087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzb20-0003B5-3K
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 02:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hzb11-0002E0-7i
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 02:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hzb0z-0003EP-DR
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 02:19:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:9382)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hzb0z-0003CJ-4B
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 02:19:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Aug 2019 23:19:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; d="scan'208";a="180265819"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga003.jf.intel.com with ESMTP; 18 Aug 2019 23:19:35 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:18:42 +0800
Message-Id: <20190819061843.28642-3-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819061843.28642-1-richardw.yang@linux.intel.com>
References: <20190819061843.28642-1-richardw.yang@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
Subject: [Qemu-devel] [PATCH 2/3] migration/postcopy: unsentmap is not
 necessary for postcopy
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
Cc: pbonzini@redhat.com, Wei Yang <richardw.yang@linux.intel.com>,
 dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit f3f491fcd6dd594ba695 ('Postcopy: Maintain unsentmap') introduced
unsentmap to track not yet sent pages.

This is not necessary since:

    * unsentmap is a sub-set of bmap before postcopy start
    * unsentmap is the summation of bmap and unsentmap after canonicalizing

This patch just removes it.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 include/exec/ram_addr.h |  6 ----
 migration/ram.c         | 80 ++++++++---------------------------------
 2 files changed, 14 insertions(+), 72 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index a327a80cfe..e96e621de5 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -44,12 +44,6 @@ struct RAMBlock {
     size_t page_size;
     /* dirty bitmap used during migration */
     unsigned long *bmap;
-    /* bitmap of pages that haven't been sent even once
-     * only maintained and used in postcopy at the moment
-     * where it's used to send the dirtymap at the start
-     * of the postcopy phase
-     */
-    unsigned long *unsentmap;
     /* bitmap of already received pages in postcopy */
     unsigned long *receivedmap;
 
diff --git a/migration/ram.c b/migration/ram.c
index 075ddc468c..066eb4755f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2348,7 +2348,7 @@ static bool get_queued_page(RAMState *rs, PageSearchStatus *pss)
             dirty = test_bit(page, block->bmap);
             if (!dirty) {
                 trace_get_queued_page_not_dirty(block->idstr, (uint64_t)offset,
-                       page, test_bit(page, block->unsentmap));
+                       page, test_bit(page, block->bmap));
             } else {
                 trace_get_queued_page(block->idstr, (uint64_t)offset, page);
             }
@@ -2619,10 +2619,6 @@ static int ram_save_host_page(RAMState *rs, PageSearchStatus *pss,
         }
 
         pages += tmppages;
-        if (pss->block->unsentmap) {
-            clear_bit(pss->page, pss->block->unsentmap);
-        }
-
         pss->page++;
     } while ((pss->page & (pagesize_bits - 1)) &&
              offset_in_ramblock(pss->block, pss->page << TARGET_PAGE_BITS));
@@ -2776,8 +2772,6 @@ static void ram_save_cleanup(void *opaque)
         block->clear_bmap = NULL;
         g_free(block->bmap);
         block->bmap = NULL;
-        g_free(block->unsentmap);
-        block->unsentmap = NULL;
     }
 
     xbzrle_cleanup();
@@ -2857,8 +2851,6 @@ void ram_postcopy_migrated_memory_release(MigrationState *ms)
  * Returns zero on success
  *
  * Callback from postcopy_each_ram_send_discard for each RAMBlock
- * Note: At this point the 'unsentmap' is the processed bitmap combined
- *       with the dirtymap; so a '1' means it's either dirty or unsent.
  *
  * @ms: current migration state
  * @block: RAMBlock to discard
@@ -2867,17 +2859,17 @@ static int postcopy_send_discard_bm_ram(MigrationState *ms, RAMBlock *block)
 {
     unsigned long end = block->used_length >> TARGET_PAGE_BITS;
     unsigned long current;
-    unsigned long *unsentmap = block->unsentmap;
+    unsigned long *bitmap = block->bmap;
 
     for (current = 0; current < end; ) {
-        unsigned long one = find_next_bit(unsentmap, end, current);
+        unsigned long one = find_next_bit(bitmap, end, current);
         unsigned long zero, discard_length;
 
         if (one >= end) {
             break;
         }
 
-        zero = find_next_zero_bit(unsentmap, end, one + 1);
+        zero = find_next_zero_bit(bitmap, end, one + 1);
 
         if (zero >= end) {
             discard_length = end - one;
@@ -2938,16 +2930,12 @@ static int postcopy_each_ram_send_discard(MigrationState *ms)
  * clean, not a mix.  This function canonicalizes the bitmaps.
  *
  * @ms: current migration state
- * @unsent_pass: if true we need to canonicalize partially unsent host pages
- *               otherwise we need to canonicalize partially dirty host pages
  * @block: block that contains the page we want to canonicalize
  */
-static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
-                                          RAMBlock *block)
+static void postcopy_chunk_hostpages_pass(MigrationState *ms, RAMBlock *block)
 {
     RAMState *rs = ram_state;
     unsigned long *bitmap = block->bmap;
-    unsigned long *unsentmap = block->unsentmap;
     unsigned int host_ratio = block->page_size / TARGET_PAGE_SIZE;
     unsigned long pages = block->used_length >> TARGET_PAGE_BITS;
     unsigned long run_start;
@@ -2957,13 +2945,8 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
         return;
     }
 
-    if (unsent_pass) {
-        /* Find a sent page */
-        run_start = find_next_zero_bit(unsentmap, pages, 0);
-    } else {
-        /* Find a dirty page */
-        run_start = find_next_bit(bitmap, pages, 0);
-    }
+    /* Find a dirty page */
+    run_start = find_next_bit(bitmap, pages, 0);
 
     while (run_start < pages) {
 
@@ -2973,11 +2956,7 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
          */
         if (QEMU_IS_ALIGNED(run_start, host_ratio)) {
             /* Find the end of this run */
-            if (unsent_pass) {
-                run_start = find_next_bit(unsentmap, pages, run_start + 1);
-            } else {
-                run_start = find_next_zero_bit(bitmap, pages, run_start + 1);
-            }
+            run_start = find_next_zero_bit(bitmap, pages, run_start + 1);
             /*
              * If the end isn't at the start of a host page, then the
              * run doesn't finish at the end of a host page
@@ -2994,9 +2973,6 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
             /* Clean up the bitmap */
             for (page = fixup_start_addr;
                  page < fixup_start_addr + host_ratio; page++) {
-                /* All pages in this host page are now not sent */
-                set_bit(page, unsentmap);
-
                 /*
                  * Remark them as dirty, updating the count for any pages
                  * that weren't previously dirty.
@@ -3005,13 +2981,8 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
             }
         }
 
-        if (unsent_pass) {
-            /* Find the next sent page for the next iteration */
-            run_start = find_next_zero_bit(unsentmap, pages, run_start);
-        } else {
-            /* Find the next dirty page for the next iteration */
-            run_start = find_next_bit(bitmap, pages, run_start);
-        }
+        /* Find the next dirty page for the next iteration */
+        run_start = find_next_bit(bitmap, pages, run_start);
     }
 }
 
@@ -3033,13 +3004,10 @@ static int postcopy_chunk_hostpages(MigrationState *ms, RAMBlock *block)
 {
     postcopy_discard_send_init(ms, block->idstr);
 
-    /* First pass: Discard all partially sent host pages */
-    postcopy_chunk_hostpages_pass(ms, true, block);
     /*
-     * Second pass: Ensure that all partially dirty host pages are made
-     * fully dirty.
+     * Ensure that all partially dirty host pages are made fully dirty.
      */
-    postcopy_chunk_hostpages_pass(ms, false, block);
+    postcopy_chunk_hostpages_pass(ms, block);
 
     postcopy_discard_send_finish(ms);
     return 0;
@@ -3077,19 +3045,6 @@ int ram_postcopy_send_discard_bitmap(MigrationState *ms)
     rs->last_page = 0;
 
     RAMBLOCK_FOREACH_NOT_IGNORED(block) {
-        unsigned long pages = block->used_length >> TARGET_PAGE_BITS;
-        unsigned long *bitmap = block->bmap;
-        unsigned long *unsentmap = block->unsentmap;
-
-        if (!unsentmap) {
-            /* We don't have a safe way to resize the sentmap, so
-             * if the bitmap was resized it will be NULL at this
-             * point.
-             */
-            error_report("migration ram resized during precopy phase");
-            rcu_read_unlock();
-            return -EINVAL;
-        }
         /* Deal with TPS != HPS and huge pages */
         ret = postcopy_chunk_hostpages(ms, block);
         if (ret) {
@@ -3097,12 +3052,9 @@ int ram_postcopy_send_discard_bitmap(MigrationState *ms)
             return ret;
         }
 
-        /*
-         * Update the unsentmap to be unsentmap = unsentmap | dirty
-         */
-        bitmap_or(unsentmap, unsentmap, bitmap, pages);
 #ifdef DEBUG_POSTCOPY
-        ram_debug_dump_bitmap(unsentmap, true, pages);
+        ram_debug_dump_bitmap(block->bmap, true,
+                              block->used_length >> TARGET_PAGE_BITS);
 #endif
     }
     trace_ram_postcopy_send_discard_bitmap();
@@ -3270,10 +3222,6 @@ static void ram_list_init_bitmaps(void)
             bitmap_set(block->bmap, 0, pages);
             block->clear_bmap_shift = shift;
             block->clear_bmap = bitmap_new(clear_bmap_size(pages, shift));
-            if (migrate_postcopy_ram()) {
-                block->unsentmap = bitmap_new(pages);
-                bitmap_set(block->unsentmap, 0, pages);
-            }
         }
     }
 }
-- 
2.17.1


