Received: from eggs.gnu.org ([209.51.188.92]:59343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5V-0008BV-GX
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:58:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5S-0005ju-GC
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:58:57 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  8 Mar 2019 13:57:54 +0100
Message-Id: <20190308125823.32535-5-kwolf@redhat.com>
In-Reply-To: <20190308125823.32535-1-kwolf@redhat.com>
References: <20190308125823.32535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/33] block: iterate_format with account of
 whitelisting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

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
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h |  2 +-
 block.c               | 23 +++++++++++++++++++----
 blockdev.c            |  4 +++-
 qemu-img.c            |  2 +-
 4 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 5b5cf868df..6a758a76f8 100644
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
diff --git a/block.c b/block.c
index 35e78e2172..ccf008c177 100644
--- a/block.c
+++ b/block.c
@@ -426,7 +426,7 @@ BlockDriver *bdrv_find_format(const char *format_name=
)
     return bdrv_do_find_format(format_name);
 }
=20
-int bdrv_is_whitelisted(BlockDriver *drv, bool read_only)
+static int bdrv_format_is_whitelisted(const char *format_name, bool read=
_only)
 {
     static const char *whitelist_rw[] =3D {
         CONFIG_BDRV_RW_WHITELIST
@@ -441,13 +441,13 @@ int bdrv_is_whitelisted(BlockDriver *drv, bool read=
_only)
     }
=20
     for (p =3D whitelist_rw; *p; p++) {
-        if (!strcmp(drv->format_name, *p)) {
+        if (!strcmp(format_name, *p)) {
             return 1;
         }
     }
     if (read_only) {
         for (p =3D whitelist_ro; *p; p++) {
-            if (!strcmp(drv->format_name, *p)) {
+            if (!strcmp(format_name, *p)) {
                 return 1;
             }
         }
@@ -455,6 +455,11 @@ int bdrv_is_whitelisted(BlockDriver *drv, bool read_=
only)
     return 0;
 }
=20
+int bdrv_is_whitelisted(BlockDriver *drv, bool read_only)
+{
+    return bdrv_format_is_whitelisted(drv->format_name, read_only);
+}
+
 bool bdrv_uses_whitelist(void)
 {
     return use_bdrv_whitelist;
@@ -4147,7 +4152,7 @@ static int qsort_strcmp(const void *a, const void *=
b)
 }
=20
 void bdrv_iterate_format(void (*it)(void *opaque, const char *name),
-                         void *opaque)
+                         void *opaque, bool read_only)
 {
     BlockDriver *drv;
     int count =3D 0;
@@ -4158,6 +4163,11 @@ void bdrv_iterate_format(void (*it)(void *opaque, =
const char *name),
         if (drv->format_name) {
             bool found =3D false;
             int i =3D count;
+
+            if (use_bdrv_whitelist && !bdrv_is_whitelisted(drv, read_onl=
y)) {
+                continue;
+            }
+
             while (formats && i && !found) {
                 found =3D !strcmp(formats[--i], drv->format_name);
             }
@@ -4176,6 +4186,11 @@ void bdrv_iterate_format(void (*it)(void *opaque, =
const char *name),
             bool found =3D false;
             int j =3D count;
=20
+            if (use_bdrv_whitelist &&
+                !bdrv_format_is_whitelisted(format_name, read_only)) {
+                continue;
+            }
+
             while (formats && j && !found) {
                 found =3D !strcmp(formats[--j], format_name);
             }
diff --git a/blockdev.c b/blockdev.c
index 7e6bf9955c..871966ca13 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -531,7 +531,9 @@ static BlockBackend *blockdev_init(const char *file, =
QDict *bs_opts,
     if ((buf =3D qemu_opt_get(opts, "format")) !=3D NULL) {
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
index 660c01898e..5fac840742 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -198,7 +198,7 @@ static void QEMU_NORETURN help(void)
            "  'skip=3DN' skip N bs-sized blocks at the start of input\n"=
;
=20
     printf("%s\nSupported formats:", help_msg);
-    bdrv_iterate_format(format_print, NULL);
+    bdrv_iterate_format(format_print, NULL, false);
     printf("\n\n" QEMU_HELP_BOTTOM "\n");
     exit(EXIT_SUCCESS);
 }
--=20
2.20.1
