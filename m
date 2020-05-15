Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81891C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 04:40:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56B98206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 04:40:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B98206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZS8j-0000LM-If
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 00:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jZS7Y-0007gw-GV
 for qemu-devel@nongnu.org; Fri, 15 May 2020 00:38:52 -0400
Received: from mga12.intel.com ([192.55.52.136]:45610)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jZS7W-0007bS-P8
 for qemu-devel@nongnu.org; Fri, 15 May 2020 00:38:51 -0400
IronPort-SDR: Cik33kwohMCBEVjstyJBBnTS0s8KR56j0zWX1j3D3oQCrk2cvwZsus+B2agWzxWEOsLsna6NSI
 yWGjVk3M+W2w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2020 21:38:47 -0700
IronPort-SDR: E9lrJQFjdy4w0aWC5ksuBarHrbvT6jj9GapituklWZPvNMCwgxx/6O8xG/usa/qggzzyOjHfWS
 pGhC6Yvo3A4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,394,1583222400"; d="scan'208";a="263069534"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by orsmga003.jf.intel.com with ESMTP; 14 May 2020 21:38:45 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 qemu-dev <qemu-devel@nongnu.org>
Subject: [PATCH  1/3] migration/colo: Optimize COLO boot code path
Date: Fri, 15 May 2020 12:28:16 +0800
Message-Id: <20200515042818.17908-2-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200515042818.17908-1-chen.zhang@intel.com>
References: <20200515042818.17908-1-chen.zhang@intel.com>
Received-SPF: pass client-ip=192.55.52.136; envelope-from=chen.zhang@intel.com;
 helo=mga12.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:38:46
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, FROM_ADDR_WS=2.999,
 FROM_WSP_TRAIL=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhang Chen <chen.zhang@intel.com>

No need to reuse MIGRATION_STATUS_ACTIVE boot COLO.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 migration/colo.c      |  2 --
 migration/migration.c | 17 ++++++++++-------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index d015d4f84e..5ef69b885d 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -669,8 +669,6 @@ void migrate_start_colo_process(MigrationState *s)
                                 colo_checkpoint_notify, s);
 
     qemu_sem_init(&s->colo_exit_sem, 0);
-    migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
-                      MIGRATION_STATUS_COLO);
     colo_process_checkpoint(s);
     qemu_mutex_lock_iothread();
 }
diff --git a/migration/migration.c b/migration/migration.c
index 0bb042a0f7..c889ef6eb7 100644
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


