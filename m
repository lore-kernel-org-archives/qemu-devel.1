Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC422C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:38:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73616206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GhfYaguf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73616206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6GFe-0001JM-MD
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 12:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G7c-0002qr-4C
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:30:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41854
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G7a-0001Qj-BC
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597336229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YXn53EsmWf/+7NHPAoFuqEH3vFShL3ZRTa7pelF9T9A=;
 b=GhfYagufcM4fBZOyzoCfMWCBTiOmZrkSoXtCBDo7iyk6RIhnBS48ZG7ZIyrgjqlDmK8MVC
 g3yDEn2YkqURjWaYmMp5c7IO/6RrEUs9OFO1oJsFVghJNlq9enGUzqXc9hQ7wG1CD7mPVT
 g0cpDrvmdU83BbJq2+MJggsZCHoy7PA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-638O3ZJ_NkaX3cZGVUAojQ-1; Thu, 13 Aug 2020 12:30:25 -0400
X-MC-Unique: 638O3ZJ_NkaX3cZGVUAojQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E619B1853DBC;
 Thu, 13 Aug 2020 16:30:23 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-97.ams2.redhat.com [10.36.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C574B5C1A3;
 Thu, 13 Aug 2020 16:30:22 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 19/22] block/export: Move strong user reference to
 block_exports
Date: Thu, 13 Aug 2020 18:29:32 +0200
Message-Id: <20200813162935.210070-20-kwolf@redhat.com>
In-Reply-To: <20200813162935.210070-1-kwolf@redhat.com>
References: <20200813162935.210070-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 03:44:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The reference owned by the user/monitor that is created when adding the
export and dropped when removing it was tied to the 'exports' list in
nbd/server.c. Every block export will have a user reference, so move it
to the block export level and tie it to the 'block_exports' list in
block/export/export.c instead. This is necessary for introducing a QMP
command for removing exports.

Note that exports are present in block_exports even after the user has
requested shutdown. This is different from NBD's exports where exports
are immediately removed on a shutdown request, even if they are still in
the process of shutting down. In order to avoid that the user still
interacts with an export that is shutting down (and possibly removes it
a second time), we need to remember if the user actually still owns it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/export.h | 8 ++++++++
 block/export/export.c  | 4 ++++
 blockdev-nbd.c         | 5 -----
 nbd/server.c           | 2 --
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/block/export.h b/include/block/export.h
index 43229857b0..83f554b745 100644
--- a/include/block/export.h
+++ b/include/block/export.h
@@ -40,6 +40,14 @@ struct BlockExport {
      */
     int refcount;
 
+    /*
+     * True if one of the references in refcount belongs to the user. After the
+     * user has dropped their reference, they may not e.g. remove the same
+     * export a second time (which would decrease the refcount without having
+     * it incremented first).
+     */
+    bool user_owned;
+
     /*
      * The AioContex whose lock needs to be held while calling
      * BlockExportDriver callbacks.
diff --git a/block/export/export.c b/block/export/export.c
index 72f1fab975..f94a81258a 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -78,6 +78,7 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
     *exp = (BlockExport) {
         .drv        = &blk_exp_nbd,
         .refcount   = 1,
+        .user_owned = true,
         .id         = g_strdup(export->id),
     };
 
@@ -117,6 +118,9 @@ void blk_exp_request_shutdown(BlockExport *exp)
     aio_context_acquire(aio_context);
     exp->drv->request_shutdown(exp);
     aio_context_release(aio_context);
+
+    exp->user_owned = false;
+    blk_exp_unref(exp);
 }
 
 static bool blk_exp_has_type(BlockExportType type)
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 1c7aa874ee..40013b7d64 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -231,11 +231,6 @@ int nbd_export_create(BlockExport *exp, BlockExportOptions *exp_args,
         goto out;
     }
 
-    /* The list of named exports has a strong reference to this export now and
-     * our only way of accessing it is through nbd_export_find(), so we can drop
-     * the strong reference that is @exp. */
-    blk_exp_unref((BlockExport*) exp);
-
     ret = 0;
  out:
     aio_context_release(aio_context);
diff --git a/nbd/server.c b/nbd/server.c
index 7e2976b81d..e3ac7f548b 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1616,7 +1616,6 @@ int nbd_export_new(BlockExport *blk_exp, BlockDriverState *bs,
 
     blk_add_aio_context_notifier(blk, blk_aio_attached, blk_aio_detach, exp);
 
-    blk_exp_ref(&exp->common);
     QTAILQ_INSERT_TAIL(&exports, exp, next);
 
     return 0;
@@ -1663,7 +1662,6 @@ static void nbd_export_request_shutdown(BlockExport *blk_exp)
         client_close(client, true);
     }
     if (exp->name) {
-        blk_exp_unref(&exp->common);
         g_free(exp->name);
         exp->name = NULL;
         QTAILQ_REMOVE(&exports, exp, next);
-- 
2.25.4


