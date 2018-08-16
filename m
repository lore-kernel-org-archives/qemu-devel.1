Received: from eggs.gnu.org ([2001:4830:134:3::10]:48609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqHuH-0003V5-DV
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqHuA-0001VS-R1
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:01:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34190 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fqHuA-0001UU-Hm
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:01:34 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 16 Aug 2018 14:01:13 +0100
Message-Id: <20180816130118.31841-7-berrange@redhat.com>
In-Reply-To: <20180816130118.31841-1-berrange@redhat.com>
References: <20180816130118.31841-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v4 06/11] authz: add QAuthZ object as an
 authorization base class
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

The current qemu_acl module provides a simple access control list
facility inside QEMU, which is used via a set of monitor commands
acl_show, acl_policy, acl_add, acl_remove & acl_reset.

Note there is no ability to create ACLs - the network services (eg VNC
server) were expected to create ACLs that they want to check.

There is also no way to define ACLs on the command line, nor potentially
integrate with external authorization systems like polkit, pam, ldap
lookup, etc.

The QAuthZ object defines a minimal abstract QOM class that can be
subclassed for creating different authorization providers.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 MAINTAINERS          |   7 +++
 Makefile             |  10 ++--
 Makefile.objs        |   6 +++
 Makefile.target      |   2 +
 authz/Makefile.objs  |   1 +
 authz/base.c         |  82 +++++++++++++++++++++++++++++++
 authz/trace-events   |   4 ++
 include/authz/base.h | 112 +++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 220 insertions(+), 4 deletions(-)
 create mode 100644 authz/Makefile.objs
 create mode 100644 authz/base.c
 create mode 100644 authz/trace-events
 create mode 100644 include/authz/base.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1284bb3443..999541b7c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1794,6 +1794,13 @@ F: io/
 F: include/io/
 F: tests/test-io-*
 
+User authorization
+M: Daniel P. Berrange <berrange@redhat.com>
+S: Maintained
+F: authz/
+F: include/authz/
+F: tests/test-authz-*
+
 Sockets
 M: Daniel P. Berrange <berrange@redhat.com>
 M: Gerd Hoffmann <kraxel@redhat.com>
