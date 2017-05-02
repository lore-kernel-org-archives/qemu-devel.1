Received: from eggs.gnu.org ([2001:4830:134:3::10]:53896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d5Z6e-0006xW-Ud
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d5Z6d-0003DZ-HI
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:48:49 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  2 May 2017 15:47:44 +0100
Message-Id: <20170502144744.26815-5-berrange@redhat.com>
In-Reply-To: <20170502144744.26815-1-berrange@redhat.com>
References: <20170502144744.26815-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v7 4/4] qemu-img: copy *key-secret opts when
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
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The qemu-img dd/convert commands will create an image file and
then try to open it. Historically it has been possible to open
new files without passing any options. With encrypted files
though, the *key-secret options are mandatory, so we need to
provide those options when opening the newly created file.

Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 qemu-img.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 94c8cea..cbf05b4 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -305,15 +305,17 @@ static BlockBackend *img_open_opts(const char *optstr,
 }
 
 static BlockBackend *img_open_file(const char *filename,
+                                   QDict *options,
                                    const char *fmt, int flags,
                                    bool writethrough, bool quiet)
 {
     BlockBackend *blk;
     Error *local_err = NULL;
-    QDict *options = NULL;
 
     if (fmt) {
-        options = qdict_new();
+        if (!options) {
+            options = qdict_new();
+        }
         qdict_put(options, "driver", qstring_from_str(fmt));
     }
 
@@ -332,6 +334,33 @@ static BlockBackend *img_open_file(const char *filename,
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
+    QDict *options = NULL;
+
+    options = qdict_new();
+    qemu_opt_foreach(create_opts, img_add_key_secrets, options, &error_abort);
+
+    return img_open_file(filename, options, fmt, flags, writethrough, quiet);
+}
+
+
 static BlockBackend *img_open(bool image_opts,
                               const char *filename,
                               const char *fmt, int flags, bool writethrough,
@@ -351,7 +380,7 @@ static BlockBackend *img_open(bool image_opts,
         }
         blk = img_open_opts(filename, opts, flags, writethrough, quiet);
     } else {
-        blk = img_open_file(filename, fmt, flags, writethrough, quiet);
+        blk = img_open_file(filename, NULL, fmt, flags, writethrough, quiet);
     }
     return blk;
 }
@@ -2256,8 +2285,8 @@ static int img_convert(int argc, char **argv)
          * That has to wait for bdrv_create to be improved
          * to allow filenames in option syntax
          */
-        s.target = img_open_file(out_filename, out_fmt, flags,
-                                 writethrough, quiet);
+        s.target = img_open_new_file(out_filename, opts, out_fmt,
+                                     flags, writethrough, quiet);
     }
     if (!s.target) {
         ret = -1;
@@ -4269,7 +4298,7 @@ static int img_dd(int argc, char **argv)
      * with the bdrv_create() call above which does not
      * support image-opts style.
      */
-    blk2 = img_open_file(out.filename, out_fmt, BDRV_O_RDWR,
+    blk2 = img_open_file(out.filename, NULL, out_fmt, BDRV_O_RDWR,
                          false, false);
 
     if (!blk2) {
-- 
2.9.3
