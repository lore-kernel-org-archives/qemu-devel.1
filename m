Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4F2C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 18:32:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86FA72417D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 18:32:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86FA72417D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVfNj-0006sa-Br
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 14:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kVf6W-0000qG-5Y; Thu, 22 Oct 2020 14:14:28 -0400
Received: from relay.sw.ru ([185.231.240.75]:52080 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kVf6K-0001nj-EP; Thu, 22 Oct 2020 14:14:23 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.94)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kVf5r-005dVw-Vk; Thu, 22 Oct 2020 21:13:43 +0300
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 andrey.shinkevich@virtuozzo.com
Subject: [PATCH v12 13/14] stream: skip filters when writing backing file name
 to QCOW2 header
Date: Thu, 22 Oct 2020 21:13:42 +0300
Message-Id: <1603390423-980205-14-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603390423-980205-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1603390423-980205-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 14:13:46
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

Avoid writing a filter JSON file name and a filter format name to QCOW2
image when the backing file is changed after the block stream job.
A user is still able to assign the 'backing-file' parameter for a
block-stream job keeping in mind the possible issue mentioned above.
If the user does not specify the 'backing-file' parameter, QEMU will
assign it automatically.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/stream.c | 15 +++++++++++++--
 blockdev.c     |  9 ++-------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index e0540ee..1ba74ab 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -65,6 +65,7 @@ static int stream_prepare(Job *job)
     BlockDriverState *bs = blk_bs(bjob->blk);
     BlockDriverState *unfiltered_bs = bdrv_skip_filters(bs);
     BlockDriverState *base = bdrv_filter_or_cow_bs(s->above_base);
+    BlockDriverState *base_unfiltered = NULL;
     Error *local_err = NULL;
     int ret = 0;
 
@@ -75,8 +76,18 @@ static int stream_prepare(Job *job)
         const char *base_id = NULL, *base_fmt = NULL;
         if (base) {
             base_id = s->backing_file_str;
-            if (base->drv) {
-                base_fmt = base->drv->format_name;
+            if (base_id) {
+                if (base->drv) {
+                    base_fmt = base->drv->format_name;
+                }
+            } else {
+                base_unfiltered = bdrv_skip_filters(base);
+                if (base_unfiltered) {
+                    base_id = base_unfiltered->filename;
+                    if (base_unfiltered->drv) {
+                        base_fmt = base_unfiltered->drv->format_name;
+                    }
+                }
             }
         }
         bdrv_set_backing_hd(unfiltered_bs, base, &local_err);
diff --git a/blockdev.c b/blockdev.c
index c917625..0e9c783 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2508,7 +2508,6 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
     BlockDriverState *base_bs = NULL;
     AioContext *aio_context;
     Error *local_err = NULL;
-    const char *base_name = NULL;
     int job_flags = JOB_DEFAULT;
 
     if (!has_on_error) {
@@ -2536,7 +2535,6 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
             goto out;
         }
         assert(bdrv_get_aio_context(base_bs) == aio_context);
-        base_name = base;
     }
 
     if (has_base_node) {
@@ -2551,7 +2549,6 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
         }
         assert(bdrv_get_aio_context(base_bs) == aio_context);
         bdrv_refresh_filename(base_bs);
-        base_name = base_bs->filename;
     }
 
     /* Check for op blockers in the whole chain between bs and base */
@@ -2571,9 +2568,6 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
         goto out;
     }
 
-    /* backing_file string overrides base bs filename */
-    base_name = has_backing_file ? backing_file : base_name;
-
     if (has_auto_finalize && !auto_finalize) {
         job_flags |= JOB_MANUAL_FINALIZE;
     }
@@ -2581,7 +2575,8 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
         job_flags |= JOB_MANUAL_DISMISS;
     }
 
-    stream_start(has_job_id ? job_id : NULL, bs, base_bs, base_name,
+    stream_start(has_job_id ? job_id : NULL, bs, base_bs,
+                 has_backing_file ? backing_file : NULL,
                  job_flags, has_speed ? speed : 0, on_error,
                  filter_node_name, &local_err);
     if (local_err) {
-- 
1.8.3.1


