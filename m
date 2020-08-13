Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E013C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:36:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BC2E206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1JaKW9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC2E206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6GDE-0005ja-Dd
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 12:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G78-0001tI-Dc
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:30:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36574
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G74-0001De-Ux
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597336198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kqdBbaOtebg9k+ULyF6nrjBnTlCFNvvQpw6nVjvsUcM=;
 b=e1JaKW9eQqaFZibiuatyPZ90T+U5vwYxOJuqTsCo3ftynIbpam4TXzBZ4vbpvOtTbd8tUe
 knhAKOljONYIFrxKYQOFR51P7vGQaKeHWuWOrVJaPsD1iYmR2eQ8E3Yj/JInHVezWSJZaM
 owlT6oztUiIh0d9CPNxG5zVdTH1kaK8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-zoftNvpHPxikNw78TAVbXg-1; Thu, 13 Aug 2020 12:29:56 -0400
X-MC-Unique: zoftNvpHPxikNw78TAVbXg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D4D91DDE0;
 Thu, 13 Aug 2020 16:29:55 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-97.ams2.redhat.com [10.36.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 38E7B5C1A3;
 Thu, 13 Aug 2020 16:29:54 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 06/22] qemu-nbd: Use raw block driver for --offset
Date: Thu, 13 Aug 2020 18:29:19 +0200
Message-Id: <20200813162935.210070-7-kwolf@redhat.com>
In-Reply-To: <20200813162935.210070-1-kwolf@redhat.com>
References: <20200813162935.210070-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 02:03:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Instead of implementing qemu-nbd --offset in the NBD code, just put a
raw block node with the requested offset on top of the user image and
rely on that doing the job.

This does not only simplify the nbd_export_new() interface and bring it
closer to the set of options that the nbd-server-add QMP command offers,
but in fact it also eliminates a potential source for bugs in the NBD
code which previously had to add the offset manually in all relevant
places.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/nbd.h |  4 ++--
 blockdev-nbd.c      |  9 +--------
 nbd/server.c        | 34 +++++++++++++++++-----------------
 qemu-nbd.c          | 27 ++++++++++++---------------
 4 files changed, 32 insertions(+), 42 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index c8c5cb6b61..3846d2bac8 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -329,8 +329,8 @@ typedef struct NBDExport NBDExport;
 typedef struct NBDClient NBDClient;
 
 BlockExport *nbd_export_create(BlockExportOptions *exp_args, Error **errp);
-NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
-                          uint64_t size, const char *name, const char *desc,
+NBDExport *nbd_export_new(BlockDriverState *bs,
+                          const char *name, const char *desc,
                           const char *bitmap, bool readonly, bool shared,
                           void (*close)(NBDExport *), bool writethrough,
                           BlockBackend *on_eject_blk, Error **errp);
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index a1dc11bdd7..16cda3b052 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -154,7 +154,6 @@ BlockExport *nbd_export_create(BlockExportOptions *exp_args, Error **errp)
     BlockDriverState *bs = NULL;
     BlockBackend *on_eject_blk;
     NBDExport *exp = NULL;
-    int64_t len;
     AioContext *aio_context;
 
     assert(exp_args->type == BLOCK_EXPORT_TYPE_NBD);
@@ -192,12 +191,6 @@ BlockExport *nbd_export_create(BlockExportOptions *exp_args, Error **errp)
 
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
-    len = bdrv_getlength(bs);
-    if (len < 0) {
-        error_setg_errno(errp, -len,
-                         "Failed to determine the NBD export's length");
-        goto out;
-    }
 
     if (!arg->has_writable) {
         arg->writable = false;
@@ -206,7 +199,7 @@ BlockExport *nbd_export_create(BlockExportOptions *exp_args, Error **errp)
         arg->writable = false;
     }
 
