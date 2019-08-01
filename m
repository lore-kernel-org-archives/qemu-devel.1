Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A35C32751
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 02:56:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20CD52064A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 02:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20CD52064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ht1GW-0003Rb-A8
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 22:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50840)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1ht1G7-00032Y-Gg
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 22:56:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1ht1G6-0003Oy-C1
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 22:56:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:34257)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1ht1G6-0003Nv-3k
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 22:56:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Jul 2019 19:56:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,332,1559545200"; d="scan'208";a="184024123"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga002.jf.intel.com with ESMTP; 31 Jul 2019 19:55:58 -0700
Date: Thu, 1 Aug 2019 10:55:35 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Ivan Ren <renyime@gmail.com>
Message-ID: <20190801025535.GB21992@richard>
References: <1563115879-2715-1-git-send-email-ivanren@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563115879-2715-1-git-send-email-ivanren@tencent.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
Subject: Re: [Qemu-devel] [PATCH] migration: always initial RAMBlock.bmap to
 1 for new migration
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks, I didn't notice this case.

On Sun, Jul 14, 2019 at 10:51:19PM +0800, Ivan Ren wrote:
>Reproduce the problem:
>migrate
>migrate_cancel
>migrate
>
>Error happen for memory migration
>
>The reason as follows:
>1. qemu start, ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] all set to
>   1 by a series of cpu_physical_memory_set_dirty_range
>2. migration start:ram_init_bitmaps
>   - memory_global_dirty_log_start: begin log diry

s/diry/dirty/

>   - memory_global_dirty_log_sync: sync dirty bitmap to
>     ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION]
>   - migration_bitmap_sync_range: sync ram_list.
>     dirty_memory[DIRTY_MEMORY_MIGRATION] to RAMBlock.bmap
>     and ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] is set to zero
>3. migration data...
>4. migrate_cancel, will stop log dirty
>5. migration start:ram_init_bitmaps
>   - memory_global_dirty_log_start: begin log diry

same as above

>   - memory_global_dirty_log_sync: sync dirty bitmap to
>     ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION]
>   - migration_bitmap_sync_range: sync ram_list.
>     dirty_memory[DIRTY_MEMORY_MIGRATION] to RAMBlock.bmap
>     and ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] is set to zero
>
>   Here RAMBlock.bmap only have new logged dirty pages, don't contain
>   the whole guest pages.
>
>Signed-off-by: Ivan Ren <ivanren@tencent.com>
>---
> migration/ram.c | 15 ++++++++-------
> 1 file changed, 8 insertions(+), 7 deletions(-)
>
>diff --git a/migration/ram.c b/migration/ram.c
>index 908517fc2b..bbebaee0c1 100644
>--- a/migration/ram.c
>+++ b/migration/ram.c
>@@ -3173,11 +3173,11 @@ static int ram_state_init(RAMState **rsp)
>     QSIMPLEQ_INIT(&(*rsp)->src_page_requests);
> 
>     /*
>+     * Count the total number of pages used by ram blocks not including any
>+     * gaps due to alignment or unplugs.
>      * This must match with the initial values of dirty bitmap.
>-     * Currently we initialize the dirty bitmap to all zeros so
>-     * here the total dirty page count is zero.
>      */
>-    (*rsp)->migration_dirty_pages = 0;
>+    (*rsp)->migration_dirty_pages = ram_bytes_total() >> TARGET_PAGE_BITS;
>     ram_state_reset(*rsp);
> 
>     return 0;
>@@ -3196,12 +3196,13 @@ static void ram_list_init_bitmaps(void)
>              * The initial dirty bitmap for migration must be set with all
>              * ones to make sure we'll migrate every guest RAM page to
>              * destination.
>-             * Here we didn't set RAMBlock.bmap simply because it is already
>-             * set in ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] in
>-             * ram_block_add, and that's where we'll sync the dirty bitmaps.
>-             * Here setting RAMBlock.bmap would be fine too but not necessary.
>+             * Here we set RAMBlock.bmap all to 1 because when rebegin a
>+             * new migration after a failed migration, ram_list.

It is after failure or cancel?

>+             * dirty_memory[DIRTY_MEMORY_MIGRATION] don't include the whole
>+             * guest memory.
>              */
>             block->bmap = bitmap_new(pages);
>+            bitmap_set(block->bmap, 0, pages);
>             if (migrate_postcopy_ram()) {
>                 block->unsentmap = bitmap_new(pages);
>                 bitmap_set(block->unsentmap, 0, pages);
>-- 
>2.17.2 (Apple Git-113)
>


Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

-- 
Wei Yang
Help you, Help me

