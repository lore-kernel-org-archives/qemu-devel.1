Received: from eggs.gnu.org ([2001:4830:134:3::10]:60332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dX1MF-0006Mq-Ns
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:26:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dX1ME-0001lj-P8
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:26:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dX1ME-0001lc-G6
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:26:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 833DA4E4D4
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 08:26:21 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 17 Jul 2017 16:26:01 +0800
Message-Id: <1500279971-13875-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1500279971-13875-1-git-send-email-peterx@redhat.com>
References: <1500279971-13875-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 01/11] qdev: provide DEFINE_PROP_INT64()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

We have merely all the stuff, but this one is missing. Add it in.

Am going to use this new helper for MigrationParameters fields, since
most of them are int64_t.

CC: Markus Armbruster <armbru@redhat.com>
CC: Eduardo Habkost <ehabkost@redhat.com>
CC: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
CC: Peter Xu <peterx@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
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
index f6692d5..30af33b 100644
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
@@ -136,6 +137,8 @@ extern const PropertyInfo qdev_prop_link;
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_int32, int32_t)
 #define DEFINE_PROP_UINT64(_n, _s, _f, _d)                      \
     DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint64, uint64_t)
+#define DEFINE_PROP_INT64(_n, _s, _f, _d)                      \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_int64, int64_t)
 #define DEFINE_PROP_SIZE(_n, _s, _f, _d)                       \
     DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_size, uint64_t)
 #define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)                   \
--=20
2.7.4