-    exp = nbd_export_new(bs, 0, len, arg->name, arg->description, arg->bitmap,
+    exp = nbd_export_new(bs, arg->name, arg->description, arg->bitmap,
                          !arg->writable, !arg->writable,
                          NULL, false, on_eject_blk, errp);
     if (!exp) {
diff --git a/nbd/server.c b/nbd/server.c
index 774325dbe5..92360d1f08 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -89,7 +89,6 @@ struct NBDExport {
     BlockBackend *blk;
     char *name;
     char *description;
-    uint64_t dev_offset;
     uint64_t size;
     uint16_t nbdflags;
     QTAILQ_HEAD(, NBDClient) clients;
@@ -1507,8 +1506,8 @@ static void nbd_eject_notifier(Notifier *n, void *data)
     aio_context_release(aio_context);
 }
 
-NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
-                          uint64_t size, const char *name, const char *desc,
+NBDExport *nbd_export_new(BlockDriverState *bs,
+                          const char *name, const char *desc,
                           const char *bitmap, bool readonly, bool shared,
                           void (*close)(NBDExport *), bool writethrough,
                           BlockBackend *on_eject_blk, Error **errp)
@@ -1516,9 +1515,17 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
     AioContext *ctx;
     BlockBackend *blk;
     NBDExport *exp;
+    int64_t size;
     uint64_t perm;
     int ret;
 
+    size = bdrv_getlength(bs);
+    if (size < 0) {
+        error_setg_errno(errp, -size,
+                         "Failed to determine the NBD export's length");
+        return NULL;
+    }
+
     exp = g_new0(NBDExport, 1);
     exp->common = (BlockExport) {
         .drv = &blk_exp_nbd,
@@ -1553,8 +1560,6 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
     exp->refcount = 1;
     QTAILQ_INIT(&exp->clients);
     exp->blk = blk;
-    assert(dev_offset <= INT64_MAX);
-    exp->dev_offset = dev_offset;
     exp->name = g_strdup(name);
     assert(!desc || strlen(desc) <= NBD_MAX_STRING_SIZE);
     exp->description = g_strdup(desc);
@@ -1569,7 +1574,7 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
         exp->nbdflags |= (NBD_FLAG_SEND_TRIM | NBD_FLAG_SEND_WRITE_ZEROES |
                           NBD_FLAG_SEND_FAST_ZERO);
     }
-    assert(size <= INT64_MAX - dev_offset);
+    assert(size <= INT64_MAX);
     exp->size = QEMU_ALIGN_DOWN(size, BDRV_SECTOR_SIZE);
 
     if (bitmap) {
@@ -1928,8 +1933,7 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
             stl_be_p(&chunk.length, pnum);
             ret = nbd_co_send_iov(client, iov, 1, errp);
         } else {
-            ret = blk_pread(exp->blk, offset + progress + exp->dev_offset,
-                            data + progress, pnum);
+            ret = blk_pread(exp->blk, offset + progress, data + progress, pnum);
             if (ret < 0) {
                 error_setg_errno(errp, -ret, "reading from file failed");
                 break;
@@ -2303,8 +2307,7 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *client, NBDRequest *request,
                                        data, request->len, errp);
     }
 
-    ret = blk_pread(exp->blk, request->from + exp->dev_offset, data,
-                    request->len);
+    ret = blk_pread(exp->blk, request->from, data, request->len);
     if (ret < 0) {
         return nbd_send_generic_reply(client, request->handle, ret,
                                       "reading from file failed", errp);
@@ -2339,7 +2342,7 @@ static coroutine_fn int nbd_do_cmd_cache(NBDClient *client, NBDRequest *request,
 
     assert(request->type == NBD_CMD_CACHE);
 
-    ret = blk_co_preadv(exp->blk, request->from + exp->dev_offset, request->len,
+    ret = blk_co_preadv(exp->blk, request->from, request->len,
                         NULL, BDRV_REQ_COPY_ON_READ | BDRV_REQ_PREFETCH);
 
     return nbd_send_generic_reply(client, request->handle, ret,
@@ -2370,8 +2373,7 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
         if (request->flags & NBD_CMD_FLAG_FUA) {
             flags |= BDRV_REQ_FUA;
         }
-        ret = blk_pwrite(exp->blk, request->from + exp->dev_offset,
-                         data, request->len, flags);
+        ret = blk_pwrite(exp->blk, request->from, data, request->len, flags);
         return nbd_send_generic_reply(client, request->handle, ret,
                                       "writing to file failed", errp);
 
@@ -2386,8 +2388,7 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
         if (request->flags & NBD_CMD_FLAG_FAST_ZERO) {
             flags |= BDRV_REQ_NO_FALLBACK;
         }
-        ret = blk_pwrite_zeroes(exp->blk, request->from + exp->dev_offset,
-                                request->len, flags);
+        ret = blk_pwrite_zeroes(exp->blk, request->from, request->len, flags);
         return nbd_send_generic_reply(client, request->handle, ret,
                                       "writing to file failed", errp);
 
@@ -2401,8 +2402,7 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
                                       "flush failed", errp);
 
     case NBD_CMD_TRIM:
-        ret = blk_co_pdiscard(exp->blk, request->from + exp->dev_offset,
-                              request->len);
+        ret = blk_co_pdiscard(exp->blk, request->from, request->len);
         if (ret == 0 && request->flags & NBD_CMD_FLAG_FUA) {
             ret = blk_co_flush(exp->blk);
         }
diff --git a/qemu-nbd.c b/qemu-nbd.c
index d2657b8db5..818c3f5d46 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -523,7 +523,6 @@ int main(int argc, char **argv)
     const char *port = NULL;
     char *sockpath = NULL;
     char *device = NULL;
-    int64_t fd_size;
     QemuOpts *sn_opts = NULL;
     const char *sn_id_or_name = NULL;
     const char *sopt = "hVb:o:p:rsnc:dvk:e:f:tl:x:T:D:B:L";
@@ -1028,6 +1027,17 @@ int main(int argc, char **argv)
     }
     bs = blk_bs(blk);
 
+    if (dev_offset) {
+        QDict *raw_opts = qdict_new();
+        qdict_put_str(raw_opts, "driver", "raw");
+        qdict_put_str(raw_opts, "file", bs->node_name);
+        qdict_put_int(raw_opts, "offset", dev_offset);
+        bs = bdrv_open(NULL, NULL, raw_opts, flags, &error_fatal);
+        blk_remove_bs(blk);
+        blk_insert_bs(blk, bs, &error_fatal);
+        bdrv_unref(bs);
+    }
+
     blk_set_enable_write_cache(blk, !writethrough);
 
     if (sn_opts) {
@@ -1045,21 +1055,8 @@ int main(int argc, char **argv)
     }
 
     bs->detect_zeroes = detect_zeroes;
-    fd_size = blk_getlength(blk);
-    if (fd_size < 0) {
-        error_report("Failed to determine the image length: %s",
-                     strerror(-fd_size));
-        exit(EXIT_FAILURE);
-    }
-
-    if (dev_offset >= fd_size) {
-        error_report("Offset (%" PRIu64 ") has to be smaller than the image "
-                     "size (%" PRId64 ")", dev_offset, fd_size);
-        exit(EXIT_FAILURE);
-    }
-    fd_size -= dev_offset;
 
-    export = nbd_export_new(bs, dev_offset, fd_size, export_name,
+    export = nbd_export_new(bs, export_name,
                             export_description, bitmap, readonly, shared > 1,
                             nbd_export_closed, writethrough, NULL,
                             &error_fatal);
-- 
2.25.4


