Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081D8C433EB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:07:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C50F92072D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C50F92072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA8RZ-0006ii-RM
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 05:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kA8OD-0007QO-Tu
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:03:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42058 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kA8OA-0007lT-V1
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:03:41 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 90270936C2EDDC0E1323;
 Mon, 24 Aug 2020 17:03:26 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Mon, 24 Aug 2020
 17:03:19 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <eblake@redhat.com>, <dgilbert@redhat.com>,
 <berrange@redhat.com>
Subject: [PATCH v5 07/12] migration/dirtyrate: Compare page hash results for
 recorded sampled page
Date: Mon, 24 Aug 2020 17:14:35 +0800
Message-ID: <1598260480-64862-8-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1598260480-64862-1-git-send-email-zhengchuan@huawei.com>
References: <1598260480-64862-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=zhengchuan@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 05:03:27
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
Cc: zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, alex.chen@huawei.com, ann.zhuangyanying@huawei.com,
 fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Compare page hash results for recorded sampled page.

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
---
 migration/dirtyrate.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 66de426..050270d 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -202,6 +202,70 @@ static int record_ramblock_hash_info(struct RamblockDirtyInfo **block_dinfo,
     return 0;
 }
 
+static int calc_page_dirty_rate(struct RamblockDirtyInfo *info)
+{
+    uint32_t crc;
+    int i;
+
+    for (i = 0; i < info->sample_pages_count; i++) {
+        crc = get_ramblock_vfn_hash(info, info->sample_page_vfn[i]);
+        if (crc != info->hash_result[i]) {
+            info->sample_dirty_count++;
+        }
+    }
+
+    return 0;
+}
+
+static bool find_page_matched(RAMBlock *block, struct RamblockDirtyInfo *infos,
+                              int count, struct RamblockDirtyInfo **matched)
+{
+    int i;
+
+    for (i = 0; i < count; i++) {
+        if (!strcmp(infos[i].idstr, qemu_ram_get_idstr(block))) {
+            break;
+        }
+    }
+
+    if (i == count) {
+        return false;
+    }
+
+    if (infos[i].ramblock_addr != qemu_ram_get_host_addr(block) ||
+        infos[i].ramblock_pages !=
+            (qemu_ram_get_used_length(block) >> DIRTYRATE_PAGE_SHIFT_KB)) {
+        return false;
+    }
+
+    *matched = &infos[i];
+    return true;
+}
+
+static int compare_page_hash_info(struct RamblockDirtyInfo *info,
+                                  int block_index)
+{
+    struct RamblockDirtyInfo *block_dinfo = NULL;
+    RAMBlock *block = NULL;
+
+    RAMBLOCK_FOREACH_MIGRATABLE(block) {
+        block_dinfo = NULL;
+        if (!find_page_matched(block, info, block_index + 1, &block_dinfo)) {
+            continue;
+        }
+        if (calc_page_dirty_rate(block_dinfo) < 0) {
+            return -1;
+        }
+        update_dirtyrate_stat(block_dinfo);
+    }
+
+    if (!DirtyStat.total_sample_count) {
+        return -1;
+    }
+
+    return 0;
+}
+
 static void calculate_dirtyrate(struct DirtyRateConfig config)
 {
     /* todo */
-- 
1.8.3.1


