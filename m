Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B002C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 02:39:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D057207EA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 02:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D057207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI0sM-00023J-A2
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 22:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kI0nO-0002SH-Of
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 22:34:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49086 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kI0nM-0005tu-9v
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 22:34:14 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 4A155977810104AD6811;
 Tue, 15 Sep 2020 10:34:07 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Tue, 15 Sep 2020
 10:33:59 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <eblake@redhat.com>, <dgilbert@redhat.com>,
 <berrange@redhat.com>
Subject: [PATCH v9 08/12] migration/dirtyrate: skip sampling ramblock with
 size below MIN_RAMBLOCK_SIZE
Date: Tue, 15 Sep 2020 10:44:43 +0800
Message-ID: <1600137887-58739-9-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1600137887-58739-1-git-send-email-zhengchuan@huawei.com>
References: <1600137887-58739-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=zhengchuan@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 22:34:04
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
 liq3ea@gmail.com, qemu-devel@nongnu.org, xiexiangyou@huawei.com,
 alex.chen@huawei.com, jinyan12@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In order to sample real RAM, skip ramblock with size below MIN_RAMBLOCK_SIZE
which is set as 128M.

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
Reviewed-by: David Edmondson <david.edmondson@oracle.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/dirtyrate.c | 21 +++++++++++++++++++++
 migration/dirtyrate.h |  5 +++++
 2 files changed, 26 insertions(+)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 2d48eb8..903f728 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -138,6 +138,18 @@ static void get_ramblock_dirty_info(RAMBlock *block,
     strcpy(info->idstr, qemu_ram_get_idstr(block));
 }
 
+static bool skip_sample_ramblock(RAMBlock *block)
+{
+    /*
+     * Sample only blocks larger than MIN_RAMBLOCK_SIZE.
+     */
+    if (qemu_ram_get_used_length(block) < (MIN_RAMBLOCK_SIZE << 10)) {
+        return true;
+    }
+
+    return false;
+}
+
 static bool record_ramblock_hash_info(struct RamblockDirtyInfo **block_dinfo,
                                       struct DirtyRateConfig config,
                                       int *block_count)
@@ -150,6 +162,9 @@ static bool record_ramblock_hash_info(struct RamblockDirtyInfo **block_dinfo,
     bool ret = false;
 
     RAMBLOCK_FOREACH_MIGRATABLE(block) {
+        if (skip_sample_ramblock(block)) {
+            continue;
+        }
         total_count++;
     }
 
@@ -159,6 +174,9 @@ static bool record_ramblock_hash_info(struct RamblockDirtyInfo **block_dinfo,
     }
 
     RAMBLOCK_FOREACH_MIGRATABLE(block) {
+        if (skip_sample_ramblock(block)) {
+            continue;
+        }
         if (index >= total_count) {
             break;
         }
@@ -225,6 +243,9 @@ static bool compare_page_hash_info(struct RamblockDirtyInfo *info,
     RAMBlock *block = NULL;
 
     RAMBLOCK_FOREACH_MIGRATABLE(block) {
+        if (skip_sample_ramblock(block)) {
+            continue;
+        }
         block_dinfo = find_page_matched(block, block_count, info);
         if (block_dinfo == NULL) {
             continue;
diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
index a3ee305..faaf9da 100644
--- a/migration/dirtyrate.h
+++ b/migration/dirtyrate.h
@@ -24,6 +24,11 @@
  */
 #define RAMBLOCK_INFO_MAX_LEN                     256
 
+/*
+ * Minimum RAMBlock size to sample, in megabytes.
+ */
+#define MIN_RAMBLOCK_SIZE                         128
+
 struct DirtyRateConfig {
     uint64_t sample_pages_per_gigabytes; /* sample pages per GB */
     int64_t sample_period_seconds; /* time duration between two sampling */
-- 
1.8.3.1


