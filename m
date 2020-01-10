Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECCCC282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:41:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7991920721
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbQkoZcB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7991920721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipwPn-0002gg-8l
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 10:41:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ipwGU-0006ey-Mt
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:31:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ipwGR-0004tz-Ox
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:31:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23780
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ipwGR-0004ss-GX
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:31:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578670314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nBHYmbX0RpFJpEW6MFvTV9YldnwclbkL80oUupFq03o=;
 b=AbQkoZcBsOIsk3TLsZOmkOEqOJCKIEQY4n4taJzU4Y6jc0r7UrAMwJzy3c2GJZKZ+qAmOl
 XbfdmEVsrvwN1vFfjxIAzdqvFpQ4E0g0LZG6T5IXbRYpmlBQzAK6VwfPYZ6zkXYHrTcvpX
 ZxUXYHwiN4SbkfQi3g4jzutAv7tZRYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-2iga5b2pM1OE_UuZhGFnYA-1; Fri, 10 Jan 2020 10:31:53 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8891185432D
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 15:31:52 +0000 (UTC)
Received: from localhost (ovpn-112-59.ams2.redhat.com [10.36.112.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EFB8E272CB;
 Fri, 10 Jan 2020 15:31:45 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/26] object: add class property initializer
Date: Fri, 10 Jan 2020 19:30:19 +0400
Message-Id: <20200110153039.1379601-7-marcandre.lureau@redhat.com>
In-Reply-To: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
References: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 2iga5b2pM1OE_UuZhGFnYA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This callback is used to set default value in following patch "object:
add object_property_set_defaut_{bool,str,int,uint}()".

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 16 ++++++++++++++--
 qom/object.c         | 14 ++++++++++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 54a548868c..29f47d3b35 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -309,6 +309,8 @@ typedef struct InterfaceInfo InterfaceInfo;
  */
=20
=20
+typedef struct ObjectProperty ObjectProperty;
+
 /**
  * ObjectPropertyAccessor:
  * @obj: the object that owns the property
@@ -356,7 +358,16 @@ typedef void (ObjectPropertyRelease)(Object *obj,
                                      const char *name,
                                      void *opaque);
=20
-typedef struct ObjectProperty
+/**
+ * ObjectPropertyInit:
+ * @obj: the object that owns the property
+ * @prop: the property to set
+ *
+ * Called when a property is initialized.
+ */
+typedef void (ObjectPropertyInit)(Object *obj, ObjectProperty *prop);
+
+struct ObjectProperty
 {
     gchar *name;
     gchar *type;
@@ -365,8 +376,9 @@ typedef struct ObjectProperty
     ObjectPropertyAccessor *set;
     ObjectPropertyResolve *resolve;
     ObjectPropertyRelease *release;
+    ObjectPropertyInit *init;
     void *opaque;
-} ObjectProperty;
+};
=20
 /**
  * ObjectUnparent:
diff --git a/qom/object.c b/qom/object.c
index 29101fdcd4..1e9113bfc8 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -469,6 +469,19 @@ void object_apply_compat_props(Object *obj)
     }
 }
=20
+static void object_class_property_init_all(Object *obj)
+{
+    ObjectPropertyIterator iter;
+    ObjectProperty *prop;
+
+    object_class_property_iter_init(&iter, object_get_class(obj));
+    while ((prop =3D object_property_iter_next(&iter))) {
+        if (prop->init) {
+            prop->init(obj, prop);
+        }
+    }
+}
+
 static void object_initialize_with_type(void *data, size_t size, TypeImpl =
*type)
 {
     Object *obj =3D data;
@@ -482,6 +495,7 @@ static void object_initialize_with_type(void *data, siz=
e_t size, TypeImpl *type)
     memset(obj, 0, type->instance_size);
     obj->class =3D type->class;
     object_ref(obj);
+    object_class_property_init_all(obj);
     obj->properties =3D g_hash_table_new_full(g_str_hash, g_str_equal,
                                             NULL, object_property_free);
     object_init_with_type(obj, type);
--=20
2.25.0.rc1.20.g2443f3f80d.dirty


