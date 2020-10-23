Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D08DC55179
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 18:44:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D197D2192A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 18:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGuvoRDK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D197D2192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW22r-0001XJ-Qq
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 14:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kW1wQ-0001Eg-1q
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 14:37:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38511)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kW1wO-0001ZO-AB
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 14:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603478247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PQKOiFY7z1Up2STIxZ1ZKXUu3eIWO5txVWaDYhaKISs=;
 b=GGuvoRDKp9TgmtY9cRfdXlLxJ0dhORozc7tWE2EBAmIuE8+UBooxHKoy/XX6QckMAoLJDO
 ybaFYWcJ9jSiDA4OneioD+RAnMCRIhaWfArvPZxaQVyXfxwX6nhB6c9C2daAuN6dNSQeQI
 njwHQtKyHdP1lFF77hfseAeEeRuYxcY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-jqraJq8JNlqMqJUMchZnaw-1; Fri, 23 Oct 2020 14:37:23 -0400
X-MC-Unique: jqraJq8JNlqMqJUMchZnaw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 793DF804B7D;
 Fri, 23 Oct 2020 18:37:22 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-7.phx2.redhat.com [10.3.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A85160BFA;
 Fri, 23 Oct 2020 18:37:15 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 07/12] nbd: Simplify qemu bitmap context name
Date: Fri, 23 Oct 2020 13:36:47 -0500
Message-Id: <20201023183652.478921-8-eblake@redhat.com>
In-Reply-To: <20201023183652.478921-1-eblake@redhat.com>
References: <20201023183652.478921-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, stefanha@redhat.com,
 qemu-block@nongnu.org, rjones@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Each dirty bitmap already knows its name; by reducing the scope of the
places where we construct "qemu:dirty-bitmap:NAME" strings, tracking
the name is more localized, and there are fewer per-export fields to
worry about.  This in turn will make it easier for an upcoming patch
to export more than one bitmap at once.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 884ffa00f1bd..05a8154975a1 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -97,7 +97,6 @@ struct NBDExport {

     bool allocation_depth;
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

     exp->allocation_depth = arg->allocation_depth;
@@ -1681,7 +1681,6 @@ static void nbd_export_delete(BlockExport *blk_exp)

     if (exp->export_bitmap) {
         bdrv_dirty_bitmap_set_busy(exp->export_bitmap, false);
-        g_free(exp->export_bitmap_context);
     }
 }

-- 
2.29.0


