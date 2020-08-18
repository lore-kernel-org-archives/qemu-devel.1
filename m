Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44D1C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 21:27:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73FBD2067C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 21:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FBD2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k898m-00013U-Ph
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 17:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k8969-0005rX-F1; Tue, 18 Aug 2020 17:24:49 -0400
Received: from relay.sw.ru ([185.231.240.75]:41579 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k8965-0003cY-2i; Tue, 18 Aug 2020 17:24:49 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.94)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k895p-000GtS-Nj; Wed, 19 Aug 2020 00:24:29 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v6 3/4] qapi: add filter-node-name to block-stream
Date: Wed, 19 Aug 2020 00:24:39 +0300
Message-Id: <1597785880-431103-4-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1597785880-431103-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1597785880-431103-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 17:24:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, armbru@redhat.com,
 qemu-devel@nongnu.org, andrey.shinkevich@virtuozzo.com, den@openvz.org,
 mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Provide the possibility to pass the 'filter-node-name' parameter to the
block-stream job as it is done for the commit block job. That will be
needed for further iotests implementations.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/monitor/block-hmp-cmds.c | 4 ++--
 block/stream.c                 | 4 +++-
 blockdev.c                     | 8 +++++++-
 include/block/block_int.h      | 7 ++++++-
 qapi/block-core.json           | 6 ++++++
 5 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 4d3db5e..4e66775 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -507,8 +507,8 @@ void hmp_block_stream(Monitor *mon, const QDict *qdict)
 
     qmp_block_stream(true, device, device, base != NULL, base, false, NULL,
                      false, NULL, qdict_haskey(qdict, "speed"), speed, true,
-                     BLOCKDEV_ON_ERROR_REPORT, false, false, false, false,
-                     &error);
+                     BLOCKDEV_ON_ERROR_REPORT, false, NULL, false, false, false,
+                     false, &error);
 
     hmp_handle_error(mon, error);
 }
diff --git a/block/stream.c b/block/stream.c
index b9c1141..8bf6b6d 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -221,7 +221,9 @@ static const BlockJobDriver stream_job_driver = {
 void stream_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *base, const char *backing_file_str,
                   int creation_flags, int64_t speed,
-                  BlockdevOnError on_error, Error **errp)
+                  BlockdevOnError on_error,
+                  const char *filter_node_name,
+                  Error **errp)
 {
     StreamBlockJob *s;
     BlockDriverState *iter;
diff --git a/blockdev.c b/blockdev.c
index 237fffb..800ecb3 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2476,6 +2476,7 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
                       bool has_backing_file, const char *backing_file,
                       bool has_speed, int64_t speed,
                       bool has_on_error, BlockdevOnError on_error,
+                      bool has_filter_node_name, const char *filter_node_name,
                       bool has_auto_finalize, bool auto_finalize,
                       bool has_auto_dismiss, bool auto_dismiss,
                       Error **errp)
@@ -2491,6 +2492,10 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
         on_error = BLOCKDEV_ON_ERROR_REPORT;
     }
 
+    if (!has_filter_node_name) {
+        filter_node_name = NULL;
+    }
+
     bs = bdrv_lookup_bs(device, device, errp);
     if (!bs) {
         return;
@@ -2558,7 +2563,8 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
     }
 
     stream_start(has_job_id ? job_id : NULL, bs, base_bs, base_name,
-                 job_flags, has_speed ? speed : 0, on_error, &local_err);
+                 job_flags, has_speed ? speed : 0, on_error,
+                 filter_node_name, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto out;
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 465a601..3efde33 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1122,6 +1122,9 @@ int is_windows_drive(const char *filename);
  *                  See @BlockJobCreateFlags
  * @speed: The maximum speed, in bytes per second, or 0 for unlimited.
  * @on_error: The action to take upon error.
+ * @filter_node_name: The node name that should be assigned to the filter
+ * driver that the commit job inserts into the graph above @bs. NULL means
+ * that a node name should be autogenerated.
  * @errp: Error object.
  *
  * Start a streaming operation on @bs.  Clusters that are unallocated
@@ -1134,7 +1137,9 @@ int is_windows_drive(const char *filename);
 void stream_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *base, const char *backing_file_str,
                   int creation_flags, int64_t speed,
-                  BlockdevOnError on_error, Error **errp);
+                  BlockdevOnError on_error,
+                  const char *filter_node_name,
+                  Error **errp);
 
 /**
  * commit_start:
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0b8ccd3..1db6ce1 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2524,6 +2524,11 @@
 #            'stop' and 'enospc' can only be used if the block device
 #            supports io-status (see BlockInfo).  Since 1.3.
 #
+# @filter-node-name: the node name that should be assigned to the
+#                    filter driver that the stream job inserts into the graph
+#                    above @device. If this option is not given, a node name is
+#                    autogenerated. (Since: 5.1)
+#
 # @auto-finalize: When false, this job will wait in a PENDING state after it has
 #                 finished its work, waiting for @block-job-finalize before
 #                 making any block graph changes.
@@ -2554,6 +2559,7 @@
   'data': { '*job-id': 'str', 'device': 'str', '*base': 'str',
             '*base-node': 'str', '*backing-file': 'str', '*speed': 'int',
             '*on-error': 'BlockdevOnError',
+            '*filter-node-name': 'str',
             '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
 
 ##
-- 
1.8.3.1


