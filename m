Received: from eggs.gnu.org ([2001:4830:134:3::10]:38079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDUzW-0004dO-4C
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:39:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDUzU-0000Hf-Lw
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:39:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gDUzU-0000Gl-Dy
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:39:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C85C988304
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 13:38:59 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 19 Oct 2018 14:38:31 +0100
Message-Id: <20181019133835.16494-8-berrange@redhat.com>
In-Reply-To: <20181019133835.16494-1-berrange@redhat.com>
References: <20181019133835.16494-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v6 07/11] authz: add QAuthZSimple object type
 for easy whitelist auth checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

In many cases a single VM will just need to whilelist a single identity
as the allowed user of network services. This is especially the case for
TLS live migration (optionally with NBD storage) where we just need to
whitelist the x509 certificate distinguished name of the source QEMU
host.

Via QMP this can be configured with:

  {
    "execute": "object-add",
    "arguments": {
      "qom-type": "authz-simple",
      "id": "authz0",
      "parameters": {
        "identity": "fred"
      }
    }
  }

Or via the command line

  -object authz-simple,id=authz0,identity=fred

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/authz/simple.h |  84 ++++++++++++++++++++++++++++++
 authz/simple.c         | 115 +++++++++++++++++++++++++++++++++++++++++
 authz/Makefile.objs    |   1 +
 authz/trace-events     |   3 ++
 qemu-options.hx        |  24 +++++++++
 5 files changed, 227 insertions(+)
 create mode 100644 include/authz/simple.h
 create mode 100644 authz/simple.c

diff --git a/include/authz/simple.h b/include/authz/simple.h
new file mode 100644
index 0000000000..4686e7676d
--- /dev/null
+++ b/include/authz/simple.h
@@ -0,0 +1,84 @@
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
+ * Or via the command line
+ *
+ *   -object authz-simple,id=authz0,identity=fred
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
diff --git a/authz/simple.c b/authz/simple.c
new file mode 100644
index 0000000000..8ab718803e
--- /dev/null
+++ b/authz/simple.c
@@ -0,0 +1,115 @@
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
+    QAuthZSimple *sauthz = QAUTHZ_SIMPLE(obj);
+
+    g_free(sauthz->identity);
+    sauthz->identity = g_strdup(value);
+}
+
+
+static char *
+qauthz_simple_prop_get_identity(Object *obj,
+                                Error **errp G_GNUC_UNUSED)
+{
+    QAuthZSimple *sauthz = QAUTHZ_SIMPLE(obj);
+
+    return g_strdup(sauthz->identity);
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
+    QAuthZClass *authz = QAUTHZ_CLASS(oc);
+
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
diff --git a/authz/Makefile.objs b/authz/Makefile.objs
index 12597c9528..2a75d53840 100644
--- a/authz/Makefile.objs
+++ b/authz/Makefile.objs
@@ -1 +1,2 @@
 authz-obj-y += base.o
+authz-obj-y += simple.o
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
diff --git a/qemu-options.hx b/qemu-options.hx
index f139459e80..68eaf39cc4 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4377,6 +4377,30 @@ e.g to launch a SEV guest
      .....
 
 @end example
+
+
+@item -object authz-simple,id=@var{id},identity=@var{string}
+
+Create an authorization object that will control access to network services.
+
+The @option{identity} parameter is identifies the user and its format
+depends on the network service that authorization object is associated
+with. For authorizing based on TLS x509 certificates, the identity must
+be the x509 distinguished name. Note that care must be taken to escape
+any commas in the distinguished name.
+
+An example authorization object to validate a x509 distinguished name
+would look like:
+@example
+ # $QEMU \
+     ...
+     -object 'authz-simple,id=auth0,identity=CN=laptop.example.com,,O=Example Org,,L=London,,ST=London,,C=GB' \
+     ...
+@end example
+
+Note the use of quotes due to the x509 distinguished name containing
+whitespace, and escaping of ','.
+
 @end table
 
 ETEXI
-- 
2.17.2
