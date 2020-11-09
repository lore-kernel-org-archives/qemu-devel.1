Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02226C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:17:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58ECC206ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58ECC206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc3Iv-0005HR-9T
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 04:17:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinzeyu@huawei.com>)
 id 1kc3Ay-0004Rd-Qz
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:09:24 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:2082)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinzeyu@huawei.com>)
 id 1kc3Av-0006yB-Py
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:09:24 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CV4tW0hf3zhhsv;
 Mon,  9 Nov 2020 17:09:07 +0800 (CST)
Received: from localhost (10.174.186.67) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Mon, 9 Nov 2020
 17:09:04 +0800
From: Zeyu Jin <jinzeyu@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [RFC PATCH 5/6] migration: Add compress_level sanity check
Date: Mon, 9 Nov 2020 17:08:49 +0800
Message-ID: <20201109090850.2424-6-jinzeyu@huawei.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201109090850.2424-1-jinzeyu@huawei.com>
References: <20201109090850.2424-1-jinzeyu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.186.67]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=jinzeyu@huawei.com;
 helo=szxga06-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 04:09:11
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Ying Fang <fangying1@huawei.com>, qemu-devel@nongnu.org,
 Zeyu Jin <jinzeyu@huawei.com>, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Zlib compression has level from 1 to 9. However Zstd compression has level
from 1 to 22 (level >= 20 not recommanded). Let's do sanity check here
to make sure a vaild compress_level is given by user.

Signed-off-by: Zeyu Jin <jinzeyu@huawei.com>
Signed-off-by: Ying Fang <fangying1@huawei.com>
---
 migration/migration.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 2c68012029..6fc0c3b532 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1235,16 +1235,40 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
     }
 }
 
+static bool compress_level_check(MigrationParameters *params, Error **errp)
+{
+    switch (params->compress_method) {
+    case COMPRESS_METHOD_ZLIB:
+        if (params->compress_level > 9 || params->compress_level < 1) {
+            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "compress_level",
+                           "a value in the range of 0 to 9 for Zlib method");
+            return false;
+        }
+        break;
+#ifdef CONFIG_ZSTD
+    case COMPRESS_METHOD_ZSTD:
+        if (params->compress_level > 19 || params->compress_level < 1) {
+            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "compress_level",
+                        "a value in the range of 1 to 19 for Zstd method");
+            return false;
+        }
+        break;
+#endif
+    default:
+        error_setg(errp, "Checking compress_level failed for unknown reason");
+        return false;
+    }
+
+    return true;
+}
+
 /*
  * Check whether the parameters are valid. Error will be put into errp
  * (if provided). Return true if valid, otherwise false.
  */
 static bool migrate_params_check(MigrationParameters *params, Error **errp)
 {
-    if (params->has_compress_level &&
-        (params->compress_level > 9)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "compress_level",
-                   "is invalid, it should be in the range of 0 to 9");
+    if (params->has_compress_level && !compress_level_check(params, errp)) {
         return false;
     }
 
-- 
2.23.0


