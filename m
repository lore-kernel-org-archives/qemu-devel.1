Received: from eggs.gnu.org ([2001:4830:134:3::10]:59227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTpbb-00069P-8a
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:21:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTpbU-0003fH-9i
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:21:35 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 15 Jun 2018 16:20:51 +0200
Message-Id: <20180615142108.27814-10-kwolf@redhat.com>
In-Reply-To: <20180615142108.27814-1-kwolf@redhat.com>
References: <20180615142108.27814-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 09/26] block: Fix -blockdev for certain
 non-string scalars
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

From: Markus Armbruster <armbru@redhat.com>

Configuration flows through the block subsystem in a rather peculiar
way.  Configuration made with -drive enters it as QemuOpts.
Configuration made with -blockdev / blockdev-add enters it as QAPI
type BlockdevOptions.  The block subsystem uses QDict, QemuOpts and
QAPI types internally.  The precise flow is next to impossible to
explain (I tried for this commit message, but gave up after wasting
several hours).  What I can explain is a flaw in the BlockDriver
interface that leads to this bug:

    $ qemu-system-x86_64 -blockdev node-name=n1,driver=nfs,server.type=inet,server.host=localhost,path=/foo/bar,user=1234
    qemu-system-x86_64: -blockdev node-name=n1,driver=nfs,server.type=inet,server.host=localhost,path=/foo/bar,user=1234: Internal error: parameter user invalid

QMP blockdev-add is broken the same way.

Here's what happens.  The block layer passes configuration represented
as flat QDict (with dotted keys) to BlockDriver methods
.bdrv_file_open().  The QDict's members are typed according to the
QAPI schema.

nfs_file_open() converts it to QAPI type BlockdevOptionsNfs, with
qdict_crumple() and a qobject input visitor.

This visitor comes in two flavors.  The plain flavor requires scalars
to be typed according to the QAPI schema.  That's the case here.  The
keyval flavor requires string scalars.  That's not the case here.
nfs_file_open() uses the latter, and promptly falls apart for members
@user, @group, @tcp-syn-count, @readahead-size, @page-cache-size,
@debug.

Switching to the plain flavor would fix -blockdev, but break -drive,
because there the scalars arrive in nfs_file_open() as strings.

The proper fix would be to replace the QDict by QAPI type
BlockdevOptions in the BlockDriver interface.  Sadly, that's beyond my
reach right now.

Next best would be to fix the block layer to always pass correctly
typed QDicts to the BlockDriver methods.  Also beyond my reach.

What I can do is throw another hack onto the pile: have
nfs_file_open() convert all members to string, so use of the keyval
flavor actually works, by replacing qdict_crumple() by new function
qdict_crumple_for_keyval_qiv().

The pattern "pass result of qdict_crumple() to
qobject_input_visitor_new_keyval()" occurs several times more:

* qemu_rbd_open()

  Same issue as nfs_file_open(), but since BlockdevOptionsRbd has only
  string members, its only a latent bug.  Fix it anyway.

* parallels_co_create_opts(), qcow_co_create_opts(),
  qcow2_co_create_opts(), bdrv_qed_co_create_opts(),
  sd_co_create_opts(), vhdx_co_create_opts(), vpc_co_create_opts()

  These work, because they create the QDict with
  qemu_opts_to_qdict_filtered(), which creates only string scalars.
  The function sports a TODO comment asking for better typing; that's
  going to be fun.  Use qdict_crumple_for_keyval_qiv() to be safe.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/qdict.h |  1 +
 block/nfs.c           |  2 +-
 block/parallels.c     |  2 +-
 block/qcow.c          |  2 +-
 block/qcow2.c         |  2 +-
 block/qed.c           |  2 +-
 block/rbd.c           |  2 +-
 block/sheepdog.c      |  2 +-
 block/vhdx.c          |  2 +-
 block/vpc.c           |  2 +-
 qobject/block-qdict.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++
 11 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/include/block/qdict.h b/include/block/qdict.h
