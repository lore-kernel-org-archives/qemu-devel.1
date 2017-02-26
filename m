Received: from eggs.gnu.org ([2001:4830:134:3::10]:37633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ci6bl-0004Vw-Fc
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 16:43:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ci6bf-0004Oy-OU
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 16:43:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ci6bf-0004Np-Fq
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 16:43:51 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 92FBF81236
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 21:43:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1QLhnKS008770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 16:43:51 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sun, 26 Feb 2017 22:43:41 +0100
Message-Id: <1488145424-14974-24-git-send-email-armbru@redhat.com>
In-Reply-To: <1488145424-14974-1-git-send-email-armbru@redhat.com>
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 23/26] qapi: Make input visitors detect
 unvisited list tails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fix the design flaw demonstrated in the previous commit: new method
check_list() lets input visitors report that unvisited input remains
for a list, exactly like check_struct() lets them report that
unvisited input remains for a struct or union.

Implement the method for the qobject input visitor (straightforward),
and the string input visitor (less so, due to the magic list syntax
there).  The opts visitor's list magic is even more impenetrable, and
all I can do there today is a stub with a FIXME comment.  No worse
than before.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/ppc/spapr_drc.c                 |  5 +++++
 include/qapi/visitor-impl.h        |  3 +++
 include/qapi/visitor.h             | 13 +++++++++++++
 qapi/opts-visitor.c                | 11 +++++++++++
 qapi/qapi-visit-core.c             |  8 ++++++++
 qapi/qobject-input-visitor.c       | 37 +++++++++++++++++++++++++++++++------
 qapi/string-input-visitor.c        | 30 ++++++++++++++++++++++++++++++
 qapi/trace-events                  |  1 +
 scripts/qapi-visit.py              |  3 +++
 tests/test-opts-visitor.c          |  2 +-
 tests/test-qobject-input-visitor.c |  9 +++++++--
 tests/test-string-input-visitor.c  | 12 ++----------
 12 files changed, 115 insertions(+), 19 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 2de6377..fe7b988 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -326,6 +326,11 @@ static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
                     return;
                 }
             }
+            visit_check_list(v, &err);
+            if (err) {
+                error_propagate(errp, err);
+                return;
+            }
             visit_end_list(v, NULL);
             break;
         }
diff --git a/include/qapi/visitor-impl.h b/include/qapi/visitor-impl.h
index 962ba1d..e87709d 100644
--- a/include/qapi/visitor-impl.h
+++ b/include/qapi/visitor-impl.h
@@ -61,6 +61,9 @@ struct Visitor
     /* Must be set */
     GenericList *(*next_list)(Visitor *v, GenericList *tail, size_t size);
 
+    /* Optional; intended for input visitors */
+    void (*check_list)(Visitor *v, Error **errp);
+
     /* Must be set */
     void (*end_list)(Visitor *v, void **list);
 
diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index 7c91a50..1a1b620 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -370,6 +370,19 @@ void visit_start_list(Visitor *v, const char *name, GenericList **list,
 GenericList *visit_next_list(Visitor *v, GenericList *tail, size_t size);
 
 /*
+ * Prepare for completing a list visit.
+ *
+ * @errp obeys typical error usage, and reports failures such as
+ * unvisited list tail remaining in the input stream.
+ *
+ * Should be called prior to visit_end_list() if all other
+ * intermediate visit steps were successful, to allow the visitor one
+ * last chance to report errors.  May be skipped on a cleanup path,
+ * where there is no need to check for further errors.
+ */
+void visit_check_list(Visitor *v, Error **errp);
+
+/*
  * Complete a list visit started earlier.
  *
  * @list must match what was passed to the paired visit_start_list().
diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index c50dc4b..026d25b 100644
--- a/qapi/opts-visitor.c
+++ b/qapi/opts-visitor.c
@@ -273,6 +273,16 @@ opts_next_list(Visitor *v, GenericList *tail, size_t size)
 
 
 static void
+opts_check_list(Visitor *v, Error **errp)
+{
+    /*
+     * FIXME should set error when unvisited elements remain.  Mostly
+     * harmless, as the generated visits always visit all elements.
+     */
+}
+
+
+static void
 opts_end_list(Visitor *v, void **obj)
 {
     OptsVisitor *ov = to_ov(v);
@@ -539,6 +549,7 @@ opts_visitor_new(const QemuOpts *opts)
 
     ov->visitor.start_list = &opts_start_list;
     ov->visitor.next_list  = &opts_next_list;
+    ov->visitor.check_list = &opts_check_list;
     ov->visitor.end_list   = &opts_end_list;
 
     ov->visitor.type_int64  = &opts_type_int64;
diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index e6e93f0..43a09d1 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -90,6 +90,14 @@ GenericList *visit_next_list(Visitor *v, GenericList *tail, size_t size)
     return v->next_list(v, tail, size);
 }
 
