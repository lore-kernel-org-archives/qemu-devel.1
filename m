Received: from eggs.gnu.org ([2001:4830:134:3::10]:59113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dXUdF-0008Nh-9U
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:41:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dXUdE-0005yF-9Q
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:41:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dXUdE-0005xZ-0Y
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:41:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 031FFC04D2EF
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 15:41:51 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 18 Jul 2017 17:41:18 +0200
Message-Id: <20170718154127.6459-8-quintela@redhat.com>
In-Reply-To: <20170718154127.6459-1-quintela@redhat.com>
References: <20170718154127.6459-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/16] qdev: provide DEFINE_PROP_INT64()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eric Blake <eblake@redhat.com>

From: Peter Xu <peterx@redhat.com>

We have nearly all the stuff, but this one is missing. Add it in.

Am going to use this new helper for MigrationParameters fields, since
most of them are int64_t.

CC: Markus Armbruster <armbru@redhat.com>
CC: Eduardo Habkost <ehabkost@redhat.com>
CC: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
CC: Peter Xu <peterx@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Marcel Apfelbaum <marcel@redhat.com>
CC: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1500349150-13240-2-git-send-email-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/core/qdev-properties.c    | 32 ++++++++++++++++++++++++++++++++
 include/hw/qdev-properties.h |  3 +++
 2 files changed, 35 insertions(+)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index dcecdf0..c1d4e54 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -404,6 +404,31 @@ static void set_uint64(Object *obj, Visitor *v, cons=
t char *name,
     visit_type_uint64(v, name, ptr, errp);
 }
=20
+static void get_int64(Object *obj, Visitor *v, const char *name,
+                      void *opaque, Error **errp)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    Property *prop =3D opaque;
+    int64_t *ptr =3D qdev_get_prop_ptr(dev, prop);
+
+    visit_type_int64(v, name, ptr, errp);
+}
+
+static void set_int64(Object *obj, Visitor *v, const char *name,
+                      void *opaque, Error **errp)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    Property *prop =3D opaque;
+    int64_t *ptr =3D qdev_get_prop_ptr(dev, prop);
+
+    if (dev->realized) {
+        qdev_prop_set_after_realize(dev, name, errp);
+        return;
+    }
+
+    visit_type_int64(v, name, ptr, errp);
+}
+
 const PropertyInfo qdev_prop_uint64 =3D {
     .name  =3D "uint64",
     .get   =3D get_uint64,
@@ -411,6 +436,13 @@ const PropertyInfo qdev_prop_uint64 =3D {
     .set_default_value =3D set_default_value_uint,
 };
=20
+const PropertyInfo qdev_prop_int64 =3D {
+    .name  =3D "int64",
+    .get   =3D get_int64,
+    .set   =3D set_int64,
+    .set_default_value =3D set_default_value_int,
+};
+
 /* --- string --- */
=20
 static void release_string(Object *obj, const char *name, void *opaque)
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 3929796..e2321f1 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -13,6 +13,7 @@ extern const PropertyInfo qdev_prop_uint16;
 extern const PropertyInfo qdev_prop_uint32;
 extern const PropertyInfo qdev_prop_int32;
 extern const PropertyInfo qdev_prop_uint64;
+extern const PropertyInfo qdev_prop_int64;
 extern const PropertyInfo qdev_prop_size;
 extern const PropertyInfo qdev_prop_string;
 extern const PropertyInfo qdev_prop_chr;
@@ -157,6 +158,8 @@ extern const PropertyInfo qdev_prop_link;
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_int32, int32_t)
 #define DEFINE_PROP_UINT64(_n, _s, _f, _d)                      \
     DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint64, uint64_t)
+#define DEFINE_PROP_INT64(_n, _s, _f, _d)                      \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_int64, int64_t)
 #define DEFINE_PROP_SIZE(_n, _s, _f, _d)                       \
     DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_size, uint64_t)
 #define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)                   \
--=20
2.9.4
