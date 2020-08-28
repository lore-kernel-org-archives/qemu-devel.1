Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBBAC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 16:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B02FD20678
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 16:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02FD20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBhfK-0005VK-NM
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 12:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kBheZ-0003zJ-Fh; Fri, 28 Aug 2020 12:55:03 -0400
Received: from relay.sw.ru ([185.231.240.75]:37972 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kBheX-0001SE-NU; Fri, 28 Aug 2020 12:55:03 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.94)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kBhe3-001XPR-Ip; Fri, 28 Aug 2020 19:54:31 +0300
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 armbru@redhat.com, jsnow@redhat.com, eblake@redhat.com, den@openvz.org,
 vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com
Subject: [PATCH v8 4/7] copy-on-read: pass base file name to COR driver
Date: Fri, 28 Aug 2020 19:52:56 +0300
Message-Id: <1598633579-221780-5-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1598633579-221780-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1598633579-221780-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 12:53:26
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

To limit the guest's COR operations by the base node in the backing
chain during stream job, pass the base file name to the copy-on-read
driver. The rest of the functionality will be implemented in the patch
that follows.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/copy-on-read.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 block/copy-on-read.h |  1 +
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index 0ede7aa..1f858bb 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -24,19 +24,45 @@
 #include "block/block_int.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qdict.h"
 #include "block/copy-on-read.h"
 
 
 typedef struct BDRVStateCOR {
     bool active;
+    BlockDriverState *base_bs;
 } BDRVStateCOR;
 
+/*
+ * Non-zero pointers are the caller's responsibility.
+ */
+static BlockDriverState *get_base_by_name(BlockDriverState *bs,
+                                          const char *base_name, Error **errp)
+{
+    BlockDriverState *base_bs = NULL;
+    AioContext *aio_context;
+
+    base_bs = bdrv_find_backing_image(bs, base_name);
+    if (base_bs == NULL) {
+        error_setg(errp, QERR_BASE_NOT_FOUND, base_name);
+        return NULL;
+    }
+
+    aio_context = bdrv_get_aio_context(bs);
+    aio_context_acquire(aio_context);
+    assert(bdrv_get_aio_context(base_bs) == aio_context);
+    aio_context_release(aio_context);
+
+    return base_bs;
+}
 
 static int cor_open(BlockDriverState *bs, QDict *options, int flags,
                     Error **errp)
 {
+    BlockDriverState *base_bs = NULL;
     BDRVStateCOR *state = bs->opaque;
+    const char *base_name = qdict_get_try_str(options, "base");
 
     bs->file = bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
                                BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
@@ -52,7 +78,15 @@ static int cor_open(BlockDriverState *bs, QDict *options, int flags,
         ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
             bs->file->bs->supported_zero_flags);
 
+    if (base_name) {
+        qdict_del(options, "base");
+        base_bs = get_base_by_name(bs, base_name, errp);
+        if (!base_bs) {
+            return -EINVAL;
+        }
+    }
     state->active = true;
+    state->base_bs = base_bs;
 
     /*
      * We don't need to call bdrv_child_refresh_perms() now as the permissions
@@ -190,6 +224,7 @@ static void bdrv_copy_on_read_init(void)
 
 
 static BlockDriverState *create_filter_node(BlockDriverState *bs,
+                                            const char *base_name,
                                             const char *filter_node_name,
                                             Error **errp)
 {
@@ -197,6 +232,9 @@ static BlockDriverState *create_filter_node(BlockDriverState *bs,
 
     qdict_put_str(opts, "driver", "copy-on-read");
     qdict_put_str(opts, "file", bdrv_get_node_name(bs));
+    if (base_name) {
+        qdict_put_str(opts, "base", base_name);
+    }
     if (filter_node_name) {
         qdict_put_str(opts, "node-name", filter_node_name);
     }
@@ -206,13 +244,14 @@ static BlockDriverState *create_filter_node(BlockDriverState *bs,
 
 
 BlockDriverState *bdrv_cor_filter_append(BlockDriverState *bs,
+                                         const char *base_name,
                                          const char *filter_node_name,
                                          Error **errp)
 {
     BlockDriverState *cor_filter_bs;
     Error *local_err = NULL;
 
-    cor_filter_bs = create_filter_node(bs, filter_node_name, errp);
+    cor_filter_bs = create_filter_node(bs, base_name, filter_node_name, errp);
     if (cor_filter_bs == NULL) {
         error_prepend(errp, "Could not create filter node: ");
         return NULL;
diff --git a/block/copy-on-read.h b/block/copy-on-read.h
index 1686e4e..6a7c8bb 100644
--- a/block/copy-on-read.h
+++ b/block/copy-on-read.h
@@ -28,6 +28,7 @@
 #include "block/block_int.h"
 
 BlockDriverState *bdrv_cor_filter_append(BlockDriverState *bs,
+                                         const char *base_name,
                                          const char *filter_node_name,
                                          Error **errp);
 void bdrv_cor_filter_drop(BlockDriverState *cor_filter_bs);
-- 
1.8.3.1


