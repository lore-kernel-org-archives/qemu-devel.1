Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E1CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:56:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14F52067D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2hnViXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14F52067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcBOr-0002yQ-IX
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 12:56:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kcB8U-00071B-5R
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:39:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54351)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kcB8S-0000Wb-2a
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:39:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604943559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/FiHgfxsqyDyfxEXB1QurImZiK6ee8uiHeIHcWP8gCg=;
 b=P2hnViXodUydoxTGg5RqH0qM3Tu6iPxld5Zz5L6BeVT+FUXktwHI99/+STMEO5CG5cOPRW
 Qhpm/UWDGVl3PSBJ0BFEEe4zU7DnXQQjHoxgMl8Ezf1V7mFjwqgKs7NwnZXJSoSQmqaszB
 YYoEyWB0XnWr8tB/Cb1q8/6E5Iudp68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-5o6xs8wXMs-BxSFhdkKsYg-1; Mon, 09 Nov 2020 12:39:17 -0500
X-MC-Unique: 5o6xs8wXMs-BxSFhdkKsYg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E499107465A;
 Mon,  9 Nov 2020 17:39:16 +0000 (UTC)
Received: from localhost (ovpn-113-179.ams2.redhat.com [10.36.113.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A1C1C6EF5C;
 Mon,  9 Nov 2020 17:39:15 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 15/15] block: make bdrv_drop_intermediate() less wrong
Date: Mon,  9 Nov 2020 18:38:39 +0100
Message-Id: <20201109173839.2135984-16-mreitz@redhat.com>
In-Reply-To: <20201109173839.2135984-1-mreitz@redhat.com>
References: <20201109173839.2135984-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

First, permission update loop tries to do iterations transactionally,
but the whole update is not transactional: nobody roll-back successful
loop iterations when some iteration fails.

Second, in the iteration we have nested permission update:
c->klass->update_filename may point to bdrv_child_cb_update_filename()
which calls bdrv_backing_update_filename(), which may do node reopen to
RW.

Permission update system is not prepared to nested updates, at least it
has intermediate permission-update state stored in BdrvChild
structures: has_backup_perm, backup_perm and backup_shared_perm.

So, let's first do bdrv_replace_node_common() (which is more
transactional than open-coded update in bdrv_drop_intermediate()) and
then call update_filename() in separate. We still do not rollback
changes in case of update_filename() failure but it's not much worse
than pre-patch behavior.

Note that bdrv_replace_node_common() does check for frozen children,
so corresponding check is dropped in bdrv_drop_intermediate().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20201106124241.16950-4-vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 54 ++++++++++++++++++++++++------------------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/block.c b/block.c
index 9a945a058d..f1cedac362 100644
--- a/block.c
+++ b/block.c
@@ -4910,9 +4910,11 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
 {
     BlockDriverState *explicit_top = top;
     bool update_inherits_from;
-    BdrvChild *c, *next;
+    BdrvChild *c;
     Error *local_err = NULL;
     int ret = -EIO;
+    g_autoptr(GSList) updated_children = NULL;
+    GSList *p;
 
     bdrv_ref(top);
     bdrv_subtree_drained_begin(top);
@@ -4926,14 +4928,6 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
         goto exit;
     }
 
-    /* This function changes all links that point to top and makes
-     * them point to base. Check that none of them is frozen. */
-    QLIST_FOREACH(c, &top->parents, next_parent) {
-        if (c->frozen) {
-            goto exit;
-        }
-    }
-
     /* If 'base' recursively inherits from 'top' then we should set
      * base->inherits_from to top->inherits_from after 'top' and all
      * other intermediate nodes have been dropped.
@@ -4950,36 +4944,36 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
         backing_file_str = base->filename;
     }
 
-    QLIST_FOREACH_SAFE(c, &top->parents, next_parent, next) {
-        /* Check whether we are allowed to switch c from top to base */
-        GSList *ignore_children = g_slist_prepend(NULL, c);
-        ret = bdrv_check_update_perm(base, NULL, c->perm, c->shared_perm,
-                                     ignore_children, NULL, &local_err);
-        g_slist_free(ignore_children);
-        if (ret < 0) {
-            error_report_err(local_err);
-            goto exit;
-        }
+    QLIST_FOREACH(c, &top->parents, next_parent) {
+        updated_children = g_slist_prepend(updated_children, c);
+    }
+
+    bdrv_replace_node_common(top, base, false, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        goto exit;
+    }
+
+    for (p = updated_children; p; p = p->next) {
+        c = p->data;
 
-        /* If so, update the backing file path in the image file */
         if (c->klass->update_filename) {
             ret = c->klass->update_filename(c, base, backing_file_str,
                                             &local_err);
             if (ret < 0) {
-                bdrv_abort_perm_update(base);
+                /*
+                 * TODO: Actually, we want to rollback all previous iterations
+                 * of this loop, and (which is almost impossible) previous
+                 * bdrv_replace_node()...
+                 *
+                 * Note, that c->klass->update_filename may lead to permission
+                 * update, so it's a bad idea to call it inside permission
+                 * update transaction of bdrv_replace_node.
+                 */
                 error_report_err(local_err);
                 goto exit;
             }
         }
-
-        /*
-         * Do the actual switch in the in-memory graph.
-         * Completes bdrv_check_update_perm() transaction internally.
-         * c->frozen is false, we have checked that above.
-         */
-        bdrv_ref(base);
-        bdrv_replace_child(c, base);
-        bdrv_unref(top);
     }
 
     if (update_inherits_from) {
-- 
2.28.0


