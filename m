Received: from eggs.gnu.org ([2001:4830:134:3::10]:42645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjmOK-0007zP-Qp
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:33:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjmOG-00082X-AC
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:33:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cjmOF-00080Q-S4
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:32:56 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C48C71B1765
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 12:32:55 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  3 Mar 2017 13:32:39 +0100
Message-Id: <1488544368-30622-20-git-send-email-armbru@redhat.com>
In-Reply-To: <1488544368-30622-1-git-send-email-armbru@redhat.com>
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v4 19/28] qapi: Drop unused non-strict qobject
 input visitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The split between tests/test-qobject-input-visitor.c and
tests/test-qobject-input-strict.c now makes less sense than ever.  The
next commit will take care of that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/nbd.c                          |  2 +-
 block/nfs.c                          |  2 +-
 block/ssh.c                          |  2 +-
 docs/qapi-code-gen.txt               |  2 +-
 include/qapi/qobject-input-visitor.h |  5 +----
 qapi/qobject-input-visitor.c         | 28 ++++++++++------------------
 qmp.c                                |  2 +-
 qom/qom-qobject.c                    |  2 +-
 scripts/qapi-commands.py             |  2 +-
 target/s390x/cpu_models.c            |  2 +-
 tests/check-qnull.c                  |  2 +-
 tests/qmp-test.c                     |  2 +-
 tests/test-qmp-commands.c            |  2 +-
 tests/test-qobject-input-strict.c    |  2 +-
 tests/test-qobject-input-visitor.c   |  2 +-
 tests/test-visitor-serialization.c   |  2 +-
 16 files changed, 25 insertions(+), 36 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index a7f9108..f478f80 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -278,7 +278,7 @@ static SocketAddress *nbd_config(BDRVNBDState *s, QDict *options, Error **errp)
         goto done;
     }
 
-    iv = qobject_input_visitor_new(crumpled_addr, true);
+    iv = qobject_input_visitor_new(crumpled_addr);
     visit_type_SocketAddress(iv, NULL, &saddr, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/block/nfs.c b/block/nfs.c
index 890d5d4..3f43f6e 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -474,7 +474,7 @@ static NFSServer *nfs_config(QDict *options, Error **errp)
         goto out;
     }
 
-    iv = qobject_input_visitor_new(crumpled_addr, true);
+    iv = qobject_input_visitor_new(crumpled_addr);
     visit_type_NFSServer(iv, NULL, &server, &local_error);
     if (local_error) {
         error_propagate(errp, local_error);
diff --git a/block/ssh.c b/block/ssh.c
index 835932e..278e66f 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -601,7 +601,7 @@ static InetSocketAddress *ssh_config(QDict *options, Error **errp)
         goto out;
     }
 
