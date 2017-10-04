Received: from eggs.gnu.org ([2001:4830:134:3::10]:40777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dzgb7-0000hK-83
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:08:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dzgb6-0005vD-4Q
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:08:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dzgb5-0005uk-St
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:08:12 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed,  4 Oct 2017 12:08:02 +0200
Message-Id: <1507111682-66171-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507111682-66171-1-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-2-git-send-email-imammedo@redhat.com>
	<1507111682-66171-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/3] qom: add helper macro DEFINE_TYPES()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, peter.maydell@linaro.org

DEFINE_TYPES() will help to simplify following routine patterns:

 static void foo_register_types(void)
 {
    type_register_static(&foo1_type_info);
    type_register_static(&foo2_type_info);
    ...
 }

 type_init(foo_register_types)

or

 static void foo_register_types(void)
 {
    int i;

    for (i = 0; i < ARRAY_SIZE(type_infos); i++) {
        type_register_static(&type_infos[i]);
    }
 }

 type_init(foo_register_types)

with a single line

 DEFINE_TYPES(type_infos)

where types have static definition which could be consolidated in
a single array of TypeInfo structures.
It saves us ~6-10LOC per use case and would help to replace
imperative foo_register_types() there with declarative style of
type registration.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/qom/object.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index ce25567..a615066 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -79,6 +79,28 @@ typedef struct InterfaceInfo InterfaceInfo;
  * #TypeInfo describes information about the type including what it inherits
  * from, the instance and class size, and constructor/destructor hooks.
  *
+ * Alternatively several static types could be registered using helper macro
+ * DEFINE_TYPES()
+ *
+ * <example>
+ *   <programlisting>
+ * static const TypeInfo device_types_info[] = {
+ *     {
+ *         .name = TYPE_MY_DEVICE_A,
+ *         .parent = TYPE_DEVICE,
+ *         .instance_size = sizeof(MyDeviceA),
+ *     },
+ *     {
+ *         .name = TYPE_MY_DEVICE_B,
+ *         .parent = TYPE_DEVICE,
+ *         .instance_size = sizeof(MyDeviceB),
+ *     },
+ * };
+ *
+ * DEFINE_TYPES(device_types_info)
+ *   </programlisting>
+ * </example>
+ *
  * Every type has an #ObjectClass associated with it.  #ObjectClass derivatives
  * are instantiated dynamically but there is only ever one instance for any
  * given type.  The #ObjectClass typically holds a table of function pointers
@@ -799,6 +821,20 @@ Type type_register(const TypeInfo *info);
 void type_register_static_array(const TypeInfo *infos, int nr_infos);
 
 /**
+ * DEFINE_TYPES:
+ * @type_array: The array containing #TypeInfo structures to register
+ *
+ * @type_array should be static constant that exists for the life time
+ * that the type is registered.
+ */
+#define DEFINE_TYPES(type_array)                                            \
+static void do_qemu_init_ ## type_array(void)                               \
+{                                                                           \
+    type_register_static_array(type_array, ARRAY_SIZE(type_array));         \
+}                                                                           \
+type_init(do_qemu_init_ ## type_array)
+
+/**
  * object_class_dynamic_cast_assert:
  * @klass: The #ObjectClass to attempt to cast.
  * @typename: The QOM typename of the class to cast to.
-- 
2.7.4
