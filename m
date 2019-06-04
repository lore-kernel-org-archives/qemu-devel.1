Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D45EC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 06:20:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0273F24B72
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 06:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0273F24B72
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46561 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY2np-0007P3-5L
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 02:20:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hY2ln-0006UJ-5b
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 02:18:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hY2lm-0000hp-3i
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 02:18:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:60784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hY2lk-0000Tb-OB
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 02:18:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	03 Jun 2019 23:17:58 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by fmsmga005.fm.intel.com with ESMTP; 03 Jun 2019 23:17:57 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 14:17:27 +0800
Message-Id: <20190604061727.6857-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.43
Subject: [Qemu-devel] [PATCH v3] migratioin/ram: leave RAMBlock->bmap blank
 on allocating
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
Cc: Wei Yang <richardw.yang@linux.intel.com>, dgilbert@redhat.com,
	peterx@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

During migration, we would sync bitmap from ram_list.dirty_memory to
RAMBlock.bmap in cpu_physical_memory_sync_dirty_bitmap().

Since we set RAMBlock.bmap and ram_list.dirty_memory both to all 1, this
means at the first round this sync is meaningless and is a duplicated
work.

Leaving RAMBlock->bmap blank on allocating would have a side effect on
migration_dirty_pages, since it is calculated from the result of
cpu_physical_memory_sync_dirty_bitmap(). To keep it right, we need to
set migration_dirty_pages to 0 in ram_state_init().

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

---
v3: adjust comment based on Peter's comments
v2: add a comment explaining why leaving RAMBlock.bmap clear
---
 migration/ram.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 4c60869226..c3ece382ae 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3182,11 +3182,11 @@ static int ram_state_init(RAMState **rsp)
     QSIMPLEQ_INIT(&(*rsp)->src_page_requests);
 
     /*
-     * Count the total number of pages used by ram blocks not including any
-     * gaps due to alignment or unplugs.
+     * This must match with the initial values of dirty bitmap.
+     * Currently we initialize the dirty bitmap to all zeros so
+     * here the total dirty page count is zero.
      */
-    (*rsp)->migration_dirty_pages = ram_bytes_total() >> TARGET_PAGE_BITS;
-
+    (*rsp)->migration_dirty_pages = 0;
     ram_state_reset(*rsp);
 
     return 0;
@@ -3201,8 +3201,16 @@ static void ram_list_init_bitmaps(void)
     if (ram_bytes_total()) {
         RAMBLOCK_FOREACH_NOT_IGNORED(block) {
             pages = block->max_length >> TARGET_PAGE_BITS;
+            /*
+             * The initial dirty bitmap for migration must be set with all
+             * ones to make sure we'll migrate every guest RAM page to
+             * destination.
+             * Here we didn't set RAMBlock.bmap simply because it is already
+             * set in ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] in
+             * ram_block_add, and that's where we'll sync the dirty bitmaps.
+             * Here setting RAMBlock.bmap would be fine too but not necessary.
+             */
             block->bmap = bitmap_new(pages);
-            bitmap_set(block->bmap, 0, pages);
             if (migrate_postcopy_ram()) {
                 block->unsentmap = bitmap_new(pages);
                 bitmap_set(block->unsentmap, 0, pages);
-- 
2.19.1


