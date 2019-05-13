Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464A0C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 13:55:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01429208CA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 13:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ikv5K70b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01429208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57727 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQBQG-0006es-4m
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 09:55:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hQBLu-0002eK-UP
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hQBHr-0005dg-Ps
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:46:41 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:36075)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hQBHr-0005cl-8A; Mon, 13 May 2019 09:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=References:In-Reply-To:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
	bh=Bp2rDBX4jzQoNNjJIRpWbG7q9lv1oZ+IR+SGedfJbBo=; 
	b=ikv5K70b8TAi/pKku4NjQPD09aFc5LOUWJvL6zr6AOrPcz9FAAYGouVgYkmg1iH3AODi0hsinfyTnu+VGa9lIe0suRpFYBKZheDA1fmOoAiQlm+zp9uVOjBkj+womiQxqZSZRVDn1yEZCKvmcp+LzNfBWYsIz3pDnT6z8wPkvBVZuZ5Q4IVopPOZmbFdGkLMJQCSB9rj/nQCvYD9hBZqEt/arZBnugAj65Efhodn7K0fdPnPfbgVUPy5XJYSKSF/Lw0829lepzouga1vwmCvISVVzEH+5AOIey6MuPpc1ASvNIrCkL5wr3hpY98Jgm/mujV4Yw+vG8JNH/WezthrKQ==;
Received: from mobile-access-bcee32-86.dhcp.inet.fi ([188.238.50.86]
	helo=perseus.local) by fanzine.igalia.com with esmtpsa 
	(Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
	id 1hQBHo-0003gd-Dq; Mon, 13 May 2019 15:46:36 +0200
Received: from berto by perseus.local with local (Exim 4.89)
	(envelope-from <berto@igalia.com>)
	id 1hQBHb-0003By-9i; Mon, 13 May 2019 16:46:23 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 16:46:18 +0300
Message-Id: <20dfb3d9ccec559cdd1a9690146abad5d204a186.1557754872.git.berto@igalia.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1557754872.git.berto@igalia.com>
References: <cover.1557754872.git.berto@igalia.com>
In-Reply-To: <cover.1557754872.git.berto@igalia.com>
References: <cover.1557754872.git.berto@igalia.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: [Qemu-devel] [PATCH v3 2/2] block: Make bdrv_root_attach_child()
 unref child_bs on failure
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
	qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A consequence of the previous patch is that bdrv_attach_child()
transfers the reference to child_bs from the caller to parent_bs,
which will drop it on bdrv_close() or when someone calls
bdrv_unref_child().

But this only happens when bdrv_attach_child() succeeds. If it fails
then the caller is responsible for dropping the reference to child_bs.

This patch makes bdrv_attach_child() take the reference also when
there is an error, freeing the caller for having to do it.

A similar situation happens with bdrv_root_attach_child(), so the
changes on this patch affect both functions.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c               | 25 +++++++++++++++++--------
 block/block-backend.c |  3 +--
 block/quorum.c        |  1 -
 blockjob.c            |  2 +-
 4 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/block.c b/block.c
index 3c3bd0f8d2..df727314ff 100644
--- a/block.c
+++ b/block.c
@@ -2208,6 +2208,13 @@ static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs)
     }
 }
 
+/*
+ * This function steals the reference to child_bs from the caller.
+ * That reference is later dropped by bdrv_root_unref_child().
+ *
+ * On failure NULL is returned, errp is set and the reference to
+ * child_bs is also dropped.
+ */
 BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
                                   const char *child_name,
                                   const BdrvChildRole *child_role,
@@ -2220,6 +2227,7 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
     ret = bdrv_check_update_perm(child_bs, NULL, perm, shared_perm, NULL, errp);
     if (ret < 0) {
         bdrv_abort_perm_update(child_bs);
+        bdrv_unref(child_bs);
         return NULL;
     }
 
@@ -2239,6 +2247,14 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
     return child;
 }
 
+/*
+ * This function transfers the reference to child_bs from the caller
+ * to parent_bs. That reference is later dropped by parent_bs on
+ * bdrv_close() or if someone calls bdrv_unref_child().
+ *
+ * On failure NULL is returned, errp is set and the reference to
+ * child_bs is also dropped.
+ */
 BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
                              BlockDriverState *child_bs,
                              const char *child_name,
@@ -2366,12 +2382,9 @@ void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
     /* If backing_hd was already part of bs's backing chain, and
      * inherits_from pointed recursively to bs then let's update it to
      * point directly to bs (else it will become NULL). */
-    if (update_inherits_from) {
+    if (bs->backing && update_inherits_from) {
         backing_hd->inherits_from = bs;
     }
-    if (!bs->backing) {
-        bdrv_unref(backing_hd);
-    }
 
 out:
     bdrv_refresh_limits(bs, NULL);
@@ -2569,10 +2582,6 @@ BdrvChild *bdrv_open_child(const char *filename,
     }
 
     c = bdrv_attach_child(parent, bs, bdref_key, child_role, errp);
-    if (!c) {
-        bdrv_unref(bs);
-        return NULL;
-    }
 
     return c;
 }
diff --git a/block/block-backend.c b/block/block-backend.c
index f78e82a707..7a621597e7 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -383,7 +383,6 @@ BlockBackend *blk_new_open(const char *filename, const char *reference,
     blk->root = bdrv_root_attach_child(bs, "root", &child_root,
                                        perm, BLK_PERM_ALL, blk, errp);
     if (!blk->root) {
-        bdrv_unref(bs);
         blk_unref(blk);
         return NULL;
     }
@@ -791,12 +790,12 @@ void blk_remove_bs(BlockBackend *blk)
 int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
 {
     ThrottleGroupMember *tgm = &blk->public.throttle_group_member;
+    bdrv_ref(bs);
     blk->root = bdrv_root_attach_child(bs, "root", &child_root,
                                        blk->perm, blk->shared_perm, blk, errp);
     if (blk->root == NULL) {
         return -EPERM;
     }
-    bdrv_ref(bs);
 
     notifier_list_notify(&blk->insert_bs_notifiers, blk);
     if (tgm->throttle_state) {
diff --git a/block/quorum.c b/block/quorum.c
index 352f729136..133ee18204 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1019,7 +1019,6 @@ static void quorum_add_child(BlockDriverState *bs, BlockDriverState *child_bs,
     child = bdrv_attach_child(bs, child_bs, indexstr, &child_format, errp);
     if (child == NULL) {
         s->next_child_index--;
-        bdrv_unref(child_bs);
         goto out;
     }
     s->children = g_renew(BdrvChild *, s->children, s->num_children + 1);
diff --git a/blockjob.c b/blockjob.c
index 730101d282..b68fa4b13e 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -208,6 +208,7 @@ int block_job_add_bdrv(BlockJob *job, const char *name, BlockDriverState *bs,
 {
     BdrvChild *c;
 
+    bdrv_ref(bs);
     c = bdrv_root_attach_child(bs, name, &child_job, perm, shared_perm,
                                job, errp);
     if (c == NULL) {
@@ -215,7 +216,6 @@ int block_job_add_bdrv(BlockJob *job, const char *name, BlockDriverState *bs,
     }
 
     job->nodes = g_slist_prepend(job->nodes, c);
-    bdrv_ref(bs);
     bdrv_op_block_all(bs, job->blocker);
 
     return 0;
-- 
2.11.0


