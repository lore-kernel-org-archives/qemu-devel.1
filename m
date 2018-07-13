Received: from eggs.gnu.org ([2001:4830:134:3::10]:43862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fdw1y-0005lV-4n
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 07:14:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fdw1x-0002cU-Ag
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 07:14:34 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 13 Jul 2018 13:14:22 +0200
Message-Id: <20180713111424.23670-2-mreitz@redhat.com>
In-Reply-To: <20180713111424.23670-1-mreitz@redhat.com>
References: <20180713111424.23670-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] qemu-img: Allow rebase with no input base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Currently, you cannot add a backing file to an image when it currently
has none.  It is really simple to allow this, though (effectively by
setting old_backing_size to 0), so this patch does just that.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 61 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 9b7506b8ae..dd684d8bf0 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3280,26 +3280,30 @@ static int img_rebase(int argc, char **argv)
         char backing_name[PATH_MAX];
         QDict *options = NULL;
 
-        if (bs->backing_format[0] != '\0') {
-            options = qdict_new();
-            qdict_put_str(options, "driver", bs->backing_format);
-        }
-
-        if (force_share) {
-            if (!options) {
+        if (bs->backing) {
+            if (bs->backing_format[0] != '\0') {
                 options = qdict_new();
+                qdict_put_str(options, "driver", bs->backing_format);
             }
-            qdict_put_bool(options, BDRV_OPT_FORCE_SHARE, true);
-        }
-        bdrv_get_backing_filename(bs, backing_name, sizeof(backing_name));
-        blk_old_backing = blk_new_open(backing_name, NULL,
-                                       options, src_flags, &local_err);
-        if (!blk_old_backing) {
-            error_reportf_err(local_err,
-                              "Could not open old backing file '%s': ",
-                              backing_name);
-            ret = -1;
-            goto out;
+
+            if (force_share) {
+                if (!options) {
+                    options = qdict_new();
+                }
+                qdict_put_bool(options, BDRV_OPT_FORCE_SHARE, true);
+            }
+            bdrv_get_backing_filename(bs, backing_name, sizeof(backing_name));
+            blk_old_backing = blk_new_open(backing_name, NULL,
+                                           options, src_flags, &local_err);
+            if (!blk_old_backing) {
+                error_reportf_err(local_err,
+                                  "Could not open old backing file '%s': ",
+                                  backing_name);
+                ret = -1;
+                goto out;
+            }
+        } else {
+            blk_old_backing = NULL;
         }
 
         if (out_baseimg[0]) {
@@ -3355,7 +3359,7 @@ static int img_rebase(int argc, char **argv)
      */
     if (!unsafe) {
         int64_t size;
-        int64_t old_backing_size;
+        int64_t old_backing_size = 0;
         int64_t new_backing_size = 0;
         uint64_t offset;
         int64_t n;
@@ -3371,15 +3375,18 @@ static int img_rebase(int argc, char **argv)
             ret = -1;
             goto out;
         }
-        old_backing_size = blk_getlength(blk_old_backing);
-        if (old_backing_size < 0) {
-            char backing_name[PATH_MAX];
+        if (blk_old_backing) {
+            old_backing_size = blk_getlength(blk_old_backing);
+            if (old_backing_size < 0) {
+                char backing_name[PATH_MAX];
 
-            bdrv_get_backing_filename(bs, backing_name, sizeof(backing_name));
-            error_report("Could not get size of '%s': %s",
-                         backing_name, strerror(-old_backing_size));
-            ret = -1;
-            goto out;
+                bdrv_get_backing_filename(bs, backing_name,
+                                          sizeof(backing_name));
+                error_report("Could not get size of '%s': %s",
+                             backing_name, strerror(-old_backing_size));
+                ret = -1;
+                goto out;
+            }
         }
         if (blk_new_backing) {
             new_backing_size = blk_getlength(blk_new_backing);
-- 
2.17.1
