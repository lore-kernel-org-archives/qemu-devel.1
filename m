Received: from eggs.gnu.org ([2001:4830:134:3::10]:34877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cfpkf-0008NW-UJ
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:19:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cfpke-0007H8-Pa
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:19:45 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 20 Feb 2017 15:19:21 +0000
Message-Id: <20170220151921.22842-5-berrange@redhat.com>
In-Reply-To: <20170220151921.22842-1-berrange@redhat.com>
References: <20170220151921.22842-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 4/4] qemu-img: copy *key-secret opts when
 opening newly created files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The qemu-img dd/convert commands will create a image file and
then try to open it. Historically it has been possible to open
new files without passing any options. With encrypted files
though, the *key-secret options are mandatory, so we need to
provide those options when opening the newly created file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 qemu-img.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index e48e676..bad19fd 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -317,6 +317,46 @@ static BlockBackend *img_open_file(const char *filename,
 }
 
 
+static int img_add_key_secrets(void *opaque,
+                               const char *name, const char *value,
+                               Error **errp)
+{
+    QDict *options = opaque;
+
+    if (g_str_has_suffix(name, "key-secret")) {
+        qdict_put(options, name, qstring_from_str(value));
+    }
+
+    return 0;
+}
+
+static BlockBackend *img_open_new_file(const char *filename,
+                                       QemuOpts *create_opts,
+                                       const char *fmt, int flags,
+                                       bool writethrough, bool quiet)
+{
+    BlockBackend *blk;
+    Error *local_err = NULL;
+    QDict *options = NULL;
+
+    options = qdict_new();
+    if (fmt) {
+        qdict_put(options, "driver", qstring_from_str(fmt));
+    }
+
+    qemu_opt_foreach(create_opts, img_add_key_secrets, options, NULL);
+
+    blk = blk_new_open(filename, NULL, options, flags, &local_err);
+    if (!blk) {
+        error_reportf_err(local_err, "Could not open '%s': ", filename);
+        return NULL;
+    }
+    blk_set_enable_write_cache(blk, !writethrough);
+
+    return blk;
+}
+
+
 static BlockBackend *img_open(bool image_opts,
                               const char *filename,
                               const char *fmt, int flags, bool writethrough,
@@ -2120,8 +2160,8 @@ static int img_convert(int argc, char **argv)
          * That has to wait for bdrv_create to be improved
          * to allow filenames in option syntax
          */
-        out_blk = img_open_file(out_filename, out_fmt,
-                                flags, writethrough, quiet);
+        out_blk = img_open_new_file(out_filename, opts, out_fmt,
+                                    flags, writethrough, quiet);
     }
     if (!out_blk) {
         ret = -1;
-- 
2.9.3
