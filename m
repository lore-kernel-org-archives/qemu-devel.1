Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E7CC3E8AB
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 13:52:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3975E222C8
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 13:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3975E222C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGkTo-0000vG-AY
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 09:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iGkSb-0008VX-Dv
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 09:51:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iGkSa-0002PD-8D
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 09:51:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:60375)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iGkSZ-0002NG-W8
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 09:51:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Oct 2019 06:50:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,260,1566889200"; d="scan'208";a="192683733"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga007.fm.intel.com with ESMTP; 05 Oct 2019 06:50:53 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: quintela@redhat.com,
	dgilbert@redhat.com
Subject: [PATCH 1/2] migration/postcopy: allocate tmp_page in setup stage
Date: Sat,  5 Oct 2019 21:50:20 +0800
Message-Id: <20191005135021.21721-2-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191005135021.21721-1-richardw.yang@linux.intel.com>
References: <20191005135021.21721-1-richardw.yang@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.88
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

During migration, a tmp page is allocated so that we could place a whole
host page during postcopy.

Currently the page is allocated during load stage, this is a little bit
late. And more important, if we failed to allocate it, the error is not
checked properly. Even it is NULL, we would still use it.

This patch moves the allocation to setup stage and if failed error
message would be printed and caller would notice it.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 migration/postcopy-ram.c | 40 ++++++++++------------------------------
 migration/postcopy-ram.h |  7 -------
 migration/ram.c          |  2 +-
 3 files changed, 11 insertions(+), 38 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 51dc164693..e554f93eec 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1132,6 +1132,16 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
         return -1;
     }
 
+    mis->postcopy_tmp_page = mmap(NULL, mis->largest_page_size,
+                                  PROT_READ | PROT_WRITE, MAP_PRIVATE |
+                                  MAP_ANONYMOUS, -1, 0);
+    if (mis->postcopy_tmp_page == MAP_FAILED) {
+        mis->postcopy_tmp_page = NULL;
+        error_report("%s: Failed to map postcopy_tmp_page %s",
+                     __func__, strerror(errno));
+        return -1;
+    }
+
     /*
      * Ballooning can mark pages as absent while we're postcopying
      * that would cause false userfaults.
@@ -1258,30 +1268,6 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
     }
 }
 
-/*
- * Returns a target page of memory that can be mapped at a later point in time
- * using postcopy_place_page
- * The same address is used repeatedly, postcopy_place_page just takes the
- * backing page away.
- * Returns: Pointer to allocated page
- *
- */
-void *postcopy_get_tmp_page(MigrationIncomingState *mis)
-{
-    if (!mis->postcopy_tmp_page) {
-        mis->postcopy_tmp_page = mmap(NULL, mis->largest_page_size,
-                             PROT_READ | PROT_WRITE, MAP_PRIVATE |
-                             MAP_ANONYMOUS, -1, 0);
-        if (mis->postcopy_tmp_page == MAP_FAILED) {
-            mis->postcopy_tmp_page = NULL;
-            error_report("%s: %s", __func__, strerror(errno));
-            return NULL;
-        }
-    }
-
-    return mis->postcopy_tmp_page;
-}
-
 #else
 /* No target OS support, stubs just fail */
 void fill_destination_postcopy_migration_info(MigrationInfo *info)
@@ -1339,12 +1325,6 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
     return -1;
 }
 
-void *postcopy_get_tmp_page(MigrationIncomingState *mis)
-{
-    assert(0);
-    return NULL;
-}
-
 int postcopy_wake_shared(struct PostCopyFD *pcfd,
                          uint64_t client_addr,
                          RAMBlock *rb)
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index e3dde32155..c0ccf64a96 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -100,13 +100,6 @@ typedef enum {
     POSTCOPY_INCOMING_END
 } PostcopyState;
 
-/*
- * Allocate a page of memory that can be mapped at a later point in time
- * using postcopy_place_page
- * Returns: Pointer to allocated page
- */
-void *postcopy_get_tmp_page(MigrationIncomingState *mis);
-
 PostcopyState postcopy_state_get(void);
 /* Set the state and return the old state */
 PostcopyState postcopy_state_set(PostcopyState new_state,
diff --git a/migration/ram.c b/migration/ram.c
index 4c15162bd6..adbaf0b11a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4048,7 +4048,7 @@ static int ram_load_postcopy(QEMUFile *f)
     bool matches_target_page_size = false;
     MigrationIncomingState *mis = migration_incoming_get_current();
     /* Temporary page that is later 'placed' */
-    void *postcopy_host_page = postcopy_get_tmp_page(mis);
+    void *postcopy_host_page = mis->postcopy_tmp_page;
     void *last_host = NULL;
     bool all_zero = false;
 
-- 
2.17.1


