Received: from eggs.gnu.org ([2001:4830:134:3::10]:52357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06Yc-0007B6-Ld
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06Ya-0008G1-Lm
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e06Ya-0008Fc-Fz
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:20 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  5 Oct 2017 15:50:36 +0200
Message-Id: <1507211474-188400-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
References: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 02/40] qom: introduce
 type_register_static_array()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

it will help to remove code duplication of registration
static types in places that have open coded loop to
perform batch type registering.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 include/qom/object.h | 10 ++++++++++
 qom/object.c         |  9 +++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 76a5e3a..ce25567 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -789,6 +789,16 @@ Type type_register_static(const TypeInfo *info);
 Type type_register(const TypeInfo *info);
=20
 /**
+ * type_register_static_array:
+ * @infos: The array of the new type #TypeInfo structures.
+ * @nr_infos: number of entries in @infos
+ *
+ * @infos and all of the strings it points to should exist for the life =
time
+ * that the type is registered.
+ */
+void type_register_static_array(const TypeInfo *infos, int nr_infos);
+
+/**
  * object_class_dynamic_cast_assert:
  * @klass: The #ObjectClass to attempt to cast.
  * @typename: The QOM typename of the class to cast to.
diff --git a/qom/object.c b/qom/object.c
index 3e18537..f4c377a 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -151,6 +151,15 @@ TypeImpl *type_register_static(const TypeInfo *info)
     return type_register(info);
 }
=20
+void type_register_static_array(const TypeInfo *infos, int nr_infos)
+{
+    int i;
+
+    for (i =3D 0; i < nr_infos; i++) {
+        type_register_static(&infos[i]);
+    }
+}
+
 static TypeImpl *type_get_by_name(const char *name)
 {
     if (name =3D=3D NULL) {
--=20
2.7.4
