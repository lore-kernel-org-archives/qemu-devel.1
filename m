Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29612C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 01:32:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03E2620738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 01:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E2620738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kANog-0006YJ-3K
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 21:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kANno-0004tJ-5l
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 21:31:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4209 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kANnj-0005pe-IA
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 21:31:07 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 405201C9C8AF9ADF5ECF;
 Tue, 25 Aug 2020 09:30:57 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Tue, 25 Aug 2020
 09:30:50 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <eblake@redhat.com>, <dgilbert@redhat.com>,
 <berrange@redhat.com>
Subject: [PATCH v5 04/12] migration/dirtyrate: Add dirtyrate statistics series
 functions
Date: Tue, 25 Aug 2020 09:40:42 +0800
Message-ID: <1598319650-36762-5-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1598319650-36762-1-git-send-email-zhengchuan@huawei.com>
References: <1598319650-36762-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=zhengchuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 21:30:58
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
Cc: zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, alex.chen@huawei.com, ann.zhuangyanying@huawei.com,
 fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add dirtyrate statistics to record/update dirtyrate info.

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
---
 migration/dirtyrate.c | 29 +++++++++++++++++++++++++++++
 migration/dirtyrate.h | 10 ++++++++++
 2 files changed, 39 insertions(+)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 91987c5..0d7163f 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -24,6 +24,7 @@
 #include "dirtyrate.h"
 
 static int CalculatingState = DIRTY_RATE_STATUS_UNSTARTED;
+static struct DirtyRateStat DirtyStat;
 
 static int dirtyrate_set_state(int *state, int old_state, int new_state)
 {
@@ -35,6 +36,34 @@ static int dirtyrate_set_state(int *state, int old_state, int new_state)
     }
 }
 
+static void reset_dirtyrate_stat(void)
+{
+    DirtyStat.total_dirty_samples = 0;
+    DirtyStat.total_sample_count = 0;
+    DirtyStat.total_block_mem_MB = 0;
+    DirtyStat.dirty_rate = 0;
+}
+
+static void update_dirtyrate_stat(struct RamblockDirtyInfo *info)
+{
+    DirtyStat.total_dirty_samples += info->sample_dirty_count;
+    DirtyStat.total_sample_count += info->sample_pages_count;
+    /* size of 4K pages in MB */
+    DirtyStat.total_block_mem_MB += info->ramblock_pages / 256;
+}
+
+static void update_dirtyrate(uint64_t msec)
+{
+    uint64_t dirtyrate;
+    uint64_t total_dirty_samples = DirtyStat.total_dirty_samples;
+    uint64_t total_sample_count = DirtyStat.total_sample_count;
+    uint64_t total_block_mem_MB = DirtyStat.total_block_mem_MB;
+
+    dirtyrate = total_dirty_samples * total_block_mem_MB *
+                 1000 / (total_sample_count * msec);
+
+    DirtyStat.dirty_rate = dirtyrate;
+}
 
 static void calculate_dirtyrate(struct DirtyRateConfig config)
 {
diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
index dc45419..8e25d93 100644
--- a/migration/dirtyrate.h
+++ b/migration/dirtyrate.h
@@ -45,6 +45,16 @@ struct RamblockDirtyInfo {
     uint32_t *hash_result; /* array of hash result for sampled pages */
 };
 
+/*
+ * Store calculation statistics for each measure.
+ */
+struct DirtyRateStat {
+    uint64_t total_dirty_samples; /* total dirty sampled page */
+    uint64_t total_sample_count; /* total sampled pages */
+    uint64_t total_block_mem_MB; /* size of total sampled pages in MB */
+    int64_t dirty_rate; /* dirty rate in MB/s */
+};
+
 void *get_dirtyrate_thread(void *arg);
 #endif
 
-- 
1.8.3.1


