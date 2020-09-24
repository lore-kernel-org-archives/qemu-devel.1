Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C9FC2D0E2
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D50B22311E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J97dWPkG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50B22311E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLTkp-0002YQ-OR
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 12:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLTAO-0001uv-DQ
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:28:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23688)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLTAL-0005ZQ-1H
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600961292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aZHSOyBKEHwiJS9MsaOADdNyCp6EdrfkFm7tC5uXzl0=;
 b=J97dWPkGP9exGH7aVbD6ZttrcnS9b1LCEiqmDrvpe2r4pwavuHM+iJBUDUwXeRKQlU/Y41
 kjbPIk8P52SkzuhSn8SA53n4SREhIpUfjKgXVWy5O6Ty/iB0ElUn5l5FTgI+djZlTBIlsp
 hKbvo6vTh7nbGqnCamdSdaNmR29IVGg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-ojNU__GVOcKzdBHOG8DRmw-1; Thu, 24 Sep 2020 11:28:09 -0400
X-MC-Unique: ojNU__GVOcKzdBHOG8DRmw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B13731021D29;
 Thu, 24 Sep 2020 15:28:08 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-72.ams2.redhat.com [10.36.114.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 70EFD60C04;
 Thu, 24 Sep 2020 15:28:07 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 22/31] block/export: Move blk to BlockExport
Date: Thu, 24 Sep 2020 17:27:08 +0200
Message-Id: <20200924152717.287415-23-kwolf@redhat.com>
In-Reply-To: <20200924152717.287415-1-kwolf@redhat.com>
References: <20200924152717.287415-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Every block export has a BlockBackend representing the disk that is
exported. It should live in BlockExport therefore.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/block/export.h |  3 +++
 block/export/export.c  |  3 +++
 nbd/server.c           | 43 +++++++++++++++++++++---------------------
 3 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/include/block/export.h b/include/block/export.h
index ff54d35872..7feb02e10d 100644
--- a/include/block/export.h
+++ b/include/block/export.h
@@ -71,6 +71,9 @@ struct BlockExport {
     /* The AioContext whose lock protects this BlockExport object. */
     AioContext *ctx;
 
+    /* The block device to export */
+    BlockBackend *blk;
+
     /* List entry for block_exports */
     QLIST_ENTRY(BlockExport) next;
 };
diff --git a/block/export/export.c b/block/export/export.c
index 87940d5c40..ad374a6649 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -92,6 +92,8 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
         return NULL;
     }
 
+    assert(exp->blk != NULL);
+
     QLIST_INSERT_HEAD(&block_exports, exp, next);
     return exp;
 }
@@ -114,6 +116,7 @@ static void blk_exp_delete_bh(void *opaque)
     assert(exp->refcount == 0);
     QLIST_REMOVE(exp, next);
     exp->drv->delete(exp);
+    blk_unref(exp->blk);
     qapi_event_send_block_export_deleted(exp->id);
     g_free(exp->id);
     g_free(exp);
