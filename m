Received: from eggs.gnu.org ([2001:4830:134:3::10]:46243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dKGbQ-0002OH-US
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 00:05:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dKGbQ-0001UA-1X
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 00:05:20 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Mon, 12 Jun 2017 00:05:13 -0400
Message-Id: <449e09e3de17c34febd360fb2b09af5002b4c3c7.1497240079.git.jcody@redhat.com>
In-Reply-To: <cover.1497240079.git.jcody@redhat.com>
References: <cover.1497240079.git.jcody@redhat.com>
In-Reply-To: <cover.1497240079.git.jcody@redhat.com>
References: <cover.1497240079.git.jcody@redhat.com>
Subject: [Qemu-devel] [RFC 1/2] block/rbd: enable filename option and parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, armbru@redhat.com

When enabling option parsing and blockdev-add for rbd, we removed the
'filename' option.  Unfortunately, this was a bit optimistic, as
previous versions of QEMU allowed the use of the option in backing
filenames via json.  This means that without parsing this option, we
cannot open existing images that used to work fine.

See bug: https://bugzilla.redhat.com/show_bug.cgi?id=1457088

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/rbd.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/block/rbd.c b/block/rbd.c
index e551639..cbc0b85 100644
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
@@ -541,12 +545,24 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
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
@@ -665,6 +681,7 @@ failed_shutdown:
 failed_opts:
     qemu_opts_del(opts);
     g_free(mon_host);
+exit:
     return r;
 }
 
-- 
2.9.3
