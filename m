Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5551C4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 22:36:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB72820830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 22:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB72820830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Xhm-0004zK-EC
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 18:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i8XcR-00085Y-HC
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 18:31:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i8XcP-0005x4-UZ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 18:31:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59892)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i8XcM-0005uA-FY; Thu, 12 Sep 2019 18:31:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CFFBC307D934;
 Thu, 12 Sep 2019 22:31:09 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E59A25C1B2;
 Thu, 12 Sep 2019 22:31:02 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 13 Sep 2019 01:30:24 +0300
Message-Id: <20190912223028.18496-8-mlevitsk@redhat.com>
In-Reply-To: <20190912223028.18496-1-mlevitsk@redhat.com>
References: <20190912223028.18496-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 12 Sep 2019 22:31:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 07/11] block: add x-blockdev-amend qmp
 command
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/Makefile.objs       |   2 +-
 block/amend.c             | 116 ++++++++++++++++++++++++++++++++++++++
 include/block/block_int.h |  23 ++++++--
 qapi/block-core.json      |  26 +++++++++
 qapi/job.json             |   4 +-
 5 files changed, 163 insertions(+), 8 deletions(-)
 create mode 100644 block/amend.c

diff --git a/block/Makefile.objs b/block/Makefile.objs
index 35f3bca4d9..10d0308792 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -18,7 +18,7 @@ block-obj-y += block-backend.o snapshot.o qapi.o
 block-obj-$(CONFIG_WIN32) += file-win32.o win32-aio.o
 block-obj-$(CONFIG_POSIX) += file-posix.o
 block-obj-$(CONFIG_LINUX_AIO) += linux-aio.o
-block-obj-y += null.o mirror.o commit.o io.o create.o
+block-obj-y += null.o mirror.o commit.o io.o create.o amend.o
 block-obj-y += throttle-groups.o
 block-obj-$(CONFIG_LINUX) += nvme.o
 
