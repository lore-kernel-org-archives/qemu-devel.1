Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8365C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 12:45:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AD2C2187F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 12:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD2C2187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iShAL-0002cH-I7
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 07:45:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iSh4k-0004DL-0a
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 07:39:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iSh4i-0002v7-K7
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 07:39:45 -0500
Received: from mga06.intel.com ([134.134.136.31]:63434)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iSh4i-0002tE-9G
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 07:39:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Nov 2019 04:39:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,278,1569308400"; d="scan'208";a="377408609"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga005.jf.intel.com with ESMTP; 07 Nov 2019 04:39:42 -0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: quintela@redhat.com,
	dgilbert@redhat.com
Subject: [Patch v2 6/6] migration/postcopy: enable compress during postcopy
Date: Thu,  7 Nov 2019 20:39:07 +0800
Message-Id: <20191107123907.29791-7-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191107123907.29791-1-richardw.yang@linux.intel.com>
References: <20191107123907.29791-1-richardw.yang@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.31
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

postcopy requires to place a whole host page, while migration thread
migrate memory in target page size. This makes postcopy need to collect
all target pages in one host page before placing via userfaultfd.

To enable compress during postcopy, there are two problems to solve:

    1. Random order for target page arrival
    2. Target pages in one host page arrives without interrupt by target
       page from other host page

The first one is handled by previous cleanup patch.

This patch handles the second one by:

    1. Flush compress thread for each host page
    2. Wait for decompress thread for before placing host page

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 11 -----------
 migration/ram.c       | 28 +++++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 354ad072fa..3c926a3ae3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1005,17 +1005,6 @@ static bool migrate_caps_check(bool *cap_list,
 #endif
 
     if (cap_list[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
-        if (cap_list[MIGRATION_CAPABILITY_COMPRESS]) {
-            /* The decompression threads asynchronously write into RAM
-             * rather than use the atomic copies needed to avoid
-             * userfaulting.  It should be possible to fix the decompression
-             * threads for compatibility in future.
-             */
-            error_setg(errp, "Postcopy is not currently compatible "
-                       "with compression");
-            return false;
-        }
-
         /* This check is reasonably expensive, so only when it's being
          * set the first time, also it's only the destination that needs
          * special support.
diff --git a/migration/ram.c b/migration/ram.c
index 666ad69284..0d53786311 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3449,6 +3449,14 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
 
             rs->target_page_count += pages;
 
+            /*
+             * During postcopy, it is necessary to make sure one whole host
+             * page is sent in one chunk.
+             */
+            if (migrate_postcopy_ram()) {
+                flush_compressed_data(rs);
+            }
+
             /*
              * we want to check in the 1st loop, just in case it was the 1st
              * time and we had to sync the dirty bitmap.
@@ -4026,6 +4034,7 @@ static int ram_load_postcopy(QEMUFile *f)
         void *place_source = NULL;
         RAMBlock *block = NULL;
         uint8_t ch;
+        int len;
 
         addr = qemu_get_be64(f);
 
@@ -4043,7 +4052,8 @@ static int ram_load_postcopy(QEMUFile *f)
 
         trace_ram_load_postcopy_loop((uint64_t)addr, flags);
         place_needed = false;
-        if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE)) {
+        if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
+                     RAM_SAVE_FLAG_COMPRESS_PAGE)) {
             block = ram_block_from_stream(f, flags);
 
             host = host_from_ram_block_offset(block, addr);
@@ -4126,6 +4136,17 @@ static int ram_load_postcopy(QEMUFile *f)
                                          TARGET_PAGE_SIZE);
             }
             break;
+        case RAM_SAVE_FLAG_COMPRESS_PAGE:
+            all_zero = false;
+            len = qemu_get_be32(f);
+            if (len < 0 || len > compressBound(TARGET_PAGE_SIZE)) {
+                error_report("Invalid compressed data length: %d", len);
+                ret = -EINVAL;
+                break;
+            }
+            decompress_data_with_multi_threads(f, page_buffer, len);
+            break;
+
         case RAM_SAVE_FLAG_EOS:
             /* normal exit */
             multifd_recv_sync_main();
@@ -4137,6 +4158,11 @@ static int ram_load_postcopy(QEMUFile *f)
             break;
         }
 
+        /* Got the whole host page, wait for decompress before placing. */
+        if (place_needed) {
+            ret |= wait_for_decompress_done();
+        }
+
         /* Detect for any possible file errors */
         if (!ret && qemu_file_get_error(f)) {
             ret = qemu_file_get_error(f);
-- 
2.17.1


