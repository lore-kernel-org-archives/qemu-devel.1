Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A42AC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 03:03:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B275206EB
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 03:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B275206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzATI-00011x-F7
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 23:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1jzAPW-00029S-S0
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 22:59:42 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33320 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1jzAPU-0000m7-Qa
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 22:59:42 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 756EF6A0080683C96539;
 Sat, 25 Jul 2020 10:59:33 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Sat, 25 Jul 2020
 10:59:24 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [RFC PATCH 7/8] migration/dirtyrate: Implement calculate_dirtyrate()
 function
Date: Sat, 25 Jul 2020 11:11:08 +0800
Message-ID: <1595646669-109310-8-git-send-email-zhengchuan@huawei.com>
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

Implement calculate_dirtyrate() function.

Signed-off-by: Zheng Chuan <zhengchuan@huawei.com>
Signed-off-by: YanYing Zhang <ann.zhuangyanying@huawei.com>
---
 migration/dirtyrate.c | 53 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 00abfa7..d87e16d 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -161,6 +161,21 @@ alloc_block_dirty_info(int *block_index,
     return block_dinfo;
 }
 
+static void free_block_dirty_info(struct block_dirty_info *infos, int count)
+{
+    int i;
+
+    if (!infos) {
+        return;
+    }
+
+    for (i = 0; i < count; i++) {
+        g_free(infos[i].sample_page_vfn);
+        g_free(infos[i].hash_result);
+    }
+    g_free(infos);
+}
+
 static int ram_block_skip(RAMBlock *block)
 {
     if (!strstr(qemu_ram_get_idstr(block), "ram-node") &&
@@ -278,12 +293,6 @@ static int compare_block_hash_info(struct block_dirty_info *info, int block_inde
     return 0;
 }
 
-
-static void calculate_dirtyrate(struct dirtyrate_config config, int64_t time)
-{
-    /* todo */
-}
-
 /*
  * There are multithread will write/read *calculating_dirty_rate_stage*,
  * we can protect only one thread write/read it by libvirt api.
@@ -320,6 +329,38 @@ static int64_t get_sample_gap_period(struct dirtyrate_config config)
     return msec;
 }
 
+static void calculate_dirtyrate(struct dirtyrate_config config, int64_t time)
+{
+    struct block_dirty_info *block_dinfo = NULL;
+    int block_index = 0;
+    int64_t msec = time;
+    int64_t initial_time;
+
+    rcu_register_thread();
+    reset_dirtyrate_stat();
+    initial_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    rcu_read_lock();
+    if (record_block_hash_info(config, &block_dinfo, &block_index) < 0) {
+        goto out;
+    }
+    rcu_read_unlock();
+
+    msec = block_sample_gap_period(msec, initial_time);
+
+    rcu_read_lock();
+    if (compare_block_hash_info(block_dinfo, block_index) < 0) {
+        goto out;
+    }
+
+    update_dirtyrate(msec);
+
+out:
+    rcu_read_unlock();
+    free_block_dirty_info(block_dinfo, block_index + 1);
+    rcu_unregister_thread();
+}
+
+
 void *get_dirtyrate_thread(void *arg)
 {
     struct dirtyrate_config config = *(struct dirtyrate_config *)arg;
-- 
1.8.3.1


