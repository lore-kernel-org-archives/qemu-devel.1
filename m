Received: from eggs.gnu.org ([2001:4830:134:3::10]:49044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSjRh-0005C3-93
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:07:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSjRc-0005Qj-36
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:07:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gSjRb-0005QX-QX
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:07:00 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3612EA402D
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 14:06:59 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 30 Nov 2018 14:06:12 +0000
Message-Id: <20181130140615.19937-9-berrange@redhat.com>
In-Reply-To: <20181130140615.19937-1-berrange@redhat.com>
References: <20181130140615.19937-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 08/11] authz: add QAuthZList object type for
 an access control list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

Add a QAuthZList object type that implements the QAuthZ interface. This
built-in implementation maintains a trivial access control list with a
sequence of match rules and a final default policy. This replicates the
functionality currently provided by the qemu_acl module.

To create an instance of this object via the QMP monitor, the syntax
used would be:

  {
    "execute": "object-add",
    "arguments": {
      "qom-type": "authz-list",
      "id": "authz0",
      "parameters": {
        "rules": [
           { "match": "fred", "policy": "allow", "format": "exact" },
           { "match": "bob", "policy": "allow", "format": "exact" },
           { "match": "danb", "policy": "deny", "format": "glob" },
           { "match": "dan*", "policy": "allow", "format": "exact" },
        ],
        "policy": "deny"
      }
    }
  }

This sets up an authorization rule that allows 'fred', 'bob' and anyone
whose name starts with 'dan', except for 'danb'. Everyone unmatched is
denied.

It is not currently possible to create this via -object, since there is
no syntax supported to specify non-scalar properties for objects. This
is likely to be addressed by later support for using JSON with -object,
or an equivalent approach.

In any case the future "authz-listfile" object can be used from the
CLI and is likely a better choice, as it allows the ACL to be refreshed
automatically on change.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 .gitignore              |   4 +
 MAINTAINERS             |   1 +
 Makefile                |   7 +-
 Makefile.objs           |   4 +
 authz/Makefile.objs     |   1 +
 authz/list.c            | 285 ++++++++++++++++++++++++++++++++++++++++
 authz/trace-events      |   4 +
 include/authz/list.h    | 106 +++++++++++++++
 qapi/authz.json         |  58 ++++++++
 qapi/qapi-schema.json   |   1 +
 tests/Makefile.include  |   2 +
 tests/test-authz-list.c | 159 ++++++++++++++++++++++
 12 files changed, 631 insertions(+), 1 deletion(-)
 create mode 100644 authz/list.c
 create mode 100644 include/authz/list.h
 create mode 100644 qapi/authz.json
 create mode 100644 tests/test-authz-list.c

diff --git a/.gitignore b/.gitignore
index 64efdfd929..9b9fcad829 100644
--- a/.gitignore
+++ b/.gitignore
@@ -47,6 +47,7 @@
 /qapi/qapi-commands-trace.[ch]
 /qapi/qapi-commands-transaction.[ch]
 /qapi/qapi-commands-ui.[ch]
+/qapi/qapi-commands-authz.[ch]
 /qapi/qapi-commands.[ch]
 /qapi/qapi-events-block-core.[ch]
 /qapi/qapi-events-block.[ch]
@@ -65,6 +66,7 @@
 /qapi/qapi-events-trace.[ch]
 /qapi/qapi-events-transaction.[ch]
 /qapi/qapi-events-ui.[ch]
+/qapi/qapi-events-authz.[ch]
 /qapi/qapi-events.[ch]
 /qapi/qapi-introspect.[ch]
 /qapi/qapi-types-block-core.[ch]
@@ -84,6 +86,7 @@
 /qapi/qapi-types-trace.[ch]
 /qapi/qapi-types-transaction.[ch]
 /qapi/qapi-types-ui.[ch]
+/qapi/qapi-types-authz.[ch]
 /qapi/qapi-types.[ch]
 /qapi/qapi-visit-block-core.[ch]
 /qapi/qapi-visit-block.[ch]
@@ -102,6 +105,7 @@
 /qapi/qapi-visit-trace.[ch]
 /qapi/qapi-visit-transaction.[ch]
 /qapi/qapi-visit-ui.[ch]
