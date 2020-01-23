Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F849C33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:35:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 348E122464
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NRMJWxsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 348E122464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufRp-0004zn-IQ
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:35:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iucuc-0001jw-Iy
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iucub-0001PJ-8Q
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52131
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iucub-0001P3-4C
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PwsciPAkxt1dB3oq4840PKHbmiUXpOueDbvkc5uqNnQ=;
 b=NRMJWxsQKs8gaNBE8NaBwmA5/WsRC/rpcbjIzSqvp61MOyscT0zZY4IiwWHGjIkfFz26vd
 tcM9V1+awf0PX22SAQjM7DEVS3TvkgMs/hqonmGiVcCAp4VCB4vWp5aSdwnkn3xAmRkrCW
 tbOZKu8bUwEQ8tgI5sbhQoSfKWgzOA8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-V_IXYwEQM5y5zqO-_ySovw-1; Thu, 23 Jan 2020 08:52:43 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CC1D802593
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:52:42 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 38A2D1CB;
 Thu, 23 Jan 2020 13:52:40 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 54/59] qom: introduce object_property_help()
Date: Thu, 23 Jan 2020 14:50:44 +0100
Message-Id: <1579787449-27599-55-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: V_IXYwEQM5y5zqO-_ySovw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Let's factor out the code to format a help string for a property. We
are going to reuse it in qdev next, which will bring some consistency.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200110153039.1379601-25-marcandre.lureau@redhat.com>
[Adjust for removal of object_property_get_default, move default
 after description. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h    | 13 +++++++++++++
 qom/object_interfaces.c | 45 ++++++++++++++++++++++++++++-----------------
 2 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 18660fd..2954649 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1837,6 +1837,19 @@ Object *container_get(Object *root, const char *path=
);
  */
 size_t object_type_get_instance_size(const char *typename);
=20
+/**
+ * object_property_help:
+ * @name: the name of the property
+ * @type: the type of the property
+ * @defval: the default value
+ * @description: description of the property
+ *
+ * Returns: a user-friendly formatted string describing the property
+ * for help purposes.
+ */
+char *object_property_help(const char *name, const char *type,
+                           QObject *defval, const char *description);
+
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(Object, object_unref)
=20
 #endif
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index edb4cc4..72cb9e3 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -4,6 +4,8 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
+#include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qstring.h"
 #include "qom/object_interfaces.h"
 #include "qemu/help_option.h"
 #include "qemu/module.h"
@@ -158,6 +160,29 @@ int user_creatable_add_opts_foreach(void *opaque, Qemu=
Opts *opts, Error **errp)
     return 0;
 }
=20
+char *object_property_help(const char *name, const char *type,
+                           QObject *defval, const char *description)
+{
+    GString *str =3D g_string_new(NULL);
+
+    g_string_append_printf(str, "  %s=3D<%s>", name, type);
+    if (description || defval) {
+        if (str->len < 24) {
+            g_string_append_printf(str, "%*s", 24 - (int)str->len, "");
+        }
+        g_string_append(str, " - ");
+    }
+    if (description) {
+        g_string_append(str, description);
+    }
+    if (defval) {
+        g_autofree char *def_json =3D qstring_free(qobject_to_json(defval)=
, TRUE);
+        g_string_append_printf(str, " (default: %s)", def_json);
+    }
+
+    return g_string_free(str, false);
+}
+
 bool user_creatable_print_help(const char *type, QemuOpts *opts)
 {
     ObjectClass *klass;
@@ -184,27 +209,13 @@ bool user_creatable_print_help(const char *type, Qemu=
Opts *opts)
=20
         object_class_property_iter_init(&iter, klass);
         while ((prop =3D object_property_iter_next(&iter))) {
-            GString *str;
-            char *defval;
-
             if (!prop->set) {
                 continue;
             }
=20
-            str =3D g_string_new(NULL);
-            g_string_append_printf(str, "  %s=3D<%s>", prop->name, prop->t=
ype);
-            defval =3D object_property_get_default(prop);
-            if (defval) {
-                g_string_append_printf(str, " (default: %s)", defval);
-                g_free(defval);
-            }
-            if (prop->description) {
-                if (str->len < 24) {
-                    g_string_append_printf(str, "%*s", 24 - (int)str->len,=
 "");
-                }
-                g_string_append_printf(str, " - %s", prop->description);
-            }
-            g_ptr_array_add(array, g_string_free(str, false));
+            g_ptr_array_add(array,
+                            object_property_help(prop->name, prop->type,
+                                                 prop->defval, prop->descr=
iption));
         }
         g_ptr_array_sort(array, (GCompareFunc)qemu_pstrcmp0);
         if (array->len > 0) {
--=20
1.8.3.1



