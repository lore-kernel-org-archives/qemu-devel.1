Received: from eggs.gnu.org ([2001:4830:134:3::10]:53973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fzqZI-0002qw-9T
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 17:51:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fzqJs-0002DH-OX
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 17:35:38 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 11 Sep 2018 17:34:53 -0400
Message-Id: <5b49a980f2cde6610ab1df41bb0277d00b5db893.1536701561.git.jcody@redhat.com>
In-Reply-To: <cover.1536701561.git.jcody@redhat.com>
References: <cover.1536701561.git.jcody@redhat.com>
In-Reply-To: <cover.1536701561.git.jcody@redhat.com>
References: <cover.1536701561.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/4] block/rbd: pull out
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
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, jsnow@redhat.com, eblake@redhat.com

Code movement to pull the conversion from Qdict to BlockdevOptionsRbd
into a helper function.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/rbd.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index ca8e5bbace..b199450f9f 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -655,12 +655,34 @@ failed_opts:
     return r;
 }
 
+static int qemu_rbd_convert_options(QDict *options, BlockdevOptionsRbd **opts,
+                                    Error **errp)
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
+    r = qemu_rbd_convert_options(options, &opts, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        r = -EINVAL;
         goto out;
     }
 
-- 
2.17.1
