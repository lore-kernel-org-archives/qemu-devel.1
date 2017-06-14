Received: from eggs.gnu.org ([2001:4830:134:3::10]:42418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dL7ne-0003xK-Re
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 08:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dL7nd-0006Gi-Oe
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 08:53:30 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 14 Jun 2017 08:53:19 -0400
Message-Id: <937dc9fde348d13311eb8e23444df3bc3190b612.1497444637.git.jcody@redhat.com>
In-Reply-To: <cover.1497444637.git.jcody@redhat.com>
References: <cover.1497444637.git.jcody@redhat.com>
In-Reply-To: <cover.1497444637.git.jcody@redhat.com>
References: <cover.1497444637.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] block/rbd: enable filename option and
 parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, rjones@redhat.com

When enabling option parsing and blockdev-add for rbd, we removed the
'filename' option.  Unfortunately, this was a bit optimistic, as
previous versions of QEMU allowed the use of the option in backing
filenames via json.  This means that without parsing this option, we
cannot open existing images that used to work fine.

See bug: https://bugzilla.redhat.com/show_bug.cgi?id=1457088

Tested-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/rbd.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/block/rbd.c b/block/rbd.c
index e551639..ff44e5f 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -340,6 +340,10 @@ static QemuOptsList runtime_opts = {
             .type = QEMU_OPT_STRING,
             .help = "Legacy rados key/value option parameters",
         },
+        {
+            .name = "filename",
+            .type = QEMU_OPT_STRING,
+        },
         { /* end of list */ }
     },
 };
@@ -541,12 +545,27 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
 {
     BDRVRBDState *s = bs->opaque;
     const char *pool, *snap, *conf, *user, *image_name, *keypairs;
-    const char *secretid;
+    const char *secretid, *filename;
     QemuOpts *opts;
     Error *local_err = NULL;
     char *mon_host = NULL;
     int r;
 
+    /* If we are given a filename, parse the filename, with precedence given to
+     * filename encoded options */
+    filename = qdict_get_try_str(options, "filename");
+    if (filename) {
+        error_report("Warning: 'filename' option specified. "
+                      "This is an unsupported option, and may be deprecated "
+                      "in the future");
+        qemu_rbd_parse_filename(filename, options, &local_err);
+        if (local_err) {
+            r = -EINVAL;
+            error_propagate(errp, local_err);
+            goto exit;
+        }
+    }
+
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
     qemu_opts_absorb_qdict(opts, options, &local_err);
     if (local_err) {
@@ -665,6 +684,7 @@ failed_shutdown:
 failed_opts:
     qemu_opts_del(opts);
     g_free(mon_host);
+exit:
     return r;
 }
 
-- 
2.9.3
