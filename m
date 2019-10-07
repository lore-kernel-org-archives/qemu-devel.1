Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76171ECE595
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 09:11:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CDB02084D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 09:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDB02084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHP3V-00052A-FF
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 05:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iHP2M-00040g-43
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 05:10:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iHP2K-0000Gj-Ne
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 05:10:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:12001)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iHP2K-0000Dv-GF
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 05:10:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Oct 2019 02:10:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,267,1566889200"; d="scan'208";a="193039245"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga007.fm.intel.com with ESMTP; 07 Oct 2019 02:10:27 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: quintela@redhat.com,
	dgilbert@redhat.com
Subject: [PATCH] migration/postcopy: not necessary to discard all RAM at the
 beginning
Date: Mon,  7 Oct 2019 17:10:08 +0800
Message-Id: <20191007091008.9435-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
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
Cc: qemu-devel@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ram_discard_range() unmap page for specific range. To be specific, this
clears related page table entries so that userfault would be triggered.
But this step is not necessary at the very beginning.

ram_postcopy_incoming_init() is called when destination gets ADVISE
command. ADVISE command is sent when migration thread just starts, which
implies destination is not running yet. This means no page fault
happened and memory region's page tables entries are empty.

This patch removes the discard at the beginning.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 migration/postcopy-ram.c | 46 ----------------------------------------
 migration/postcopy-ram.h |  7 ------
 migration/ram.c          | 16 --------------
 migration/ram.h          |  1 -
 migration/savevm.c       |  4 ----
 5 files changed, 74 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 5da6de8c8b..459be8e780 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -443,32 +443,6 @@ out:
     return ret;
 }
 
-/*
- * Setup an area of RAM so that it *can* be used for postcopy later; this
- * must be done right at the start prior to pre-copy.
- * opaque should be the MIS.
- */
-static int init_range(RAMBlock *rb, void *opaque)
-{
-    const char *block_name = qemu_ram_get_idstr(rb);
-    void *host_addr = qemu_ram_get_host_addr(rb);
-    ram_addr_t offset = qemu_ram_get_offset(rb);
-    ram_addr_t length = qemu_ram_get_used_length(rb);
-    trace_postcopy_init_range(block_name, host_addr, offset, length);
-
-    /*
-     * We need the whole of RAM to be truly empty for postcopy, so things
-     * like ROMs and any data tables built during init must be zero'd
-     * - we're going to get the copy from the source anyway.
-     * (Precopy will just overwrite this data, so doesn't need the discard)
-     */
-    if (ram_discard_range(block_name, 0, length)) {
-        return -1;
-    }
-
-    return 0;
-}
-
 /*
  * At the end of migration, undo the effects of init_range
  * opaque should be the MIS.
@@ -506,20 +480,6 @@ static int cleanup_range(RAMBlock *rb, void *opaque)
     return 0;
 }
 
-/*
- * Initialise postcopy-ram, setting the RAM to a state where we can go into
- * postcopy later; must be called prior to any precopy.
- * called from arch_init's similarly named ram_postcopy_incoming_init
- */
-int postcopy_ram_incoming_init(MigrationIncomingState *mis)
-{
-    if (foreach_not_ignored_block(init_range, NULL)) {
-        return -1;
-    }
-
-    return 0;
-}
-
 /*
  * Manage a single vote to the QEMU balloon inhibitor for all postcopy usage,
  * last caller wins.
@@ -1282,12 +1242,6 @@ bool postcopy_ram_supported_by_host(MigrationIncomingState *mis)
     return false;
 }
 
-int postcopy_ram_incoming_init(MigrationIncomingState *mis)
-{
-    error_report("postcopy_ram_incoming_init: No OS support");
-    return -1;
-}
-
 int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
 {
     assert(0);
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index c0ccf64a96..1c79c6e51f 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -22,13 +22,6 @@ bool postcopy_ram_supported_by_host(MigrationIncomingState *mis);
  */
 int postcopy_ram_incoming_setup(MigrationIncomingState *mis);
 
-/*
- * Initialise postcopy-ram, setting the RAM to a state where we can go into
- * postcopy later; must be called prior to any precopy.
- * called from ram.c's similarly named ram_postcopy_incoming_init
- */
-int postcopy_ram_incoming_init(MigrationIncomingState *mis);
-
 /*
  * At the end of a migration where postcopy_ram_incoming_init was called.
  */
diff --git a/migration/ram.c b/migration/ram.c
index dfc50d57d5..9a853703d8 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4015,22 +4015,6 @@ static int ram_load_cleanup(void *opaque)
     return 0;
 }
 
-/**
- * ram_postcopy_incoming_init: allocate postcopy data structures
- *
- * Returns 0 for success and negative if there was one error
- *
- * @mis: current migration incoming state
- *
- * Allocate data structures etc needed by incoming migration with
- * postcopy-ram. postcopy-ram's similarly names
- * postcopy_ram_incoming_init does the work.
- */
-int ram_postcopy_incoming_init(MigrationIncomingState *mis)
-{
-    return postcopy_ram_incoming_init(mis);
-}
-
 /**
  * ram_load_postcopy: load a page in postcopy case
  *
diff --git a/migration/ram.h b/migration/ram.h
index 44fe4753ad..66cbff1d52 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -58,7 +58,6 @@ void ram_postcopy_migrated_memory_release(MigrationState *ms);
 int ram_postcopy_send_discard_bitmap(MigrationState *ms);
 /* For incoming postcopy discard */
 int ram_discard_range(const char *block_name, uint64_t start, size_t length);
-int ram_postcopy_incoming_init(MigrationIncomingState *mis);
 bool postcopy_is_running(void);
 
 void ram_handle_compressed(void *host, uint8_t ch, uint64_t size);
diff --git a/migration/savevm.c b/migration/savevm.c
index 9dc191e0a0..d2a427a3bf 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1674,10 +1674,6 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
         return -1;
     }
 
-    if (ram_postcopy_incoming_init(mis)) {
-        return -1;
-    }
-
     return 0;
 }
 
-- 
2.17.1


