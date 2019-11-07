Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E77C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 12:44:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD0A2187F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 12:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD0A2187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSh9R-0001Qx-VK
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 07:44:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iSh4i-00049h-K0
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 07:39:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iSh4h-0002uD-EO
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 07:39:44 -0500
Received: from mga06.intel.com ([134.134.136.31]:63434)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iSh4h-0002tE-6q
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 07:39:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Nov 2019 04:39:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,278,1569308400"; d="scan'208";a="377408601"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga005.jf.intel.com with ESMTP; 07 Nov 2019 04:39:41 -0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: quintela@redhat.com,
	dgilbert@redhat.com
Subject: [Patch v2 5/6] migration/postcopy: enable random order target page
 arrival
Date: Thu,  7 Nov 2019 20:39:06 +0800
Message-Id: <20191107123907.29791-6-richardw.yang@linux.intel.com>
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

After using number of target page received to track one host page, we
could have the capability to handle random order target page arrival in
one host page.

This is a preparation for enabling compress during postcopy.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

---
v2:
   * use uintptr_t to calculate place_dest
   * check target pages belongs to the same host page
---
 migration/ram.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index b5759793a9..666ad69284 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4015,7 +4015,7 @@ static int ram_load_postcopy(QEMUFile *f)
     MigrationIncomingState *mis = migration_incoming_get_current();
     /* Temporary page that is later 'placed' */
     void *postcopy_host_page = mis->postcopy_tmp_page;
-    void *last_host = NULL;
+    void *this_host = NULL;
     bool all_zero = false;
     int target_pages = 0;
 
@@ -4062,24 +4062,26 @@ static int ram_load_postcopy(QEMUFile *f)
              * that's moved into place later.
              * The migration protocol uses,  possibly smaller, target-pages
              * however the source ensures it always sends all the components
-             * of a host page in order.
+             * of a host page in one chunk.
              */
             page_buffer = postcopy_host_page +
                           ((uintptr_t)host & (block->page_size - 1));
             /* If all TP are zero then we can optimise the place */
             if (target_pages == 1) {
                 all_zero = true;
+                this_host = (void *)QEMU_ALIGN_DOWN((uintptr_t)host,
+                                                    block->page_size);
             } else {
                 /* not the 1st TP within the HP */
-                if (host != (last_host + TARGET_PAGE_SIZE)) {
-                    error_report("Non-sequential target page %p/%p",
-                                  host, last_host);
+                if (QEMU_ALIGN_DOWN((uintptr_t)host, block->page_size) !=
+                    (uintptr_t)this_host) {
+                    error_report("Non-same host page %p/%p",
+                                  host, this_host);
                     ret = -EINVAL;
                     break;
                 }
             }
 
-
             /*
              * If it's the last part of a host page then we place the host
              * page
@@ -4090,7 +4092,6 @@ static int ram_load_postcopy(QEMUFile *f)
             }
             place_source = postcopy_host_page;
         }
-        last_host = host;
 
         switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {
         case RAM_SAVE_FLAG_ZERO:
@@ -4143,7 +4144,8 @@ static int ram_load_postcopy(QEMUFile *f)
 
         if (!ret && place_needed) {
             /* This gets called at the last target page in the host page */
-            void *place_dest = host + TARGET_PAGE_SIZE - block->page_size;
+            void *place_dest = (void *)QEMU_ALIGN_DOWN((uintptr_t)host,
+                                                       block->page_size);
 
             if (all_zero) {
                 ret = postcopy_place_page_zero(mis, place_dest,
-- 
2.17.1


