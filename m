Received: from eggs.gnu.org ([2001:4830:134:3::10]:39357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fRKtZ-0007BT-RL
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:09:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fRKtY-0008OY-9O
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:09:49 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri,  8 Jun 2018 18:09:29 +0100
Message-Id: <20180608170933.9137-5-berrange@redhat.com>
In-Reply-To: <20180608170933.9137-1-berrange@redhat.com>
References: <20180608170933.9137-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH 4/8] authz: add QAuthZSimple object type for
 trivial auth checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-trivial@nongnu.org, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>

In many cases a single VM will just need to whilelist a single identity
as the allowed user of network services. This is especially the case for
TLS live migration (optionally with NBD storage) where we just need to
whitelist the x509 certificate distinguished name of the source QEMU
host.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 authz/Makefile.objs    |   1 +
 authz/simple.c         | 122 +++++++++++++++++++++++++++++++++++++++++
 authz/trace-events     |   3 +
 include/authz/simple.h |  81 +++++++++++++++++++++++++++
 4 files changed, 207 insertions(+)
 create mode 100644 authz/simple.c
 create mode 100644 include/authz/simple.h

diff --git a/authz/Makefile.objs b/authz/Makefile.objs
index 12597c9528..2a75d53840 100644
--- a/authz/Makefile.objs
+++ b/authz/Makefile.objs
@@ -1 +1,2 @@
 authz-obj-y += base.o
+authz-obj-y += simple.o
diff --git a/authz/simple.c b/authz/simple.c
new file mode 100644
index 0000000000..1ed1605b14
--- /dev/null
+++ b/authz/simple.c
@@ -0,0 +1,122 @@
+/*
+ * QEMU simple authorization driver
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
+#include "authz/simple.h"
+#include "authz/trace.h"
+#include "qom/object_interfaces.h"
+
+static bool qauthz_simple_is_allowed(QAuthZ *authz,
+                                     const char *identity,
+                                     Error **errp)
+{
+    QAuthZSimple *sauthz = QAUTHZ_SIMPLE(authz);
+
+    trace_qauthz_simple_is_allowed(authz, sauthz->identity, identity);
+    return g_str_equal(identity, sauthz->identity);
+}
+
+static void
+qauthz_simple_prop_set_identity(Object *obj,
+                                const char *value,
+                                Error **errp G_GNUC_UNUSED)
+{
+    QAuthZSimple *authz = QAUTHZ_SIMPLE(obj);
+
+    authz->identity = g_strdup(value);
+}
+
+
+static char *
+qauthz_simple_prop_get_identity(Object *obj,
+                                Error **errp G_GNUC_UNUSED)
+{
+    QAuthZSimple *authz = QAUTHZ_SIMPLE(obj);
+
+    return g_strdup(authz->identity);
+}
+
+
+static void
+qauthz_simple_complete(UserCreatable *uc, Error **errp)
+{
+}
+
+
+static void
+qauthz_simple_finalize(Object *obj)
+{
+    QAuthZSimple *sauthz = QAUTHZ_SIMPLE(obj);
+
+    g_free(sauthz->identity);
+}
+
+
+static void
+qauthz_simple_class_init(ObjectClass *oc, void *data)
+{
+    UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
+    QAuthZClass *authz = QAUTHZ_CLASS(oc);
+
+    ucc->complete = qauthz_simple_complete;
+    authz->is_allowed = qauthz_simple_is_allowed;
+
+    object_class_property_add_str(oc, "identity",
+                                  qauthz_simple_prop_get_identity,
+                                  qauthz_simple_prop_set_identity,
+                                  NULL);
+}
+
+
+QAuthZSimple *qauthz_simple_new(const char *id,
+                                const char *identity,
+                                Error **errp)
+{
+    return QAUTHZ_SIMPLE(
+        object_new_with_props(TYPE_QAUTHZ_SIMPLE,
+                              object_get_objects_root(),
+                              id, errp,
+                              "identity", identity,
+                              NULL));
+}
+
+
+static const TypeInfo qauthz_simple_info = {
+    .parent = TYPE_QAUTHZ,
+    .name = TYPE_QAUTHZ_SIMPLE,
+    .instance_size = sizeof(QAuthZSimple),
+    .instance_finalize = qauthz_simple_finalize,
+    .class_size = sizeof(QAuthZSimpleClass),
+    .class_init = qauthz_simple_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_USER_CREATABLE },
+        { }
+    }
+};
+
+
+static void
+qauthz_simple_register_types(void)
+{
+    type_register_static(&qauthz_simple_info);
+}
+
+
+type_init(qauthz_simple_register_types);
diff --git a/authz/trace-events b/authz/trace-events
index 481c90f511..1ef796c1e1 100644
--- a/authz/trace-events
+++ b/authz/trace-events
@@ -2,3 +2,6 @@
 
 # authz/base.c
 qauthz_is_allowed(void *authz, const char *identity, bool allowed) "AuthZ %p check identity=%s allowed=%d"
+
+# auth/simple.c
+qauthz_simple_is_allowed(void *authz, const char *wantidentity, const char *gotidentity) "AuthZ simple %p check want identity=%s got identity=%s"
diff --git a/include/authz/simple.h b/include/authz/simple.h
new file mode 100644
index 0000000000..e669f4afec
--- /dev/null
+++ b/include/authz/simple.h
@@ -0,0 +1,81 @@
+/*
+ * QEMU simple authorization driver
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
+#ifndef QAUTHZ_SIMPLE_H__
+#define QAUTHZ_SIMPLE_H__
+
+#include "authz/base.h"
+#include "qapi/qapi-types-authz.h"
+
+#define TYPE_QAUTHZ_SIMPLE "authz-simple"
+
+#define QAUTHZ_SIMPLE_CLASS(klass)                        \
+    OBJECT_CLASS_CHECK(QAuthZSimpleClass, (klass),        \
+                       TYPE_QAUTHZ_SIMPLE)
+#define QAUTHZ_SIMPLE_GET_CLASS(obj)              \
+    OBJECT_GET_CLASS(QAuthZSimpleClass, (obj),    \
+                      TYPE_QAUTHZ_SIMPLE)
+#define QAUTHZ_SIMPLE(obj) \
+    INTERFACE_CHECK(QAuthZSimple, (obj),          \
+                    TYPE_QAUTHZ_SIMPLE)
+
+typedef struct QAuthZSimple QAuthZSimple;
+typedef struct QAuthZSimpleClass QAuthZSimpleClass;
+
+
+/**
+ * QAuthZSimple:
+ *
+ * This authorization driver provides a simple mechanism
+ * for granting access based on an exact matched username.
+ *
+ * To create an instance of this class via QMP:
+ *
+ *  {
+ *    "execute": "object-add",
+ *    "arguments": {
+ *      "qom-type": "authz-simple",
+ *      "id": "authz0",
+ *      "parameters": {
+ *        "identity": "fred"
+ *      }
+ *    }
+ *  }
+ *
+ */
+struct QAuthZSimple {
+    QAuthZ parent_obj;
+
+    char *identity;
+};
+
+
+struct QAuthZSimpleClass {
+    QAuthZClass parent_class;
+};
+
+
+QAuthZSimple *qauthz_simple_new(const char *id,
+                                const char *identity,
+                                Error **errp);
+
+
+#endif /* QAUTHZ_SIMPLE_H__ */
+
-- 
2.17.0
