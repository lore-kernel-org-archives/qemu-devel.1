Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52FEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:07:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACEF62065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACEF62065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jglqI-00010O-Uw
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 05:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jglpX-00080n-4m
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:06:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:40868)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jglpW-0005Cp-3J
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:06:30 -0400
IronPort-SDR: 0TQCSS6pdRnAHi+DLVYjjC/HeYotgNmtDwYXvJN9wi1OkrkMBTSwkLRSWWCEjCadVKSULoHtpc
 0Z2D475KUIvQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2020 02:06:27 -0700
IronPort-SDR: GPijHCpiLEAvC0VJQ4Totl4jIfZ61qD6Yi2YsuKcIaGxk0qAnb/crfQKXV3VkZ0OqUwXbbxIg4
 FYndGz2OUjAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,471,1583222400"; d="scan'208";a="416847115"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by orsmga004.jf.intel.com with ESMTP; 04 Jun 2020 02:06:25 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>
Subject: [PATCH V2 1/2] migration/colo: Optimize COLO boot code path
Date: Thu,  4 Jun 2020 16:55:32 +0800
Message-Id: <20200604085533.7769-2-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200604085533.7769-1-chen.zhang@intel.com>
References: <20200604085533.7769-1-chen.zhang@intel.com>
Received-SPF: pass client-ip=134.134.136.31; envelope-from=chen.zhang@intel.com;
 helo=mga06.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 05:06:26
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, FROM_ADDR_WS=2.999,
 FROM_WSP_TRAIL=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Zhang Chen <chen.zhang@intel.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhang Chen <chen.zhang@intel.com>

No need to reuse MIGRATION_STATUS_ACTIVE boot COLO.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 migration/colo.c      |  2 --
 migration/migration.c | 17 ++++++++++-------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index ea7d1e9d4e..91c76789fa 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -670,8 +670,6 @@ void migrate_start_colo_process(MigrationState *s)
                                 colo_checkpoint_notify, s);
 
     qemu_sem_init(&s->colo_exit_sem, 0);
-    migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
-                      MIGRATION_STATUS_COLO);
     colo_process_checkpoint(s);
     qemu_mutex_lock_iothread();
 }
diff --git a/migration/migration.c b/migration/migration.c
index b63ad91d34..7f3f82a715 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2972,7 +2972,10 @@ static void migration_completion(MigrationState *s)
         goto fail_invalidate;
     }
 
-    if (!migrate_colo_enabled()) {
+    if (migrate_colo_enabled()) {
+        migrate_set_state(&s->state, current_active_state,
+                          MIGRATION_STATUS_COLO);
+    } else {
         migrate_set_state(&s->state, current_active_state,
                           MIGRATION_STATUS_COMPLETED);
     }
@@ -3304,12 +3307,7 @@ static void migration_iteration_finish(MigrationState *s)
         migration_calculate_complete(s);
         runstate_set(RUN_STATE_POSTMIGRATE);
         break;
-
-    case MIGRATION_STATUS_ACTIVE:
-        /*
-         * We should really assert here, but since it's during
-         * migration, let's try to reduce the usage of assertions.
-         */
+    case MIGRATION_STATUS_COLO:
         if (!migrate_colo_enabled()) {
             error_report("%s: critical error: calling COLO code without "
                          "COLO enabled", __func__);
@@ -3319,6 +3317,11 @@ static void migration_iteration_finish(MigrationState *s)
          * Fixme: we will run VM in COLO no matter its old running state.
          * After exited COLO, we will keep running.
          */
+    case MIGRATION_STATUS_ACTIVE:
+        /*
+         * We should really assert here, but since it's during
+         * migration, let's try to reduce the usage of assertions.
+         */
         s->vm_was_running = true;
         /* Fallthrough */
     case MIGRATION_STATUS_FAILED:
-- 
2.17.1


