Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B62C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:44:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4178C20721
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FWm5k5Zq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4178C20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipwSJ-0006dY-PE
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 10:44:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ipwGi-0006sy-IC
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:32:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ipwGh-0005d1-BV
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:32:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28704
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ipwGh-0005bX-6d
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:32:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578670330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LuRnPGYw4ga0F7e6YpZFaN9OO9bJIZy0z2/K6cAho1U=;
 b=FWm5k5Zq9HnkSvE9rpXnDDP9fRifrc9svU+3Mzjm5gnSmW20vItvtixki4DdxMg962lK2p
 oY2ThCCW3EOVq/nnBaqVqEwU+uSn3BAOKF1EVuPVQa6oOGuKK0TAmnhpAGmchmZ0ck5a5s
 InkiKvc/aV7ie3MsUk17fKH9uflogdU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-am0MjwHhMyqp60HxgjqvAw-1; Fri, 10 Jan 2020 10:32:07 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D830412CE5C
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 15:32:06 +0000 (UTC)
Received: from localhost (ovpn-112-59.ams2.redhat.com [10.36.112.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CED55C1B5;
 Fri, 10 Jan 2020 15:32:00 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/26] object: add object_property_get_defaut()
Date: Fri, 10 Jan 2020 19:30:20 +0400
Message-Id: <20200110153039.1379601-8-marcandre.lureau@redhat.com>
In-Reply-To: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
References: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: am0MjwHhMyqp60HxgjqvAw-1
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

The new callback will be used in following "object: add
object_property_set_defaut_{bool,str,int,uint}()" and "vl: print
default value in object help" patches.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 17 +++++++++++++++++
 qom/object.c         |  9 +++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 29f47d3b35..ca47308ac4 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -367,6 +367,13 @@ typedef void (ObjectPropertyRelease)(Object *obj,
  */
 typedef void (ObjectPropertyInit)(Object *obj, ObjectProperty *prop);
=20
+/**
+ * ObjectPropertyGetDefault:
+ *
+ * Get an allocated string representation of the default value.
+ */
+typedef char *(ObjectPropertyGetDefault)(ObjectProperty *prop);
+
 struct ObjectProperty
 {
     gchar *name;
@@ -377,6 +384,7 @@ struct ObjectProperty
     ObjectPropertyResolve *resolve;
     ObjectPropertyRelease *release;
     ObjectPropertyInit *init;
+    ObjectPropertyGetDefault *get_default;
     void *opaque;
 };
=20
@@ -1233,6 +1241,15 @@ bool object_property_get_bool(Object *obj, const cha=
r *name,
 void object_property_set_int(Object *obj, int64_t value,
                              const char *name, Error **errp);
=20
+/**
+ * object_property_get_defaut:
+ * @prop: the property to get default value
+ *
+ * Return an allocated string that represents the default property
+ * value or NULL.
+ */
+char *object_property_get_default(ObjectProperty *prop);
+
 /**
  * object_property_get_int:
  * @obj: the object
diff --git a/qom/object.c b/qom/object.c
index 1e9113bfc8..b319db4ac6 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1429,6 +1429,15 @@ int64_t object_property_get_int(Object *obj, const c=
har *name,
     return retval;
 }
=20
+char *object_property_get_default(ObjectProperty *prop)
+{
+    if (!prop->get_default) {
+        return NULL;
+    }
+
+    return prop->get_default(prop);
+}
+
 void object_property_set_uint(Object *obj, uint64_t value,
                               const char *name, Error **errp)
 {
--=20
2.25.0.rc1.20.g2443f3f80d.dirty


