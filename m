Received: from eggs.gnu.org ([2001:4830:134:3::10]:51725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFfOJ-00046K-Cv
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 07:05:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFfOH-0006Xc-Us
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 07:05:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eFfOH-0006Wt-N3
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 07:05:01 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E4437C04AC5D
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 12:05:00 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 17 Nov 2017 13:04:52 +0100
Message-Id: <20171117120454.13507-3-kraxel@redhat.com>
In-Reply-To: <20171117120454.13507-1-kraxel@redhat.com>
References: <20171117120454.13507-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] ramfb: simple boot framebuffer living in
 guest ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?L=C3=A1szl=C3=B3=20=C3=89rsek?= <lersek@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

---
 include/hw/display/ramfb.h |  8 ++++
 hw/display/ramfb.c         | 94 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/display/Makefile.objs   |  2 +
 3 files changed, 104 insertions(+)
 create mode 100644 include/hw/display/ramfb.h
 create mode 100644 hw/display/ramfb.c

diff --git a/include/hw/display/ramfb.h b/include/hw/display/ramfb.h
new file mode 100644
index 0000000000..f3a772e99e
--- /dev/null
+++ b/include/hw/display/ramfb.h
@@ -0,0 +1,8 @@
+#ifndef RAMFB_H
+#define RAMFB_H
+
+typedef struct RAMFBState RAMFBState;
+void ramfb_display_update(QemuConsole *con, RAMFBState *s);
+RAMFBState *ramfb_setup(Error **errp);
+
+#endif /* RAMFB_H */
diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
new file mode 100644
index 0000000000..bed5964ed8
--- /dev/null
+++ b/hw/display/ramfb.c
@@ -0,0 +1,94 @@
+/*
+ * early boot framebuffer in guest ram
+ * configured using fw_cfg
+ *
+ * Copyright Red Hat, Inc. 2017
+ *
+ * Author:
+ *     Gerd Hoffmann <kraxel@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/loader.h"
+#include "hw/display/ramfb.h"
+#include "ui/console.h"
+#include "sysemu/sysemu.h"
+
+struct RAMFBCfg {
+    uint64_t addr;
+    uint32_t fourcc;
+    uint32_t flags;
+    uint32_t width;
+    uint32_t height;
+    uint32_t stride;
+};
+
+struct RAMFBState {
+    DisplaySurface *ds;
+    uint32_t width, height;
+    struct RAMFBCfg cfg;
+};
+
+static void ramfb_fw_cfg_write(void *dev, off_t offset, size_t len)
+{
+    RAMFBState *s = dev;
+    void *framebuffer;
+    uint32_t stride;
+    hwaddr addr, length;
+
+    s->width  = be32_to_cpu(s->cfg.width);
+    s->height = be32_to_cpu(s->cfg.height);
+    stride    = be32_to_cpu(s->cfg.stride);
+    addr      = be64_to_cpu(s->cfg.addr);
+    length    = stride * s->height;
+
+    fprintf(stderr, "%s: %dx%d @ 0x%" PRIx64 "\n", __func__,
+            s->width, s->height, addr);
+    framebuffer = address_space_map(&address_space_memory,
+                                    addr, &length, false);
+    if (!framebuffer || length < stride * s->height) {
+        s->width = 0;
+        s->height = 0;
+        return;
+    }
+    s->ds = qemu_create_displaysurface_from(s->width, s->height,
+                                            PIXMAN_x8r8g8b8 /* FIXME */,
+                                            stride, framebuffer);
+}
+
+void ramfb_display_update(QemuConsole *con, RAMFBState *s)
+{
+    if (!s->width || !s->height) {
+        return;
+    }
+
+    if (s->ds) {
+        dpy_gfx_replace_surface(con, s->ds);
+        s->ds = NULL;
+    }
+
+    /* simple full screen update */
+    dpy_gfx_update(con, 0, 0, s->width, s->height);
+}
+
+RAMFBState *ramfb_setup(Error **errp)
+{
+    FWCfgState *fw_cfg = fw_cfg_find();
+    RAMFBState *s;
+
+    if (!fw_cfg || !fw_cfg->dma_enabled) {
+        error_setg(errp, "ramfb device requires fw_cfg with DMA");
+        return NULL;
+    }
+
+    s = g_new0(RAMFBState, 1);
+
+    rom_add_vga("vgabios-ramfb.bin");
+    fw_cfg_add_file_callback(fw_cfg, "etc/ramfb",
+                             NULL, ramfb_fw_cfg_write, s,
+                             &s->cfg, sizeof(s->cfg), false);
+    return s;
+}
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index 551c050a6a..4e8ff48b55 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -1,3 +1,5 @@
+common-obj-y += ramfb.o
+
 common-obj-$(CONFIG_ADS7846) += ads7846.o
 common-obj-$(CONFIG_VGA_CIRRUS) += cirrus_vga.o
 common-obj-$(CONFIG_G364FB) += g364fb.o
-- 
2.9.3
