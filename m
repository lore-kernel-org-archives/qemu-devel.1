Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54613C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 18:18:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D27A724641
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 18:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27A724641
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVfAI-0003CL-Gq
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 14:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kVf60-0000Vm-OT; Thu, 22 Oct 2020 14:13:56 -0400
Received: from relay.sw.ru ([185.231.240.75]:52070 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kVf5x-0001nf-Mt; Thu, 22 Oct 2020 14:13:51 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.94)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kVf5r-005dVw-Eb; Thu, 22 Oct 2020 21:13:43 +0300
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 andrey.shinkevich@virtuozzo.com
Subject: [PATCH v12 02/14] block: add insert/remove node functions
Date: Thu, 22 Oct 2020 21:13:31 +0300
Message-Id: <1603390423-980205-3-git-send-email-andrey.shinkevich@virtuozzo.com>
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

Provide API for a node insertion to and removal from a backing chain.

Suggested-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block.c               | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/block/block.h |  3 +++
 2 files changed, 52 insertions(+)

diff --git a/block.c b/block.c
index 430edf7..502b483 100644
--- a/block.c
+++ b/block.c
@@ -4670,6 +4670,55 @@ static void bdrv_delete(BlockDriverState *bs)
     g_free(bs);
 }
 
+BlockDriverState *bdrv_insert_node(BlockDriverState *bs, QDict *node_options,
+                                   int flags, Error **errp)
+{
+    BlockDriverState *new_node_bs;
+    Error *local_err = NULL;
+
+    new_node_bs =  bdrv_open(NULL, NULL, node_options, flags, errp);
+    if (new_node_bs == NULL) {
+        error_prepend(errp, "Could not create node: ");
+        return NULL;
+    }
+
+    bdrv_drained_begin(bs);
+    bdrv_replace_node(bs, new_node_bs, &local_err);
+    bdrv_drained_end(bs);
+
+    if (local_err) {
+        bdrv_unref(new_node_bs);
+        error_propagate(errp, local_err);
+        return NULL;
+    }
+
+    return new_node_bs;
+}
+
+void bdrv_remove_node(BlockDriverState *bs)
+{
+    BdrvChild *child;
+    BlockDriverState *inferior_bs;
+
+    child = bdrv_filter_or_cow_child(bs);
+    if (!child) {
+        return;
+    }
+    inferior_bs = child->bs;
+
+    /* Retain the BDS until we complete the graph change. */
+    bdrv_ref(inferior_bs);
+    /* Hold a guest back from writing while permissions are being reset. */
+    bdrv_drained_begin(inferior_bs);
+    /* Refresh permissions before the graph change. */
+    bdrv_child_refresh_perms(bs, child, &error_abort);
+    bdrv_replace_node(bs, inferior_bs, &error_abort);
+
+    bdrv_drained_end(inferior_bs);
+    bdrv_unref(inferior_bs);
+    bdrv_unref(bs);
+}
+
 /*
  * Run consistency checks on an image
  *
diff --git a/include/block/block.h b/include/block/block.h
index d16c401..ae7612f 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -350,6 +350,9 @@ void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
                  Error **errp);
 void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
                        Error **errp);
+BlockDriverState *bdrv_insert_node(BlockDriverState *bs, QDict *node_options,
+                                   int flags, Error **errp);
+void bdrv_remove_node(BlockDriverState *bs);
 
 int bdrv_parse_aio(const char *mode, int *flags);
 int bdrv_parse_cache_mode(const char *mode, int *flags, bool *writethrough);
-- 
1.8.3.1


