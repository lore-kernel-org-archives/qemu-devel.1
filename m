Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF81C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 15:24:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A82D92072A
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 15:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8jXpQyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82D92072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAxnT-0001Gz-Rp
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 11:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jAxiV-0000iY-0H
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 11:19:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jAxiT-0001kf-AK
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 11:19:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37711
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jAxiT-0001kT-39
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 11:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583680784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aDRS7DeeffqTgCl6abkVj/mGBwSe1S+W9Ucu99b6J5k=;
 b=D8jXpQyFo5XD0HXwzX1IPd3pypYj1oIqyNBhsxziKET6kSPn8JS/fftL0Vdt7ILumGDZMd
 cXDPGVA5VsrLr1vUbewlGOR28VgP5KopvEXgcPZgh8T0qZf0r45x0mBthmPIMPOLYgpBB0
 qFv+VfhoHA+b9qkQgrSHsayihpzG0GY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-_e3nNLZtOt2oha-mnG412A-1; Sun, 08 Mar 2020 11:19:42 -0400
X-MC-Unique: _e3nNLZtOt2oha-mnG412A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87243801E5C;
 Sun,  8 Mar 2020 15:19:41 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B92E5C1B0;
 Sun,  8 Mar 2020 15:19:38 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/14] block/core: add generic infrastructure for
 x-blockdev-amend qmp command
Date: Sun,  8 Mar 2020 17:19:00 +0200
Message-Id: <20200308151903.25941-12-mlevitsk@redhat.com>
In-Reply-To: <20200308151903.25941-1-mlevitsk@redhat.com>
References: <20200308151903.25941-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

blockdev-amend will be used similiar to blockdev-create
to allow on the fly changes of the structure of the format based block devi=
ces.

Current plan is to first support encryption keyslot management for luks
based formats (raw and embedded in qcow2)

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/Makefile.objs       |   2 +-
 block/amend.c             | 108 ++++++++++++++++++++++++++++++++++++++
 include/block/block_int.h |  21 +++++---
 qapi/block-core.json      |  42 +++++++++++++++
 qapi/job.json             |   4 +-
 5 files changed, 169 insertions(+), 8 deletions(-)
 create mode 100644 block/amend.c

diff --git a/block/Makefile.objs b/block/Makefile.objs
index 3bcb35c81d..5f0e60e7b4 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -19,7 +19,7 @@ block-obj-$(CONFIG_WIN32) +=3D file-win32.o win32-aio.o
 block-obj-$(CONFIG_POSIX) +=3D file-posix.o
 block-obj-$(CONFIG_LINUX_AIO) +=3D linux-aio.o
 block-obj-$(CONFIG_LINUX_IO_URING) +=3D io_uring.o
-block-obj-y +=3D null.o mirror.o commit.o io.o create.o
+block-obj-y +=3D null.o mirror.o commit.o io.o create.o amend.o
 block-obj-y +=3D throttle-groups.o
 block-obj-$(CONFIG_LINUX) +=3D nvme.o
