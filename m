Received: from eggs.gnu.org ([2001:4830:134:3::10]:42852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e7r7t-0001tc-Ve
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 18:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e7r7r-0002Mv-Ft
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 18:59:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1e7r7r-0002Kx-6u
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 18:59:47 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Thu, 26 Oct 2017 15:59:41 -0700
Message-Id: <1509058783-25851-1-git-send-email-sstabellini@kernel.org>
In-Reply-To: <alpine.DEB.2.10.1710261556510.3086@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1710261556510.3086@sstabellini-ThinkPad-X260>
Subject: [Qemu-devel] [PULL 1/3] xen: add a global indicator for grant copy
 being available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: stefanha@gmail.com, sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Juergen Gross <jgross@suse.com>

From: Juergen Gross <jgross@suse.com>

The Xen qdisk backend needs to test whether grant copy operations is
available in the kernel. Unfortunately this collides with using
xengnttab_set_max_grants() on some kernels as this operation has to
be the first one after opening the gnttab device.

In order to solve this problem test for the availability of grant copy
in xen_be_init() opening the gnttab device just for that purpose and
closing it again afterwards. Advertise the availability via a global
flag and use that flag in the qdisk backend.

Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/block/xen_disk.c          | 18 ++++++------------
 hw/xen/xen_backend.c         | 11 +++++++++++
 include/hw/xen/xen_backend.h |  1 +
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
index 536e2ee..62506e3 100644
--- a/hw/block/xen_disk.c
+++ b/hw/block/xen_disk.c
@@ -121,9 +121,6 @@ struct XenBlkDev {
     unsigned int        persistent_gnt_count;
     unsigned int        max_grants;
 
-    /* Grant copy */
-    gboolean            feature_grant_copy;
-
     /* qemu block driver */
     DriveInfo           *dinfo;
     BlockBackend        *blk;
@@ -616,7 +613,7 @@ static void qemu_aio_complete(void *opaque, int ret)
         return;
     }
 
-    if (ioreq->blkdev->feature_grant_copy) {
+    if (xen_feature_grant_copy) {
         switch (ioreq->req.operation) {
         case BLKIF_OP_READ:
             /* in case of failure ioreq->aio_errors is increased */
@@ -638,7 +635,7 @@ static void qemu_aio_complete(void *opaque, int ret)
     }
 
     ioreq->status = ioreq->aio_errors ? BLKIF_RSP_ERROR : BLKIF_RSP_OKAY;
-    if (!ioreq->blkdev->feature_grant_copy) {
+    if (!xen_feature_grant_copy) {
         ioreq_unmap(ioreq);
     }
     ioreq_finish(ioreq);
@@ -698,7 +695,7 @@ static int ioreq_runio_qemu_aio(struct ioreq *ioreq)
 {
     struct XenBlkDev *blkdev = ioreq->blkdev;
 
-    if (ioreq->blkdev->feature_grant_copy) {
+    if (xen_feature_grant_copy) {
         ioreq_init_copy_buffers(ioreq);
         if (ioreq->req.nr_segments && (ioreq->req.operation == BLKIF_OP_WRITE ||
             ioreq->req.operation == BLKIF_OP_FLUSH_DISKCACHE) &&
@@ -750,7 +747,7 @@ static int ioreq_runio_qemu_aio(struct ioreq *ioreq)
     }
     default:
         /* unknown operation (shouldn't happen -- parse catches this) */
-        if (!ioreq->blkdev->feature_grant_copy) {
+        if (!xen_feature_grant_copy) {
             ioreq_unmap(ioreq);
         }
         goto err;
@@ -1010,18 +1007,15 @@ static int blk_init(struct XenDevice *xendev)
 
     blkdev->file_blk  = BLOCK_SIZE;
 
-    blkdev->feature_grant_copy =
-                (xengnttab_grant_copy(blkdev->xendev.gnttabdev, 0, NULL) == 0);
-
     xen_pv_printf(&blkdev->xendev, 3, "grant copy operation %s\n",
-                  blkdev->feature_grant_copy ? "enabled" : "disabled");
+                  xen_feature_grant_copy ? "enabled" : "disabled");
 
     /* fill info
      * blk_connect supplies sector-size and sectors
      */
     xenstore_write_be_int(&blkdev->xendev, "feature-flush-cache", 1);
     xenstore_write_be_int(&blkdev->xendev, "feature-persistent",
-                          !blkdev->feature_grant_copy);
+                          !xen_feature_grant_copy);
     xenstore_write_be_int(&blkdev->xendev, "info", info);
 
     xenstore_write_be_int(&blkdev->xendev, "max-ring-page-order",
diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
index c46cbb0..0f849a2 100644
--- a/hw/xen/xen_backend.c
+++ b/hw/xen/xen_backend.c
@@ -44,6 +44,7 @@ BusState *xen_sysbus;
 /* public */
 struct xs_handle *xenstore = NULL;
 const char *xen_protocol;
+bool xen_feature_grant_copy;
 
 /* private */
 static int debug;
@@ -519,6 +520,8 @@ void xenstore_update_fe(char *watch, struct XenDevice *xendev)
 
 int xen_be_init(void)
 {
+    xengnttab_handle *gnttabdev;
+
     xenstore = xs_daemon_open();
     if (!xenstore) {
         xen_pv_printf(NULL, 0, "can't connect to xenstored\n");
@@ -532,6 +535,14 @@ int xen_be_init(void)
         goto err;
     }
 
+    gnttabdev = xengnttab_open(NULL, 0);
+    if (gnttabdev != NULL) {
+        if (xengnttab_grant_copy(gnttabdev, 0, NULL) == 0) {
+            xen_feature_grant_copy = true;
+        }
+        xengnttab_close(gnttabdev);
+    }
+
     xen_sysdev = qdev_create(NULL, TYPE_XENSYSDEV);
     qdev_init_nofail(xen_sysdev);
     xen_sysbus = qbus_create(TYPE_XENSYSBUS, DEVICE(xen_sysdev), "xen-sysbus");
diff --git a/include/hw/xen/xen_backend.h b/include/hw/xen/xen_backend.h
index 8a6fbcb..3a27692 100644
--- a/include/hw/xen/xen_backend.h
+++ b/include/hw/xen/xen_backend.h
@@ -16,6 +16,7 @@
 /* variables */
 extern struct xs_handle *xenstore;
 extern const char *xen_protocol;
+extern bool xen_feature_grant_copy;
 extern DeviceState *xen_sysdev;
 extern BusState *xen_sysbus;
 
-- 
1.9.1
