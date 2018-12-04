Received: from eggs.gnu.org ([2001:4830:134:3::10]:47940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gUBaF-00055v-Se
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:21:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gUBaF-0007Ls-4k
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:21:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gUBaE-0007Lf-VA
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:21:55 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 36AB930832E8
	for <qemu-devel@nongnu.org>; Tue,  4 Dec 2018 14:21:54 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  4 Dec 2018 18:20:16 +0400
Message-Id: <20181204142023.15982-13-marcandre.lureau@redhat.com>
In-Reply-To: <20181204142023.15982-1-marcandre.lureau@redhat.com>
References: <20181204142023.15982-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 v5 12/19] qdev-props: convert
 global_props to GPtrArray
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, ehabkost@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

A step towards being able to call a common function,
object_apply_global_props().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/core/qdev-properties.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 43c30a57f4..3467e0485c 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1173,22 +1173,32 @@ void qdev_prop_set_ptr(DeviceState *dev, const ch=
ar *name, void *value)
     *ptr =3D value;
 }
=20
-static GList *global_props;
+static GPtrArray *global_props(void)
+{
+    static GPtrArray *gp;
+
+    if (!gp) {
+        gp =3D g_ptr_array_new();
+    }
+
+    return gp;
+}
=20
 void qdev_prop_register_global(GlobalProperty *prop)
 {
-    global_props =3D g_list_append(global_props, prop);
+    g_ptr_array_add(global_props(), prop);
 }
=20
 int qdev_prop_check_globals(void)
 {
-    GList *l;
-    int ret =3D 0;
+    int i, ret =3D 0;
=20
-    for (l =3D global_props; l; l =3D l->next) {
-        GlobalProperty *prop =3D l->data;
+    for (i =3D 0; i < global_props()->len; i++) {
+        GlobalProperty *prop;
         ObjectClass *oc;
         DeviceClass *dc;
+
+        prop =3D g_ptr_array_index(global_props(), i);
         if (prop->used) {
             continue;
         }
@@ -1213,12 +1223,13 @@ int qdev_prop_check_globals(void)
=20
 void qdev_prop_set_globals(DeviceState *dev)
 {
-    GList *l;
+    int i;
=20
-    for (l =3D global_props; l; l =3D l->next) {
-        GlobalProperty *prop =3D l->data;
+    for (i =3D 0; i < global_props()->len; i++) {
+        GlobalProperty *prop;
         Error *err =3D NULL;
=20
+        prop =3D g_ptr_array_index(global_props(), i);
         if (object_dynamic_cast(OBJECT(dev), prop->driver) =3D=3D NULL) =
{
             continue;
         }
--=20
2.20.0.rc1
