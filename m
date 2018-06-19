Received: from eggs.gnu.org ([2001:4830:134:3::10]:46826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5jH-0002pO-Sh
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:46:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5jG-0000Wv-T1
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:46:43 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:42:36 -0500
Message-Id: <20180619014319.28272-71-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 070/113] qemu-img: Resolve relative backing
 paths in rebase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>

From: Max Reitz <mreitz@redhat.com>

Currently, rebase interprets a relative path for the new backing image
as follows:
(1) Open the new backing image with the given relative path (thus relative to
    qemu-img's working directory).
(2) Write it directly into the overlay's backing path field (thus
    relative to the overlay).

If the overlay is not in qemu-img's working directory, both will be
different interpretations, which may either lead to an error somewhere
(either rebase fails because it cannot open the new backing image, or
your overlay becomes unusable because its backing path does not point to
a file), or, even worse, it may result in your rebase being performed
for a different backing file than what your overlay will point to after
the rebase.

Fix this by interpreting the target backing path as relative to the
overlay, like qemu-img does everywhere else.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1569835
Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20180509182002.8044-2-mreitz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit d16699b64671466b42079c45b89127aeea1ca565)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qemu-img.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index 68b375f998..03da42dae2 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3190,6 +3190,9 @@ static int img_rebase(int argc, char **argv)
         }
 
         if (out_baseimg[0]) {
+            const char *overlay_filename;
+            char *out_real_path;
+
             options = qdict_new();
             if (out_basefmt) {
                 qdict_put_str(options, "driver", out_basefmt);
@@ -3198,8 +3201,26 @@ static int img_rebase(int argc, char **argv)
                 qdict_put_bool(options, BDRV_OPT_FORCE_SHARE, true);
             }
 
-            blk_new_backing = blk_new_open(out_baseimg, NULL,
+            overlay_filename = bs->exact_filename[0] ? bs->exact_filename
+                                                     : bs->filename;
+            out_real_path = g_malloc(PATH_MAX);
+
+            bdrv_get_full_backing_filename_from_filename(overlay_filename,
+                                                         out_baseimg,
+                                                         out_real_path,
+                                                         PATH_MAX,
+                                                         &local_err);
+            if (local_err) {
+                error_reportf_err(local_err,
+                                  "Could not resolve backing filename: ");
+                ret = -1;
+                g_free(out_real_path);
+                goto out;
+            }
+
+            blk_new_backing = blk_new_open(out_real_path, NULL,
                                            options, src_flags, &local_err);
+            g_free(out_real_path);
             if (!blk_new_backing) {
                 error_reportf_err(local_err,
                                   "Could not open new backing file '%s': ",
-- 
2.11.0
