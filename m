Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08B4C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:55:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1303E2064E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZcAULSsB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1303E2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKfxI-0006J6-TK
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 06:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kKfs2-0000BK-P2
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:50:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41321)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kKfrt-0000SN-QP
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600771789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UTrRI+Vh+mX14W1DwBs1CjcLTpVNkRFF6rwR1vpThhk=;
 b=ZcAULSsBaRQHTIAmS7U6GF36RRNZDAUHfcAJxaMlEQthcaQxD6wMSFxH7vb3v2JVZRw3l2
 CM4+CmyZa2p7aeS7ZW14hX5+UPF3+BiYoG/aUo60rvu7dUCeE75/1R87TLkUmpaz8QxmIe
 nU9DwW2bi8xtDa16npa0Jza8IQXM4rc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-jaAqkxTQMR-QkAkoFBVe3Q-1; Tue, 22 Sep 2020 06:49:46 -0400
X-MC-Unique: jaAqkxTQMR-QkAkoFBVe3Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FA561868406;
 Tue, 22 Sep 2020 10:49:45 +0000 (UTC)
Received: from localhost (ovpn-114-26.ams2.redhat.com [10.36.114.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FA7378805;
 Tue, 22 Sep 2020 10:49:44 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 02/20] fuse: Allow exporting BDSs via FUSE
Date: Tue, 22 Sep 2020 12:49:14 +0200
Message-Id: <20200922104932.46384-3-mreitz@redhat.com>
In-Reply-To: <20200922104932.46384-1-mreitz@redhat.com>
References: <20200922104932.46384-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

block-export-add type=fuse allows mounting block graph nodes via FUSE on
some existing regular file.  That file should then appears like a raw
disk image, and accesses to it result in accesses to the exported BDS.

Right now, we only implement the necessary block export functions to set
it up and shut it down.  We do not implement any access functions, so
accessing the mount point only results in errors.  This will be
addressed by a followup patch.

We keep a hash table of exported mount points, because we want to be
able to detect when users try to use a mount point twice.  This is
because we invoke stat() to check whether the given mount point is a
regular file, but if that file is served by ourselves (because it is
already used as a mount point), then this stat() would have to be served
by ourselves, too, which is impossible to do while we (as the caller)
are waiting for it to settle.  Therefore, keep track of mount point
paths to at least catch the most obvious instances of that problem.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-export.json   |  24 +++-
 include/block/fuse.h     |  30 +++++
 block.c                  |   1 +
 block/export/export.c    |   4 +
 block/export/fuse.c      | 253 +++++++++++++++++++++++++++++++++++++++
 block/export/meson.build |   1 +
 6 files changed, 311 insertions(+), 2 deletions(-)
 create mode 100644 include/block/fuse.h
 create mode 100644 block/export/fuse.c

diff --git a/qapi/block-export.json b/qapi/block-export.json
index 0c045dfe7b..cb5bd54cbf 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -174,6 +174,21 @@
 ##
 { 'command': 'nbd-server-stop' }
 
+##
+# @BlockExportOptionsFuse:
+#
+# Options for exporting a block graph node on some (file) mountpoint
+# as a raw image.
+#
+# @mountpoint: Path on which to export the block device via FUSE.
+#              This must point to an existing regular file.
+#
+# Since: 5.2
+##
+{ 'struct': 'BlockExportOptionsFuse',
+  'data': { 'mountpoint': 'str' },
+  'if': 'defined(CONFIG_FUSE)' }
+
 ##
 # @BlockExportType:
 #
@@ -181,10 +196,13 @@
 #
 # @nbd: NBD export
 #
+# @fuse: Fuse export (since: 5.2)
+#
 # Since: 4.2
 ##
 { 'enum': 'BlockExportType',
-  'data': [ 'nbd' ] }
+  'data': [ 'nbd',
+            { 'name': 'fuse', 'if': 'defined(CONFIG_FUSE)' } ] }
 
 ##
 # @BlockExportOptions:
@@ -213,7 +231,9 @@
             '*writethrough': 'bool' },
   'discriminator': 'type',
   'data': {
-      'nbd': 'BlockExportOptionsNbd'
+      'nbd': 'BlockExportOptionsNbd',
+      'fuse': { 'type': 'BlockExportOptionsFuse',
+                'if': 'defined(CONFIG_FUSE)' }
    } }
 
 ##
