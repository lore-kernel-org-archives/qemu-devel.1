Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D12BCA9EB3
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 00:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 181AA21852
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 00:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 181AA21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLGWl-0001Te-8Q
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 20:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iLGSL-0004QS-36
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 20:49:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iLGSJ-00019x-Uo
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 20:49:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:15620)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iLGSJ-00010g-M9
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 20:49:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Oct 2019 17:49:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,309,1566889200"; d="scan'208";a="199552637"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga003.jf.intel.com with ESMTP; 17 Oct 2019 17:49:22 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: quintela@redhat.com,
	dgilbert@redhat.com
Subject: [PATCH 5/6] migration/postcopy: enable random order target page
 arrival
Date: Fri, 18 Oct 2019 08:48:49 +0800
Message-Id: <20191018004850.9888-6-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018004850.9888-1-richardw.yang@linux.intel.com>
References: <20191018004850.9888-1-richardw.yang@linux.intel.com>
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
 migration/ram.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index b5759793a9..da0596411c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4015,7 +4015,6 @@ static int ram_load_postcopy(QEMUFile *f)
     MigrationIncomingState *mis = migration_incoming_get_current();
     /* Temporary page that is later 'placed' */
     void *postcopy_host_page = mis->postcopy_tmp_page;
-    void *last_host = NULL;
     bool all_zero = false;
     int target_pages = 0;
 
@@ -4062,24 +4061,15 @@ static int ram_load_postcopy(QEMUFile *f)
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
-            } else {
-                /* not the 1st TP within the HP */
-                if (host != (last_host + TARGET_PAGE_SIZE)) {
-                    error_report("Non-sequential target page %p/%p",
-                                  host, last_host);
-                    ret = -EINVAL;
-                    break;
-                }
             }
 
-
             /*
              * If it's the last part of a host page then we place the host
              * page
@@ -4090,7 +4080,6 @@ static int ram_load_postcopy(QEMUFile *f)
             }
             place_source = postcopy_host_page;
         }
-        last_host = host;
 
         switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {
         case RAM_SAVE_FLAG_ZERO:
@@ -4143,7 +4132,8 @@ static int ram_load_postcopy(QEMUFile *f)
 
         if (!ret && place_needed) {
             /* This gets called at the last target page in the host page */
-            void *place_dest = host + TARGET_PAGE_SIZE - block->page_size;
+            void *place_dest = (void *)QEMU_ALIGN_DOWN((unsigned long)host,
+                                                       block->page_size);
 
             if (all_zero) {
                 ret = postcopy_place_page_zero(mis, place_dest,
-- 
2.17.1


