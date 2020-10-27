Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBB5C55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 05:11:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E1062080A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 05:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T5dcFXeK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E1062080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXHGh-0000ib-FF
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 01:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kXHBi-0003n9-QH
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:06:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51314)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kXHBZ-0003d2-5C
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603775175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/RegGtDczshYmkbCCsHc+yotURCo6VJW03YdInOIJ3k=;
 b=T5dcFXeKfHyl6VU1WfMY0UU/oUg3DdHA6BYKYg2j5Ny8fS6imygaqaM2n0Xo3mG6arJjMS
 WT4Ket2Jpc+oxqJD04WXxOgioXmKhu9+tdRxHSgM34k9uoLP7KtPsufQBv4GMrpj8/8+63
 q70Mgkg3zSkBLtfPKU7HEU85hFCbwiU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-9urZGgFXPba77dSDNmr7Iw-1; Tue, 27 Oct 2020 01:06:12 -0400
X-MC-Unique: 9urZGgFXPba77dSDNmr7Iw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83303100746A;
 Tue, 27 Oct 2020 05:06:11 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-145.phx2.redhat.com [10.3.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C85B610013C4;
 Tue, 27 Oct 2020 05:06:10 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 07/11] nbd: Allow export of multiple bitmaps for one device
Date: Tue, 27 Oct 2020 00:05:52 -0500
Message-Id: <20201027050556.269064-8-eblake@redhat.com>
In-Reply-To: <20201027050556.269064-1-eblake@redhat.com>
References: <20201027050556.269064-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 armbru@redhat.com, rjones@redhat.com, vsementsov@virtuozzo.com,
 stefanha@redhat.com, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With this, 'qemu-nbd -B b0 -B b1 -f qcow2 img.qcow2' can let you sniff
out multiple bitmaps from one server.  qemu-img as client can still
only read one bitmap per client connection, but other NBD clients
(hello libnbd) can now read multiple bitmaps in a single pass.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c           | 100 ++++++++++++++++++++++++++++-------------
 tests/qemu-iotests/291 |   6 +--
 2 files changed, 72 insertions(+), 34 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 42d494bc9616..b6841e455414 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -27,6 +27,7 @@
 #include "qemu/units.h"

 #define NBD_META_ID_BASE_ALLOCATION 0
+/* Dirty bitmaps use 'NBD_META_ID_DIRTY_BITMAP + i', so keep this id last. */
 #define NBD_META_ID_DIRTY_BITMAP 1

 /*
@@ -94,7 +95,8 @@ struct NBDExport {
     BlockBackend *eject_notifier_blk;
     Notifier eject_notifier;

-    BdrvDirtyBitmap *export_bitmap;
+    BdrvDirtyBitmap **export_bitmaps;
+    size_t nr_export_bitmaps;
 };

 static QTAILQ_HEAD(, NBDExport) exports = QTAILQ_HEAD_INITIALIZER(exports);
@@ -106,7 +108,10 @@ typedef struct NBDExportMetaContexts {
     NBDExport *exp;
     size_t count; /* number of negotiated contexts */
     bool base_allocation; /* export base:allocation context (block status) */
-    bool bitmap; /* export qemu:dirty-bitmap:<export bitmap name> */
+    bool *bitmaps; /*
+                    * export qemu:dirty-bitmap:<export bitmap name>,
+                    * sized by exp->nr_export_bitmaps
+                    */
 } NBDExportMetaContexts;

 struct NBDClient {
@@ -857,6 +862,8 @@ static bool nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
 static bool nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,
                                 const char *query)
 {
+    size_t i;
+
     if (!nbd_strshift(&query, "qemu:")) {
         return false;
     }
@@ -864,24 +871,33 @@ static bool nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,

     if (!*query) {
         if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
-            meta->bitmap = !!meta->exp->export_bitmap;
+            memset(meta->bitmaps, 1, meta->exp->nr_export_bitmaps);
         }
         trace_nbd_negotiate_meta_query_parse("empty");
         return true;
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

@@ -943,9 +959,10 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
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
@@ -960,6 +977,7 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
         meta = &local_meta;
     }

+    g_free(meta->bitmaps);
     memset(meta, 0, sizeof(*meta));

     ret = nbd_opt_read_name(client, &export_name, NULL, errp);
@@ -974,6 +992,10 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
         return nbd_opt_drop(client, NBD_REP_ERR_UNKNOWN, errp,
                             "export '%s' not present", sane_name);
     }
