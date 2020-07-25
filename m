Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4608DC433E4
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 03:00:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E542206EB
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 03:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E542206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzAQX-0003uu-7k
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 23:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1jzAPU-00024a-7K
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 22:59:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33220 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1jzAPQ-0000k5-Mn
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 22:59:39 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 32288D51536A426CC409;
 Sat, 25 Jul 2020 10:59:28 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Sat, 25 Jul 2020
 10:59:22 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [RFC PATCH 3/8] migration/dirtyrate: Add dirtyrate statistics series
 functions
Date: Sat, 25 Jul 2020 11:11:04 +0800
Message-ID: <1595646669-109310-4-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1595646669-109310-1-git-send-email-zhengchuan@huawei.com>
References: <1595646669-109310-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=zhengchuan@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 22:59:28
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
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
Cc: zhang.zhanghailiang@huawei.com, linyilu@huawei.com, qemu-devel@nongnu.org,
 alex.chen@huawei.com, ann.zhuangyanying@huawei.com, fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zheng Chuan <zhengchuan@huawei.com>

Add dirtyrate statistics to record/update dirtyrate info.

Signed-off-by: Zheng Chuan <zhengchuan@huawei.com>
Signed-off-by: YanYing Zhang <ann.zhuangyanying@huawei.com>
---
 migration/dirtyrate.c | 47 ++++++++++++++++++++++++++++++-----------------
 migration/dirtyrate.h | 11 +++++++++++
 2 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index fc652fb..6baf674 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -13,19 +13,41 @@
 #include "dirtyrate.h"
 
 static uint64_t sample_pages_per_gigabytes = DIRTYRATE_DEFAULT_SAMPLE_PAGES;
-static uint64_t dirty_rate; /* MB/s */
+static struct dirtyrate_statistics dirty_stat;
 CalculatingDirtyRateStage calculating_dirty_rate_stage = CAL_DIRTY_RATE_INIT;
 
-static bool calculate_dirtyrate(struct dirtyrate_config config,
-                        uint64_t *dirty_rate, int64_t time)
+static void reset_dirtyrate_stat(void)
 {
-    /* todo */
-    return true;
+    dirty_stat.total_dirty_samples = 0;
+    dirty_stat.total_sample_count = 0;
+    dirty_stat.total_block_mem_MB = 0;
+    dirty_stat.dirty_rate = 0;
+}
+
+static void update_dirtyrate_stat(struct block_dirty_info *info)
+{
+    dirty_stat.total_dirty_samples += info->sample_dirty_count;
+    dirty_stat.total_sample_count += info->sample_pages_count;
+    dirty_stat.total_block_mem_MB += (info->block_pages << DIRTYRATE_PAGE_SIZE_SHIFT) >> PAGE_SIZE_SHIFT;
 }
 
-static void set_dirty_rate(uint64_t drate)
+static void update_dirtyrate(int64_t msec)
 {
-    dirty_rate = drate;
+    uint64_t dirty_rate;
+    unsigned int total_dirty_samples = dirty_stat.total_dirty_samples;
+    unsigned int total_sample_count = dirty_stat.total_sample_count;
+    unsigned long total_block_mem_MB = dirty_stat.total_block_mem_MB;
+
+    dirty_rate = total_dirty_samples * total_block_mem_MB *
+                 1000 / (total_sample_count * msec);
+
+    dirty_stat.dirty_rate = dirty_rate;
+}
+
+
+static void calculate_dirtyrate(struct dirtyrate_config config, int64_t time)
+{
+    /* todo */
 }
 
 /*
@@ -42,21 +64,12 @@ static void set_dirty_rate_stage(CalculatingDirtyRateStage ratestage)
 void *get_dirtyrate_thread(void *arg)
 {
     struct dirtyrate_config config = *(struct dirtyrate_config *)arg;
-    uint64_t dirty_rate;
-    uint64_t hash_dirty_rate;
-    bool query_succ;
     int64_t msec = 0;
  
     set_dirty_rate_stage(CAL_DIRTY_RATE_ING);
 
-    query_succ = calculate_dirtyrate(config, &hash_dirty_rate, msec);
-    if (!query_succ) {
-        dirty_rate = 0;
-    } else {
-        dirty_rate = hash_dirty_rate;
-    }
+    calculate_dirtyrate(config, msec);
 
-    set_dirty_rate(dirty_rate);
     set_dirty_rate_stage(CAL_DIRTY_RATE_END);
 
     return NULL;
diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
index 342b89f..2994535 100644
--- a/migration/dirtyrate.h
+++ b/migration/dirtyrate.h
@@ -15,6 +15,9 @@
 
 /* take 256 pages per GB for cal dirty rate */
 #define DIRTYRATE_DEFAULT_SAMPLE_PAGES    256
+#define DIRTYRATE_PAGE_SIZE_SHIFT       12
+#define BLOCK_INFO_MAX_LEN              256
+#define PAGE_SIZE_SHIFT                 20
 
 struct dirtyrate_config {
     uint64_t sample_pages_per_gigabytes;
@@ -33,6 +36,14 @@ typedef enum {
     CAL_DIRTY_RATE_END   = 2,
 } CalculatingDirtyRateStage;
 
+struct dirtyrate_statistics {
+    unsigned int total_dirty_samples;
+    unsigned int total_sample_count;
+    unsigned long total_block_mem_MB;
+    int64_t dirty_rate;
+};
+
+
 /* 
  * Store dirtypage info for each block.
  */
-- 
1.8.3.1


