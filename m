Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71F2C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:24:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94E93206C0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CCQdKi6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E93206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joTkA-0007aM-SD
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joThz-0005EI-OJ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:22:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32017
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joThx-0000YX-PG
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593098553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dl5gsxaX3h9ydAHzCIHB7Hsfs7PhzxLzH9abiKtx1CE=;
 b=CCQdKi6jYNQm6wUhX7/eQgJZ5caeN85/WByZUqHbQ153u47SUSeAfHwUg2brHYlsaWxTNu
 AulOdVCf9VeCbU/IrQqraZuHkqb5jVe7jb3j6R2J2HWOwURNuSBRfdmVbDvsiBRd6zKHmY
 DWqI0D4+nEqPv3XpcbYz+zI1q5a3yYo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-EVTVE8qhNIq93gPD6shcrg-1; Thu, 25 Jun 2020 11:22:29 -0400
X-MC-Unique: EVTVE8qhNIq93gPD6shcrg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BB09EC1A7;
 Thu, 25 Jun 2020 15:22:28 +0000 (UTC)
Received: from localhost (ovpn-113-182.ams2.redhat.com [10.36.113.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DB641DC;
 Thu, 25 Jun 2020 15:22:27 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 05/47] block: Include filters when freezing backing chain
Date: Thu, 25 Jun 2020 17:21:33 +0200
Message-Id: <20200625152215.941773-6-mreitz@redhat.com>
In-Reply-To: <20200625152215.941773-1-mreitz@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 01:47:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In order to make filters work in backing chains, the associated
functions must be able to deal with them and freeze both COW and filter
child links.

While at it, add some comments that note which functions require their
caller to ensure that a given child link is not frozen, and how the
callers do so.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 60 +++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 21 deletions(-)

diff --git a/block.c b/block.c
index d139ffb57d..b59bd776cd 100644
--- a/block.c
+++ b/block.c
@@ -2595,12 +2595,15 @@ static void bdrv_replace_child_noperm(BdrvChild *child,
  * If @new_bs is not NULL, bdrv_check_perm() must be called beforehand, as this
  * function uses bdrv_set_perm() to update the permissions according to the new
  * reference that @new_bs gets.
+ *
+ * Callers must ensure that child->frozen is false.
  */
 static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs)
 {
     BlockDriverState *old_bs = child->bs;
     uint64_t perm, shared_perm;
 
+    /* Asserts that child->frozen == false */
     bdrv_replace_child_noperm(child, new_bs);
 
     /*
@@ -2761,6 +2764,7 @@ static void bdrv_detach_child(BdrvChild *child)
     g_free(child);
 }
 
+/* Callers must ensure that child->frozen is false. */
 void bdrv_root_unref_child(BdrvChild *child)
 {
     BlockDriverState *child_bs;
@@ -2798,6 +2802,7 @@ static void bdrv_unset_inherits_from(BlockDriverState *root, BdrvChild *child)
     }
 }
 
+/* Callers must ensure that child->frozen is false. */
 void bdrv_unref_child(BlockDriverState *parent, BdrvChild *child)
 {
     if (child == NULL) {
@@ -2864,6 +2869,7 @@ void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
     }
 
     if (bs->backing) {
+        /* Cannot be frozen, we checked that above */
         bdrv_unref_child(bs, bs->backing);
         bs->backing = NULL;
     }
@@ -4372,6 +4378,7 @@ static void bdrv_close(BlockDriverState *bs)
 
     if (bs->drv) {
         if (bs->drv->bdrv_close) {
+            /* Must unfreeze all children, so bdrv_unref_child() works */
             bs->drv->bdrv_close(bs);
         }
         bs->drv = NULL;
@@ -4741,20 +4748,22 @@ BlockDriverState *bdrv_find_base(BlockDriverState *bs)
 }
 
 /*
- * Return true if at least one of the backing links between @bs and
- * @base is frozen. @errp is set if that's the case.
+ * Return true if at least one of the COW (backing) and filter links
+ * between @bs and @base is frozen. @errp is set if that's the case.
  * @base must be reachable from @bs, or NULL.
  */
 bool bdrv_is_backing_chain_frozen(BlockDriverState *bs, BlockDriverState *base,
                                   Error **errp)
 {
     BlockDriverState *i;
+    BdrvChild *child;
 
-    for (i = bs; i != base; i = backing_bs(i)) {
-        if (i->backing && i->backing->frozen) {
+    for (i = bs; i != base; i = child_bs(child)) {
+        child = bdrv_filter_or_cow_child(i);
+
+        if (child && child->frozen) {
             error_setg(errp, "Cannot change '%s' link from '%s' to '%s'",
-                       i->backing->name, i->node_name,
-                       backing_bs(i)->node_name);
+                       child->name, i->node_name, child->bs->node_name);
             return true;
         }
     }
@@ -4763,7 +4772,7 @@ bool bdrv_is_backing_chain_frozen(BlockDriverState *bs, BlockDriverState *base,
 }
 
 /*
- * Freeze all backing links between @bs and @base.
+ * Freeze all COW (backing) and filter links between @bs and @base.
  * If any of the links is already frozen the operation is aborted and
  * none of the links are modified.
  * @base must be reachable from @bs, or NULL.
@@ -4773,22 +4782,25 @@ int bdrv_freeze_backing_chain(BlockDriverState *bs, BlockDriverState *base,
                               Error **errp)
 {
     BlockDriverState *i;
+    BdrvChild *child;
 
     if (bdrv_is_backing_chain_frozen(bs, base, errp)) {
         return -EPERM;
     }
 
-    for (i = bs; i != base; i = backing_bs(i)) {
-        if (i->backing && backing_bs(i)->never_freeze) {
+    for (i = bs; i != base; i = child_bs(child)) {
+        child = bdrv_filter_or_cow_child(i);
+        if (child && child->bs->never_freeze) {
             error_setg(errp, "Cannot freeze '%s' link to '%s'",
-                       i->backing->name, backing_bs(i)->node_name);
+                       child->name, child->bs->node_name);
             return -EPERM;
         }
     }
 
-    for (i = bs; i != base; i = backing_bs(i)) {
-        if (i->backing) {
-            i->backing->frozen = true;
+    for (i = bs; i != base; i = child_bs(child)) {
+        child = bdrv_filter_or_cow_child(i);
+        if (child) {
+            child->frozen = true;
         }
     }
 
@@ -4796,18 +4808,21 @@ int bdrv_freeze_backing_chain(BlockDriverState *bs, BlockDriverState *base,
 }
 
 /*
- * Unfreeze all backing links between @bs and @base. The caller must
- * ensure that all links are frozen before using this function.
+ * Unfreeze all COW (backing) and filter links between @bs and @base.
+ * The caller must ensure that all links are frozen before using this
+ * function.
  * @base must be reachable from @bs, or NULL.
  */
 void bdrv_unfreeze_backing_chain(BlockDriverState *bs, BlockDriverState *base)
 {
     BlockDriverState *i;
+    BdrvChild *child;
 
-    for (i = bs; i != base; i = backing_bs(i)) {
-        if (i->backing) {
-            assert(i->backing->frozen);
-            i->backing->frozen = false;
+    for (i = bs; i != base; i = child_bs(child)) {
+        child = bdrv_filter_or_cow_child(i);
+        if (child) {
+            assert(child->frozen);
+            child->frozen = false;
         }
     }
 }
@@ -4910,8 +4925,11 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
             }
         }
 
-        /* Do the actual switch in the in-memory graph.
-         * Completes bdrv_check_update_perm() transaction internally. */
+        /*
+         * Do the actual switch in the in-memory graph.
+         * Completes bdrv_check_update_perm() transaction internally.
+         * c->frozen is false, we have checked that above.
+         */
         bdrv_ref(base);
         bdrv_replace_child(c, base);
         bdrv_unref(top);
-- 
2.26.2


