Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9608C3F68F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:23:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9C54214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pvi0GXzg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C54214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugCo-0004PE-B8
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:23:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iucuA-000120-Si
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iucu9-00014q-Gp
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:18 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28084
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iucu9-00014Q-D7
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lru7EtjHaEqMeItb4R9+tzTA7eHFGIwJYyGXegiVPeE=;
 b=Pvi0GXzgk+q8PmmmeakzdkOu3e8wDK4w+uiE0fOtrQtFbxDMOnHBHROewzaKwCL046u+od
 PIkrlYGjgeAGGfOguS3ewDG+38sfeVnVn48ZpOPNtb4er8l+2A/Sp0JsJy92fs5AHliLsG
 ihhI9fInXkY1Y5ztuZs9ErYsu/2x6DY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-2GIZirLdNfCS80pqO_Gweg-1; Thu, 23 Jan 2020 08:52:15 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6032E100F107
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:52:14 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5AC1C8575C;
 Thu, 23 Jan 2020 13:52:13 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 39/59] object: add object_property_set_default
Date: Thu, 23 Jan 2020 14:50:29 +0100
Message-Id: <1579787449-27599-40-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 2GIZirLdNfCS80pqO_Gweg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Add a default value to ObjectProperty and an implementation of
ObjectPropertyInit that uses it.  This will make it easier to show the
default in help messages.

Also provide convenience functions object_property_set_default_{bool,
str, int, uint}().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200110153039.1379601-11-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h | 37 +++++++++++++++++++++++++++++++++++++
 qom/object.c         | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index afe658c..82cf20f 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -378,6 +378,7 @@ struct ObjectProperty
     ObjectPropertyRelease *release;
     ObjectPropertyInit *init;
     void *opaque;
+    QObject *defval;
 };
=20
 /**
@@ -1056,6 +1057,42 @@ ObjectProperty *object_class_property_add(ObjectClas=
s *klass, const char *name,
                                           void *opaque, Error **errp);
=20
 /**
+ * object_property_set_default_bool:
+ * @prop: the property to set
+ * @value: the value to be written to the property
+ *
+ * Set the property default value.
+ */
+void object_property_set_default_bool(ObjectProperty *prop, bool value);
+
+/**
+ * object_property_set_default_str:
+ * @prop: the property to set
+ * @value: the value to be written to the property
+ *
+ * Set the property default value.
+ */
+void object_property_set_default_str(ObjectProperty *prop, const char *val=
ue);
+
+/**
+ * object_property_set_default_int:
+ * @prop: the property to set
+ * @value: the value to be written to the property
+ *
+ * Set the property default value.
+ */
+void object_property_set_default_int(ObjectProperty *prop, int64_t value);
+
+/**
+ * object_property_set_default_uint:
+ * @prop: the property to set
+ * @value: the value to be written to the property
+ *
+ * Set the property default value.
+ */
+void object_property_set_default_uint(ObjectProperty *prop, uint64_t value=
);
+
+/**
  * object_property_find:
  * @obj: the object
  * @name: the name of the property
diff --git a/qom/object.c b/qom/object.c
index 4ade409..2d29019 100644
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
@@ -268,6 +270,10 @@ static void object_property_free(gpointer data)
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
@@ -1438,6 +1444,45 @@ int64_t object_property_get_int(Object *obj, const c=
har *name,
     return retval;
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
+static void object_property_set_default(ObjectProperty *prop, QObject *def=
val)
+{
+    assert(!prop->defval);
+    assert(!prop->init);
+
+    prop->defval =3D defval;
+    prop->init =3D object_property_init_defval;
+}
+
+void object_property_set_default_bool(ObjectProperty *prop, bool value)
+{
+    object_property_set_default(prop, QOBJECT(qbool_from_bool(value)));
+}
+
+void object_property_set_default_str(ObjectProperty *prop, const char *val=
ue)
+{
+    object_property_set_default(prop, QOBJECT(qstring_from_str(value)));
+}
+
+void object_property_set_default_int(ObjectProperty *prop, int64_t value)
+{
+    object_property_set_default(prop, QOBJECT(qnum_from_int(value)));
+}
+
+void object_property_set_default_uint(ObjectProperty *prop, uint64_t value=
)
+{
+    object_property_set_default(prop, QOBJECT(qnum_from_uint(value)));
+}
+
 void object_property_set_uint(Object *obj, uint64_t value,
                               const char *name, Error **errp)
 {
@@ -2549,6 +2594,9 @@ void object_property_add_alias(Object *obj, const cha=
r *name,
         goto out;
     }
     op->resolve =3D property_resolve_alias;
+    if (target_prop->defval) {
+        op->defval =3D qobject_ref(target_prop->defval);
+    }
=20
     object_property_set_description(obj, op->name,
                                     target_prop->description,
--=20
1.8.3.1



