Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE57BC2D0FC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:14:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C50C20740
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JOlgr4kX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C50C20740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYpL1-0005mE-OP
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 07:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpDX-0001cf-Fy
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:06:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28347
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpDW-0003Qi-Ca
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589367985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J7wXNOmdeaThFceSvOMegYbyo31W9+9fkSBEoOpACtM=;
 b=JOlgr4kXpgPQwCDJqiHwSxARRbNIcoGgTzEMG0x98biqYPRh+/LFXz2jDSb9hvgIUhFwfy
 enyW90TaPTujldFUYT+deKJwASh0UI+LtJpHYVOa4+dSJprzE9j9jgwl328tlrsDOnKUKY
 e89M0oFPpUqgTLTmdlKWkYzN5FG215Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-W6uDeO3mNwGeH3FFA4BWlA-1; Wed, 13 May 2020 07:06:23 -0400
X-MC-Unique: W6uDeO3mNwGeH3FFA4BWlA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC4BF8014D7;
 Wed, 13 May 2020 11:06:22 +0000 (UTC)
Received: from localhost (unknown [10.40.193.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8264160C05;
 Wed, 13 May 2020 11:06:22 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 13/34] block: Unify bdrv_child_cb_detach()
Date: Wed, 13 May 2020 13:05:23 +0200
Message-Id: <20200513110544.176672-14-mreitz@redhat.com>
In-Reply-To: <20200513110544.176672-1-mreitz@redhat.com>
References: <20200513110544.176672-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
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

Make bdrv_child_cb_detach() call bdrv_backing_detach() for children with
a COW role (and drop the reverse call from bdrv_backing_detach()), so it
can be used for any child (with a proper role set).

Because so far no child has a proper role set, we need a temporary new
callback for child_backing.detach that ensures bdrv_backing_detach() is
called for all COW children that do not have their role set yet.

(Also, move bdrv_child_cb_detach() down to group it with
bdrv_inherited_options() and bdrv_child_cb_attach().)

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/block.c b/block.c
index 755704a54c..f63417c06d 100644
--- a/block.c
+++ b/block.c
@@ -85,6 +85,7 @@ static void bdrv_inherited_options(BdrvChildRole role, bool parent_is_format,
                                    int *child_flags, QDict *child_options,
                                    int parent_flags, QDict *parent_options);
 static void bdrv_child_cb_attach(BdrvChild *child);
+static void bdrv_child_cb_detach(BdrvChild *child);
 
 /* If non-zero, use only whitelisted block drivers */
 static int use_bdrv_whitelist;
@@ -1100,12 +1101,6 @@ static void bdrv_child_cb_drained_end(BdrvChild *child,
     bdrv_drained_end_no_poll(bs, drained_end_counter);
 }
 
-static void bdrv_child_cb_detach(BdrvChild *child)
-{
-    BlockDriverState *bs = child->opaque;
-    bdrv_unapply_subtree_drain(child, bs);
-}
-
 static int bdrv_child_cb_inactivate(BdrvChild *child)
 {
     BlockDriverState *bs = child->opaque;
@@ -1266,7 +1261,14 @@ static void bdrv_backing_detach(BdrvChild *c)
     bdrv_op_unblock_all(c->bs, parent->backing_blocker);
     error_free(parent->backing_blocker);
     parent->backing_blocker = NULL;
+}
 
+/* XXX: Will be removed along with child_backing */
+static void bdrv_child_cb_detach_backing(BdrvChild *c)
+{
+    if (!(c->role & BDRV_CHILD_COW)) {
+        bdrv_backing_detach(c);
+    }
     bdrv_child_cb_detach(c);
 }
 
@@ -1314,7 +1316,7 @@ const BdrvChildClass child_backing = {
     .parent_is_bds   = true,
     .get_parent_desc = bdrv_child_get_parent_desc,
     .attach          = bdrv_child_cb_attach_backing,
-    .detach          = bdrv_backing_detach,
+    .detach          = bdrv_child_cb_detach_backing,
     .inherit_options = bdrv_backing_options,
     .drained_begin   = bdrv_child_cb_drained_begin,
     .drained_poll    = bdrv_child_cb_drained_poll,
@@ -1416,6 +1418,17 @@ static void bdrv_child_cb_attach(BdrvChild *child)
     bdrv_apply_subtree_drain(child, bs);
 }
 
+static void bdrv_child_cb_detach(BdrvChild *child)
+{
+    BlockDriverState *bs = child->opaque;
+
+    if (child->role & BDRV_CHILD_COW) {
+        bdrv_backing_detach(child);
+    }
+
+    bdrv_unapply_subtree_drain(child, bs);
+}
+
 static int bdrv_open_flags(BlockDriverState *bs, int flags)
 {
     int open_flags = flags;
-- 
2.26.2