-    iv = qobject_input_visitor_new(crumpled_addr, true);
+    iv = qobject_input_visitor_new(crumpled_addr);
     visit_type_InetSocketAddress(iv, NULL, &inet, &local_error);
     if (local_error) {
         error_propagate(errp, local_error);
diff --git a/docs/qapi-code-gen.txt b/docs/qapi-code-gen.txt
index 7eb7be1..6746c10 100644
--- a/docs/qapi-code-gen.txt
+++ b/docs/qapi-code-gen.txt
@@ -1138,7 +1138,7 @@ Example:
         Visitor *v;
         UserDefOneList *arg1 = NULL;
 
-        v = qobject_input_visitor_new(QOBJECT(args), true);
+        v = qobject_input_visitor_new(QOBJECT(args));
         visit_start_struct(v, NULL, NULL, 0, &err);
         if (err) {
             goto out;
diff --git a/include/qapi/qobject-input-visitor.h b/include/qapi/qobject-input-visitor.h
index cde328d..21db9c4 100644
--- a/include/qapi/qobject-input-visitor.h
+++ b/include/qapi/qobject-input-visitor.h
@@ -21,10 +21,7 @@ typedef struct QObjectInputVisitor QObjectInputVisitor;
 
 /*
  * Return a new input visitor that converts a QObject to a QAPI object.
- *
- * Set @strict to reject a parse that doesn't consume all keys of a
- * dictionary; otherwise excess input is ignored.
  */
-Visitor *qobject_input_visitor_new(QObject *obj, bool strict);
+Visitor *qobject_input_visitor_new(QObject *obj);
 
 #endif
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 8015a98..eafcdf4 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -43,9 +43,6 @@ struct QObjectInputVisitor {
      * QDict or QList). */
     QSLIST_HEAD(, StackObject) stack;
 
-    /* True to reject parse in visit_end_struct() if unvisited keys remain. */
-    bool strict;
-
     GString *errname;           /* Accumulator for full_name() */
 };
 
@@ -157,11 +154,12 @@ static const QListEntry *qobject_input_push(QObjectInputVisitor *qiv,
     tos->obj = obj;
     tos->qapi = qapi;
 
-    if (qiv->strict && qobject_type(obj) == QTYPE_QDICT) {
+    if (qobject_type(obj) == QTYPE_QDICT) {
         h = g_hash_table_new(g_str_hash, g_str_equal);
         qdict_iter(qobject_to_qdict(obj), qdict_add_key, h);
         tos->h = h;
-    } else if (qobject_type(obj) == QTYPE_QLIST) {
+    } else {
+        assert(qobject_type(obj) == QTYPE_QLIST);
         tos->entry = qlist_first(qobject_to_qlist(obj));
         tos->index = -1;
     }
@@ -175,20 +173,15 @@ static void qobject_input_check_struct(Visitor *v, Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
     StackObject *tos = QSLIST_FIRST(&qiv->stack);
+    GHashTableIter iter;
+    const char *key;
 
     assert(tos && !tos->entry);
-    if (qiv->strict) {
-        GHashTable *const top_ht = tos->h;
-        if (top_ht) {
-            GHashTableIter iter;
-            const char *key;
 
-            g_hash_table_iter_init(&iter, top_ht);
-            if (g_hash_table_iter_next(&iter, (void **)&key, NULL)) {
-                error_setg(errp, "Parameter '%s' is unexpected",
-                           full_name(qiv, key));
-            }
-        }
+    g_hash_table_iter_init(&iter, tos->h);
+    if (g_hash_table_iter_next(&iter, (void **)&key, NULL)) {
+        error_setg(errp, "Parameter '%s' is unexpected",
+                   full_name(qiv, key));
     }
 }
 
@@ -465,7 +458,7 @@ static void qobject_input_free(Visitor *v)
     g_free(qiv);
 }
 
-Visitor *qobject_input_visitor_new(QObject *obj, bool strict)
+Visitor *qobject_input_visitor_new(QObject *obj)
 {
     QObjectInputVisitor *v;
 
@@ -489,7 +482,6 @@ Visitor *qobject_input_visitor_new(QObject *obj, bool strict)
     v->visitor.type_null = qobject_input_type_null;
     v->visitor.optional = qobject_input_optional;
     v->visitor.free = qobject_input_free;
-    v->strict = strict;
 
     v->root = obj;
     qobject_incref(obj);
diff --git a/qmp.c b/qmp.c
index dfaabac..fa82b59 100644
--- a/qmp.c
+++ b/qmp.c
@@ -675,7 +675,7 @@ void qmp_object_add(const char *type, const char *id,
         pdict = qdict_new();
     }
 
-    v = qobject_input_visitor_new(QOBJECT(pdict), true);
+    v = qobject_input_visitor_new(QOBJECT(pdict));
     obj = user_creatable_add_type(type, id, pdict, v, errp);
     visit_free(v);
     if (obj) {
diff --git a/qom/qom-qobject.c b/qom/qom-qobject.c
index bbdedda..4aec20d 100644
--- a/qom/qom-qobject.c
+++ b/qom/qom-qobject.c
@@ -23,7 +23,7 @@ void object_property_set_qobject(Object *obj, QObject *value,
 {
     Visitor *v;
 
-    v = qobject_input_visitor_new(value, true);
+    v = qobject_input_visitor_new(value);
     object_property_set(obj, v, name, errp);
     visit_free(v);
 }
diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
index 2b062ad..0c05449 100644
--- a/scripts/qapi-commands.py
+++ b/scripts/qapi-commands.py
@@ -130,7 +130,7 @@ def gen_marshal(name, arg_type, boxed, ret_type):
         push_indent()
 
     ret += mcgen('''
-    v = qobject_input_visitor_new(QOBJECT(args), true);
+    v = qobject_input_visitor_new(QOBJECT(args));
     visit_start_struct(v, NULL, NULL, 0, &err);
     if (err) {
         goto out;
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 2a894ee..4ea3a2d 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -346,7 +346,7 @@ static void cpu_model_from_info(S390CPUModel *model, const CpuModelInfo *info,
     }
 
     if (qdict) {
-        visitor = qobject_input_visitor_new(info->props, true);
+        visitor = qobject_input_visitor_new(info->props);
         visit_start_struct(visitor, NULL, NULL, 0, errp);
         if (*errp) {
             object_unref(obj);
diff --git a/tests/check-qnull.c b/tests/check-qnull.c
index b50bb8a..8dd1c96 100644
--- a/tests/check-qnull.c
+++ b/tests/check-qnull.c
@@ -47,7 +47,7 @@ static void qnull_visit_test(void)
 
     g_assert(qnull_.refcnt == 1);
     obj = qnull();
-    v = qobject_input_visitor_new(obj, true);
+    v = qobject_input_visitor_new(obj);
     qobject_decref(obj);
     visit_type_null(v, NULL, &error_abort);
     visit_free(v);
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 405e49e..5d0260b 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -34,7 +34,7 @@ static void test_version(QObject *version)
     VersionInfo *vinfo;
 
     g_assert(version);
-    v = qobject_input_visitor_new(version, true);
+    v = qobject_input_visitor_new(version);
     visit_type_VersionInfo(v, "version", &vinfo, &error_abort);
     qapi_free_VersionInfo(vinfo);
     visit_free(v);
diff --git a/tests/test-qmp-commands.c b/tests/test-qmp-commands.c
index 1cf413b..0f81a98 100644
--- a/tests/test-qmp-commands.c
+++ b/tests/test-qmp-commands.c
@@ -246,7 +246,7 @@ static void test_dealloc_partial(void)
         ud2_dict = qdict_new();
         qdict_put_obj(ud2_dict, "string0", QOBJECT(qstring_from_str(text)));
 
-        v = qobject_input_visitor_new(QOBJECT(ud2_dict), true);
+        v = qobject_input_visitor_new(QOBJECT(ud2_dict));
         visit_type_UserDefTwo(v, NULL, &ud2, &err);
         visit_free(v);
         QDECREF(ud2_dict);
diff --git a/tests/test-qobject-input-strict.c b/tests/test-qobject-input-strict.c
index 4087ea3..7d26113 100644
--- a/tests/test-qobject-input-strict.c
+++ b/tests/test-qobject-input-strict.c
@@ -53,7 +53,7 @@ static Visitor *validate_test_init_internal(TestInputVisitorData *data,
     data->obj = qobject_from_jsonv(json_string, ap);
     g_assert(data->obj);
 
-    data->qiv = qobject_input_visitor_new(data->obj, true);
+    data->qiv = qobject_input_visitor_new(data->obj);
     g_assert(data->qiv);
     return data->qiv;
 }
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-visitor.c
index 125e34c..658fa2c 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -49,7 +49,7 @@ static Visitor *visitor_input_test_init_internal(TestInputVisitorData *data,
     data->obj = qobject_from_jsonv(json_string, ap);
     g_assert(data->obj);
 
-    data->qiv = qobject_input_visitor_new(data->obj, true);
+    data->qiv = qobject_input_visitor_new(data->obj);
     g_assert(data->qiv);
     return data->qiv;
 }
diff --git a/tests/test-visitor-serialization.c b/tests/test-visitor-serialization.c
index 66b2b1c..c7e64f0 100644
--- a/tests/test-visitor-serialization.c
+++ b/tests/test-visitor-serialization.c
@@ -1040,7 +1040,7 @@ static void qmp_deserialize(void **native_out, void *datap,
     obj = qobject_from_json(qstring_get_str(output_json));
 
     QDECREF(output_json);
-    d->qiv = qobject_input_visitor_new(obj, true);
+    d->qiv = qobject_input_visitor_new(obj);
     qobject_decref(obj_orig);
     qobject_decref(obj);
     visit(d->qiv, native_out, errp);
-- 
2.7.4
