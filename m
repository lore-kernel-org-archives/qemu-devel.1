Received: from eggs.gnu.org ([2001:4830:134:3::10]:53431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ciFlj-0006ha-Is
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 02:30:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ciFli-0006vk-Mm
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 02:30:51 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Mon, 27 Feb 2017 02:30:39 -0500
Message-Id: <6f1d60bdbbb4e82991c699d4aa6666c4317a1c5d.1488180142.git.jcody@redhat.com>
In-Reply-To: <cover.1488180142.git.jcody@redhat.com>
References: <cover.1488180142.git.jcody@redhat.com>
In-Reply-To: <cover.1488180142.git.jcody@redhat.com>
References: <cover.1488180142.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] block/rbd: code movement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, berrange@redhat.com, eblake@redhat.com

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/rbd.c | 64 +++++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 3f1a9de..c8d4eb1 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -357,6 +357,51 @@ static void qemu_rbd_memset(RADOSCB *rcb, int64_t offs)
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
+        },
+        {
+            .name = "pool",
+            .type = QEMU_OPT_STRING,
+        },
+        {
+            .name = "image",
+            .type = QEMU_OPT_STRING,
+        },
+        {
+            .name = "snapshot",
+            .type = QEMU_OPT_STRING,
+        },
+        {
+            /* you might be tempted to call this 'id' to match
+             * the ceph documentation, but then it'll get gobbled
+             * up in the block layer before it gets to the image driver */
+            .name = "rbd-id",
+            .type = QEMU_OPT_STRING,
+        },
+        {
+            .name = "keyvalue-pairs",
+            .type = QEMU_OPT_STRING,
+        },
+        { /* end of list */ }
+    },
+};
+
 static int qemu_rbd_create(const char *filename, QemuOpts *opts, Error **errp)
 {
     Error *local_err = NULL;
@@ -500,25 +545,6 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
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
