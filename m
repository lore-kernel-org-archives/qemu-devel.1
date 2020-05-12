Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32C8C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:57:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAB8A206D3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB8A206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYWLL-0003vn-Q5
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 10:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jYWHj-0004py-PD; Tue, 12 May 2020 10:53:31 -0400
Received: from relay.sw.ru ([185.231.240.75]:45838)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jYWHh-0005os-4Z; Tue, 12 May 2020 10:53:30 -0400
Received: from dhcp-172-16-25-136.sw.ru ([172.16.25.136] helo=localhost.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jYWHa-0003c8-Kp; Tue, 12 May 2020 17:53:22 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 12/15] copy-on-read: add filter append/drop functions
Date: Tue, 12 May 2020 17:53:13 +0300
Message-Id: <1589295196-773454-13-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1589295196-773454-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1589295196-773454-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 10:53:25
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 armbru@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 andrey.shinkevich@virtuozzo.com, den@openvz.org, mreitz@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Provide API for the COR-filter insertion/removal.
Also, drop the filter child permissions for an inactive state when the
filter node is being removed.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/copy-on-read.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index 4030d56..31e1619 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -24,8 +24,15 @@
 #include "qemu/cutils.h"
 #include "block/block_int.h"
 #include "qemu/module.h"
+#include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
+#include "block/copy-on-read.h"
 
 
+typedef struct BDRVStateCOR {
+    bool active;
+} BDRVStateCOR;
+
 static int cor_open(BlockDriverState *bs, QDict *options, int flags,
                     Error **errp)
 {
@@ -57,6 +64,17 @@ static void cor_child_perm(BlockDriverState *bs, BdrvChild *c,
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
 
@@ -150,6 +168,7 @@ static int cor_change_backing_file(BlockDriverState *bs,
 
 static BlockDriver bdrv_copy_on_read = {
     .format_name                        = "copy-on-read",
+    .instance_size                      = sizeof(BDRVStateCOR),
 
     .bdrv_open                          = cor_open,
     .bdrv_child_perm                    = cor_child_perm,
@@ -178,4 +197,83 @@ static void bdrv_copy_on_read_init(void)
     bdrv_register(&bdrv_copy_on_read);
 }
 
+
+static BlockDriverState *create_filter_node(BlockDriverState *bs,
+                                            const char *filter_node_name,
+                                            Error **errp)
+{
+    QDict *opts = qdict_new();
+
+    qdict_put_str(opts, "driver", "copy-on-read");
+    qdict_put_str(opts, "file", bdrv_get_node_name(bs));
+    if (filter_node_name) {
+        qdict_put_str(opts, "node-name", filter_node_name);
+    }
+
+    return bdrv_open(NULL, NULL, opts, BDRV_O_RDWR, errp);
+}
+
+
+BlockDriverState *bdrv_cor_filter_append(BlockDriverState *bs,
+                                         const char *filter_node_name,
+                                         Error **errp)
+{
+    BlockDriverState *cor_filter_bs;
+    BDRVStateCOR *state;
+    Error *local_err = NULL;
+
+    cor_filter_bs = create_filter_node(bs, filter_node_name, errp);
+    if (cor_filter_bs == NULL) {
+        error_prepend(errp, "Could not create filter node: ");
+        return NULL;
+    }
+
+    if (!filter_node_name) {
+        cor_filter_bs->implicit = true;
+    }
+
+    bdrv_drained_begin(bs);
+    bdrv_replace_node(bs, cor_filter_bs, &local_err);
+    bdrv_drained_end(bs);
+
+    if (local_err) {
+        bdrv_unref(cor_filter_bs);
+        error_propagate(errp, local_err);
+        return NULL;
+    }
+
+    state = cor_filter_bs->opaque;
+    state->active = true;
+
+    return cor_filter_bs;
+}
+
+
+void bdrv_cor_filter_drop(BlockDriverState *cor_filter_bs)
+{
+    BdrvChild *child;
+    BlockDriverState *bs;
+    BDRVStateCOR *s = cor_filter_bs->opaque;
+
+    child = bdrv_filtered_rw_child(cor_filter_bs);
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
 block_init(bdrv_copy_on_read_init);
-- 
1.8.3.1


