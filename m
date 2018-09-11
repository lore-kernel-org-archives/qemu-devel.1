Received: from eggs.gnu.org ([2001:4830:134:3::10]:53945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fzqZI-0002pg-Av
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 17:51:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fzqJu-0002E7-8F
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 17:35:40 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 11 Sep 2018 17:34:54 -0400
Message-Id: <15b332e5432ad069441f7275a46080f465d789a0.1536701561.git.jcody@redhat.com>
In-Reply-To: <cover.1536701561.git.jcody@redhat.com>
References: <cover.1536701561.git.jcody@redhat.com>
In-Reply-To: <cover.1536701561.git.jcody@redhat.com>
References: <cover.1536701561.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/4] block/rbd: Attempt to parse legacy
 filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, jsnow@redhat.com, eblake@redhat.com

When we converted rbd to get rid of the older key/value-centric
encoding format, we broke compatibility with image files with backing
file strings encoded in the old format.

This leaves a bit of an ugly conundrum, and a hacky solution.

If the initial attempt to parse the "proper" options fails, it assumes
that we may have an older key/value encoded filename.  Fall back to
attempting to parse the filename, and extract the required options from
it.  If that fails, pass along the original error message.

We do not support mixed modern usage alongside legacy keyvalue pair
usage.

A deprecation warning has been added, although care should be taken
when actually deprecating since the impact is not limited to
commandline or qapi usage, but also opening existing images.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/rbd.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index b199450f9f..5090e4f662 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -678,6 +678,33 @@ static int qemu_rbd_convert_options(QDict *options, BlockdevOptionsRbd **opts,
     return 0;
 }
 
+static int qemu_rbd_attempt_legacy_options(QDict *options,
+                                           BlockdevOptionsRbd **opts,
+                                           char **keypairs)
+{
+    char *filename;
+    int r;
+
+    filename = g_strdup(qdict_get_try_str(options, "filename"));
+    if (!filename) {
+        return -EINVAL;
+    }
+    qdict_del(options, "filename");
+
+    qemu_rbd_parse_filename(filename, options, NULL);
+
+    /* keypairs freed by caller */
+    *keypairs = g_strdup(qdict_get_try_str(options, "=keyvalue-pairs"));
+    if (*keypairs) {
+        qdict_del(options, "=keyvalue-pairs");
+    }
+
+    r = qemu_rbd_convert_options(options, opts, NULL);
+
+    g_free(filename);
+    return r;
+}
+
 static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
                          Error **errp)
 {
@@ -700,8 +727,30 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
 
     r = qemu_rbd_convert_options(options, &opts, &local_err);
     if (local_err) {
-        error_propagate(errp, local_err);
-        goto out;
+        /* If keypairs are present, that means some options are present in
+         * the modern option format.  Don't attempt to parse legacy option
+         * formats, as we won't support mixed usage. */
+        if (keypairs) {
+            error_propagate(errp, local_err);
+            goto out;
+        }
+
+        /* If the initial attempt to convert and process the options failed,
+         * we may be attempting to open an image file that has the rbd options
+         * specified in the older format consisting of all key/value pairs
+         * encoded in the filename.  Go ahead and attempt to parse the
+         * filename, and see if we can pull out the required options. */
+        r = qemu_rbd_attempt_legacy_options(options, &opts, &keypairs);
+        if (r < 0) {
+            error_propagate(errp, local_err);
+            goto out;
+        }
+        /* Take care whenever deciding to actually deprecate; once this ability
+         * is removed, we will not be able to open any images with legacy-styled
+         * backing image strings. */
+        error_report("RBD options encoded in the filename as keyvalue pairs "
+                     "is deprecated.  Future versions may cease to parse "
+                     "these options in the future.");
     }
 
     /* Remove the processed options from the QDict (the visitor processes
-- 
2.17.1
