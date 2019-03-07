Received: from eggs.gnu.org ([209.51.188.92]:60413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1h1t9w-0002LW-Sf
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:34:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1h1t9v-0003LV-Ua
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:34:04 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Thu,  7 Mar 2019 16:33:58 +0300
Message-Id: <1551965640-164939-3-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1551965640-164939-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1551965640-164939-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 2/4] block: iterate_format with account of
 whitelisting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, rkagan@virtuozzo.com, andrey.shinkevich@virtuozzo.com

bdrv_iterate_format (which is currently only used for printing out the
formats supported by the block layer) doesn't take format whitelisting
into account.

This creates a problem for tests: they enumerate supported formats to
decide which tests to enable, but then discover that QEMU doesn't let
them actually use some of those formats.

To avoid that, exclude formats that are not whitelisted from
enumeration, if whitelisting is in use.  Since we have separate
whitelists for r/w and r/o, take this a parameter to
bdrv_iterate_format, and print two lists of supported formats (r/w and
r/o) in main qemu.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block.c               | 23 +++++++++++++++++++----
 blockdev.c            |  4 +++-
 include/block/block.h |  2 +-
 qemu-img.c            |  2 +-
 4 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/block.c b/block.c
index 35e78e2..ccf008c 100644
--- a/block.c
+++ b/block.c
@@ -426,7 +426,7 @@ BlockDriver *bdrv_find_format(const char *format_name)
     return bdrv_do_find_format(format_name);
 }
 
-int bdrv_is_whitelisted(BlockDriver *drv, bool read_only)
+static int bdrv_format_is_whitelisted(const char *format_name, bool read_only)
 {
     static const char *whitelist_rw[] = {
         CONFIG_BDRV_RW_WHITELIST
@@ -441,13 +441,13 @@ int bdrv_is_whitelisted(BlockDriver *drv, bool read_only)
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
@@ -455,6 +455,11 @@ int bdrv_is_whitelisted(BlockDriver *drv, bool read_only)
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
@@ -4147,7 +4152,7 @@ static int qsort_strcmp(const void *a, const void *b)
 }
 
 void bdrv_iterate_format(void (*it)(void *opaque, const char *name),
-                         void *opaque)
+                         void *opaque, bool read_only)
 {
     BlockDriver *drv;
     int count = 0;
@@ -4158,6 +4163,11 @@ void bdrv_iterate_format(void (*it)(void *opaque, const char *name),
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
@@ -4176,6 +4186,11 @@ void bdrv_iterate_format(void (*it)(void *opaque, const char *name),
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
index 7e6bf99..871966c 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -531,7 +531,9 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
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
diff --git a/include/block/block.h b/include/block/block.h
index 5b5cf86..6a758a7 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -472,7 +472,7 @@ void bdrv_next_cleanup(BdrvNextIterator *it);
 BlockDriverState *bdrv_next_monitor_owned(BlockDriverState *bs);
 bool bdrv_is_encrypted(BlockDriverState *bs);
 void bdrv_iterate_format(void (*it)(void *opaque, const char *name),
-                         void *opaque);
+                         void *opaque, bool read_only);
 const char *bdrv_get_node_name(const BlockDriverState *bs);
 const char *bdrv_get_device_name(const BlockDriverState *bs);
 const char *bdrv_get_device_or_node_name(const BlockDriverState *bs);
diff --git a/qemu-img.c b/qemu-img.c
index 660c018..5fac840 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -198,7 +198,7 @@ static void QEMU_NORETURN help(void)
            "  'skip=N' skip N bs-sized blocks at the start of input\n";
 
     printf("%s\nSupported formats:", help_msg);
-    bdrv_iterate_format(format_print, NULL);
+    bdrv_iterate_format(format_print, NULL, false);
     printf("\n\n" QEMU_HELP_BOTTOM "\n");
     exit(EXIT_SUCCESS);
 }
-- 
1.8.3.1
