Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0190C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:06:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A309C20657
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QKhdvCtP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A309C20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZa33-0007lW-QH
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 09:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZjF-0002zA-9G
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29764
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZj9-0002KT-47
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589546770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NbJfsYfo07GaMxBwWalEQHpvwpMDYTD/7dFv2WLaHhQ=;
 b=QKhdvCtPQHP8NzXPfKTDk3uxyVCDx7uFrUwcxBsAq/+p5dtbbMLhpnxpto/TuXA4AEoqaJ
 MsypIyBajZDq2sHHKtsgHBHBQVt3WnAnKBT9+HdNENL2dAI0CHE3yWuD06V+maR3sllXkl
 u0COnEQ+pSmCnENJ4QhWtwXcKQeg+z0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-MGC3ZNoHPOitsbqmGZPFsQ-1; Fri, 15 May 2020 08:46:07 -0400
X-MC-Unique: MGC3ZNoHPOitsbqmGZPFsQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87078801503;
 Fri, 15 May 2020 12:46:06 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-110.ams2.redhat.com
 [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8EFA12E024;
 Fri, 15 May 2020 12:46:05 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 24/51] block: Unify bdrv_child_cb_attach()
Date: Fri, 15 May 2020 14:44:54 +0200
Message-Id: <20200515124521.335403-25-kwolf@redhat.com>
In-Reply-To: <20200515124521.335403-1-kwolf@redhat.com>
References: <20200515124521.335403-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:27:07
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Make bdrv_child_cb_attach() call bdrv_backing_attach() for children with
a COW role (and drop the reverse call from bdrv_backing_attach()), so it
can be used for any child (with a proper role set).

Because so far no child has a proper role set, we need a temporary new
callback for child_backing.attach that ensures bdrv_backing_attach() is
called for all COW children that do not have their role set yet.

(Also, move bdrv_child_cb_attach() down to group it with
bdrv_inherited_options().)

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200513110544.176672-13-mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/block.c b/block.c
index b3b978a092..755704a54c 100644
--- a/block.c
+++ b/block.c
@@ -84,6 +84,7 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
 static void bdrv_inherited_options(BdrvChildRole role, bool parent_is_format,
                                    int *child_flags, QDict *child_options,
                                    int parent_flags, QDict *parent_options);
+static void bdrv_child_cb_attach(BdrvChild *child);
 
 /* If non-zero, use only whitelisted block drivers */
 static int use_bdrv_whitelist;
@@ -1099,12 +1100,6 @@ static void bdrv_child_cb_drained_end(BdrvChild *child,
     bdrv_drained_end_no_poll(bs, drained_end_counter);
 }
 
-static void bdrv_child_cb_attach(BdrvChild *child)
-{
-    BlockDriverState *bs = child->opaque;
-    bdrv_apply_subtree_drain(child, bs);
-}
-
 static void bdrv_child_cb_detach(BdrvChild *child)
 {
     BlockDriverState *bs = child->opaque;
@@ -1252,7 +1247,14 @@ static void bdrv_backing_attach(BdrvChild *c)
                     parent->backing_blocker);
     bdrv_op_unblock(backing_hd, BLOCK_OP_TYPE_BACKUP_TARGET,
                     parent->backing_blocker);
+}
 
+/* XXX: Will be removed along with child_backing */
+static void bdrv_child_cb_attach_backing(BdrvChild *c)
+{
+    if (!(c->role & BDRV_CHILD_COW)) {
+        bdrv_backing_attach(c);
+    }
     bdrv_child_cb_attach(c);
 }
 
@@ -1311,7 +1313,7 @@ static int bdrv_backing_update_filename(BdrvChild *c, BlockDriverState *base,
 const BdrvChildClass child_backing = {
     .parent_is_bds   = true,
     .get_parent_desc = bdrv_child_get_parent_desc,
-    .attach          = bdrv_backing_attach,
+    .attach          = bdrv_child_cb_attach_backing,
     .detach          = bdrv_backing_detach,
     .inherit_options = bdrv_backing_options,
     .drained_begin   = bdrv_child_cb_drained_begin,
@@ -1403,6 +1405,17 @@ static void bdrv_inherited_options(BdrvChildRole role, bool parent_is_format,
     *child_flags = flags;
 }
 
+static void bdrv_child_cb_attach(BdrvChild *child)
+{
+    BlockDriverState *bs = child->opaque;
+
+    if (child->role & BDRV_CHILD_COW) {
+        bdrv_backing_attach(child);
+    }
+
+    bdrv_apply_subtree_drain(child, bs);
+}
+
 static int bdrv_open_flags(BlockDriverState *bs, int flags)
 {
     int open_flags = flags;
-- 
2.25.4


