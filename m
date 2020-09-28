Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC82C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:17:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10DDC2074B
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10DDC2074B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMt1b-0004jr-7Q
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kMsoi-0006gR-PQ; Mon, 28 Sep 2020 09:03:44 -0400
Received: from relay.sw.ru ([185.231.240.75]:59402 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kMsog-0000id-6n; Mon, 28 Sep 2020 09:03:44 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.94)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kMso6-001tba-H5; Mon, 28 Sep 2020 16:03:06 +0300
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net, jsnow@redhat.com, armbru@redhat.com,
 eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 andrey.shinkevich@virtuozzo.com
Subject: [PATCH v9 8/9] block: remove unused backing-file name parameter
Date: Mon, 28 Sep 2020 16:00:00 +0300
Message-Id: <1601298001-774096-9-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1601298001-774096-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1601298001-774096-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 09:00:28
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
From: Andrey Shinkevich via <qemu-devel@nongnu.org>

The block stream QMP parameter backing-file is in use no more. It
designates a backing file name to set in QCOW2 image header after the
block stream job finished. The base file name is used instead.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/monitor/block-hmp-cmds.c |  2 +-
 block/stream.c                 |  6 +-----
 blockdev.c                     | 17 +----------------
 include/block/block_int.h      |  2 +-
 qapi/block-core.json           | 17 +----------------
 5 files changed, 5 insertions(+), 39 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 4e66775..5f19499 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -506,7 +506,7 @@ void hmp_block_stream(Monitor *mon, const QDict *qdict)
     int64_t speed = qdict_get_try_int(qdict, "speed", 0);
 
     qmp_block_stream(true, device, device, base != NULL, base, false, NULL,
-                     false, NULL, qdict_haskey(qdict, "speed"), speed, true,
+                     qdict_haskey(qdict, "speed"), speed, true,
                      BLOCKDEV_ON_ERROR_REPORT, false, NULL, false, false, false,
                      false, &error);
 
diff --git a/block/stream.c b/block/stream.c
index b0719e9..fe2663f 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -34,7 +34,6 @@ typedef struct StreamBlockJob {
     BlockDriverState *base_overlay; /* COW overlay (stream from this) */
     BlockDriverState *above_base;   /* Node directly above the base */
     BlockdevOnError on_error;
-    char *backing_file_str;
     bool bs_read_only;
     bool chain_frozen;
 } StreamBlockJob;
@@ -103,8 +102,6 @@ static void stream_clean(Job *job)
         blk_set_perm(bjob->blk, 0, BLK_PERM_ALL, &error_abort);
         bdrv_reopen_set_read_only(bs, true, NULL);
     }
-
-    g_free(s->backing_file_str);
 }
 
 static int coroutine_fn stream_run(Job *job, Error **errp)
@@ -220,7 +217,7 @@ static const BlockJobDriver stream_job_driver = {
 };
 
 void stream_start(const char *job_id, BlockDriverState *bs,
-                  BlockDriverState *base, const char *backing_file_str,
+                  BlockDriverState *base,
                   int creation_flags, int64_t speed,
                   BlockdevOnError on_error,
                   const char *filter_node_name,
@@ -295,7 +292,6 @@ void stream_start(const char *job_id, BlockDriverState *bs,
 
     s->base_overlay = base_overlay;
     s->above_base = above_base;
-    s->backing_file_str = g_strdup(backing_file_str);
     s->bs_read_only = bs_read_only;
     s->chain_frozen = true;
 
diff --git a/blockdev.c b/blockdev.c
index d719c47..b223601 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2486,7 +2486,6 @@ out:
 void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
                       bool has_base, const char *base,
                       bool has_base_node, const char *base_node,
-                      bool has_backing_file, const char *backing_file,
                       bool has_speed, int64_t speed,
                       bool has_on_error, BlockdevOnError on_error,
                       bool has_filter_node_name, const char *filter_node_name,
@@ -2498,7 +2497,6 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
     BlockDriverState *base_bs = NULL;
     AioContext *aio_context;
     Error *local_err = NULL;
-    const char *base_name = NULL;
     int job_flags = JOB_DEFAULT;
 
     if (!has_on_error) {
@@ -2526,7 +2524,6 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
             goto out;
         }
         assert(bdrv_get_aio_context(base_bs) == aio_context);
-        base_name = base;
     }
 
     if (has_base_node) {
@@ -2541,7 +2538,6 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
         }
         assert(bdrv_get_aio_context(base_bs) == aio_context);
         bdrv_refresh_filename(base_bs);
-        base_name = base_bs->filename;
     }
 
     /* Check for op blockers in the whole chain between bs and base */
@@ -2553,17 +2549,6 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
         }
     }
 
-    /* if we are streaming the entire chain, the result will have no backing
-     * file, and specifying one is therefore an error */
-    if (base_bs == NULL && has_backing_file) {
-        error_setg(errp, "backing file specified, but streaming the "
-                         "entire chain");
-        goto out;
-    }
-
-    /* backing_file string overrides base bs filename */
-    base_name = has_backing_file ? backing_file : base_name;
-
     if (has_auto_finalize && !auto_finalize) {
         job_flags |= JOB_MANUAL_FINALIZE;
     }
@@ -2571,7 +2556,7 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
         job_flags |= JOB_MANUAL_DISMISS;
     }
 
-    stream_start(has_job_id ? job_id : NULL, bs, base_bs, base_name,
+    stream_start(has_job_id ? job_id : NULL, bs, base_bs,
                  job_flags, has_speed ? speed : 0, on_error,
                  filter_node_name, &local_err);
     if (local_err) {
diff --git a/include/block/block_int.h b/include/block/block_int.h
index f782737..bbe2ee6 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1147,7 +1147,7 @@ int is_windows_drive(const char *filename);
  * BlockDriverState.
  */
 void stream_start(const char *job_id, BlockDriverState *bs,
-                  BlockDriverState *base, const char *backing_file_str,
+                  BlockDriverState *base,
                   int creation_flags, int64_t speed,
                   BlockdevOnError on_error,
                   const char *filter_node_name,
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 32fb097..6358606 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2512,21 +2512,6 @@
 # @base-node: the node name of the backing file.
 #             It cannot be set if @base is also set. (Since 2.8)
 #
-# @backing-file: The backing file string to write into the top
-#                image. This filename is not validated.
-#
-#                If a pathname string is such that it cannot be
-#                resolved by QEMU, that means that subsequent QMP or
-#                HMP commands must use node-names for the image in
-#                question, as filename lookup methods will fail.
-#
-#                If not specified, QEMU will automatically determine
-#                the backing file string to use, or error out if there
-#                is no obvious choice.  Care should be taken when
-#                specifying the string, to specify a valid filename or
-#                protocol.
-#                (Since 2.1)
-#
 # @speed: the maximum speed, in bytes per second
 #
 # @on-error: the action to take on an error (default report).
@@ -2566,7 +2551,7 @@
 ##
 { 'command': 'block-stream',
   'data': { '*job-id': 'str', 'device': 'str', '*base': 'str',
-            '*base-node': 'str', '*backing-file': 'str', '*speed': 'int',
+            '*base-node': 'str', '*speed': 'int',
             '*on-error': 'BlockdevOnError',
             '*filter-node-name': 'str',
             '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
-- 
1.8.3.1


