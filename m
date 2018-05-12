Received: from eggs.gnu.org ([2001:4830:134:3::10]:40343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fHJIE-0006SR-Af
	for qemu-devel@nongnu.org; Fri, 11 May 2018 21:25:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fHJIB-0006Yr-Pt
	for qemu-devel@nongnu.org; Fri, 11 May 2018 21:25:50 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 11 May 2018 21:25:37 -0400
Message-Id: <20180512012537.22478-13-jsnow@redhat.com>
In-Reply-To: <20180512012537.22478-1-jsnow@redhat.com>
References: <20180512012537.22478-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 12/12] qemu-img: add bitmap clear
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qemu-img-cmds.hx |  4 ++--
 qemu-img.c       | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index d25f359f5a..7b6ec73488 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -23,9 +23,9 @@ STEXI
 ETEXI
 
 DEF("bitmap", img_bitmap,
-    "bitmap dump [--object objectdef] [--image-opts] [-f fmt] [--output=ofmt] [-U] filename [bitmap]")
+    "bitmap <dump|clear> [--object objectdef] [--image-opts] [-f fmt] [--output=ofmt] [-U] filename [bitmap]")
 STEXI
-@item bitmap dump [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--output=@var{ofmt}] [-U] @var{filename} [@var{bitmap}]
+@item bitmap <dump|clear> [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--output=@var{ofmt}] [-U] @var{filename} [@var{bitmap}]
 ETEXI
 
 DEF("check", img_check,
diff --git a/qemu-img.c b/qemu-img.c
index 1141216617..b5ab8a3837 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2967,7 +2967,22 @@ static void dump_bitmap_mapping(BitmapMapping *bm, OutputFormat output_format,
     }
 }
 
-/* img_bitmap subcommands: dump */
+static int do_bitmap_clear(BlockDriverState *bs, BdrvDirtyBitmap *bitmap)
+{
+    bool enabled = bdrv_dirty_bitmap_enabled(bitmap);
+
+    if (!enabled) {
+        bdrv_enable_dirty_bitmap(bitmap);
+    }
+    bdrv_clear_dirty_bitmap(bitmap, NULL);
+    if (!enabled) {
+        bdrv_disable_dirty_bitmap(bitmap);
+    }
+
+    return 0;
+}
+
+/* img_bitmap subcommands: dump, clear */
 
 typedef struct BitmapOpts {
     CommonOpts base;
@@ -3017,6 +3032,30 @@ static int bitmap_cmd_dump(BlockDriverState *bs, BitmapOpts *opts)
     return 0;
 }
 
+static int bitmap_cmd_clear(BlockDriverState *bs, BitmapOpts *opts)
+{
+    BdrvDirtyBitmap *bitmap = NULL;
+
+    if (opts->name) {
+        bitmap = bdrv_find_dirty_bitmap(bs, opts->name);
+        if (!bitmap) {
+            error_report("No bitmap named '%s' found", opts->name);
+            return -1;
+        }
+        if (do_bitmap_clear(bs, bitmap)) {
+            return -1;
+        }
+    } else {
+        while ((bitmap = bdrv_dirty_bitmap_next(bs, bitmap))) {
+            if (do_bitmap_clear(bs, bitmap)) {
+                return -1;
+            }
+        }
+    }
+
+    return 0;
+}
+
 static int img_bitmap(int argc, char **argv)
 {
     const char *cmd;
@@ -3029,12 +3068,15 @@ static int img_bitmap(int argc, char **argv)
     int (* handler)(BlockDriverState *b, BitmapOpts *opts);
 
     if (argc < 2) {
-        error_report("Expected a bitmap subcommand: <dump>");
+        error_report("Expected a bitmap subcommand: <dump | clear>");
         return EXIT_FAILURE;
     }
     cmd = argv[1];
     if (strcmp(cmd, "dump") == 0) {
         handler = bitmap_cmd_dump;
+    } else if (strcmp(cmd, "clear") == 0) {
+        flags |= BDRV_O_RDWR;
+        handler = bitmap_cmd_clear;
     } else {
         error_report("Unrecognized bitmap subcommand '%s'", cmd);
         return EXIT_FAILURE;
-- 
2.14.3
