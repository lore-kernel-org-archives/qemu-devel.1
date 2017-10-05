Received: from eggs.gnu.org ([2001:4830:134:3::10]:44905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e08xJ-0002nT-LP
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:25:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e08xI-0003DM-Ma
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:25:01 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  5 Oct 2017 18:24:30 +0200
Message-Id: <1507220690-265042-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/23] qom: add helper macro DEFINE_TYPES()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>

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

    for (i =3D 0; i < ARRAY_SIZE(type_infos); i++) {
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
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 include/qom/object.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 9a2369c..dc73d59 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -79,6 +79,28 @@ typedef struct InterfaceInfo InterfaceInfo;
  * #TypeInfo describes information about the type including what it inhe=
rits
  * from, the instance and class size, and constructor/destructor hooks.
  *
+ * Alternatively several static types could be registered using helper m=
acro
+ * DEFINE_TYPES()
+ *
+ * <example>
+ *   <programlisting>
+ * static const TypeInfo device_types_info[] =3D {
+ *     {
+ *         .name =3D TYPE_MY_DEVICE_A,
+ *         .parent =3D TYPE_DEVICE,
+ *         .instance_size =3D sizeof(MyDeviceA),
+ *     },
+ *     {
+ *         .name =3D TYPE_MY_DEVICE_B,
+ *         .parent =3D TYPE_DEVICE,
+ *         .instance_size =3D sizeof(MyDeviceB),
+ *     },
+ * };
+ *
+ * DEFINE_TYPES(device_types_info)
+ *   </programlisting>
+ * </example>
+ *
  * Every type has an #ObjectClass associated with it.  #ObjectClass deri=
vatives
  * are instantiated dynamically but there is only ever one instance for =
any
  * given type.  The #ObjectClass typically holds a table of function poi=
nters
@@ -799,6 +821,20 @@ Type type_register(const TypeInfo *info);
 void type_register_static_array(const TypeInfo *infos, int nr_infos);
=20
 /**
+ * DEFINE_TYPES:
+ * @type_array: The array containing #TypeInfo structures to register
+ *
+ * @type_array should be static constant that exists for the life time
+ * that the type is registered.
+ */
+#define DEFINE_TYPES(type_array)                                        =
    \
+static void do_qemu_init_ ## type_array(void)                           =
    \
+{                                                                       =
    \
+    type_register_static_array(type_array, ARRAY_SIZE(type_array));     =
    \
+}                                                                       =
    \
+type_init(do_qemu_init_ ## type_array)
+
+/**
  * object_class_dynamic_cast_assert:
  * @klass: The #ObjectClass to attempt to cast.
  * @typename: The QOM typename of the class to cast to.
--=20
2.7.4
