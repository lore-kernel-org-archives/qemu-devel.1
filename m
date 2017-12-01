Received: from eggs.gnu.org ([2001:4830:134:3::10]:55946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1eKv4N-0004IV-F7
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 18:50:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1eKv4M-0008NX-MV
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 18:50:11 -0500
From: Klim Kireev <klim.kireev@virtuozzo.com>
Date: Sat, 2 Dec 2017 02:49:43 +0300
Message-ID: <20171201234943.14695-1-klim.kireev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3] qemu-img: add the simplest format
 recognition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: den@openvz.org, vsementsov@virtuozzo.com, klim.kireev@virtuozzo.com

Now, if you type something like

qemu-img create disk.qcow2 1G
or
qemu-img dd if=/dev/sda of=disk.qcow2

it creates a raw image and if you need you should
manually specify an image format with -f qcow2. It would
be more convenient if it could be assumed from an extension.

This patch adds a simple heuristic to recognize the image format
for qcow, qcow2, vmdk, vhdx, vdi

It warns users about guessed format and informs them about '-f' option.

Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
---
 qemu-img.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 02a6e27beb..4ec04f5c86 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -421,11 +421,21 @@ static int64_t cvtnum(const char *s)
     return value;
 }
 
+static const char *get_format(const char *filename)
+{
+    const char *fmt = strrchr(filename, '.');
+    if (fmt == NULL || bdrv_find_format(++fmt) == NULL) {
+        fmt = "raw";
+    }
+    warn_report("No format specified with -f, assuming %s.", fmt);
+    return fmt;
+}
+
 static int img_create(int argc, char **argv)
 {
     int c;
     uint64_t img_size = -1;
-    const char *fmt = "raw";
+    const char *fmt = NULL;
     const char *base_fmt = NULL;
     const char *filename;
     const char *base_filename = NULL;
@@ -496,6 +506,9 @@ static int img_create(int argc, char **argv)
 
     /* Get the filename */
     filename = (optind < argc) ? argv[optind] : NULL;
+    if (fmt == NULL) {
+        fmt = get_format(filename);
+    }
     if (options && has_help_option(options)) {
         g_free(options);
         return print_block_option_help(filename, fmt);
@@ -4181,7 +4194,7 @@ static int img_dd(int argc, char **argv)
     Error *local_err = NULL;
     bool image_opts = false;
     int c, i;
-    const char *out_fmt = "raw";
+    const char *out_fmt = NULL;
     const char *fmt = NULL;
     int64_t size = 0;
     int64_t block_count = 0, out_pos, in_pos;
@@ -4308,6 +4321,9 @@ static int img_dd(int argc, char **argv)
         goto out;
     }
 
+    if (out_fmt == NULL) {
+        out_fmt = get_format(out.filename);
+    }
     drv = bdrv_find_format(out_fmt);
     if (!drv) {
         error_report("Unknown file format");
-- 
2.13.6
