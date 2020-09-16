Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6738DC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:18:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E74122065E
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74122065E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIQm6-0006nM-S0
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 02:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kIQfM-0006pi-Qf
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:11:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37016 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kIQfD-0005XU-AF
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:11:40 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 1CE9487D3BF1F4283FFD;
 Wed, 16 Sep 2020 14:11:25 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 16 Sep 2020
 14:11:15 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <eblake@redhat.com>, <dgilbert@redhat.com>,
 <berrange@redhat.com>
Subject: [PATCH v10 01/12] migration/dirtyrate: setup up query-dirtyrate
 framwork
Date: Wed, 16 Sep 2020 14:21:56 +0800
Message-ID: <1600237327-33618-2-git-send-email-zhengchuan@huawei.com>
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

Add get_dirtyrate_thread() functions to setup query-dirtyrate
framework.

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: David Edmondson <david.edmondson@oracle.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
---
 migration/dirtyrate.c | 38 ++++++++++++++++++++++++++++++++++++++
 migration/dirtyrate.h | 29 +++++++++++++++++++++++++++++
 migration/meson.build |  2 +-
 3 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 migration/dirtyrate.c
 create mode 100644 migration/dirtyrate.h

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
new file mode 100644
index 0000000..bf7fd24
--- /dev/null
+++ b/migration/dirtyrate.c
@@ -0,0 +1,38 @@
+/*
+ * Dirtyrate implement code
+ *
+ * Copyright (c) 2020 HUAWEI TECHNOLOGIES CO.,LTD.
+ *
+ * Authors:
+ *  Chuan Zheng <zhengchuan@huawei.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "qemu/config-file.h"
+#include "exec/memory.h"
+#include "exec/ramblock.h"
+#include "exec/target_page.h"
+#include "qemu/rcu_queue.h"
+#include "qapi/qapi-commands-migration.h"
+#include "migration.h"
+#include "dirtyrate.h"
+
+static void calculate_dirtyrate(struct DirtyRateConfig config)
+{
+    /* todo */
+    return;
+}
+
+void *get_dirtyrate_thread(void *arg)
+{
+    struct DirtyRateConfig config = *(struct DirtyRateConfig *)arg;
+
+    calculate_dirtyrate(config);
+
+    return NULL;
+}
diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
new file mode 100644
index 0000000..5be9714
--- /dev/null
+++ b/migration/dirtyrate.h
@@ -0,0 +1,29 @@
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
+/*
+ * Sample 512 pages per GB as default.
+ * TODO: Make it configurable.
+ */
+#define DIRTYRATE_DEFAULT_SAMPLE_PAGES            512
+
+struct DirtyRateConfig {
+    uint64_t sample_pages_per_gigabytes; /* sample pages per GB */
+    int64_t sample_period_seconds; /* time duration between two sampling */
+};
+
+void *get_dirtyrate_thread(void *arg);
+#endif
+
diff --git a/migration/meson.build b/migration/meson.build
index ac8ff14..b5b71c8 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -37,4 +37,4 @@ softmmu_ss.add(when: ['CONFIG_RDMA', rdma], if_true: files('rdma.c'))
 softmmu_ss.add(when: 'CONFIG_LIVE_BLOCK_MIGRATION', if_true: files('block.c'))
 softmmu_ss.add(when: 'CONFIG_ZSTD', if_true: [files('multifd-zstd.c'), zstd])
 
-specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: files('ram.c'))
+specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: files('dirtyrate.c', 'ram.c'))
-- 
1.8.3.1