+/qapi/qapi-visit-authz.[ch]
 /qapi/qapi-visit.[ch]
 /qapi/qapi-doc.texi
 /qemu-doc.html
diff --git a/MAINTAINERS b/MAINTAINERS
index e78de51da9..ee1f735567 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2012,6 +2012,7 @@ User authorization
 M: Daniel P. Berrange <berrange@redhat.com>
 S: Maintained
 F: authz/
+F: qapi/authz.json
 F: include/authz/
 F: tests/test-authz-*
=20
diff --git a/Makefile b/Makefile
index 4b20ee2b19..da9ea40725 100644
--- a/Makefile
+++ b/Makefile
@@ -600,7 +600,8 @@ qapi-modules =3D $(SRC_PATH)/qapi/qapi-schema.json $(=
SRC_PATH)/qapi/common.json \
                $(SRC_PATH)/qapi/tpm.json \
                $(SRC_PATH)/qapi/trace.json \
                $(SRC_PATH)/qapi/transaction.json \
-               $(SRC_PATH)/qapi/ui.json
+               $(SRC_PATH)/qapi/ui.json \
+               $(SRC_PATH)/qapi/authz.json
=20
 qapi/qapi-builtin-types.c qapi/qapi-builtin-types.h \
 qapi/qapi-types.c qapi/qapi-types.h \
@@ -621,6 +622,7 @@ qapi/qapi-types-tpm.c qapi/qapi-types-tpm.h \
 qapi/qapi-types-trace.c qapi/qapi-types-trace.h \
 qapi/qapi-types-transaction.c qapi/qapi-types-transaction.h \
 qapi/qapi-types-ui.c qapi/qapi-types-ui.h \
+qapi/qapi-types-authz.c qapi/qapi-types-authz.h \
 qapi/qapi-builtin-visit.c qapi/qapi-builtin-visit.h \
 qapi/qapi-visit.c qapi/qapi-visit.h \
 qapi/qapi-visit-block-core.c qapi/qapi-visit-block-core.h \
@@ -640,6 +642,7 @@ qapi/qapi-visit-tpm.c qapi/qapi-visit-tpm.h \
 qapi/qapi-visit-trace.c qapi/qapi-visit-trace.h \
 qapi/qapi-visit-transaction.c qapi/qapi-visit-transaction.h \
 qapi/qapi-visit-ui.c qapi/qapi-visit-ui.h \
+qapi/qapi-visit-authz.c qapi/qapi-visit-authz.h \
 qapi/qapi-commands.h qapi/qapi-commands.c \
 qapi/qapi-commands-block-core.c qapi/qapi-commands-block-core.h \
 qapi/qapi-commands-block.c qapi/qapi-commands-block.h \
@@ -658,6 +661,7 @@ qapi/qapi-commands-tpm.c qapi/qapi-commands-tpm.h \
 qapi/qapi-commands-trace.c qapi/qapi-commands-trace.h \
 qapi/qapi-commands-transaction.c qapi/qapi-commands-transaction.h \
 qapi/qapi-commands-ui.c qapi/qapi-commands-ui.h \
+qapi/qapi-commands-authz.c qapi/qapi-commands-authz.h \
 qapi/qapi-events.c qapi/qapi-events.h \
 qapi/qapi-events-block-core.c qapi/qapi-events-block-core.h \
 qapi/qapi-events-block.c qapi/qapi-events-block.h \
@@ -676,6 +680,7 @@ qapi/qapi-events-tpm.c qapi/qapi-events-tpm.h \
 qapi/qapi-events-trace.c qapi/qapi-events-trace.h \
 qapi/qapi-events-transaction.c qapi/qapi-events-transaction.h \
 qapi/qapi-events-ui.c qapi/qapi-events-ui.h \
+qapi/qapi-events-authz.c qapi/qapi-events-authz.h \
 qapi/qapi-introspect.h qapi/qapi-introspect.c \
 qapi/qapi-doc.texi: \
 qapi-gen-timestamp ;
diff --git a/Makefile.objs b/Makefile.objs
index ba083f2bf7..514ea2b403 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -21,6 +21,7 @@ util-obj-y +=3D qapi/qapi-types-tpm.o
 util-obj-y +=3D qapi/qapi-types-trace.o
 util-obj-y +=3D qapi/qapi-types-transaction.o
 util-obj-y +=3D qapi/qapi-types-ui.o