diff --git a/block/amend.c b/block/amend.c
new file mode 100644
index 0000000000..9bd28e08e7
--- /dev/null
+++ b/block/amend.c
@@ -0,0 +1,116 @@
+/*
+ * Block layer code related to image options amend
+ *
+ * Copyright (c) 2018 Kevin Wolf <kwolf@redhat.com>
+ * Copyright (c) 2019 Maxim Levitsky <mlevitsk@redhat.com>
+ *
+ * Heavily based on create.c
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "block/block_int.h"
+#include "qemu/job.h"
+#include "qemu/main-loop.h"
+#include "qapi/qapi-commands-block-core.h"
+#include "qapi/qapi-visit-block-core.h"
+#include "qapi/clone-visitor.h"
+#include "qapi/error.h"
+
+typedef struct BlockdevAmendJob {
+    Job common;
+    BlockdevCreateOptions *opts;
+    BlockDriverState *bs;
+    bool force;
+} BlockdevAmendJob;
+
+static int coroutine_fn blockdev_amend_run(Job *job, Error **errp)
+{
+    BlockdevAmendJob *s = container_of(job, BlockdevAmendJob, common);
+    int ret;
+
+    job_progress_set_remaining(&s->common, 1);
+    ret = s->bs->drv->bdrv_co_amend(s->bs, s->opts, s->force, errp);
+    job_progress_update(&s->common, 1);
+
+    qapi_free_BlockdevCreateOptions(s->opts);
+
+    return ret;
+}
+
+static const JobDriver blockdev_amend_job_driver = {
+    .instance_size = sizeof(BlockdevAmendJob),
+    .job_type      = JOB_TYPE_AMEND,
+    .run           = blockdev_amend_run,
+};
+
+void qmp_x_blockdev_amend(const char *job_id,
+                        const char *node_name,
+                        BlockdevCreateOptions *options,
+                        bool has_force,
+                        bool force,
+                        Error **errp)
+{
+    BlockdevAmendJob *s;
+    const char *fmt = BlockdevDriver_str(options->driver);
+    BlockDriver *drv = bdrv_find_format(fmt);
+    BlockDriverState *bs = bdrv_find_node(node_name);
+
+    /*
+     * If the driver is in the schema, we know that it exists. But it may not
+     * be whitelisted.
+     */
+    assert(drv);
+    if (bdrv_uses_whitelist() && !bdrv_is_whitelisted(drv, false)) {
+        error_setg(errp, "Driver is not whitelisted");
+        return;
+    }
+
+    if (bs->drv != drv) {
+        error_setg(errp,
+                   "x-blockdev-amend doesn't support changing the block driver");
+        return;
+
+    }
+
+    /* Error out if the driver doesn't support .bdrv_co_amend */
+    if (!drv->bdrv_co_amend) {
+        error_setg(errp, "Driver does not support x-blockdev-amend");
+        return;
+    }
+
+    /*
+     * Create the block job
+     * TODO Running in the main context. Block drivers need to error out or add
+     * locking when they use a BDS in a different AioContext.
+     */
+    s = job_create(job_id, &blockdev_amend_job_driver, NULL,
+                   qemu_get_aio_context(), JOB_DEFAULT | JOB_MANUAL_DISMISS,
+                   NULL, NULL, errp);
+    if (!s) {
+        return;
+    }
+
+    s->bs = bs,
+    s->opts = QAPI_CLONE(BlockdevCreateOptions, options),
+    s->force = has_force ? force : false;
+
+    job_start(&s->common);
+}
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 5ea30f9d58..3001114361 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -133,11 +133,28 @@ struct BlockDriver {
     int (*bdrv_file_open)(BlockDriverState *bs, QDict *options, int flags,
                           Error **errp);
     void (*bdrv_close)(BlockDriverState *bs);
+
+
     int coroutine_fn (*bdrv_co_create)(BlockdevCreateOptions *opts,
                                        Error **errp);
     int coroutine_fn (*bdrv_co_create_opts)(const char *filename,
                                             QemuOpts *opts,
                                             Error **errp);
+
+
+    int coroutine_fn (*bdrv_co_amend)(BlockDriverState *bs,
+                                      BlockdevCreateOptions *opts,
+                                      bool force,
+                                      Error **errp);
+
+    int (*bdrv_amend_options)(BlockDriverState *bs,
+                              QemuOpts *opts,
+                              BlockDriverAmendStatusCB *status_cb,
+                              void *cb_opaque,
+                              bool force,
+                              Error **errp);
+
+
     int (*bdrv_make_empty)(BlockDriverState *bs);
 
     /*
@@ -408,12 +425,6 @@ struct BlockDriver {
                                       BdrvCheckResult *result,
                                       BdrvCheckMode fix);
 
-    int (*bdrv_amend_options)(BlockDriverState *bs, QemuOpts *opts,
-                              BlockDriverAmendStatusCB *status_cb,
-                              void *cb_opaque,
-                              bool force,
-                              Error **errp);
-
     void (*bdrv_debug_event)(BlockDriverState *bs, BlkdebugEvent event);
 
     /* TODO Better pass a option string/QDict/QemuOpts to add any rule? */
diff --git a/qapi/block-core.json b/qapi/block-core.json
index e6edd641f1..7900914506 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4650,6 +4650,32 @@
   'data': { 'job-id': 'str',
             'options': 'BlockdevCreateOptions' } }
 
+##
+# @x-blockdev-amend:
+#
+# Starts a job to amend format specific options of an existing open block device.
+# The job is automatically finalized, but a manual job-dismiss is required.
+#
+# @job-id:          Identifier for the newly created job.
+#
+# @node-name:       Name of the block node to work on
+#
+# @options:         Options (same as for image creation)
+#
+# @force:           Allow unsafe operations, format specific
+#                   For luks that allows erase of the last active keyslot
+#                   (permanent loss of data),
+#                   and replacement of an active keyslot
+#                   (possible loss of data if IO error happens)
+#
+# Since: 4.2
+##
+{ 'command': 'x-blockdev-amend',
+  'data': { 'job-id': 'str',
+            'node-name': 'str',
+            'options': 'BlockdevCreateOptions',
+            '*force': 'bool' } }
+
 ##
 # @blockdev-open-tray:
 #
diff --git a/qapi/job.json b/qapi/job.json
index a121b615fb..342d29a7aa 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -19,10 +19,12 @@
 #
 # @create: image creation job type, see "blockdev-create" (since 3.0)
 #
+# @amend: image options amend job type, see "x-blockdev-amend" (since 4.2)
+#
 # Since: 1.7
 ##
 { 'enum': 'JobType',
-  'data': ['commit', 'stream', 'mirror', 'backup', 'create'] }
+  'data': ['commit', 'stream', 'mirror', 'backup', 'create', 'amend'] }
 
 ##
 # @JobStatus:
-- 
2.17.2


