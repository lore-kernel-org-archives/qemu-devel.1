Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1B6C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 03:03:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97B59206EB
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 03:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B59206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzATL-000197-Sq
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 23:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1jzAPV-000273-Ra
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 22:59:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4157 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1jzAPQ-0000l7-Sd
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 22:59:41 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 495B34E2B397365D759E;
 Sat, 25 Jul 2020 10:59:33 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Sat, 25 Jul 2020
 10:59:23 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [RFC PATCH 6/8] migration/dirtyrate: Implement
 get_sample_gap_period() and block_sample_gap_period()
Date: Sat, 25 Jul 2020 11:11:07 +0800
Message-ID: <1595646669-109310-7-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1595646669-109310-1-git-send-email-zhengchuan@huawei.com>
References: <1595646669-109310-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=zhengchuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 22:59:33
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

Implement get_sample_gap_period() and block_sample_gap_period() to
sleep specific time between sample actions.

Signed-off-by: Zheng Chuan <zhengchuan@huawei.com>
Signed-off-by: YanYing Zhang <ann.zhuangyanying@huawei.com>
---
 migration/dirtyrate.c | 28 ++++++++++++++++++++++++++++
 migration/dirtyrate.h |  6 +++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 7badc53..00abfa7 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -295,10 +295,38 @@ static void set_dirty_rate_stage(CalculatingDirtyRateStage ratestage)
     calculating_dirty_rate_stage = ratestage;
 }
 
+static int64_t block_sample_gap_period(int64_t msec, int64_t initial_time)
+{
+    int64_t current_time;
+
+    current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    if ((current_time - initial_time) >= msec) {
+        msec = current_time - initial_time;
+    } else {
+        g_usleep((msec + initial_time - current_time) * 1000);
+    }
+
+    return msec;
+}
+
+static int64_t get_sample_gap_period(struct dirtyrate_config config)
+{
+    int64_t msec;
+
+    msec = config.sample_period_seconds * 1000;
+    if (msec <= MIN_FETCH_DIRTYRATE_TIME_MSEC || msec > MAX_FETCH_DIRTYRATE_TIME_MSEC) {
+        msec = DEFAULT_FETCH_DIRTYRATE_TIME_MSEC;
+    }
+    return msec;
+}
+
 void *get_dirtyrate_thread(void *arg)
 {
     struct dirtyrate_config config = *(struct dirtyrate_config *)arg;
     int64_t msec = 0;
+
+    /* max period is 60 seconds */
+    msec = get_sample_gap_period(config);
  
     set_dirty_rate_stage(CAL_DIRTY_RATE_ING);
 
diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
index 4d9b3b8..5aef2d7 100644
--- a/migration/dirtyrate.h
+++ b/migration/dirtyrate.h
@@ -14,12 +14,16 @@
 #define QEMU_MIGRATION_DIRTYRATE_H
 
 /* take 256 pages per GB for cal dirty rate */
-#define DIRTYRATE_DEFAULT_SAMPLE_PAGES    256
+#define DIRTYRATE_DEFAULT_SAMPLE_PAGES  256
 #define DIRTYRATE_SAMPLE_PAGE_SIZE      4096
 #define DIRTYRATE_PAGE_SIZE_SHIFT       12
 #define BLOCK_INFO_MAX_LEN              256
 #define PAGE_SIZE_SHIFT                 20
 
+#define MIN_FETCH_DIRTYRATE_TIME_MSEC        0
+#define MAX_FETCH_DIRTYRATE_TIME_MSEC        60000
+#define DEFAULT_FETCH_DIRTYRATE_TIME_MSEC    1000
+
 struct dirtyrate_config {
     uint64_t sample_pages_per_gigabytes;
     int64_t sample_period_seconds;
-- 
1.8.3.1


