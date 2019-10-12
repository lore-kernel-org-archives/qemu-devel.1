Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30986ECE58D
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 02:41:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A916206CD
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 02:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A916206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ7LF-0005Nq-VV
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 22:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iJ7KB-00045l-K2
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 22:40:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iJ7KA-0001Ij-FP
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 22:40:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:11741)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iJ7KA-0001Hj-84
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 22:40:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Oct 2019 19:40:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,286,1566889200"; d="scan'208";a="395935164"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga006.fm.intel.com with ESMTP; 11 Oct 2019 19:40:04 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: quintela@redhat.com,
	dgilbert@redhat.com
Subject: [PATCH 2/2] migration/compress: disable compress if failed to setup
Date: Sat, 12 Oct 2019 10:39:32 +0800
Message-Id: <20191012023932.1863-3-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191012023932.1863-1-richardw.yang@linux.intel.com>
References: <20191012023932.1863-1-richardw.yang@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
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

In current logic, if compress_threads_save_setup() returns -1 the whole
migration would fail, while we could handle it gracefully by disable
compress.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 migration/migration.c |  9 +++++++++
 migration/migration.h |  1 +
 migration/ram.c       | 15 ++++++++-------
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 5f7e4d15e9..02b95f4223 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2093,6 +2093,15 @@ bool migrate_use_compression(void)
     return s->enabled_capabilities[MIGRATION_CAPABILITY_COMPRESS];
 }
 
+void migrate_disable_compression(void)
+{
+    MigrationState *s;
+
+    s = migrate_get_current();
+
+    s->enabled_capabilities[MIGRATION_CAPABILITY_COMPRESS] = false;
+}
+
 int migrate_compress_level(void)
 {
     MigrationState *s;
diff --git a/migration/migration.h b/migration/migration.h
index 4f2fe193dc..51368d3a6e 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -309,6 +309,7 @@ bool migrate_use_return_path(void);
 uint64_t ram_get_total_transferred_pages(void);
 
 bool migrate_use_compression(void);
+void migrate_disable_compression(void);
 int migrate_compress_level(void);
 int migrate_compress_threads(void);
 int migrate_compress_wait_thread(void);
diff --git a/migration/ram.c b/migration/ram.c
index 96c9b16402..39279161a8 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -533,12 +533,12 @@ static void compress_threads_save_cleanup(void)
     comp_param = NULL;
 }
 
-static int compress_threads_save_setup(void)
+static void compress_threads_save_setup(void)
 {
     int i, thread_count;
 
     if (!migrate_use_compression()) {
-        return 0;
+        return;
     }
     thread_count = migrate_compress_threads();
     compress_threads = g_new0(QemuThread, thread_count);
@@ -569,11 +569,14 @@ static int compress_threads_save_setup(void)
                            do_data_compress, comp_param + i,
                            QEMU_THREAD_JOINABLE);
     }
-    return 0;
+    return;
 
 exit:
     compress_threads_save_cleanup();
-    return -1;
+    migrate_disable_compression();
+    error_report("%s: failed to setup compress threads, compress disabled",
+                 __func__);
+    return;
 }
 
 /* Multiple fd's */
@@ -3338,9 +3341,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     RAMState **rsp = opaque;
     RAMBlock *block;
 
-    if (compress_threads_save_setup()) {
-        return -1;
-    }
+    compress_threads_save_setup();
 
     /* migration has already setup the bitmap, reuse it. */
     if (!migration_in_colo_state()) {
-- 
2.17.1


