Received: from eggs.gnu.org ([2001:4830:134:3::10]:57378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX8O9-0002sg-6J
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:56:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX8O8-0007b4-Dd
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:56:49 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 17 Jul 2017 10:56:32 -0500
Message-Id: <20170717155632.12754-6-eblake@redhat.com>
In-Reply-To: <20170717155632.12754-1-eblake@redhat.com>
References: <20170717155632.12754-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 5/5] blockdev: Use simpler QAPI_TO_QOBJECT()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

Use the new macro to avoid some boilerplate.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 blockdev.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 7f53cc8bb3..bf26c38195 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3884,35 +3884,30 @@ void qmp_blockdev_add(BlockdevOptions *options, Error **errp)
 {
     BlockDriverState *bs;
     QObject *obj;
-    Visitor *v = qobject_output_visitor_new(&obj);
     QDict *qdict;
     Error *local_err = NULL;

-    visit_type_BlockdevOptions(v, NULL, &options, &local_err);
+    obj = QAPI_TO_QOBJECT(BlockdevOptions, options, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        goto fail;
+        return;
     }

-    visit_complete(v, &obj);
     qdict = qobject_to_qdict(obj);

     qdict_flatten(qdict);

     if (!qdict_get_try_str(qdict, "node-name")) {
         error_setg(errp, "'node-name' must be specified for the root node");
-        goto fail;
+        return;
     }

     bs = bds_tree_init(qdict, errp);
     if (!bs) {
-        goto fail;
+        return;
     }

     QTAILQ_INSERT_TAIL(&monitor_bdrv_states, bs, monitor_list);
-
-fail:
-    visit_free(v);
 }

 void qmp_blockdev_del(const char *node_name, Error **errp)
-- 
2.13.3
