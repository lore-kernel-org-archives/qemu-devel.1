Received: from eggs.gnu.org ([2001:4830:134:3::10]:54311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCPX-0003yp-7b
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:51:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCPU-00079h-0D
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:51:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gXCPT-00079G-QW
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:51:15 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 32FEB7F6C8
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 21:51:15 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Dec 2018 01:48:48 +0400
Message-Id: <20181212214850.29953-27-marcandre.lureau@redhat.com>
In-Reply-To: <20181212214850.29953-1-marcandre.lureau@redhat.com>
References: <20181212214850.29953-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 26/28] qdev-props: call
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
Cc: imammedo@redhat.com, ehabkost@redhat.com

It's now possible to use the common function.

Teach object_apply_global_props() to warn if Error argument is NULL.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/core/qdev-properties.c | 24 ++----------------------
 qom/object.c              | 12 +++++++++++-
 2 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index a2d25d3d37..6061090dc2 100644
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
-        prop =3D g_ptr_array_index(global_props(), i);
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
index dbdab0aead..aa6f3a2a71 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -390,7 +390,17 @@ void object_apply_global_props(Object *obj, const GP=
trArray *props, Error **errp
         if (err !=3D NULL) {
             error_prepend(&err, "can't apply global %s.%s=3D%s: ",
                           p->driver, p->property, p->value);
-            error_propagate(errp, err);
+            /*
+             * If errp !=3D NULL, propagate error and return.
+             * If errp =3D=3D NULL, report a warning, but keep going
+             * with the remaining globals.
+             */
+            if (errp) {
+                error_propagate(errp, err);
+                return;
+            } else {
+                warn_report_err(err);
+            }
         }
     }
 }
--=20
2.20.0
