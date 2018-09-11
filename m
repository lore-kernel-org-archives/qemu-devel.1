Received: from eggs.gnu.org ([2001:4830:134:3::10]:51045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fzb3r-0004qH-8R
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 01:18:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fzb1q-0004bN-65
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 01:15:58 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 11 Sep 2018 01:15:48 -0400
Message-Id: <78d2f47b07325fce34a03b115159830f662b7f90.1536642773.git.jcody@redhat.com>
In-Reply-To: <cover.1536642773.git.jcody@redhat.com>
References: <cover.1536642773.git.jcody@redhat.com>
In-Reply-To: <cover.1536642773.git.jcody@redhat.com>
References: <cover.1536642773.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] block/rbd: pull out
 qemu_rbd_convert_options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, jsnow@redhat.com, kwolf@redhat.com, armbru@redhat.com

Code movement to pull the conversion from Qdict to BlockdevOptionsRbd
into a helper function.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/rbd.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index ca8e5bbace..a8e79d01d2 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -655,12 +655,34 @@ failed_opts:
     return r;
 }
 
+static int qemu_rbd_convert_options(BlockDriverState *bs, QDict *options,
+                                    BlockdevOptionsRbd **opts, Error **errp)
+{
+    Visitor *v;
+    Error *local_err = NULL;
+
+    /* Convert the remaining options into a QAPI object */
+    v = qobject_input_visitor_new_flat_confused(options, errp);
+    if (!v) {
+        return -EINVAL;
+    }
+
+    visit_type_BlockdevOptionsRbd(v, NULL, opts, &local_err);
+    visit_free(v);
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
 static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
                          Error **errp)
 {
     BDRVRBDState *s = bs->opaque;
     BlockdevOptionsRbd *opts = NULL;
-    Visitor *v;
     const QDictEntry *e;
     Error *local_err = NULL;
     char *keypairs, *secretid;
@@ -676,19 +698,9 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
         qdict_del(options, "password-secret");
     }
 
-    /* Convert the remaining options into a QAPI object */
-    v = qobject_input_visitor_new_flat_confused(options, errp);
-    if (!v) {
-        r = -EINVAL;
-        goto out;
-    }
-
-    visit_type_BlockdevOptionsRbd(v, NULL, &opts, &local_err);
-    visit_free(v);
-
+    r = qemu_rbd_convert_options(bs, options, &opts, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        r = -EINVAL;
         goto out;
     }
 
-- 
2.17.1
