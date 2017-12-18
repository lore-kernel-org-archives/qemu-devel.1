Received: from eggs.gnu.org ([208.118.235.92]:51233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eR0HL-0002oA-WC
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 13:36:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eR0HH-0001X1-NP
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 13:36:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eR0HH-0001WH-EU
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 13:36:39 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 18 Dec 2017 19:36:31 +0100
Message-Id: <20171218183631.32357-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] tpm: move qdev_prop_tpm to hw/tpm/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanb@linux.vnet.ibm.com, pbonzini@redhat.com
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, qemu-devel@nongnu.org, lvivier@redhat.com, f4bug@amsat.org, Cornelia Huck <cohuck@redhat.com>

Building with --disable-tpm yields

../hw/core/qdev-properties-system.o: In function `set_tpm':
/home/cohuck/git/qemu/hw/core/qdev-properties-system.c:274: undefined ref=
erence to `qemu_find_tpm_be'
/home/cohuck/git/qemu/hw/core/qdev-properties-system.c:278: undefined ref=
erence to `tpm_backend_init'
../hw/core/qdev-properties-system.o: In function `release_tpm':
/home/cohuck/git/qemu/hw/core/qdev-properties-system.c:291: undefined ref=
erence to `tpm_backend_reset'

Move the implementation of DEFINE_PROP_TPMBE to hw/tpm/ so that it is
only built when tpm is actually configured, and build tpm_util in every
case.

Fixes: 493b78303532 ("qdev: add DEFINE_PROP_TPMBE")
Reported-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
v1->v2: fix x86_64 build with mingw (always build tpm_util)
---
 hw/core/qdev-properties-system.c | 64 ----------------------------------=
----
 hw/tpm/Makefile.objs             |  5 +--
 hw/tpm/tpm_util.c                | 67 ++++++++++++++++++++++++++++++++++=
++++++
 hw/tpm/tpm_util.h                |  3 ++
 include/hw/qdev-properties.h     |  2 --
 5 files changed, 73 insertions(+), 68 deletions(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-s=
ystem.c
index c17364655c..ec10da7424 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -21,7 +21,6 @@
 #include "net/hub.h"
 #include "qapi/visitor.h"
 #include "chardev/char-fe.h"
-#include "sysemu/tpm_backend.h"
 #include "sysemu/iothread.h"
=20
 static void get_pointer(Object *obj, Visitor *v, Property *prop,
@@ -237,69 +236,6 @@ const PropertyInfo qdev_prop_chr =3D {
     .release =3D release_chr,
 };
=20
-/* --- character device --- */
-
-static void get_tpm(Object *obj, Visitor *v, const char *name, void *opa=
que,
-                    Error **errp)
-{
-    DeviceState *dev =3D DEVICE(obj);
-    TPMBackend **be =3D qdev_get_prop_ptr(dev, opaque);
-    char *p;
-
-    p =3D g_strdup(*be ? (*be)->id : "");
-    visit_type_str(v, name, &p, errp);
-    g_free(p);
-}
-
-static void set_tpm(Object *obj, Visitor *v, const char *name, void *opa=
que,
-                    Error **errp)
-{
-    DeviceState *dev =3D DEVICE(obj);
-    Error *local_err =3D NULL;
-    Property *prop =3D opaque;
-    TPMBackend *s, **be =3D qdev_get_prop_ptr(dev, prop);
-    char *str;
-
-    if (dev->realized) {
-        qdev_prop_set_after_realize(dev, name, errp);
-        return;
-    }
-
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
-    s =3D qemu_find_tpm_be(str);
-    if (s =3D=3D NULL) {
-        error_setg(errp, "Property '%s.%s' can't find value '%s'",
-                   object_get_typename(obj), prop->name, str);
-    } else if (tpm_backend_init(s, TPM_IF(obj), errp) =3D=3D 0) {
-        *be =3D s; /* weak reference, avoid cyclic ref */
-    }
-    g_free(str);
-}
-
-static void release_tpm(Object *obj, const char *name, void *opaque)
-{
-    DeviceState *dev =3D DEVICE(obj);
-    Property *prop =3D opaque;
-    TPMBackend **be =3D qdev_get_prop_ptr(dev, prop);
-
-    if (*be) {
-        tpm_backend_reset(*be);
-    }
-}
-
-const PropertyInfo qdev_prop_tpm =3D {
-    .name  =3D "str",
-    .description =3D "ID of a tpm to use as a backend",
-    .get   =3D get_tpm,
-    .set   =3D set_tpm,
-    .release =3D release_tpm,
-};
-
 /* --- netdev device --- */
 static void get_netdev(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
index 41f0b7a590..7a93b24636 100644
--- a/hw/tpm/Makefile.objs
+++ b/hw/tpm/Makefile.objs
@@ -1,3 +1,4 @@
+common-obj-y +=3D tpm_util.o
 common-obj-$(CONFIG_TPM_TIS) +=3D tpm_tis.o
-common-obj-$(CONFIG_TPM_PASSTHROUGH) +=3D tpm_passthrough.o tpm_util.o
-common-obj-$(CONFIG_TPM_EMULATOR) +=3D tpm_emulator.o tpm_util.o
+common-obj-$(CONFIG_TPM_PASSTHROUGH) +=3D tpm_passthrough.o
+common-obj-$(CONFIG_TPM_EMULATOR) +=3D tpm_emulator.o
diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
index a317243a7e..17cafbe6b3 100644
--- a/hw/tpm/tpm_util.c
+++ b/hw/tpm/tpm_util.c
@@ -21,9 +21,13 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
 #include "tpm_util.h"
 #include "tpm_int.h"
 #include "exec/memory.h"
+#include "sysemu/tpm_backend.h"
+#include "hw/qdev.h"
=20
 #define DEBUG_TPM 0
=20
@@ -33,6 +37,69 @@
     } \
 } while (0)
=20
+/* tpm backend property */
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
 /*
  * Write an error message in the given output buffer.
  */
diff --git a/hw/tpm/tpm_util.h b/hw/tpm/tpm_util.h
index 1c17e3913b..2393b6bc0e 100644
--- a/hw/tpm/tpm_util.h
+++ b/hw/tpm/tpm_util.h
@@ -39,4 +39,7 @@ static inline uint32_t tpm_cmd_get_size(const void *b)
 int tpm_util_get_buffer_size(int tpm_fd, TPMVersion tpm_version,
                              size_t *buffersize);
=20
+#define DEFINE_PROP_TPMBE(_n, _s, _f)                     \
+    DEFINE_PROP(_n, _s, _f, qdev_prop_tpm, TPMBackend *)
+
 #endif /* TPM_TPM_UTIL_H */
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 4d24cdf8d6..60b42ac561 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -187,8 +187,6 @@ extern const PropertyInfo qdev_prop_link;
=20
 #define DEFINE_PROP_CHR(_n, _s, _f)             \
     DEFINE_PROP(_n, _s, _f, qdev_prop_chr, CharBackend)
-#define DEFINE_PROP_TPMBE(_n, _s, _f)                     \
-    DEFINE_PROP(_n, _s, _f, qdev_prop_tpm, TPMBackend *)
 #define DEFINE_PROP_STRING(_n, _s, _f)             \
     DEFINE_PROP(_n, _s, _f, qdev_prop_string, char*)
 #define DEFINE_PROP_NETDEV(_n, _s, _f)             \
--=20
2.13.6
