Received: from eggs.gnu.org ([2001:4830:134:3::10]:42055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mahaocong_work@163.com>) id 1fzeBG-0003YI-Iw
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 04:37:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mahaocong_work@163.com>) id 1fzeBD-000698-CE
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 04:37:54 -0400
From: Ma Haocong <mahaocong_work@163.com>
Date: Tue, 11 Sep 2018 16:37:06 +0800
Message-Id: <20180911083706.5378-2-mahaocong_work@163.com>
In-Reply-To: <20180911083706.5378-1-mahaocong_work@163.com>
References: <20180911083706.5378-1-mahaocong_work@163.com>
Subject: [Qemu-devel] [PATCH v1 1/1] qemu-img: add new function to remove
 bitmap in image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Ma Haocong <mahaocong_work@163.com>

Signed-off-by: Ma Haocong <mahaocong_work@163.com>
---
 qemu-img-cmds.hx |   6 +++
 qemu-img.c       | 119 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+)

diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 1526f327a5..cc397b64e4 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -97,6 +97,12 @@ STEXI
 @item resize [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--preallocation=@var{prealloc}] [-q] [--shrink] @var{filename} [+ | -]@var{size}
 ETEXI
 
+DEF("removebmp", img_removebmp,
+    "removebmp [--object objectdef] [--image-opts] [-q] [-f fmt] filename dirtybitmap")
+STEXI
+@item removebmp [--object @var{objectdef}] [--image-opts] [-q] [-f @var{fmt}] @var{filename} @var{dirtybitmap}
+ETEXI
+
 STEXI
 @end table
 ETEXI
diff --git a/qemu-img.c b/qemu-img.c
index b12f4cd19b..fdafb4a131 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -835,6 +835,125 @@ fail:
     return ret;
 }
 
+/*
+ * Remove a named dirty bitmap in image.
+ * This command should be used with no other QEMU process
+ * open the image at the same time. Otherwise it may be
+ * croputed the bitmap even the image.
+ */
+static int img_removebmp(int argc, char **argv)
+{
+    int               c, ret;
+    const char       *filename, *fmt, *bitmapname;
+    bool              quiet = false;
+    BlockBackend     *blk;
+    BlockDriverState *bs;
+    BdrvDirtyBitmap  *bitmap;
+    Error            *local_err = NULL;
+    bool image_opts = false;
+    fmt = NULL;
+
+    for (;;) {
+        int option_index = 0;
+        static const struct option long_options[] = {
+            {"help", no_argument, 0, 'h'},
+            {"format", required_argument, 0, 'f'},
+            {"object", required_argument, 0, OPTION_OBJECT},
+            {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {0, 0, 0, 0}
+        };
+        c = getopt_long(argc, argv, ":hf:q",
+                        long_options, &option_index);
+        if (c == -1) {
+            break;
+        }
+        switch (c) {
+        case ':':
+            missing_argument(argv[optind - 1]);
+            break;
+        case '?':
+            unrecognized_option(argv[optind - 1]);
+            break;
+        case 'h':
+            help();
+            break;
+        case 'f':
+            fmt = optarg;
+            break;
+        case 'q':
+            quiet = true;
+            break;
+        case OPTION_OBJECT: {
+            QemuOpts *opts;
+            opts = qemu_opts_parse_noisily(&qemu_object_opts,
+                                           optarg, true);
+            if (!opts) {
+                return 1;
+            }
+        }   break;
+        case OPTION_IMAGE_OPTS:
+            image_opts = true;
+            break;
+        }
+    }
+
+    if (optind != argc - 2) {
+        error_exit("Expecting two parameters");
+    }
+    filename = argv[optind++];
+    bitmapname = argv[optind++];
+
+    if (qemu_opts_foreach(&qemu_object_opts,
+                          user_creatable_add_opts_foreach,
+                          NULL, NULL)) {
+        return 1;
+    }
+
+    blk = img_open(image_opts, filename, fmt,
+                   BDRV_O_RDWR, false, quiet, false);
+    if (!blk) {
+        ret = -1;
+        goto out;
+    }
+    bs = blk_bs(blk);
+    if (!bs) {
+        ret = -1;
+        goto out;
+    }
+
+    bitmap = bdrv_find_dirty_bitmap(bs, bitmapname);
+
+    /*
+     * Dirty bitmap may not be load if the 'IN_USE' flag is set (e.g. the
+     * qemu thread is corrupted and the 'IN_USE' flag is not be cleared),
+     * so the result of bdrv_find_dirty_bitmap is null. In this case,
+     * we delete bitmap in qcow2 file directly.
+    */
+    if (!bitmap) {
+        bdrv_remove_persistent_dirty_bitmap(bs, bitmapname, &local_err);
+        if (local_err != NULL) {
+            ret = -1;
+            goto out;
+        }
+    } else {
+        if (bdrv_dirty_bitmap_get_persistance(bitmap)) {
+            bdrv_remove_persistent_dirty_bitmap(bs, bitmapname, &local_err);
+            if (local_err != NULL) {
+                ret = -1;
+                goto out;
+            }
+        }
+        bdrv_release_dirty_bitmap(bs, bitmap);
+    }
+
+out:
+    blk_unref(blk);
+    if (ret) {
+        return 1;
+    }
+    return 0;
+}
+
 typedef struct CommonBlockJobCBInfo {
     BlockDriverState *bs;
     Error **errp;
-- 
2.14.1
