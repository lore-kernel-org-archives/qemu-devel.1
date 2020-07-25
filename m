Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC2FC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 03:02:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A470D206EB
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 03:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A470D206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzAS4-0006wT-UN
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 23:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1jzAPW-00028M-Fq
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 22:59:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4158 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1jzAPR-0000l9-3P
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 22:59:42 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 401B5539D792B5385680;
 Sat, 25 Jul 2020 10:59:33 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Sat, 25 Jul 2020
 10:59:23 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [RFC PATCH 5/8] migration/dirtyrate: Compare hash results for
 recorded ramblock
Date: Sat, 25 Jul 2020 11:11:06 +0800
Message-ID: <1595646669-109310-6-git-send-email-zhengchuan@huawei.com>
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

Compare hash results for recorded ramblock.

Signed-off-by: Zheng Chuan <zhengchuan@huawei.com>
Signed-off-by: YanYing Zhang <ann.zhuangyanying@huawei.com>
---
 migration/dirtyrate.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 45cfc91..7badc53 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -202,6 +202,83 @@ static int record_block_hash_info(struct dirtyrate_config config,
     return 0;
 }
 
+static int cal_block_dirty_rate(struct block_dirty_info *info)
+{
+    uint8_t *md = NULL;
+    size_t hash_len;
+    int i;
+    int ret = 0;
+
+    hash_len = qcrypto_hash_digest_len(QCRYPTO_HASH_ALG_MD5);
+    md = g_new0(uint8_t, hash_len);
+
+    for (i = 0; i < info->sample_pages_count; i++) {
+        ret = get_block_vfn_hash(info, info->sample_page_vfn[i], &md, &hash_len);
+        if (ret < 0) {
+            goto out;
+        }
+
+        if (memcmp(md, info->hash_result + i * hash_len, hash_len) != 0) {
+            info->sample_dirty_count++;
+        }
+    }
+
+out:
+    g_free(md);
+    return ret;
+}
+
+static bool find_block_matched(RAMBlock *block, struct block_dirty_info *infos,
+                               int count, struct block_dirty_info **matched)
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
+    if (infos[i].block_addr != qemu_ram_get_host_addr(block) ||
+        infos[i].block_pages !=
+            (qemu_ram_get_used_length(block) >> DIRTYRATE_PAGE_SIZE_SHIFT)) {
+        return false;
+    }
+
+    *matched = &infos[i];
+    return true;
+}
+
+static int compare_block_hash_info(struct block_dirty_info *info, int block_index)
+{
+    struct block_dirty_info *block_dinfo = NULL;
+    RAMBlock *block = NULL;
+
+    RAMBLOCK_FOREACH_MIGRATABLE(block) {
+        if (ram_block_skip(block) < 0) {
+            continue;
+        }
+        block_dinfo = NULL;
+        if (!find_block_matched(block, info, block_index + 1, &block_dinfo)) {
+            continue;
+        }
+        if (cal_block_dirty_rate(block_dinfo) < 0) {
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
+
 static void calculate_dirtyrate(struct dirtyrate_config config, int64_t time)
 {
     /* todo */
-- 
1.8.3.1


