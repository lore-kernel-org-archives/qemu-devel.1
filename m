Received: from eggs.gnu.org ([2001:4830:134:3::10]:60257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ddduo-0000MF-F9
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:49:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ddduP-0000Qa-Fl
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:49:26 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  4 Aug 2017 16:43:54 +0200
Message-Id: <20170804144354.21985-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH] block/null: Remove 'filename' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

This option was only added to allow 'null-co://' and 'null-aio://' as
filenames, its value never served any actual purpose and was ignored.
Nevertheless it was accepted as '-drive driver=null,filename=foo'.

The correct way to enable the protocol prefixes (and that without adding
a useless -drive option) is implementing .bdrv_parse_filename. This is
what this patch does.

Technically, this is an incompatible change, but the null block driver
is only used for benchmarking, testing and debugging, and an option
without effect isn't likely to be used by anyone anyway, so no bad
effects are to be expected.

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/null.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/block/null.c b/block/null.c
index 876f90965b..dd9c13f9ba 100644
--- a/block/null.c
+++ b/block/null.c
@@ -30,11 +30,6 @@ static QemuOptsList runtime_opts = {
     .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
     .desc = {
         {
-            .name = "filename",
-            .type = QEMU_OPT_STRING,
-            .help = "",
-        },
-        {
             .name = BLOCK_OPT_SIZE,
             .type = QEMU_OPT_SIZE,
             .help = "size of the null block",
@@ -54,6 +49,30 @@ static QemuOptsList runtime_opts = {
     },
 };
 
+static void null_co_parse_filename(const char *filename, QDict *options,
+                                   Error **errp)
+{
+    /* This functions only exists so that a null-co:// filename is accepted
+     * with the null-co driver. */
+    if (strcmp(filename, "null-co://")) {
+        error_setg(errp, "The only allowed filename for this driver is "
+                         "'null-co://'");
+        return;
+    }
+}
+
+static void null_aio_parse_filename(const char *filename, QDict *options,
+                                    Error **errp)
+{
+    /* This functions only exists so that a null-aio:// filename is accepted
+     * with the null-aio driver. */
+    if (strcmp(filename, "null-aio://")) {
+        error_setg(errp, "The only allowed filename for this driver is "
+                         "'null-aio://'");
+        return;
+    }
+}
+
 static int null_file_open(BlockDriverState *bs, QDict *options, int flags,
                           Error **errp)
 {
@@ -242,6 +261,7 @@ static BlockDriver bdrv_null_co = {
     .instance_size          = sizeof(BDRVNullState),
 
     .bdrv_file_open         = null_file_open,
+    .bdrv_parse_filename    = null_co_parse_filename,
     .bdrv_close             = null_close,
     .bdrv_getlength         = null_getlength,
 
@@ -261,6 +281,7 @@ static BlockDriver bdrv_null_aio = {
     .instance_size          = sizeof(BDRVNullState),
 
     .bdrv_file_open         = null_file_open,
+    .bdrv_parse_filename    = null_aio_parse_filename,
     .bdrv_close             = null_close,
     .bdrv_getlength         = null_getlength,
 
-- 
2.13.3