+util-obj-y +=3D qapi/qapi-types-authz.o
 util-obj-y +=3D qapi/qapi-builtin-visit.o
 util-obj-y +=3D qapi/qapi-visit.o
 util-obj-y +=3D qapi/qapi-visit-block-core.o
@@ -40,6 +41,7 @@ util-obj-y +=3D qapi/qapi-visit-tpm.o
 util-obj-y +=3D qapi/qapi-visit-trace.o
 util-obj-y +=3D qapi/qapi-visit-transaction.o
 util-obj-y +=3D qapi/qapi-visit-ui.o
+util-obj-y +=3D qapi/qapi-visit-authz.o
 util-obj-y +=3D qapi/qapi-events.o
 util-obj-y +=3D qapi/qapi-events-block-core.o
 util-obj-y +=3D qapi/qapi-events-block.o
@@ -58,6 +60,7 @@ util-obj-y +=3D qapi/qapi-events-tpm.o
 util-obj-y +=3D qapi/qapi-events-trace.o
 util-obj-y +=3D qapi/qapi-events-transaction.o
 util-obj-y +=3D qapi/qapi-events-ui.o
+util-obj-y +=3D qapi/qapi-events-authz.o
 util-obj-y +=3D qapi/qapi-introspect.o
=20
 chardev-obj-y =3D chardev/
@@ -160,6 +163,7 @@ common-obj-y +=3D qapi/qapi-commands-tpm.o
 common-obj-y +=3D qapi/qapi-commands-trace.o
 common-obj-y +=3D qapi/qapi-commands-transaction.o
 common-obj-y +=3D qapi/qapi-commands-ui.o
+common-obj-y +=3D qapi/qapi-commands-authz.o
 common-obj-y +=3D qapi/qapi-introspect.o
 common-obj-y +=3D qmp.o hmp.o
 endif
diff --git a/authz/Makefile.objs b/authz/Makefile.objs
index 2a75d53840..921fa624d7 100644
--- a/authz/Makefile.objs
+++ b/authz/Makefile.objs
@@ -1,2 +1,3 @@
 authz-obj-y +=3D base.o
 authz-obj-y +=3D simple.o