+void visit_check_list(Visitor *v, Error **errp)
+{
+    trace_visit_check_list(v);
+    if (v->check_list) {
+        v->check_list(v, errp);
+    }
+}
+
 void visit_end_list(Visitor *v, void **obj)
 {
     trace_visit_end_list(v, obj);
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 97a27e2..47e546e 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -51,7 +51,8 @@ static QObjectInputVisitor *to_qiv(Visitor *v)
     return container_of(v, QObjectInputVisitor, visitor);
 }
 
-static const char *full_name(QObjectInputVisitor *qiv, const char *name)
+static const char *full_name_nth(QObjectInputVisitor *qiv, const char *name,
+                                 int n)
 {
     StackObject *so;
     char buf[32];
@@ -63,8 +64,10 @@ static const char *full_name(QObjectInputVisitor *qiv, const char *name)
     }
 
     QSLIST_FOREACH(so , &qiv->stack, node) {
-        if (qobject_type(so->obj) == QTYPE_QDICT) {
-            g_string_prepend(qiv->errname, name);
+        if (n) {
+            n--;
+        } else if (qobject_type(so->obj) == QTYPE_QDICT) {
+            g_string_prepend(qiv->errname, name ?: "<anonymous>");
             g_string_prepend_c(qiv->errname, '.');
         } else {
             snprintf(buf, sizeof(buf), "[%u]", so->index);
@@ -72,18 +75,24 @@ static const char *full_name(QObjectInputVisitor *qiv, const char *name)
         }
         name = so->name;
     }
+    assert(!n);
 
     if (name) {
         g_string_prepend(qiv->errname, name);
     } else if (qiv->errname->str[0] == '.') {
         g_string_erase(qiv->errname, 0, 1);
-    } else {
+    } else if (!qiv->errname->str[0]) {
         return "<anonymous>";
     }
 
     return qiv->errname->str;
 }
 
+static const char *full_name(QObjectInputVisitor *qiv, const char *name)
+{
+    return full_name_nth(qiv, name, 0);
+}
+
 static QObject *qobject_input_try_get_object(QObjectInputVisitor *qiv,
                                              const char *name,
                                              bool consume)
@@ -260,15 +269,30 @@ static GenericList *qobject_input_next_list(Visitor *v, GenericList *tail,
                                             size_t size)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    StackObject *so = QSLIST_FIRST(&qiv->stack);
+    StackObject *tos = QSLIST_FIRST(&qiv->stack);
 
-    if (!so->entry) {
+    assert(tos && tos->obj && qobject_type(tos->obj) == QTYPE_QLIST);
+
+    if (!tos->entry) {
         return NULL;
     }
     tail->next = g_malloc0(size);
     return tail->next;
 }
 
+static void qobject_input_check_list(Visitor *v, Error **errp)
+{
+    QObjectInputVisitor *qiv = to_qiv(v);
+    StackObject *tos = QSLIST_FIRST(&qiv->stack);
+
+    assert(tos && tos->obj && qobject_type(tos->obj) == QTYPE_QLIST);
+
+    if (tos->entry) {
+        error_setg(errp, "Only %u list elements expected in %s",
+                   tos->index + 1, full_name_nth(qiv, NULL, 1));
+    }
+}
+
 static void qobject_input_start_alternate(Visitor *v, const char *name,
                                           GenericAlternate **obj, size_t size,
                                           bool promote_int, Error **errp)
@@ -470,6 +494,7 @@ Visitor *qobject_input_visitor_new(QObject *obj)
     v->visitor.end_struct = qobject_input_pop;
     v->visitor.start_list = qobject_input_start_list;
     v->visitor.next_list = qobject_input_next_list;
+    v->visitor.check_list = qobject_input_check_list;
     v->visitor.end_list = qobject_input_pop;
     v->visitor.start_alternate = qobject_input_start_alternate;
     v->visitor.type_int64 = qobject_input_type_int64;
diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
index f126cd9..806b01ae 100644
--- a/qapi/string-input-visitor.c
+++ b/qapi/string-input-visitor.c
@@ -170,6 +170,35 @@ static GenericList *next_list(Visitor *v, GenericList *tail, size_t size)
     return tail->next;
 }
 