+    meta->bitmaps = g_new0(bool, meta->exp->nr_export_bitmaps);
+    if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
+        bitmaps = meta->bitmaps;
+    }

     ret = nbd_opt_read(client, &nb_queries, sizeof(nb_queries), false, errp);
     if (ret <= 0) {
@@ -986,7 +1008,7 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
     if (client->opt == NBD_OPT_LIST_META_CONTEXT && !nb_queries) {
         /* enable all known contexts */
         meta->base_allocation = true;
-        meta->bitmap = !!meta->exp->export_bitmap;
+        memset(meta->bitmaps, 1, meta->exp->nr_export_bitmaps);
     } else {
         for (i = 0; i < nb_queries; ++i) {
             ret = nbd_negotiate_meta_query(client, meta, errp);
@@ -1006,13 +1028,19 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
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
@@ -1366,6 +1394,7 @@ void nbd_client_put(NBDClient *client)
             QTAILQ_REMOVE(&client->exp->clients, client, next);
             blk_exp_unref(&client->exp->common);
         }
+        g_free(client->export_meta.bitmaps);
         g_free(client);
     }
 }
@@ -1482,6 +1511,7 @@ static int nbd_export_create(BlockExport *blk_exp, BlockExportOptions *exp_args,
     bool readonly = !exp_args->writable;
     bool shared = !exp_args->writable;
     strList *bitmaps;
+    size_t i;
     int ret;

     assert(exp_args->type == BLOCK_EXPORT_TYPE_NBD);
@@ -1541,12 +1571,12 @@ static int nbd_export_create(BlockExport *blk_exp, BlockExportOptions *exp_args,
     }
     exp->size = QEMU_ALIGN_DOWN(size, BDRV_SECTOR_SIZE);

-    /* XXX Allow more than one bitmap */
-    if (arg->bitmaps && arg->bitmaps->next) {
-        error_setg(errp, "multiple bitmaps per export not supported yet");
-        return -EOPNOTSUPP;
-    }
     for (bitmaps = arg->bitmaps; bitmaps; bitmaps = bitmaps->next) {
+        exp->nr_export_bitmaps++;
+    }
+    exp->export_bitmaps = g_new0(BdrvDirtyBitmap *, exp->nr_export_bitmaps);
+    for (i = 0, bitmaps = arg->bitmaps; bitmaps;
+         i++, bitmaps = bitmaps->next) {
         const char *bitmap = bitmaps->value;
         BlockDriverState *bs = blk_bs(blk);
         BdrvDirtyBitmap *bm = NULL;
@@ -1580,11 +1610,15 @@ static int nbd_export_create(BlockExport *blk_exp, BlockExportOptions *exp_args,
             goto fail;
         }

-        bdrv_dirty_bitmap_set_busy(bm, true);
-        exp->export_bitmap = bm;
+        exp->export_bitmaps[i] = bm;
         assert(strlen(bitmap) <= BDRV_BITMAP_MAX_NAME_SIZE);
     }

+    /* Mark bitmaps busy in a separate loop, to simplify roll-back concerns. */
+    for (i = 0; i < exp->nr_export_bitmaps; i++) {
+        bdrv_dirty_bitmap_set_busy(exp->export_bitmaps[i], true);
+    }
+
     blk_add_aio_context_notifier(blk, blk_aio_attached, blk_aio_detach, exp);

     QTAILQ_INSERT_TAIL(&exports, exp, next);
@@ -1592,6 +1626,7 @@ static int nbd_export_create(BlockExport *blk_exp, BlockExportOptions *exp_args,
     return 0;

 fail:
+    g_free(exp->export_bitmaps);
     g_free(exp->name);
     g_free(exp->description);
     return ret;
@@ -1641,6 +1676,7 @@ static void nbd_export_request_shutdown(BlockExport *blk_exp)

 static void nbd_export_delete(BlockExport *blk_exp)
 {
+    size_t i;
     NBDExport *exp = container_of(blk_exp, NBDExport, common);

     assert(exp->name == NULL);
@@ -1658,8 +1694,8 @@ static void nbd_export_delete(BlockExport *blk_exp)
                                         blk_aio_detach, exp);
     }

-    if (exp->export_bitmap) {
-        bdrv_dirty_bitmap_set_busy(exp->export_bitmap, false);
+    for (i = 0; i < exp->nr_export_bitmaps; i++) {
+        bdrv_dirty_bitmap_set_busy(exp->export_bitmaps[i], false);
     }
 }

@@ -2268,6 +2304,7 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
     int flags;
     NBDExport *exp = client->exp;
     char *msg;
+    size_t i;

     switch (request->type) {
     case NBD_CMD_CACHE:
@@ -2358,12 +2395,15 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
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
2.29.0


