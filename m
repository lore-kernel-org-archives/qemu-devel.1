Received: from eggs.gnu.org ([2001:4830:134:3::10]:57549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g8Zj0-0003j0-CG
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 19:41:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g8Ziw-0000bH-GR
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 19:41:36 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Sat,  6 Oct 2018 01:40:18 +0200
Message-Id: <20181005234023.8104-27-mreitz@redhat.com>
In-Reply-To: <20181005234023.8104-1-mreitz@redhat.com>
References: <20181005234023.8104-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v11 26/31] block/nvme: Fix
 bdrv_refresh_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

Currently, nvme's bdrv_refresh_filename() is an exact copy of null's
implementation.  However, for null, "null-co://" and "null-aio://" are
indeed valid filenames -- for nvme, they are not, as a device address is
still required.

The correct implementation should generate a filename of the form
"nvme://[PCI address]/[namespace]" (as the comment above
nvme_parse_filename() describes).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/nvme.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 0df7cb30fb..860a3d7113 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -111,6 +111,9 @@ typedef struct {
 
     /* Total size of mapped qiov, accessed under dma_map_lock */
     int dma_map_count;
+
+    /* PCI address (required for nvme_refresh_filename()) */
+    char *device;
 } BDRVNVMeState;
 
 #define NVME_BLOCK_OPT_DEVICE "device"
@@ -558,6 +561,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
 
     qemu_co_mutex_init(&s->dma_map_lock);
     qemu_co_queue_init(&s->dma_flush_queue);
+    s->device = g_strdup(device);
     s->nsid = namespace;
     s->aio_context = bdrv_get_aio_context(bs);
     ret = event_notifier_init(&s->irq_notifier, 0);
@@ -730,6 +734,8 @@ static void nvme_close(BlockDriverState *bs)
     event_notifier_cleanup(&s->irq_notifier);
     qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs, 0, NVME_BAR_SIZE);
     qemu_vfio_close(s->vfio);
+
+    g_free(s->device);
 }
 
 static int nvme_file_open(BlockDriverState *bs, QDict *options, int flags,
@@ -1060,21 +1066,10 @@ static int nvme_reopen_prepare(BDRVReopenState *reopen_state,
 
 static void nvme_refresh_filename(BlockDriverState *bs)
 {
-    const QDictEntry *e;
-
-    for (e = qdict_first(bs->full_open_options); e;
-         e = qdict_next(bs->full_open_options, e))
-    {
-        /* These options can be ignored */
-        if (strcmp(qdict_entry_key(e), "filename") &&
-            strcmp(qdict_entry_key(e), "driver"))
-        {
-            return;
-        }
-    }
+    BDRVNVMeState *s = bs->opaque;
 
-    snprintf(bs->exact_filename, sizeof(bs->exact_filename), "%s://",
-             bs->drv->format_name);
+    snprintf(bs->exact_filename, sizeof(bs->exact_filename), "nvme://%s/%i",
+             s->device, s->nsid);
 }
 
 static void nvme_refresh_limits(BlockDriverState *bs, Error **errp)
-- 
2.17.1
