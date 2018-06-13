Received: from eggs.gnu.org ([2001:4830:134:3::10]:44475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fT0Ul-0005iU-PZ
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 03:47:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fT0Uk-0006lp-Ou
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 03:47:07 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 13 Jun 2018 15:46:55 +0800
Message-Id: <20180613074655.16289-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] nvme: Support image creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Similar to the host_device's implementation, we check the requested
length against the namespace size.

Truncation is necessary to make qcow2 creation work.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/nvme.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/block/nvme.c b/block/nvme.c
index 6f71122bf5..ec3d18e790 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -21,6 +21,7 @@
 #include "qemu/option.h"
 #include "qemu/vfio-helpers.h"
 #include "block/block_int.h"
+#include "sysemu/block-backend.h"
 #include "trace.h"
 
 #include "block/nvme.h"
@@ -1154,6 +1155,73 @@ static void nvme_unregister_buf(BlockDriverState *bs, void *host)
     qemu_vfio_dma_unmap(s->vfio, host);
 }
 
+static QemuOptsList nvme_create_opts = {
+    .name = "nvme-create-opts",
+    .head = QTAILQ_HEAD_INITIALIZER(nvme_create_opts.head),
+    .desc = {
+        {
+            .name = BLOCK_OPT_SIZE,
+            .type = QEMU_OPT_SIZE,
+            .help = "Virtual disk size"
+        },
+        { /* end of list */ }
+    }
+};
+
+static int coroutine_fn nvme_co_create_opts(const char *filename, QemuOpts *opts,
+                                            Error **errp)
+{
+    int ret = 0;
+    BlockDriverState *bs = NULL;
+    int64_t size;
+
+    if (strncmp(filename, "nvme://", strlen("nvme://"))) {
+        error_setg(errp, "Invalid filename (must start with \"nvme://\")");
+        ret = -EINVAL;
+        goto out;
+    }
+
+    bs = bdrv_open(filename, NULL, NULL, BDRV_O_RDWR | BDRV_O_PROTOCOL, errp);
+    if (!bs) {
+        ret = -EINVAL;
+        goto out;
+    }
+
+    size = qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0);
+
+    if (size < 0 || bdrv_getlength(bs) < size) {
+        error_setg(errp, "Invalid image size");
+        ret = -EINVAL;
+    }
+
+out:
+    bdrv_unref(bs);
+    /* Hold breath for a little while before letting image format creation run.
+     * The problem is when testing with Intel P3700, the controller doesn't
+     * like the immediate open after close, as a result, nvme_init() will fail.
+     * This works around that.
+     **/
+    g_usleep(2000000);
+    return ret;
+}
+
+static int nvme_truncate(BlockDriverState *bs, int64_t offset,
+                         PreallocMode prealloc, Error **errp)
+{
+    if (prealloc != PREALLOC_MODE_OFF) {
+        error_setg(errp, "Preallocation mode '%s' unsupported",
+                   PreallocMode_str(prealloc));
+        return -ENOTSUP;
+    }
+
+    if (offset > nvme_getlength(bs)) {
+        error_setg(errp, "Cannot grow device files");
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
 static BlockDriver bdrv_nvme = {
     .format_name              = "nvme",
     .protocol_name            = "nvme",
@@ -1180,6 +1248,10 @@ static BlockDriver bdrv_nvme = {
 
     .bdrv_register_buf        = nvme_register_buf,
     .bdrv_unregister_buf      = nvme_unregister_buf,
+
+    .create_opts              = &nvme_create_opts,
+    .bdrv_co_create_opts      = nvme_co_create_opts,
+    .bdrv_truncate            = nvme_truncate,
 };
 
 static void bdrv_nvme_init(void)
-- 
2.17.0
