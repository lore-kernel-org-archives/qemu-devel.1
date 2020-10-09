Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D426C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 02:16:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F5DA22255
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 02:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YyDFGE8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5DA22255
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQhxE-00058A-07
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 22:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kQhor-00068Y-3P
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 22:07:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34539)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kQhog-0006sU-4M
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 22:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602209248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c1fuJa5ieggS4PhAR64buGO6f6hS+qiZSVSigdWVwXs=;
 b=YyDFGE8S1UT6BlC8bFX56XybNCokNZu4jJE3MWF7culVRHBuEhTgsrxDwqx3/HbcUQsL+8
 ErbEs6zo2XUCHg0lSJsk/u+EorMMzugdxHCbmlystXmUM/wSIZZzL8SJG1EwYmGIpizhsU
 bkjJFQG7jaSwPL+qCGt+s/QyTDYtk1w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-4fvjKXScNESPioRLWtuYRQ-1; Thu, 08 Oct 2020 22:07:24 -0400
X-MC-Unique: 4fvjKXScNESPioRLWtuYRQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6148387951D;
 Fri,  9 Oct 2020 02:07:23 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-14.phx2.redhat.com [10.3.113.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D674076650;
 Fri,  9 Oct 2020 02:07:22 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/6] nbd: Simplify qemu bitmap context name
Date: Thu,  8 Oct 2020 21:07:12 -0500
Message-Id: <20201009020714.1074061-5-eblake@redhat.com>
In-Reply-To: <20201009020714.1074061-1-eblake@redhat.com>
References: <20201009020714.1074061-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com,
 rjones@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Each dirty bitmap already knows its name; by reducing the scope of the
places where we construct "qemu:dirty-bitmap:NAME" strings, tracking
the name is more localized, and there are fewer per-export fields to
worry about.  This in turn will make it easier for an upcoming patch
to export more than one bitmap at once.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index ea5de0b503cd..6326d6fe3f3a 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -97,7 +97,6 @@ struct NBDExport {

     bool alloc_context;
     BdrvDirtyBitmap *export_bitmap;
-    char *export_bitmap_context;
 };

 static QTAILQ_HEAD(, NBDExport) exports = QTAILQ_HEAD_INITIALIZER(exports);
@@ -882,14 +881,15 @@ static bool nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,
     }

     if (nbd_strshift(&query, "dirty-bitmap:")) {
+        const char *bm_name;
+
         trace_nbd_negotiate_meta_query_parse("dirty-bitmap:");
         if (!meta->exp->export_bitmap) {
             trace_nbd_negotiate_meta_query_skip("no dirty-bitmap exported");
             return true;
         }
-        if (nbd_meta_empty_or_pattern(client,
-                                      meta->exp->export_bitmap_context +
-                                      strlen("qemu:dirty-bitmap:"), query)) {
+        bm_name = bdrv_dirty_bitmap_name(meta->exp->export_bitmap);
+        if (nbd_meta_empty_or_pattern(client, bm_name, query)) {
             meta->bitmap = true;
         }
         return true;
@@ -1025,8 +1025,11 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
     }

     if (meta->bitmap) {
-        ret = nbd_negotiate_send_meta_context(client,
-                                              meta->exp->export_bitmap_context,
+        const char *bm_name = bdrv_dirty_bitmap_name(meta->exp->export_bitmap);
+        g_autofree char *context = g_strdup_printf("qemu:dirty-bitmap:%s",
+                                                   bm_name);
+
+        ret = nbd_negotiate_send_meta_context(client, context,
                                               NBD_META_ID_DIRTY_BITMAP,
                                               errp);
         if (ret < 0) {
@@ -1599,9 +1602,6 @@ static int nbd_export_create(BlockExport *blk_exp, BlockExportOptions *exp_args,
         bdrv_dirty_bitmap_set_busy(bm, true);
         exp->export_bitmap = bm;
         assert(strlen(bitmap) <= BDRV_BITMAP_MAX_NAME_SIZE);
-        exp->export_bitmap_context = g_strdup_printf("qemu:dirty-bitmap:%s",
-                                                     bitmap);
-        assert(strlen(exp->export_bitmap_context) < NBD_MAX_STRING_SIZE);
     }

     exp->alloc_context = arg->alloc;
@@ -1681,7 +1681,6 @@ static void nbd_export_delete(BlockExport *blk_exp)

     if (exp->export_bitmap) {
         bdrv_dirty_bitmap_set_busy(exp->export_bitmap, false);
-        g_free(exp->export_bitmap_context);
     }
 }

-- 
2.28.0


