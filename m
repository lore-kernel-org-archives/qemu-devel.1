Received: from eggs.gnu.org ([2001:4830:134:3::10]:55488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g04OT-0005Q2-ET
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:37:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g04OQ-0006pY-98
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:37:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g04OQ-0006nz-36
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:37:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BD3C93002738
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 12:37:12 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 12 Sep 2018 14:36:59 +0200
Message-Id: <20180912123700.7708-2-kraxel@redhat.com>
In-Reply-To: <20180912123700.7708-1-kraxel@redhat.com>
References: <20180912123700.7708-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] display/edid: add region helper.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Create a io region for an EDID data block.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/display/edid.h |  4 ++++
 hw/display/edid-region.c  | 33 +++++++++++++++++++++++++++++++++
 hw/display/Makefile.objs  |  1 +
 3 files changed, 38 insertions(+)
 create mode 100644 hw/display/edid-region.c

diff --git a/include/hw/display/edid.h b/include/hw/display/edid.h
index 63b60015c3..c39d5cd77b 100644
--- a/include/hw/display/edid.h
+++ b/include/hw/display/edid.h
@@ -1,6 +1,8 @@
 #ifndef EDID_H
 #define EDID_H
 
+#include "hw/hw.h"
+
 typedef struct qemu_edid_info {
     const char *vendor;
     const char *name;
@@ -14,5 +16,7 @@ typedef struct qemu_edid_info {
 
 void qemu_edid_generate(uint8_t *edid, size_t size,
                         qemu_edid_info *info);
+void qemu_edid_region_io(MemoryRegion *region, Object *owner,
+                         uint8_t *edid, size_t size);
 
 #endif /* EDID_H */
diff --git a/hw/display/edid-region.c b/hw/display/edid-region.c
new file mode 100644
index 0000000000..9a15734d3a
--- /dev/null
+++ b/hw/display/edid-region.c
@@ -0,0 +1,33 @@
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "hw/display/edid.h"
+
+static uint64_t edid_region_read(void *ptr, hwaddr addr, unsigned size)
+{
+    uint8_t *edid = ptr;
+
+    return edid[addr];
+}
+
+static void edid_region_write(void *ptr, hwaddr addr,
+                             uint64_t val, unsigned size)
+{
+    /* read only */
+}
+
+static const MemoryRegionOps edid_region_ops = {
+    .read = edid_region_read,
+    .write = edid_region_write,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+    .impl.min_access_size = 1,
+    .impl.max_access_size = 1,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+void qemu_edid_region_io(MemoryRegion *region, Object *owner,
+                         uint8_t *edid, size_t size)
+{
+    memory_region_init_io(region, owner, &edid_region_ops,
+                          edid, "edid", size);
+}
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index 492404c09e..780a76b9f0 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -15,6 +15,7 @@ common-obj-$(CONFIG_XEN) += xenfb.o
 
 common-obj-$(CONFIG_VGA_PCI) += vga-pci.o
 common-obj-$(CONFIG_VGA_PCI) += bochs-display.o
+common-obj-$(CONFIG_VGA_PCI) += edid-region.o
 common-obj-$(CONFIG_VGA_ISA) += vga-isa.o
 common-obj-$(CONFIG_VGA_ISA_MM) += vga-isa-mm.o
 common-obj-$(CONFIG_VMWARE_VGA) += vmware_vga.o
-- 
2.9.3
