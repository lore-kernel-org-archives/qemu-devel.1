Received: from eggs.gnu.org ([2001:4830:134:3::10]:33622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKl1-00018F-B1
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKky-0006wv-Iy
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:35 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:19:03 +0100
Message-Id: <20180309161933.8168-27-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 26/56] qdict: Introduce qdict_rename_keys()
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

A few block drivers will need to rename .bdrv_create options for their
QAPIfication, so let's have a helper function for that.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/qmp/qdict.h |   6 +++
 qobject/qdict.c          |  34 +++++++++++++
 tests/check-qdict.c      | 129 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 169 insertions(+)

diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
index ff6f7842c3..7c6d844549 100644
--- a/include/qapi/qmp/qdict.h
+++ b/include/qapi/qmp/qdict.h
@@ -81,4 +81,10 @@ QObject *qdict_crumple(const QDict *src, Error **errp);
 
 void qdict_join(QDict *dest, QDict *src, bool overwrite);
 
+typedef struct QDictRenames {
+    const char *from;
+    const char *to;
+} QDictRenames;
+bool qdict_rename_keys(QDict *qdict, const QDictRenames *renames, Error **errp);
+
 #endif /* QDICT_H */
diff --git a/qobject/qdict.c b/qobject/qdict.c
index 23df84f9cd..229b8c840b 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -1072,3 +1072,37 @@ void qdict_join(QDict *dest, QDict *src, bool overwrite)
         entry = next;
     }
 }
+
+/**
+ * qdict_rename_keys(): Rename keys in qdict according to the replacements
+ * specified in the array renames. The array must be terminated by an entry
+ * with from = NULL.
+ *
+ * The renames are performed individually in the order of the array, so entries
+ * may be renamed multiple times and may or may not conflict depending on the
+ * order of the renames array.
+ *
+ * Returns true for success, false in error cases.
+ */
+bool qdict_rename_keys(QDict *qdict, const QDictRenames *renames, Error **errp)
+{
+    QObject *qobj;
+
+    while (renames->from) {
+        if (qdict_haskey(qdict, renames->from)) {
+            if (qdict_haskey(qdict, renames->to)) {
+                error_setg(errp, "'%s' and its alias '%s' can't be used at the "
+                           "same time", renames->to, renames->from);
+                return false;
+            }
+
+            qobj = qdict_get(qdict, renames->from);
+            qobject_incref(qobj);
+            qdict_put_obj(qdict, renames->to, qobj);
+            qdict_del(qdict, renames->from);
+        }
+
+        renames++;
+    }
+    return true;
+}
diff --git a/tests/check-qdict.c b/tests/check-qdict.c
index ec628f3453..a3faea8bfc 100644
--- a/tests/check-qdict.c
+++ b/tests/check-qdict.c
@@ -665,6 +665,133 @@ static void qdict_crumple_test_empty(void)
     QDECREF(dst);
 }
 
