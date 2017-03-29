Received: from eggs.gnu.org ([2001:4830:134:3::10]:44831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctJVA-00022Q-4b
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:43:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctJV9-00009w-72
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:43:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ctJV8-00009Z-V5
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:43:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E6D258AE72
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 19:43:25 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 29 Mar 2017 16:41:44 -0300
Message-Id: <20170329194148.19015-6-ehabkost@redhat.com>
In-Reply-To: <20170329194148.19015-1-ehabkost@redhat.com>
References: <20170329194148.19015-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC v2 5/9] Make class parameter const at some
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

There are many functions that don't need a non-const class
pointer argument. Change them to accept a const argument. This
will allow us to change class pointer variables to const in most
of the code.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/object.h        |  7 ++++---
 gdbstub.c                   |  2 +-
 qdev-monitor.c              |  4 ++--
 qom/object.c                | 10 +++++-----
 target/i386/cpu.c           |  2 +-
 target/ppc/translate_init.c |  2 +-
 6 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 674a45862d..bb0be22ac7 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -885,7 +885,7 @@ const ObjectClass *object_class_get_parent_const(const ObjectClass *klass);
  *
  * Returns: The QOM typename for @klass.
  */
-const char *object_class_get_name(ObjectClass *klass);
+const char *object_class_get_name(const ObjectClass *klass);
 
 /**
  * object_class_is_abstract:
@@ -893,7 +893,7 @@ const char *object_class_get_name(ObjectClass *klass);
  *
  * Returns: %true if @klass is abstract, %false otherwise.
  */
-bool object_class_is_abstract(ObjectClass *klass);
+bool object_class_is_abstract(const ObjectClass *klass);
 
 /**
  * object_class_by_name:
@@ -984,7 +984,8 @@ ObjectProperty *object_class_property_add(ObjectClass *klass, const char *name,
  */
 ObjectProperty *object_property_find(Object *obj, const char *name,
                                      Error **errp);
-ObjectProperty *object_class_property_find(ObjectClass *klass, const char *name,
+ObjectProperty *object_class_property_find(const ObjectClass *klass,
+                                           const char *name,
                                            Error **errp);
 
 typedef struct ObjectPropertyIterator {
diff --git a/gdbstub.c b/gdbstub.c
index 991115361e..3c7e5f3a96 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -573,7 +573,7 @@ static int memtox(char *buf, const char *mem, int len)
 }
 
 static const char *get_feature_xml(const char *p, const char **newp,
-                                   CPUClass *cc)
+                                   const CPUClass *cc)
 {
     size_t len;
     int i;
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 5f2fcdfc45..339775e49d 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -77,7 +77,7 @@ static const QDevAlias qdev_alias_table[] = {
     { }
 };
 
-static const char *qdev_class_get_alias(DeviceClass *dc)
+static const char *qdev_class_get_alias(const DeviceClass *dc)
 {
     const char *typename = object_class_get_name(OBJECT_CLASS(dc));
     int i;
@@ -96,7 +96,7 @@ static const char *qdev_class_get_alias(DeviceClass *dc)
     return NULL;
 }
 
-static bool qdev_class_has_alias(DeviceClass *dc)
+static bool qdev_class_has_alias(const DeviceClass *dc)
 {
     return (qdev_class_get_alias(dc) != NULL);
 }
diff --git a/qom/object.c b/qom/object.c
index 8f60ad9b8e..a25b1fffad 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -751,12 +751,12 @@ ObjectClass *object_get_class(Object *obj)
     return obj->class;
 }
 
-bool object_class_is_abstract(ObjectClass *klass)
+bool object_class_is_abstract(const ObjectClass *klass)
 {
     return klass->type->abstract;
 }
 
-const char *object_class_get_name(ObjectClass *klass)
+const char *object_class_get_name(const ObjectClass *klass)
 {
     return klass->type->name;
 }
@@ -1029,11 +1029,11 @@ ObjectProperty *object_property_iter_next(ObjectPropertyIterator *iter)
     return val;
 }
 
-ObjectProperty *object_class_property_find(ObjectClass *klass, const char *name,
-                                           Error **errp)
+ObjectProperty *object_class_property_find(const ObjectClass *klass,
+                                           const char *name, Error **errp)
 {
     ObjectProperty *prop;
-    ObjectClass *parent_klass;
+    const ObjectClass *parent_klass;
 
     parent_klass = object_class_get_parent(klass);
     if (parent_klass) {
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7aa762245a..b1d6252ae0 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -735,7 +735,7 @@ static ObjectClass *x86_cpu_class_by_name(const char *cpu_model)
     return oc;
 }
 
-static char *x86_cpu_class_get_model_name(X86CPUClass *cc)
+static char *x86_cpu_class_get_model_name(const X86CPUClass *cc)
 {
     const char *class_name = object_class_get_name(OBJECT_CLASS(cc));
     assert(g_str_has_suffix(class_name, X86_CPU_TYPE_SUFFIX));
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index c1a901455c..ee8ff04fd2 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -9773,7 +9773,7 @@ static int ppc_fixup_cpu(PowerPCCPU *cpu)
     return 0;
 }
 
-static inline bool ppc_cpu_is_valid(PowerPCCPUClass *pcc)
+static inline bool ppc_cpu_is_valid(const PowerPCCPUClass *pcc)
 {
 #ifdef TARGET_PPCEMB
     return pcc->mmu_model == POWERPC_MMU_BOOKE ||
-- 
2.11.0.259.g40922b1
