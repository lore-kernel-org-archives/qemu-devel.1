Received: from eggs.gnu.org ([2001:4830:134:3::10]:43007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fBjd6-0003BX-0v
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:20:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fBjd3-0000dQ-Il
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:20:19 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Thu, 26 Apr 2018 19:19:42 +0300
Message-Id: <20180426161958.2872-2-rkagan@virtuozzo.com>
In-Reply-To: <20180426161958.2872-1-rkagan@virtuozzo.com>
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 01/17] block: iterate_format with account of
 whitelisting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

bdrv_iterate_format (which is currently only used for printing out the
formats supported by the block layer) doesn't take format whitelisting
into account.

As a result, QEMU lies when asked for the list of block drivers it
supports with "-drive format=?": some of the formats there may be
recognized by qemu-* tools but unusable in qemu proper.

To avoid that, exclude formats that are not whitelisted from
enumeration, if whitelisting is in use.  Since we have separate
whitelists for r/w and r/o, take this as a parameter to
bdrv_iterate_format, and print two lists of supported formats (r/w and
r/o) in main qemu.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 include/block/block.h |  2 +-
 block.c               | 23 +++++++++++++++++++----
 blockdev.c            |  4 +++-
 qemu-img.c            |  2 +-
 4 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index cdec3639a3..e60983248f 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -429,7 +429,7 @@ void bdrv_next_cleanup(BdrvNextIterator *it);
 BlockDriverState *bdrv_next_monitor_owned(BlockDriverState *bs);
 bool bdrv_is_encrypted(BlockDriverState *bs);
 void bdrv_iterate_format(void (*it)(void *opaque, const char *name),
-                         void *opaque);
+                         void *opaque, bool read_only);
 const char *bdrv_get_node_name(const BlockDriverState *bs);
 const char *bdrv_get_device_name(const BlockDriverState *bs);
 const char *bdrv_get_device_or_node_name(const BlockDriverState *bs);
diff --git a/block.c b/block.c
index a2caadf0a0..eaa73edc79 100644
--- a/block.c
+++ b/block.c
@@ -371,7 +371,7 @@ BlockDriver *bdrv_find_format(const char *format_name)
     return bdrv_do_find_format(format_name);
 }
 
-int bdrv_is_whitelisted(BlockDriver *drv, bool read_only)
+static int bdrv_format_is_whitelisted(const char *format_name, bool read_only)
 {
     static const char *whitelist_rw[] = {
         CONFIG_BDRV_RW_WHITELIST
@@ -386,13 +386,13 @@ int bdrv_is_whitelisted(BlockDriver *drv, bool read_only)
     }
 
     for (p = whitelist_rw; *p; p++) {
-        if (!strcmp(drv->format_name, *p)) {
+        if (!strcmp(format_name, *p)) {
             return 1;
         }
     }
     if (read_only) {
         for (p = whitelist_ro; *p; p++) {
-            if (!strcmp(drv->format_name, *p)) {
+            if (!strcmp(format_name, *p)) {
                 return 1;
             }
         }
@@ -400,6 +400,11 @@ int bdrv_is_whitelisted(BlockDriver *drv, bool read_only)
     return 0;
 }
 
+int bdrv_is_whitelisted(BlockDriver *drv, bool read_only)
+{
+    return bdrv_format_is_whitelisted(drv->format_name, read_only);
+}
+
 bool bdrv_uses_whitelist(void)
 {
     return use_bdrv_whitelist;
@@ -3886,7 +3891,7 @@ static int qsort_strcmp(const void *a, const void *b)
 }
 
 void bdrv_iterate_format(void (*it)(void *opaque, const char *name),
-                         void *opaque)
+                         void *opaque, bool read_only)
 {
     BlockDriver *drv;
     int count = 0;
@@ -3897,6 +3902,11 @@ void bdrv_iterate_format(void (*it)(void *opaque, const char *name),
         if (drv->format_name) {
             bool found = false;
             int i = count;
+
+            if (use_bdrv_whitelist && !bdrv_is_whitelisted(drv, read_only)) {
+                continue;
+            }
+
             while (formats && i && !found) {
                 found = !strcmp(formats[--i], drv->format_name);
             }
@@ -3915,6 +3925,11 @@ void bdrv_iterate_format(void (*it)(void *opaque, const char *name),
             bool found = false;
             int j = count;
 
+            if (use_bdrv_whitelist &&
+                !bdrv_format_is_whitelisted(format_name, read_only)) {
+                continue;
+            }
+
             while (formats && j && !found) {
                 found = !strcmp(formats[--j], format_name);
             }
diff --git a/blockdev.c b/blockdev.c
index c31bf3d98d..f43c6bcf27 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -530,7 +530,9 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
     if ((buf = qemu_opt_get(opts, "format")) != NULL) {
         if (is_help_option(buf)) {
             error_printf("Supported formats:");
-            bdrv_iterate_format(bdrv_format_print, NULL);
+            bdrv_iterate_format(bdrv_format_print, NULL, false);
+            error_printf("\nSupported formats (read-only):");
+            bdrv_iterate_format(bdrv_format_print, NULL, true);
             error_printf("\n");
             goto early_err;
         }
diff --git a/qemu-img.c b/qemu-img.c
index 855fa52514..a938cb253e 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -201,7 +201,7 @@ static void QEMU_NORETURN help(void)
            "  'skip=N' skip N bs-sized blocks at the start of input\n";
 
     printf("%s\nSupported formats:", help_msg);
-    bdrv_iterate_format(format_print, NULL);
+    bdrv_iterate_format(format_print, NULL, false);
     printf("\n\n" QEMU_HELP_BOTTOM "\n");
     exit(EXIT_SUCCESS);
 }
-- 
2.14.3