diff --git a/Makefile b/Makefile
index 2da686be33..7c414d9918 100644
--- a/Makefile
+++ b/Makefile
@@ -411,6 +411,7 @@ endif
 
 dummy := $(call unnest-vars,, \
                 stub-obj-y \
+                authz-obj-y \
                 chardev-obj-y \
                 util-obj-y \
                 qga-obj-y \
@@ -472,6 +473,7 @@ qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
 SUBDIR_RULES=$(patsubst %,subdir-%, $(TARGET_DIRS))
 SOFTMMU_SUBDIR_RULES=$(filter %-softmmu,$(SUBDIR_RULES))
 
+$(SOFTMMU_SUBDIR_RULES): $(authz-obj-y)
 $(SOFTMMU_SUBDIR_RULES): $(block-obj-y)
 $(SOFTMMU_SUBDIR_RULES): $(crypto-obj-y)
 $(SOFTMMU_SUBDIR_RULES): $(io-obj-y)
@@ -534,9 +536,9 @@ COMMON_LDADDS = libqemuutil.a
 
 qemu-img.o: qemu-img-cmds.h
 
-qemu-img$(EXESUF): qemu-img.o $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
-qemu-nbd$(EXESUF): qemu-nbd.o $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
-qemu-io$(EXESUF): qemu-io.o $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
+qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
+qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
+qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 
 qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o $(COMMON_LDADDS)
 
@@ -545,7 +547,7 @@ qemu-keymap$(EXESUF): qemu-keymap.o ui/input-keymap.o $(COMMON_LDADDS)
 fsdev/virtfs-proxy-helper$(EXESUF): fsdev/virtfs-proxy-helper.o fsdev/9p-marshal.o fsdev/9p-iov-marshal.o $(COMMON_LDADDS)
 fsdev/virtfs-proxy-helper$(EXESUF): LIBS += -lcap
 
-scsi/qemu-pr-helper$(EXESUF): scsi/qemu-pr-helper.o scsi/utils.o $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
+scsi/qemu-pr-helper$(EXESUF): scsi/qemu-pr-helper.o scsi/utils.o $(authz-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 ifdef CONFIG_MPATH
 scsi/qemu-pr-helper$(EXESUF): LIBS += -ludev -lmultipath -lmpathpersist
 endif
diff --git a/Makefile.objs b/Makefile.objs
index 7a9828da28..42cdb1c1c3 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -62,6 +62,11 @@ util-obj-y += qapi/qapi-introspect.o
 
 chardev-obj-y = chardev/
 
+#######################################################################
+# authz-obj-y is code used by both qemu system emulation and qemu-img
+
+authz-obj-y = authz/
+
 #######################################################################
 # block-obj-y is code used by both qemu system emulation and qemu-img
 
@@ -199,6 +204,7 @@ trace-events-subdirs =
 trace-events-subdirs += accel/kvm
 trace-events-subdirs += accel/tcg
 trace-events-subdirs += audio
+trace-events-subdirs += authz
 trace-events-subdirs += block
 trace-events-subdirs += chardev
 trace-events-subdirs += crypto
diff --git a/Makefile.target b/Makefile.target
index 4d56298bbf..c08461726d 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -172,6 +172,7 @@ include $(SRC_PATH)/Makefile.objs
 dummy := $(call unnest-vars,,target-obj-y)
 target-obj-y-save := $(target-obj-y)
 dummy := $(call unnest-vars,.., \
+               authz-obj-y \
                block-obj-y \
                block-obj-m \
                chardev-obj-y \
@@ -185,6 +186,7 @@ target-obj-y := $(target-obj-y-save)
 all-obj-y += $(common-obj-y)
 all-obj-y += $(target-obj-y)
 all-obj-y += $(qom-obj-y)
+all-obj-$(CONFIG_SOFTMMU) += $(authz-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(block-obj-y) $(chardev-obj-y)
 all-obj-$(CONFIG_USER_ONLY) += $(crypto-aes-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(crypto-obj-y)
diff --git a/authz/Makefile.objs b/authz/Makefile.objs
new file mode 100644
index 0000000000..12597c9528
--- /dev/null
+++ b/authz/Makefile.objs
@@ -0,0 +1 @@
+authz-obj-y += base.o
diff --git a/authz/base.c b/authz/base.c
new file mode 100644
index 0000000000..5b15811384
--- /dev/null
+++ b/authz/base.c
@@ -0,0 +1,82 @@
+/*
+ * QEMU authorization framework base class
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
+#include "authz/base.h"
+#include "authz/trace.h"
+
+bool qauthz_is_allowed(QAuthZ *authz,
+                       const char *identity,
+                       Error **errp)
+{
+    QAuthZClass *cls = QAUTHZ_GET_CLASS(authz);
+    bool allowed;
+
+    allowed = cls->is_allowed(authz, identity, errp);
+    trace_qauthz_is_allowed(authz, identity, allowed);
+
+    return allowed;
+}
+
+
+bool qauthz_is_allowed_by_id(const char *authzid,
+                             const char *identity,
+                             Error **errp)
+{
+    QAuthZ *authz;
+    Object *obj;
+    Object *container;
+
+    container = object_get_objects_root();
+    obj = object_resolve_path_component(container,
+                                        authzid);
+    if (!obj) {
+        error_setg(errp, "Cannot find QAuthZ object ID %s",
+                   authzid);
+        return 0;
+    }
+
+    if (!object_dynamic_cast(obj, TYPE_QAUTHZ)) {
+        error_setg(errp, "Object '%s' is not a QAuthZ subclass",
+                   authzid);
+        return 0;
+    }
+
+    authz = QAUTHZ(obj);
+
+    return qauthz_is_allowed(authz, identity, errp);
+}
+
+
+static const TypeInfo authz_info = {
+    .parent = TYPE_OBJECT,
+    .name = TYPE_QAUTHZ,
+    .instance_size = sizeof(QAuthZ),
+    .class_size = sizeof(QAuthZClass),
+    .abstract = true,
+};
+
+static void qauthz_register_types(void)
+{
+    type_register_static(&authz_info);
+}
+
+type_init(qauthz_register_types)
+
diff --git a/authz/trace-events b/authz/trace-events
new file mode 100644
index 0000000000..481c90f511
--- /dev/null
+++ b/authz/trace-events
@@ -0,0 +1,4 @@
+# See docs/devel/tracing.txt for syntax documentation.
+
+# authz/base.c
+qauthz_is_allowed(void *authz, const char *identity, bool allowed) "AuthZ %p check identity=%s allowed=%d"
diff --git a/include/authz/base.h b/include/authz/base.h
new file mode 100644
index 0000000000..77dcd54c4c
--- /dev/null
+++ b/include/authz/base.h
@@ -0,0 +1,112 @@
+/*
+ * QEMU authorization framework base class
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
+#ifndef QAUTHZ_BASE_H__
+#define QAUTHZ_BASE_H__
+
+#include "qemu-common.h"
+#include "qapi/error.h"
+#include "qom/object.h"
+
+
+#define TYPE_QAUTHZ "authz"
+
+#define QAUTHZ_CLASS(klass) \
+     OBJECT_CLASS_CHECK(QAuthZClass, (klass), \
+                        TYPE_QAUTHZ)
+#define QAUTHZ_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(QAuthZClass, (obj), \
+                      TYPE_QAUTHZ)
+#define QAUTHZ(obj) \
+     INTERFACE_CHECK(QAuthZ, (obj), \
+                     TYPE_QAUTHZ)
+
+typedef struct QAuthZ QAuthZ;
+typedef struct QAuthZClass QAuthZClass;
+
+/**
+ * QAuthZ:
+ *
+ * The QAuthZ class defines an API contract to be used
+ * for providing an authorization driver for services
+ * with user identities.
+ */
+
+struct QAuthZ {
+    Object parent_obj;
+};
+
+
+struct QAuthZClass {
+    ObjectClass parent_class;
+
+    bool (*is_allowed)(QAuthZ *authz,
+                       const char *identity,
+                       Error **errp);
+};
+
+
+/**
+ * qauthz_is_allowed:
+ * @authz: the authorization object
+ * @identity: the user identity to authorize
+ * @errp: pointer to a NULL initialized error object
+ *
+ * Check if a user @identity is authorized. If an error
+ * occurs this method will return false to indicate
+ * denial, as well as setting @errp to contain the details.
+ * Callers are recommended to treat the denial and error
+ * scenarios identically. Specifically the error info in
+ * @errp should never be fed back to the user being
+ * authorized, it is merely for benefit of administrator
+ * debugging.
+ *
+ * Returns: true if @identity is authorized, false if denied or if
+ * an error occurred.
+ */
+bool qauthz_is_allowed(QAuthZ *authz,
+                       const char *identity,
+                       Error **errp);
+
+
+/**
+ * qauthz_is_allowed_by_id:
+ * @authzid: ID of the authorization object
+ * @identity: the user identity to authorize
+ * @errp: pointer to a NULL initialized error object
+ *
+ * Check if a user @identity is authorized. If an error
+ * occurs this method will return false to indicate
+ * denial, as well as setting @errp to contain the details.
+ * Callers are recommended to treat the denial and error
+ * scenarios identically. Specifically the error info in
+ * @errp should never be fed back to the user being
+ * authorized, it is merely for benefit of administrator
+ * debugging.
+ *
+ * Returns: true if @identity is authorized, false if denied or if
+ * an error occurred.
+ */
+bool qauthz_is_allowed_by_id(const char *authzid,
+                             const char *identity,
+                             Error **errp);
+
+#endif /* QAUTHZ_BASE_H__ */
+
-- 
2.17.1
