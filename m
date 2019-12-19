Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6DAC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:40:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26C3E21D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUBPku5u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C3E21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwyp-000787-PV
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:40:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ihwwn-0004Xj-IC
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:38:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ihwwl-0004l6-DB
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:38:37 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25894
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ihwwl-0004iM-7N
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:38:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576766314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=coegx/pIA0zy5+KREfWxNhE3iKutdC0/rC+UH09VWA0=;
 b=LUBPku5uOXK8L1K5ygrO2VMcKlwqU8vckkxb4EKVbPPbtL8ZxtHEaAoN+NiDet+xQo/xdZ
 Cl1bWITn6XbTjcg8lleu7MU12YuMODPW+wTwzE2rOU5d38yE71o5sf8dVmx4PEXLiKInGY
 uA29aGpaTNcqgw0oqvRO8gWtjH037TA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-fgkZZZZoNr6opmvUjBAxAw-1; Thu, 19 Dec 2019 09:38:31 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F84B800D5A;
 Thu, 19 Dec 2019 14:38:30 +0000 (UTC)
Received: from localhost (ovpn-205-138.brq.redhat.com [10.40.205.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 04DB25DE52;
 Thu, 19 Dec 2019 14:38:27 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 02/18] fuse: Allow exporting BDSs via FUSE
Date: Thu, 19 Dec 2019 15:38:02 +0100
Message-Id: <20191219143818.1646168-3-mreitz@redhat.com>
In-Reply-To: <20191219143818.1646168-1-mreitz@redhat.com>
References: <20191219143818.1646168-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: fgkZZZZoNr6opmvUjBAxAw-1
X-Mimecast-Spam-Score: 0
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

fuse-export-add allows mounting block graph nodes via FUSE on some
existing regular file.  That file should then appears like a raw disk
image, and accesses to it result in accesses to the exported BDS.

Right now, we only set up the mount point and tear all mount points down
in bdrv_close_all().  We do not implement any access functions, so
accessing the mount point only results in errors.  This will be
addressed by a followup patch.

The set of exported nodes is kept in a hash table so we can later add a
fuse-export-remove that allows unmounting.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c              |   4 +
 block/Makefile.objs  |   3 +
 block/fuse.c         | 260 +++++++++++++++++++++++++++++++++++++++++++
 include/block/fuse.h |  24 ++++
 qapi/block.json      |  23 ++++
 5 files changed, 314 insertions(+)
 create mode 100644 block/fuse.c
 create mode 100644 include/block/fuse.h

diff --git a/block.c b/block.c
index c390ec6461..887c0b105e 100644
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
@@ -4077,6 +4078,9 @@ void bdrv_close_all(void)
 {
     assert(job_next(NULL) =3D=3D NULL);
     nbd_export_close_all();
+#ifdef CONFIG_FUSE
+    fuse_export_close_all();
+#endif
=20
     /* Drop references from requests still in flight, such as canceled blo=
ck
      * jobs whose AIO context has not been polled yet */
diff --git a/block/Makefile.objs b/block/Makefile.objs
index e394fe0b6c..b02846a6e7 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -43,6 +43,7 @@ block-obj-y +=3D crypto.o
=20
 block-obj-y +=3D aio_task.o
 block-obj-y +=3D backup-top.o
+block-obj-$(CONFIG_FUSE) +=3D fuse.o
=20
 common-obj-y +=3D stream.o
=20
@@ -67,3 +68,5 @@ qcow.o-libs        :=3D -lz
 linux-aio.o-libs   :=3D -laio
 parallels.o-cflags :=3D $(LIBXML2_CFLAGS)
 parallels.o-libs   :=3D $(LIBXML2_LIBS)
+fuse.o-cflags      :=3D $(FUSE_CFLAGS)
+fuse.o-libs        :=3D $(FUSE_LIBS)
diff --git a/block/fuse.c b/block/fuse.c
new file mode 100644
index 0000000000..3a22579dca
--- /dev/null
+++ b/block/fuse.c
@@ -0,0 +1,260 @@
+/*
+ * Present a block device as a raw image through FUSE
+ *
+ * Copyright (c) 2019 Max Reitz <mreitz@redhat.com>
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
+typedef struct BdrvFuseSession {
+    struct fuse_session *fuse_session;
+    struct fuse_buf fuse_buf;
+    BlockBackend *blk;
+    uint64_t perm, shared_perm;
+    bool mounted, fd_handler_set_up;
+    bool writable;
+} BdrvFuseSession;
+
+static GHashTable *sessions;
+static const struct fuse_lowlevel_ops fuse_ops;
+
+static void init_fuse(void);
+static int setup_fuse_session(BdrvFuseSession *session, const char *mountp=
oint,
+                              Error **errp);
+static void read_from_fuse_session(void *opaque);
+static void close_fuse_session(BdrvFuseSession *session);
+static void drop_fuse_session_from_hash_table(gpointer value);
+
+static bool is_regular_file(const char *path, Error **errp);
+
+
+void qmp_fuse_export_add(const char *node_name, const char *mountpoint,
+                         bool has_writable, bool writable,
+                         Error **errp)
+{
+    BlockDriverState *bs;
+    BdrvFuseSession *session =3D NULL;
+
+    if (!has_writable) {
+        writable =3D false;
+    }
+
+    init_fuse();
+
+    /*
+     * It is important to do this check before calling is_regular_file() -=
-
+     * that function will do a stat(), which we would have to handle if we
+     * already exported something on @mountpoint.  But we cannot, because
+     * we are currently caught up here.
+     */
+    if (g_hash_table_contains(sessions, mountpoint)) {
+        error_setg(errp, "There already is a FUSE export on '%s'", mountpo=
int);
+        goto fail;
+    }
+
+    if (!is_regular_file(mountpoint, errp)) {
+        goto fail;
+    }
+
+    bs =3D bdrv_find_node(node_name);
+    if (!bs) {
+        error_setg(errp, "Node '%s' not found", node_name);
+        goto fail;
+    }
+
+    session =3D g_new(BdrvFuseSession, 1);
+    *session =3D (BdrvFuseSession){
+        .fuse_buf =3D {
+            .mem =3D NULL,
+        },
+
+        .writable =3D writable,
+    };
+
+    session->perm =3D BLK_PERM_CONSISTENT_READ;
+    if (writable) {
+        session->perm |=3D BLK_PERM_WRITE;
+    }
+    session->shared_perm =3D BLK_PERM_ALL;
+
+    session->blk =3D blk_new(bdrv_get_aio_context(bs),
+                           session->perm, session->shared_perm);
+    if (blk_insert_bs(session->blk, bs, errp) < 0) {
+        goto fail;
+    }
+
+    if (setup_fuse_session(session, mountpoint, errp) < 0) {
+        goto fail;
+    }
+
+    g_hash_table_insert(sessions, g_strdup(mountpoint), session);
+    return;
+
+fail:
+    close_fuse_session(session);
+}
+
+/**
+ * Drop all FUSE exports.
+ */
+void fuse_export_close_all(void)
+{
+    if (sessions) {
+        g_hash_table_destroy(sessions);
+    }
+}
+
+
+/**
+ * Ensure that the global FUSE context is set up.
+ */
+static void init_fuse(void)
+{
+    if (sessions) {
+        return;
+    }
+
+    sessions =3D g_hash_table_new_full(g_str_hash, g_str_equal, g_free,
+                                     drop_fuse_session_from_hash_table);
+}
+
+/**
+ * Create session->fuse_session and mount it.
+ */
+static int setup_fuse_session(BdrvFuseSession *session, const char *mountp=
oint,
+                              Error **errp)
+{
+    const char *fuse_argv[2];
+    struct fuse_args fuse_args;
+    int ret;
+
+    fuse_argv[0] =3D ""; /* Dummy program name */
+    fuse_argv[1] =3D NULL;
+    fuse_args =3D (struct fuse_args)FUSE_ARGS_INIT(1, (char **)fuse_argv);
+
+    session->fuse_session =3D fuse_session_new(&fuse_args, &fuse_ops,
+                                             sizeof(fuse_ops), session);
+    if (!session->fuse_session) {
+        error_setg(errp, "Failed to set up FUSE session");
+        return -EIO;
+    }
+
+    ret =3D fuse_session_mount(session->fuse_session, mountpoint);
+    if (ret < 0) {
+        error_setg(errp, "Failed to mount FUSE session to export");
+        return -EIO;
+    }
+    session->mounted =3D true;
+
+    aio_set_fd_handler(blk_get_aio_context(session->blk),
+                       fuse_session_fd(session->fuse_session), true,
+                       read_from_fuse_session, NULL, NULL, session);
+    session->fd_handler_set_up =3D true;
+
+    return 0;
+}
+
+/**
+ * Callback to be invoked when the FUSE session FD can be read from.
+ * (This is basically the FUSE event loop.)
+ */
+static void read_from_fuse_session(void *opaque)
+{
+    BdrvFuseSession *session =3D opaque;
+    int ret;
+
+    ret =3D fuse_session_receive_buf(session->fuse_session, &session->fuse=
_buf);
+    if (ret < 0) {
+        return;
+    }
+
+    fuse_session_process_buf(session->fuse_session, &session->fuse_buf);
+}
+
+/**
+ * Drop a FUSE session (unmount it and free all associated resources).
+ * It is not removed from the @sessions hash table.
+ */
+static void close_fuse_session(BdrvFuseSession *session)
+{
+    if (!session) {
+        return;
+    }
+
+    if (session->fuse_session) {
+        if (session->mounted) {
+            fuse_session_unmount(session->fuse_session);
+        }
+        if (session->fd_handler_set_up) {
+            aio_set_fd_handler(blk_get_aio_context(session->blk),
+                               fuse_session_fd(session->fuse_session), tru=
e,
+                               NULL, NULL, NULL, NULL);
+        }
+        fuse_session_destroy(session->fuse_session);
+    }
+    blk_unref(session->blk);
+
+    g_free(session);
+}
+
+/**
+ * Wrapper around close_fuse_session() for use with
+ * g_hash_table_new_full().  This allows dropping sessions by removing
+ * them from the @sessions hash table.
+ */
+static void drop_fuse_session_from_hash_table(gpointer value)
+{
+    return close_fuse_session(value);
+}
+
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
+    ret =3D stat(path, &statbuf);
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
+static const struct fuse_lowlevel_ops fuse_ops =3D {
+};
diff --git a/include/block/fuse.h b/include/block/fuse.h
new file mode 100644
index 0000000000..1d24dded50
--- /dev/null
+++ b/include/block/fuse.h
@@ -0,0 +1,24 @@
+/*
+ * Present a block device as a raw image through FUSE
+ *
+ * Copyright (c) 2019 Max Reitz <mreitz@redhat.com>
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
+void fuse_export_close_all(void);
+
+#endif
diff --git a/qapi/block.json b/qapi/block.json
index 145c268bb6..03f8d1b537 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -317,6 +317,29 @@
 ##
 { 'command': 'nbd-server-stop' }
=20
+##
+# @fuse-export-add:
+#
+# Exports a block graph node on some (file) mountpoint as a raw image.
+#
+# @node-name: Node to be exported
+#
+# @mountpoint: Path on which to export the block device via FUSE.
+#              This must point to an existing regular file.
+#
+# @writable: Whether clients should be able to write to the block
+#            device via the FUSE export. (default: false)
+#
+# Since: 5.0
+##
+{ 'command': 'fuse-export-add',
+  'data': {
+      'node-name': 'str',
+      'mountpoint': 'str',
+      '*writable': 'bool'
+  },
+  'if': 'defined(CONFIG_FUSE)' }
+
 ##
 # @DEVICE_TRAY_MOVED:
 #
--=20
2.23.0


