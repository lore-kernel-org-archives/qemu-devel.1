Received: from eggs.gnu.org ([2001:4830:134:3::10]:43209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBuq-0000c5-I1
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBup-00084Y-7n
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:44 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Feb 2017 15:58:22 +0100
Message-Id: <1487689130-30373-27-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 26/54] block: Add BDRV_O_RESIZE for
 blk_new_open()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

blk_new_open() is a convenience function that processes flags rather
than QDict options as a simple way to just open an image file.

In order to keep it convenient in the future, it must automatically
request the necessary permissions. This can easily be inferred from the
flags for read and write, but we need another flag that tells us whether
to get the resize permission.

We can't just always request it because that means that no block jobs
can run on the resulting BlockBackend (which is something that e.g.
qemu-img commit wants to do), but we also can't request it never because
most of the .bdrv_create() implementations call blk_truncate().

The solution is to introduce another flag that is passed by all users
that want to resize the image.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/parallels.c     | 3 ++-
 block/qcow.c          | 3 ++-
 block/qcow2.c         | 3 ++-
 block/qed.c           | 3 ++-
 block/vdi.c           | 3 ++-
 block/vhdx.c          | 3 ++-
 block/vmdk.c          | 6 ++++--
 block/vpc.c           | 3 ++-
 include/block/block.h | 1 +
 qemu-img.c            | 2 +-
 10 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 6b0c0a9..19935e2 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -488,7 +488,8 @@ static int parallels_create(const char *filename, QemuOpts *opts, Error **errp)
     }
 
     file = blk_new_open(filename, NULL, NULL,
-                        BDRV_O_RDWR | BDRV_O_PROTOCOL, &local_err);
+                        BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL,
+                        &local_err);
     if (file == NULL) {
         error_propagate(errp, local_err);
         return -EIO;
diff --git a/block/qcow.c b/block/qcow.c
index eb5d54c..9d6ac83 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -823,7 +823,8 @@ static int qcow_create(const char *filename, QemuOpts *opts, Error **errp)
     }
 
     qcow_blk = blk_new_open(filename, NULL, NULL,
-                            BDRV_O_RDWR | BDRV_O_PROTOCOL, &local_err);
+                            BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL,
+                            &local_err);
     if (qcow_blk == NULL) {
         error_propagate(errp, local_err);
         ret = -EIO;
diff --git a/block/qcow2.c b/block/qcow2.c
index 6f79df8..4ca9f24 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2266,7 +2266,8 @@ static int qcow2_create2(const char *filename, int64_t total_size,
     options = qdict_new();
     qdict_put(options, "driver", qstring_from_str("qcow2"));
     blk = blk_new_open(filename, NULL, options,
-                       BDRV_O_RDWR | BDRV_O_NO_FLUSH, &local_err);
+                       BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_NO_FLUSH,
+                       &local_err);
     if (blk == NULL) {
         error_propagate(errp, local_err);
         ret = -EIO;
diff --git a/block/qed.c b/block/qed.c
index d8f947a..5ec7fd8 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -625,7 +625,8 @@ static int qed_create(const char *filename, uint32_t cluster_size,
     }
 
     blk = blk_new_open(filename, NULL, NULL,
-                       BDRV_O_RDWR | BDRV_O_PROTOCOL, &local_err);
+                       BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL,
+                       &local_err);
     if (blk == NULL) {
         error_propagate(errp, local_err);
         return -EIO;
diff --git a/block/vdi.c b/block/vdi.c
index fd6e26d..9b4f70e 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -763,7 +763,8 @@ static int vdi_create(const char *filename, QemuOpts *opts, Error **errp)
     }
 
     blk = blk_new_open(filename, NULL, NULL,
-                       BDRV_O_RDWR | BDRV_O_PROTOCOL, &local_err);
+                       BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL,
+                       &local_err);
     if (blk == NULL) {
         error_propagate(errp, local_err);
         ret = -EIO;
diff --git a/block/vhdx.c b/block/vhdx.c
index ab747f6..052a753 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1859,7 +1859,8 @@ static int vhdx_create(const char *filename, QemuOpts *opts, Error **errp)
     }
 
     blk = blk_new_open(filename, NULL, NULL,
-                       BDRV_O_RDWR | BDRV_O_PROTOCOL, &local_err);
+                       BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL,
+                       &local_err);
     if (blk == NULL) {
         error_propagate(errp, local_err);
         ret = -EIO;
diff --git a/block/vmdk.c b/block/vmdk.c
index f5e2fb5..a9bd22b 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1703,7 +1703,8 @@ static int vmdk_create_extent(const char *filename, int64_t filesize,
     }
 
     blk = blk_new_open(filename, NULL, NULL,
-                       BDRV_O_RDWR | BDRV_O_PROTOCOL, &local_err);
+                       BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL,
+                       &local_err);
     if (blk == NULL) {
         error_propagate(errp, local_err);
         ret = -EIO;
@@ -2071,7 +2072,8 @@ static int vmdk_create(const char *filename, QemuOpts *opts, Error **errp)
     }
 
     new_blk = blk_new_open(filename, NULL, NULL,
-                           BDRV_O_RDWR | BDRV_O_PROTOCOL, &local_err);
+                           BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL,
+                           &local_err);
     if (new_blk == NULL) {
         error_propagate(errp, local_err);
         ret = -EIO;
diff --git a/block/vpc.c b/block/vpc.c
index b9c9832..f591d4b 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -915,7 +915,8 @@ static int vpc_create(const char *filename, QemuOpts *opts, Error **errp)
     }
 
     blk = blk_new_open(filename, NULL, NULL,
-                       BDRV_O_RDWR | BDRV_O_PROTOCOL, &local_err);
+                       BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL,
+                       &local_err);
     if (blk == NULL) {
         error_propagate(errp, local_err);
         ret = -EIO;
diff --git a/include/block/block.h b/include/block/block.h
index 2d6ed7d..701d22b 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -82,6 +82,7 @@ typedef struct HDGeometry {
 } HDGeometry;
 
 #define BDRV_O_RDWR        0x0002
+#define BDRV_O_RESIZE      0x0004 /* requests permission for resizing the node */
 #define BDRV_O_SNAPSHOT    0x0008 /* open the file read only and save writes in a snapshot */
 #define BDRV_O_TEMPORARY   0x0010 /* delete the file after use */
 #define BDRV_O_NOCACHE     0x0020 /* do not use the host page cache */
diff --git a/qemu-img.c b/qemu-img.c
index cff22e3..8d9195e 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3275,7 +3275,7 @@ static int img_resize(int argc, char **argv)
     qemu_opts_del(param);
 
     blk = img_open(image_opts, filename, fmt,
-                   BDRV_O_RDWR, false, quiet);
+                   BDRV_O_RDWR | BDRV_O_RESIZE, false, quiet);
     if (!blk) {
         ret = -1;
         goto out;
-- 
1.8.3.1
