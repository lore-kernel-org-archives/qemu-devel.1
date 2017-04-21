Received: from eggs.gnu.org ([2001:4830:134:3::10]:35775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d1exx-0004Q7-HW
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 16:15:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d1exv-0002l0-KN
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 16:15:41 -0400
Received: from mail.kernel.org ([198.145.29.136]:43212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1d1exv-0002kw-Bw
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 16:15:39 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Fri, 21 Apr 2017 13:15:00 -0700
Message-Id: <1492805702-19690-19-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1492805702-19690-1-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1704211258580.18403@sstabellini-ThinkPad-X260>
	<1492805702-19690-1-git-send-email-sstabellini@kernel.org>
Subject: [Qemu-devel] [PULL 19/21] move xen-common.c to hw/xen/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: stefanha@gmail.com, sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Anthony Xu <anthony.xu@intel.com>

From: Anthony Xu <anthony.xu@intel.com>

move xen-common.c to hw/xen/

Signed-off -by: Anthony Xu <anthony.xu@intel.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 Makefile.target      |   2 -
 hw/xen/Makefile.objs |   2 +-
 hw/xen/xen-common.c  | 169 +++++++++++++++++++++++++++++++++++++++++++++++++++
 stubs/Makefile.objs  |   1 +
 stubs/xen-common.c   |  14 +++++
 xen-common-stub.c    |  14 -----
 xen-common.c         | 169 ---------------------------------------------------
 7 files changed, 185 insertions(+), 186 deletions(-)
 create mode 100644 hw/xen/xen-common.c
 create mode 100644 stubs/xen-common.c
 delete mode 100644 xen-common-stub.c
 delete mode 100644 xen-common.c

diff --git a/Makefile.target b/Makefile.target
index 7df2b8c..48c027f 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -150,9 +150,7 @@ obj-y += migration/ram.o migration/savevm.o
 LIBS := $(libs_softmmu) $(LIBS)
 
 # xen support
-obj-$(CONFIG_XEN) += xen-common.o
 obj-$(CONFIG_XEN_I386) += xen-hvm.o xen-mapcache.o
-obj-$(call lnot,$(CONFIG_XEN)) += xen-common-stub.o
 obj-$(call lnot,$(CONFIG_XEN_I386)) += xen-hvm-stub.o
 
 # Hardware support
diff --git a/hw/xen/Makefile.objs b/hw/xen/Makefile.objs
index 4be3ec9..64a70bc 100644
--- a/hw/xen/Makefile.objs
+++ b/hw/xen/Makefile.objs
@@ -1,5 +1,5 @@
 # xen backend driver support
-common-obj-$(CONFIG_XEN) += xen_backend.o xen_devconfig.o xen_pvdev.o
+common-obj-$(CONFIG_XEN) += xen_backend.o xen_devconfig.o xen_pvdev.o xen-common.o
 
 obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen-host-pci-device.o
 obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen_pt.o xen_pt_config_init.o xen_pt_graphics.o xen_pt_msi.o
diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
new file mode 100644
index 0000000..ae76150
--- /dev/null
+++ b/hw/xen/xen-common.c
@@ -0,0 +1,169 @@
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
+xc_interface *xen_xc;
+xenforeignmemory_handle *xen_fmem;
+xendevicemodel_handle *xen_dmod;
+
+static int store_dev_info(int domid, Chardev *cs, const char *string)
+{
+    struct xs_handle *xs = NULL;
+    char *path = NULL;
+    char *newpath = NULL;
+    char *pts = NULL;
+    int ret = -1;
+
+    /* Only continue if we're talking to a pty. */
+    if (strncmp(cs->filename, "pty:", 4)) {
+        return 0;
+    }
+    pts = cs->filename + 4;
+
+    /* We now have everything we need to set the xenstore entry. */
+    xs = xs_open(0);
+    if (xs == NULL) {
+        fprintf(stderr, "Could not contact XenStore\n");
+        goto out;
+    }
+
+    path = xs_get_domain_path(xs, domid);
+    if (path == NULL) {
+        fprintf(stderr, "xs_get_domain_path() error\n");
+        goto out;
+    }
+    newpath = realloc(path, (strlen(path) + strlen(string) +
+                strlen("/tty") + 1));
+    if (newpath == NULL) {
+        fprintf(stderr, "realloc error\n");
+        goto out;
+    }
+    path = newpath;
+
+    strcat(path, string);
+    strcat(path, "/tty");
+    if (!xs_write(xs, XBT_NULL, path, pts, strlen(pts))) {
+        fprintf(stderr, "xs_write for '%s' fail", string);
+        goto out;
+    }
+    ret = 0;
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
+    if (i == 0) {
+        store_dev_info(xen_domid, chr, "/console");
+    } else {
+        char buf[32];
+        snprintf(buf, sizeof(buf), "/device/console/%d", i);
+        store_dev_info(xen_domid, chr, buf);
+    }
+}
+
+
+static void xenstore_record_dm_state(struct xs_handle *xs, const char *state)
+{
+    char path[50];
+
+    if (xs == NULL) {
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
+    xen_xc = xc_interface_open(0, 0, 0);
+    if (xen_xc == NULL) {
+        xen_pv_printf(NULL, 0, "can't open xen interface\n");
+        return -1;
+    }
+    xen_fmem = xenforeignmemory_open(0, 0);
+    if (xen_fmem == NULL) {
+        xen_pv_printf(NULL, 0, "can't open xen fmem interface\n");
+        xc_interface_close(xen_xc);
+        return -1;
+    }
+    xen_dmod = xendevicemodel_open(0, 0);
+    if (xen_dmod == NULL) {
+        xen_pv_printf(NULL, 0, "can't open xen devicemodel interface\n");
+        xenforeignmemory_close(xen_fmem);
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
+    AccelClass *ac = ACCEL_CLASS(oc);
+    ac->name = "Xen";
+    ac->init_machine = xen_init;
+    ac->allowed = &xen_allowed;
+}
+
+#define TYPE_XEN_ACCEL ACCEL_CLASS_NAME("xen")
+
+static const TypeInfo xen_accel_type = {
+    .name = TYPE_XEN_ACCEL,
+    .parent = TYPE_ACCEL,
+    .class_init = xen_accel_class_init,
+};
+
+static void xen_type_init(void)
+{
+    type_register_static(&xen_accel_type);
+}
+
+type_init(xen_type_init);
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 224f04b..6c80613 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -37,3 +37,4 @@ stub-obj-y += target-monitor-defs.o
 stub-obj-y += target-get-monitor-def.o
 stub-obj-y += pc_madt_cpu_entry.o
 stub-obj-y += vmgenid.o
+stub-obj-y += xen-common.o
diff --git a/stubs/xen-common.c b/stubs/xen-common.c
new file mode 100644
index 0000000..09fce2d
--- /dev/null
+++ b/stubs/xen-common.c
@@ -0,0 +1,14 @@
+/*
+ * Copyright (C) 2014       Citrix Systems UK Ltd.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
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
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
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
index ae76150..0000000
--- a/xen-common.c
+++ /dev/null
@@ -1,169 +0,0 @@
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
-xc_interface *xen_xc;
-xenforeignmemory_handle *xen_fmem;
-xendevicemodel_handle *xen_dmod;
-
-static int store_dev_info(int domid, Chardev *cs, const char *string)
-{
-    struct xs_handle *xs = NULL;
-    char *path = NULL;
-    char *newpath = NULL;
-    char *pts = NULL;
-    int ret = -1;
-
-    /* Only continue if we're talking to a pty. */
-    if (strncmp(cs->filename, "pty:", 4)) {
-        return 0;
-    }
-    pts = cs->filename + 4;
-
-    /* We now have everything we need to set the xenstore entry. */
-    xs = xs_open(0);
-    if (xs == NULL) {
-        fprintf(stderr, "Could not contact XenStore\n");
-        goto out;
-    }
-
-    path = xs_get_domain_path(xs, domid);
-    if (path == NULL) {
-        fprintf(stderr, "xs_get_domain_path() error\n");
-        goto out;
-    }
-    newpath = realloc(path, (strlen(path) + strlen(string) +
-                strlen("/tty") + 1));
-    if (newpath == NULL) {
-        fprintf(stderr, "realloc error\n");
-        goto out;
-    }
-    path = newpath;
-
-    strcat(path, string);
-    strcat(path, "/tty");
-    if (!xs_write(xs, XBT_NULL, path, pts, strlen(pts))) {
-        fprintf(stderr, "xs_write for '%s' fail", string);
-        goto out;
-    }
-    ret = 0;
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
-    if (i == 0) {
-        store_dev_info(xen_domid, chr, "/console");
-    } else {
-        char buf[32];
-        snprintf(buf, sizeof(buf), "/device/console/%d", i);
-        store_dev_info(xen_domid, chr, buf);
-    }
-}
-
-
-static void xenstore_record_dm_state(struct xs_handle *xs, const char *state)
-{
-    char path[50];
-
-    if (xs == NULL) {
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
-    xen_xc = xc_interface_open(0, 0, 0);
-    if (xen_xc == NULL) {
-        xen_pv_printf(NULL, 0, "can't open xen interface\n");
-        return -1;
-    }
-    xen_fmem = xenforeignmemory_open(0, 0);
-    if (xen_fmem == NULL) {
-        xen_pv_printf(NULL, 0, "can't open xen fmem interface\n");
-        xc_interface_close(xen_xc);
-        return -1;
-    }
-    xen_dmod = xendevicemodel_open(0, 0);
-    if (xen_dmod == NULL) {
-        xen_pv_printf(NULL, 0, "can't open xen devicemodel interface\n");
-        xenforeignmemory_close(xen_fmem);
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
-    AccelClass *ac = ACCEL_CLASS(oc);
-    ac->name = "Xen";
-    ac->init_machine = xen_init;
-    ac->allowed = &xen_allowed;
-}
-
-#define TYPE_XEN_ACCEL ACCEL_CLASS_NAME("xen")
-
-static const TypeInfo xen_accel_type = {
-    .name = TYPE_XEN_ACCEL,
-    .parent = TYPE_ACCEL,
-    .class_init = xen_accel_class_init,
-};
-
-static void xen_type_init(void)
-{
-    type_register_static(&xen_accel_type);
-}
-
-type_init(xen_type_init);
-- 
1.9.1
