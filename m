Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2C4C432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:23:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A9E820725
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3A3YvKc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9E820725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibNK1-0007Z1-75
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 06:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNDi-0001Pj-G4
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:16:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNDg-0008Vh-Hr
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:16:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53622
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ibNDe-0008Sp-Mz
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:16:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575199008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vu+kVcxkweaFIg4YWXP7ZzsRutBw6C4J8rIa3fvlIeg=;
 b=G3A3YvKcxim0l49WeMwdYSX2BL4mgbNTb9RxQIbHBnjv7agoMt4XCGrv3Ngsd0hbUeCxm0
 wqqqrbuu3D6isLWoOzF8JJzNN1WyjaDfbwT9cYsV84mJCxtBeVzNiFi7C1ylDNPtZxoVMg
 GJP7IKcxVM9qzE5PBzmpS6T8UGrhKfg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-StJKblJHMWCy8WxSxw4VeA-1; Sun, 01 Dec 2019 06:16:46 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05AD2800D4C
 for <qemu-devel@nongnu.org>; Sun,  1 Dec 2019 11:16:46 +0000 (UTC)
Received: from localhost (unknown [10.36.112.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64250600C8;
 Sun,  1 Dec 2019 11:16:43 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/26] object: add object_property_get_defaut()
Date: Sun,  1 Dec 2019 15:15:12 +0400
Message-Id: <20191201111531.1136947-8-marcandre.lureau@redhat.com>
In-Reply-To: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
References: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: StJKblJHMWCy8WxSxw4VeA-1
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

The new callback will be used in following "object: add
object_property_set_defaut_{bool,str,int,uint}()" and "vl: print
default value in object help" patches.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 17 +++++++++++++++++
 qom/object.c         |  9 +++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index e15ebd486b..8d442cf633 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -361,6 +361,13 @@ typedef void (ObjectPropertyRelease)(Object *obj,
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
@@ -371,6 +378,7 @@ struct ObjectProperty
     ObjectPropertyResolve *resolve;
     ObjectPropertyRelease *release;
     ObjectPropertyInit *init;
+    ObjectPropertyGetDefault *get_default;
     void *opaque;
 };
=20
@@ -1214,6 +1222,15 @@ bool object_property_get_bool(Object *obj, const cha=
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
index 4b9f8d8668..844a2d66bf 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1405,6 +1405,15 @@ int64_t object_property_get_int(Object *obj, const c=
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
2.24.0


