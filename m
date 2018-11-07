Received: from eggs.gnu.org ([2001:4830:134:3::10]:37900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gKN7F-0008Ag-8Q
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 07:39:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gKN79-0007QB-VN
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 07:39:23 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  7 Nov 2018 16:36:48 +0400
Message-Id: <20181107123652.23417-11-marcandre.lureau@redhat.com>
In-Reply-To: <20181107123652.23417-1-marcandre.lureau@redhat.com>
References: <20181107123652.23417-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 v3 10/14] qdev-props: call
 object_apply_global_props()
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

It's now possible to use the common function.

Teach object_apply_global_props() to warn if Error argument is NULL.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/core/qdev-properties.c | 24 ++----------------------
 qom/object.c              |  6 +++++-
 2 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 8728cbab9f..239535a4cb 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1223,28 +1223,8 @@ int qdev_prop_check_globals(void)
=20
 void qdev_prop_set_globals(DeviceState *dev)
 {
-    int i;
-
-    for (i =3D 0; i < global_props()->len; i++) {
-        GlobalProperty *prop;
-        Error *err =3D NULL;
-
-        prop =3D g_array_index(global_props(), GlobalProperty *, i);
-        if (object_dynamic_cast(OBJECT(dev), prop->driver) =3D=3D NULL) =
{
-            continue;
-        }
-        prop->used =3D true;
-        object_property_parse(OBJECT(dev), prop->value, prop->property, =
&err);
-        if (err !=3D NULL) {
-            error_prepend(&err, "can't apply global %s.%s=3D%s: ",
-                          prop->driver, prop->property, prop->value);
-            if (!dev->hotplugged) {
-                error_propagate(&error_fatal, err);
-            } else {
-                warn_report_err(err);
-            }
-        }
-    }
+    object_apply_global_props(OBJECT(dev), global_props(),
+                              dev->hotplugged ? NULL : &error_fatal);
 }
=20
 /* --- 64bit unsigned int 'size' type --- */
diff --git a/qom/object.c b/qom/object.c
index 9acdf9e16d..b1a7f70550 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -392,7 +392,11 @@ void object_apply_global_props(Object *obj, GArray *=
props, Error **errp)
         if (err !=3D NULL) {
             error_prepend(&err, "can't apply global %s.%s=3D%s: ",
                           p->driver, p->property, p->value);
-            error_propagate(errp, err);
+            if (errp) {
+                error_propagate(errp, err);
+            } else {
+                warn_report_err(err);
+            }
         }
     }
 }
--=20
2.19.1.708.g4ede3d42df
