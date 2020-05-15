Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7B8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 944022074D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4cQsXth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 944022074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZZvI-00029H-LG
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 08:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZjC-0002sV-IV
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22893
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZj9-0002LK-Vg
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589546771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zQUje6L++K+HCykTJZlsV1fOYXQaL1kXm8P3kuauhOk=;
 b=T4cQsXthTPpRXsbHzMC4aYtSIvWTAX+A3XIlnegbWRSTno0pcuTcoN0g5v08u9t5ZteOHG
 1jd7zUsZCdUFIEHbq07UygnDtbBwqcQNaFzfT4ObUJoWExeq37UZ4hBF6Y/okDpYSdIZKp
 ER/XiwAiNqhDG9eF/ZdBvxHPzFRtlhY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-To8sZwWdM2a5n2HkH0-flA-1; Fri, 15 May 2020 08:46:08 -0400
X-MC-Unique: To8sZwWdM2a5n2HkH0-flA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C959CA0BD7;
 Fri, 15 May 2020 12:46:07 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-110.ams2.redhat.com
 [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D0A262E024;
 Fri, 15 May 2020 12:46:06 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 25/51] block: Unify bdrv_child_cb_detach()
Date: Fri, 15 May 2020 14:44:55 +0200
Message-Id: <20200515124521.335403-26-kwolf@redhat.com>
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

Make bdrv_child_cb_detach() call bdrv_backing_detach() for children with
a COW role (and drop the reverse call from bdrv_backing_detach()), so it
can be used for any child (with a proper role set).

Because so far no child has a proper role set, we need a temporary new
callback for child_backing.detach that ensures bdrv_backing_detach() is
called for all COW children that do not have their role set yet.

(Also, move bdrv_child_cb_detach() down to group it with
bdrv_inherited_options() and bdrv_child_cb_attach().)

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200513110544.176672-14-mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
2.25.4


