Received: from eggs.gnu.org ([2001:4830:134:3::10]:37610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gKN6j-0007hE-Rt
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 07:38:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gKN6f-00074j-Ov
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 07:38:51 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  7 Nov 2018 16:36:46 +0400
Message-Id: <20181107123652.23417-9-marcandre.lureau@redhat.com>
In-Reply-To: <20181107123652.23417-1-marcandre.lureau@redhat.com>
References: <20181107123652.23417-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 v3 08/14] qdev-props: convert
 global_props to GArray
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, dgilbert@redhat.com, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, xen-devel@lists.xenproject.org, Artyom Tarasenko <atar4qemu@gmail.com>, Anthony Perard <anthony.perard@citrix.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Amit Shah <amit@kernel.org>, Stefan Berger <stefanb@linux.ibm.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <minyard@acm.org>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

A step towards being able to call object_apply_global_props().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/core/qdev-properties.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 43c30a57f4..353e67c05a 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1173,22 +1173,32 @@ void qdev_prop_set_ptr(DeviceState *dev, const ch=
ar *name, void *value)
     *ptr =3D value;
 }
=20
-static GList *global_props;
+static GArray *global_props(void)
+{
+    static GArray *gp;
+
+    if (!gp) {
+        gp =3D g_array_new(false, false, sizeof(GlobalProperty *));
+    }
+
+    return gp;
+}
=20
 void qdev_prop_register_global(GlobalProperty *prop)
 {
-    global_props =3D g_list_append(global_props, prop);
+    g_array_append_val(global_props(), prop);
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
+        prop =3D g_array_index(global_props(), GlobalProperty *, i);
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
+        prop =3D g_array_index(global_props(), GlobalProperty *, i);
         if (object_dynamic_cast(OBJECT(dev), prop->driver) =3D=3D NULL) =
{
             continue;
         }
--=20
2.19.1.708.g4ede3d42df
