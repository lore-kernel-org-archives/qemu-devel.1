Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26721C35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 14:25:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFC5A215EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 14:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC5A215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFfZc-0007vG-Ry
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 10:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iFfWx-0005iL-FL
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 10:23:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iFfWv-0005bC-KI
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 10:23:03 -0400
Received: from relay.sw.ru ([185.231.240.75]:53292)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iFfWv-0005Zd-BP; Wed, 02 Oct 2019 10:23:01 -0400
Received: from [172.16.25.136] (helo=dhcp-172-16-25-136.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iFfWr-0003C3-KI; Wed, 02 Oct 2019 17:22:57 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Subject: [PATCH v2 3/6] qemu-nbd: add compression flag support
Date: Wed,  2 Oct 2019 17:22:43 +0300
Message-Id: <1570026166-748566-4-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570026166-748566-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1570026166-748566-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 jsnow@redhat.com, armbru@redhat.com, dgilbert@redhat.com, stefanha@redhat.com,
 andrey.shinkevich@virtuozzo.com, den@openvz.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Added possibility to write compressed data by using the
blk_write_compressed. This action has the limitations of the format
driver. For example we can't write compressed data over other.

$ ./qemu-img create -f qcow2 -o size=10G ./image.qcow2
$ sudo ./qemu-nbd -c /dev/nbd0 ./image.qcow2
$ sudo dd if=/dev/sda1 of=/dev/nbd0 bs=10M count=10
10+0 records in
10+0 records out
104857600 bytes (105 MB) copied, 0,0890581 s, 1,2 GB/s
$ sudo ./qemu-nbd -d /dev/nbd0
$ du -sh ./image.qcow2
101M    ./image.qcow2

$ ./qemu-img create -f qcow2 -o size=10G ./image.qcow2
$ sudo ./qemu-nbd -C -c /dev/nbd0 ./image.qcow2
$ sudo dd if=/dev/sda1 of=/dev/nbd0 bs=10M count=10
10+0 records in
10+0 records out
104857600 bytes (105 MB) copied, 0,076046 s, 1,4 GB/s
$ sudo ./qemu-nbd -d /dev/nbd0
$ du -sh ./image.qcow2
5,3M    ./image.qcow2

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 blockdev-nbd.c      |  8 ++++++--
 include/block/nbd.h | 11 +++++++++--
 nbd/server.c        | 14 ++++++++++----
 qemu-nbd.c          | 30 ++++++++++++++++++++++++++----
 qemu-nbd.texi       |  2 ++
 5 files changed, 53 insertions(+), 12 deletions(-)

diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 6a8b206..e83036b 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -151,6 +151,7 @@ void qmp_nbd_server_add(const char *device, bool has_name, const char *name,
     BlockBackend *on_eject_blk;
     NBDExport *exp;
     int64_t len;
+    uint32_t iflags = 0;
     AioContext *aio_context;
 
     if (!nbd_server) {
@@ -189,9 +190,12 @@ void qmp_nbd_server_add(const char *device, bool has_name, const char *name,
     if (bdrv_is_read_only(bs)) {
         writable = false;
     }
+    if (!writable) {
+        iflags = NBD_INTERNAL_FLAG_READONLY | NBD_INTERNAL_FLAG_SHARED;
+    }
 
-    exp = nbd_export_new(bs, 0, len, name, NULL, bitmap, !writable, !writable,
-                         NULL, false, on_eject_blk, errp);
+    exp = nbd_export_new(bs, 0, len, name, NULL, bitmap, iflags, NULL,
+                         on_eject_blk, errp);
     if (!exp) {
         goto out;
     }
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 316fd70..80be9d5 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -25,6 +25,13 @@
 #include "crypto/tlscreds.h"
 #include "qapi/error.h"
 
+enum {
+    NBD_INTERNAL_FLAG_READONLY     = 1 << 0, /* Device is read-only */
+    NBD_INTERNAL_FLAG_SHARED       = 1 << 1, /* Device can be shared */
+    NBD_INTERNAL_FLAG_WRITETHROUGH = 1 << 2, /* Enable write cache */
+    NBD_INTERNAL_FLAG_COMPRESS     = 1 << 3, /* Use compressed write */
+};
+
 /* Handshake phase structs - this struct is passed on the wire */
 
 struct NBDOption {
@@ -330,8 +337,8 @@ typedef struct NBDClient NBDClient;
 
 NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
                           uint64_t size, const char *name, const char *desc,
-                          const char *bitmap, bool readonly, bool shared,
-                          void (*close)(NBDExport *), bool writethrough,
+                          const char *bitmap, uint32_t iflags,
+                          void (*close)(NBDExport *),
                           BlockBackend *on_eject_blk, Error **errp);
 void nbd_export_close(NBDExport *exp);
 void nbd_export_remove(NBDExport *exp, NbdServerRemoveMode mode, Error **errp);
diff --git a/nbd/server.c b/nbd/server.c
index d8d1e62..cf3b75d 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -91,6 +91,7 @@ struct NBDExport {
     uint16_t nbdflags;
     QTAILQ_HEAD(, NBDClient) clients;
     QTAILQ_ENTRY(NBDExport) next;
+    uint32_t iflags;
 
     AioContext *ctx;
 
@@ -1471,13 +1472,14 @@ static void nbd_eject_notifier(Notifier *n, void *data)
 
 NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
                           uint64_t size, const char *name, const char *desc,
-                          const char *bitmap, bool readonly, bool shared,
-                          void (*close)(NBDExport *), bool writethrough,
+                          const char *bitmap, uint32_t iflags,
+                          void (*close)(NBDExport *),
                           BlockBackend *on_eject_blk, Error **errp)
 {
     AioContext *ctx;
     BlockBackend *blk;
     NBDExport *exp = g_new0(NBDExport, 1);
+    bool readonly = iflags & NBD_INTERNAL_FLAG_READONLY;
     uint64_t perm;
     int ret;
 
@@ -1504,7 +1506,7 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
     if (ret < 0) {
         goto fail;
     }
-    blk_set_enable_write_cache(blk, !writethrough);
+    blk_set_enable_write_cache(blk, !(iflags & NBD_INTERNAL_FLAG_WRITETHROUGH));
     blk_set_allow_aio_context_change(blk, true);
 
     exp->refcount = 1;
@@ -1518,13 +1520,14 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
                      NBD_FLAG_SEND_FUA | NBD_FLAG_SEND_CACHE);
     if (readonly) {
         exp->nbdflags |= NBD_FLAG_READ_ONLY;
-        if (shared) {
+        if (iflags & NBD_INTERNAL_FLAG_SHARED) {
             exp->nbdflags |= NBD_FLAG_CAN_MULTI_CONN;
         }
     } else {
         exp->nbdflags |= (NBD_FLAG_SEND_TRIM | NBD_FLAG_SEND_WRITE_ZEROES |
                           NBD_FLAG_SEND_FAST_ZERO);
     }
+    exp->iflags = iflags;
     assert(size <= INT64_MAX - dev_offset);
     exp->size = QEMU_ALIGN_DOWN(size, BDRV_SECTOR_SIZE);
 
@@ -2312,6 +2315,9 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
         if (request->flags & NBD_CMD_FLAG_FUA) {
             flags |= BDRV_REQ_FUA;
         }
+        if (exp->iflags & NBD_INTERNAL_FLAG_COMPRESS) {
+            flags |= BDRV_REQ_WRITE_COMPRESSED;
+        }
         ret = blk_pwrite(exp->blk, request->from + exp->dev_offset,
                          data, request->len, flags);
         return nbd_send_generic_reply(client, request->handle, ret,
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 9032b6d..4163135 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -139,6 +139,7 @@ static void usage(const char *name)
 "      --discard=MODE        set discard mode (ignore, unmap)\n"
 "      --detect-zeroes=MODE  set detect-zeroes mode (off, on, unmap)\n"
 "      --image-opts          treat FILE as a full set of image options\n"
+"  -C, --compress            use data compression (if the target format supports it)\n"
 "\n"
 QEMU_HELP_BOTTOM "\n"
     , name, name, NBD_DEFAULT_PORT, "DEVICE");
@@ -602,6 +603,7 @@ int main(int argc, char **argv)
     BlockDriverState *bs;
     uint64_t dev_offset = 0;
     bool readonly = false;
+    uint32_t iflags = 0;
     bool disconnect = false;
     const char *bindto = NULL;
     const char *port = NULL;
@@ -610,7 +612,7 @@ int main(int argc, char **argv)
     int64_t fd_size;
     QemuOpts *sn_opts = NULL;
     const char *sn_id_or_name = NULL;
-    const char *sopt = "hVb:o:p:rsnP:c:dvk:e:f:tl:x:T:D:B:L";
+    const char *sopt = "hVb:o:p:rsnCP:c:dvk:e:f:tl:x:T:D:B:L";
     struct option lopt[] = {
         { "help", no_argument, NULL, 'h' },
         { "version", no_argument, NULL, 'V' },
@@ -619,6 +621,7 @@ int main(int argc, char **argv)
         { "socket", required_argument, NULL, 'k' },
         { "offset", required_argument, NULL, 'o' },
         { "read-only", no_argument, NULL, 'r' },
+        { "compress", no_argument, NULL, 'C'},
         { "partition", required_argument, NULL, 'P' },
         { "bitmap", required_argument, NULL, 'B' },
         { "connect", required_argument, NULL, 'c' },
@@ -786,6 +789,9 @@ int main(int argc, char **argv)
             readonly = true;
             flags &= ~BDRV_O_RDWR;
             break;
+        case 'C':
+            iflags |= NBD_INTERNAL_FLAG_COMPRESS;
+            break;
         case 'P':
             warn_report("The '-P' option is deprecated; use --image-opts with "
                         "a raw device wrapper for subset exports instead");
@@ -1117,6 +1123,14 @@ int main(int argc, char **argv)
 
     blk_set_enable_write_cache(blk, !writethrough);
 
+    if ((iflags & NBD_INTERNAL_FLAG_COMPRESS) &&
+        !(bs->drv && bs->drv->bdrv_co_pwritev_compressed_part))
+    {
+        error_report("Compression not supported for this file format %s",
+                     argv[optind]);
+        exit(EXIT_FAILURE);
+    }
+
     if (sn_opts) {
         ret = bdrv_snapshot_load_tmp(bs,
                                      qemu_opt_get(sn_opts, SNAPSHOT_OPT_ID),
@@ -1173,10 +1187,18 @@ int main(int argc, char **argv)
         fd_size = limit;
     }
 
+    if (writethrough) {
+        iflags |= NBD_INTERNAL_FLAG_WRITETHROUGH;
+    }
+    if (readonly) {
+        iflags |= NBD_INTERNAL_FLAG_READONLY;
+    }
+    if (shared > 1) {
+        iflags |= NBD_INTERNAL_FLAG_SHARED;
+    }
     export = nbd_export_new(bs, dev_offset, fd_size, export_name,
-                            export_description, bitmap, readonly, shared > 1,
-                            nbd_export_closed, writethrough, NULL,
-                            &error_fatal);
+                            export_description, bitmap, iflags,
+                            nbd_export_closed, NULL, &error_fatal);
 
     if (device) {
 #if HAVE_NBD_DEVICE
diff --git a/qemu-nbd.texi b/qemu-nbd.texi
index 7f55657..26ea1ec 100644
--- a/qemu-nbd.texi
+++ b/qemu-nbd.texi
@@ -55,6 +55,8 @@ Force the use of the block driver for format @var{fmt} instead of
 auto-detecting.
 @item -r, --read-only
 Export the disk as read-only.
+@item -C, --compress
+Use data compression (if the target format supports it)
 @item -P, --partition=@var{num}
 Deprecated: Only expose MBR partition @var{num}.  Understands physical
 partitions 1-4 and logical partition 5. New code should instead use
-- 
1.8.3.1