diff --git a/nbd/server.c b/nbd/server.c
index 1a0e1db401..f9af45c480 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -84,7 +84,6 @@ struct NBDRequestData {
 struct NBDExport {
     BlockExport common;
 
-    BlockBackend *blk;
     char *name;
     char *description;
     uint64_t size;
@@ -643,7 +642,7 @@ static int nbd_negotiate_handle_info(NBDClient *client, Error **errp)
      * whether this is OPT_INFO or OPT_GO. */
     /* minimum - 1 for back-compat, or actual if client will obey it. */
     if (client->opt == NBD_OPT_INFO || blocksize) {
-        check_align = sizes[0] = blk_get_request_alignment(exp->blk);
+        check_align = sizes[0] = blk_get_request_alignment(exp->common.blk);
     } else {
         sizes[0] = 1;
     }
@@ -652,7 +651,7 @@ static int nbd_negotiate_handle_info(NBDClient *client, Error **errp)
      * TODO: is blk_bs(blk)->bl.opt_transfer appropriate? */
     sizes[1] = MAX(4096, sizes[0]);
     /* maximum - At most 32M, but smaller as appropriate. */
-    sizes[2] = MIN(blk_get_max_transfer(exp->blk), NBD_MAX_BUFFER_SIZE);
+    sizes[2] = MIN(blk_get_max_transfer(exp->common.blk), NBD_MAX_BUFFER_SIZE);
     trace_nbd_negotiate_handle_info_block_size(sizes[0], sizes[1], sizes[2]);
     sizes[0] = cpu_to_be32(sizes[0]);
     sizes[1] = cpu_to_be32(sizes[1]);
@@ -684,7 +683,7 @@ static int nbd_negotiate_handle_info(NBDClient *client, Error **errp)
      * tolerate all clients, regardless of alignments.
      */
     if (client->opt == NBD_OPT_INFO && !blocksize &&
-        blk_get_request_alignment(exp->blk) > 1) {
+        blk_get_request_alignment(exp->common.blk) > 1) {
         return nbd_negotiate_send_rep_err(client,
                                           NBD_REP_ERR_BLOCK_SIZE_REQD,
                                           errp,
@@ -1557,7 +1556,7 @@ int nbd_export_new(BlockExport *blk_exp, BlockDriverState *bs,
     blk_set_allow_aio_context_change(blk, true);
 
     QTAILQ_INIT(&exp->clients);
-    exp->blk = blk;
+    exp->common.blk = blk;
     exp->name = g_strdup(name);
     assert(!desc || strlen(desc) <= NBD_MAX_STRING_SIZE);
     exp->description = g_strdup(desc);
@@ -1679,15 +1678,13 @@ static void nbd_export_delete(BlockExport *blk_exp)
     g_free(exp->description);
     exp->description = NULL;
 
-    if (exp->blk) {
+    if (exp->common.blk) {
         if (exp->eject_notifier_blk) {
             notifier_remove(&exp->eject_notifier);
             blk_unref(exp->eject_notifier_blk);
         }
-        blk_remove_aio_context_notifier(exp->blk, blk_aio_attached,
+        blk_remove_aio_context_notifier(exp->common.blk, blk_aio_attached,
                                         blk_aio_detach, exp);
-        blk_unref(exp->blk);
-        exp->blk = NULL;
     }
 
     if (exp->export_bitmap) {
@@ -1840,7 +1837,7 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
 
     while (progress < size) {
         int64_t pnum;
-        int status = bdrv_block_status_above(blk_bs(exp->blk), NULL,
+        int status = bdrv_block_status_above(blk_bs(exp->common.blk), NULL,
                                              offset + progress,
                                              size - progress, &pnum, NULL,
                                              NULL);
@@ -1872,7 +1869,8 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
             stl_be_p(&chunk.length, pnum);
             ret = nbd_co_send_iov(client, iov, 1, errp);
         } else {
-            ret = blk_pread(exp->blk, offset + progress, data + progress, pnum);
+            ret = blk_pread(exp->common.blk, offset + progress,
+                            data + progress, pnum);
             if (ret < 0) {
                 error_setg_errno(errp, -ret, "reading from file failed");
                 break;
@@ -2136,7 +2134,8 @@ static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request,
         }
 
         if (request->type != NBD_CMD_CACHE) {
-            req->data = blk_try_blockalign(client->exp->blk, request->len);
+            req->data = blk_try_blockalign(client->exp->common.blk,
+                                           request->len);
             if (req->data == NULL) {
                 error_setg(errp, "No memory");
                 return -ENOMEM;
@@ -2232,7 +2231,7 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *client, NBDRequest *request,
 
     /* XXX: NBD Protocol only documents use of FUA with WRITE */
     if (request->flags & NBD_CMD_FLAG_FUA) {
-        ret = blk_co_flush(exp->blk);
+        ret = blk_co_flush(exp->common.blk);
         if (ret < 0) {
             return nbd_send_generic_reply(client, request->handle, ret,
                                           "flush failed", errp);
@@ -2246,7 +2245,7 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *client, NBDRequest *request,
                                        data, request->len, errp);
     }
 
-    ret = blk_pread(exp->blk, request->from, data, request->len);
+    ret = blk_pread(exp->common.blk, request->from, data, request->len);
     if (ret < 0) {
         return nbd_send_generic_reply(client, request->handle, ret,
                                       "reading from file failed", errp);
@@ -2281,7 +2280,7 @@ static coroutine_fn int nbd_do_cmd_cache(NBDClient *client, NBDRequest *request,
 
     assert(request->type == NBD_CMD_CACHE);
 
-    ret = blk_co_preadv(exp->blk, request->from, request->len,
+    ret = blk_co_preadv(exp->common.blk, request->from, request->len,
                         NULL, BDRV_REQ_COPY_ON_READ | BDRV_REQ_PREFETCH);
 
     return nbd_send_generic_reply(client, request->handle, ret,
@@ -2312,7 +2311,8 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
         if (request->flags & NBD_CMD_FLAG_FUA) {
             flags |= BDRV_REQ_FUA;
         }
-        ret = blk_pwrite(exp->blk, request->from, data, request->len, flags);
+        ret = blk_pwrite(exp->common.blk, request->from, data, request->len,
+                         flags);
         return nbd_send_generic_reply(client, request->handle, ret,
                                       "writing to file failed", errp);
 
@@ -2333,7 +2333,7 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
             int align = client->check_align ?: 1;
             int len = MIN(request->len, QEMU_ALIGN_DOWN(BDRV_REQUEST_MAX_BYTES,
                                                         align));
-            ret = blk_pwrite_zeroes(exp->blk, request->from, len, flags);
+            ret = blk_pwrite_zeroes(exp->common.blk, request->from, len, flags);
             request->len -= len;
             request->from += len;
         }
@@ -2345,7 +2345,7 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
         abort();
 
     case NBD_CMD_FLUSH:
-        ret = blk_co_flush(exp->blk);
+        ret = blk_co_flush(exp->common.blk);
         return nbd_send_generic_reply(client, request->handle, ret,
                                       "flush failed", errp);
 
@@ -2356,12 +2356,12 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
             int align = client->check_align ?: 1;
             int len = MIN(request->len, QEMU_ALIGN_DOWN(BDRV_REQUEST_MAX_BYTES,
                                                         align));
-            ret = blk_co_pdiscard(exp->blk, request->from, len);
+            ret = blk_co_pdiscard(exp->common.blk, request->from, len);
             request->len -= len;
             request->from += len;
         }
         if (ret >= 0 && request->flags & NBD_CMD_FLAG_FUA) {
-            ret = blk_co_flush(exp->blk);
+            ret = blk_co_flush(exp->common.blk);
         }
         return nbd_send_generic_reply(client, request->handle, ret,
                                       "discard failed", errp);
@@ -2379,7 +2379,8 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
 
             if (client->export_meta.base_allocation) {
                 ret = nbd_co_send_block_status(client, request->handle,
-                                               blk_bs(exp->blk), request->from,
+                                               blk_bs(exp->common.blk),
+                                               request->from,
                                                request->len, dont_fragment,
                                                !client->export_meta.bitmap,
                                                NBD_META_ID_BASE_ALLOCATION,
-- 
2.25.4


