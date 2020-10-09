Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71606C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 22:02:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0454C22258
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 22:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uh5zrxG4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0454C22258
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kR0TY-0000x0-2l
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 18:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kR0Mi-0002sL-Q4
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 17:55:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kR0Me-0003Rq-E1
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 17:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602280547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XF9Iqxp9drBDNo+yyFLQiBdKbClIc4C0VnXimXDYiNs=;
 b=Uh5zrxG4NeUk9vTPpwoWKm6jwqjHB7S2tCMLE5gjwcWQmdN8bHtg0HdI9D1GB8c+ortT3i
 BJZma6QePpGLjTd44yoTE35T9d64JgnB6+mBAgk0UsAcAqIbNQF+nFJhnUf68+xH5fC+EX
 Cj5UgUY1FK8T6lnMoVfdUTgGDJdV/K0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-wh_9vAAPMY61YOk9t3zaag-1; Fri, 09 Oct 2020 17:55:45 -0400
X-MC-Unique: wh_9vAAPMY61YOk9t3zaag-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67D0E8463DD;
 Fri,  9 Oct 2020 21:55:44 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-14.phx2.redhat.com [10.3.113.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC8B510013C4;
 Fri,  9 Oct 2020 21:55:43 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 7/7] nbd: Allow export of multiple bitmaps for one device
Date: Fri,  9 Oct 2020 16:55:33 -0500
Message-Id: <20201009215533.1194742-8-eblake@redhat.com>
In-Reply-To: <20201009215533.1194742-1-eblake@redhat.com>
References: <20201009215533.1194742-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 rjones@redhat.com, Max Reitz <mreitz@redhat.com>, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With this, 'qemu-nbd -B b0 -B b1 -f qcow2 img.qcow2' can let you sniff
out multiple bitmaps from one server.  qemu-img as client can still
only read one bitmap per client connection, but other NBD clients
(hello libnbd) can now read multiple bitmaps in a single pass.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c           | 89 +++++++++++++++++++++++++++++-------------
 tests/qemu-iotests/291 |  6 +--
 2 files changed, 63 insertions(+), 32 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 27d943529409..8a9455627d25 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -96,7 +96,8 @@ struct NBDExport {
     Notifier eject_notifier;

     bool allocation_depth;
-    BdrvDirtyBitmap *export_bitmap;
+    BdrvDirtyBitmap **export_bitmaps;
+    size_t nr_export_bitmaps;
 };

 static QTAILQ_HEAD(, NBDExport) exports = QTAILQ_HEAD_INITIALIZER(exports);
