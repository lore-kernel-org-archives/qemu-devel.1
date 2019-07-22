Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17A4C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 06:25:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B4B0219BE
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 06:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B4B0219BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpRl4-0004rR-Go
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 02:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34170)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hpRkv-0004Sv-5k
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 02:25:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hpRku-0004fV-48
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 02:25:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:65115)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hpRkt-0004e7-Sm
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 02:25:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Jul 2019 23:25:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,294,1559545200"; d="scan'208";a="176902484"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by FMSMGA003.fm.intel.com with ESMTP; 21 Jul 2019 23:25:00 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Mon, 22 Jul 2019 14:24:35 +0800
Message-Id: <20190722062435.2518-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
Subject: [Qemu-devel] [PATCH] migration/multifd: multifd_load_cleanup()
 always return 0
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
Cc: Wei Yang <richardw.yang@linux.intel.com>, dgilbert@redhat.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

multifd_load_cleanup() always return 0 and never use the errp, just
cleanup a little.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 migration/migration.c | 9 ++-------
 migration/ram.c       | 7 +++----
 migration/ram.h       | 2 +-
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 27ca10122f..38d2fdfa73 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -399,10 +399,7 @@ static void process_incoming_migration_bh(void *opaque)
      */
     qemu_announce_self(&mis->announce_timer, migrate_announce_params());
 
-    if (multifd_load_cleanup(&local_err) != 0) {
-        error_report_err(local_err);
-        autostart = false;
-    }
+    multifd_load_cleanup();
     /* If global state section was not received or we are in running
        state, we need to obey autostart. Any other state is set with
        runstate_set. */
@@ -506,9 +503,7 @@ fail:
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_FAILED);
     qemu_fclose(mis->from_src_file);
-    if (multifd_load_cleanup(&local_err) != 0) {
-        error_report_err(local_err);
-    }
+    multifd_load_cleanup();
     exit(EXIT_FAILURE);
 }
 
diff --git a/migration/ram.c b/migration/ram.c
index 66792568e2..7d30f8484c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1243,13 +1243,12 @@ static void multifd_recv_terminate_threads(Error *err)
     }
 }
 
-int multifd_load_cleanup(Error **errp)
+void multifd_load_cleanup(void)
 {
     int i;
-    int ret = 0;
 
     if (!migrate_use_multifd()) {
-        return 0;
+        return;
     }
     multifd_recv_terminate_threads(NULL);
     for (i = 0; i < migrate_multifd_channels(); i++) {
@@ -1276,7 +1275,7 @@ int multifd_load_cleanup(Error **errp)
     g_free(multifd_recv_state);
     multifd_recv_state = NULL;
 
-    return ret;
+    return;
 }
 
 static void multifd_recv_sync_main(void)
diff --git a/migration/ram.h b/migration/ram.h
index e0a499b956..6fdd449899 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -44,7 +44,7 @@ uint64_t ram_bytes_total(void);
 int multifd_save_setup(void);
 void multifd_save_cleanup(void);
 int multifd_load_setup(void);
-int multifd_load_cleanup(Error **errp);
+void multifd_load_cleanup(void);
 bool multifd_recv_all_channels_created(void);
 bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
 
-- 
2.17.1


