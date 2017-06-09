Received: from eggs.gnu.org ([2001:4830:134:3::10]:38294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJKGG-0000dB-9e
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:47:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJKGF-0003XZ-41
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:47:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dJKGE-0003Wu-RM
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:47:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D232C4E326
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 13:47:33 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  9 Jun 2017 15:46:56 +0200
Message-Id: <1497016045-6009-13-git-send-email-armbru@redhat.com>
In-Reply-To: <1497016045-6009-1-git-send-email-armbru@redhat.com>
References: <1497016045-6009-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/41] object: add uint property setter/getter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20170607163635.17635-13-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qom/object.h | 23 +++++++++++++++++++++++
 qom/object.c         | 29 +++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index cd0f412..abaeb8c 100644
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
index dee7f7c..5f6fdfa 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1216,6 +1216,35 @@ int64_t object_property_get_int(Object *obj, const=
 char *name,
     return retval;
 }
=20
+void object_property_set_uint(Object *obj, uint64_t value,
+                              const char *name, Error **errp)
+{
+    QNum *qnum =3D qnum_from_uint(value);
+
+    object_property_set_qobject(obj, QOBJECT(qnum), name, errp);
+    QDECREF(qnum);
+}
+
+uint64_t object_property_get_uint(Object *obj, const char *name,
+                                  Error **errp)
+{
+    QObject *ret =3D object_property_get_qobject(obj, name, errp);
+    QNum *qnum;
+    uint64_t retval;
+
+    if (!ret) {
+        return 0;
+    }
+    qnum =3D qobject_to_qnum(ret);
+    if (!qnum || !qnum_get_try_uint(qnum, &retval)) {
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
2.7.5