@@ -109,7 +110,10 @@ typedef struct NBDExportMetaContexts {
     size_t count; /* number of negotiated contexts */
     bool base_allocation; /* export base:allocation context (block status) */
     bool allocation_depth; /* export qemu:allocation-depth */
-    bool bitmap; /* export qemu:dirty-bitmap:<export bitmap name> */
+    bool *bitmaps; /*
+                    * export qemu:dirty-bitmap:<export bitmap name>,
+                    * sized by exp->nr_export_bitmaps
+                    */
 } NBDExportMetaContexts;

 struct NBDClient {
@@ -861,6 +865,8 @@ static bool nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
 static bool nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,
                                 const char *query)
 {
+    size_t i;
+
     if (!nbd_strshift(&query, "qemu:")) {
         return false;
     }
@@ -869,7 +875,7 @@ static bool nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,
     if (!*query) {
         if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
             meta->allocation_depth = meta->exp->allocation_depth;
-            meta->bitmap = !!meta->exp->export_bitmap;
+            memset(meta->bitmaps, 1, meta->exp->nr_export_bitmaps);
         }
         trace_nbd_negotiate_meta_query_parse("empty");
         return true;
@@ -882,17 +888,26 @@ static bool nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,
     }

     if (nbd_strshift(&query, "dirty-bitmap:")) {
-        const char *bm_name;
-
         trace_nbd_negotiate_meta_query_parse("dirty-bitmap:");
-        if (!meta->exp->export_bitmap) {
-            trace_nbd_negotiate_meta_query_skip("no dirty-bitmap exported");
+        if (!*query) {
+            if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
+                memset(meta->bitmaps, 1, meta->exp->nr_export_bitmaps);
+            }
+            trace_nbd_negotiate_meta_query_parse("empty");
             return true;
         }
-        bm_name = bdrv_dirty_bitmap_name(meta->exp->export_bitmap);
-        if (nbd_meta_empty_or_pattern(client, bm_name, query)) {
-            meta->bitmap = true;
+
+        for (i = 0; i < meta->exp->nr_export_bitmaps; i++) {
+            const char *bm_name;
+
+            bm_name = bdrv_dirty_bitmap_name(meta->exp->export_bitmaps[i]);
+            if (strcmp(bm_name, query) == 0) {
+                meta->bitmaps[i] = true;
+                trace_nbd_negotiate_meta_query_parse(query);
+                return true;
+            }
         }
+        trace_nbd_negotiate_meta_query_skip("no dirty-bitmap match");
         return true;
     }

@@ -954,9 +969,10 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
 {
     int ret;
     g_autofree char *export_name = NULL;
-    NBDExportMetaContexts local_meta;
+    g_autofree bool *bitmaps = NULL;
+    NBDExportMetaContexts local_meta = {0};
     uint32_t nb_queries;
-    int i;
+    size_t i;
     size_t count = 0;

     if (!client->structured_reply) {
@@ -971,6 +987,7 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
         meta = &local_meta;
     }

+    g_free(meta->bitmaps);
     memset(meta, 0, sizeof(*meta));

     ret = nbd_opt_read_name(client, &export_name, NULL, errp);
@@ -985,6 +1002,10 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
         return nbd_opt_drop(client, NBD_REP_ERR_UNKNOWN, errp,
                             "export '%s' not present", sane_name);
     }
+    meta->bitmaps = g_new0(bool, meta->exp->nr_export_bitmaps);
+    if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
+        bitmaps = meta->bitmaps;
+    }

     ret = nbd_opt_read(client, &nb_queries, sizeof(nb_queries), false, errp);
     if (ret <= 0) {
@@ -998,7 +1019,7 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
         /* enable all known contexts */
         meta->base_allocation = true;
         meta->allocation_depth = meta->exp->allocation_depth;
-        meta->bitmap = !!meta->exp->export_bitmap;
+        memset(meta->bitmaps, 1, meta->exp->nr_export_bitmaps);
     } else {
         for (i = 0; i < nb_queries; ++i) {
             ret = nbd_negotiate_meta_query(client, meta, errp);
@@ -1028,13 +1049,19 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
         count++;
     }

-    if (meta->bitmap) {
-        const char *bm_name = bdrv_dirty_bitmap_name(meta->exp->export_bitmap);
-        g_autofree char *context = g_strdup_printf("qemu:dirty-bitmap:%s",
-                                                   bm_name);
+    for (i = 0; i < meta->exp->nr_export_bitmaps; i++) {
+        const char *bm_name;
+        g_autofree char *context = NULL;
+
+        if (!meta->bitmaps[i]) {
+            continue;
+        }
+
+        bm_name = bdrv_dirty_bitmap_name(meta->exp->export_bitmaps[i]);
+        context = g_strdup_printf("qemu:dirty-bitmap:%s", bm_name);

         ret = nbd_negotiate_send_meta_context(client, context,
-                                              NBD_META_ID_DIRTY_BITMAP,
+                                              NBD_META_ID_DIRTY_BITMAP + i,
                                               errp);
         if (ret < 0) {
             return ret;
@@ -1388,6 +1415,7 @@ void nbd_client_put(NBDClient *client)
             QTAILQ_REMOVE(&client->exp->clients, client, next);
             blk_exp_unref(&client->exp->common);
         }
+        g_free(client->export_meta.bitmaps);
         g_free(client);
     }
 }
@@ -1565,11 +1593,11 @@ static int nbd_export_create(BlockExport *blk_exp, BlockExportOptions *exp_args,
     }
     exp->size = QEMU_ALIGN_DOWN(size, BDRV_SECTOR_SIZE);

-    /* XXX Allow more than one bitmap */
-    if (arg->bitmaps && arg->bitmaps->next) {
-        error_setg(errp, "multiple bitmaps per export not supported yet");
-        return -EOPNOTSUPP;
+    for (bitmaps = arg->bitmaps; bitmaps; bitmaps = bitmaps->next) {
+        exp->nr_export_bitmaps++;
     }
+    exp->export_bitmaps = g_new0(BdrvDirtyBitmap *, exp->nr_export_bitmaps);
+    exp->nr_export_bitmaps = 0;
     for (bitmaps = arg->bitmaps; bitmaps; bitmaps = bitmaps->next) {
         const char *bitmap = bitmaps->value;
         BlockDriverState *bs = blk_bs(blk);
@@ -1605,7 +1633,7 @@ static int nbd_export_create(BlockExport *blk_exp, BlockExportOptions *exp_args,
         }

         bdrv_dirty_bitmap_set_busy(bm, true);
-        exp->export_bitmap = bm;
+        exp->export_bitmaps[exp->nr_export_bitmaps++] = bm;
         assert(strlen(bitmap) <= BDRV_BITMAP_MAX_NAME_SIZE);
     }

@@ -1667,6 +1695,7 @@ static void nbd_export_request_shutdown(BlockExport *blk_exp)

 static void nbd_export_delete(BlockExport *blk_exp)
 {
+    size_t i;
     NBDExport *exp = container_of(blk_exp, NBDExport, common);

     assert(exp->name == NULL);
@@ -1684,8 +1713,8 @@ static void nbd_export_delete(BlockExport *blk_exp)
                                         blk_aio_detach, exp);
     }

-    if (exp->export_bitmap) {
-        bdrv_dirty_bitmap_set_busy(exp->export_bitmap, false);
+    for (i = 0; i < exp->nr_export_bitmaps; i++) {
+        bdrv_dirty_bitmap_set_busy(exp->export_bitmaps[i], false);
     }
 }

@@ -2332,6 +2361,7 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
     int flags;
     NBDExport *exp = client->exp;
     char *msg;
+    size_t i;

     switch (request->type) {
     case NBD_CMD_CACHE:
@@ -2435,12 +2465,15 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
                 }
             }

