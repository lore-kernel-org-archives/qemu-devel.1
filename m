Received: from eggs.gnu.org ([2001:4830:134:3::10]:50341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSisd-0007Kl-6A
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:58:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSisa-0003Ej-A9
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:58:35 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 12 Jun 2018 14:58:10 +0200
Message-Id: <20180612125821.4229-8-armbru@redhat.com>
In-Reply-To: <20180612125821.4229-1-armbru@redhat.com>
References: <20180612125821.4229-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 07/18] block: Clean up a misuse of qobject_to()
 in .bdrv_co_create_opts()
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

The following pattern occurs in the .bdrv_co_create_opts() methods of
parallels, qcow, qcow2, qed, vhdx and vpc:

    qobj = qdict_crumple_for_keyval_qiv(qdict, errp);
    qobject_unref(qdict);
    qdict = qobject_to(QDict, qobj);
    if (qdict == NULL) {
         ret = -EINVAL;
         goto done;
    }

    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
    [...]
    ret = 0;
done:
    qobject_unref(qdict);
    [...]
    return ret;

If qobject_to() fails, we return failure without setting errp.  That's
wrong.  As far as I can tell, it cannot fail here.  Clean it up
anyway, by removing the useless conversion.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/parallels.c | 9 ++++-----
 block/qcow.c      | 9 ++++-----
 block/qcow2.c     | 9 ++++-----
 block/qed.c       | 9 ++++-----
 block/vhdx.c      | 9 ++++-----
 block/vpc.c       | 9 ++++-----
 6 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 695899fc4b..ceb7a15d62 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -616,7 +616,7 @@ static int coroutine_fn parallels_co_create_opts(const char *filename,
     BlockdevCreateOptions *create_options = NULL;
     Error *local_err = NULL;
     BlockDriverState *bs = NULL;
-    QDict *qdict = NULL;
+    QDict *qdict;
     QObject *qobj;
     Visitor *v;
     int ret;
@@ -654,14 +654,13 @@ static int coroutine_fn parallels_co_create_opts(const char *filename,
     qdict_put_str(qdict, "file", bs->node_name);
 
     qobj = qdict_crumple_for_keyval_qiv(qdict, errp);
-    qobject_unref(qdict);
-    qdict = qobject_to(QDict, qobj);
-    if (qdict == NULL) {
+    if (!qobj) {
         ret = -EINVAL;
         goto done;
     }
 
-    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    v = qobject_input_visitor_new_keyval(qobj);
+    qobject_unref(qobj);
     visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_err);
     visit_free(v);
 
diff --git a/block/qcow.c b/block/qcow.c
index 860b058240..2f81f081fd 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -946,7 +946,7 @@ static int coroutine_fn qcow_co_create_opts(const char *filename,
 {
     BlockdevCreateOptions *create_options = NULL;
     BlockDriverState *bs = NULL;
-    QDict *qdict = NULL;
+    QDict *qdict;
     QObject *qobj;
     Visitor *v;
     const char *val;
@@ -998,14 +998,13 @@ static int coroutine_fn qcow_co_create_opts(const char *filename,
     qdict_put_str(qdict, "file", bs->node_name);
 
     qobj = qdict_crumple_for_keyval_qiv(qdict, errp);
-    qobject_unref(qdict);
-    qdict = qobject_to(QDict, qobj);
-    if (qdict == NULL) {
+    if (!qobj) {
         ret = -EINVAL;
         goto fail;
     }
 
-    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    v = qobject_input_visitor_new_keyval(qobj);
+    qobject_unref(qobj);
     visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_err);
     visit_free(v);
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 0a27afa2ef..8c338661db 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3080,7 +3080,7 @@ static int coroutine_fn qcow2_co_create_opts(const char *filename, QemuOpts *opt
                                              Error **errp)
 {
     BlockdevCreateOptions *create_options = NULL;
-    QDict *qdict = NULL;
+    QDict *qdict;
     QObject *qobj;
     Visitor *v;
     BlockDriverState *bs = NULL;
@@ -3153,14 +3153,13 @@ static int coroutine_fn qcow2_co_create_opts(const char *filename, QemuOpts *opt
 
     /* Now get the QAPI type BlockdevCreateOptions */
     qobj = qdict_crumple_for_keyval_qiv(qdict, errp);
-    qobject_unref(qdict);
-    qdict = qobject_to(QDict, qobj);
-    if (qdict == NULL) {
+    if (!qobj) {
         ret = -EINVAL;
         goto finish;
     }
 
-    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    v = qobject_input_visitor_new_keyval(qobj);
+    qobject_unref(qobj);
     visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_err);
     visit_free(v);
 
diff --git a/block/qed.c b/block/qed.c
index 88fa36d409..fcec760b26 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -722,7 +722,7 @@ static int coroutine_fn bdrv_qed_co_create_opts(const char *filename,
                                                 Error **errp)
 {
     BlockdevCreateOptions *create_options = NULL;
-    QDict *qdict = NULL;
+    QDict *qdict;
     QObject *qobj;
     Visitor *v;
     BlockDriverState *bs = NULL;
@@ -764,14 +764,13 @@ static int coroutine_fn bdrv_qed_co_create_opts(const char *filename,
     qdict_put_str(qdict, "file", bs->node_name);
 
     qobj = qdict_crumple_for_keyval_qiv(qdict, errp);
-    qobject_unref(qdict);
-    qdict = qobject_to(QDict, qobj);
-    if (qdict == NULL) {
+    if (!qobj) {
         ret = -EINVAL;
         goto fail;
     }
 
-    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    v = qobject_input_visitor_new_keyval(qobj);
+    qobject_unref(qobj);
     visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_err);
     visit_free(v);
 
diff --git a/block/vhdx.c b/block/vhdx.c
index 78b29d9fc7..f2aec3d2cd 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1965,7 +1965,7 @@ static int coroutine_fn vhdx_co_create_opts(const char *filename,
                                             Error **errp)
 {
     BlockdevCreateOptions *create_options = NULL;
-    QDict *qdict = NULL;
+    QDict *qdict;
     QObject *qobj;
     Visitor *v;
     BlockDriverState *bs = NULL;
@@ -2006,14 +2006,13 @@ static int coroutine_fn vhdx_co_create_opts(const char *filename,
     qdict_put_str(qdict, "file", bs->node_name);
 
     qobj = qdict_crumple_for_keyval_qiv(qdict, errp);
-    qobject_unref(qdict);
-    qdict = qobject_to(QDict, qobj);
-    if (qdict == NULL) {
+    if (!qobj) {
         ret = -EINVAL;
         goto fail;
     }
 
-    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    v = qobject_input_visitor_new_keyval(qobj);
+    qobject_unref(qobj);
     visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_err);
     visit_free(v);
 
diff --git a/block/vpc.c b/block/vpc.c
index 16178e5a90..a9bb04149d 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -1081,7 +1081,7 @@ static int coroutine_fn vpc_co_create_opts(const char *filename,
                                            QemuOpts *opts, Error **errp)
 {
     BlockdevCreateOptions *create_options = NULL;
-    QDict *qdict = NULL;
+    QDict *qdict;
     QObject *qobj;
     Visitor *v;
     BlockDriverState *bs = NULL;
@@ -1120,14 +1120,13 @@ static int coroutine_fn vpc_co_create_opts(const char *filename,
     qdict_put_str(qdict, "file", bs->node_name);
 
     qobj = qdict_crumple_for_keyval_qiv(qdict, errp);
-    qobject_unref(qdict);
-    qdict = qobject_to(QDict, qobj);
-    if (qdict == NULL) {
+    if (!qobj) {
         ret = -EINVAL;
         goto fail;
     }
 
-    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    v = qobject_input_visitor_new_keyval(qobj);
+    qobject_unref(qobj);
     visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_err);
     visit_free(v);
 
-- 
2.17.1
