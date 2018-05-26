Received: from eggs.gnu.org ([2001:4830:134:3::10]:35703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fMRgQ-0006C9-Up
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:24:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fMRgQ-0004TN-3f
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:24:02 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:38176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fMRgP-0004TF-Vl
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:24:02 -0400
Received: by mail-qt0-x244.google.com with SMTP id m9-v6so9187789qtb.5
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 22:24:01 -0700 (PDT)
From: keno@juliacomputing.com
Date: Sat, 26 May 2018 01:23:04 -0400
Message-Id: <a6ce15881bf120c8df68acfff6f2bd9c0745007b.1527310210.git.keno@alumni.harvard.edu>
In-Reply-To: <cover.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
In-Reply-To: <cover.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
Subject: [Qemu-devel] [PATCH 02/13] 9p: Avoid warning if FS_IOC_GETVERSION
 is not defined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Keno Fischer <keno@alumni.harvard.edu>, groug@kaod.org, Keno Fischer <keno@juliacomputing.com>

From: Keno Fischer <keno@alumni.harvard.edu>

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---
 hw/9pfs/9p-local.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index f6c7526..7592f8d 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1375,10 +1375,10 @@ static int local_unlinkat(FsContext *ctx, V9fsPath *dir,
     return ret;
 }
 
+#ifdef FS_IOC_GETVERSION
 static int local_ioc_getversion(FsContext *ctx, V9fsPath *path,
                                 mode_t st_mode, uint64_t *st_gen)
 {
-#ifdef FS_IOC_GETVERSION
     int err;
     V9fsFidOpenState fid_open;
 
@@ -1397,15 +1397,11 @@ static int local_ioc_getversion(FsContext *ctx, V9fsPath *path,
     err = ioctl(fid_open.fd, FS_IOC_GETVERSION, st_gen);
     local_close(ctx, &fid_open);
     return err;
-#else
-    errno = ENOTTY;
-    return -1;
-#endif
 }
+#endif
 
 static int local_init(FsContext *ctx, Error **errp)
 {
-    struct statfs stbuf;
     LocalData *data = g_malloc(sizeof(*data));
 
     data->mountfd = open(ctx->fs_root, O_DIRECTORY | O_RDONLY);
@@ -1415,20 +1411,23 @@ static int local_init(FsContext *ctx, Error **errp)
     }
 
 #ifdef FS_IOC_GETVERSION
-    /*
-     * use ioc_getversion only if the ioctl is definied
-     */
-    if (fstatfs(data->mountfd, &stbuf) < 0) {
-        close_preserve_errno(data->mountfd);
-        goto err;
-    }
-    switch (stbuf.f_type) {
-    case EXT2_SUPER_MAGIC:
-    case BTRFS_SUPER_MAGIC:
-    case REISERFS_SUPER_MAGIC:
-    case XFS_SUPER_MAGIC:
-        ctx->exops.get_st_gen = local_ioc_getversion;
-        break;
+    {
+        struct statfs stbuf;
+        /*
+        * use ioc_getversion only if the ioctl is definied
+        */
+        if (fstatfs(data->mountfd, &stbuf) < 0) {
+            close_preserve_errno(data->mountfd);
+            goto err;
+        }
+        switch (stbuf.f_type) {
+        case EXT2_SUPER_MAGIC:
+        case BTRFS_SUPER_MAGIC:
+        case REISERFS_SUPER_MAGIC:
+        case XFS_SUPER_MAGIC:
+            ctx->exops.get_st_gen = local_ioc_getversion;
+            break;
+        }
     }
 #endif
 
-- 
2.8.1
