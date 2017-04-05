Received: from eggs.gnu.org ([2001:4830:134:3::10]:41380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cvpqT-0005ti-UZ
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 14:39:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cvpqP-0000A9-Rg
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 14:39:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:17095)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1cvpqP-00009q-F1
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 14:39:49 -0400
From: "Xu, Anthony" <anthony.xu@intel.com>
Date: Wed, 5 Apr 2017 18:39:46 +0000
Message-ID: <4712D8F4B26E034E80552F30A67BE0B1A4F5DD@ORSMSX112.amr.corp.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel]  [PATCH 1/3] move xen-common.c to hw/xen/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>
Cc: "sstabellini@kernel.org" <sstabellini@kernel.org>, "anthony.perard@citrix.com" <anthony.perard@citrix.com>, 'Paolo Bonzini' <pbonzini@redhat.com>

move xen-common.c to hw/xen/


Signed-off -by: Anthony Xu <anthony.xu@intel.com>



---
 hw/xen/xen-common.c | 158 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 stubs/xen-common.c  |  14 +++++
 xen-common-stub.c   |  14 -----
 xen-common.c        | 158 ------------------------------------------------=
----
 4 files changed, 172 insertions(+), 172 deletions(-)
 create mode 100644 hw/xen/xen-common.c
 create mode 100644 stubs/xen-common.c
 delete mode 100644 xen-common-stub.c
 delete mode 100644 xen-common.c

diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
new file mode 100644
index 0000000..fd2c928
--- /dev/null
+++ b/hw/xen/xen-common.c
@@ -0,0 +1,158 @@
+/*
+ * Copyright (C) 2014       Citrix Systems UK Ltd.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * Contributions after 2012-01-13 are licensed under the terms of the
+ * GNU GPL, version 2 or (at your option) any later version.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/xen/xen_backend.h"
+#include "qmp-commands.h"
+#include "sysemu/char.h"
+#include "sysemu/accel.h"
+#include "migration/migration.h"
+
+//#define DEBUG_XEN
+
+#ifdef DEBUG_XEN
+#define DPRINTF(fmt, ...) \
+    do { fprintf(stderr, "xen: " fmt, ## __VA_ARGS__); } while (0)
+#else
+#define DPRINTF(fmt, ...) \
+    do { } while (0)
+#endif
+
+static int store_dev_info(int domid, Chardev *cs, const char *string)
+{
+    struct xs_handle *xs =3D NULL;
+    char *path =3D NULL;
+    char *newpath =3D NULL;
+    char *pts =3D NULL;
+    int ret =3D -1;
+
+    /* Only continue if we're talking to a pty. */
+    if (strncmp(cs->filename, "pty:", 4)) {
+        return 0;
+    }
+    pts =3D cs->filename + 4;
+
+    /* We now have everything we need to set the xenstore entry. */
+    xs =3D xs_open(0);
+    if (xs =3D=3D NULL) {
+        fprintf(stderr, "Could not contact XenStore\n");
+        goto out;
+    }
+
+    path =3D xs_get_domain_path(xs, domid);
+    if (path =3D=3D NULL) {
+        fprintf(stderr, "xs_get_domain_path() error\n");
+        goto out;
+    }
+    newpath =3D realloc(path, (strlen(path) + strlen(string) +
+                strlen("/tty") + 1));
+    if (newpath =3D=3D NULL) {
+        fprintf(stderr, "realloc error\n");
+        goto out;
+    }
+    path =3D newpath;
+
+    strcat(path, string);
+    strcat(path, "/tty");
+    if (!xs_write(xs, XBT_NULL, path, pts, strlen(pts))) {
+        fprintf(stderr, "xs_write for '%s' fail", string);
+        goto out;
+    }
+    ret =3D 0;
+
+out:
+    free(path);
+    xs_close(xs);
+
+    return ret;
+}
+
+void xenstore_store_pv_console_info(int i, Chardev *chr)
+{
+    if (i =3D=3D 0) {
+        store_dev_info(xen_domid, chr, "/console");
+    } else {
+        char buf[32];
+        snprintf(buf, sizeof(buf), "/device/console/%d", i);
+        store_dev_info(xen_domid, chr, buf);
+    }
+}
+
+
+static void xenstore_record_dm_state(struct xs_handle *xs, const char *sta=
te)
+{
+    char path[50];
+
+    if (xs =3D=3D NULL) {
+        fprintf(stderr, "xenstore connection not initialized\n");
+        exit(1);
+    }
+
+    snprintf(path, sizeof (path), "device-model/%u/state", xen_domid);
+    if (!xs_write(xs, XBT_NULL, path, state, strlen(state))) {
+        fprintf(stderr, "error recording dm state\n");
+        exit(1);
+    }
+}
+
+
+static void xen_change_state_handler(void *opaque, int running,
+                                     RunState state)
+{
+    if (running) {
+        /* record state running */
+        xenstore_record_dm_state(xenstore, "running");
+    }
+}
+
+static int xen_init(MachineState *ms)
+{
+    xen_xc =3D xc_interface_open(0, 0, 0);
+    if (xen_xc =3D=3D NULL) {
+        xen_pv_printf(NULL, 0, "can't open xen interface\n");
+        return -1;
+    }
+    xen_fmem =3D xenforeignmemory_open(0, 0);
+    if (xen_fmem =3D=3D NULL) {
+        xen_pv_printf(NULL, 0, "can't open xen fmem interface\n");
+        xc_interface_close(xen_xc);
+        return -1;
+    }
+    qemu_add_vm_change_state_handler(xen_change_state_handler, NULL);
+
+    global_state_set_optional();
+    savevm_skip_configuration();
+    savevm_skip_section_footers();
+
+    return 0;
+}
+
+static void xen_accel_class_init(ObjectClass *oc, void *data)
+{
+    AccelClass *ac =3D ACCEL_CLASS(oc);
+    ac->name =3D "Xen";
+    ac->init_machine =3D xen_init;
+    ac->allowed =3D &xen_allowed;
+}
+
+#define TYPE_XEN_ACCEL ACCEL_CLASS_NAME("xen")
+
+static const TypeInfo xen_accel_type =3D {
+    .name =3D TYPE_XEN_ACCEL,
+    .parent =3D TYPE_ACCEL,
+    .class_init =3D xen_accel_class_init,
+};
+
+static void xen_type_init(void)
+{
+    type_register_static(&xen_accel_type);
+}
+
+type_init(xen_type_init);
diff --git a/stubs/xen-common.c b/stubs/xen-common.c
new file mode 100644
index 0000000..09fce2d
--- /dev/null
+++ b/stubs/xen-common.c
@@ -0,0 +1,14 @@
+/*
+ * Copyright (C) 2014       Citrix Systems UK Ltd.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "hw/xen/xen.h"
+
+void xenstore_store_pv_console_info(int i, Chardev *chr)
+{
+}
diff --git a/xen-common-stub.c b/xen-common-stub.c
deleted file mode 100644
index 09fce2d..0000000
--- a/xen-common-stub.c
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * Copyright (C) 2014       Citrix Systems UK Ltd.
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
- * See the COPYING file in the top-level directory.
- */
-
-#include "qemu/osdep.h"
-#include "qemu-common.h"
-#include "hw/xen/xen.h"
-
-void xenstore_store_pv_console_info(int i, Chardev *chr)
-{
-}
diff --git a/xen-common.c b/xen-common.c
deleted file mode 100644
index fd2c928..0000000
--- a/xen-common.c
+++ /dev/null
@@ -1,158 +0,0 @@
-/*
- * Copyright (C) 2014       Citrix Systems UK Ltd.
- *
- * This work is licensed under the terms of the GNU GPL, version 2.  See
- * the COPYING file in the top-level directory.
- *
- * Contributions after 2012-01-13 are licensed under the terms of the
- * GNU GPL, version 2 or (at your option) any later version.
- */
-
-#include "qemu/osdep.h"
-#include "hw/xen/xen_backend.h"
-#include "qmp-commands.h"
-#include "sysemu/char.h"
-#include "sysemu/accel.h"
-#include "migration/migration.h"
-
-//#define DEBUG_XEN
-
-#ifdef DEBUG_XEN
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, "xen: " fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
-
-static int store_dev_info(int domid, Chardev *cs, const char *string)
-{
-    struct xs_handle *xs =3D NULL;
-    char *path =3D NULL;
-    char *newpath =3D NULL;
-    char *pts =3D NULL;
-    int ret =3D -1;
-
-    /* Only continue if we're talking to a pty. */
-    if (strncmp(cs->filename, "pty:", 4)) {
-        return 0;
-    }
-    pts =3D cs->filename + 4;
-
-    /* We now have everything we need to set the xenstore entry. */
-    xs =3D xs_open(0);
-    if (xs =3D=3D NULL) {
-        fprintf(stderr, "Could not contact XenStore\n");
-        goto out;
-    }
-
-    path =3D xs_get_domain_path(xs, domid);
-    if (path =3D=3D NULL) {
-        fprintf(stderr, "xs_get_domain_path() error\n");
-        goto out;
-    }
-    newpath =3D realloc(path, (strlen(path) + strlen(string) +
-                strlen("/tty") + 1));
-    if (newpath =3D=3D NULL) {
-        fprintf(stderr, "realloc error\n");
-        goto out;
-    }
-    path =3D newpath;
-
-    strcat(path, string);
-    strcat(path, "/tty");
-    if (!xs_write(xs, XBT_NULL, path, pts, strlen(pts))) {
-        fprintf(stderr, "xs_write for '%s' fail", string);
-        goto out;
-    }
-    ret =3D 0;
-
-out:
-    free(path);
-    xs_close(xs);
-
-    return ret;
-}
-
-void xenstore_store_pv_console_info(int i, Chardev *chr)
-{
-    if (i =3D=3D 0) {
-        store_dev_info(xen_domid, chr, "/console");
-    } else {
-        char buf[32];
-        snprintf(buf, sizeof(buf), "/device/console/%d", i);
-        store_dev_info(xen_domid, chr, buf);
-    }
-}
-
-
-static void xenstore_record_dm_state(struct xs_handle *xs, const char *sta=
te)
-{
-    char path[50];
-
-    if (xs =3D=3D NULL) {
-        fprintf(stderr, "xenstore connection not initialized\n");
-        exit(1);
-    }
-
-    snprintf(path, sizeof (path), "device-model/%u/state", xen_domid);
-    if (!xs_write(xs, XBT_NULL, path, state, strlen(state))) {
-        fprintf(stderr, "error recording dm state\n");
-        exit(1);
-    }
-}
-
-
-static void xen_change_state_handler(void *opaque, int running,
-                                     RunState state)
-{
-    if (running) {
-        /* record state running */
-        xenstore_record_dm_state(xenstore, "running");
-    }
-}
-
-static int xen_init(MachineState *ms)
-{
-    xen_xc =3D xc_interface_open(0, 0, 0);
-    if (xen_xc =3D=3D NULL) {
-        xen_pv_printf(NULL, 0, "can't open xen interface\n");
-        return -1;
-    }
-    xen_fmem =3D xenforeignmemory_open(0, 0);
-    if (xen_fmem =3D=3D NULL) {
-        xen_pv_printf(NULL, 0, "can't open xen fmem interface\n");
-        xc_interface_close(xen_xc);
-        return -1;
-    }
-    qemu_add_vm_change_state_handler(xen_change_state_handler, NULL);
-
-    global_state_set_optional();
-    savevm_skip_configuration();
-    savevm_skip_section_footers();
-
-    return 0;
-}
-
-static void xen_accel_class_init(ObjectClass *oc, void *data)
-{
-    AccelClass *ac =3D ACCEL_CLASS(oc);
-    ac->name =3D "Xen";
-    ac->init_machine =3D xen_init;
-    ac->allowed =3D &xen_allowed;
-}
-
-#define TYPE_XEN_ACCEL ACCEL_CLASS_NAME("xen")
-
-static const TypeInfo xen_accel_type =3D {
-    .name =3D TYPE_XEN_ACCEL,
-    .parent =3D TYPE_ACCEL,
-    .class_init =3D xen_accel_class_init,
-};
-
-static void xen_type_init(void)
-{
-    type_register_static(&xen_accel_type);
-}
-
-type_init(xen_type_init);
--=20
1.8.3.1
