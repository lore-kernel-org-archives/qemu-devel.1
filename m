Received: from eggs.gnu.org ([2001:4830:134:3::10]:48669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqHuK-0003Xo-Tg
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:01:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqHuH-0001YB-0F
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:01:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60984 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fqHuG-0001XJ-MU
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:01:40 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 16 Aug 2018 14:01:15 +0100
Message-Id: <20180816130118.31841-9-berrange@redhat.com>
In-Reply-To: <20180816130118.31841-1-berrange@redhat.com>
References: <20180816130118.31841-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v4 08/11] authz: add QAuthZList object type for
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
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

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
 authz/list.c            | 315 ++++++++++++++++++++++++++++++++++++++++
 authz/trace-events      |   4 +
 include/authz/list.h    | 106 ++++++++++++++
 qapi/authz.json         |  58 ++++++++
 qapi/qapi-schema.json   |   1 +
 tests/Makefile.include  |   4 +
 tests/test-authz-list.c | 171 ++++++++++++++++++++++
 12 files changed, 675 insertions(+), 1 deletion(-)
 create mode 100644 authz/list.c
 create mode 100644 include/authz/list.h
 create mode 100644 qapi/authz.json
 create mode 100644 tests/test-authz-list.c

diff --git a/.gitignore b/.gitignore
index 5668d02782..5aab952505 100644
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
index 999541b7c6..77a11213c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1798,6 +1798,7 @@ User authorization
 M: Daniel P. Berrange <berrange@redhat.com>
 S: Maintained
 F: authz/
+F: qapi/authz.json
 F: include/authz/
 F: tests/test-authz-*
 
diff --git a/Makefile b/Makefile
index 7c414d9918..1fc74ff15b 100644
--- a/Makefile
+++ b/Makefile
@@ -596,7 +596,8 @@ qapi-modules = $(SRC_PATH)/qapi/qapi-schema.json $(SRC_PATH)/qapi/common.json \
                $(SRC_PATH)/qapi/tpm.json \
                $(SRC_PATH)/qapi/trace.json \
                $(SRC_PATH)/qapi/transaction.json \
-               $(SRC_PATH)/qapi/ui.json
+               $(SRC_PATH)/qapi/ui.json \
+               $(SRC_PATH)/qapi/authz.json
 
 qapi/qapi-builtin-types.c qapi/qapi-builtin-types.h \
 qapi/qapi-types.c qapi/qapi-types.h \
@@ -617,6 +618,7 @@ qapi/qapi-types-tpm.c qapi/qapi-types-tpm.h \
 qapi/qapi-types-trace.c qapi/qapi-types-trace.h \
 qapi/qapi-types-transaction.c qapi/qapi-types-transaction.h \
 qapi/qapi-types-ui.c qapi/qapi-types-ui.h \
+qapi/qapi-types-authz.c qapi/qapi-types-authz.h \
 qapi/qapi-builtin-visit.c qapi/qapi-builtin-visit.h \
 qapi/qapi-visit.c qapi/qapi-visit.h \
 qapi/qapi-visit-block-core.c qapi/qapi-visit-block-core.h \
@@ -636,6 +638,7 @@ qapi/qapi-visit-tpm.c qapi/qapi-visit-tpm.h \
 qapi/qapi-visit-trace.c qapi/qapi-visit-trace.h \
 qapi/qapi-visit-transaction.c qapi/qapi-visit-transaction.h \
 qapi/qapi-visit-ui.c qapi/qapi-visit-ui.h \
+qapi/qapi-visit-authz.c qapi/qapi-visit-authz.h \
 qapi/qapi-commands.h qapi/qapi-commands.c \
 qapi/qapi-commands-block-core.c qapi/qapi-commands-block-core.h \
 qapi/qapi-commands-block.c qapi/qapi-commands-block.h \
@@ -654,6 +657,7 @@ qapi/qapi-commands-tpm.c qapi/qapi-commands-tpm.h \
 qapi/qapi-commands-trace.c qapi/qapi-commands-trace.h \
 qapi/qapi-commands-transaction.c qapi/qapi-commands-transaction.h \
 qapi/qapi-commands-ui.c qapi/qapi-commands-ui.h \
+qapi/qapi-commands-authz.c qapi/qapi-commands-authz.h \
 qapi/qapi-events.c qapi/qapi-events.h \
 qapi/qapi-events-block-core.c qapi/qapi-events-block-core.h \
 qapi/qapi-events-block.c qapi/qapi-events-block.h \
