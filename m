Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03148C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:23:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2C7C21734
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlfEbDtL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C7C21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufFy-00060L-Ei
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:22:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrg-0005Rd-Qd
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrf-0004G2-EU
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:44 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:39489)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrf-0004EI-7R
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:43 -0500
Received: by mail-wr1-x42a.google.com with SMTP id y11so3145706wrt.6
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PA5q0FZDEW8Y+8rLXWGciLnycgXwrVkUoj4n+I9lelQ=;
 b=jlfEbDtL61E1kvuMnalngLPJbWwKJsXgeFcd7t8eFNIdPH1TYx2UcsBoxFSr7Qh6/l
 1V0dUVFYfJyy4H2M+f0qWKlpRpf6WL3hR59A0jxUX+sRYhHGjzIt/hPDJXunUiQ+gs4r
 orsHPSzQt/urm+aw46r6xC7jg9Pt8ymTE9eQNn6AeqxpjnutMTrz63DJCqdBCVTyEENR
 XYyJcejHr3S595PbnaCzox+G1/qgQ3ReWHBfSV8IWZTAndkxpfxVq2evG/CXHPMtqxj+
 LdHQwKCWBv2wWs/5DR8ijvBWUb35v7z1jllGgiJ1QZY8U4NrCANqLEuKfSCiKUq4IGus
 NXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=PA5q0FZDEW8Y+8rLXWGciLnycgXwrVkUoj4n+I9lelQ=;
 b=kCto0U/p2YQzbMUyi1xktF+VUZr7+/OIsZHGwZbMowj3Vpy4NAEBv6slMRM3NCYynn
 BdZasmwCmitipc7I7kxU/Tmo0z0pDKU9F5Cr7sOWgNpIUgU9pLoUlUnn8rsisnKYKc97
 HgRGjo10IDe3Gg7HGlLFhfmalNmVLgWWMYbsdfYPll8faIRdi2lBSRcS6hV+kfQB1AuY
 lvYl2yKP2xFVotq+pQPeqgzv0etm6Kyc3TXOcIBPPM25rnIYZEb+JYIh2NwFlDGNStCf
 jPTnDOYh45OsSHqRgkX96I83cYiHWP+ar9Bwc0ceI9n1/F3oOcTqDQwS4S1byV/GzxPd
 m9kg==
X-Gm-Message-State: APjAAAUe0gGCUvJMUed/QAqpIoWf47i+xrXFtTzMeiAsSAUXx0hKDAs6
 0L/HB7vb2G6NgreNoNcuAmih0Dlh
X-Google-Smtp-Source: APXvYqzFcar7e49qi2hihpWVCIY/fRmKzcM0i2KaJYxOokpmEQMpiA0vDtHPGH5U+5eTejKhwMrRIg==
X-Received: by 2002:adf:ee82:: with SMTP id b2mr17038078wro.194.1579787381895; 
 Thu, 23 Jan 2020 05:49:41 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:41 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 40/59] object: add object_property_set_defaut_{bool, str, int,
 uint}()
Date: Thu, 23 Jan 2020 14:48:43 +0100
Message-Id: <1579787342-27146-41-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200110153039.1379601-11-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h | 37 ++++++++++++++++++++++++++++++++++
 qom/object.c         | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 9f52bc3..fb133d6 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -386,6 +386,7 @@ struct ObjectProperty
     ObjectPropertyInit *init;
     ObjectPropertyGetDefault *get_default;
     void *opaque;
+    QObject *defval;
 };
 
 /**
@@ -1064,6 +1065,42 @@ ObjectProperty *object_class_property_add(ObjectClass *klass, const char *name,
                                           void *opaque, Error **errp);
 
 /**
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
+void object_property_set_defaut_str(ObjectProperty *prop, const char *value);
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
+void object_property_set_defaut_uint(ObjectProperty *prop, uint64_t value);
+
+/**
  * object_property_find:
  * @obj: the object
  * @name: the name of the property
diff --git a/qom/object.c b/qom/object.c
index 213a796..1423344 100644
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
 
 /* TODO: replace QObject with a simpler visitor to avoid a dependency
@@ -268,6 +270,10 @@ static void object_property_free(gpointer data)
 {
     ObjectProperty *prop = data;
 
+    if (prop->defval) {
+        qobject_unref(prop->defval);
+        prop->defval = NULL;
+    }
     g_free(prop->name);
     g_free(prop->type);
     g_free(prop->description);
@@ -1447,6 +1453,52 @@ char *object_property_get_default(ObjectProperty *prop)
     return prop->get_default(prop);
 }
 
+static void object_property_init_defval(Object *obj, ObjectProperty *prop)
+{
+    Visitor *v = qobject_input_visitor_new(prop->defval);
+
+    assert(prop->set != NULL);
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
+static void object_property_set_defaut(ObjectProperty *prop, QObject *defval)
+{
+    assert(!prop->defval);
+    assert(!prop->init);
+    assert(!prop->get_default);
+
+    prop->defval = defval;
+    prop->init = object_property_init_defval;
+    prop->get_default = object_property_get_defval;
+}
+
+void object_property_set_defaut_bool(ObjectProperty *prop, bool value)
+{
+    object_property_set_defaut(prop, QOBJECT(qbool_from_bool(value)));
+}
+
+void object_property_set_defaut_str(ObjectProperty *prop, const char *value)
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
@@ -2558,6 +2610,10 @@ void object_property_add_alias(Object *obj, const char *name,
         goto out;
     }
     op->resolve = property_resolve_alias;
+    if (target_prop->get_default) {
+        op->get_default = target_prop->get_default;
+        op->defval = qobject_ref(target_prop->defval);
+    }
 
     object_property_set_description(obj, op->name,
                                     target_prop->description,
-- 
1.8.3.1