+authz-obj-y +=3D list.o
diff --git a/authz/list.c b/authz/list.c
new file mode 100644
index 0000000000..3b94600e24
--- /dev/null
+++ b/authz/list.c
@@ -0,0 +1,285 @@
+/*
+ * QEMU access control list authorization driver
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "authz/list.h"
+#include "authz/trace.h"
+#include "qom/object_interfaces.h"
+#include "qapi/qapi-visit-authz.h"
+
+static bool qauthz_list_is_allowed(QAuthZ *authz,
+                                   const char *identity,
+                                   Error **errp)
+{
+    QAuthZList *lauthz =3D QAUTHZ_LIST(authz);
+    QAuthZListRuleList *rules =3D lauthz->rules;
+
+    while (rules) {
+        QAuthZListRule *rule =3D rules->value;
+        QAuthZListFormat format =3D rule->has_format ? rule->format :
+            QAUTHZ_LIST_FORMAT_EXACT;
+
+        trace_qauthz_list_check_rule(authz, rule->match, identity,
+                                     format, rule->policy);
+        switch (format) {
+        case QAUTHZ_LIST_FORMAT_EXACT:
+            if (g_str_equal(rule->match, identity)) {
+                return rule->policy =3D=3D QAUTHZ_LIST_POLICY_ALLOW;
+            }
+            break;
+        case QAUTHZ_LIST_FORMAT_GLOB:
+            if (g_pattern_match_simple(rule->match, identity)) {
+                return rule->policy =3D=3D QAUTHZ_LIST_POLICY_ALLOW;
+            }
+            break;
+        default:
+            g_warn_if_reached();
+            return false;
+        }
+        rules =3D rules->next;
+    }
+
+    trace_qauthz_list_default_policy(authz, identity, lauthz->policy);
+    return lauthz->policy =3D=3D QAUTHZ_LIST_POLICY_ALLOW;
+}
+
+
+static void
+qauthz_list_prop_set_policy(Object *obj,
+                            int value,
+                            Error **errp G_GNUC_UNUSED)
+{
+    QAuthZList *lauthz =3D QAUTHZ_LIST(obj);
+
+    lauthz->policy =3D value;
+}
+
+
+static int
+qauthz_list_prop_get_policy(Object *obj,
+                            Error **errp G_GNUC_UNUSED)
+{
+    QAuthZList *lauthz =3D QAUTHZ_LIST(obj);
+
+    return lauthz->policy;
+}
+
+
+static void
+qauthz_list_prop_get_rules(Object *obj, Visitor *v, const char *name,
+                           void *opaque, Error **errp)
+{
+    QAuthZList *lauthz =3D QAUTHZ_LIST(obj);
+
+    visit_type_QAuthZListRuleList(v, name, &lauthz->rules, errp);
+}
+
+static void
+qauthz_list_prop_set_rules(Object *obj, Visitor *v, const char *name,
+                           void *opaque, Error **errp)
+{
+    QAuthZList *lauthz =3D QAUTHZ_LIST(obj);
+    QAuthZListRuleList *oldrules;
+
+    oldrules =3D lauthz->rules;
+    visit_type_QAuthZListRuleList(v, name, &lauthz->rules, errp);
+
+    qapi_free_QAuthZListRuleList(oldrules);
+}
+
+
+static void
+qauthz_list_finalize(Object *obj)
+{
+    QAuthZList *lauthz =3D QAUTHZ_LIST(obj);
+
+    qapi_free_QAuthZListRuleList(lauthz->rules);
+}
+
+
+static void
+qauthz_list_class_init(ObjectClass *oc, void *data)
+{
+    QAuthZClass *authz =3D QAUTHZ_CLASS(oc);
+
+    object_class_property_add_enum(oc, "policy",
+                                   "QAuthZListPolicy",
+                                   &QAuthZListPolicy_lookup,
+                                   qauthz_list_prop_get_policy,
+                                   qauthz_list_prop_set_policy,
+                                   NULL);
+
+    object_class_property_add(oc, "rules", "QAuthZListRule",
+                              qauthz_list_prop_get_rules,
+                              qauthz_list_prop_set_rules,
+                              NULL, NULL, NULL);
+
+    authz->is_allowed =3D qauthz_list_is_allowed;
+}
+
+
+QAuthZList *qauthz_list_new(const char *id,
+                            QAuthZListPolicy policy,
+                            Error **errp)
+{
+    return QAUTHZ_LIST(
+        object_new_with_props(TYPE_QAUTHZ_LIST,
+                              object_get_objects_root(),
+                              id, errp,
+                              "policy", QAuthZListPolicy_str(policy),
+                              NULL));
+}
+
+ssize_t qauthz_list_append_rule(QAuthZList *auth,
+                                const char *match,
+                                QAuthZListPolicy policy,
+                                QAuthZListFormat format,
+                                Error **errp)
+{
+    QAuthZListRule *rule;
+    QAuthZListRuleList *rules, *tmp;
+    size_t i =3D 0;
+
+#ifndef CONFIG_FNMATCH
+    if (format =3D=3D QAUTHZ_LIST_FORMAT_GLOB) {
+        error_setg(errp, "Glob format not supported on this platform");
+        return -1;
+    }
+#endif
+
+    rule =3D g_new0(QAuthZListRule, 1);
+    rule->policy =3D policy;
+    rule->match =3D g_strdup(match);
+    rule->format =3D format;
+    rule->has_format =3D true;
+
+    tmp =3D g_new0(QAuthZListRuleList, 1);
+    tmp->value =3D rule;
+
+    rules =3D auth->rules;
+    if (rules) {
+        while (rules->next) {
+            i++;
+            rules =3D rules->next;
+        }
+        rules->next =3D tmp;
+        return i + 1;
+    } else {
+        auth->rules =3D tmp;
+        return 0;
+    }
+}
+
+
+ssize_t qauthz_list_insert_rule(QAuthZList *auth,
+                                const char *match,
+                                QAuthZListPolicy policy,
+                                QAuthZListFormat format,
+                                size_t index,
+                                Error **errp)
+{
+    QAuthZListRule *rule;
+    QAuthZListRuleList *rules, *tmp;
+    size_t i =3D 0;
+
+#ifndef CONFIG_FNMATCH
+    if (format =3D=3D QAUTHZ_LIST_FORMAT_GLOB) {
+        error_setg(errp, "Glob format not supported on this platform");
+        return -1;
+    }
+#endif
+
+    rule =3D g_new0(QAuthZListRule, 1);
+    rule->policy =3D policy;
+    rule->match =3D g_strdup(match);
+    rule->format =3D format;
+    rule->has_format =3D true;
+
+    tmp =3D g_new0(QAuthZListRuleList, 1);
+    tmp->value =3D rule;
+
+    rules =3D auth->rules;
+    if (rules && index > 0) {
+        while (rules->next && i < (index - 1)) {
+            i++;
+            rules =3D rules->next;
+        }
+        tmp->next =3D rules->next;
+        rules->next =3D tmp;
+        return i + 1;
+    } else {
+        tmp->next =3D auth->rules;
+        auth->rules =3D tmp;
+        return 0;
+    }
+}
+
+
+ssize_t qauthz_list_delete_rule(QAuthZList *auth, const char *match)
+{
+    QAuthZListRule *rule;
+    QAuthZListRuleList *rules, *prev;
+    size_t i =3D 0;
+
+    prev =3D NULL;
+    rules =3D auth->rules;
+    while (rules) {
+        rule =3D rules->value;
+        if (g_str_equal(rule->match, match)) {
+            if (prev) {
+                prev->next =3D rules->next;
+            } else {
+                auth->rules =3D rules->next;
+            }
+            rules->next =3D NULL;
+            qapi_free_QAuthZListRuleList(rules);
+            return i;
+        }
+        prev =3D rules;
+        rules =3D rules->next;
+        i++;
+    }
+
+    return -1;
+}
+
+
+static const TypeInfo qauthz_list_info =3D {
+    .parent =3D TYPE_QAUTHZ,
+    .name =3D TYPE_QAUTHZ_LIST,
+    .instance_size =3D sizeof(QAuthZList),
+    .instance_finalize =3D qauthz_list_finalize,
+    .class_size =3D sizeof(QAuthZListClass),
+    .class_init =3D qauthz_list_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { TYPE_USER_CREATABLE },
+        { }
+    }
+};
+
+
+static void
+qauthz_list_register_types(void)
+{
+    type_register_static(&qauthz_list_info);
+}
+
+
+type_init(qauthz_list_register_types);
diff --git a/authz/trace-events b/authz/trace-events
index 1ef796c1e1..a896d876e8 100644
--- a/authz/trace-events
+++ b/authz/trace-events
@@ -5,3 +5,7 @@ qauthz_is_allowed(void *authz, const char *identity, bool=
 allowed) "AuthZ %p che
=20
 # auth/simple.c
 qauthz_simple_is_allowed(void *authz, const char *wantidentity, const ch=
ar *gotidentity) "AuthZ simple %p check want identity=3D%s got identity=3D=
%s"
+
+# auth/list.c
+qauthz_list_check_rule(void *authz, const char *identity, const char *ru=
le, int format, int policy) "AuthZ list %p check rule=3D%s identity=3D%s =
format=3D%d policy=3D%d"
+qauthz_list_default_policy(void *authz, const char *identity, int policy=
) "AuthZ list %p default identity=3D%s policy=3D%d"
diff --git a/include/authz/list.h b/include/authz/list.h
new file mode 100644
index 0000000000..eb131ba0f0
--- /dev/null
+++ b/include/authz/list.h
@@ -0,0 +1,106 @@
+/*
+ * QEMU list authorization driver
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
+ *
+ */
+
+#ifndef QAUTHZ_LIST_H__
+#define QAUTHZ_LIST_H__
+
+#include "authz/base.h"
+#include "qapi/qapi-types-authz.h"
+
+#define TYPE_QAUTHZ_LIST "authz-list"
+
+#define QAUTHZ_LIST_CLASS(klass)                        \
+    OBJECT_CLASS_CHECK(QAuthZListClass, (klass),        \
+                       TYPE_QAUTHZ_LIST)
+#define QAUTHZ_LIST_GET_CLASS(obj)              \
+    OBJECT_GET_CLASS(QAuthZListClass, (obj),    \
+                      TYPE_QAUTHZ_LIST)
+#define QAUTHZ_LIST(obj) \
+    INTERFACE_CHECK(QAuthZList, (obj),          \
+                    TYPE_QAUTHZ_LIST)
+
+typedef struct QAuthZList QAuthZList;
+typedef struct QAuthZListClass QAuthZListClass;
+
+
+/**
+ * QAuthZList:
+ *
+ * This authorization driver provides a list mechanism
+ * for granting access by matching user names against a
+ * list of globs. Each match rule has an associated policy
+ * and a catch all policy applies if no rule matches
+ *
+ * To create an instance of this class via QMP:
+ *
+ *  {
+ *    "execute": "object-add",
+ *    "arguments": {
+ *      "qom-type": "authz-list",
+ *      "id": "authz0",
+ *      "parameters": {
+ *        "rules": [
+ *           { "match": "fred", "policy": "allow", "format": "exact" },
+ *           { "match": "bob", "policy": "allow", "format": "exact" },
+ *           { "match": "danb", "policy": "deny", "format": "exact" },
+ *           { "match": "dan*", "policy": "allow", "format": "glob" }
+ *        ],
+ *        "policy": "deny"
+ *      }
+ *    }
+ *  }
+ *
+ */
+struct QAuthZList {
+    QAuthZ parent_obj;
+
+    QAuthZListPolicy policy;
+    QAuthZListRuleList *rules;
+};
+
+
+struct QAuthZListClass {
+    QAuthZClass parent_class;
+};
+
+
+QAuthZList *qauthz_list_new(const char *id,
+                            QAuthZListPolicy policy,
+                            Error **errp);
+
+ssize_t qauthz_list_append_rule(QAuthZList *auth,
+                                const char *match,
+                                QAuthZListPolicy policy,
+                                QAuthZListFormat format,
+                                Error **errp);
+
+ssize_t qauthz_list_insert_rule(QAuthZList *auth,
+                                const char *match,
+                                QAuthZListPolicy policy,
+                                QAuthZListFormat format,
+                                size_t index,
+                                Error **errp);
+
+ssize_t qauthz_list_delete_rule(QAuthZList *auth,
+                                const char *match);
+
+
+#endif /* QAUTHZ_LIST_H__ */
+
diff --git a/qapi/authz.json b/qapi/authz.json
new file mode 100644
index 0000000000..55468de8a8
--- /dev/null
+++ b/qapi/authz.json
@@ -0,0 +1,58 @@
+# -*- Mode: Python -*-
+#
+# QAPI authz definitions
+
+##
+# @QAuthZListPolicy:
+#
+# The authorization policy result
+#
+# @deny: deny access
+# @allow: allow access
+#
+# Since: 4.0
+##
+{ 'enum': 'QAuthZListPolicy',
+  'prefix': 'QAUTHZ_LIST_POLICY',
+  'data': ['deny', 'allow']}
+
+##
+# @QAuthZListFormat:
+#
+# The authorization policy result
+#
+# @exact: an exact string match
+# @glob: string with ? and * shell wildcard support
+#
+# Since: 4.0
+##
+{ 'enum': 'QAuthZListFormat',
+  'prefix': 'QAUTHZ_LIST_FORMAT',
+  'data': ['exact', 'glob']}
+
+##
+# @QAuthZListRule:
+#
+# A single authorization rule.
+#
+# @match: a glob to match against a user identity
+# @policy: the result to return if @match evaluates to true
+# @format: (optional) the format of the @match rule (default 'exact')
+#
+# Since: 4.0
+##
+{ 'struct': 'QAuthZListRule',
+  'data': {'match': 'str',
+           'policy': 'QAuthZListPolicy',
+           '*format': 'QAuthZListFormat'}}
+
+##
+# @QAuthZListRuleListHack:
+#
+# Not exposed via QMP; hack to generate QAuthZListRuleList
+# for use internally by the code.
+#
+# Since: 4.0
+##
+{ 'struct': 'QAuthZListRuleListHack',
+  'data': { 'unused': ['QAuthZListRule'] } }
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 65b6dc2f6f..6a5a02a388 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -89,6 +89,7 @@
 { 'include': 'rocker.json' }
 { 'include': 'tpm.json' }
 { 'include': 'ui.json' }