@@ -672,6 +676,7 @@ qapi/qapi-events-tpm.c qapi/qapi-events-tpm.h \
 qapi/qapi-events-trace.c qapi/qapi-events-trace.h \
 qapi/qapi-events-transaction.c qapi/qapi-events-transaction.h \
 qapi/qapi-events-ui.c qapi/qapi-events-ui.h \
+qapi/qapi-events-authz.c qapi/qapi-events-authz.h \
 qapi/qapi-introspect.h qapi/qapi-introspect.c \
 qapi/qapi-doc.texi: \
 qapi-gen-timestamp ;
diff --git a/Makefile.objs b/Makefile.objs
index 42cdb1c1c3..60c0af70cc 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -21,6 +21,7 @@ util-obj-y += qapi/qapi-types-tpm.o
 util-obj-y += qapi/qapi-types-trace.o
 util-obj-y += qapi/qapi-types-transaction.o
 util-obj-y += qapi/qapi-types-ui.o
+util-obj-y += qapi/qapi-types-authz.o
 util-obj-y += qapi/qapi-builtin-visit.o
 util-obj-y += qapi/qapi-visit.o
 util-obj-y += qapi/qapi-visit-block-core.o
@@ -40,6 +41,7 @@ util-obj-y += qapi/qapi-visit-tpm.o
 util-obj-y += qapi/qapi-visit-trace.o
 util-obj-y += qapi/qapi-visit-transaction.o
 util-obj-y += qapi/qapi-visit-ui.o
+util-obj-y += qapi/qapi-visit-authz.o
 util-obj-y += qapi/qapi-events.o
 util-obj-y += qapi/qapi-events-block-core.o
 util-obj-y += qapi/qapi-events-block.o
@@ -58,6 +60,7 @@ util-obj-y += qapi/qapi-events-tpm.o
 util-obj-y += qapi/qapi-events-trace.o
 util-obj-y += qapi/qapi-events-transaction.o
 util-obj-y += qapi/qapi-events-ui.o
+util-obj-y += qapi/qapi-events-authz.o
 util-obj-y += qapi/qapi-introspect.o
 
 chardev-obj-y = chardev/
@@ -160,6 +163,7 @@ common-obj-y += qapi/qapi-commands-tpm.o
 common-obj-y += qapi/qapi-commands-trace.o
 common-obj-y += qapi/qapi-commands-transaction.o
 common-obj-y += qapi/qapi-commands-ui.o
+common-obj-y += qapi/qapi-commands-authz.o
 common-obj-y += qapi/qapi-introspect.o
 common-obj-y += qmp.o hmp.o
 endif
diff --git a/authz/Makefile.objs b/authz/Makefile.objs
index 2a75d53840..921fa624d7 100644
--- a/authz/Makefile.objs
+++ b/authz/Makefile.objs
@@ -1,2 +1,3 @@
 authz-obj-y += base.o
 authz-obj-y += simple.o
