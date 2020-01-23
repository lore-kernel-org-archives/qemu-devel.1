Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C71C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:20:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 541A321835
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pe9UA2H8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 541A321835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufDj-0002LE-3h
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:20:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51684)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrd-0005M9-71
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrc-00048G-0d
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:41 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:45385)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrb-00044r-PP
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:39 -0500
Received: by mail-wr1-x433.google.com with SMTP id j42so3107241wrj.12
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cNSBVvuhqWAGJYrIfEMAuXBTzy9mOBWpnwL0MQDgTyk=;
 b=pe9UA2H8guk5hFdS7uASs9SAtsFshkRhPgYBdUqodol4xMqnXLDdm5cHK3UOGsAEDI
 tt/ZuL3OKbHBXN83Aw2sRlyusy1rIxboBMEbnYw3trMQQoxhgW2P5LBwqKhJ09Db96N9
 N8OgUYsX0hmekidvZHAG7IZ9izFuxwD/Ze2lHNchJtgMJzHl+x/0Uu3mPfCTmjswLqa3
 Gd6yNIA8u7/9Hus1NCjdUb7xw8QxsBDoNqzyrPHX8g2MwX0BMPK2TYslDdvKAnBTgUeE
 MDCCMxSml5W7C9JO25sMj9zbZ9kCAUB2pcDkoQTae3HqEVS24BxI5RC5+SKnd+qKSqgm
 Rd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cNSBVvuhqWAGJYrIfEMAuXBTzy9mOBWpnwL0MQDgTyk=;
 b=PnGsN5HZNm7hIZc3lL9LfwKIGoNboo0/yOdlOGEH2aTgpBt6sBxrPEJH8holA5gsi6
 faxPAG/YaAWbPeTuqmWeN3Xk4TRuw2YBdfLUBFnptmFtOjRqV68v8WeZcu9AeC5zVuce
 iKjRcQPZohUwZIsRNWPwSzVn3SIFNAgmHrYCFr44c9xszWUroYC1mbIWoc311j31l0iE
 mvdjqnC/7K9TcnVzBhDzzZdevihONeQdd/a2ZLcwdhjtFNupvopTgEfYWwUnyiYfY5m2
 EkT1vw/atnE4PdZfpSgtqV2ccIkJ6f/PDjxvWjIrIJ8tSuO7+kqFJEU9XLq6/sZ3F+Ju
 Jycw==
X-Gm-Message-State: APjAAAUgBg7H/0iYkuLgq2PeYY4FcaAjzGb4a9BHKWevCDKwtjR7xHB4
 eqqxuaJBV8Jmzg9zg6mos9R7Ut8P
X-Google-Smtp-Source: APXvYqyY2gEVx8pbFh5NxrSXkJ8gziTBMt2gxDgJbujJdwbhTimwcXK0Nf+bsEnrAk+D7lT1Vo4fmA==
X-Received: by 2002:adf:e984:: with SMTP id h4mr18017722wrm.275.1579787378522; 
 Thu, 23 Jan 2020 05:49:38 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 36/59] object: add class property initializer
Date: Thu, 23 Jan 2020 14:48:39 +0100
Message-Id: <1579787342-27146-37-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

This callback is used to set default value in following patch "object:
add object_property_set_defaut_{bool,str,int,uint}()".

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200110153039.1379601-7-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h | 16 ++++++++++++++--
 qom/object.c         | 14 ++++++++++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 54a5488..29f47d3 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -309,6 +309,8 @@ typedef struct InterfaceInfo InterfaceInfo;
  */
 
 
+typedef struct ObjectProperty ObjectProperty;
+
 /**
  * ObjectPropertyAccessor:
  * @obj: the object that owns the property
@@ -356,7 +358,16 @@ typedef void (ObjectPropertyRelease)(Object *obj,
                                      const char *name,
                                      void *opaque);
 
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
 
 /**
  * ObjectUnparent:
diff --git a/qom/object.c b/qom/object.c
index e921363..cd7ce81 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -478,6 +478,19 @@ void object_apply_compat_props(Object *obj)
     }
 }
 
+static void object_class_property_init_all(Object *obj)
+{
+    ObjectPropertyIterator iter;
+    ObjectProperty *prop;
+
+    object_class_property_iter_init(&iter, object_get_class(obj));
+    while ((prop = object_property_iter_next(&iter))) {
+        if (prop->init) {
+            prop->init(obj, prop);
+        }
+    }
+}
+
 static void object_initialize_with_type(void *data, size_t size, TypeImpl *type)
 {
     Object *obj = data;
@@ -491,6 +504,7 @@ static void object_initialize_with_type(void *data, size_t size, TypeImpl *type)
     memset(obj, 0, type->instance_size);
     obj->class = type->class;
     object_ref(obj);
+    object_class_property_init_all(obj);
     obj->properties = g_hash_table_new_full(g_str_hash, g_str_equal,
                                             NULL, object_property_free);
     object_init_with_type(obj, type);
-- 
1.8.3.1