+{ 'include': 'authz.json' }
 { 'include': 'migration.json' }
 { 'include': 'transaction.json' }
 { 'include': 'trace.json' }
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 6dda623607..825ea218cb 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -113,6 +113,7 @@ check-unit-y +=3D tests/test-timed-average$(EXESUF)
 check-unit-$(CONFIG_INOTIFY1) +=3D tests/test-util-filemonitor$(EXESUF)
 check-unit-y +=3D tests/test-util-sockets$(EXESUF)
 check-unit-y +=3D tests/test-authz-simple$(EXESUF)
+check-unit-y +=3D tests/test-authz-list$(EXESUF)
 check-unit-y +=3D tests/test-io-task$(EXESUF)
 check-unit-y +=3D tests/test-io-channel-socket$(EXESUF)
 check-unit-y +=3D tests/test-io-channel-file$(EXESUF)
@@ -644,6 +645,7 @@ tests/test-util-filemonitor$(EXESUF): tests/test-util=
-filemonitor.o \
 tests/test-util-sockets$(EXESUF): tests/test-util-sockets.o \
 	tests/socket-helpers.o $(test-util-obj-y)
 tests/test-authz-simple$(EXESUF): tests/test-authz-simple.o $(test-authz=
-obj-y)
+tests/test-authz-list$(EXESUF): tests/test-authz-list.o $(test-authz-obj=
-y)
 tests/test-io-task$(EXESUF): tests/test-io-task.o $(test-io-obj-y)
 tests/test-io-channel-socket$(EXESUF): tests/test-io-channel-socket.o \
         tests/io-channel-helpers.o tests/socket-helpers.o $(test-io-obj-=
y)
diff --git a/tests/test-authz-list.c b/tests/test-authz-list.c
new file mode 100644
index 0000000000..24347a6ac3
--- /dev/null
+++ b/tests/test-authz-list.c
@@ -0,0 +1,159 @@
+/*
+ * QEMU list file authorization object tests
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+
+#include "authz/list.h"
+
+static void test_authz_default_deny(void)
+{
+    QAuthZList *auth =3D qauthz_list_new("auth0",
+                                       QAUTHZ_LIST_POLICY_DENY,
+                                       &error_abort);
+
+    g_assert(!qauthz_is_allowed(QAUTHZ(auth), "fred", &error_abort));
+
+    object_unparent(OBJECT(auth));
+}
+
+static void test_authz_default_allow(void)
+{
+    QAuthZList *auth =3D qauthz_list_new("auth0",
+                                       QAUTHZ_LIST_POLICY_ALLOW,
+                                       &error_abort);
+
+    g_assert(qauthz_is_allowed(QAUTHZ(auth), "fred", &error_abort));
+
+    object_unparent(OBJECT(auth));
+}
+
+static void test_authz_explicit_deny(void)
+{
+    QAuthZList *auth =3D qauthz_list_new("auth0",
+                                       QAUTHZ_LIST_POLICY_ALLOW,
+                                       &error_abort);
+
+    qauthz_list_append_rule(auth, "fred", QAUTHZ_LIST_POLICY_DENY,
+                            QAUTHZ_LIST_FORMAT_EXACT, &error_abort);
+
+    g_assert(!qauthz_is_allowed(QAUTHZ(auth), "fred", &error_abort));
+
+    object_unparent(OBJECT(auth));
+}
+
+static void test_authz_explicit_allow(void)
+{
+    QAuthZList *auth =3D qauthz_list_new("auth0",
+                                       QAUTHZ_LIST_POLICY_DENY,
+                                       &error_abort);
+
+    qauthz_list_append_rule(auth, "fred", QAUTHZ_LIST_POLICY_ALLOW,
+                            QAUTHZ_LIST_FORMAT_EXACT, &error_abort);
+
+    g_assert(qauthz_is_allowed(QAUTHZ(auth), "fred", &error_abort));
+
+    object_unparent(OBJECT(auth));
+}
+
+
+static void test_authz_complex(void)
+{
+    QAuthZList *auth =3D qauthz_list_new("auth0",
+                                       QAUTHZ_LIST_POLICY_DENY,
+                                       &error_abort);
+
+    qauthz_list_append_rule(auth, "fred", QAUTHZ_LIST_POLICY_ALLOW,
+                            QAUTHZ_LIST_FORMAT_EXACT, &error_abort);
+    qauthz_list_append_rule(auth, "bob", QAUTHZ_LIST_POLICY_ALLOW,
+                            QAUTHZ_LIST_FORMAT_EXACT, &error_abort);
+    qauthz_list_append_rule(auth, "dan", QAUTHZ_LIST_POLICY_DENY,
+                            QAUTHZ_LIST_FORMAT_EXACT, &error_abort);
+    qauthz_list_append_rule(auth, "dan*", QAUTHZ_LIST_POLICY_ALLOW,
+                            QAUTHZ_LIST_FORMAT_GLOB, &error_abort);
+
+    g_assert(qauthz_is_allowed(QAUTHZ(auth), "fred", &error_abort));
+    g_assert(qauthz_is_allowed(QAUTHZ(auth), "bob", &error_abort));
+    g_assert(!qauthz_is_allowed(QAUTHZ(auth), "dan", &error_abort));
+    g_assert(qauthz_is_allowed(QAUTHZ(auth), "danb", &error_abort));
+
+    object_unparent(OBJECT(auth));
+}
+
+static void test_authz_add_remove(void)
+{
+    QAuthZList *auth =3D qauthz_list_new("auth0",
+                                       QAUTHZ_LIST_POLICY_ALLOW,
+                                       &error_abort);
+
+    g_assert_cmpint(qauthz_list_append_rule(auth, "fred",
+                                            QAUTHZ_LIST_POLICY_ALLOW,
+                                            QAUTHZ_LIST_FORMAT_EXACT,
+                                            &error_abort),
+                    =3D=3D, 0);
+    g_assert_cmpint(qauthz_list_append_rule(auth, "bob",
+                                            QAUTHZ_LIST_POLICY_ALLOW,
+                                            QAUTHZ_LIST_FORMAT_EXACT,
+                                            &error_abort),
+                    =3D=3D, 1);
+    g_assert_cmpint(qauthz_list_append_rule(auth, "dan",
+                                            QAUTHZ_LIST_POLICY_DENY,
+                                            QAUTHZ_LIST_FORMAT_EXACT,
+                                            &error_abort),
+                    =3D=3D, 2);
+    g_assert_cmpint(qauthz_list_append_rule(auth, "frank",
+                                            QAUTHZ_LIST_POLICY_DENY,
+                                            QAUTHZ_LIST_FORMAT_EXACT,
+                                            &error_abort),
+                    =3D=3D, 3);
+
+    g_assert(!qauthz_is_allowed(QAUTHZ(auth), "dan", &error_abort));
+
+    g_assert_cmpint(qauthz_list_delete_rule(auth, "dan"),
+                    =3D=3D, 2);
+
+    g_assert(qauthz_is_allowed(QAUTHZ(auth), "dan", &error_abort));
+
+    g_assert_cmpint(qauthz_list_insert_rule(auth, "dan",
+                                            QAUTHZ_LIST_POLICY_DENY,
+                                            QAUTHZ_LIST_FORMAT_EXACT,
+                                            2,
+                                            &error_abort),
+                    =3D=3D, 2);
+
+    g_assert(!qauthz_is_allowed(QAUTHZ(auth), "dan", &error_abort));
+
+    object_unparent(OBJECT(auth));
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    module_call_init(MODULE_INIT_QOM);
+
+    g_test_add_func("/auth/list/default/deny", test_authz_default_deny);
+    g_test_add_func("/auth/list/default/allow", test_authz_default_allow=
);
+    g_test_add_func("/auth/list/explicit/deny", test_authz_explicit_deny=
);
+    g_test_add_func("/auth/list/explicit/allow", test_authz_explicit_all=
ow);
+    g_test_add_func("/auth/list/complex", test_authz_complex);
+    g_test_add_func("/auth/list/add-remove", test_authz_add_remove);
+
+    return g_test_run();
+}
--=20
2.19.2
