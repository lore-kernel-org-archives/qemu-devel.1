Received: from eggs.gnu.org ([2001:4830:134:3::10]:48909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJ0-0007IJ-Vw
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIl-0003rp-HF
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:46:55 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:26 +0200
Message-Id: <1502117160-24655-23-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 22/56] block: Mix up signed and unsigned
 less in bdrv_img_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

@size is declared int64_t.  It's set in two places.

The second one assigns the (signed) value of bdrv_getlength(), then
errors out if its negative.

The first one assigns qemu_opt_get_size(opts, BLOCK_OPT_SIZE, 0),
i.e. an uint64_t value.  What if it exceeds INT64_MAX?  Is that even
possible?  Turns out it is:

    $ qemu-img create -o size=9223372036854775808 foo.img

On closer examination, the code still works as long as converting from
uint64_t to int64_t and back doesn't change the value.
Implementation-defined behavior, but sane implementations behave.
Things actually break elsewhere for such sizes, e.g. file-posix.c's
raw_create().

Clean this up.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/block.c b/block.c
index ce9cce7..04cce0d 100644
--- a/block.c
+++ b/block.c
@@ -4309,7 +4309,8 @@ void bdrv_img_create(const char *filename, const char *fmt,
     QemuOptsList *create_opts = NULL;
     QemuOpts *opts = NULL;
     const char *backing_fmt, *backing_file;
-    int64_t size;
+    uint64_t size;
+    int64_t backing_size;
     BlockDriver *drv, *proto_drv;
     Error *local_err = NULL;
     int ret = 0;
@@ -4414,7 +4415,7 @@ void bdrv_img_create(const char *filename, const char *fmt,
         bs = bdrv_open(full_backing, NULL, backing_options, back_flags,
                        &local_err);
         g_free(full_backing);
-        if (!bs && size != -1) {
+        if (!bs && size != UINT64_MAX) {
             /* Couldn't open BS, but we have a size, so it's nonfatal */
             warn_reportf_err(local_err,
                             "Could not verify backing image. "
@@ -4426,22 +4427,24 @@ void bdrv_img_create(const char *filename, const char *fmt,
                               "Could not open backing image to determine size.\n");
             goto out;
         } else {
-            if (size == -1) {
+            if (size == UINT64_MAX) {
                 /* Opened BS, have no size */
-                size = bdrv_getlength(bs);
-                if (size < 0) {
-                    error_setg_errno(errp, -size, "Could not get size of '%s'",
+                backing_size = bdrv_getlength(bs);
+                if (backing_size < 0) {
+                    error_setg_errno(errp, -backing_size,
+                                     "Could not get size of '%s'",
                                      backing_file);
                     bdrv_unref(bs);
                     goto out;
                 }
+                size = backing_size;
                 qemu_opt_set_number(opts, BLOCK_OPT_SIZE, size, &error_abort);
             }
             bdrv_unref(bs);
         }
     } /* (backing_file && !(flags & BDRV_O_NO_BACKING)) */
 
-    if (size == -1) {
+    if (size == UINT64_MAX) {
         error_setg(errp, "Image creation needs a size parameter");
         goto out;
     }
-- 
2.7.5
