Received: from eggs.gnu.org ([2001:4830:134:3::10]:56352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fiLQo-00066R-6D
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 11:10:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fiLQl-0003Fx-3U
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 11:10:26 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 25 Jul 2018 17:10:11 +0200
Message-Id: <20180725151011.25951-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH] rbd: Don't convert keypairs to JSON and
 back
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

qemu_rbd_parse_filename() builds a keypairs QList, converts it to JSON, and
stores the resulting QString in a QDict.

qemu_rbd_co_create_opts() and qemu_rbd_open() get the QString from the
QDict, pass it to qemu_rbd_set_keypairs(), which converts it back into
a QList.

Drop both conversions, store the QList instead.

This affects output of qemu-img info.  Before this patch:

    $ qemu-img info rbd:rbd/testimg.raw:mon_host=192.168.15.180:rbd_cache=true:conf=/tmp/ceph.conf
    [junk printed by Ceph library code...]
    image: json:{"driver": "raw", "file": {"pool": "rbd", "image": "testimg.raw", "conf": "/tmp/ceph.conf", "driver": "rbd", "=keyvalue-pairs": "[\"mon_host\", \"192.168.15.180\", \"rbd_cache\", \"true\"]"}}
    [more output, not interesting here]

After this patch, we get

    image: json:{"driver": "raw", "file": {"pool": "rbd", "image": "testimg.raw", "conf": "/tmp/ceph.conf", "driver": "rbd", "=keyvalue-pairs": ["mon_host", "192.168.15.180", "rbd_cache", "true"]}}

The value of member "=keyvalue-pairs" changes from a string containing
a JSON array to that JSON array.  That's an improvement of sorts.  However:

* Should "=keyvalue-pairs" even be visible here?  It's supposed to be
  purely internal...

* Is this a stable interface we need to preserve, warts and all?

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/rbd.c | 50 ++++++++++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index ca8e5bbace..ddc59e1c7a 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -23,7 +23,6 @@
 #include "qemu/cutils.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-visit-block-core.h"
@@ -106,7 +105,7 @@ typedef struct BDRVRBDState {
 
 static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
                             BlockdevOptionsRbd *opts, bool cache,
-                            const char *keypairs, const char *secretid,
+                            QList *keypairs, const char *secretid,
                             Error **errp);
 
 static char *qemu_rbd_next_tok(char *src, char delim, char **p)
@@ -221,13 +220,11 @@ static void qemu_rbd_parse_filename(const char *filename, QDict *options,
     }
 
     if (keypairs) {
-        qdict_put(options, "=keyvalue-pairs",
-                  qobject_to_json(QOBJECT(keypairs)));
+        qdict_put(options, "=keyvalue-pairs", keypairs);
     }
 
 done:
     g_free(buf);
-    qobject_unref(keypairs);
     return;
 }
 
@@ -281,42 +278,36 @@ static int qemu_rbd_set_auth(rados_t cluster, BlockdevOptionsRbd *opts,
     return 0;
 }
 
-static int qemu_rbd_set_keypairs(rados_t cluster, const char *keypairs_json,
+static int qemu_rbd_set_keypairs(rados_t cluster, QList *keypairs,
                                  Error **errp)
 {
-    QList *keypairs;
+    const QListEntry *entry1, *entry2;
     QString *name;
     QString *value;
     const char *key;
-    size_t remaining;
     int ret = 0;
 
-    if (!keypairs_json) {
+    if (!keypairs) {
         return ret;
     }
-    keypairs = qobject_to(QList,
-                          qobject_from_json(keypairs_json, &error_abort));
-    remaining = qlist_size(keypairs) / 2;
-    assert(remaining);
 
-    while (remaining--) {
-        name = qobject_to(QString, qlist_pop(keypairs));
-        value = qobject_to(QString, qlist_pop(keypairs));
+    entry1 = qlist_first(keypairs);
+    do {
+        entry2 = qlist_next(entry1);
+        name = qobject_to(QString, qlist_entry_obj(entry1));
+        value = qobject_to(QString, qlist_entry_obj(entry2));
         assert(name && value);
         key = qstring_get_str(name);
 
         ret = rados_conf_set(cluster, key, qstring_get_str(value));
-        qobject_unref(value);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "invalid conf option %s", key);
-            qobject_unref(name);
             ret = -EINVAL;
             break;
         }
-        qobject_unref(name);
-    }
+        entry1 = qlist_next(entry2);
+    } while(entry1);
 
-    qobject_unref(keypairs);
     return ret;
 }
 
@@ -370,7 +361,7 @@ static QemuOptsList runtime_opts = {
 
 /* FIXME Deprecate and remove keypairs or make it available in QMP. */
 static int qemu_rbd_do_create(BlockdevCreateOptions *options,
-                              const char *keypairs, const char *password_secret,
+                              QList *keypairs, const char *password_secret,
                               Error **errp)
 {
     BlockdevCreateOptionsRbd *opts = &options->u.rbd;
@@ -430,7 +421,8 @@ static int coroutine_fn qemu_rbd_co_create_opts(const char *filename,
     BlockdevCreateOptionsRbd *rbd_opts;
     BlockdevOptionsRbd *loc;
     Error *local_err = NULL;
-    const char *keypairs, *password_secret;
+    const char *password_secret;
+    QList *keypairs;
     QDict *options = NULL;
     int ret = 0;
 
@@ -470,7 +462,8 @@ static int coroutine_fn qemu_rbd_co_create_opts(const char *filename,
     loc->user     = g_strdup(qdict_get_try_str(options, "user"));
     loc->has_user = !!loc->user;
     loc->image    = g_strdup(qdict_get_try_str(options, "image"));
-    keypairs      = qdict_get_try_str(options, "=keyvalue-pairs");
+    /* non-string type, but it comes from qemu_rbd_parse_filename() */
+    keypairs      = qdict_get_qlist(options, "=keyvalue-pairs");
 
     ret = qemu_rbd_do_create(create_options, keypairs, password_secret, errp);
     if (ret < 0) {
@@ -567,7 +560,7 @@ static char *qemu_rbd_mon_host(BlockdevOptionsRbd *opts, Error **errp)
 
 static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
                             BlockdevOptionsRbd *opts, bool cache,
-                            const char *keypairs, const char *secretid,
+                            QList *keypairs, const char *secretid,
                             Error **errp)
 {
     char *mon_host = NULL;
@@ -663,10 +656,11 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
     Visitor *v;
     const QDictEntry *e;
     Error *local_err = NULL;
-    char *keypairs, *secretid;
+    QList *keypairs;
+    char *secretid;
     int r;
 
-    keypairs = g_strdup(qdict_get_try_str(options, "=keyvalue-pairs"));
+    keypairs = qobject_ref(qdict_get_qlist(options, "=keyvalue-pairs"));
     if (keypairs) {
         qdict_del(options, "=keyvalue-pairs");
     }
@@ -741,7 +735,7 @@ failed_open:
     rados_shutdown(s->cluster);
 out:
     qapi_free_BlockdevOptionsRbd(opts);
-    g_free(keypairs);
+    qobject_unref(keypairs);
     g_free(secretid);
     return r;
 }
-- 
2.17.1