index 71c037afba..47d9638c37 100644
--- a/include/block/qdict.h
+++ b/include/block/qdict.h
@@ -21,6 +21,7 @@ void qdict_extract_subqdict(QDict *src, QDict **dst, const char *start);
 void qdict_array_split(QDict *src, QList **dst);
 int qdict_array_entries(QDict *src, const char *subqdict);
 QObject *qdict_crumple(const QDict *src, Error **errp);
+QObject *qdict_crumple_for_keyval_qiv(QDict *qdict, Error **errp);
 void qdict_flatten(QDict *qdict);
 
 typedef struct QDictRenames {
diff --git a/block/nfs.c b/block/nfs.c
index 3170b059b3..6935b611cc 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -561,7 +561,7 @@ static BlockdevOptionsNfs *nfs_options_qdict_to_qapi(QDict *options,
     const QDictEntry *e;
     Error *local_err = NULL;
 
-    crumpled = qdict_crumple(options, errp);
+    crumpled = qdict_crumple_for_keyval_qiv(options, errp);
     if (crumpled == NULL) {
         return NULL;
     }
diff --git a/block/parallels.c b/block/parallels.c
index c1d9643498..695899fc4b 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -653,7 +653,7 @@ static int coroutine_fn parallels_co_create_opts(const char *filename,
     qdict_put_str(qdict, "driver", "parallels");
     qdict_put_str(qdict, "file", bs->node_name);
 
-    qobj = qdict_crumple(qdict, errp);
+    qobj = qdict_crumple_for_keyval_qiv(qdict, errp);
     qobject_unref(qdict);
     qdict = qobject_to(QDict, qobj);
     if (qdict == NULL) {
diff --git a/block/qcow.c b/block/qcow.c
index 8c08908fd8..860b058240 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -997,7 +997,7 @@ static int coroutine_fn qcow_co_create_opts(const char *filename,
     qdict_put_str(qdict, "driver", "qcow");
     qdict_put_str(qdict, "file", bs->node_name);
 
-    qobj = qdict_crumple(qdict, errp);
+    qobj = qdict_crumple_for_keyval_qiv(qdict, errp);
     qobject_unref(qdict);
     qdict = qobject_to(QDict, qobj);
     if (qdict == NULL) {
diff --git a/block/qcow2.c b/block/qcow2.c
index d2d955f984..0a27afa2ef 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3152,7 +3152,7 @@ static int coroutine_fn qcow2_co_create_opts(const char *filename, QemuOpts *opt
     qdict_put_str(qdict, "file", bs->node_name);
 
     /* Now get the QAPI type BlockdevCreateOptions */
-    qobj = qdict_crumple(qdict, errp);
+    qobj = qdict_crumple_for_keyval_qiv(qdict, errp);
     qobject_unref(qdict);
     qdict = qobject_to(QDict, qobj);
     if (qdict == NULL) {
diff --git a/block/qed.c b/block/qed.c
index 324a953cbc..88fa36d409 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -763,7 +763,7 @@ static int coroutine_fn bdrv_qed_co_create_opts(const char *filename,
     qdict_put_str(qdict, "driver", "qed");
     qdict_put_str(qdict, "file", bs->node_name);
 
-    qobj = qdict_crumple(qdict, errp);
+    qobj = qdict_crumple_for_keyval_qiv(qdict, errp);
     qobject_unref(qdict);
     qdict = qobject_to(QDict, qobj);
     if (qdict == NULL) {
diff --git a/block/rbd.c b/block/rbd.c
index 9659c7361f..09720e97c0 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -647,7 +647,7 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     /* Convert the remaining options into a QAPI object */
-    crumpled = qdict_crumple(options, errp);
+    crumpled = qdict_crumple_for_keyval_qiv(options, errp);
     if (crumpled == NULL) {
         r = -EINVAL;
         goto out;
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 2e1f0e6eca..a93f93d360 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -2217,7 +2217,7 @@ static int coroutine_fn sd_co_create_opts(const char *filename, QemuOpts *opts,
     }
 
     /* Get the QAPI object */
-    crumpled = qdict_crumple(qdict, errp);
+    crumpled = qdict_crumple_for_keyval_qiv(qdict, errp);
     if (crumpled == NULL) {
         ret = -EINVAL;
         goto fail;
diff --git a/block/vhdx.c b/block/vhdx.c
index 2e32e24514..78b29d9fc7 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -2005,7 +2005,7 @@ static int coroutine_fn vhdx_co_create_opts(const char *filename,
     qdict_put_str(qdict, "driver", "vhdx");
     qdict_put_str(qdict, "file", bs->node_name);
 
-    qobj = qdict_crumple(qdict, errp);
+    qobj = qdict_crumple_for_keyval_qiv(qdict, errp);
     qobject_unref(qdict);
     qdict = qobject_to(QDict, qobj);
     if (qdict == NULL) {
diff --git a/block/vpc.c b/block/vpc.c
index 41c8c980f1..16178e5a90 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -1119,7 +1119,7 @@ static int coroutine_fn vpc_co_create_opts(const char *filename,
     qdict_put_str(qdict, "driver", "vpc");
     qdict_put_str(qdict, "file", bs->node_name);
 
-    qobj = qdict_crumple(qdict, errp);
+    qobj = qdict_crumple_for_keyval_qiv(qdict, errp);
     qobject_unref(qdict);
     qdict = qobject_to(QDict, qobj);
     if (qdict == NULL) {
diff --git a/qobject/block-qdict.c b/qobject/block-qdict.c
index fb92010dc5..aba372c2eb 100644
--- a/qobject/block-qdict.c
+++ b/qobject/block-qdict.c
@@ -9,7 +9,10 @@
 
 #include "qemu/osdep.h"
 #include "block/qdict.h"
+#include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qlist.h"
+#include "qapi/qmp/qnum.h"
+#include "qapi/qmp/qstring.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 
@@ -514,6 +517,60 @@ QObject *qdict_crumple(const QDict *src, Error **errp)
 }
 
 /**
+ * qdict_crumple_for_keyval_qiv:
+ * @src: the flat dictionary (only scalar values) to crumple
+ * @errp: location to store error
+ *
+ * Like qdict_crumple(), but additionally transforms scalar values so
+ * the result can be passed to qobject_input_visitor_new_keyval().
+ *
+ * The block subsystem uses this function to prepare its flat QDict
+ * with possibly confused scalar types for a visit.  It should not be
+ * used for anything else, and it should go away once the block
+ * subsystem has been cleaned up.
+ */
+QObject *qdict_crumple_for_keyval_qiv(QDict *src, Error **errp)
+{
+    QDict *tmp = NULL;
+    char *buf;
+    const char *s;
+    const QDictEntry *ent;
+    QObject *dst;
+
+    for (ent = qdict_first(src); ent; ent = qdict_next(src, ent)) {
+        buf = NULL;
+        switch (qobject_type(ent->value)) {
+        case QTYPE_QNULL:
+        case QTYPE_QSTRING:
+            continue;
+        case QTYPE_QNUM:
+            s = buf = qnum_to_string(qobject_to(QNum, ent->value));
+            break;
+        case QTYPE_QDICT:
+        case QTYPE_QLIST:
+            /* @src isn't flat; qdict_crumple() will fail */
+            continue;
+        case QTYPE_QBOOL:
+            s = qbool_get_bool(qobject_to(QBool, ent->value))
+                ? "on" : "off";
+            break;
+        default:
+            abort();
+        }
+
+        if (!tmp) {
+            tmp = qdict_clone_shallow(src);
+        }
+        qdict_put(tmp, ent->key, qstring_from_str(s));
+        g_free(buf);
+    }
+
+    dst = qdict_crumple(tmp ?: src, errp);
+    qobject_unref(tmp);
+    return dst;
+}
+
+/**
  * qdict_array_entries(): Returns the number of direct array entries if the
  * sub-QDict of src specified by the prefix in subqdict (or src itself for
  * prefix == "") is valid as an array, i.e. the length of the created list if
-- 
2.13.6