diff --git a/include/block/fuse.h b/include/block/fuse.h
new file mode 100644
index 0000000000..ffa91fe364
--- /dev/null
+++ b/include/block/fuse.h
@@ -0,0 +1,30 @@
+/*
+ * Present a block device as a raw image through FUSE
+ *
+ * Copyright (c) 2020 Max Reitz <mreitz@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; under version 2 or later of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef BLOCK_FUSE_H
+#define BLOCK_FUSE_H
+
+#ifdef CONFIG_FUSE
+
+#include "block/export.h"
+
+extern const BlockExportDriver blk_exp_fuse;
+
+#endif /* CONFIG_FUSE */
+
+#endif
diff --git a/block.c b/block.c
index acde53f92a..7bf45f6ede 100644
--- a/block.c
+++ b/block.c
@@ -26,6 +26,7 @@
 #include "block/trace.h"
 #include "block/block_int.h"
 #include "block/blockjob.h"
+#include "block/fuse.h"
 #include "block/nbd.h"
 #include "block/qdict.h"
 #include "qemu/error-report.h"
diff --git a/block/export/export.c b/block/export/export.c
index 64d39a6934..ba866d6ba7 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -16,6 +16,7 @@
 #include "block/block.h"
 #include "sysemu/block-backend.h"
 #include "block/export.h"
+#include "block/fuse.h"
 #include "block/nbd.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-block-export.h"
@@ -24,6 +25,9 @@
 
 static const BlockExportDriver *blk_exp_drivers[] = {
     &blk_exp_nbd,
+#ifdef CONFIG_FUSE
+    &blk_exp_fuse,
+#endif
 };
 
 /* Only accessed from the main thread */
