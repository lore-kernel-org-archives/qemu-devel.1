Received: from eggs.gnu.org ([2001:4830:134:3::10]:47774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cikRV-0004qv-U0
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:16:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cikRU-0001li-SL
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:16:01 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 28 Feb 2017 11:15:50 -0500
Message-Id: <20170228161553.28142-3-jcody@redhat.com>
In-Reply-To: <20170228161553.28142-1-jcody@redhat.com>
References: <20170228161553.28142-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 2/5] block/rbd: add all the currently supported
 runtime_opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org

This adds all the currently supported runtime opts, which
are the options as parsed from the filename.  All of these
options are explicitly checked for during during runtime,
with an exception to the "keyvalue-pairs" option.

This option contains all the key/value pairs that the QEMU rbd
driver merely unescapes, and passes along blindly to rados.  This
option is a "legacy" option, and will not be exposed in the QAPI
or available for introspection.

Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/rbd.c | 68 ++++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 49 insertions(+), 19 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 33c21d8..67d680c 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -357,6 +357,55 @@ static void qemu_rbd_memset(RADOSCB *rcb, int64_t offs)
     }
 }
 
+static QemuOptsList runtime_opts = {
+    .name = "rbd",
+    .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
+    .desc = {
+        {
+            .name = "filename",
+            .type = QEMU_OPT_STRING,
+            .help = "Specification of the rbd image",
+        },
+        {
+            .name = "password-secret",
+            .type = QEMU_OPT_STRING,
+            .help = "ID of secret providing the password",
+        },
+        {
+            .name = "conf",
+            .type = QEMU_OPT_STRING,
+            .help = "Rados config file location",
+        },
+        {
+            .name = "pool",
+            .type = QEMU_OPT_STRING,
+            .help = "Rados pool name",
+        },
+        {
+            .name = "image",
+            .type = QEMU_OPT_STRING,
+            .help = "Image name in the pool",
+        },
+        {
+            .name = "snapshot",
+            .type = QEMU_OPT_STRING,
+            .help = "Ceph snapshot name",
+        },
+        {
+            /* maps to 'id' in rados_create() */
+            .name = "user",
+            .type = QEMU_OPT_STRING,
+            .help = "Rados id name",
+        },
+        {
+            .name = "keyvalue-pairs",
+            .type = QEMU_OPT_STRING,
+            .help = "Legacy rados key/value option parameters",
+        },
+        { /* end of list */ }
+    },
+};
+
 static int qemu_rbd_create(const char *filename, QemuOpts *opts, Error **errp)
 {
     Error *local_err = NULL;
@@ -500,25 +549,6 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
     qemu_aio_unref(acb);
 }
 
-/* TODO Convert to fine grained options */
-static QemuOptsList runtime_opts = {
-    .name = "rbd",
-    .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
-    .desc = {
-        {
-            .name = "filename",
-            .type = QEMU_OPT_STRING,
-            .help = "Specification of the rbd image",
-        },
-        {
-            .name = "password-secret",
-            .type = QEMU_OPT_STRING,
-            .help = "ID of secret providing the password",
-        },
-        { /* end of list */ }
-    },
-};
-
 static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
                          Error **errp)
 {
-- 
2.9.3
