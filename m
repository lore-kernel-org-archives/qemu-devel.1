Received: from eggs.gnu.org ([2001:4830:134:3::10]:45748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d896L-0008DN-13
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:39:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d896G-0004S7-6v
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:39:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d896F-0004Ru-UV
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:39:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D7D7680472
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 17:39:02 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 May 2017 20:35:52 +0300
Message-Id: <20170509173559.31598-11-marcandre.lureau@redhat.com>
In-Reply-To: <20170509173559.31598-1-marcandre.lureau@redhat.com>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/17] object: add uint property setter/getter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 23 +++++++++++++++++++++++
 qom/object.c         | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

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
index c1644dbcb7..a9259e330d 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1221,6 +1221,39 @@ int64_t object_property_get_int(Object *obj, const=
 char *name,
     return retval;
 }
=20
+void object_property_set_uint(Object *obj, uint64_t value,
+                             const char *name, Error **errp)
+{
+    QNum *qn =3D qnum_from_uint(value);
+    object_property_set_qobject(obj, QOBJECT(qn), name, errp);
+    QDECREF(qn);
+}
+
+uint64_t object_property_get_uint(Object *obj, const char *name,
+                                  Error **errp)
+{
+    QObject *ret =3D object_property_get_qobject(obj, name, errp);
+    Error *err =3D NULL;
+    QNum *qnum;
+    uint64_t retval;
+
+    if (!ret) {
+        return 0;
+    }
+    qnum =3D qobject_to_qnum(ret);
+    if (qnum) {
+        retval =3D qnum_get_uint(qnum, &err);
+    }
+
+    if (!qnum || err) {
+        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name, "uint");
+        retval =3D 0;
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
2.13.0.rc1.16.gd80b50c3f
