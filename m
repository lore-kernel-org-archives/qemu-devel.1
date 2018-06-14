Received: from eggs.gnu.org ([2001:4830:134:3::10]:53537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTXi1-0001gA-7s
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:15:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTXhy-0001dW-Tp
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:15:01 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 14 Jun 2018 21:14:33 +0200
Message-Id: <20180614191443.14361-9-armbru@redhat.com>
In-Reply-To: <20180614191443.14361-1-armbru@redhat.com>
References: <20180614191443.14361-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 08/18] block: Factor out
 qobject_input_visitor_new_flat_confused()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, eblake@redhat.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block/nbd.c           |  7 ++-----
 block/nfs.c           |  7 ++-----
 block/parallels.c     |  7 ++-----
 block/qcow.c          |  7 ++-----
 block/qcow2.c         |  7 ++-----
 block/qed.c           |  7 ++-----
 block/rbd.c           |  7 ++-----
 block/sheepdog.c      | 14 ++++----------
 block/ssh.c           |  7 ++-----
 block/vhdx.c          |  7 ++-----
 block/vpc.c           |  7 ++-----
 include/block/qdict.h |  3 ++-
 qobject/block-qdict.c | 28 +++++++++++++++++++++++++++-
 13 files changed, 53 insertions(+), 62 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 614dd9fec0..13db4030e6 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -263,7 +263,6 @@ static SocketAddress *nbd_config(BDRVNBDState *s, QDict *options,
 {
     SocketAddress *saddr = NULL;
     QDict *addr = NULL;
-    QObject *crumpled_addr = NULL;
     Visitor *iv = NULL;
     Error *local_err = NULL;
 
@@ -273,12 +272,11 @@ static SocketAddress *nbd_config(BDRVNBDState *s, QDict *options,
         goto done;
     }
 
-    crumpled_addr = qdict_crumple_for_keyval_qiv(addr, errp);
-    if (!crumpled_addr) {
+    iv = qobject_input_visitor_new_flat_confused(addr, errp);
+    if (!iv) {
         goto done;
     }
 
-    iv = qobject_input_visitor_new_keyval(crumpled_addr);
     visit_type_SocketAddress(iv, NULL, &saddr, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -287,7 +285,6 @@ static SocketAddress *nbd_config(BDRVNBDState *s, QDict *options,
 
 done:
     qobject_unref(addr);
-    qobject_unref(crumpled_addr);
     visit_free(iv);
     return saddr;
 }
diff --git a/block/nfs.c b/block/nfs.c
index 6935b611cc..743ca0450e 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -556,20 +556,17 @@ static BlockdevOptionsNfs *nfs_options_qdict_to_qapi(QDict *options,
                                                      Error **errp)
 {
     BlockdevOptionsNfs *opts = NULL;
-    QObject *crumpled = NULL;
     Visitor *v;
     const QDictEntry *e;
     Error *local_err = NULL;
 
-    crumpled = qdict_crumple_for_keyval_qiv(options, errp);
-    if (crumpled == NULL) {
+    v = qobject_input_visitor_new_flat_confused(options, errp);
+    if (!v) {
         return NULL;
     }
 
-    v = qobject_input_visitor_new_keyval(crumpled);
     visit_type_BlockdevOptionsNfs(v, NULL, &opts, &local_err);
     visit_free(v);
-    qobject_unref(crumpled);
 
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/block/parallels.c b/block/parallels.c
index ceb7a15d62..fd215e202a 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -617,7 +617,6 @@ static int coroutine_fn parallels_co_create_opts(const char *filename,
     Error *local_err = NULL;
     BlockDriverState *bs = NULL;
     QDict *qdict;
-    QObject *qobj;
     Visitor *v;
     int ret;
 
@@ -653,14 +652,12 @@ static int coroutine_fn parallels_co_create_opts(const char *filename,
     qdict_put_str(qdict, "driver", "parallels");
     qdict_put_str(qdict, "file", bs->node_name);
 
-    qobj = qdict_crumple_for_keyval_qiv(qdict, errp);
-    if (!qobj) {
+    v = qobject_input_visitor_new_flat_confused(qdict, errp);
+    if (!v) {
         ret = -EINVAL;
         goto done;
     }
 
-    v = qobject_input_visitor_new_keyval(qobj);
-    qobject_unref(qobj);
     visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_err);
     visit_free(v);
 
diff --git a/block/qcow.c b/block/qcow.c
index 2f81f081fd..5532731b9f 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -947,7 +947,6 @@ static int coroutine_fn qcow_co_create_opts(const char *filename,
     BlockdevCreateOptions *create_options = NULL;
     BlockDriverState *bs = NULL;
     QDict *qdict;
-    QObject *qobj;
     Visitor *v;
     const char *val;
     Error *local_err = NULL;
@@ -997,14 +996,12 @@ static int coroutine_fn qcow_co_create_opts(const char *filename,
     qdict_put_str(qdict, "driver", "qcow");
     qdict_put_str(qdict, "file", bs->node_name);
 
-    qobj = qdict_crumple_for_keyval_qiv(qdict, errp);
-    if (!qobj) {
+    v = qobject_input_visitor_new_flat_confused(qdict, errp);
+    if (!v) {
         ret = -EINVAL;
         goto fail;
     }
 
-    v = qobject_input_visitor_new_keyval(qobj);
-    qobject_unref(qobj);
     visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_err);
     visit_free(v);
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 8c338661db..945132f692 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3081,7 +3081,6 @@ static int coroutine_fn qcow2_co_create_opts(const char *filename, QemuOpts *opt
 {
     BlockdevCreateOptions *create_options = NULL;
     QDict *qdict;
-    QObject *qobj;
     Visitor *v;
     BlockDriverState *bs = NULL;
     Error *local_err = NULL;
@@ -3152,14 +3151,12 @@ static int coroutine_fn qcow2_co_create_opts(const char *filename, QemuOpts *opt
     qdict_put_str(qdict, "file", bs->node_name);
 
     /* Now get the QAPI type BlockdevCreateOptions */
-    qobj = qdict_crumple_for_keyval_qiv(qdict, errp);
-    if (!qobj) {
+    v = qobject_input_visitor_new_flat_confused(qdict, errp);
+    if (!v) {
         ret = -EINVAL;
         goto finish;
     }
 
-    v = qobject_input_visitor_new_keyval(qobj);
-    qobject_unref(qobj);
     visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_err);
     visit_free(v);
 
diff --git a/block/qed.c b/block/qed.c
index fcec760b26..2363814538 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -723,7 +723,6 @@ static int coroutine_fn bdrv_qed_co_create_opts(const char *filename,
 {
     BlockdevCreateOptions *create_options = NULL;
     QDict *qdict;
-    QObject *qobj;
     Visitor *v;
     BlockDriverState *bs = NULL;
     Error *local_err = NULL;
@@ -763,14 +762,12 @@ static int coroutine_fn bdrv_qed_co_create_opts(const char *filename,
     qdict_put_str(qdict, "driver", "qed");
     qdict_put_str(qdict, "file", bs->node_name);
 
-    qobj = qdict_crumple_for_keyval_qiv(qdict, errp);
-    if (!qobj) {
+    v = qobject_input_visitor_new_flat_confused(qdict, errp);
+    if (!v) {
         ret = -EINVAL;
         goto fail;
     }
 
-    v = qobject_input_visitor_new_keyval(qobj);
-    qobject_unref(qobj);
     visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_err);
     visit_free(v);
 
diff --git a/block/rbd.c b/block/rbd.c
index 09720e97c0..82346a2a5e 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -630,7 +630,6 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
     BDRVRBDState *s = bs->opaque;
     BlockdevOptionsRbd *opts = NULL;
     Visitor *v;
-    QObject *crumpled = NULL;
     const QDictEntry *e;
     Error *local_err = NULL;
     char *keypairs, *secretid;
@@ -647,16 +646,14 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     /* Convert the remaining options into a QAPI object */
-    crumpled = qdict_crumple_for_keyval_qiv(options, errp);
-    if (crumpled == NULL) {
+    v = qobject_input_visitor_new_flat_confused(options, errp);
+    if (!v) {
         r = -EINVAL;
         goto out;
     }
 
-    v = qobject_input_visitor_new_keyval(crumpled);
     visit_type_BlockdevOptionsRbd(v, NULL, &opts, &local_err);
     visit_free(v);
-    qobject_unref(crumpled);
 
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 29e3e1eaaa..665b1763eb 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -539,19 +539,17 @@ static void sd_aio_setup(SheepdogAIOCB *acb, BDRVSheepdogState *s,
 static SocketAddress *sd_server_config(QDict *options, Error **errp)
 {
     QDict *server = NULL;
-    QObject *crumpled_server = NULL;
     Visitor *iv = NULL;
     SocketAddress *saddr = NULL;
     Error *local_err = NULL;
 
     qdict_extract_subqdict(options, &server, "server.");
 
-    crumpled_server = qdict_crumple_for_keyval_qiv(server, errp);
-    if (!crumpled_server) {
+    iv = qobject_input_visitor_new_flat_confused(server, errp);
+    if (!iv) {
         goto done;
     }
 
-    iv = qobject_input_visitor_new_keyval(crumpled_server);
     visit_type_SocketAddress(iv, NULL, &saddr, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -560,7 +558,6 @@ static SocketAddress *sd_server_config(QDict *options, Error **errp)
 
 done:
     visit_free(iv);
-    qobject_unref(crumpled_server);
     qobject_unref(server);
     return saddr;
 }
@@ -2173,7 +2170,6 @@ static int coroutine_fn sd_co_create_opts(const char *filename, QemuOpts *opts,
 {
     BlockdevCreateOptions *create_options = NULL;
     QDict *qdict, *location_qdict;
-    QObject *crumpled;
     Visitor *v;
     char *redundancy;
     Error *local_err = NULL;
@@ -2209,16 +2205,14 @@ static int coroutine_fn sd_co_create_opts(const char *filename, QemuOpts *opts,
     }
 
     /* Get the QAPI object */
-    crumpled = qdict_crumple_for_keyval_qiv(qdict, errp);
-    if (crumpled == NULL) {
+    v = qobject_input_visitor_new_flat_confused(qdict, errp);
+    if (!v) {
         ret = -EINVAL;
         goto fail;
     }
 
-    v = qobject_input_visitor_new_keyval(crumpled);
     visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_err);
     visit_free(v);
-    qobject_unref(crumpled);
 
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/block/ssh.c b/block/ssh.c
index bd85d989d5..da7bbf73e2 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -606,7 +606,6 @@ static BlockdevOptionsSsh *ssh_parse_options(QDict *options, Error **errp)
     BlockdevOptionsSsh *result = NULL;
     QemuOpts *opts = NULL;
     Error *local_err = NULL;
-    QObject *crumpled;
     const QDictEntry *e;
     Visitor *v;
 
@@ -623,15 +622,13 @@ static BlockdevOptionsSsh *ssh_parse_options(QDict *options, Error **errp)
     }
 
     /* Create the QAPI object */
-    crumpled = qdict_crumple_for_keyval_qiv(options, errp);
-    if (crumpled == NULL) {
+    v = qobject_input_visitor_new_flat_confused(options, errp);
+    if (!v) {
         goto fail;
     }
 
-    v = qobject_input_visitor_new_keyval(crumpled);
     visit_type_BlockdevOptionsSsh(v, NULL, &result, &local_err);
     visit_free(v);
-    qobject_unref(crumpled);
 
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/block/vhdx.c b/block/vhdx.c
index f2aec3d2cd..a677703a9e 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1966,7 +1966,6 @@ static int coroutine_fn vhdx_co_create_opts(const char *filename,
 {
     BlockdevCreateOptions *create_options = NULL;
     QDict *qdict;
-    QObject *qobj;
     Visitor *v;
     BlockDriverState *bs = NULL;
     Error *local_err = NULL;
@@ -2005,14 +2004,12 @@ static int coroutine_fn vhdx_co_create_opts(const char *filename,
     qdict_put_str(qdict, "driver", "vhdx");
     qdict_put_str(qdict, "file", bs->node_name);
 
-    qobj = qdict_crumple_for_keyval_qiv(qdict, errp);
-    if (!qobj) {
+    v = qobject_input_visitor_new_flat_confused(qdict, errp);
+    if (!v) {
         ret = -EINVAL;
         goto fail;
     }
 
-    v = qobject_input_visitor_new_keyval(qobj);
-    qobject_unref(qobj);
     visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_err);
     visit_free(v);
 
diff --git a/block/vpc.c b/block/vpc.c
index a9bb04149d..bf294abfa7 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -1082,7 +1082,6 @@ static int coroutine_fn vpc_co_create_opts(const char *filename,
 {
     BlockdevCreateOptions *create_options = NULL;
     QDict *qdict;
-    QObject *qobj;
     Visitor *v;
     BlockDriverState *bs = NULL;
     Error *local_err = NULL;
@@ -1119,14 +1118,12 @@ static int coroutine_fn vpc_co_create_opts(const char *filename,
     qdict_put_str(qdict, "driver", "vpc");
     qdict_put_str(qdict, "file", bs->node_name);
 
-    qobj = qdict_crumple_for_keyval_qiv(qdict, errp);
-    if (!qobj) {
+    v = qobject_input_visitor_new_flat_confused(qdict, errp);
+    if (!v) {
         ret = -EINVAL;
         goto fail;
     }
 
-    v = qobject_input_visitor_new_keyval(qobj);
-    qobject_unref(qobj);
     visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_err);
     visit_free(v);
 
diff --git a/include/block/qdict.h b/include/block/qdict.h
index 47d9638c37..d8cb502d7d 100644
--- a/include/block/qdict.h
+++ b/include/block/qdict.h
@@ -21,7 +21,6 @@ void qdict_extract_subqdict(QDict *src, QDict **dst, const char *start);
 void qdict_array_split(QDict *src, QList **dst);
 int qdict_array_entries(QDict *src, const char *subqdict);
 QObject *qdict_crumple(const QDict *src, Error **errp);
-QObject *qdict_crumple_for_keyval_qiv(QDict *qdict, Error **errp);
 void qdict_flatten(QDict *qdict);
 
 typedef struct QDictRenames {
@@ -30,4 +29,6 @@ typedef struct QDictRenames {
 } QDictRenames;
 bool qdict_rename_keys(QDict *qdict, const QDictRenames *renames, Error **errp);
 
+Visitor *qobject_input_visitor_new_flat_confused(QDict *qdict,
+                                                 Error **errp);
 #endif
diff --git a/qobject/block-qdict.c b/qobject/block-qdict.c
index aba372c2eb..41f39abc4a 100644
--- a/qobject/block-qdict.c
+++ b/qobject/block-qdict.c
@@ -13,6 +13,7 @@
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
+#include "qapi/qobject-input-visitor.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 
@@ -529,7 +530,7 @@ QObject *qdict_crumple(const QDict *src, Error **errp)
  * used for anything else, and it should go away once the block
  * subsystem has been cleaned up.
  */
-QObject *qdict_crumple_for_keyval_qiv(QDict *src, Error **errp)
+static QObject *qdict_crumple_for_keyval_qiv(QDict *src, Error **errp)
 {
     QDict *tmp = NULL;
     char *buf;
@@ -695,3 +696,28 @@ bool qdict_rename_keys(QDict *qdict, const QDictRenames *renames, Error **errp)
     }
     return true;
 }
+
+/*
+ * Create a QObject input visitor for flat @qdict with possibly
+ * confused scalar types.
+ *
+ * The block subsystem uses this function to visit its flat QDict with
+ * possibly confused scalar types.  It should not be used for anything
+ * else, and it should go away once the block subsystem has been
+ * cleaned up.
+ */
+Visitor *qobject_input_visitor_new_flat_confused(QDict *qdict,
+                                                 Error **errp)
+{
+    QObject *crumpled;
+    Visitor *v;
+
+    crumpled = qdict_crumple_for_keyval_qiv(qdict, errp);
+    if (!crumpled) {
+        return NULL;
+    }
+
+    v = qobject_input_visitor_new_keyval(crumpled);
+    qobject_unref(crumpled);
+    return v;
+}
-- 
2.17.1
