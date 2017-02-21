Received: from eggs.gnu.org ([2001:4830:134:3::10]:48984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cg7uQ-0007qp-Kl
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:43:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cg7uO-0002u3-GZ
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:43:02 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cg7uO-0002tp-6E
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:43:00 -0500
Received: by mail-wm0-x242.google.com with SMTP id v77so18936766wmv.0
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 02:43:00 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Feb 2017 11:42:54 +0100
Message-Id: <20170221104256.5153-2-pbonzini@redhat.com>
In-Reply-To: <20170221104256.5153-1-pbonzini@redhat.com>
References: <20170221104256.5153-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] qom-qobject: introduce object_property_{g,
 s}et_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, anton.nefedov@virtuozzo.com, den@openvz.org

The functions simplify the handling of QOM properties whose type
is a QAPI struct.  They go through a QObject just like the other
functions that access a QOM property through its C type.

Like QAPI_CLONE, the functions are wrapped by macros that take a
QAPI type name and use it to build the name of a visitor function.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/qom-qobject.h               |  68 ++++++++++++
 qom/qom-qobject.c                       |  49 +++++++++
 tests/Makefile.include                  |   2 +-
 tests/check-qom-proplist.c              | 185 +++++++++++++++++++++++++++++++-
 tests/qapi-schema/qapi-schema-test.json |   8 ++
 5 files changed, 309 insertions(+), 3 deletions(-)