-            if (client->export_meta.bitmap) {
+            for (i = 0; i < client->exp->nr_export_bitmaps; i++) {
+                if (!client->export_meta.bitmaps[i]) {
+                    continue;
+                }
                 ret = nbd_co_send_bitmap(client, request->handle,
-                                         client->exp->export_bitmap,
+                                         client->exp->export_bitmaps[i],
                                          request->from, request->len,
                                          dont_fragment, !--contexts_remaining,
-                                         NBD_META_ID_DIRTY_BITMAP, errp);
+                                         NBD_META_ID_DIRTY_BITMAP + i, errp);
                 if (ret < 0) {
                     return ret;
                 }
diff --git a/tests/qemu-iotests/291 b/tests/qemu-iotests/291
index 4f837b205655..37848ac60bba 100755
--- a/tests/qemu-iotests/291
+++ b/tests/qemu-iotests/291
@@ -107,16 +107,14 @@ echo
 # x-dirty-bitmap is a hack for reading bitmaps; it abuses block status to
 # report "data":false for portions of the bitmap which are set
 IMG="driver=nbd,server.type=unix,server.path=$nbd_unix_socket"
-nbd_server_start_unix_socket -r -f qcow2 -B b0 "$TEST_IMG"
+nbd_server_start_unix_socket -r -f qcow2 \
+    -B b0 -B b1 -B b2 -B b3 "$TEST_IMG"
 $QEMU_IMG map --output=json --image-opts \
     "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:b0" | _filter_qemu_img_map
-nbd_server_start_unix_socket -r -f qcow2 -B b1 "$TEST_IMG"
 $QEMU_IMG map --output=json --image-opts \
     "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:b1" | _filter_qemu_img_map
-nbd_server_start_unix_socket -r -f qcow2 -B b2 "$TEST_IMG"
 $QEMU_IMG map --output=json --image-opts \
     "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:b2" | _filter_qemu_img_map
-nbd_server_start_unix_socket -r -f qcow2 -B b3 "$TEST_IMG"
 $QEMU_IMG map --output=json --image-opts \
     "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:b3" | _filter_qemu_img_map

-- 
2.28.0


