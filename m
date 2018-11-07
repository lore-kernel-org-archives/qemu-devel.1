Received: from eggs.gnu.org ([2001:4830:134:3::10]:37968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gKN7S-0008N7-Nj
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 07:39:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gKN7F-0007WV-0C
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 07:39:29 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  7 Nov 2018 16:36:50 +0400
Message-Id: <20181107123652.23417-13-marcandre.lureau@redhat.com>
In-Reply-To: <20181107123652.23417-1-marcandre.lureau@redhat.com>
References: <20181107123652.23417-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 v3 12/14] machine: add compat-props
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, dgilbert@redhat.com, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, xen-devel@lists.xenproject.org, Artyom Tarasenko <atar4qemu@gmail.com>, Anthony Perard <anthony.perard@citrix.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Amit Shah <amit@kernel.org>, Stefan Berger <stefanb@linux.ibm.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <minyard@acm.org>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Let's make compatiblity properties an interface, so that objects other
than QDev can benefit from having machine compatiblity properties.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/boards.h    |  2 ++
 hw/core/compat-props.c | 43 ++++++++++++++++++++++++++++++++++++++++++
 hw/core/qdev.c         | 12 ++++--------
 MAINTAINERS            |  1 +
 hw/core/Makefile.objs  |  1 +
 tests/Makefile.include |  1 +
 6 files changed, 52 insertions(+), 8 deletions(-)
 create mode 100644 hw/core/compat-props.c

diff --git a/include/hw/boards.h b/include/hw/boards.h
index c02190fc52..e09cbe70a4 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -9,6 +9,8 @@
 #include "qom/object.h"
 #include "qom/cpu.h"
=20
+#define TYPE_COMPAT_PROPS "compat-props"
+
 /**
  * memory_region_allocate_system_memory - Allocate a board's main memory
  * @mr: the #MemoryRegion to be initialized
diff --git a/hw/core/compat-props.c b/hw/core/compat-props.c
new file mode 100644
index 0000000000..1edeadb6a3
--- /dev/null
+++ b/hw/core/compat-props.c
@@ -0,0 +1,43 @@
+/*
+ * QEMU Machine compat properties
+ *
+ * Copyright (C) 2018 Red Hat Inc
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/boards.h"
+#include "qapi/error.h"
+
+typedef struct CompatProps CompatProps;
+
+typedef struct CompatPropsClass {
+    InterfaceClass parent_class;
+} CompatPropsClass;
+
+static void compat_props_post_init(Object *obj)
+{
+    if (current_machine) {
+        MachineClass *mc =3D MACHINE_GET_CLASS(current_machine);
+        AccelClass *ac =3D ACCEL_GET_CLASS(current_machine->accelerator)=
;
+
+        object_apply_global_props(obj, mc->compat_props, &error_abort);
+        object_apply_global_props(obj, ac->compat_props, &error_abort);
+    }
+}
+
+static void compat_props_register_types(void)
+{
+    static const TypeInfo cp_interface_info =3D {
+        .name          =3D TYPE_COMPAT_PROPS,
+        .parent        =3D TYPE_INTERFACE,
+        .class_size =3D sizeof(CompatPropsClass),
+        .instance_post_init =3D compat_props_post_init,
+    };
+
+    type_register_static(&cp_interface_info);
+}
+
+type_init(compat_props_register_types)
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 30890f2c8d..b0ee05f837 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -972,14 +972,6 @@ static void device_initfn(Object *obj)
=20
 static void device_post_init(Object *obj)
 {
-    if (current_machine) {
-        MachineClass *mc =3D MACHINE_GET_CLASS(current_machine);
-        AccelClass *ac =3D ACCEL_GET_CLASS(current_machine->accelerator)=
;
-
-        object_apply_global_props(obj, mc->compat_props, &error_abort);
-        object_apply_global_props(obj, ac->compat_props, &error_abort);
-    }
-
     qdev_prop_set_globals(DEVICE(obj));
 }
=20
@@ -1112,6 +1104,10 @@ static const TypeInfo device_type_info =3D {
     .class_init =3D device_class_init,
     .abstract =3D true,
     .class_size =3D sizeof(DeviceClass),
+    .interfaces =3D (InterfaceInfo[]) {
+        { TYPE_COMPAT_PROPS },
+        { }
+    }
 };
=20
 static void qdev_register_types(void)
diff --git a/MAINTAINERS b/MAINTAINERS
index 0499e11593..60af287386 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1024,6 +1024,7 @@ Machine core
 M: Eduardo Habkost <ehabkost@redhat.com>
 M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
 S: Supported
+F: hw/core/compat-props.c
 F: hw/core/machine.c
 F: hw/core/null-machine.c
 F: include/hw/boards.h
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index a799c83815..f15b3c970a 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -1,5 +1,6 @@
 # core qdev-related obj files, also used by *-user:
 common-obj-y +=3D qdev.o qdev-properties.o
+common-obj-y +=3D compat-props.o
 common-obj-y +=3D bus.o reset.o
 common-obj-$(CONFIG_SOFTMMU) +=3D qdev-fw.o
 common-obj-$(CONFIG_SOFTMMU) +=3D fw-path-provider.o
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 074eece558..4bfde2e7b0 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -565,6 +565,7 @@ tests/test-qdev-global-props$(EXESUF): tests/test-qde=
v-global-props.o \
 	hw/core/irq.o \
 	hw/core/fw-path-provider.o \
 	hw/core/reset.o \
+	hw/core/compat-props.o \
 	$(test-qapi-obj-y)
 tests/test-vmstate$(EXESUF): tests/test-vmstate.o \
 	migration/vmstate.o migration/vmstate-types.o migration/qemu-file.o \
--=20
2.19.1.708.g4ede3d42df
