Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F2BCA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:12:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2818220740
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bK7WKx9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2818220740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYpJW-00039l-71
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 07:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpDZ-0001ir-Qi
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:06:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23428
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpDY-0003RW-Sy
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589367988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k68u1Za7iA4GLoZz/RT9eaWrdNEzjmE5mbKppChZ1XA=;
 b=bK7WKx9nJRtkW41ZKyHVOU89eZ88tgM10SWHV92t+OMlDeBTh6YSSmEPrYx9r8C9sHG3XJ
 06lxtis0IUW3yBOa7cXCGmFoiHQWuelM+NxUC3OPEbEQyBApylApRy8/u8aGG7wrzejkMc
 9yOe68PmuUSwwnTWaqXo6eP1uNjPUug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-7PKNHN-5NfOiLF8UNjWm5g-1; Wed, 13 May 2020 07:06:26 -0400
X-MC-Unique: 7PKNHN-5NfOiLF8UNjWm5g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BE0019200C2;
 Wed, 13 May 2020 11:06:25 +0000 (UTC)
Received: from localhost (unknown [10.40.193.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 135905C1C3;
 Wed, 13 May 2020 11:06:24 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 14/34] block: Add child_of_bds
Date: Wed, 13 May 2020 13:05:24 +0200
Message-Id: <20200513110544.176672-15-mreitz@redhat.com>
In-Reply-To: <20200513110544.176672-1-mreitz@redhat.com>
References: <20200513110544.176672-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

Any current user of child_file, child_format, and child_backing can and
should use this generic BdrvChildClass instead, as it can handle all of
these cases.  However, to be able to do so, the users must pass the
appropriate BdrvChildRole when the child is created/attached.  (The
following commits will take care of that.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
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
2.26.2


