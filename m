Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A068C43457
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 04:18:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2B4820791
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 04:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B4820791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTdgG-0008Tk-UT
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 00:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kTdXg-0005td-Ho
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 00:10:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5239 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kTdXe-0007Gb-DE
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 00:10:04 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 7B63CD1119B5D6BEA59B;
 Sat, 17 Oct 2020 12:09:51 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Sat, 17 Oct 2020
 12:09:41 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [PATCH v3 02/18] migration/rdma: judge whether or not the RDMA is
 used for migration
Date: Sat, 17 Oct 2020 12:25:32 +0800
Message-ID: <1602908748-43335-3-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1602908748-43335-1-git-send-email-zhengchuan@huawei.com>
References: <1602908748-43335-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=zhengchuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/17 00:09:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: yubihong@huawei.com, zhang.zhanghailiang@huawei.com, fengzhimin1@huawei.com,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, alex.chen@huawei.com,
 wanghao232@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add enabled_rdma_migration into MigrationState to judge
whether or not the RDMA is used for migration.

Signed-off-by: Zhimin Feng <fengzhimin1@huawei.com>
Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
---
 migration/migration.c | 13 +++++++++++++
 migration/migration.h |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 64ae417..be6166a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -389,7 +389,9 @@ void migrate_add_address(SocketAddress *address)
 void qemu_start_incoming_migration(const char *uri, Error **errp)
 {
     const char *p = NULL;
+    MigrationState *s = migrate_get_current();
 
+    s->enabled_rdma_migration = false;
     qapi_event_send_migration(MIGRATION_STATUS_SETUP);
     if (!strcmp(uri, "defer")) {
         deferred_incoming_migration(errp);
@@ -399,6 +401,7 @@ void qemu_start_incoming_migration(const char *uri, Error **errp)
         socket_start_incoming_migration(p ? p : uri, errp);
 #ifdef CONFIG_RDMA
     } else if (strstart(uri, "rdma:", &p)) {
+        s->enabled_rdma_migration = true;
         rdma_start_incoming_migration(p, errp);
 #endif
     } else if (strstart(uri, "exec:", &p)) {
@@ -1887,6 +1890,7 @@ void migrate_init(MigrationState *s)
     s->start_postcopy = false;
     s->postcopy_after_devices = false;
     s->migration_thread_running = false;
+    s->enabled_rdma_migration = false;
     error_free(s->error);
     s->error = NULL;
     s->hostname = NULL;
@@ -2115,6 +2119,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
         socket_start_outgoing_migration(s, p ? p : uri, &local_err);
 #ifdef CONFIG_RDMA
     } else if (strstart(uri, "rdma:", &p)) {
+        s->enabled_rdma_migration = true;
         rdma_start_outgoing_migration(s, p, &local_err);
 #endif
     } else if (strstart(uri, "exec:", &p)) {
@@ -2329,6 +2334,14 @@ bool migrate_use_events(void)
     return s->enabled_capabilities[MIGRATION_CAPABILITY_EVENTS];
 }
 
+bool migrate_use_rdma(void)
+{
+    MigrationState *s;
+    s = migrate_get_current();
+
+    return s->enabled_rdma_migration;
+}
+
 bool migrate_use_rdma_pin_all(void)
 {
     MigrationState *s;
diff --git a/migration/migration.h b/migration/migration.h
index 74fd790..e92eb29 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -264,6 +264,11 @@ struct MigrationState
      * This save hostname when out-going migration starts
      */
     char *hostname;
+
+    /*
+     * Enable RDMA migration
+     */
+    bool enabled_rdma_migration;
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
@@ -300,6 +305,7 @@ bool migrate_ignore_shared(void);
 bool migrate_validate_uuid(void);
 
 bool migrate_auto_converge(void);
+bool migrate_use_rdma(void);
 bool migrate_use_rdma_pin_all(void);
 bool migrate_use_multifd(void);
 bool migrate_pause_before_switchover(void);
-- 
1.8.3.1