+static int qdict_count_entries(QDict *dict)
+{
+    const QDictEntry *e;
+    int count = 0;
+
+    for (e = qdict_first(dict); e; e = qdict_next(dict, e)) {
+        count++;
+    }
+
+    return count;
+}
+
+static void qdict_rename_keys_test(void)
+{
+    QDict *dict = qdict_new();
+    QDict *copy;
+    QDictRenames *renames;
+    Error *local_err = NULL;
+
+    qdict_put_str(dict, "abc", "foo");
+    qdict_put_str(dict, "abcdef", "bar");
+    qdict_put_int(dict, "number", 42);
+    qdict_put_bool(dict, "flag", true);
+    qdict_put_null(dict, "nothing");
+
+    /* Empty rename list */
+    renames = (QDictRenames[]) {
+        { NULL, "this can be anything" }
+    };
+    copy = qdict_clone_shallow(dict);
+    qdict_rename_keys(copy, renames, &error_abort);
+
+    g_assert_cmpstr(qdict_get_str(copy, "abc"), ==, "foo");
+    g_assert_cmpstr(qdict_get_str(copy, "abcdef"), ==, "bar");
+    g_assert_cmpint(qdict_get_int(copy, "number"), ==, 42);
+    g_assert_cmpint(qdict_get_bool(copy, "flag"), ==, true);
+    g_assert(qobject_type(qdict_get(copy, "nothing")) == QTYPE_QNULL);
+    g_assert_cmpint(qdict_count_entries(copy), ==, 5);
+
+    QDECREF(copy);
+
+    /* Simple rename of all entries */
+    renames = (QDictRenames[]) {
+        { "abc",        "str1" },
+        { "abcdef",     "str2" },
+        { "number",     "int" },
+        { "flag",       "bool" },
+        { "nothing",    "null" },
+        { NULL , NULL }
+    };
+    copy = qdict_clone_shallow(dict);
+    qdict_rename_keys(copy, renames, &error_abort);
+
+    g_assert(!qdict_haskey(copy, "abc"));
+    g_assert(!qdict_haskey(copy, "abcdef"));
+    g_assert(!qdict_haskey(copy, "number"));
+    g_assert(!qdict_haskey(copy, "flag"));
+    g_assert(!qdict_haskey(copy, "nothing"));
+
+    g_assert_cmpstr(qdict_get_str(copy, "str1"), ==, "foo");
+    g_assert_cmpstr(qdict_get_str(copy, "str2"), ==, "bar");
+    g_assert_cmpint(qdict_get_int(copy, "int"), ==, 42);
+    g_assert_cmpint(qdict_get_bool(copy, "bool"), ==, true);
+    g_assert(qobject_type(qdict_get(copy, "null")) == QTYPE_QNULL);
+    g_assert_cmpint(qdict_count_entries(copy), ==, 5);
+
+    QDECREF(copy);
+
+    /* Renames are processed top to bottom */
+    renames = (QDictRenames[]) {
+        { "abc",        "tmp" },
+        { "abcdef",     "abc" },
+        { "number",     "abcdef" },
+        { "flag",       "number" },
+        { "nothing",    "flag" },
+        { "tmp",        "nothing" },
+        { NULL , NULL }
+    };
+    copy = qdict_clone_shallow(dict);
+    qdict_rename_keys(copy, renames, &error_abort);
+
+    g_assert_cmpstr(qdict_get_str(copy, "nothing"), ==, "foo");
+    g_assert_cmpstr(qdict_get_str(copy, "abc"), ==, "bar");
+    g_assert_cmpint(qdict_get_int(copy, "abcdef"), ==, 42);
+    g_assert_cmpint(qdict_get_bool(copy, "number"), ==, true);
+    g_assert(qobject_type(qdict_get(copy, "flag")) == QTYPE_QNULL);
+    g_assert(!qdict_haskey(copy, "tmp"));
+    g_assert_cmpint(qdict_count_entries(copy), ==, 5);
+
+    QDECREF(copy);
+
+    /* Conflicting rename */
+    renames = (QDictRenames[]) {
+        { "abcdef",     "abc" },
+        { NULL , NULL }
+    };
+    copy = qdict_clone_shallow(dict);
+    qdict_rename_keys(copy, renames, &local_err);
+
+    g_assert(local_err != NULL);
+    error_free(local_err);
+    local_err = NULL;
+
+    g_assert_cmpstr(qdict_get_str(copy, "abc"), ==, "foo");
+    g_assert_cmpstr(qdict_get_str(copy, "abcdef"), ==, "bar");
+    g_assert_cmpint(qdict_get_int(copy, "number"), ==, 42);
+    g_assert_cmpint(qdict_get_bool(copy, "flag"), ==, true);
+    g_assert(qobject_type(qdict_get(copy, "nothing")) == QTYPE_QNULL);
+    g_assert_cmpint(qdict_count_entries(copy), ==, 5);
+
+    QDECREF(copy);
+
+    /* Renames in an empty dict */
+    renames = (QDictRenames[]) {
+        { "abcdef",     "abc" },
+        { NULL , NULL }
+    };
+
+    QDECREF(dict);
+    dict = qdict_new();
+
+    qdict_rename_keys(dict, renames, &error_abort);
+    g_assert(qdict_first(dict) == NULL);
+
+    QDECREF(dict);
+}
+
 static void qdict_crumple_test_bad_inputs(void)
 {
     QDict *src;
@@ -880,6 +1007,8 @@ int main(int argc, char **argv)
     g_test_add_func("/public/crumple/bad_inputs",
                     qdict_crumple_test_bad_inputs);
 
+    g_test_add_func("/public/rename_keys", qdict_rename_keys_test);
+
     /* The Big one */
     if (g_test_slow()) {
         g_test_add_func("/stress/test", qdict_stress_test);
-- 
2.13.6
