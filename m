Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7332BC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 18:21:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCD48223C7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 18:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD48223C7
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVfDC-0006Nh-O4
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 14:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kVf60-0000W0-TK; Thu, 22 Oct 2020 14:14:01 -0400
Received: from relay.sw.ru ([185.231.240.75]:52082 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kVf5x-0001nk-K0; Thu, 22 Oct 2020 14:13:52 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.94)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kVf5r-005dVw-Fi; Thu, 22 Oct 2020 21:13:43 +0300
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 andrey.shinkevich@virtuozzo.com
Subject: [PATCH v12 03/14] copy-on-read: add filter drop function
Date: Thu, 22 Oct 2020 21:13:32 +0300
Message-Id: <1603390423-980205-4-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603390423-980205-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1603390423-980205-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 14:13:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
From: Andrey Shinkevich via <qemu-devel@nongnu.org>

Provide API for the COR-filter removal. Also, drop the filter child
permissions for an inactive state when the filter node is being
removed. This function may be considered as an intermediate solution
before we are able to use bdrv_remove_node(). It will be possible once
the QEMU permission update system has overhauled.
To insert the filter, the block generic layer function
bdrv_insert_node() can be used.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/copy-on-read.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 block/copy-on-read.h | 32 ++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)
 create mode 100644 block/copy-on-read.h

diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index cb03e0f..618c4c4 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -23,11 +23,20 @@
 #include "qemu/osdep.h"
 #include "block/block_int.h"
 #include "qemu/module.h"
+#include "qapi/error.h"
+#include "block/copy-on-read.h"
+
+
+typedef struct BDRVStateCOR {
+    bool active;
+} BDRVStateCOR;
 
 
 static int cor_open(BlockDriverState *bs, QDict *options, int flags,
                     Error **errp)
 {
+    BDRVStateCOR *state = bs->opaque;
+
     bs->file = bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
                                BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
                                false, errp);
@@ -42,6 +51,13 @@ static int cor_open(BlockDriverState *bs, QDict *options, int flags,
         ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
             bs->file->bs->supported_zero_flags);
 
+    state->active = true;
+
+    /*
+     * We don't need to call bdrv_child_refresh_perms() now as the permissions
+     * will be updated later when the filter node gets its parent.
+     */
+
     return 0;
 }
 
@@ -57,6 +73,17 @@ static void cor_child_perm(BlockDriverState *bs, BdrvChild *c,
                            uint64_t perm, uint64_t shared,
                            uint64_t *nperm, uint64_t *nshared)
 {
+    BDRVStateCOR *s = bs->opaque;
+
+    if (!s->active) {
+        /*
+         * While the filter is being removed
+         */
+        *nperm = 0;
+        *nshared = BLK_PERM_ALL;
+        return;
+    }
+
     *nperm = perm & PERM_PASSTHROUGH;
     *nshared = (shared & PERM_PASSTHROUGH) | PERM_UNCHANGED;
 
@@ -135,6 +162,7 @@ static void cor_lock_medium(BlockDriverState *bs, bool locked)
 
 static BlockDriver bdrv_copy_on_read = {
     .format_name                        = "copy-on-read",
+    .instance_size                      = sizeof(BDRVStateCOR),
 
     .bdrv_open                          = cor_open,
     .bdrv_child_perm                    = cor_child_perm,
@@ -154,6 +182,34 @@ static BlockDriver bdrv_copy_on_read = {
     .is_filter                          = true,
 };
 
+
+void bdrv_cor_filter_drop(BlockDriverState *cor_filter_bs)
+{
+    BdrvChild *child;
+    BlockDriverState *bs;
+    BDRVStateCOR *s = cor_filter_bs->opaque;
+
+    child = bdrv_filter_child(cor_filter_bs);
+    if (!child) {
+        return;
+    }
+    bs = child->bs;
+
+    /* Retain the BDS until we complete the graph change. */
+    bdrv_ref(bs);
+    /* Hold a guest back from writing while permissions are being reset. */
+    bdrv_drained_begin(bs);
+    /* Drop permissions before the graph change. */
+    s->active = false;
+    bdrv_child_refresh_perms(cor_filter_bs, child, &error_abort);
+    bdrv_replace_node(cor_filter_bs, bs, &error_abort);
+
+    bdrv_drained_end(bs);
+    bdrv_unref(bs);
+    bdrv_unref(cor_filter_bs);
+}
+
+
 static void bdrv_copy_on_read_init(void)
 {
     bdrv_register(&bdrv_copy_on_read);
diff --git a/block/copy-on-read.h b/block/copy-on-read.h
new file mode 100644
index 0000000..7bf405d
--- /dev/null
+++ b/block/copy-on-read.h
@@ -0,0 +1,32 @@
+/*
+ * Copy-on-read filter block driver
+ *
+ * The filter driver performs Copy-On-Read (COR) operations
+ *
+ * Copyright (c) 2018-2020 Virtuozzo International GmbH.
+ *
+ * Author:
+ *   Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef BLOCK_COPY_ON_READ
+#define BLOCK_COPY_ON_READ
+
+#include "block/block_int.h"
+
+void bdrv_cor_filter_drop(BlockDriverState *cor_filter_bs);
+
+#endif /* BLOCK_COPY_ON_READ */
-- 
1.8.3.1


