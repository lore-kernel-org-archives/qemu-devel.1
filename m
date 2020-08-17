Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4748BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 03:12:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 191472063A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 03:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191472063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7VZN-0004cE-D3
	for qemu-devel@archiver.kernel.org; Sun, 16 Aug 2020 23:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1k7VWB-0006DS-L9
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 23:09:03 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4256 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1k7VW8-0008M0-LR
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 23:09:03 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id DD027E72928D3028BC1E;
 Mon, 17 Aug 2020 11:08:53 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Mon, 17 Aug 2020
 11:08:45 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <eblake@redhat.com>, <dgilbert@redhat.com>
Subject: [PATCH v3 06/10] migration/dirtyrate: Compare page hash results for
 recorded sampled page
Date: Mon, 17 Aug 2020 11:20:29 +0800
Message-ID: <1597634433-18809-7-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1597634433-18809-1-git-send-email-zhengchuan@huawei.com>
References: <1597634433-18809-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=zhengchuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/16 23:08:53
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

Compare page hash results for recorded sampled page.

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
---
 migration/dirtyrate.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 62b6f69..3ce25f5 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -215,6 +215,82 @@ static int record_ramblock_hash_info(struct RamblockDirtyInfo **block_dinfo,
     return 0;
 }
 
+static int calc_page_dirty_rate(struct RamblockDirtyInfo *info)
+{
+    uint8_t *md = NULL;
+    int i;
+    int ret = 0;
+
+    md = g_try_new0(uint8_t, qcrypto_hash_len);
+    if (!md) {
+        return -1;
+    }
+
+    for (i = 0; i < info->sample_pages_count; i++) {
+        ret = get_ramblock_vfn_hash(info, info->sample_page_vfn[i], &md);
+        if (ret < 0) {
+            goto out;
+        }
+
+        if (memcmp(md, info->hash_result + i * qcrypto_hash_len,
+                   qcrypto_hash_len) != 0) {
+            info->sample_dirty_count++;
+        }
+    }
+
+out:
+    g_free(md);
+    return ret;
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
+            (qemu_ram_get_used_length(block) >> 12)) {
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
+    if (!dirty_stat.total_sample_count) {
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


