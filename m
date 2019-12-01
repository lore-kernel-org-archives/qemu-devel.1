Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7ADCC432C3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:24:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2AA820725
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bAGBde39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2AA820725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibNKu-0000XS-Er
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 06:24:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNDh-0001Pd-3C
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:16:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNDf-0008UK-4s
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:16:53 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55084
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ibNDb-0008RM-A6
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:16:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575199002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MLUjBxiVjVLIDgpoaa6jIWtiFGePuIQHhtTHEdht4sw=;
 b=bAGBde39f/QBwJjz8eHNDpxmiVsc6uPlcqdcbwq39l3BvWIchSYH7tCJ0kXfyrtYMH+BjF
 8BUV3rLC7IqTvKUOWxP39DjiYQsVt5NHyonZGPnNJGvZQIYZ8lCo5/zaQxsMwPGl7INnOv
 8vkuJs0t9CnzEZJ6Q4tTIjFfJ5jK5KY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-pIBSBzL2NNCI0T4-jS6Afg-1; Sun, 01 Dec 2019 06:16:39 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EDE1184CABB
 for <qemu-devel@nongnu.org>; Sun,  1 Dec 2019 11:16:38 +0000 (UTC)
Received: from localhost (unknown [10.36.112.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED918600C8;
 Sun,  1 Dec 2019 11:16:33 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/26] object: add class property initializer
Date: Sun,  1 Dec 2019 15:15:11 +0400
Message-Id: <20191201111531.1136947-7-marcandre.lureau@redhat.com>
In-Reply-To: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
References: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: pIBSBzL2NNCI0T4-jS6Afg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
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
index 128d00c77f..e15ebd486b 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -303,6 +303,8 @@ typedef struct InterfaceInfo InterfaceInfo;
  */
=20
=20
+typedef struct ObjectProperty ObjectProperty;
+
 /**
  * ObjectPropertyAccessor:
  * @obj: the object that owns the property
@@ -350,7 +352,16 @@ typedef void (ObjectPropertyRelease)(Object *obj,
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
@@ -359,8 +370,9 @@ typedef struct ObjectProperty
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
index f1e1e0947b..4b9f8d8668 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -450,6 +450,19 @@ void object_apply_compat_props(Object *obj)
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
@@ -463,6 +476,7 @@ static void object_initialize_with_type(void *data, siz=
e_t size, TypeImpl *type)
     memset(obj, 0, type->instance_size);
     obj->class =3D type->class;
     object_ref(obj);
+    object_class_property_init_all(obj);
     obj->properties =3D g_hash_table_new_full(g_str_hash, g_str_equal,
                                             NULL, object_property_free);
     object_init_with_type(obj, type);
--=20
2.24.0


