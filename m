Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0ACC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:13:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A61EA208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61EA208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIQgr-0008HH-Iv
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 02:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kIQfF-0006jH-5E
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:11:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37008 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kIQfC-0005XV-CZ
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:11:32 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 225AF8B5049A6D4EF96B;
 Wed, 16 Sep 2020 14:11:25 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 16 Sep 2020
 14:11:16 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <eblake@redhat.com>, <dgilbert@redhat.com>,
 <berrange@redhat.com>
Subject: [PATCH v10 03/12] migration/dirtyrate: Add RamblockDirtyInfo to store
 sampled page info
Date: Wed, 16 Sep 2020 14:21:58 +0800
Message-ID: <1600237327-33618-4-git-send-email-zhengchuan@huawei.com>
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

Add RamblockDirtyInfo to store sampled page info of each ramblock.

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: David Edmondson <david.edmondson@oracle.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
---
 migration/dirtyrate.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
index 5be9714..479e222 100644
--- a/migration/dirtyrate.h
+++ b/migration/dirtyrate.h
@@ -19,11 +19,29 @@
  */
 #define DIRTYRATE_DEFAULT_SAMPLE_PAGES            512
 
+/*
+ * Record ramblock idstr
+ */
+#define RAMBLOCK_INFO_MAX_LEN                     256
+
 struct DirtyRateConfig {
     uint64_t sample_pages_per_gigabytes; /* sample pages per GB */
     int64_t sample_period_seconds; /* time duration between two sampling */
 };
 
+/*
+ * Store dirtypage info for each ramblock.
+ */
+struct RamblockDirtyInfo {
+    char idstr[RAMBLOCK_INFO_MAX_LEN]; /* idstr for each ramblock */
+    uint8_t *ramblock_addr; /* base address of ramblock we measure */
+    uint64_t ramblock_pages; /* ramblock size in TARGET_PAGE_SIZE */
+    uint64_t *sample_page_vfn; /* relative offset address for sampled page */
+    uint64_t sample_pages_count; /* count of sampled pages */
+    uint64_t sample_dirty_count; /* count of dirty pages we measure */
+    uint32_t *hash_result; /* array of hash result for sampled pages */
+};
+
 void *get_dirtyrate_thread(void *arg);
 #endif
 
-- 
1.8.3.1


