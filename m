Received: from eggs.gnu.org ([2001:4830:134:3::10]:44904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctJVH-000298-Gm
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:43:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctJVG-0000CM-KX
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:43:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ctJVG-0000C9-Aw
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:43:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 545CC7E9E5
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 19:43:33 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 29 Mar 2017 16:41:47 -0300
Message-Id: <20170329194148.19015-9-ehabkost@redhat.com>
In-Reply-To: <20170329194148.19015-1-ehabkost@redhat.com>
References: <20170329194148.19015-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC v2 8/9] qom: Make class cast macros/functions
 const-aware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Use the QUALIFIED_CAST macro to make OBJECT_CLASS,
OBJECT_CLASS_CHECK, object_class_dynamic_cast(), and
object_class_dynamic_cast_assert() return a const pointer if the
class argument is already a const pointer.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/object.h | 31 +++++++++++++++++++++----------
 qom/object.c         | 15 ++++++++-------
 2 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 4af3c8e232..2b1513d2f2 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -527,7 +527,7 @@ struct TypeInfo
  * this function will always succeed.
  */
 #define OBJECT_CLASS(class) \
-    ((ObjectClass *)(class))
+    (QUALIFIED_CAST(typeof(class), ObjectClass *)(class))
 
 /**
  * OBJECT_CHECK:
@@ -556,9 +556,10 @@ struct TypeInfo
  * typically wrapped by each type to perform type safe casts of a class to a
  * specific class type.
  */
-#define OBJECT_CLASS_CHECK(class_type, class, name) \
-    ((class_type *)object_class_dynamic_cast_assert(OBJECT_CLASS(class), (name), \
-                                               __FILE__, __LINE__, __func__))
+#define OBJECT_CLASS_CHECK(class_type, class, name)                \
+    (QUALIFIED_CAST(typeof(class), class_type *)                   \
+     object_class_dynamic_cast_assert(OBJECT_CLASS(class), (name), \
+                                      __FILE__, __LINE__, __func__))
 
 /**
  * OBJECT_GET_CLASS:
@@ -845,10 +846,16 @@ Type type_register(const TypeInfo *info);
  * enabled.  This function is not meant to be called directly, but only through
  * the wrapper macros OBJECT_CLASS_CHECK and INTERFACE_CHECK.
  */
-ObjectClass *object_class_dynamic_cast_assert(ObjectClass *klass,
-                                              const char *typename,
-                                              const char *file, int line,
-                                              const char *func);
+#define object_class_dynamic_cast_assert(klass, typename, file, line, func) \
+    (QUALIFIED_CAST(typeof(klass), ObjectClass *)                           \
+     object_class_dynamic_cast_assert_const((ObjectClass *)klass, typename, \
+                                            file, line, func))
+
+const ObjectClass *object_class_dynamic_cast_assert_const(ObjectClass *klass,
+                                                          const char *typename,
+                                                          const char *file,
+                                                          int line,
+                                                          const char *func);
 
 /**
  * object_class_dynamic_cast:
@@ -864,8 +871,12 @@ ObjectClass *object_class_dynamic_cast_assert(ObjectClass *klass,
  * classes or interfaces on the hierarchy leading to @klass implement
  * it.  (FIXME: perhaps this can be detected at type definition time?)
  */
-ObjectClass *object_class_dynamic_cast(ObjectClass *klass,
-                                       const char *typename);
+#define object_class_dynamic_cast(klass, typename) \
+    (QUALIFIED_CAST(typeof(klass), ObjectClass *)  \
+     object_class_dynamic_cast_const(klass, typename))
+
+const ObjectClass *object_class_dynamic_cast_const(const ObjectClass *klass,
+                                                   const char *typename);
 
 /**
  * object_class_get_parent:
diff --git a/qom/object.c b/qom/object.c
index 41dae18420..9b6c990ac5 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -648,10 +648,10 @@ out:
     return obj;
 }
 
-ObjectClass *object_class_dynamic_cast(ObjectClass *class,
-                                       const char *typename)
+const ObjectClass *object_class_dynamic_cast_const(const ObjectClass *class,
+                                                   const char *typename)
 {
-    ObjectClass *ret = NULL;
+    const ObjectClass *ret = NULL;
     TypeImpl *target_type;
     TypeImpl *type;
 
@@ -696,10 +696,11 @@ ObjectClass *object_class_dynamic_cast(ObjectClass *class,
     return ret;
 }
 
-ObjectClass *object_class_dynamic_cast_assert(ObjectClass *class,
-                                              const char *typename,
-                                              const char *file, int line,
-                                              const char *func)
+const ObjectClass *object_class_dynamic_cast_assert_const(ObjectClass *class,
+                                                          const char *typename,
+                                                          const char *file,
+                                                          int line,
+                                                          const char *func)
 {
     ObjectClass *ret;
 
-- 
2.11.0.259.g40922b1
