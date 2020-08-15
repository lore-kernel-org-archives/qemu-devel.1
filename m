Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD44C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 18:07:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5425123B6F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 18:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5425123B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k70as-0000Z5-Lr
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 14:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1k70VK-0000wS-MU
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 14:02:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57580 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1k70VH-0007E4-QR
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 14:02:06 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 1E66BAA7B85AFA6BCE1E;
 Sat, 15 Aug 2020 10:11:17 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Sat, 15 Aug 2020
 10:11:07 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <eblake@redhat.com>, <dgilbert@redhat.com>
Subject: [PATCH v2 04/10] migration/dirtyrate: move
 RAMBLOCK_FOREACH_MIGRATABLE into ram.h
Date: Sat, 15 Aug 2020 10:22:54 +0800
Message-ID: <1597458180-16945-5-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1597458180-16945-1-git-send-email-zhengchuan@huawei.com>
References: <1597458180-16945-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=zhengchuan@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/15 14:01:48
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

RAMBLOCK_FOREACH_MIGRATABLE is need in dirtyrate measure,
move the existing definition up into migration/ram.h

Signed-off-by: Zheng Chuan <zhengchuan@huawei.com>
---
 migration/dirtyrate.c |  1 +
 migration/ram.c       | 11 +----------
 migration/ram.h       | 10 ++++++++++
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 8708090..c4304ef 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -21,6 +21,7 @@
 #include "qemu/rcu_queue.h"
 #include "qapi/qapi-commands-migration.h"
 #include "migration.h"
+#include "ram.h"
 #include "dirtyrate.h"
 
 CalculatingDirtyRateState CalculatingState = CAL_DIRTY_RATE_INIT;
diff --git a/migration/ram.c b/migration/ram.c
index 76d4fee..37ef0da 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -158,21 +158,12 @@ out:
     return ret;
 }
 
-static bool ramblock_is_ignored(RAMBlock *block)
+bool ramblock_is_ignored(RAMBlock *block)
 {
     return !qemu_ram_is_migratable(block) ||
            (migrate_ignore_shared() && qemu_ram_is_shared(block));
 }
 
-/* Should be holding either ram_list.mutex, or the RCU lock. */
-#define RAMBLOCK_FOREACH_NOT_IGNORED(block)            \
-    INTERNAL_RAMBLOCK_FOREACH(block)                   \
-        if (ramblock_is_ignored(block)) {} else
-
-#define RAMBLOCK_FOREACH_MIGRATABLE(block)             \
-    INTERNAL_RAMBLOCK_FOREACH(block)                   \
-        if (!qemu_ram_is_migratable(block)) {} else
-
 #undef RAMBLOCK_FOREACH
 
 int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque)
diff --git a/migration/ram.h b/migration/ram.h
index 2eeaacf..011e854 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -37,6 +37,16 @@ extern MigrationStats ram_counters;
 extern XBZRLECacheStats xbzrle_counters;
 extern CompressionStats compression_counters;
 
+bool ramblock_is_ignored(RAMBlock *block);
+/* Should be holding either ram_list.mutex, or the RCU lock. */
+#define RAMBLOCK_FOREACH_NOT_IGNORED(block)            \
+    INTERNAL_RAMBLOCK_FOREACH(block)                   \
+        if (ramblock_is_ignored(block)) {} else
+
+#define RAMBLOCK_FOREACH_MIGRATABLE(block)             \
+    INTERNAL_RAMBLOCK_FOREACH(block)                   \
+        if (!qemu_ram_is_migratable(block)) {} else
+
 int xbzrle_cache_resize(int64_t new_size, Error **errp);
 uint64_t ram_bytes_remaining(void);
 uint64_t ram_bytes_total(void);
-- 
1.8.3.1


