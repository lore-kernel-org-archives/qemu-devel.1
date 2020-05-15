Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8962AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:15:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53B7520709
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ie06BwTX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B7520709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZaBt-0000DA-H9
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 09:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZjb-0003oI-43
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22519
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZjZ-0002TB-MF
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589546796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S83isIXzSMWcUNUD+G6daMYXj8AGmtILAs7bhnHWgbc=;
 b=ie06BwTX5KCq0v2wBpRapkJrepUtRqPcCtXlkReYHo5Tbl5vxHBFFegzYuEx0gYgl5B2Ao
 iBGJqt4OSESLv6MKWn50fzcs8tXkXPwpcLe8lsb/9tqzsEjGyIEiLkaZ24IRyAtEUBQeWQ
 ap4ZqWrO2q0JpfkIQ7lUr/7GQopm1u8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-zUHU1CN0PhCCu4J_xYJg3w-1; Fri, 15 May 2020 08:46:34 -0400
X-MC-Unique: zUHU1CN0PhCCu4J_xYJg3w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EACF107ACF7;
 Fri, 15 May 2020 12:46:33 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-110.ams2.redhat.com
 [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5480D2E170;
 Fri, 15 May 2020 12:46:32 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 45/51] block: Pass BdrvChildRole in remaining cases
Date: Fri, 15 May 2020 14:45:15 +0200
Message-Id: <20200515124521.335403-46-kwolf@redhat.com>
In-Reply-To: <20200515124521.335403-1-kwolf@redhat.com>
References: <20200515124521.335403-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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

These calls have no real use for the child role yet, but it will not
harm to give one.

Notably, the bdrv_root_attach_child() call in blockjob.c is left
unmodified because there is not much the generic BlockJob object wants
from its children.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200513110544.176672-34-mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/block-backend.c | 11 +++++++----
 block/vvfat.c         |  4 +++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index f2e81af27d..6936b25c83 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -424,8 +424,9 @@ BlockBackend *blk_new_open(const char *filename, const char *reference,
         return NULL;
     }
 
-    blk->root = bdrv_root_attach_child(bs, "root", &child_root, 0, blk->ctx,
-                                       perm, BLK_PERM_ALL, blk, errp);
+    blk->root = bdrv_root_attach_child(bs, "root", &child_root,
+                                       BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
+                                       blk->ctx, perm, BLK_PERM_ALL, blk, errp);
     if (!blk->root) {
         blk_unref(blk);
         return NULL;
@@ -835,8 +836,10 @@ int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
 {
     ThrottleGroupMember *tgm = &blk->public.throttle_group_member;
     bdrv_ref(bs);
-    blk->root = bdrv_root_attach_child(bs, "root", &child_root, 0, blk->ctx,
-                                       blk->perm, blk->shared_perm, blk, errp);
+    blk->root = bdrv_root_attach_child(bs, "root", &child_root,
+                                       BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
+                                       blk->ctx, blk->perm, blk->shared_perm,
+                                       blk, errp);
     if (blk->root == NULL) {
         return -EPERM;
     }
diff --git a/block/vvfat.c b/block/vvfat.c
index e8848a0497..089abe1e29 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3184,7 +3184,9 @@ static int enable_write_target(BlockDriverState *bs, Error **errp)
     options = qdict_new();
     qdict_put_str(options, "write-target.driver", "qcow");
     s->qcow = bdrv_open_child(s->qcow_filename, options, "write-target", bs,
-                              &child_vvfat_qcow, 0, false, errp);
+                              &child_vvfat_qcow,
+                              BDRV_CHILD_DATA | BDRV_CHILD_METADATA,
+                              false, errp);
     qobject_unref(options);
     if (!s->qcow) {
         ret = -EINVAL;
-- 
2.25.4


