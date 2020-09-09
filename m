Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0C0C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 14:46:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33E9C20758
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 14:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E9C20758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG1Ma-0002C8-Mz
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 10:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kG1Ii-0002Nh-Cj
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 10:42:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4683 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kG1Ig-00070l-Ah
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 10:42:19 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id EB2C86CC4B218949602A;
 Wed,  9 Sep 2020 22:42:07 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Sep 2020
 22:41:57 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <eblake@redhat.com>, <dgilbert@redhat.com>,
 <berrange@redhat.com>
Subject: [PATCH v1 1/7] migration/tls: save hostname into MigrationState
Date: Wed, 9 Sep 2020 22:52:51 +0800
Message-ID: <1599663177-53993-2-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1599663177-53993-1-git-send-email-zhengchuan@huawei.com>
References: <1599663177-53993-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=zhengchuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 10:42:09
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
Cc: zhengchuan@huawei.com, zhang.zhanghailiang@huawei.com, yuxiating@huawei.com,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, alex.chen@huawei.com,
 jinyan12@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

hostname is need in multifd-tls, save hostname into MigrationState

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
Signed-off-by: Yan Jin <jinyan12@huawei.com>
---
 migration/channel.c   | 5 +++++
 migration/migration.c | 1 +
 migration/migration.h | 5 +++++
 3 files changed, 11 insertions(+)

diff --git a/migration/channel.c b/migration/channel.c
index 20e4c8e..2af3069 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -66,6 +66,11 @@ void migration_channel_connect(MigrationState *s,
     trace_migration_set_outgoing_channel(
         ioc, object_get_typename(OBJECT(ioc)), hostname, error);
 
+    /* Save hostname into MigrationState for handshake */
+    if (hostname) {
+        s->hostname = g_strdup(hostname);
+    }
+
     if (!error) {
         if (s->parameters.tls_creds &&
             *s->parameters.tls_creds &&
diff --git a/migration/migration.c b/migration/migration.c
index 58a5452..e20b778 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1883,6 +1883,7 @@ void migrate_init(MigrationState *s)
     s->migration_thread_running = false;
     error_free(s->error);
     s->error = NULL;
+    s->hostname = NULL;
 
     migrate_set_state(&s->state, MIGRATION_STATUS_NONE, MIGRATION_STATUS_SETUP);
 
diff --git a/migration/migration.h b/migration/migration.h
index ae497bd..758f803 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -261,6 +261,11 @@ struct MigrationState
      * (which is in 4M chunk).
      */
     uint8_t clear_bitmap_shift;
+
+    /*
+     * This save hostname when out-going migration starts
+     */
+    char *hostname;
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
-- 
1.8.3.1