diff --git a/block/export/fuse.c b/block/export/fuse.c
new file mode 100644
index 0000000000..75f11d2514
--- /dev/null
+++ b/block/export/fuse.c
@@ -0,0 +1,253 @@
+/*
+ * Present a block device as a raw image through FUSE
+ *
+ * Copyright (c) 2020 Max Reitz <mreitz@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; under version 2 or later of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define FUSE_USE_VERSION 31
+
+#include "qemu/osdep.h"
+#include "block/aio.h"
+#include "block/block.h"
+#include "block/export.h"
+#include "block/fuse.h"
+#include "block/qapi.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-block.h"
+#include "sysemu/block-backend.h"
+
+#include <fuse.h>
+#include <fuse_lowlevel.h>
+
+
+typedef struct FuseExport {
+    BlockExport common;
+
+    struct fuse_session *fuse_session;
+    struct fuse_buf fuse_buf;
+    bool mounted, fd_handler_set_up;
+
+    char *mountpoint;
+    bool writable;
+} FuseExport;
+
+static GHashTable *exports;
+static const struct fuse_lowlevel_ops fuse_ops;
+
+static void fuse_export_shutdown(BlockExport *exp);
+static void fuse_export_delete(BlockExport *exp);
+
+static void init_fuse(void);
+static int setup_fuse_export(FuseExport *exp, const char *mountpoint,
+                             Error **errp);
+static void read_from_fuse_export(void *opaque);
+
+static bool is_regular_file(const char *path, Error **errp);
+
+
+static int fuse_export_create(BlockExport *blk_exp,
+                              BlockExportOptions *blk_exp_args,
+                              Error **errp)
+{
+    FuseExport *exp = container_of(blk_exp, FuseExport, common);
+    BlockExportOptionsFuse *args = &blk_exp_args->u.fuse;
+    int ret;
+
+    assert(blk_exp_args->type == BLOCK_EXPORT_TYPE_FUSE);
+
+    init_fuse();
+
+    /*
+     * It is important to do this check before calling is_regular_file() --
+     * that function will do a stat(), which we would have to handle if we
+     * already exported something on @mountpoint.  But we cannot, because
+     * we are currently caught up here.
+     * (Note that ideally we would want to resolve relative paths here,
+     * but bdrv_make_absolute_filename() might do the wrong thing for
+     * paths that contain colons, and realpath() would resolve symlinks,
+     * which we do not want: The mount point is not going to be the
+     * symlink's destination, but the link itself.)
+     * So this will not catch all potential clashes, but hopefully at
+     * least the most common one of specifying exactly the same path
+     * string twice.
+     */
+    if (g_hash_table_contains(exports, args->mountpoint)) {
+        error_setg(errp, "There already is a FUSE export on '%s'",
+                   args->mountpoint);
+        ret = -EEXIST;
+        goto fail;
+    }
+
+    if (!is_regular_file(args->mountpoint, errp)) {
+        ret = -EINVAL;
+        goto fail;
+    }
+
+    exp->mountpoint = g_strdup(args->mountpoint);
+    exp->writable = blk_exp_args->writable;
+
+    ret = setup_fuse_export(exp, args->mountpoint, errp);
+    if (ret < 0) {
+        goto fail;
+    }
+
+    g_hash_table_insert(exports, g_strdup(args->mountpoint), NULL);
+    return 0;
+
+fail:
+    fuse_export_shutdown(blk_exp);
+    fuse_export_delete(blk_exp);
+    return ret;
+}
+
+/**
+ * Ensure that the global FUSE context is set up.
+ */
+static void init_fuse(void)
+{
+    if (exports) {
+        return;
+    }
+
+    exports = g_hash_table_new_full(g_str_hash, g_str_equal, g_free, NULL);
+}
+
+/**
+ * Create exp->fuse_session and mount it.
+ */
+static int setup_fuse_export(FuseExport *exp, const char *mountpoint,
+                             Error **errp)
+{
+    const char *fuse_argv[2];
+    struct fuse_args fuse_args;
+    int ret;
+
+    fuse_argv[0] = ""; /* Dummy program name */
+    fuse_argv[1] = NULL;
+    fuse_args = (struct fuse_args)FUSE_ARGS_INIT(1, (char **)fuse_argv);
+
+    exp->fuse_session = fuse_session_new(&fuse_args, &fuse_ops,
+                                         sizeof(fuse_ops), exp);
+    if (!exp->fuse_session) {
+        error_setg(errp, "Failed to set up FUSE session");
+        return -EIO;
+    }
+
+    ret = fuse_session_mount(exp->fuse_session, mountpoint);
+    if (ret < 0) {
+        error_setg(errp, "Failed to mount FUSE session to export");
+        return -EIO;
+    }
+    exp->mounted = true;
+
+    aio_set_fd_handler(exp->common.ctx,
+                       fuse_session_fd(exp->fuse_session), true,
+                       read_from_fuse_export, NULL, NULL, exp);
+    exp->fd_handler_set_up = true;
+
+    return 0;
+}
+
+/**
+ * Callback to be invoked when the FUSE session FD can be read from.
+ * (This is basically the FUSE event loop.)
+ */
+static void read_from_fuse_export(void *opaque)
+{
+    FuseExport *exp = opaque;
+    int ret;
+
+    blk_exp_ref(&exp->common);
+
+    ret = fuse_session_receive_buf(exp->fuse_session, &exp->fuse_buf);
+    if (ret < 0) {
+        goto out;
+    }
+
+    fuse_session_process_buf(exp->fuse_session, &exp->fuse_buf);
+
+out:
+    blk_exp_unref(&exp->common);
+}
+
+static void fuse_export_shutdown(BlockExport *blk_exp)
+{
+    FuseExport *exp = container_of(blk_exp, FuseExport, common);
+
+    if (exp->fuse_session) {
+        fuse_session_exit(exp->fuse_session);
+
+        if (exp->mounted) {
+            fuse_session_unmount(exp->fuse_session);
+            exp->mounted = false;
+        }
+
+        if (exp->fd_handler_set_up) {
+            aio_set_fd_handler(exp->common.ctx,
+                               fuse_session_fd(exp->fuse_session), true,
+                               NULL, NULL, NULL, NULL);
+            exp->fd_handler_set_up = false;
+        }
+
+        fuse_session_destroy(exp->fuse_session);
+        exp->fuse_session = NULL;
+    }
+
+    if (exp->mountpoint) {
+        g_hash_table_remove(exports, exp->mountpoint);
+    }
+}
+
+static void fuse_export_delete(BlockExport *blk_exp)
+{
+    FuseExport *exp = container_of(blk_exp, FuseExport, common);
+
+    free(exp->fuse_buf.mem);
+    g_free(exp->mountpoint);
+}
+
+/**
+ * Check whether @path points to a regular file.  If not, put an
+ * appropriate message into *errp.
+ */
+static bool is_regular_file(const char *path, Error **errp)
+{
+    struct stat statbuf;
+    int ret;
+
+    ret = stat(path, &statbuf);
+    if (ret < 0) {
+        error_setg_errno(errp, errno, "Failed to stat '%s'", path);
+        return false;
+    }
+
+    if (!S_ISREG(statbuf.st_mode)) {
+        error_setg(errp, "'%s' is not a regular file", path);
+        return false;
+    }
+
+    return true;
+}
+
+static const struct fuse_lowlevel_ops fuse_ops = {
+};
+
+const BlockExportDriver blk_exp_fuse = {
+    .type               = BLOCK_EXPORT_TYPE_FUSE,
+    .instance_size      = sizeof(FuseExport),
+    .create             = fuse_export_create,
+    .delete             = fuse_export_delete,
+    .request_shutdown   = fuse_export_shutdown,
+};
diff --git a/block/export/meson.build b/block/export/meson.build
index 558ef35d38..3f7f8c5263 100644
--- a/block/export/meson.build
+++ b/block/export/meson.build
@@ -1 +1,2 @@
 block_ss.add(files('export.c'))
+block_ss.add(when: ['CONFIG_FUSE', libfuse], if_true: files('fuse.c'))
-- 
2.26.2


