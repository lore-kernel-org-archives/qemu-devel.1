Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9132C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 19:53:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD67F20842
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 19:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD67F20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFOCo-000197-1x
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 15:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iFNo9-0004j2-5E
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iFNo7-0001SS-6S
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:27:36 -0400
Received: from relay.sw.ru ([185.231.240.75]:45312)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iFNo6-0001Qp-UX; Tue, 01 Oct 2019 15:27:35 -0400
Received: from [172.16.25.136] (helo=dhcp-172-16-25-136.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iFNo3-00060a-UZ; Tue, 01 Oct 2019 22:27:32 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Subject: [PATCH 5/6] block-stream: add compress option
Date: Tue,  1 Oct 2019 22:27:19 +0300
Message-Id: <1569958040-697220-6-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1569958040-697220-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1569958040-697220-1-git-send-email-andrey.shinkevich@virtuozzo.com>
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

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/stream.c            | 19 +++++++++++++------
 blockdev.c                | 14 +++++++++++++-
 hmp-commands.hx           |  4 ++--
 include/block/block_int.h |  3 ++-
 monitor/hmp-cmds.c        |  5 +++--
 qapi/block-core.json      |  5 ++++-
 6 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index 5562ccb..51cc49e 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -36,15 +36,21 @@ typedef struct StreamBlockJob {
     char *backing_file_str;
     bool bs_read_only;
     bool chain_frozen;
+    bool compress;
 } StreamBlockJob;
 
-static int coroutine_fn stream_populate(BlockBackend *blk,
-                                        int64_t offset, uint64_t bytes)
+static int coroutine_fn stream_populate(BlockBackend *blk, int64_t offset,
+                                        uint64_t bytes, bool compress)
 {
+    int flags = BDRV_REQ_COPY_ON_READ | BDRV_REQ_PREFETCH;
+
+    if (compress) {
+        flags |= BDRV_REQ_WRITE_COMPRESSED;
+    }
+
     assert(bytes < SIZE_MAX);
 
-    return blk_co_preadv(blk, offset, bytes, NULL,
-                         BDRV_REQ_COPY_ON_READ | BDRV_REQ_PREFETCH);
+    return blk_co_preadv(blk, offset, bytes, NULL, flags);
 }
 
 static void stream_abort(Job *job)
@@ -167,7 +173,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
         }
         trace_stream_one_iteration(s, offset, n, ret);
         if (copy) {
-            ret = stream_populate(blk, offset, n);
+            ret = stream_populate(blk, offset, n, s->compress);
         }
         if (ret < 0) {
             BlockErrorAction action =
@@ -217,7 +223,7 @@ static const BlockJobDriver stream_job_driver = {
 
 void stream_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *base, const char *backing_file_str,
-                  int creation_flags, int64_t speed,
+                  int creation_flags, int64_t speed, bool compress,
                   BlockdevOnError on_error, Error **errp)
 {
     StreamBlockJob *s;
@@ -267,6 +273,7 @@ void stream_start(const char *job_id, BlockDriverState *bs,
     s->backing_file_str = g_strdup(backing_file_str);
     s->bs_read_only = bs_read_only;
     s->chain_frozen = true;
+    s->compress = compress;
 
     s->on_error = on_error;
     trace_stream_start(bs, base, s);
diff --git a/blockdev.c b/blockdev.c
index fbef684..290ee4b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3238,6 +3238,7 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
                       bool has_base_node, const char *base_node,
                       bool has_backing_file, const char *backing_file,
                       bool has_speed, int64_t speed,
+                      bool has_compress, bool compress,
                       bool has_on_error, BlockdevOnError on_error,
                       bool has_auto_finalize, bool auto_finalize,
                       bool has_auto_dismiss, bool auto_dismiss,
@@ -3254,6 +3255,10 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
         on_error = BLOCKDEV_ON_ERROR_REPORT;
     }
 
+    if (!has_compress) {
+        compress = false;
+    }
+
     bs = bdrv_lookup_bs(device, device, errp);
     if (!bs) {
         return;
@@ -3308,6 +3313,12 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
         goto out;
     }
 
+    if (compress && bs->drv->bdrv_co_pwritev_compressed_part == NULL) {
+        error_setg(errp, "Compression is not supported for this drive %s",
+                   bdrv_get_device_name(bs));
+        goto out;
+    }
+
     /* backing_file string overrides base bs filename */
     base_name = has_backing_file ? backing_file : base_name;
 
@@ -3319,7 +3330,8 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
     }
 
     stream_start(has_job_id ? job_id : NULL, bs, base_bs, base_name,
-                 job_flags, has_speed ? speed : 0, on_error, &local_err);
+                 job_flags, has_speed ? speed : 0, compress, on_error,
+                 &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto out;
diff --git a/hmp-commands.hx b/hmp-commands.hx
index cfcc044..3a347fd 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -95,8 +95,8 @@ ETEXI
 
     {
         .name       = "block_stream",
-        .args_type  = "device:B,speed:o?,base:s?",
-        .params     = "device [speed [base]]",
+        .args_type  = "device:B,speed:o?,base:s?,compress:o?",
+        .params     = "device [speed [base]] [compress]",
         .help       = "copy data from a backing file into a block device",
         .cmd        = hmp_block_stream,
     },
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 0422acd..5e7fce8 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1065,6 +1065,7 @@ int is_windows_drive(const char *filename);
  * @creation_flags: Flags that control the behavior of the Job lifetime.
  *                  See @BlockJobCreateFlags
  * @speed: The maximum speed, in bytes per second, or 0 for unlimited.
+ * @compress: True to compress data.
  * @on_error: The action to take upon error.
  * @errp: Error object.
  *
@@ -1077,7 +1078,7 @@ int is_windows_drive(const char *filename);
  */
 void stream_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *base, const char *backing_file_str,
-                  int creation_flags, int64_t speed,
+                  int creation_flags, int64_t speed, bool compress,
                   BlockdevOnError on_error, Error **errp);
 
 /**
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index b2551c1..91201fe 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -2025,11 +2025,12 @@ void hmp_block_stream(Monitor *mon, const QDict *qdict)
     const char *device = qdict_get_str(qdict, "device");
     const char *base = qdict_get_try_str(qdict, "base");
     int64_t speed = qdict_get_try_int(qdict, "speed", 0);
+    bool compress = qdict_get_try_bool(qdict, "compress", false);
 
     qmp_block_stream(true, device, device, base != NULL, base, false, NULL,
                      false, NULL, qdict_haskey(qdict, "speed"), speed, true,
-                     BLOCKDEV_ON_ERROR_REPORT, false, false, false, false,
-                     &error);
+                     compress, true, BLOCKDEV_ON_ERROR_REPORT,
+                     false, false, false, false, &error);
 
     hmp_handle_error(mon, &error);
 }
diff --git a/qapi/block-core.json b/qapi/block-core.json
index e6edd64..f41513f 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2544,6 +2544,9 @@
 #
 # @speed:  the maximum speed, in bytes per second
 #
+# @compress: true to compress data, if the target format supports it.
+#            (default: false). Since 4.1.
+#
 # @on-error: the action to take on an error (default report).
 #            'stop' and 'enospc' can only be used if the block device
 #            supports io-status (see BlockInfo).  Since 1.3.
@@ -2576,7 +2579,7 @@
 { 'command': 'block-stream',
   'data': { '*job-id': 'str', 'device': 'str', '*base': 'str',
             '*base-node': 'str', '*backing-file': 'str', '*speed': 'int',
-            '*on-error': 'BlockdevOnError',
+            '*compress': 'bool', '*on-error': 'BlockdevOnError',
             '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
 
 ##
-- 
1.8.3.1


