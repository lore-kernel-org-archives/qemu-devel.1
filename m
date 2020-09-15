Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23ECC2BBD1
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 02:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82450207EA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 02:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82450207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI0q3-0007ZV-Kv
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 22:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kI0nN-0002Q8-UE
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 22:34:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34028 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kI0nK-0005tT-Rp
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 22:34:13 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 83C919148793D719AD73;
 Tue, 15 Sep 2020 10:34:07 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Tue, 15 Sep 2020
 10:33:59 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <eblake@redhat.com>, <dgilbert@redhat.com>,
 <berrange@redhat.com>
Subject: [PATCH v9 07/12] migration/dirtyrate: Compare page hash results for
 recorded sampled page
Date: Tue, 15 Sep 2020 10:44:42 +0800
Message-ID: <1600137887-58739-8-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1600137887-58739-1-git-send-email-zhengchuan@huawei.com>
References: <1600137887-58739-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=zhengchuan@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 21:28:41
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

Compare page hash results for recorded sampled page.

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/dirtyrate.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 5e6eedf..2d48eb8 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -177,6 +177,69 @@ out:
     return ret;
 }
 
+static void calc_page_dirty_rate(struct RamblockDirtyInfo *info)
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
+}
+
+static struct RamblockDirtyInfo *
+find_page_matched(RAMBlock *block, int count,
+                  struct RamblockDirtyInfo *infos)
+{
+    int i;
+    struct RamblockDirtyInfo *matched;
+
+    for (i = 0; i <= count; i++) {
+        if (!strcmp(infos[i].idstr, qemu_ram_get_idstr(block))) {
+            break;
+        }
+    }
+
+    if (i == count) {
+        return NULL;
+    }
+
+    if (infos[i].ramblock_addr != qemu_ram_get_host_addr(block) ||
+        infos[i].ramblock_pages !=
+            (qemu_ram_get_used_length(block) >> TARGET_PAGE_BITS)) {
+        return NULL;
+    }
+
+    matched = &infos[i];
+
+    return matched;
+}
+
+static bool compare_page_hash_info(struct RamblockDirtyInfo *info,
+                                  int block_count)
+{
+    struct RamblockDirtyInfo *block_dinfo = NULL;
+    RAMBlock *block = NULL;
+
+    RAMBLOCK_FOREACH_MIGRATABLE(block) {
+        block_dinfo = find_page_matched(block, block_count, info);
+        if (block_dinfo == NULL) {
+            continue;
+        }
+        calc_page_dirty_rate(block_dinfo);
+        update_dirtyrate_stat(block_dinfo);
+    }
+
+    if (DirtyStat.total_sample_count == 0) {
+        return false;
+    }
+
+    return true;
+}
+
 static void calculate_dirtyrate(struct DirtyRateConfig config)
 {
     /* todo */
-- 
1.8.3.1


