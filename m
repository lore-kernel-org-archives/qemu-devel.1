Received: from eggs.gnu.org ([2001:4830:134:3::10]:58669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmgzZ-00021I-95
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmgzY-0002UA-8S
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cmgzX-0002To-W5
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:28 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 11 Mar 2017 17:22:42 +0400
Message-Id: <20170311132256.22951-8-marcandre.lureau@redhat.com>
In-Reply-To: <20170311132256.22951-1-marcandre.lureau@redhat.com>
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 07/21] object: add uint property setter/getter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, anderson@redhat.com, mdroth@linux.vnet.ibm.com, armbru@redhat.com, lersek@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 23 +++++++++++++++++++++++
 qom/object.c         | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index cd0f412ce9..abaeb8cf4e 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1094,6 +1094,29 @@ int64_t object_property_get_int(Object *obj, const=
 char *name,
                                 Error **errp);
=20
 /**
+ * object_property_set_uint:
+ * @value: the value to be written to the property
+ * @name: the name of the property
+ * @errp: returns an error if this function fails
+ *
+ * Writes an unsigned integer value to a property.
+ */
+void object_property_set_uint(Object *obj, uint64_t value,
+                              const char *name, Error **errp);
+
+/**
+ * object_property_get_uint:
+ * @obj: the object
+ * @name: the name of the property
+ * @errp: returns an error if this function fails
+ *
+ * Returns: the value of the property, converted to an unsigned integer,=
 or 0
+ * an error occurs (including when the property value is not an integer)=
.
+ */
+uint64_t object_property_get_uint(Object *obj, const char *name,
+                                  Error **errp);
+
+/**
  * object_property_get_enum:
  * @obj: the object
  * @name: the name of the property
diff --git a/qom/object.c b/qom/object.c
index c7b8079df6..ca9d4137b3 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -28,6 +28,7 @@
 #include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qint.h"
+#include "qapi/qmp/quint.h"
 #include "qapi/qmp/qstring.h"
=20
 #define MAX_INTERFACES 32
@@ -1218,6 +1219,37 @@ int64_t object_property_get_int(Object *obj, const=
 char *name,
     return retval;
 }
=20
+void object_property_set_uint(Object *obj, uint64_t value,
+                             const char *name, Error **errp)
+{
+    QUInt *quint =3D quint_from_uint(value);
+    object_property_set_qobject(obj, QOBJECT(quint), name, errp);
+
+    QDECREF(quint);
+}
+
+uint64_t object_property_get_uint(Object *obj, const char *name,
+                                  Error **errp)
+{
+    QObject *ret =3D object_property_get_qobject(obj, name, errp);
+    QUInt *quint;
+    uint64_t retval;
+
+    if (!ret) {
+        return 0;
+    }
+    quint =3D qobject_to_quint(ret);
+    if (!quint) {
+        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name, "uint");
+        retval =3D 0;
+    } else {
+        retval =3D quint_get_uint(quint);
+    }
+
+    qobject_decref(ret);
+    return retval;
+}
+
 typedef struct EnumProperty {
     const char * const *strings;
     int (*get)(Object *, Error **);
--=20
2.12.0.191.gc5d8de91d
