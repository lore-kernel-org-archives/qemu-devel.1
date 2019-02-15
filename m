Received: from eggs.gnu.org ([209.51.188.92]:46929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gufsJ-00057B-JY
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 10:58:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gufsG-00030s-Mg
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 10:58:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gufsG-0002yI-B2
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 10:58:00 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 15 Feb 2019 15:57:04 +0000
Message-Id: <20190215155709.15777-7-berrange@redhat.com>
In-Reply-To: <20190215155709.15777-1-berrange@redhat.com>
References: <20190215155709.15777-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 06/11] authz: add QAuthZ object as an
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

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

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
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
index 5989796fa9..3941c1fbe4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2072,6 +2072,13 @@ F: io/
 F: include/io/
 F: tests/test-io-*
=20
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
index 3658310b95..564def78ee 100644
--- a/Makefile
+++ b/Makefile
@@ -359,6 +359,7 @@ endif
=20
 dummy :=3D $(call unnest-vars,, \
                 stub-obj-y \
+                authz-obj-y \
                 chardev-obj-y \
                 util-obj-y \
                 qga-obj-y \
@@ -423,6 +424,7 @@ qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_P=
ATH)/scripts/hxtool
 SUBDIR_RULES=3D$(patsubst %,subdir-%, $(TARGET_DIRS))
 SOFTMMU_SUBDIR_RULES=3D$(filter %-softmmu,$(SUBDIR_RULES))
=20
+$(SOFTMMU_SUBDIR_RULES): $(authz-obj-y)
 $(SOFTMMU_SUBDIR_RULES): $(block-obj-y)
 $(SOFTMMU_SUBDIR_RULES): $(crypto-obj-y)
 $(SOFTMMU_SUBDIR_RULES): $(io-obj-y)
@@ -485,9 +487,9 @@ COMMON_LDADDS =3D libqemuutil.a
=20
 qemu-img.o: qemu-img-cmds.h
=20
-qemu-img$(EXESUF): qemu-img.o $(block-obj-y) $(crypto-obj-y) $(io-obj-y)=
 $(qom-obj-y) $(COMMON_LDADDS)
-qemu-nbd$(EXESUF): qemu-nbd.o $(block-obj-y) $(crypto-obj-y) $(io-obj-y)=
 $(qom-obj-y) $(COMMON_LDADDS)
-qemu-io$(EXESUF): qemu-io.o $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $=
(qom-obj-y) $(COMMON_LDADDS)
+qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y) $(crypto-obj=
-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
+qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj=
-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
+qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y=
) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
=20
 qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o $(COMMON_LDADDS)
=20
@@ -498,7 +500,7 @@ qemu-edid$(EXESUF): qemu-edid.o hw/display/edid-gener=
ate.o $(COMMON_LDADDS)
 fsdev/virtfs-proxy-helper$(EXESUF): fsdev/virtfs-proxy-helper.o fsdev/9p=
-marshal.o fsdev/9p-iov-marshal.o $(COMMON_LDADDS)
 fsdev/virtfs-proxy-helper$(EXESUF): LIBS +=3D -lcap
=20
-scsi/qemu-pr-helper$(EXESUF): scsi/qemu-pr-helper.o scsi/utils.o $(crypt=
o-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
+scsi/qemu-pr-helper$(EXESUF): scsi/qemu-pr-helper.o scsi/utils.o $(authz=
-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 ifdef CONFIG_MPATH
 scsi/qemu-pr-helper$(EXESUF): LIBS +=3D -ludev -lmultipath -lmpathpersis=
t
 endif
diff --git a/Makefile.objs b/Makefile.objs
index fee0ce9fc5..68910f8169 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -19,6 +19,11 @@ util-obj-y +=3D qapi/qapi-introspect.o
 chardev-obj-y =3D chardev/
 slirp-obj-$(CONFIG_SLIRP) =3D slirp/
=20
+#######################################################################
+# authz-obj-y is code used by both qemu system emulation and qemu-img
+
+authz-obj-y =3D authz/
+
 #######################################################################
 # block-obj-y is code used by both qemu system emulation and qemu-img
=20
@@ -140,6 +145,7 @@ trace-events-subdirs =3D
 trace-events-subdirs +=3D accel/kvm
 trace-events-subdirs +=3D accel/tcg
 trace-events-subdirs +=3D audio
+trace-events-subdirs +=3D authz
 trace-events-subdirs +=3D block
 trace-events-subdirs +=3D chardev
 trace-events-subdirs +=3D crypto
diff --git a/Makefile.target b/Makefile.target
index 401dc1ea6f..076cb600bb 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -178,6 +178,7 @@ include $(SRC_PATH)/Makefile.objs
 dummy :=3D $(call unnest-vars,,target-obj-y)
 target-obj-y-save :=3D $(target-obj-y)
 dummy :=3D $(call unnest-vars,.., \
+               authz-obj-y \
                block-obj-y \
                block-obj-m \
                chardev-obj-y \
@@ -192,6 +193,7 @@ target-obj-y :=3D $(target-obj-y-save)
 all-obj-y +=3D $(common-obj-y)
 all-obj-y +=3D $(target-obj-y)
 all-obj-y +=3D $(qom-obj-y)
+all-obj-$(CONFIG_SOFTMMU) +=3D $(authz-obj-y)
 all-obj-$(CONFIG_SOFTMMU) +=3D $(block-obj-y) $(chardev-obj-y)
 all-obj-$(CONFIG_USER_ONLY) +=3D $(crypto-aes-obj-y)
 all-obj-$(CONFIG_SOFTMMU) +=3D $(crypto-obj-y)
diff --git a/authz/Makefile.objs b/authz/Makefile.objs
new file mode 100644
index 0000000000..12597c9528
--- /dev/null
+++ b/authz/Makefile.objs
@@ -0,0 +1 @@
+authz-obj-y +=3D base.o
diff --git a/authz/base.c b/authz/base.c
new file mode 100644
index 0000000000..110dfa4195
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
+ * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
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
+    QAuthZClass *cls =3D QAUTHZ_GET_CLASS(authz);
+    bool allowed;
+
+    allowed =3D cls->is_allowed(authz, identity, errp);
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
+    container =3D object_get_objects_root();
+    obj =3D object_resolve_path_component(container,
+                                        authzid);
+    if (!obj) {
+        error_setg(errp, "Cannot find QAuthZ object ID %s",
+                   authzid);
+        return false;
+    }
+
+    if (!object_dynamic_cast(obj, TYPE_QAUTHZ)) {
+        error_setg(errp, "Object '%s' is not a QAuthZ subclass",
+                   authzid);
+        return false;
+    }
+
+    authz =3D QAUTHZ(obj);
+
+    return qauthz_is_allowed(authz, identity, errp);
+}
+
+
+static const TypeInfo authz_info =3D {
+    .parent =3D TYPE_OBJECT,
+    .name =3D TYPE_QAUTHZ,
+    .instance_size =3D sizeof(QAuthZ),
+    .class_size =3D sizeof(QAuthZClass),
+    .abstract =3D true,
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
+qauthz_is_allowed(void *authz, const char *identity, bool allowed) "Auth=
Z %p check identity=3D%s allowed=3D%d"
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
+ * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
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
--=20
2.20.1