+static void check_list(Visitor *v, Error **errp)
+{
+    const StringInputVisitor *siv = to_siv(v);
+    Range *r;
+    GList *cur_range;
+
+    if (!siv->ranges || !siv->cur_range) {
+        return;
+    }
+
+    r = siv->cur_range->data;
+    if (!r) {
+        return;
+    }
+
+    if (!range_contains(r, siv->cur)) {
+        cur_range = g_list_next(siv->cur_range);
+        if (!cur_range) {
+            return;
+        }
+        r = cur_range->data;
+        if (!r) {
+            return;
+        }
+    }
+
+    error_setg(errp, "Range contains too many values");
+}
+
 static void end_list(Visitor *v, void **obj)
 {
     StringInputVisitor *siv = to_siv(v);
@@ -318,6 +347,7 @@ Visitor *string_input_visitor_new(const char *str)
     v->visitor.type_number = parse_type_number;
     v->visitor.start_list = start_list;
     v->visitor.next_list = next_list;
+    v->visitor.check_list = check_list;
     v->visitor.end_list = end_list;
     v->visitor.free = string_input_free;
 
diff --git a/qapi/trace-events b/qapi/trace-events
index 9cbb61b..339cacf 100644
--- a/qapi/trace-events
+++ b/qapi/trace-events
@@ -8,6 +8,7 @@ visit_end_struct(void *v, void *obj) "v=%p obj=%p"
 
 visit_start_list(void *v, const char *name, void *obj, size_t size) "v=%p name=%s obj=%p size=%zu"
 visit_next_list(void *v, void *tail, size_t size) "v=%p tail=%p size=%zu"
+visit_check_list(void *v) "v=%p"
 visit_end_list(void *v, void *obj) "v=%p obj=%p"
 
 visit_start_alternate(void *v, const char *name, void *obj, size_t size, bool promote_int) "v=%p name=%s obj=%p size=%zu promote_int=%d"
diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index 96f2491..330b9f3 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -133,6 +133,9 @@ void visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error
         }
     }
 
+    if (!err) {
+        visit_check_list(v, &err);
+    }
     visit_end_list(v, (void **)obj);
     if (err && visit_is_input(v)) {
         qapi_free_%(c_name)s(*obj);
diff --git a/tests/test-opts-visitor.c b/tests/test-opts-visitor.c
index d0f7646..b93fd33 100644
--- a/tests/test-opts-visitor.c
+++ b/tests/test-opts-visitor.c
@@ -199,8 +199,8 @@ test_opts_range_unvisited(void)
     g_assert_cmpint(tail->value, ==, 1);
     tail = (intList *)visit_next_list(v, (GenericList *)tail, sizeof(*list));
     g_assert(tail);
+    visit_check_list(v, &error_abort); /* BUG: unvisited tail not reported */
     visit_end_list(v, (void **)&list);
-    /* BUG: unvisited tail not reported; actually not reportable by design */
 
     visit_check_struct(v, &error_abort);
     visit_end_struct(v, NULL);
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-visitor.c
index 6e04736..b631773 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -932,6 +932,7 @@ static void test_visitor_in_fail_list(TestInputVisitorData *data,
                                       const void *unused)
 {
     int64_t i64 = -1;
+    Error *err = NULL;
     Visitor *v;
 
     /* Unvisited list tail */
@@ -943,14 +944,16 @@ static void test_visitor_in_fail_list(TestInputVisitorData *data,
     g_assert_cmpint(i64, ==, 1);
     visit_type_int(v, NULL, &i64, &error_abort);
     g_assert_cmpint(i64, ==, 2);
+    visit_check_list(v, &err);
+    error_free_or_abort(&err);
     visit_end_list(v, NULL);
-    /* BUG: unvisited tail not reported; actually not reportable by design */
 }
 
 static void test_visitor_in_fail_list_nested(TestInputVisitorData *data,
                                              const void *unused)
 {
     int64_t i64 = -1;
+    Error *err = NULL;
     Visitor *v;
 
     /* Unvisited nested list tail */
@@ -963,8 +966,10 @@ static void test_visitor_in_fail_list_nested(TestInputVisitorData *data,
     visit_start_list(v, NULL, NULL, 0, &error_abort);
     visit_type_int(v, NULL, &i64, &error_abort);
     g_assert_cmpint(i64, ==, 1);
+    visit_check_list(v, &err);
+    error_free_or_abort(&err);
     visit_end_list(v, NULL);
-    /* BUG: unvisited tail not reported; actually not reportable by design */
+    visit_check_list(v, &error_abort);
     visit_end_list(v, NULL);
 }
 
diff --git a/tests/test-string-input-visitor.c b/tests/test-string-input-visitor.c
index 70cee65..c93cfeb 100644
--- a/tests/test-string-input-visitor.c
+++ b/tests/test-string-input-visitor.c
@@ -160,17 +160,9 @@ static void test_visitor_in_intList(TestInputVisitorData *data,
     /* Would be simpler if the visitor genuinely supported virtual walks */
     visit_start_list(v, NULL, (GenericList **)&res, sizeof(*res),
                      &error_abort);
-    tail = res;
-    visit_type_int64(v, NULL, &tail->value, &error_abort);
-    g_assert_cmpint(tail->value, ==, 0);
-    tail = (int64List *)visit_next_list(v, (GenericList *)tail, sizeof(*res));
-    g_assert(tail);
-    visit_type_int64(v, NULL, &tail->value, &error_abort);
-    g_assert_cmpint(tail->value, ==, 2);
-    tail = (int64List *)visit_next_list(v, (GenericList *)tail, sizeof(*res));
-    g_assert(tail);
+    visit_check_list(v, &err);
+    error_free_or_abort(&err);
     visit_end_list(v, (void **)&res);
-    /* BUG: unvisited tail not reported; actually not reportable by design */
 
     qapi_free_int64List(res);
 }
-- 
2.7.4
