Received: from eggs.gnu.org ([2001:4830:134:3::10]:33232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e1e5D-0003H1-11
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 15:51:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e1e58-0006MM-QA
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 15:51:23 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  9 Oct 2017 21:50:49 +0200
Message-Id: <1507578671-158758-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507578671-158758-1-git-send-email-imammedo@redhat.com>
References: <1507578671-158758-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 02/24] qom: introduce
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
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>

it will help to remove code duplication of registration
static types in places that have open coded loop to
perform batch type registering.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/qom/object.h | 10 ++++++++++
 qom/object.c         |  9 +++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index a707b67..9a2369c 100644
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
index 6a7bd92..c58c52d 100644
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
