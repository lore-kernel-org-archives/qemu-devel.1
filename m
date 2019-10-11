Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFF1C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 20:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A6EA2067B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 20:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6EA2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ1yY-0007gA-Cp
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 16:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iJ1xT-0006Ws-Uf
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 16:56:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iJ1xS-0001OB-Jh
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 16:56:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50406)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iJ1xP-0001N8-Oj; Fri, 11 Oct 2019 16:56:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 081193086228;
 Fri, 11 Oct 2019 20:56:15 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.118.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE0B560600;
 Fri, 11 Oct 2019 20:56:13 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/4] vl: Split off user_creatable_print_help()
Date: Fri, 11 Oct 2019 22:55:48 +0200
Message-Id: <20191011205551.32149-2-kwolf@redhat.com>
In-Reply-To: <20191011205551.32149-1-kwolf@redhat.com>
References: <20191011205551.32149-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 11 Oct 2019 20:56:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Printing help for --object is something that we don't only want in the
system emulator, but also in tools that support --object. Move it into a
separate function in qom/object_interfaces.c to make the code accessible
for tools.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/qom/object_interfaces.h | 12 +++++++
 qom/object_interfaces.c         | 61 +++++++++++++++++++++++++++++++++
 vl.c                            | 52 +---------------------------
 3 files changed, 74 insertions(+), 51 deletions(-)

diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfa=
ces.h
index 682ba1d9b0..3e4e1d928b 100644
--- a/include/qom/object_interfaces.h
+++ b/include/qom/object_interfaces.h
@@ -132,6 +132,18 @@ typedef bool (*user_creatable_add_opts_predicate)(co=
nst char *type);
 int user_creatable_add_opts_foreach(void *opaque,
                                     QemuOpts *opts, Error **errp);
=20
+/**
+ * user_creatable_print_help:
+ * @type: the QOM type to be added
+ * @opts: options to create
+ *
+ * Prints help if requested in @opts.
+ *
+ * Returns: true if @opts contained a help option and help was printed, =
false
+ * if no help option was found.
+ */
+bool user_creatable_print_help(const char *type, QemuOpts *opts);
+
 /**
  * user_creatable_del:
  * @id: the unique ID for the object
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index cb5809934a..46cd6eab5c 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -1,8 +1,11 @@
 #include "qemu/osdep.h"
+
+#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qom/object_interfaces.h"
+#include "qemu/help_option.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qapi/opts-visitor.h"
@@ -155,6 +158,64 @@ int user_creatable_add_opts_foreach(void *opaque, Qe=
muOpts *opts, Error **errp)
     return 0;
 }
=20
+bool user_creatable_print_help(const char *type, QemuOpts *opts)
+{
+    ObjectClass *klass;
+
+    if (is_help_option(type)) {
+        GSList *l, *list;
+
+        printf("List of user creatable objects:\n");
+        list =3D object_class_get_list_sorted(TYPE_USER_CREATABLE, false=
);
+        for (l =3D list; l !=3D NULL; l =3D l->next) {
+            ObjectClass *oc =3D OBJECT_CLASS(l->data);
+            printf("  %s\n", object_class_get_name(oc));
+        }
+        g_slist_free(list);
+        return true;
+    }
+
+    klass =3D object_class_by_name(type);
+    if (klass && qemu_opt_has_help_opt(opts)) {
+        ObjectPropertyIterator iter;
+        ObjectProperty *prop;
+        GPtrArray *array =3D g_ptr_array_new();
+        int i;
+
+        object_class_property_iter_init(&iter, klass);
+        while ((prop =3D object_property_iter_next(&iter))) {
+            GString *str;
+
+            if (!prop->set) {
+                continue;
+            }
+
+            str =3D g_string_new(NULL);
+            g_string_append_printf(str, "  %s=3D<%s>", prop->name, prop-=
>type);
+            if (prop->description) {
+                if (str->len < 24) {
+                    g_string_append_printf(str, "%*s", 24 - (int)str->le=
n, "");
+                }
+                g_string_append_printf(str, " - %s", prop->description);
+            }
+            g_ptr_array_add(array, g_string_free(str, false));
+        }
+        g_ptr_array_sort(array, (GCompareFunc)qemu_pstrcmp0);
+        if (array->len > 0) {
+            printf("%s options:\n", type);
+        } else {
+            printf("There are no options for %s.\n", type);
+        }
+        for (i =3D 0; i < array->len; i++) {
+            printf("%s\n", (char *)array->pdata[i]);
+        }
+        g_ptr_array_set_free_func(array, g_free);
+        g_ptr_array_free(array, true);
+        return true;
+    }
+
+    return false;
+}
=20
 void user_creatable_del(const char *id, Error **errp)
 {
diff --git a/vl.c b/vl.c
index 002bf4919e..b86d4e502d 100644
--- a/vl.c
+++ b/vl.c
@@ -2649,57 +2649,7 @@ static int machine_set_property(void *opaque,
  */
 static bool object_create_initial(const char *type, QemuOpts *opts)
 {
-    ObjectClass *klass;
-
-    if (is_help_option(type)) {
-        GSList *l, *list;
-
-        printf("List of user creatable objects:\n");
-        list =3D object_class_get_list_sorted(TYPE_USER_CREATABLE, false=
);
-        for (l =3D list; l !=3D NULL; l =3D l->next) {
-            ObjectClass *oc =3D OBJECT_CLASS(l->data);
-            printf("  %s\n", object_class_get_name(oc));
-        }
-        g_slist_free(list);
-        exit(0);
-    }
-
-    klass =3D object_class_by_name(type);
-    if (klass && qemu_opt_has_help_opt(opts)) {
-        ObjectPropertyIterator iter;
-        ObjectProperty *prop;
-        GPtrArray *array =3D g_ptr_array_new();
-        int i;
-
-        object_class_property_iter_init(&iter, klass);
-        while ((prop =3D object_property_iter_next(&iter))) {
-            GString *str;
-
-            if (!prop->set) {
-                continue;
-            }
-
-            str =3D g_string_new(NULL);
-            g_string_append_printf(str, "  %s=3D<%s>", prop->name, prop-=
>type);
-            if (prop->description) {
-                if (str->len < 24) {
-                    g_string_append_printf(str, "%*s", 24 - (int)str->le=
n, "");
-                }
-                g_string_append_printf(str, " - %s", prop->description);
-            }
-            g_ptr_array_add(array, g_string_free(str, false));
-        }
-        g_ptr_array_sort(array, (GCompareFunc)qemu_pstrcmp0);
-        if (array->len > 0) {
-            printf("%s options:\n", type);
-        } else {
-            printf("There are no options for %s.\n", type);
-        }
-        for (i =3D 0; i < array->len; i++) {
-            printf("%s\n", (char *)array->pdata[i]);
-        }
-        g_ptr_array_set_free_func(array, g_free);
-        g_ptr_array_free(array, true);
+    if (user_creatable_print_help(type, opts)) {
         exit(0);
     }
=20
--=20
2.20.1


