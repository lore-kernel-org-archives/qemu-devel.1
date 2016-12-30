Received: from eggs.gnu.org ([2001:4830:134:3::10]:34035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cN0cp-00086j-Hh
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 12:05:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cN0cm-0005qf-C3
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 12:05:51 -0500
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Fri, 30 Dec 2016 17:31:25 +0300
Message-ID: <20161230143142.18214-2-pbutsykin@virtuozzo.com>
In-Reply-To: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
References: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 01/18] block/pcache: empty pcache driver
 filter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, eblake@redhat.com, armbru@redhat.com

The basic version of pcache driver for easy preparation of a patch set.

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
 block/Makefile.objs |   1 +
 block/pcache.c      | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)
 create mode 100644 block/pcache.c

diff --git a/block/Makefile.objs b/block/Makefile.objs
index 67a036a1df..0a024f4e66 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -4,6 +4,7 @@ block-obj-y += qed.o qed-gencb.o qed-l2-cache.o qed-table.o qed-cluster.o
 block-obj-y += qed-check.o
 block-obj-y += vhdx.o vhdx-endian.o vhdx-log.o
 block-obj-y += quorum.o
+block-obj-y += pcache.o
 block-obj-y += parallels.o blkdebug.o blkverify.o blkreplay.o
 block-obj-y += block-backend.o snapshot.o qapi.o
 block-obj-$(CONFIG_WIN32) += raw-win32.o win32-aio.o
diff --git a/block/pcache.c b/block/pcache.c
new file mode 100644
index 0000000000..7a67618408
--- /dev/null
+++ b/block/pcache.c
@@ -0,0 +1,102 @@
+/*
+ * Prefetch cache driver filter
+ *
+ * Copyright (C) 2015-2016 Parallels IP Holdings GmbH.
+ *
+ * Author: Pavel Butsykin <pbutsykin@virtuozzo.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "block/block_int.h"
+#include "qapi/error.h"
+#include "qapi/qmp/qstring.h"
+
+
+static QemuOptsList runtime_opts = {
+    .name = "pcache",
+    .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
+    .desc = {
+        { /* end of list */ }
+    },
+};
+
+static coroutine_fn int pcache_co_preadv(BlockDriverState *bs, uint64_t offset,
+                                         uint64_t bytes, QEMUIOVector *qiov,
+                                         int flags)
+{
+    return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
+}
+
+static coroutine_fn int pcache_co_pwritev(BlockDriverState *bs, uint64_t offset,
+                                          uint64_t bytes, QEMUIOVector *qiov,
+                                          int flags)
+{
+    return bdrv_co_pwritev(bs->file, offset, bytes, qiov, flags);
+}
+
+static int pcache_file_open(BlockDriverState *bs, QDict *options, int flags,
+                            Error **errp)
+{
+    QemuOpts *opts;
+    Error *local_err = NULL;
+    int ret = 0;
+
+    opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
+    qemu_opts_absorb_qdict(opts, options, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret = -EINVAL;
+        goto fail;
+    }
+
+    assert(bs->file == NULL);
+    bs->file = bdrv_open_child(NULL, options, "image", bs, &child_format,
+                               false, &local_err);
+    if (local_err) {
+        ret = -EINVAL;
+        error_propagate(errp, local_err);
+    }
+fail:
+    qemu_opts_del(opts);
+    return ret;
+}
+
+static void pcache_close(BlockDriverState *bs)
+{
+}
+
+static int64_t pcache_getlength(BlockDriverState *bs)
+{
+    return bdrv_getlength(bs->file->bs);
+}
+
+static bool pcache_recurse_is_first_non_filter(BlockDriverState *bs,
+                                               BlockDriverState *candidate)
+{
+    return bdrv_recurse_is_first_non_filter(bs->file->bs, candidate);
+}
+
+static BlockDriver bdrv_pcache = {
+    .format_name                        = "pcache",
+    .instance_size                      = 0,
+
+    .bdrv_file_open                     = pcache_file_open,
+    .bdrv_close                         = pcache_close,
+    .bdrv_getlength                     = pcache_getlength,
+
+    .bdrv_co_preadv                     = pcache_co_preadv,
+    .bdrv_co_pwritev                    = pcache_co_pwritev,
+
+    .is_filter                          = true,
+    .bdrv_recurse_is_first_non_filter   = pcache_recurse_is_first_non_filter,
+};
+
+static void bdrv_cache_init(void)
+{
+    bdrv_register(&bdrv_pcache);
+}
+
+block_init(bdrv_cache_init);
-- 
2.11.0
