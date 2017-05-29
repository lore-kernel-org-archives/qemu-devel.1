Received: from eggs.gnu.org ([2001:4830:134:3::10]:45838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFMGZ-0001Z6-78
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFMGX-0006WU-Nd
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:07:31 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 29 May 2017 17:06:54 +0200
Message-Id: <1496070414-6744-16-git-send-email-kwolf@redhat.com>
In-Reply-To: <1496070414-6744-1-git-send-email-kwolf@redhat.com>
References: <1496070414-6744-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 15/15] block/file-*: *_parse_filename() and
 colons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

The file drivers' *_parse_filename() implementations just strip the
optional protocol prefix off the filename. However, for e.g.
"file:foo:bar", this would lead to "foo:bar" being stored as the BDS's
filename which looks like it should be managed using the "foo" protocol.
This is especially troublesome if you then try to resolve a backing
filename based on "foo:bar".

This issue can only occur if the stripped part is a relative filename
("file:/foo:bar" will be shortened to "/foo:bar" and having a slash
before the first colon means that "/foo" is not recognized as a protocol
part). Therefore, we can easily fix it by prepending "./" to such
filenames.

Before this patch:
$ ./qemu-img create -f qcow2 backing.qcow2 64M
Formatting 'backing.qcow2', fmt=qcow2 size=67108864 encryption=off
    cluster_size=65536 lazy_refcounts=off refcount_bits=16
$ ./qemu-img create -f qcow2 -b backing.qcow2 file:top:image.qcow2
Formatting 'file:top:image.qcow2', fmt=qcow2 size=67108864
    backing_file=backing.qcow2 encryption=off cluster_size=65536
    lazy_refcounts=off refcount_bits=16
$ ./qemu-io file:top:image.qcow2
can't open device file:top:image.qcow2: Could not open backing file:
    Unknown protocol 'top'

After this patch:
$ ./qemu-io file:top:image.qcow2
[no error]

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170522195217.12991-3-mreitz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c                   | 35 +++++++++++++++++++++++++++++++++++
 block/file-posix.c        | 17 +++--------------
 block/file-win32.c        | 12 ++----------
 include/block/block_int.h |  3 +++
 4 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/block.c b/block.c
index b72b872..fa1d06d 100644
--- a/block.c
+++ b/block.c
@@ -197,6 +197,41 @@ void path_combine(char *dest, int dest_size,
     }
 }
 
+/*
+ * Helper function for bdrv_parse_filename() implementations to remove optional
+ * protocol prefixes (especially "file:") from a filename and for putting the
+ * stripped filename into the options QDict if there is such a prefix.
+ */
+void bdrv_parse_filename_strip_prefix(const char *filename, const char *prefix,
+                                      QDict *options)
+{
+    if (strstart(filename, prefix, &filename)) {
+        /* Stripping the explicit protocol prefix may result in a protocol
+         * prefix being (wrongly) detected (if the filename contains a colon) */
+        if (path_has_protocol(filename)) {
+            QString *fat_filename;
+
+            /* This means there is some colon before the first slash; therefore,
+             * this cannot be an absolute path */
+            assert(!path_is_absolute(filename));
+
+            /* And we can thus fix the protocol detection issue by prefixing it
+             * by "./" */
+            fat_filename = qstring_from_str("./");
+            qstring_append(fat_filename, filename);
+
+            assert(!path_has_protocol(qstring_get_str(fat_filename)));
+
+            qdict_put(options, "filename", fat_filename);
+        } else {
+            /* If no protocol prefix was detected, we can use the shortened
+             * filename as-is */
+            qdict_put_str(options, "filename", filename);
+        }
+    }
+}
+
+
 /* Returns whether the image file is opened as read-only. Note that this can
  * return false and writing to the image file is still not possible because the
  * image is inactivated. */
diff --git a/block/file-posix.c b/block/file-posix.c
index 4354d49..de2d3a2 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -381,12 +381,7 @@ static void raw_parse_flags(int bdrv_flags, int *open_flags)
 static void raw_parse_filename(const char *filename, QDict *options,
                                Error **errp)
 {
-    /* The filename does not have to be prefixed by the protocol name, since
-     * "file" is the default protocol; therefore, the return value of this
-     * function call can be ignored. */
-    strstart(filename, "file:", &filename);
-
-    qdict_put_str(options, "filename", filename);
+    bdrv_parse_filename_strip_prefix(filename, "file:", options);
 }
 
 static QemuOptsList raw_runtime_opts = {
@@ -2395,10 +2390,7 @@ static int check_hdev_writable(BDRVRawState *s)
 static void hdev_parse_filename(const char *filename, QDict *options,
                                 Error **errp)
 {
-    /* The prefix is optional, just as for "file". */
-    strstart(filename, "host_device:", &filename);
-
-    qdict_put_str(options, "filename", filename);
+    bdrv_parse_filename_strip_prefix(filename, "host_device:", options);
 }
 
 static bool hdev_is_sg(BlockDriverState *bs)
@@ -2697,10 +2689,7 @@ static BlockDriver bdrv_host_device = {
 static void cdrom_parse_filename(const char *filename, QDict *options,
                                  Error **errp)
 {
-    /* The prefix is optional, just as for "file". */
-    strstart(filename, "host_cdrom:", &filename);
-
-    qdict_put_str(options, "filename", filename);
+    bdrv_parse_filename_strip_prefix(filename, "host_cdrom:", options);
 }
 #endif
 
diff --git a/block/file-win32.c b/block/file-win32.c
index 8f14f0b..ef2910b 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -276,12 +276,7 @@ static void raw_parse_flags(int flags, bool use_aio, int *access_flags,
 static void raw_parse_filename(const char *filename, QDict *options,
                                Error **errp)
 {
-    /* The filename does not have to be prefixed by the protocol name, since
-     * "file" is the default protocol; therefore, the return value of this
-     * function call can be ignored. */
-    strstart(filename, "file:", &filename);
-
-    qdict_put_str(options, "filename", filename);
+    bdrv_parse_filename_strip_prefix(filename, "file:", options);
 }
 
 static QemuOptsList raw_runtime_opts = {
@@ -671,10 +666,7 @@ static int hdev_probe_device(const char *filename)
 static void hdev_parse_filename(const char *filename, QDict *options,
                                 Error **errp)
 {
-    /* The prefix is optional, just as for "file". */
-    strstart(filename, "host_device:", &filename);
-
-    qdict_put_str(options, "filename", filename);
+    bdrv_parse_filename_strip_prefix(filename, "host_device:", options);
 }
 
 static int hdev_open(BlockDriverState *bs, QDict *options, int flags,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 8d3724c..e5eb473 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -682,6 +682,9 @@ int get_tmp_filename(char *filename, int size);
 BlockDriver *bdrv_probe_all(const uint8_t *buf, int buf_size,
                             const char *filename);
 
+void bdrv_parse_filename_strip_prefix(const char *filename, const char *prefix,
+                                      QDict *options);
+
 
 /**
  * bdrv_add_before_write_notifier:
-- 
1.8.3.1
