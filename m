Received: from eggs.gnu.org ([2001:4830:134:3::10]:42265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dzM6A-0002E6-05
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:14:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dzM65-00053T-RO
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:14:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dzM65-00050E-II
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:14:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AEC35780C4
	for <qemu-devel@nongnu.org>; Tue,  3 Oct 2017 12:14:48 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue,  3 Oct 2017 14:14:46 +0200
Message-Id: <1507032886-199950-1-git-send-email-imammedo@redhat.com>
In-Reply-To: <20171002192404.GC17385@localhost.localdomain>
References: <20171002192404.GC17385@localhost.localdomain>
Subject: [Qemu-devel] [PATCH] qom: add helpers REGISTER_STATIC_TYPE[S]()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com

it will help to remove code duplication in places
that currently open code registration of static
type[s] and remove necessity to declare function
for type_init() to call, when only static types
need to be registered.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
I'm going to use it for CPU types in followup patches

CC: ehabkost@redhat.com
---
 include/qemu/module.h | 10 ++++++++++
 include/qom/object.h  | 10 ++++++++++
 qom/object.c          |  9 +++++++++
 3 files changed, 29 insertions(+)

diff --git a/include/qemu/module.h b/include/qemu/module.h
index 56dd218..60dd632 100644
--- a/include/qemu/module.h
+++ b/include/qemu/module.h
@@ -52,6 +52,16 @@ typedef enum {
 #define type_init(function) module_init(function, MODULE_INIT_QOM)
 #define trace_init(function) module_init(function, MODULE_INIT_TRACE)
 
+#define REGISTER_STATIC_TYPES(t, nr)                                        \
+static void do_qemu_init_ ## t(void)                                        \
+{                                                                           \
+    type_register_static_array(t, nr);                                      \
+}                                                                           \
+type_init(do_qemu_init_ ## t)
+
+#define REGISTER_STATIC_TYPE(t)                                             \
+    REGISTER_STATIC_TYPES(t, 1)
+
 #define block_module_load_one(lib) module_load_one("block-", lib)
 
 void register_module_init(void (*fn)(void), module_init_type type);
diff --git a/include/qom/object.h b/include/qom/object.h
index f3e5cff..17fcadd 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -789,6 +789,16 @@ Type type_register_static(const TypeInfo *info);
 Type type_register(const TypeInfo *info);
 
 /**
+ * type_register_static_array:
+ * @infos: The array of the new type #TypeInfo structures.
+ * @nr_infos: number of entries in @infos
+ *
+ * @infos and all of the strings it points to should exist for the life time
+ * that the type is registered.
+ */
+void type_register_static_array(const TypeInfo *infos, int nr_infos);
+
+/**
  * object_class_dynamic_cast_assert:
  * @klass: The #ObjectClass to attempt to cast.
  * @typename: The QOM typename of the class to cast to.
diff --git a/qom/object.c b/qom/object.c
index 3e18537..40b1729 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -151,6 +151,15 @@ TypeImpl *type_register_static(const TypeInfo *info)
     return type_register(info);
 }
 
+void type_register_static_array(const TypeInfo *infos, int nr_infos)
+{
+    int i;
+
+    for (i = 0; i < nr_infos; i++) {
+        assert(type_register_static(&infos[i]));
+    }
+}
+
 static TypeImpl *type_get_by_name(const char *name)
 {
     if (name == NULL) {
-- 
2.7.4
