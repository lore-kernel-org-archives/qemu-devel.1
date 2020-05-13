Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BA5C2D0FA
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:26:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41DEC2078C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G79310a9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41DEC2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYpWa-0001FA-Eq
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 07:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpDx-0002cE-LN
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:06:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41345
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpDv-0003W0-Kw
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589368010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HxkSJ85lDyAy9b7MqcqSrMYoaFkSl1srX+rWrTAxmZU=;
 b=G79310a9Gmng4Y5Ygh3UHFR+R2IuO5g4f4ir4gUutpBWoxC+nU9u40neYK9PZ1GqX5P+Le
 biwlIOE7CiubK0vshwPQgy86Vjx5uq0oajuMyLam9F60uvz6SwMSLvLQWDBMJIWr1gclno
 XmzZckwEtIBGZ8R+uoWWSoRhuCoeU2o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-YVqTfmIZNWOaKCTPGNxG1w-1; Wed, 13 May 2020 07:06:48 -0400
X-MC-Unique: YVqTfmIZNWOaKCTPGNxG1w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF4321009629;
 Wed, 13 May 2020 11:06:47 +0000 (UTC)
Received: from localhost (unknown [10.40.193.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 83DF82E035;
 Wed, 13 May 2020 11:06:47 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 23/34] block: Make backing files child_of_bds children
Date: Wed, 13 May 2020 13:05:33 +0200
Message-Id: <20200513110544.176672-24-mreitz@redhat.com>
In-Reply-To: <20200513110544.176672-1-mreitz@redhat.com>
References: <20200513110544.176672-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make all parents of backing files pass the appropriate BdrvChildRole.
By doing so, we can switch their BdrvChildClass over to the generic
child_of_bds, which will do the right thing when given a correct
BdrvChildRole.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c                 | 26 ++++++++++++++++++++------
 block/backup-top.c      |  2 +-
 block/vvfat.c           |  3 ++-
 tests/test-bdrv-drain.c | 13 +++++++------
 4 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/block.c b/block.c
index 85b4f947ba..131ae20ffc 100644
--- a/block.c
+++ b/block.c
@@ -2941,6 +2941,20 @@ static bool bdrv_inherits_from_recursive(BlockDriverState *child,
     return child != NULL;
 }
 
+/*
+ * Return the BdrvChildRole for @bs's backing child.  bs->backing is
+ * mostly used for COW backing children (role = COW), but also for
+ * filtered children (role = FILTERED | PRIMARY).
+ */
+static BdrvChildRole bdrv_backing_role(BlockDriverState *bs)
+{
+    if (bs->drv && bs->drv->is_filter) {
+        return BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY;
+    } else {
+        return BDRV_CHILD_COW;
+    }
+}
+
 /*
  * Sets the backing file link of a BDS. A new reference is created; callers
  * which don't need their own reference any more must call bdrv_unref().
@@ -2968,8 +2982,8 @@ void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
         goto out;
     }
 
-    bs->backing = bdrv_attach_child(bs, backing_hd, "backing", &child_backing,
-                                    0, errp);
+    bs->backing = bdrv_attach_child(bs, backing_hd, "backing", &child_of_bds,
+                                    bdrv_backing_role(bs), errp);
     /* If backing_hd was already part of bs's backing chain, and
      * inherits_from pointed recursively to bs then let's update it to
      * point directly to bs (else it will become NULL). */
@@ -3066,7 +3080,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
     }
 
     backing_hd = bdrv_open_inherit(backing_filename, reference, options, 0, bs,
-                                   &child_backing, 0, errp);
+                                   &child_of_bds, bdrv_backing_role(bs), errp);
     if (!backing_hd) {
         bs->open_flags |= BDRV_O_NO_BACKING;
         error_prepend(errp, "Could not open backing file: ");
@@ -3895,8 +3909,8 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp)
         if (state->replace_backing_bs && state->new_backing_bs) {
             uint64_t nperm, nshared;
             bdrv_child_perm(state->bs, state->new_backing_bs,
-                            NULL, &child_backing, 0, bs_queue,
-                            state->perm, state->shared_perm,
+                            NULL, &child_of_bds, bdrv_backing_role(state->bs),
+                            bs_queue, state->perm, state->shared_perm,
                             &nperm, &nshared);
             ret = bdrv_check_update_perm(state->new_backing_bs, NULL,
                                          nperm, nshared, NULL, NULL, errp);
@@ -6852,7 +6866,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
         drv->bdrv_gather_child_options(bs, opts, backing_overridden);
     } else {
         QLIST_FOREACH(child, &bs->children, next) {
-            if (child->klass == &child_backing && !backing_overridden) {
+            if (child == bs->backing && !backing_overridden) {
                 /* We can skip the backing BDS if it has not been overridden */
                 continue;
             }
diff --git a/block/backup-top.c b/block/backup-top.c
index e2b4d2acd3..f059617095 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -143,7 +143,7 @@ static void backup_top_child_perm(BlockDriverState *bs, BdrvChild *c,
         return;
     }
 
-    if (child_class == &child_file) {
+    if (!(role & BDRV_CHILD_FILTERED)) {
         /*
          * Target child
          *
diff --git a/block/vvfat.c b/block/vvfat.c
index b4c8417dbd..e8848a0497 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3219,7 +3219,8 @@ static void vvfat_child_perm(BlockDriverState *bs, BdrvChild *c,
 {
     BDRVVVFATState *s = bs->opaque;
 
-    assert(c == s->qcow || child_class == &child_backing);
+    assert(c == s->qcow ||
+           (child_class == &child_of_bds && (role & BDRV_CHILD_COW)));
 
     if (c == s->qcow) {
         /* This is a private node, nobody should try to attach to it */
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index b3d7960bd0..15393a0140 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -96,7 +96,7 @@ static void bdrv_test_child_perm(BlockDriverState *bs, BdrvChild *c,
      * bdrv_format_default_perms() accepts only these two, so disguise
      * detach_by_driver_cb_parent as one of them.
      */
-    if (child_class != &child_file && child_class != &child_backing) {
+    if (child_class != &child_file && child_class != &child_of_bds) {
         child_class = &child_file;
     }
 
@@ -1399,8 +1399,8 @@ static void test_detach_indirect(bool by_parent_cb)
     bdrv_ref(a);
     child_b = bdrv_attach_child(parent_b, b, "PB-B", &child_file, 0,
                                 &error_abort);
-    child_a = bdrv_attach_child(parent_b, a, "PB-A", &child_backing, 0,
-                                &error_abort);
+    child_a = bdrv_attach_child(parent_b, a, "PB-A", &child_of_bds,
+                                BDRV_CHILD_COW, &error_abort);
 
     bdrv_ref(a);
     bdrv_attach_child(parent_a, a, "PA-A",
@@ -1793,7 +1793,7 @@ static void test_drop_intermediate_poll(void)
     int i;
     int ret;
 
-    chain_child_class = child_backing;
+    chain_child_class = child_of_bds;
     chain_child_class.update_filename = drop_intermediate_poll_update_filename;
 
     for (i = 0; i < 3; i++) {
@@ -1816,7 +1816,7 @@ static void test_drop_intermediate_poll(void)
             /* Takes the reference to chain[i - 1] */
             chain[i]->backing = bdrv_attach_child(chain[i], chain[i - 1],
                                                   "chain", &chain_child_class,
-                                                  0, &error_abort);
+                                                  BDRV_CHILD_COW, &error_abort);
         }
     }
 
@@ -2034,7 +2034,8 @@ static void do_test_replace_child_mid_drain(int old_drain_count,
 
     bdrv_ref(old_child_bs);
     parent_bs->backing = bdrv_attach_child(parent_bs, old_child_bs, "child",
-                                           &child_backing, 0, &error_abort);
+                                           &child_of_bds, BDRV_CHILD_COW,
+                                           &error_abort);
 
     for (i = 0; i < old_drain_count; i++) {
         bdrv_drained_begin(old_child_bs);
-- 
2.26.2


