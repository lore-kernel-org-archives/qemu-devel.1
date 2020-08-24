Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A7CC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:05:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B66F1206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B66F1206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA8QE-0003PA-Rq
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 05:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kA8OC-0007MW-Kq
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:03:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41998 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kA8O9-0007lB-Ua
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:03:40 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 85236DAF4C612265A924;
 Mon, 24 Aug 2020 17:03:26 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Mon, 24 Aug 2020
 17:03:19 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <eblake@redhat.com>, <dgilbert@redhat.com>,
 <berrange@redhat.com>
Subject: [PATCH v5 06/12] migration/dirtyrate: Record hash results for each
 sampled page
Date: Mon, 24 Aug 2020 17:14:34 +0800
Message-ID: <1598260480-64862-7-git-send-email-zhengchuan@huawei.com>
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

Record hash results for each sampled page, crc32 is taken to calculate
hash results for each sampled 4K-page.

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
---
 migration/dirtyrate.c | 136 ++++++++++++++++++++++++++++++++++++++++++++++++++
 migration/dirtyrate.h |  15 ++++++
 2 files changed, 151 insertions(+)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index f6a94d8..66de426 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -10,6 +10,7 @@
  * See the COPYING file in the top-level directory.
  */
 
+#include <zlib.h>
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "crypto/hash.h"
@@ -66,6 +67,141 @@ static void update_dirtyrate(uint64_t msec)
     DirtyStat.dirty_rate = dirtyrate;
 }
 
+/*
+ * get hash result for the sampled memory with length of 4K byte in ramblock,
+ * which starts from ramblock base address.
+ */
+static uint32_t get_ramblock_vfn_hash(struct RamblockDirtyInfo *info,
+                                      uint64_t vfn)
+{
+    struct iovec iov_array;
+    uint32_t crc;
+
+    iov_array.iov_base = info->ramblock_addr +
+                         vfn * DIRTYRATE_SAMPLE_PAGE_SIZE;
+    iov_array.iov_len = DIRTYRATE_SAMPLE_PAGE_SIZE;
+
+    crc = crc32(0, iov_array.iov_base, iov_array.iov_len);
+
+    return crc;
+}
+
+static int save_ramblock_hash(struct RamblockDirtyInfo *info)
+{
+    unsigned int sample_pages_count;
+    int i;
+    int ret = -1;
+    GRand *rand = g_rand_new();
+
+    sample_pages_count = info->sample_pages_count;
+
+    /* ramblock size less than one page, return success to skip this ramblock */
+    if (unlikely(info->ramblock_pages == 0 || sample_pages_count == 0)) {
+        ret = 0;
+        goto out;
+    }
+
+    info->hash_result = g_try_malloc0_n(sample_pages_count,
+                                        sizeof(uint32_t));
+    if (!info->hash_result) {
+        ret = -1;
+        goto out;
+    }
+
+    info->sample_page_vfn = g_try_malloc0_n(sample_pages_count,
+                                            sizeof(uint64_t));
+    if (!info->sample_page_vfn) {
+        g_free(info->hash_result);
+        ret = -1;
+        goto out;
+    }
+
+    for (i = 0; i < sample_pages_count; i++) {
+        info->sample_page_vfn[i] = g_rand_int_range(rand, 0,
+                                                    info->ramblock_pages - 1);
+        info->hash_result[i] = get_ramblock_vfn_hash(info,
+                                                     info->sample_page_vfn[i]);
+    }
+    ret = 0;
+
+out:
+    g_rand_free(rand);
+    return ret;
+}
+
+static void get_ramblock_dirty_info(RAMBlock *block,
+                                    struct RamblockDirtyInfo *info,
+                                    struct DirtyRateConfig *config)
+{
+    uint64_t sample_pages_per_gigabytes = config->sample_pages_per_gigabytes;
+
+    /* Right shift 30 bits to calc block size in GB */
+    info->sample_pages_count = (qemu_ram_get_used_length(block) *
+                                sample_pages_per_gigabytes) >>
+                                DIRTYRATE_PAGE_SHIFT_GB;
+
+    /* Right shift 12 bits to calc page count in 4KB */
+    info->ramblock_pages = qemu_ram_get_used_length(block) >>
+                           DIRTYRATE_PAGE_SHIFT_KB;
+    info->ramblock_addr = qemu_ram_get_host_addr(block);
+    strcpy(info->idstr, qemu_ram_get_idstr(block));
+}
+
+static struct RamblockDirtyInfo *
+alloc_ramblock_dirty_info(int *block_index,
+                          struct RamblockDirtyInfo *block_dinfo)
+{
+    struct RamblockDirtyInfo *info = NULL;
+    int index = *block_index;
+
+    if (!block_dinfo) {
+        index = 0;
+        block_dinfo = g_try_new(struct RamblockDirtyInfo, 1);
+    } else {
+        index++;
+        block_dinfo = g_try_realloc(block_dinfo, (index + 1) *
+                                    sizeof(struct RamblockDirtyInfo));
+    }
+    if (!block_dinfo) {
+        return NULL;
+    }
+
+    info = &block_dinfo[index];
+    *block_index = index;
+    memset(info, 0, sizeof(struct RamblockDirtyInfo));
+
+    return block_dinfo;
+}
+
+static int record_ramblock_hash_info(struct RamblockDirtyInfo **block_dinfo,
+                                     struct DirtyRateConfig config,
+                                     int *block_index)
+{
+    struct RamblockDirtyInfo *info = NULL;
+    struct RamblockDirtyInfo *dinfo = NULL;
+    RAMBlock *block = NULL;
+    int index = 0;
+
+    RAMBLOCK_FOREACH_MIGRATABLE(block) {
+        dinfo = alloc_ramblock_dirty_info(&index, dinfo);
+        if (dinfo == NULL) {
+            return -1;
+        }
+        info = &dinfo[index];
+        get_ramblock_dirty_info(block, info, &config);
+        if (save_ramblock_hash(info) < 0) {
+            *block_dinfo = dinfo;
+            *block_index = index;
+            return -1;
+        }
+    }
+
+    *block_dinfo = dinfo;
+    *block_index = index;
+
+    return 0;
+}
+
 static void calculate_dirtyrate(struct DirtyRateConfig config)
 {
     /* todo */
diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
index 9db269d..5050add 100644
--- a/migration/dirtyrate.h
+++ b/migration/dirtyrate.h
@@ -24,6 +24,21 @@
  */
 #define RAMBLOCK_INFO_MAX_LEN                     256
 
+/*
+ * Sample page size 4K as default.
+ */
+#define DIRTYRATE_SAMPLE_PAGE_SIZE                4096
+
+/*
+ * Sample page size 4K shift
+ */
+#define DIRTYRATE_PAGE_SHIFT_KB                   12
+
+/*
+ * Sample page size 1G shift
+ */
+#define DIRTYRATE_PAGE_SHIFT_GB                   30
+
 /* Take 1s as default for calculation duration */
 #define DEFAULT_FETCH_DIRTYRATE_TIME_SEC          1
 
-- 
1.8.3.1


