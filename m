Received: from eggs.gnu.org ([2001:4830:134:3::10]:33866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXSkv-0000Bu-Pv
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 09:41:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXSkt-0007TN-9t
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 09:41:41 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 18 Jul 2017 15:41:18 +0200
Message-Id: <1500385286-21142-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1500385286-21142-1-git-send-email-armbru@redhat.com>
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 02/10] qapi: Use QNull for a more
 regular visit_type_null()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com

Make visit_type_null() take an @obj argument like its buddies.  This
helps keeing the next commit simple.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/ppc/spapr_drc.c                  |  4 +++-
 include/qapi/visitor-impl.h         |  3 ++-
 include/qapi/visitor.h              |  8 ++++----
 qapi/qapi-clone-visitor.c           |  5 +++--
 qapi/qapi-dealloc-visitor.c         |  6 +++++-
 qapi/qapi-visit-core.c              |  7 ++++---
 qapi/qobject-input-visitor.c        |  6 +++++-
 qapi/qobject-output-visitor.c       |  3 ++-
 qapi/string-input-visitor.c         |  8 +++++++-
 qapi/string-output-visitor.c        |  3 ++-
 qapi/trace-events                   |  2 +-
 tests/check-qnull.c                 |  9 +++++++--
 tests/test-qobject-input-visitor.c  | 13 +++++++++----
 tests/test-qobject-output-visitor.c |  3 ++-
 14 files changed, 56 insertions(+), 24 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index f34355d..169ab0b 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -267,12 +267,14 @@ static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
 {
     sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(obj);
+    QNull *null;
     Error *err = NULL;
     int fdt_offset_next, fdt_offset, fdt_depth;
     void *fdt;
 
     if (!drc->fdt) {
-        visit_type_null(v, NULL, errp);
+        visit_type_null(v, NULL, &null, errp);
+        QDECREF(null);
         return;
     }
 
diff --git a/include/qapi/visitor-impl.h b/include/qapi/visitor-impl.h
index dcd656a..8ccb3b6 100644
--- a/include/qapi/visitor-impl.h
+++ b/include/qapi/visitor-impl.h
@@ -103,7 +103,8 @@ struct Visitor
                      Error **errp);
 
     /* Must be set to visit explicit null values.  */
-    void (*type_null)(Visitor *v, const char *name, Error **errp);
+    void (*type_null)(Visitor *v, const char *name, QNull **obj,
+                      Error **errp);
 
     /* Must be set for input visitors to visit structs, optional otherwise.
        The core takes care of the return type in the public interface. */
diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index 74768aa..fe9faf4 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -618,10 +618,10 @@ void visit_type_any(Visitor *v, const char *name, QObject **obj, Error **errp);
  * @name expresses the relationship of the null value to its parent
  * container; see the general description of @name above.
  *
- * Unlike all other visit_type_* functions, no obj parameter is
- * needed; rather, this is a witness that an explicit null value is
- * expected rather than any other type.
+ * @obj must be non-NULL.  Input visitors set *@obj to the value;
+ * other visitors ignore *@obj.
  */
-void visit_type_null(Visitor *v, const char *name, Error **errp);
+void visit_type_null(Visitor *v, const char *name, QNull **obj,
+                     Error **errp);
 
 #endif
diff --git a/qapi/qapi-clone-visitor.c b/qapi/qapi-clone-visitor.c
index ed16d3a..d8b6279 100644
--- a/qapi/qapi-clone-visitor.c
+++ b/qapi/qapi-clone-visitor.c
@@ -127,12 +127,13 @@ static void qapi_clone_type_number(Visitor *v, const char *name, double *obj,
     /* Value was already cloned by g_memdup() */
 }
 
-static void qapi_clone_type_null(Visitor *v, const char *name, Error **errp)
+static void qapi_clone_type_null(Visitor *v, const char *name, QNull **obj,
+                                 Error **errp)
 {
     QapiCloneVisitor *qcv = to_qcv(v);
 
     assert(qcv->depth);
-    /* Nothing to do */
+    *obj = qnull();
 }
 
 static void qapi_clone_free(Visitor *v)
diff --git a/qapi/qapi-dealloc-visitor.c b/qapi/qapi-dealloc-visitor.c
index fd6f9fb..ed70a01 100644
--- a/qapi/qapi-dealloc-visitor.c
+++ b/qapi/qapi-dealloc-visitor.c
@@ -103,8 +103,12 @@ static void qapi_dealloc_type_anything(Visitor *v, const char *name,
     }
 }
 
