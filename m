Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDADDC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:09:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A148B20657
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fk2nGxxD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A148B20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZa5z-0004uY-Rr
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 09:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZjD-0002vW-O8
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41867
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZjB-0002Li-4m
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589546772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=exmpVgQdn1BPIsIvyOs3f+hoWImPMi+7oYKNGj+Heao=;
 b=Fk2nGxxDi5Jh2HWXhE3lOK3I1yCXSjE3EWI9E/9J1gsgWQnjhb+1p+m7mmhU/+MkyjMQOX
 LrBgUWHYARw5r946Rn/LaaY+DXDDF6QhZO8hjrWu7jmlnWv4xmhxZOI8L8aNPRWi2N+eLW
 HGIGOvZSLE63WOMhoM/fk0jwNYF1ZoY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-wHxyvcgvMFedikEP6aL6_w-1; Fri, 15 May 2020 08:46:10 -0400
X-MC-Unique: wHxyvcgvMFedikEP6aL6_w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 170AC8005AD;
 Fri, 15 May 2020 12:46:09 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-110.ams2.redhat.com
 [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E8EB2E024;
 Fri, 15 May 2020 12:46:07 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 26/51] block: Add child_of_bds
Date: Fri, 15 May 2020 14:44:56 +0200
Message-Id: <20200515124521.335403-27-kwolf@redhat.com>
In-Reply-To: <20200515124521.335403-1-kwolf@redhat.com>
References: <20200515124521.335403-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:07:24
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

Any current user of child_file, child_format, and child_backing can and
should use this generic BdrvChildClass instead, as it can handle all of
these cases.  However, to be able to do so, the users must pass the
appropriate BdrvChildRole when the child is created/attached.  (The
following commits will take care of that.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200513110544.176672-15-mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int.h |  1 +
 block.c                   | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 6245d8a18d..54df821d61 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -740,6 +740,7 @@ struct BdrvChildClass {
     void (*set_aio_ctx)(BdrvChild *child, AioContext *ctx, GSList **ignore);
 };
 
+extern const BdrvChildClass child_of_bds;
 extern const BdrvChildClass child_file;
 extern const BdrvChildClass child_format;
 extern const BdrvChildClass child_backing;
diff --git a/block.c b/block.c
index f63417c06d..be9bfa9d46 100644
--- a/block.c
+++ b/block.c
@@ -1429,6 +1429,30 @@ static void bdrv_child_cb_detach(BdrvChild *child)
     bdrv_unapply_subtree_drain(child, bs);
 }
 
+static int bdrv_child_cb_update_filename(BdrvChild *c, BlockDriverState *base,
+                                         const char *filename, Error **errp)
+{
+    if (c->role & BDRV_CHILD_COW) {
+        return bdrv_backing_update_filename(c, base, filename, errp);
+    }
+    return 0;
+}
+
+const BdrvChildClass child_of_bds = {
+    .parent_is_bds   = true,
+    .get_parent_desc = bdrv_child_get_parent_desc,
+    .inherit_options = bdrv_inherited_options,
+    .drained_begin   = bdrv_child_cb_drained_begin,
+    .drained_poll    = bdrv_child_cb_drained_poll,
+    .drained_end     = bdrv_child_cb_drained_end,
+    .attach          = bdrv_child_cb_attach,
+    .detach          = bdrv_child_cb_detach,
+    .inactivate      = bdrv_child_cb_inactivate,
+    .can_set_aio_ctx = bdrv_child_cb_can_set_aio_ctx,
+    .set_aio_ctx     = bdrv_child_cb_set_aio_ctx,
+    .update_filename = bdrv_child_cb_update_filename,
+};
+
 static int bdrv_open_flags(BlockDriverState *bs, int flags)
 {
     int open_flags = flags;
-- 
2.25.4


