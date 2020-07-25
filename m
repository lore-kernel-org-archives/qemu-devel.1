Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC05C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 03:00:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1B76206EB
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 03:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B76206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzAQU-0003qz-Ti
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 23:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1jzAPU-00024n-Vq
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 22:59:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33212 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1jzAPQ-0000k7-M8
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 22:59:40 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 3691A90B99F7B96B7017;
 Sat, 25 Jul 2020 10:59:28 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Sat, 25 Jul 2020
 10:59:20 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [RFC PATCH 1/8] migration/dirtyrate: Add get_dirtyrate_thread()
 function
Date: Sat, 25 Jul 2020 11:11:02 +0800
Message-ID: <1595646669-109310-2-git-send-email-zhengchuan@huawei.com>
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

Add get_dirtyrate_thread() functions

Signed-off-by: Zheng Chuan <zhengchuan@huawei.com>
Signed-off-by: YanYing Zhang <ann.zhuangyanying@huawei.com>
---
 migration/dirtyrate.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++
 migration/dirtyrate.h | 38 +++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 migration/dirtyrate.c
 create mode 100644 migration/dirtyrate.h

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
new file mode 100644
index 0000000..fc652fb
--- /dev/null
+++ b/migration/dirtyrate.c
@@ -0,0 +1,63 @@
+/*
+ * Dirtyrate implement code
+ *
+ * Copyright (c) 2017-2020 HUAWEI TECHNOLOGIES CO.,LTD.
+ *
+ * Authors:
+ *  Chuan Zheng <zhengchuan@huawei.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "dirtyrate.h"
+
+static uint64_t sample_pages_per_gigabytes = DIRTYRATE_DEFAULT_SAMPLE_PAGES;
+static uint64_t dirty_rate; /* MB/s */
+CalculatingDirtyRateStage calculating_dirty_rate_stage = CAL_DIRTY_RATE_INIT;
+
+static bool calculate_dirtyrate(struct dirtyrate_config config,
+                        uint64_t *dirty_rate, int64_t time)
+{
+    /* todo */
+    return true;
+}
+
+static void set_dirty_rate(uint64_t drate)
+{
+    dirty_rate = drate;
+}
+
+/*
+ * There are multithread will write/read *calculating_dirty_rate_stage*,
+ * we can protect only one thread write/read it by libvirt api.
+ * So we don't add mutex_lock to protect it here, but we must calculate
+ * dirty_rate by libvirt api.
+ */
+static void set_dirty_rate_stage(CalculatingDirtyRateStage ratestage)
+{
+    calculating_dirty_rate_stage = ratestage;
+}
+
+void *get_dirtyrate_thread(void *arg)
+{
+    struct dirtyrate_config config = *(struct dirtyrate_config *)arg;
+    uint64_t dirty_rate;
+    uint64_t hash_dirty_rate;
+    bool query_succ;
+    int64_t msec = 0;
+ 
+    set_dirty_rate_stage(CAL_DIRTY_RATE_ING);
+
+    query_succ = calculate_dirtyrate(config, &hash_dirty_rate, msec);
+    if (!query_succ) {
+        dirty_rate = 0;
+    } else {
+        dirty_rate = hash_dirty_rate;
+    }
+
+    set_dirty_rate(dirty_rate);
+    set_dirty_rate_stage(CAL_DIRTY_RATE_END);
+
+    return NULL;
+}
diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
new file mode 100644
index 0000000..9a5c228
--- /dev/null
+++ b/migration/dirtyrate.h
@@ -0,0 +1,38 @@
+/*
+ *  Dirtyrate common functions
+ *
+ *  Copyright (c) 2020 HUAWEI TECHNOLOGIES CO., LTD.
+ *
+ *  Authors:
+ *  Chuan Zheng <zhengchuan@huawei.com>
+ *
+ *  This work is licensed under the terms of the GNU GPL, version 2 or later.
+ *  See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_MIGRATION_DIRTYRATE_H
+#define QEMU_MIGRATION_DIRTYRATE_H
+
+/* take 256 pages per GB for cal dirty rate */
+#define DIRTYRATE_DEFAULT_SAMPLE_PAGES    256
+
+struct dirtyrate_config {
+    uint64_t sample_pages_per_gigabytes;
+    int64_t sample_period_seconds;
+};
+
+/*
+ *  To record calculate dirty_rate status:
+ *  0: initial status, calculating thread is not be created here.
+ *  1: calculating thread is created.
+ *  2: calculating thread is end, we can get result.
+ */
+typedef enum {
+    CAL_DIRTY_RATE_INIT  = 0,
+    CAL_DIRTY_RATE_ING   = 1,
+    CAL_DIRTY_RATE_END   = 2,
+} CalculatingDirtyRateStage;
+
+void *get_dirtyrate_thread(void *arg);
+#endif
+
-- 
1.8.3.1