-static void qapi_dealloc_type_null(Visitor *v, const char *name, Error **errp)
+static void qapi_dealloc_type_null(Visitor *v, const char *name,
+                                   QNull **obj, Error **errp)
 {
+    if (obj) {
+        QDECREF(*obj);
+    }
 }
 
 static void qapi_dealloc_free(Visitor *v)
diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index 935a2c5..ed6d2af 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -325,10 +325,11 @@ void visit_type_any(Visitor *v, const char *name, QObject **obj, Error **errp)
     error_propagate(errp, err);
 }
 
-void visit_type_null(Visitor *v, const char *name, Error **errp)
+void visit_type_null(Visitor *v, const char *name, QNull **obj,
+                     Error **errp)
 {
-    trace_visit_type_null(v, name);
-    v->type_null(v, name, errp);
+    trace_visit_type_null(v, name, obj);
+    v->type_null(v, name, obj, errp);
 }
 
 static void output_type_enum(Visitor *v, const char *name, int *obj,
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 35aff78..ee9e47d 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -587,11 +587,13 @@ static void qobject_input_type_any(Visitor *v, const char *name, QObject **obj,
     *obj = qobj;
 }
 
-static void qobject_input_type_null(Visitor *v, const char *name, Error **errp)
+static void qobject_input_type_null(Visitor *v, const char *name,
+                                    QNull **obj, Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
     QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
 
+    *obj = NULL;
     if (!qobj) {
         return;
     }
@@ -599,7 +601,9 @@ static void qobject_input_type_null(Visitor *v, const char *name, Error **errp)
     if (qobject_type(qobj) != QTYPE_QNULL) {
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
                    full_name(qiv, name), "null");
+        return;
     }
+    *obj = qnull();
 }
 
 static void qobject_input_type_size_keyval(Visitor *v, const char *name,
diff --git a/qapi/qobject-output-visitor.c b/qapi/qobject-output-visitor.c
index 398dcb5..d325163 100644
--- a/qapi/qobject-output-visitor.c
+++ b/qapi/qobject-output-visitor.c
@@ -187,7 +187,8 @@ static void qobject_output_type_any(Visitor *v, const char *name,
     qobject_output_add_obj(qov, name, *obj);
 }
 
-static void qobject_output_type_null(Visitor *v, const char *name, Error **errp)
+static void qobject_output_type_null(Visitor *v, const char *name,
+                                     QNull **obj, Error **errp)
 {
     QObjectOutputVisitor *qov = to_qov(v);
     qobject_output_add(qov, name, qnull());
diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
index 63ae115..67a0a4a 100644
--- a/qapi/string-input-visitor.c
+++ b/qapi/string-input-visitor.c
@@ -326,14 +326,20 @@ static void parse_type_number(Visitor *v, const char *name, double *obj,
     *obj = val;
 }
 
-static void parse_type_null(Visitor *v, const char *name, Error **errp)
+static void parse_type_null(Visitor *v, const char *name, QNull **obj,
+                            Error **errp)
 {
     StringInputVisitor *siv = to_siv(v);
 
+    *obj = NULL;
+
     if (!siv->string || siv->string[0]) {
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
                    "null");
+        return;
     }
+
+    *obj = qnull();
 }
 
 static void string_input_free(Visitor *v)
diff --git a/qapi/string-output-visitor.c b/qapi/string-output-visitor.c
index af649e1..7ab6446 100644
--- a/qapi/string-output-visitor.c
+++ b/qapi/string-output-visitor.c
@@ -256,7 +256,8 @@ static void print_type_number(Visitor *v, const char *name, double *obj,
     string_output_set(sov, g_strdup_printf("%f", *obj));
 }
 
-static void print_type_null(Visitor *v, const char *name, Error **errp)
+static void print_type_null(Visitor *v, const char *name, QNull **obj,
+                            Error **errp)
 {
     StringOutputVisitor *sov = to_sov(v);
     char *out;
diff --git a/qapi/trace-events b/qapi/trace-events
index 3b57aba..9e9008a 100644
--- a/qapi/trace-events
+++ b/qapi/trace-events
@@ -31,4 +31,4 @@ visit_type_bool(void *v, const char *name, bool *obj) "v=%p name=%s obj=%p"
 visit_type_str(void *v, const char *name, char **obj) "v=%p name=%s obj=%p"
 visit_type_number(void *v, const char *name, double *obj) "v=%p name=%s obj=%p"
 visit_type_any(void *v, const char *name, void *obj) "v=%p name=%s obj=%p"
-visit_type_null(void *v, const char *name) "v=%p name=%s"
+visit_type_null(void *v, const char *name, void *obj) "v=%p name=%s obj=%p"
diff --git a/tests/check-qnull.c b/tests/check-qnull.c
index 1ab7c98..5c6eb0a 100644
--- a/tests/check-qnull.c
+++ b/tests/check-qnull.c
@@ -38,6 +38,7 @@ static void qnull_visit_test(void)
 {
     QObject *obj;
     Visitor *v;
+    QNull *null;
 
     /*
      * Most tests of interactions between QObject and visitors are in
@@ -49,13 +50,17 @@ static void qnull_visit_test(void)
     obj = QOBJECT(qnull());
     v = qobject_input_visitor_new(obj);
     qobject_decref(obj);
-    visit_type_null(v, NULL, &error_abort);
+    visit_type_null(v, NULL, &null, &error_abort);
+    g_assert(obj == QOBJECT(&qnull_));
+    QDECREF(null);
     visit_free(v);
 
+    null = NULL;
     v = qobject_output_visitor_new(&obj);
-    visit_type_null(v, NULL, &error_abort);
+    visit_type_null(v, NULL, &null, &error_abort);
     visit_complete(v, &obj);
     g_assert(obj == QOBJECT(&qnull_));
+    QDECREF(null);
     qobject_decref(obj);
     visit_free(v);
 
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-visitor.c
index 34bab8a..f98caf9 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -510,6 +510,7 @@ static void test_visitor_in_null(TestInputVisitorData *data,
 {
     Visitor *v;
     Error *err = NULL;
+    QNull *null;
     char *tmp;
 
     /*
@@ -524,12 +525,15 @@ static void test_visitor_in_null(TestInputVisitorData *data,
     v = visitor_input_test_init_full(data, false,
                                      "{ 'a': null, 'b': '' }");
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
-    visit_type_null(v, "a", &error_abort);
-    visit_type_null(v, "b", &err);
+    visit_type_null(v, "a", &null, &error_abort);
+    g_assert(qobject_type(QOBJECT(null)) == QTYPE_QNULL);
+    QDECREF(null);
+    visit_type_null(v, "b", &null, &err);
     error_free_or_abort(&err);
+    g_assert(!null);
     visit_type_str(v, "c", &tmp, &err);
-    g_assert(!tmp);
     error_free_or_abort(&err);
+    g_assert(!tmp);
     visit_check_struct(v, &error_abort);
     visit_end_struct(v, NULL);
 }
@@ -1087,6 +1091,7 @@ static void test_visitor_in_fail_struct_missing(TestInputVisitorData *data,
     Error *err = NULL;
     Visitor *v;
     QObject *any;
+    QNull *null;
     GenericAlternate *alt;
     bool present;
     int en;
@@ -1120,7 +1125,7 @@ static void test_visitor_in_fail_struct_missing(TestInputVisitorData *data,
     error_free_or_abort(&err);
     visit_type_any(v, "any", &any, &err);
     error_free_or_abort(&err);
-    visit_type_null(v, "null", &err);
+    visit_type_null(v, "null", &null, &err);
     error_free_or_abort(&err);
     visit_start_list(v, "sub", NULL, 0, &error_abort);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-output-visitor.c
index 749c540..8f1fcd4 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -445,11 +445,12 @@ static void test_visitor_out_alternate(TestOutputVisitorData *data,
 static void test_visitor_out_null(TestOutputVisitorData *data,
                                   const void *unused)
 {
+    QNull *null = NULL;
     QDict *qdict;
     QObject *nil;
 
     visit_start_struct(data->ov, NULL, NULL, 0, &error_abort);
-    visit_type_null(data->ov, "a", &error_abort);
+    visit_type_null(data->ov, "a", &null, &error_abort);
     visit_check_struct(data->ov, &error_abort);
     visit_end_struct(data->ov, NULL);
     qdict = qobject_to_qdict(visitor_get(data));
-- 
2.7.5
