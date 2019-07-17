Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DE1C7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 00:54:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 907F120818
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 00:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 907F120818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnYD8-0005ke-K1
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 20:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55810)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hnYCy-0005G7-4j
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 20:54:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hnYCw-0007sq-Sz
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 20:54:12 -0400
Received: from mga04.intel.com ([192.55.52.120]:51834)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hnYCw-0007rY-IG
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 20:54:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Jul 2019 17:54:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,272,1559545200"; d="scan'208";a="178728614"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga002.jf.intel.com with ESMTP; 16 Jul 2019 17:54:06 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 08:53:41 +0800
Message-Id: <20190717005341.14140-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
Subject: [Qemu-devel] [PATCH] migration: use migration_is_active to
 represent active state
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

Wrap the check into a function to make it easy to read.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 include/migration/misc.h |  1 +
 migration/migration.c    | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 5cdbabd094..42d6abc920 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -61,6 +61,7 @@ void migration_object_init(void);
 void migration_shutdown(void);
 void qemu_start_incoming_migration(const char *uri, Error **errp);
 bool migration_is_idle(void);
+bool migration_is_active(MigrationState *);
 void add_migration_state_change_notifier(Notifier *notify);
 void remove_migration_state_change_notifier(Notifier *notify);
 bool migration_in_setup(MigrationState *);
diff --git a/migration/migration.c b/migration/migration.c
index 43fd8297ef..4c066fc85c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1529,8 +1529,7 @@ static void migrate_fd_cleanup(MigrationState *s)
         qemu_fclose(tmp);
     }
 
-    assert((s->state != MIGRATION_STATUS_ACTIVE) &&
-           (s->state != MIGRATION_STATUS_POSTCOPY_ACTIVE));
+    assert(!migration_is_active(s));
 
     if (s->state == MIGRATION_STATUS_CANCELLING) {
         migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING,
@@ -1690,6 +1689,12 @@ bool migration_is_idle(void)
     return false;
 }
 
+bool migration_is_active(MigrationState *s)
+{
+    return (s->state == MIGRATION_STATUS_ACTIVE ||
+            s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
+}
+
 void migrate_init(MigrationState *s)
 {
     /*
@@ -3226,8 +3231,7 @@ static void *migration_thread(void *opaque)
 
     trace_migration_thread_setup_complete();
 
-    while (s->state == MIGRATION_STATUS_ACTIVE ||
-           s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
+    while (migration_is_active(s)) {
         int64_t current_time;
 
         if (urgent || !qemu_file_rate_limit(s->to_dst_file)) {
-- 
2.17.1


