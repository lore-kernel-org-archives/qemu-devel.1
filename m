Received: from eggs.gnu.org ([2001:4830:134:3::10]:40305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmL2-0007zJ-3o
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:41:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmL0-0005jR-Qo
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:41:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eBmL0-0005h7-Il
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:41:34 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  6 Nov 2017 19:39:23 +0100
Message-Id: <20171106183925.16747-27-marcandre.lureau@redhat.com>
In-Reply-To: <20171106183925.16747-1-marcandre.lureau@redhat.com>
References: <20171106183925.16747-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 26/28] qdev: add DEFINE_PROP_TPMBE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com, stefanb@linux.vnet.ibm.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

A property to lookup a tpm backend.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/qdev-properties.h     |  3 ++
 hw/core/qdev-properties-system.c | 64 ++++++++++++++++++++++++++++++++++=
++++++
 2 files changed, 67 insertions(+)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index e2321f1cc1..4d24cdf8d6 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -17,6 +17,7 @@ extern const PropertyInfo qdev_prop_int64;
 extern const PropertyInfo qdev_prop_size;
 extern const PropertyInfo qdev_prop_string;
 extern const PropertyInfo qdev_prop_chr;
+extern const PropertyInfo qdev_prop_tpm;
 extern const PropertyInfo qdev_prop_ptr;
 extern const PropertyInfo qdev_prop_macaddr;
 extern const PropertyInfo qdev_prop_on_off_auto;
@@ -186,6 +187,8 @@ extern const PropertyInfo qdev_prop_link;
=20
 #define DEFINE_PROP_CHR(_n, _s, _f)             \
     DEFINE_PROP(_n, _s, _f, qdev_prop_chr, CharBackend)
+#define DEFINE_PROP_TPMBE(_n, _s, _f)                     \
+    DEFINE_PROP(_n, _s, _f, qdev_prop_tpm, TPMBackend *)
 #define DEFINE_PROP_STRING(_n, _s, _f)             \
     DEFINE_PROP(_n, _s, _f, qdev_prop_string, char*)
 #define DEFINE_PROP_NETDEV(_n, _s, _f)             \
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-s=
ystem.c
index ec10da7424..c17364655c 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -21,6 +21,7 @@
 #include "net/hub.h"
 #include "qapi/visitor.h"
 #include "chardev/char-fe.h"
+#include "sysemu/tpm_backend.h"
 #include "sysemu/iothread.h"
=20
 static void get_pointer(Object *obj, Visitor *v, Property *prop,
@@ -236,6 +237,69 @@ const PropertyInfo qdev_prop_chr =3D {
     .release =3D release_chr,
 };
=20
+/* --- character device --- */
+
+static void get_tpm(Object *obj, Visitor *v, const char *name, void *opa=
que,
+                    Error **errp)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    TPMBackend **be =3D qdev_get_prop_ptr(dev, opaque);
+    char *p;
+
+    p =3D g_strdup(*be ? (*be)->id : "");
+    visit_type_str(v, name, &p, errp);
+    g_free(p);
+}
+
+static void set_tpm(Object *obj, Visitor *v, const char *name, void *opa=
que,
+                    Error **errp)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    Error *local_err =3D NULL;
+    Property *prop =3D opaque;
+    TPMBackend *s, **be =3D qdev_get_prop_ptr(dev, prop);
+    char *str;
+
+    if (dev->realized) {
+        qdev_prop_set_after_realize(dev, name, errp);
+        return;
+    }
+
+    visit_type_str(v, name, &str, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    s =3D qemu_find_tpm_be(str);
+    if (s =3D=3D NULL) {
+        error_setg(errp, "Property '%s.%s' can't find value '%s'",
+                   object_get_typename(obj), prop->name, str);
+    } else if (tpm_backend_init(s, TPM_IF(obj), errp) =3D=3D 0) {
+        *be =3D s; /* weak reference, avoid cyclic ref */
+    }
+    g_free(str);
+}
+
+static void release_tpm(Object *obj, const char *name, void *opaque)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    Property *prop =3D opaque;
+    TPMBackend **be =3D qdev_get_prop_ptr(dev, prop);
+
+    if (*be) {
+        tpm_backend_reset(*be);
+    }
+}
+
+const PropertyInfo qdev_prop_tpm =3D {
+    .name  =3D "str",
+    .description =3D "ID of a tpm to use as a backend",
+    .get   =3D get_tpm,
+    .set   =3D set_tpm,
+    .release =3D release_tpm,
+};
+
 /* --- netdev device --- */
 static void get_netdev(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
--=20
2.15.0.rc0.40.gaefcc5f6f
