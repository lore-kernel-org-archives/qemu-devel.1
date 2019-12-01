Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9C8C432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:28:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07F5F2146E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="af1htVre"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F5F2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibNOe-0004YV-VR
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 06:28:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNE7-0001td-5L
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:17:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNE5-0000M5-PZ
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:17:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42218
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ibNE5-0000LZ-LS
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:17:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575199037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vb9T5sEnlrU3GX7+K7C/Qbe2848eZOW4FwS/WKG5AbM=;
 b=af1htVreYxktVSQIbEamZ2+TEj8buqutvmdx3pC6CuRHb78UZ/B3iih7xNDWgaWPRig6p2
 tWLaBWHlxT7WBLSMxd7SD6dnTMFzA/RwAi41/arL2cfAqpPU8kNHN66GGhI73o504Akcii
 KSt5bPxZKM13/5+pdxa4EJxSnNWm0hk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-_XW43EasNgGSX0_993v1GA-1; Sun, 01 Dec 2019 06:17:16 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AC25800D4E
 for <qemu-devel@nongnu.org>; Sun,  1 Dec 2019 11:17:15 +0000 (UTC)
Received: from localhost (unknown [10.36.112.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D0445C541;
 Sun,  1 Dec 2019 11:17:09 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/26] object: add object_property_set_defaut_{bool, str, int,
 uint}()
Date: Sun,  1 Dec 2019 15:15:15 +0400
Message-Id: <20191201111531.1136947-11-marcandre.lureau@redhat.com>
In-Reply-To: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
References: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: _XW43EasNgGSX0_993v1GA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 37 +++++++++++++++++++++++++++++
 qom/object.c         | 56 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 102d941ca5..03574473cd 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -380,6 +380,7 @@ struct ObjectProperty
     ObjectPropertyInit *init;
     ObjectPropertyGetDefault *get_default;
     void *opaque;
+    QObject *defval;
 };
=20
 /**
@@ -1044,6 +1045,42 @@ ObjectProperty *object_class_property_add(ObjectClas=
s *klass, const char *name,
                                           ObjectPropertyRelease *release,
                                           void *opaque, Error **errp);
=20
+/**
+ * object_property_set_defaut_bool:
+ * @prop: the property to set
+ * @value: the value to be written to the property
+ *
+ * Set the property default value.
+ */
+void object_property_set_defaut_bool(ObjectProperty *prop, bool value);
+
+/**
+ * object_property_set_defaut_str:
+ * @prop: the property to set
+ * @value: the value to be written to the property
+ *
+ * Set the property default value.
+ */
+void object_property_set_defaut_str(ObjectProperty *prop, const char *valu=
e);
+
+/**
+ * object_property_set_defaut_int:
+ * @prop: the property to set
+ * @value: the value to be written to the property
+ *
+ * Set the property default value.
+ */
+void object_property_set_defaut_int(ObjectProperty *prop, int64_t value);
+
+/**
+ * object_property_set_defaut_uint:
+ * @prop: the property to set
+ * @value: the value to be written to the property
+ *
+ * Set the property default value.
+ */
+void object_property_set_defaut_uint(ObjectProperty *prop, uint64_t value)=
;
+
 /**
  * object_property_find:
  * @obj: the object
diff --git a/qom/object.c b/qom/object.c
index de43b30e5e..63d489553c 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -19,8 +19,10 @@
 #include "qapi/visitor.h"
 #include "qapi/string-input-visitor.h"
 #include "qapi/string-output-visitor.h"
+#include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-builtin-visit.h"
 #include "qapi/qmp/qerror.h"
+#include "qapi/qmp/qjson.h"
 #include "trace.h"
=20
 /* TODO: replace QObject with a simpler visitor to avoid a dependency
@@ -264,6 +266,10 @@ static void object_property_free(gpointer data)
 {
     ObjectProperty *prop =3D data;
=20
+    if (prop->defval) {
+        qobject_unref(prop->defval);
+        prop->defval =3D NULL;
+    }
     g_free(prop->name);
     g_free(prop->type);
     g_free(prop->description);
@@ -1414,6 +1420,52 @@ char *object_property_get_default(ObjectProperty *pr=
op)
     return prop->get_default(prop);
 }
=20
+static void object_property_init_defval(Object *obj, ObjectProperty *prop)
+{
+    Visitor *v =3D qobject_input_visitor_new(prop->defval);
+
+    assert(prop->set !=3D NULL);
+    prop->set(obj, v, prop->name, prop->opaque, &error_abort);
+
+    visit_free(v);
+}
+
+static char *object_property_get_defval(ObjectProperty *prop)
+{
+    return qstring_free(qobject_to_json(prop->defval), TRUE);
+}
+
+static void object_property_set_defaut(ObjectProperty *prop, QObject *defv=
al)
+{
+    assert(!prop->defval);
+    assert(!prop->init);
+    assert(!prop->get_default);
+
+    prop->defval =3D defval;
+    prop->init =3D object_property_init_defval;
+    prop->get_default =3D object_property_get_defval;
+}
+
+void object_property_set_defaut_bool(ObjectProperty *prop, bool value)
+{
+    object_property_set_defaut(prop, QOBJECT(qbool_from_bool(value)));
+}
+
+void object_property_set_defaut_str(ObjectProperty *prop, const char *valu=
e)
+{
+    object_property_set_defaut(prop, QOBJECT(qstring_from_str(value)));
+}
+
+void object_property_set_defaut_int(ObjectProperty *prop, int64_t value)
+{
+    object_property_set_defaut(prop, QOBJECT(qnum_from_int(value)));
+}
+
+void object_property_set_defaut_uint(ObjectProperty *prop, uint64_t value)
+{
+    object_property_set_defaut(prop, QOBJECT(qnum_from_uint(value)));
+}
+
 void object_property_set_uint(Object *obj, uint64_t value,
                               const char *name, Error **errp)
 {
@@ -2525,6 +2577,10 @@ void object_property_add_alias(Object *obj, const ch=
ar *name,
         goto out;
     }
     op->resolve =3D property_resolve_alias;
+    if (target_prop->get_default) {
+        op->get_default =3D target_prop->get_default;
+        op->defval =3D qobject_ref(target_prop->defval);
+    }
=20
     object_property_set_description(obj, op->name,
                                     target_prop->description,
--=20
2.24.0


