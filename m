Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E5FC04AB5
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 00:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3C09262C2
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 00:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3C09262C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42884 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXxKm-0007Gv-4g
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 20:29:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hXxJv-0006xu-RU
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 20:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hXxJu-0003hb-OQ
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 20:28:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:3584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hXxJs-0003bP-Na
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 20:28:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	03 Jun 2019 17:28:41 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by fmsmga008.fm.intel.com with ESMTP; 03 Jun 2019 17:28:39 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 08:28:10 +0800
Message-Id: <20190604002810.12869-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.93
Subject: [Qemu-devel] [PATCH v2] migratioin/ram: leave RAMBlock->bmap blank
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
v2: add a comment explaining why leaving RAMBlock.bmap clear
---
 migration/ram.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 4c60869226..e9a27ea5e6 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3181,12 +3181,7 @@ static int ram_state_init(RAMState **rsp)
     qemu_mutex_init(&(*rsp)->src_page_req_mutex);
     QSIMPLEQ_INIT(&(*rsp)->src_page_requests);
 
-    /*
-     * Count the total number of pages used by ram blocks not including any
-     * gaps due to alignment or unplugs.
-     */
-    (*rsp)->migration_dirty_pages = ram_bytes_total() >> TARGET_PAGE_BITS;
-
+    (*rsp)->migration_dirty_pages = 0;
     ram_state_reset(*rsp);
 
     return 0;
@@ -3201,8 +3196,15 @@ static void ram_list_init_bitmaps(void)
     if (ram_bytes_total()) {
         RAMBLOCK_FOREACH_NOT_IGNORED(block) {
             pages = block->max_length >> TARGET_PAGE_BITS;
+            /*
+             * We leave RAMBlock.bmap clear here and they will be sync from
+             * ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] in
+             * migration_bitmap_sync_precopy().
+             *
+             * ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] is set to all 1
+             * in ram_block_add().
+             */
             block->bmap = bitmap_new(pages);
-            bitmap_set(block->bmap, 0, pages);
             if (migrate_postcopy_ram()) {
                 block->unsentmap = bitmap_new(pages);
                 bitmap_set(block->unsentmap, 0, pages);
-- 
2.19.1