=20
diff --git a/block/amend.c b/block/amend.c
new file mode 100644
index 0000000000..2db7b1eafc
--- /dev/null
+++ b/block/amend.c
@@ -0,0 +1,108 @@
+/*
+ * Block layer code related to image options amend
+ *
+ * Copyright (c) 2018 Kevin Wolf <kwolf@redhat.com>
+ * Copyright (c) 2019 Maxim Levitsky <mlevitsk@redhat.com>
+ *
+ * Heavily based on create.c
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
+ * of this software and associated documentation files (the "Software"), t=
o deal
+ * in the Software without restriction, including without limitation the r=
ights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN
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
+    BlockdevAmendOptions *opts;
+    BlockDriverState *bs;
+    bool force;
+} BlockdevAmendJob;
+
+static int coroutine_fn blockdev_amend_run(Job *job, Error **errp)
+{
+    BlockdevAmendJob *s =3D container_of(job, BlockdevAmendJob, common);
+    int ret;
+
+    job_progress_set_remaining(&s->common, 1);
+    ret =3D s->bs->drv->bdrv_co_amend(s->bs, s->opts, s->force, errp);
+    job_progress_update(&s->common, 1);
+    qapi_free_BlockdevAmendOptions(s->opts);
+    return ret;
+}
+
+static const JobDriver blockdev_amend_job_driver =3D {
+    .instance_size =3D sizeof(BlockdevAmendJob),
+    .job_type      =3D JOB_TYPE_AMEND,
+    .run           =3D blockdev_amend_run,
+};
+
+void qmp_x_blockdev_amend(const char *job_id,
+                          const char *node_name,
+                          BlockdevAmendOptions *options,
+                          bool has_force,
+                          bool force,
+                          Error **errp)
+{
+    BlockdevAmendJob *s;
+    const char *fmt =3D BlockdevDriver_str(options->driver);
+    BlockDriver *drv =3D bdrv_find_format(fmt);
+    BlockDriverState *bs =3D bdrv_find_node(node_name);
+
+    /*
+     * If the driver is in the schema, we know that it exists. But it may =
not
+     * be whitelisted.
+     */
+    assert(drv);
+    if (bdrv_uses_whitelist() && !bdrv_is_whitelisted(drv, false)) {
+        error_setg(errp, "Driver is not whitelisted");
+        return;
+    }
+
+    if (bs->drv !=3D drv) {
+        error_setg(errp,
+                   "x-blockdev-amend doesn't support changing the block dr=
iver");
+        return;
+    }
+
+    /* Error out if the driver doesn't support .bdrv_co_amend */
+    if (!drv->bdrv_co_amend) {
+        error_setg(errp, "Driver does not support x-blockdev-amend");
+        return;
+    }
+
+    /* Create the block job */
+    s =3D job_create(job_id, &blockdev_amend_job_driver, NULL,
+                   bdrv_get_aio_context(bs), JOB_DEFAULT | JOB_MANUAL_DISM=
ISS,
+                   NULL, NULL, errp);
+    if (!s) {
+        return;
+    }
+
+    s->bs =3D bs,
+    s->opts =3D QAPI_CLONE(BlockdevAmendOptions, options),
+    s->force =3D has_force ? force : false;
+    job_start(&s->common);
+}
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 48a4c2fa1c..c993cf9540 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -132,11 +132,26 @@ struct BlockDriver {
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
+    int coroutine_fn (*bdrv_co_amend)(BlockDriverState *bs,
+                                      BlockdevAmendOptions *opts,
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
     int (*bdrv_make_empty)(BlockDriverState *bs);
=20
     /*
@@ -427,12 +442,6 @@ struct BlockDriver {
                                       BdrvCheckResult *result,
                                       BdrvCheckMode fix);
=20
-    int (*bdrv_amend_options)(BlockDriverState *bs, QemuOpts *opts,
-                              BlockDriverAmendStatusCB *status_cb,
-                              void *cb_opaque,
-                              bool force,
-                              Error **errp);
-
     void (*bdrv_debug_event)(BlockDriverState *bs, BlkdebugEvent event);
=20
     /* TODO Better pass a option string/QDict/QemuOpts to add any rule? */
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 85e27bb61f..192da75a10 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4757,6 +4757,48 @@
   'data': { 'job-id': 'str',
             'options': 'BlockdevCreateOptions' } }
=20
+##
+# @BlockdevAmendOptions:
+#
+# Options for amending an image format
+#
+# @driver           block driver that is suitable for the image
+#
+# Since: 5.0
+##
+{ 'union': 'BlockdevAmendOptions',
+  'base': {
+      'driver':         'BlockdevDriver' },
+  'discriminator': 'driver',
+  'data': {
+  } }
+
+##
+# @x-blockdev-amend:
+#
+# Starts a job to amend format specific options of an existing open block =
device
+# The job is automatically finalized, but a manual job-dismiss is required=
.
+#
+# @job-id:          Identifier for the newly created job.
+#
+# @node-name:       Name of the block node to work on
+#
+# @options:         Options (driver specific)
+#
+# @force:           Allow unsafe operations, format specific
+#                   For luks that allows erase of the last active keyslot
+#                   (permanent loss of data),
+#                   and replacement of an active keyslot
+#                   (possible loss of data if IO error happens)
+#
+# Since: 5.0
+##
+{ 'command': 'x-blockdev-amend',
+  'data': { 'job-id': 'str',
+            'node-name': 'str',
+            'options': 'BlockdevAmendOptions',
+            '*force': 'bool' } }
+
 ##
 # @blockdev-open-tray:
 #
diff --git a/qapi/job.json b/qapi/job.json
index 5e658281f5..7e4f7fcaa4 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -19,10 +19,12 @@
 #
 # @create: image creation job type, see "blockdev-create" (since 3.0)
 #
+# @amend: image options amend job type, see "x-blockdev-amend" (since 5.0)
+#
 # Since: 1.7
 ##
 { 'enum': 'JobType',
-  'data': ['commit', 'stream', 'mirror', 'backup', 'create'] }
+  'data': ['commit', 'stream', 'mirror', 'backup', 'create', 'amend'] }
=20
 ##
 # @JobStatus:
--=20
2.17.2


