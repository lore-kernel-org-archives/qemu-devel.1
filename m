Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C228C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CEDC20657
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CEDC20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy9st-0002aY-II
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 04:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jy9qt-0007iz-5Q
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:11:47 -0400
Received: from relay.sw.ru ([185.231.240.75]:54958 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jy9qq-0004p5-N1
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:11:46 -0400
Received: from [10.94.4.71] (helo=dptest2.qa.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jy9ql-0002yK-Ql; Wed, 22 Jul 2020 11:11:39 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v0 2/4] migration: add background snapshot capability
Date: Wed, 22 Jul 2020 11:11:31 +0300
Message-Id: <20200722081133.29926-3-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200722081133.29926-1-dplotnikov@virtuozzo.com>
References: <20200722081133.29926-1-dplotnikov@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=dplotnikov@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 04:11:41
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_BL_SPAMCOP_NET=1.347,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com,
 armbru@redhat.com, den@openvz.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The capability is used for background snapshot enabling.
The background snapshot logic is going to be added in the following
patch.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 qapi/migration.json   |  7 ++++++-
 migration/migration.h |  1 +
 migration/migration.c | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index d5000558c6..46681a5c3c 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -424,6 +424,11 @@
 # @validate-uuid: Send the UUID of the source to allow the destination
 #                 to ensure it is the same. (since 4.2)
 #
+# @background-snapshot: If enabled, the migration stream will be a snapshot
+#                       of the VM exactly at the point when the migration
+#                       procedure starts. The VM RAM is saved with running VM.
+#                       (since 5.2)
+#
 # Since: 1.2
 ##
 { 'enum': 'MigrationCapability',
@@ -431,7 +436,7 @@
            'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
            'block', 'return-path', 'pause-before-switchover', 'multifd',
            'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
-           'x-ignore-shared', 'validate-uuid' ] }
+           'x-ignore-shared', 'validate-uuid', 'background-snapshot' ] }
 
 ##
 # @MigrationCapabilityStatus:
diff --git a/migration/migration.h b/migration/migration.h
index f617960522..63f2fde9a3 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -322,6 +322,7 @@ int migrate_compress_wait_thread(void);
 int migrate_decompress_threads(void);
 bool migrate_use_events(void);
 bool migrate_postcopy_blocktime(void);
+bool migrate_background_snapshot(void);
 
 /* Sending on the return path - generic and then for each message type */
 void migrate_send_rp_shut(MigrationIncomingState *mis,
diff --git a/migration/migration.c b/migration/migration.c
index 2ed9923227..2ec0451abe 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1086,6 +1086,32 @@ static bool migrate_caps_check(bool *cap_list,
             error_setg(errp, "Postcopy is not compatible with ignore-shared");
             return false;
         }
+
+        if (cap_list[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT]) {
+            error_setg(errp, "Postcopy is not compatible "
+                        "with background snapshot");
+            return false;
+        }
+    }
+
+    if (cap_list[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT]) {
+        if (cap_list[MIGRATION_CAPABILITY_RELEASE_RAM]) {
+            error_setg(errp, "Background snapshot is not compatible "
+                        "with release ram capability");
+            return false;
+        }
+
+        if (cap_list[MIGRATION_CAPABILITY_COMPRESS]) {
+            error_setg(errp, "Background snapshot is not "
+                        "currently compatible with compression");
+            return false;
+        }
+
+        if (cap_list[MIGRATION_CAPABILITY_XBZRLE]) {
+            error_setg(errp, "Background snapshot is not "
+                        "currently compatible with XBZLRE");
+            return false;
+        }
     }
 
     return true;
@@ -2390,6 +2416,15 @@ bool migrate_use_block_incremental(void)
     return s->parameters.block_incremental;
 }
 
+bool migrate_background_snapshot(void)
+{
+    MigrationState *s;
+
+    s = migrate_get_current();
+
+    return s->enabled_capabilities[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT];
+}
+
 /* migration thread support */
 /*
  * Something bad happened to the RP stream, mark an error
-- 
2.17.0


