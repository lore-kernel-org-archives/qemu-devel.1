Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CFEC4727E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 03:34:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 438BC20BED
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 03:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438BC20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN6P1-0006F8-4T
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 23:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kN6N9-0004SS-St
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 23:32:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5152 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kN6N7-0001h1-JR
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 23:32:11 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id F3CB7CB6FDBEFCDFBD6E;
 Tue, 29 Sep 2020 11:32:04 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 29 Sep 2020
 11:31:56 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <eblake@redhat.com>, <dgilbert@redhat.com>,
 <berrange@redhat.com>
Subject: [PATCH v2 1/2] migration/dirtyrate: record start_time and calc_time
 while at the measuring state
Date: Tue, 29 Sep 2020 11:42:17 +0800
Message-ID: <1601350938-128320-2-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1601350938-128320-1-git-send-email-zhengchuan@huawei.com>
References: <1601350938-128320-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=zhengchuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 23:32:05
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
Cc: alex.chen@huawei.com, zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, david.edmondson@oracle.com, wanghao232@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Querying could include both the start-time and the calc-time while at the measuring
state, allowing a caller to determine when they should expect to come back looking
for a result.

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
---
 migration/dirtyrate.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 68577ef..40e41e7 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -83,14 +83,14 @@ static struct DirtyRateInfo *query_dirty_rate_info(void)
     return info;
 }
 
-static void reset_dirtyrate_stat(void)
+static void init_dirtyrate_stat(int64_t start_time, int64_t calc_time)
 {
     DirtyStat.total_dirty_samples = 0;
     DirtyStat.total_sample_count = 0;
     DirtyStat.total_block_mem_MB = 0;
     DirtyStat.dirty_rate = -1;
-    DirtyStat.start_time = 0;
-    DirtyStat.calc_time = 0;
+    DirtyStat.start_time = start_time;
+    DirtyStat.calc_time = calc_time;
 }
 
 static void update_dirtyrate_stat(struct RamblockDirtyInfo *info)
@@ -335,7 +335,6 @@ static void calculate_dirtyrate(struct DirtyRateConfig config)
     int64_t initial_time;
 
     rcu_register_thread();
-    reset_dirtyrate_stat();
     rcu_read_lock();
     initial_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     if (!record_ramblock_hash_info(&block_dinfo, config, &block_count)) {
@@ -365,6 +364,8 @@ void *get_dirtyrate_thread(void *arg)
 {
     struct DirtyRateConfig config = *(struct DirtyRateConfig *)arg;
     int ret;
+    int64_t start_time;
+    int64_t calc_time;
 
     ret = dirtyrate_set_state(&CalculatingState, DIRTY_RATE_STATUS_UNSTARTED,
                               DIRTY_RATE_STATUS_MEASURING);
@@ -373,6 +374,10 @@ void *get_dirtyrate_thread(void *arg)
         return NULL;
     }
 
+    start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) / 1000;
+    calc_time = config.sample_period_seconds;
+    init_dirtyrate_stat(start_time, calc_time);
+
     calculate_dirtyrate(config);
 
     ret = dirtyrate_set_state(&CalculatingState, DIRTY_RATE_STATUS_MEASURING,
-- 
1.8.3.1