diff --git a/include/qom/qom-qobject.h b/include/qom/qom-qobject.h
index 77cd717..ff1d307 100644
--- a/include/qom/qom-qobject.h
+++ b/include/qom/qom-qobject.h
@@ -39,4 +39,72 @@ struct QObject *object_property_get_qobject(Object *obj, const char *name,
 void object_property_set_qobject(Object *obj, struct QObject *qobj,
                                  const char *name, struct Error **errp);
 
+/**
+ * object_property_get_ptr:
+ * @obj: the object
+ * @ptr: The C struct that will be written to the property.
+ * @name: the name of the property
+ * @visit_type: the visitor function for @ptr's type.
+ * @errp: returns an error if this function fails
+ *
+ * Return: the value of an object's property, unmarshaled into a C object
+ * through a QAPI type visitor, or NULL if an error occurs.
+ */
+void *object_property_get_ptr(Object *obj, const char *name,
+                              void (*visit_type)(Visitor *, const char *,
+                                                 void **, Error **),
+                              Error **errp);
+
+/**
+ * OBJECT_PROPERTY_GET_PTR:
+ * @obj: the object
+ * @ptr: The C struct that will be written to the property.
+ * @name: the name of the property
+ * @type: the name of the C struct type pointed to by @ptr.
+ * @errp: returns an error if this function fails
+ *
+ * Return: the value of an object's property, unmarshaled into a C object
+ * through a QAPI type visitor, or NULL if an error occurs.
+ */
+#define OBJECT_PROPERTY_GET_PTR(obj, name, type, errp)                      \
+    ((type *)                                                               \
+     object_property_get_ptr(obj, name,                                     \
+                             (void (*)(Visitor *, const char *, void**,     \
+                                       Error **))visit_type_ ## type,       \
+                             errp))
+
+/**
+ * object_property_set_ptr:
+ * @obj: the object
+ * @ptr: The C struct that will be written to the property.
+ * @name: the name of the property
+ * @visit_type: the visitor function for @ptr's type.
+ * @errp: returns an error if this function fails
+ *
+ * Sets an object's property to a C object's value, using a QAPI
+ * type visitor to marshal the C struct into the object.
+ */
+void object_property_set_ptr(Object *obj, void *ptr, const char *name,
+                             void (*visit_type)(Visitor *, const char *,
+                                                void **, Error **),
+                             Error **errp);
+
+/**
+ * OBJECT_PROPERTY_SET_PTR:
+ * @obj: the object
+ * @ptr: The C struct that will be written to the property.
+ * @name: the name of the property
+ * @type: the name of the C struct type pointed to by @ptr.
+ * @errp: returns an error if this function fails
+ *
+ * Sets an object's property to a C object's value, using a QAPI
+ * type visitor to marshal the C struct into the object.
+ */
+#define OBJECT_PROPERTY_SET_PTR(obj, ptr, name, type, errp)                 \
+    object_property_set_ptr(obj, ptr + type_check(type, typeof(*ptr)),      \
+                            name,                                           \
+                            (void (*)(Visitor *, const char *, void**,      \
+                                      Error **))visit_type_ ## type,        \
+                            errp)
+
 #endif
diff --git a/qom/qom-qobject.c b/qom/qom-qobject.c
index 447e4a0..09a12e0 100644
--- a/qom/qom-qobject.c
+++ b/qom/qom-qobject.c
@@ -44,3 +44,52 @@ QObject *object_property_get_qobject(Object *obj, const char *name,
     visit_free(v);
     return ret;
 }
+
+void object_property_set_ptr(Object *obj, void *ptr, const char *name,
+                             void (*visit_type)(Visitor *, const char *, void **, Error **),
+                             Error **errp)
+{
+    Error *local_err = NULL;
+    QObject *ret = NULL;
+    Visitor *v;
+    v = qobject_output_visitor_new(&ret);
+    visit_type(v, name, &ptr, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        visit_free(v);
+        return;
+    }
+    visit_complete(v, &ret);
+    visit_free(v);
+
+    /* Do not use object_property_set_qobject until we switch it
+     * to use qobject_input_visitor_new in strict mode.  See the
+     * /qom/proplist/get-set-ptr/contravariant unit test.
+     */
+    v = qobject_input_visitor_new(ret, true);
+    object_property_set(obj, v, name, errp);
+    visit_free(v);
+    qobject_decref(ret);
+}
+
+void *object_property_get_ptr(Object *obj, const char *name,
+                              void (*visit_type)(Visitor *, const char *, void **, Error **),
+                              Error **errp)
+{
+    QObject *ret;
+    Visitor *v;
+    void *ptr = NULL;
+
+    ret = object_property_get_qobject(obj, name, errp);
+    if (!ret) {
+        return NULL;
+    }
+
+    /* Do not enable strict mode to allow passing covariant
+     * data types.
+     */
+    v = qobject_input_visitor_new(ret, false);
+    visit_type(v, name, &ptr, errp);
+    qobject_decref(ret);
+    return ptr;
+}
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 634394a..9de910b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -515,7 +515,7 @@ tests/check-qfloat$(EXESUF): tests/check-qfloat.o $(test-util-obj-y)
 tests/check-qnull$(EXESUF): tests/check-qnull.o $(test-util-obj-y)
 tests/check-qjson$(EXESUF): tests/check-qjson.o $(test-util-obj-y)
 tests/check-qom-interface$(EXESUF): tests/check-qom-interface.o $(test-qom-obj-y)
-tests/check-qom-proplist$(EXESUF): tests/check-qom-proplist.o $(test-qom-obj-y)
+tests/check-qom-proplist$(EXESUF): tests/check-qom-proplist.o $(test-qom-obj-y) $(test-qapi-obj-y)
 
 tests/test-char$(EXESUF): tests/test-char.o qemu-timer.o \
 	$(test-util-obj-y) $(qtest-obj-y) $(test-block-obj-y) $(chardev-obj-y)
diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
index a16cefc..e0ad880 100644
--- a/tests/check-qom-proplist.c
+++ b/tests/check-qom-proplist.c
@@ -22,8 +22,11 @@
 
 #include "qapi/error.h"
 #include "qom/object.h"
+#include "qom/qom-qobject.h"
 #include "qemu/module.h"
 
+#include "test-qapi-types.h"
+#include "test-qapi-visit.h"
 
 #define TYPE_DUMMY "qemu-dummy"
 
@@ -56,6 +59,8 @@ struct DummyObject {
     bool bv;
     DummyAnimal av;
     char *sv;
+
+    UserDefOne *qv;
 };
 
 struct DummyObjectClass {
@@ -120,12 +125,42 @@ static char *dummy_get_sv(Object *obj,
 
 static void dummy_init(Object *obj)
 {
+    DummyObject *dobj = DUMMY_OBJECT(obj);
+
     object_property_add_bool(obj, "bv",
                              dummy_get_bv,
                              dummy_set_bv,
                              NULL);
+    dobj->qv = g_new0(UserDefOne, 1);
+    dobj->qv->string = g_strdup("dummy string");
+}
+
+
+static void dummy_get_qv(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    DummyObject *dobj = DUMMY_OBJECT(obj);
+
+    visit_type_UserDefOne(v, name, &dobj->qv, errp);
 }
 
+static void dummy_set_qv(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    DummyObject *dobj = DUMMY_OBJECT(obj);
+    UserDefOne *qv = NULL;
+    Error *local_err = NULL;
+
+    visit_type_UserDefOne(v, name, &qv, &local_err);
+    if (local_err) {
+        g_assert(qv == NULL);
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    qapi_free_UserDefOne(dobj->qv);
+    dobj->qv = qv;
+}
 
 static void dummy_class_init(ObjectClass *cls, void *data)
 {
@@ -143,6 +178,13 @@ static void dummy_class_init(ObjectClass *cls, void *data)
                                    dummy_get_av,
                                    dummy_set_av,
                                    NULL);
+    object_class_property_add(cls, "qv",
+                              "UserDefOne",
+                              dummy_get_qv,
+                              dummy_set_qv,
+                              NULL,
+                              NULL,
+                              NULL);
 }
 
 
@@ -151,9 +193,9 @@ static void dummy_finalize(Object *obj)
     DummyObject *dobj = DUMMY_OBJECT(obj);
 
     g_free(dobj->sv);
+    qapi_free_UserDefOne(dobj->qv);
 }
 
-
 static const TypeInfo dummy_info = {
     .name          = TYPE_DUMMY,
     .parent        = TYPE_OBJECT,
@@ -473,7 +515,8 @@ static void test_dummy_iterator(void)
 
     ObjectProperty *prop;
     ObjectPropertyIterator iter;
-    bool seenbv = false, seensv = false, seenav = false, seentype;
+    bool seenbv = false, seensv = false, seenav = false;
+    bool seenqv = false, seentype = false;
 
     object_property_iter_init(&iter, OBJECT(dobj));
     while ((prop = object_property_iter_next(&iter))) {
@@ -483,6 +526,8 @@ static void test_dummy_iterator(void)
             seensv = true;
         } else if (g_str_equal(prop->name, "av")) {
             seenav = true;
+        } else if (g_str_equal(prop->name, "qv")) {
+            seenqv = true;
         } else if (g_str_equal(prop->name, "type")) {
             /* This prop comes from the base Object class */
             seentype = true;
@@ -494,6 +539,7 @@ static void test_dummy_iterator(void)
     g_assert(seenbv);
     g_assert(seenav);
     g_assert(seensv);
+    g_assert(seenqv);
     g_assert(seentype);
 
     object_unparent(OBJECT(dobj));
@@ -513,6 +559,137 @@ static void test_dummy_delchild(void)
     object_unparent(OBJECT(dev));
 }
 
+static void test_dummy_get_set_ptr_struct(void)
+{
+    DummyObject *dobj = DUMMY_OBJECT(object_new(TYPE_DUMMY));
+    Error *local_err = NULL;
+    const char *s = "my other dummy string";
+    UserDefOne *ret;
+    UserDefOne val;
+
+    ret = OBJECT_PROPERTY_GET_PTR(OBJECT(dobj), "qv",
+                                  UserDefOne, &local_err);
+    g_assert(!local_err);
+
+    g_assert_cmpint(ret->integer, ==, 0);
+    g_assert_cmpstr(ret->string, ==, "dummy string");
+    g_assert(!ret->has_enum1);
+    qapi_free_UserDefOne(ret);
+
+    val.integer = 42;
+    val.string = g_strdup(s);
+    val.has_enum1 = true;
+    val.enum1 = ENUM_ONE_VALUE1;
+    OBJECT_PROPERTY_SET_PTR(OBJECT(dobj), &val, "qv",
+                            UserDefOne, &local_err);
+    g_assert(!local_err);
+
+    ret = OBJECT_PROPERTY_GET_PTR(OBJECT(dobj), "qv",
+                                  UserDefOne, &local_err);
+    g_assert(!local_err);
+
+    g_assert_cmpint(ret->integer, ==, val.integer);
+    g_assert_cmpstr(ret->string, ==, val.string);
+    g_assert(ret->has_enum1);
+    g_assert_cmpint(ret->enum1, ==, val.enum1);
+    g_free(val.string);
+    qapi_free_UserDefOne(ret);
+}
+
+static void test_dummy_get_set_ptr_contravariant(void)
+{
+    DummyObject *dobj = DUMMY_OBJECT(object_new(TYPE_DUMMY));
+    Error *local_err = NULL;
+    UserDefOneMore *ret;
+    UserDefOneMore val;
+
+    /* You cannot retrieve a contravariant (subclass) type... */
+    ret = OBJECT_PROPERTY_GET_PTR(OBJECT(dobj), "qv",
+                                  UserDefOneMore, &local_err);
+    g_assert(local_err);
+    g_assert(!ret);
+    error_free(local_err);
+    local_err = NULL;
+
+    /* And you cannot set one either.  */
+    val.integer = 42;
+    val.string = g_strdup("unused");
+    val.has_enum1 = false;
+    val.boolean = false;
+
+    OBJECT_PROPERTY_SET_PTR(OBJECT(dobj), &val, "qv",
+                            UserDefOneMore, &local_err);
+    g_assert(local_err);
+}
+
+static void test_dummy_get_set_ptr_covariant(void)
+{
+    DummyObject *dobj = DUMMY_OBJECT(object_new(TYPE_DUMMY));
+    Error *local_err = NULL;
+    UserDefZero *ret;
+    UserDefZero val;
+
+    /* You can retrieve a covariant (superclass) type... */
+    ret = OBJECT_PROPERTY_GET_PTR(OBJECT(dobj), "qv",
+                                  UserDefZero, &local_err);
+    g_assert(!local_err);
+
+    g_assert_cmpint(ret->integer, ==, 0);
+    qapi_free_UserDefZero(ret);
+
+    /* But you cannot set one.  */
+    val.integer = 42;
+    OBJECT_PROPERTY_SET_PTR(OBJECT(dobj), &val, "qv",
+                            UserDefZero, &local_err);
+    g_assert(local_err);
+    error_free(local_err);
+    local_err = NULL;
+
+    /* Test that the property has not been modified at all */
+    ret = OBJECT_PROPERTY_GET_PTR(OBJECT(dobj), "qv",
+                                  UserDefZero, &local_err);
+    g_assert(!local_err);
+
+    g_assert_cmpint(ret->integer, ==, 0);
+    qapi_free_UserDefZero(ret);
+}
+
+static void test_dummy_get_set_ptr_error(void)
+{
+    DummyObject *dobj = DUMMY_OBJECT(object_new(TYPE_DUMMY));
+    Error *local_err = NULL;
+    const char *s = "my other dummy string";
+    UserDefOne *ret;
+    UserDefOne val;
+
+    ret = OBJECT_PROPERTY_GET_PTR(OBJECT(dobj), "blah",
+                                  UserDefOne, &local_err);
+    g_assert(local_err);
+    g_assert(!ret);
+    error_free(local_err);
+    local_err = NULL;
+
+    val.integer = 42;
+    val.string = g_strdup(s);
+    val.has_enum1 = true;
+    val.enum1 = 100;
+    OBJECT_PROPERTY_SET_PTR(OBJECT(dobj), &val, "qv",
+                            UserDefOne, &local_err);
+    g_assert(local_err);
+    error_free(local_err);
+    local_err = NULL;
+
+    ret = OBJECT_PROPERTY_GET_PTR(OBJECT(dobj), "qv",
+                                  UserDefOne, &local_err);
+    g_assert(!local_err);
+
+    /* Test that the property has not been modified at all */
+    g_assert_cmpint(ret->integer, ==, 0);
+    g_assert_cmpstr(ret->string, ==, "dummy string");
+    g_assert(!ret->has_enum1);
+    qapi_free_UserDefOne(ret);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -530,5 +707,9 @@ int main(int argc, char **argv)
     g_test_add_func("/qom/proplist/iterator", test_dummy_iterator);
     g_test_add_func("/qom/proplist/delchild", test_dummy_delchild);
 
+    g_test_add_func("/qom/proplist/get-set-ptr/struct", test_dummy_get_set_ptr_struct);
+    g_test_add_func("/qom/proplist/get-set-ptr/error", test_dummy_get_set_ptr_error);
+    g_test_add_func("/qom/proplist/get-set-ptr/covariant", test_dummy_get_set_ptr_covariant);
+    g_test_add_func("/qom/proplist/get-set-ptr/contravariant", test_dummy_get_set_ptr_contravariant);
     return g_test_run();
 }
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index f4d8cc4..4e3f6ff 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -91,6 +91,14 @@
             '*enum1': 'EnumOne' } }   # intentional forward reference
 
 ##
+# @UserDefOneMore:
+# for testing nested structs
+##
+{ 'struct': 'UserDefOneMore',
+  'base': 'UserDefOne',
+  'data': { 'boolean': 'bool' } }
+
+##
 # @EnumOne:
 ##
 { 'enum': 'EnumOne',
-- 
2.9.3
