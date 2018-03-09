Received: from eggs.gnu.org ([2001:4830:134:3::10]:34006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKlD-0001OK-Su
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKlC-0007Hg-Gn
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:47 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:19:19 +0100
Message-Id: <20180309161933.8168-43-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 42/56] sheepdog: QAPIfy "redundancy" create
 option
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

The "redundancy" option for Sheepdog image creation is currently a
string that can encode one or two integers depending on its format,
which at the same time implicitly selects a mode.

This patch turns it into a QAPI union and converts the string into such
a QAPI object before interpreting the values.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json | 45 +++++++++++++++++++++++++
 block/sheepdog.c     | 94 +++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 112 insertions(+), 27 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 39e53c7791..e590ab6c71 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3467,6 +3467,51 @@
             '*cluster-size' :   'size' } }
 
 ##
+# @SheepdogRedundancyType:
+#
+# @full             Create a fully replicated vdi with x copies
+# @erasure-coded    Create an erasure coded vdi with x data strips and
+#                   y parity strips
+#
+# Since: 2.12
+##
+{ 'enum': 'SheepdogRedundancyType',
+  'data': [ 'full', 'erasure-coded' ] }
+
+##
+# @SheepdogRedundancyFull:
+#
+# @copies           Number of copies to use (between 1 and 31)
+#
+# Since: 2.12
+##
+{ 'struct': 'SheepdogRedundancyFull',
+  'data': { 'copies': 'int' }}
+
+##
+# @SheepdogRedundancyErasureCoded:
+#
+# @data-strips      Number of data strips to use (one of {2,4,8,16})
+# @parity-strips    Number of parity strips to use (between 1 and 15)
+#
+# Since: 2.12
+##
+{ 'struct': 'SheepdogRedundancyErasureCoded',
+  'data': { 'data-strips': 'int',
+            'parity-strips': 'int' }}
+
+##
+# @SheepdogRedundancy:
+#
+# Since: 2.12
+##
+{ 'union': 'SheepdogRedundancy',
+  'base': { 'type': 'SheepdogRedundancyType' },
+  'discriminator': 'type',
+  'data': { 'full': 'SheepdogRedundancyFull',
+            'erasure-coded': 'SheepdogRedundancyErasureCoded' } }
+
+##
 # @BlockdevCreateNotSupported:
 #
 # This is used for all drivers that don't support creating images.
diff --git a/block/sheepdog.c b/block/sheepdog.c
index d8c10b7cac..3966cd229a 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -1882,6 +1882,48 @@ out_with_err_set:
     return ret;
 }
 
+static int parse_redundancy(BDRVSheepdogState *s, SheepdogRedundancy *opt)
+{
+    struct SheepdogInode *inode = &s->inode;
+
+    switch (opt->type) {
+    case SHEEPDOG_REDUNDANCY_TYPE_FULL:
+        if (opt->u.full.copies > SD_MAX_COPIES || opt->u.full.copies < 1) {
+            return -EINVAL;
+        }
+        inode->copy_policy = 0;
+        inode->nr_copies = opt->u.full.copies;
+        return 0;
+
+    case SHEEPDOG_REDUNDANCY_TYPE_ERASURE_CODED:
+    {
+        int64_t copy = opt->u.erasure_coded.data_strips;
+        int64_t parity = opt->u.erasure_coded.parity_strips;
+
+        if (copy != 2 && copy != 4 && copy != 8 && copy != 16) {
+            return -EINVAL;
+        }
+
+        if (parity >= SD_EC_MAX_STRIP || parity < 1) {
+            return -EINVAL;
+        }
+
+        /*
+         * 4 bits for parity and 4 bits for data.
+         * We have to compress upper data bits because it can't represent 16
+         */
+        inode->copy_policy = ((copy / 2) << 4) + parity;
+        inode->nr_copies = copy + parity;
+        return 0;
+    }
+
+    default:
+        g_assert_not_reached();
+    }
+
+    return -EINVAL;
+}
+
 /*
  * Sheepdog support two kinds of redundancy, full replication and erasure
  * coding.
@@ -1892,12 +1934,13 @@ out_with_err_set:
  * # create a erasure coded vdi with x data strips and y parity strips
  * -o redundancy=x:y (x must be one of {2,4,8,16} and 1 <= y < SD_EC_MAX_STRIP)
  */
-static int parse_redundancy(BDRVSheepdogState *s, const char *opt)
+static int parse_redundancy_str(BDRVSheepdogState *s, const char *opt)
 {
-    struct SheepdogInode *inode = &s->inode;
+    struct SheepdogRedundancy redundancy;
     const char *n1, *n2;
     long copy, parity;
     char p[10];
+    int ret;
 
     pstrcpy(p, sizeof(p), opt);
     n1 = strtok(p, ":");
@@ -1907,35 +1950,32 @@ static int parse_redundancy(BDRVSheepdogState *s, const char *opt)
         return -EINVAL;
     }
 
-    copy = strtol(n1, NULL, 10);
-    /* FIXME fix error checking by switching to qemu_strtol() */
-    if (copy > SD_MAX_COPIES || copy < 1) {
-        return -EINVAL;
-    }
-    if (!n2) {
-        inode->copy_policy = 0;
-        inode->nr_copies = copy;
-        return 0;
+    ret = qemu_strtol(n1, NULL, 10, &copy);
+    if (ret < 0) {
+        return ret;
     }
 
-    if (copy != 2 && copy != 4 && copy != 8 && copy != 16) {
-        return -EINVAL;
-    }
+    if (!n2) {
+        redundancy = (SheepdogRedundancy) {
+            .type               = SHEEPDOG_REDUNDANCY_TYPE_FULL,
+            .u.full.copies      = copy,
+        };
+    } else {
+        ret = qemu_strtol(n2, NULL, 10, &parity);
+        if (ret < 0) {
+            return ret;
+        }
 
-    parity = strtol(n2, NULL, 10);
-    /* FIXME fix error checking by switching to qemu_strtol() */
-    if (parity >= SD_EC_MAX_STRIP || parity < 1) {
-        return -EINVAL;
+        redundancy = (SheepdogRedundancy) {
+            .type               = SHEEPDOG_REDUNDANCY_TYPE_ERASURE_CODED,
+            .u.erasure_coded    = {
+                .data_strips    = copy,
+                .parity_strips  = parity,
+            },
+        };
     }
 
-    /*
-     * 4 bits for parity and 4 bits for data.
-     * We have to compress upper data bits because it can't represent 16
-     */
-    inode->copy_policy = ((copy / 2) << 4) + parity;
-    inode->nr_copies = copy + parity;
-
-    return 0;
+    return parse_redundancy(s, &redundancy);
 }
 
 static int parse_block_size_shift(BDRVSheepdogState *s, QemuOpts *opt)
@@ -2007,7 +2047,7 @@ static int coroutine_fn sd_co_create_opts(const char *filename, QemuOpts *opts,
     g_free(buf);
     buf = qemu_opt_get_del(opts, BLOCK_OPT_REDUNDANCY);
     if (buf) {
-        ret = parse_redundancy(s, buf);
+        ret = parse_redundancy_str(s, buf);
         if (ret < 0) {
             error_setg(errp, "Invalid redundancy mode: '%s'", buf);
             goto out;
-- 
2.13.6
