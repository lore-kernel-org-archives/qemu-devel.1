Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E86C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:15:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3983C208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3983C208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIQiw-0003Ex-Pr
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 02:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kIQfH-0006jf-EC
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:11:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37012 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kIQfD-0005XT-3t
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:11:35 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 0DCE61D0AF18F228603E;
 Wed, 16 Sep 2020 14:11:25 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 16 Sep 2020
 14:11:17 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <eblake@redhat.com>, <dgilbert@redhat.com>,
 <berrange@redhat.com>
Subject: [PATCH v10 04/12] migration/dirtyrate: Add dirtyrate statistics
 series functions
Date: Wed, 16 Sep 2020 14:21:59 +0800
Message-ID: <1600237327-33618-5-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1600237327-33618-1-git-send-email-zhengchuan@huawei.com>
References: <1600237327-33618-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=zhengchuan@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:11:25
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
Cc: zhengchuan@huawei.com, zhang.zhanghailiang@huawei.com, liq3ea@gmail.com,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, alex.chen@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add dirtyrate statistics functions to record/update dirtyrate info.

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
---
 migration/dirtyrate.c | 32 ++++++++++++++++++++++++++++++++
 migration/dirtyrate.h | 12 ++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 7bea8ff..ab372ba 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -23,6 +23,7 @@
 #include "dirtyrate.h"
 
 static int CalculatingState = DIRTY_RATE_STATUS_UNSTARTED;
+static struct DirtyRateStat DirtyStat;
 
 static int dirtyrate_set_state(int *state, int old_state, int new_state)
 {
@@ -34,6 +35,37 @@ static int dirtyrate_set_state(int *state, int old_state, int new_state)
     }
 }
 
+static void reset_dirtyrate_stat(void)
+{
+    DirtyStat.total_dirty_samples = 0;
+    DirtyStat.total_sample_count = 0;
+    DirtyStat.total_block_mem_MB = 0;
+    DirtyStat.dirty_rate = -1;
+    DirtyStat.start_time = 0;
+    DirtyStat.calc_time = 0;
+}
+
+static void update_dirtyrate_stat(struct RamblockDirtyInfo *info)
+{
+    DirtyStat.total_dirty_samples += info->sample_dirty_count;
+    DirtyStat.total_sample_count += info->sample_pages_count;
+    /* size of total pages in MB */
+    DirtyStat.total_block_mem_MB += (info->ramblock_pages *
+                                     TARGET_PAGE_SIZE) >> 20;
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
+                1000 / (total_sample_count * msec);
+
+    DirtyStat.dirty_rate = dirtyrate;
+}
 
 static void calculate_dirtyrate(struct DirtyRateConfig config)
 {
diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
index 479e222..a3ee305 100644
--- a/migration/dirtyrate.h
+++ b/migration/dirtyrate.h
@@ -42,6 +42,18 @@ struct RamblockDirtyInfo {
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
+    int64_t start_time; /* calculation start time in units of second */
+    int64_t calc_time; /* time duration of two sampling in units of second */
+};
+
 void *get_dirtyrate_thread(void *arg);
 #endif
 
-- 
1.8.3.1