+authz-obj-y += list.o
diff --git a/authz/list.c b/authz/list.c
new file mode 100644
index 0000000000..1fc83290df
--- /dev/null
+++ b/authz/list.c
@@ -0,0 +1,315 @@
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
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "authz/list.h"
+#include "authz/trace.h"
+#include "qom/object_interfaces.h"
+#include "qapi/qapi-visit-authz.h"
+
+#ifdef CONFIG_FNMATCH
+#include <fnmatch.h>
+#endif
+
+static bool qauthz_list_is_allowed(QAuthZ *authz,
+                                   const char *identity,
+                                   Error **errp)
+{
+    QAuthZList *sauthz = QAUTHZ_LIST(authz);
+    QAuthZListRuleList *rules = sauthz->rules;
+
+    while (rules) {
+        QAuthZListRule *rule = rules->value;
+        QAuthZListFormat format = rule->has_format ? rule->format :
+            QAUTHZ_LIST_FORMAT_EXACT;
+
+        trace_qauthz_list_check_rule(authz, rule->match, identity,
+                                     format, rule->policy);
+        switch (format) {
+        case QAUTHZ_LIST_FORMAT_EXACT:
+            if (strcmp(rule->match, identity) == 0) {
+                return rule->policy == QAUTHZ_LIST_POLICY_ALLOW;
+            }
+            break;
+#ifdef CONFIG_FNMATCH
+        case QAUTHZ_LIST_FORMAT_GLOB:
+            if (fnmatch(rule->match, identity, 0) == 0) {
+                return rule->policy == QAUTHZ_LIST_POLICY_ALLOW;
+            }
+            break;
+#else
+            return false;
+#endif
+        default:
+            return false;
+        }
+        rules = rules->next;
+    }
+
+    trace_qauthz_list_default_policy(authz, identity, sauthz->policy);
+    return sauthz->policy == QAUTHZ_LIST_POLICY_ALLOW;
+}
+
+
+static void
+qauthz_list_prop_set_policy(Object *obj,
+                            int value,
+                            Error **errp G_GNUC_UNUSED)
+{
+    QAuthZList *bauthz = QAUTHZ_LIST(obj);
+
+    bauthz->policy = value;
+}
+
+
+static int
+qauthz_list_prop_get_policy(Object *obj,
+                            Error **errp G_GNUC_UNUSED)
+{
+    QAuthZList *bauthz = QAUTHZ_LIST(obj);
+
+    return bauthz->policy;
+}
+
+
+static void
+qauthz_list_prop_get_rules(Object *obj, Visitor *v, const char *name,
+                           void *opaque, Error **errp)
+{
+    QAuthZList *bauthz = QAUTHZ_LIST(obj);
+
+    visit_type_QAuthZListRuleList(v, name, &bauthz->rules, errp);
+}
+
+static void
+qauthz_list_prop_set_rules(Object *obj, Visitor *v, const char *name,
+                           void *opaque, Error **errp)
+{
+    QAuthZList *bauthz = QAUTHZ_LIST(obj);
+    QAuthZListRuleList *oldrules;
+#ifndef CONFIG_FNMATCH
+    QAuthZListRuleList *rules;
+#endif
+
+    oldrules = bauthz->rules;
+    visit_type_QAuthZListRuleList(v, name, &bauthz->rules, errp);
+
+#ifndef CONFIG_FNMATCH
+    rules = bauthz->rules;
+    while (rules) {
+        QAuthZListRule *rule = rules->value;
+        if (rule->has_format &&
+            rule->format == QAUTHZ_LIST_FORMAT_GLOB) {
+            error_setg(errp, "Glob format not supported on this platform");
+            qapi_free_QAuthZListRuleList(bauthz->rules);
+            bauthz->rules = oldrules;
+            return;
+        }
+    }
+#endif
+
+    qapi_free_QAuthZListRuleList(oldrules);
+}
+
+
+static void
+qauthz_list_complete(UserCreatable *uc, Error **errp)
+{
+}
+
+
+static void
+qauthz_list_finalize(Object *obj)
+{
+}
+
+
+static void
+qauthz_list_class_init(ObjectClass *oc, void *data)
+{
+    UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
+    QAuthZClass *authz = QAUTHZ_CLASS(oc);
+
+    ucc->complete = qauthz_list_complete;
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
+    authz->is_allowed = qauthz_list_is_allowed;
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
+                              "policy", QAuthZListPolicy_lookup.array[policy],
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
+    size_t i = 0;
+
+#ifndef CONFIG_FNMATCH
+    if (format == QAUTHZ_LIST_FORMAT_GLOB) {
+        error_setg(errp, "Glob format not supported on this platform");
+        return -1;
+    }
+#endif
+
+    rule = g_new0(QAuthZListRule, 1);
+    rule->policy = policy;
+    rule->match = g_strdup(match);
+    rule->format = format;
+    rule->has_format = true;
+
+    tmp = g_new0(QAuthZListRuleList, 1);
+    tmp->value = rule;
+
+    rules = auth->rules;
+    if (rules) {
+        while (rules->next) {
+            i++;
+            rules = rules->next;
+        }
+        rules->next = tmp;
+        return i + 1;
+    } else {
+        auth->rules = tmp;
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
+    size_t i = 0;
+
+#ifndef CONFIG_FNMATCH
+    if (format == QAUTHZ_LIST_FORMAT_GLOB) {
+        error_setg(errp, "Glob format not supported on this platform");
+        return -1;
+    }
+#endif
+
+    rule = g_new0(QAuthZListRule, 1);
+    rule->policy = policy;
+    rule->match = g_strdup(match);
+    rule->format = format;
+    rule->has_format = true;
+
+    tmp = g_new0(QAuthZListRuleList, 1);
+    tmp->value = rule;
+
+    rules = auth->rules;
+    if (rules && index > 0) {
+        while (rules->next && i < (index - 1)) {
+            i++;
+            rules = rules->next;
+        }
+        tmp->next = rules->next;
+        rules->next = tmp;
+        return i + 1;
+    } else {
+        tmp->next = auth->rules;
+        auth->rules = tmp;
+        return 0;
+    }
+}
+
+
+ssize_t qauthz_list_delete_rule(QAuthZList *auth, const char *match)
+{
+    QAuthZListRule *rule;
+    QAuthZListRuleList *rules, *prev;
+    size_t i = 0;
+
+    prev = NULL;
+    rules = auth->rules;
+    while (rules) {
+        rule = rules->value;
+        if (g_str_equal(rule->match, match)) {
+            if (prev) {
+                prev->next = rules->next;
+            } else {
+                auth->rules = rules->next;
+            }
+            rules->next = NULL;
+            qapi_free_QAuthZListRuleList(rules);
+            return i;
+        }
+        prev = rules;
+        rules = rules->next;
+        i++;
+    }
+
+    return -1;
+}
+
+
+static const TypeInfo qauthz_list_info = {
+    .parent = TYPE_QAUTHZ,
+    .name = TYPE_QAUTHZ_LIST,
+    .instance_size = sizeof(QAuthZList),
+    .instance_finalize = qauthz_list_finalize,
+    .class_size = sizeof(QAuthZListClass),
+    .class_init = qauthz_list_class_init,
+    .interfaces = (InterfaceInfo[]) {
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
@@ -5,3 +5,7 @@ qauthz_is_allowed(void *authz, const char *identity, bool allowed) "AuthZ %p che
 
 # auth/simple.c
 qauthz_simple_is_allowed(void *authz, const char *wantidentity, const char *gotidentity) "AuthZ simple %p check want identity=%s got identity=%s"
+
+# auth/list.c
+qauthz_list_check_rule(void *authz, const char *identity, const char *rule, int format, int policy) "AuthZ list %p check rule=%s identity=%s format=%d policy=%d"
+qauthz_list_default_policy(void *authz, const char *identity, int policy) "AuthZ list %p default identity=%s policy=%d"
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
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
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
index 0000000000..607839c627
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
+# Since: 3.0
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
+# Since: 3.0
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
+# Since: 3.0
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
+# Since: 3.0
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
index a49282704e..50157934c1 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -171,6 +171,7 @@ check-unit-y += tests/ptimer-test$(EXESUF)
 gcov-files-ptimer-test-y = hw/core/ptimer.c
 check-unit-y += tests/test-qapi-util$(EXESUF)
 gcov-files-test-qapi-util-y = qapi/qapi-util.c
+check-unit-y += tests/test-authz-list$(EXESUF)
 
 check-block-$(CONFIG_POSIX) += tests/qemu-iotests-quick.sh
 
@@ -670,6 +671,9 @@ tests/test-timed-average$(EXESUF): tests/test-timed-average.o $(test-util-obj-y)
 tests/test-base64$(EXESUF): tests/test-base64.o $(test-util-obj-y)
 tests/ptimer-test$(EXESUF): tests/ptimer-test.o tests/ptimer-test-stubs.o hw/core/ptimer.o
 
+tests/test-authz-list$(EXESUF): tests/test-authz-list.o \
+	$(test-util-obj-y) $(authz-obj-y) $(qom-obj-y)
+
 tests/test-logging$(EXESUF): tests/test-logging.o $(test-util-obj-y)
 
 tests/test-replication$(EXESUF): tests/test-replication.o $(test-util-obj-y) \
diff --git a/tests/test-authz-list.c b/tests/test-authz-list.c
new file mode 100644
index 0000000000..02ce4c5763
--- /dev/null
+++ b/tests/test-authz-list.c
@@ -0,0 +1,171 @@
+/*
+ * QEMU list authorization object
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
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+
+#include "authz/list.h"
+
+static void test_authz_default_deny(void)
+{
+    QAuthZList *auth = qauthz_list_new("auth0",
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
+    QAuthZList *auth = qauthz_list_new("auth0",
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
+    QAuthZList *auth = qauthz_list_new("auth0",
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
+    QAuthZList *auth = qauthz_list_new("auth0",
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
+#ifndef CONFIG_FNMATCH
+    Error *local_err = NULL;
+#endif
+    QAuthZList *auth = qauthz_list_new("auth0",
+                                       QAUTHZ_LIST_POLICY_DENY,
+                                       &error_abort);
+
+    qauthz_list_append_rule(auth, "fred", QAUTHZ_LIST_POLICY_ALLOW,
+                            QAUTHZ_LIST_FORMAT_EXACT, &error_abort);
+    qauthz_list_append_rule(auth, "bob", QAUTHZ_LIST_POLICY_ALLOW,
+                            QAUTHZ_LIST_FORMAT_EXACT, &error_abort);
+    qauthz_list_append_rule(auth, "dan", QAUTHZ_LIST_POLICY_DENY,
+                            QAUTHZ_LIST_FORMAT_EXACT, &error_abort);
+#ifdef CONFIG_FNMATCH
+    qauthz_list_append_rule(auth, "dan*", QAUTHZ_LIST_POLICY_ALLOW,
+                            QAUTHZ_LIST_FORMAT_GLOB, &error_abort);
+
+    g_assert(qauthz_is_allowed(QAUTHZ(auth), "fred", &error_abort));
+    g_assert(qauthz_is_allowed(QAUTHZ(auth), "bob", &error_abort));
+    g_assert(!qauthz_is_allowed(QAUTHZ(auth), "dan", &error_abort));
+    g_assert(qauthz_is_allowed(QAUTHZ(auth), "danb", &error_abort));
+#else
+    g_assert(qauthz_list_append_rule(auth, "dan*",
+                                     QAUTHZ_LIST_POLICY_ALLOW,
+                                     QAUTHZ_LIST_FORMAT_GLOB,
+                                     &local_err) < 0);
+    g_assert(local_err != NULL);
+    error_free(local_err);
+#endif
+
+    object_unparent(OBJECT(auth));
+}
+
+static void test_authz_add_remove(void)
+{
+    QAuthZList *auth = qauthz_list_new("auth0",
+                                       QAUTHZ_LIST_POLICY_ALLOW,
+                                       &error_abort);
+
+    g_assert_cmpint(qauthz_list_append_rule(auth, "fred",
+                                            QAUTHZ_LIST_POLICY_ALLOW,
+                                            QAUTHZ_LIST_FORMAT_EXACT,
+                                            &error_abort),
+                    ==, 0);
+    g_assert_cmpint(qauthz_list_append_rule(auth, "bob",
+                                            QAUTHZ_LIST_POLICY_ALLOW,
+                                            QAUTHZ_LIST_FORMAT_EXACT,
+                                            &error_abort),
+                    ==, 1);
+    g_assert_cmpint(qauthz_list_append_rule(auth, "dan",
+                                            QAUTHZ_LIST_POLICY_DENY,
+                                            QAUTHZ_LIST_FORMAT_EXACT,
+                                            &error_abort),
+                    ==, 2);
+    g_assert_cmpint(qauthz_list_append_rule(auth, "frank",
+                                            QAUTHZ_LIST_POLICY_DENY,
+                                            QAUTHZ_LIST_FORMAT_EXACT,
+                                            &error_abort),
+                    ==, 3);
+
+    g_assert(!qauthz_is_allowed(QAUTHZ(auth), "dan", &error_abort));
+
+    g_assert_cmpint(qauthz_list_delete_rule(auth, "dan"),
+                    ==, 2);
+
+    g_assert(qauthz_is_allowed(QAUTHZ(auth), "dan", &error_abort));
+
+    g_assert_cmpint(qauthz_list_insert_rule(auth, "dan",
+                                            QAUTHZ_LIST_POLICY_DENY,
+                                            QAUTHZ_LIST_FORMAT_EXACT,
+                                            2,
+                                            &error_abort),
+                    ==, 2);
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
+    g_test_add_func("/auth/list/default/allow", test_authz_default_allow);
+    g_test_add_func("/auth/list/explicit/deny", test_authz_explicit_deny);
+    g_test_add_func("/auth/list/explicit/allow", test_authz_explicit_allow);
+    g_test_add_func("/auth/list/complex", test_authz_complex);
+    g_test_add_func("/auth/list/add-remove", test_authz_add_remove);
+
+    return g_test_run();
+}
-- 
2.17.1
