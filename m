Received: from eggs.gnu.org ([2001:4830:134:3::10]:36080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJFA1-0006Oq-Kf
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:25:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJF9x-0004Y3-Fn
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:25:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43730 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fJF9x-0004Wy-3J
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:25:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B695DBB422
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 09:25:16 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 17 May 2018 11:25:10 +0200
Message-Id: <20180517092513.735-2-kraxel@redhat.com>
In-Reply-To: <20180517092513.735-1-kraxel@redhat.com>
References: <20180517092513.735-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] vga: move bochs vbe defines to header file
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

Create a new header file, move the bochs vbe dispi interface
defines to it, so they can be used outside vga code.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/vga_int.h           | 35 ++---------------------
 include/hw/display/bochs-vbe.h | 64 ++++++++++++++++++++++++++++++++++++++++++
 hw/display/vga-pci.c           | 13 ---------
 3 files changed, 66 insertions(+), 46 deletions(-)
 create mode 100644 include/hw/display/bochs-vbe.h

diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
index fe23b81442..313cff84fc 100644
--- a/hw/display/vga_int.h
+++ b/hw/display/vga_int.h
@@ -29,42 +29,11 @@
 #include "exec/memory.h"
 #include "ui/console.h"
 
+#include "hw/display/bochs-vbe.h"
+
 #define ST01_V_RETRACE      0x08
 #define ST01_DISP_ENABLE    0x01
 
-#define VBE_DISPI_MAX_XRES              16000
-#define VBE_DISPI_MAX_YRES              12000
-#define VBE_DISPI_MAX_BPP               32
-
-#define VBE_DISPI_INDEX_ID              0x0
-#define VBE_DISPI_INDEX_XRES            0x1
-#define VBE_DISPI_INDEX_YRES            0x2
-#define VBE_DISPI_INDEX_BPP             0x3
-#define VBE_DISPI_INDEX_ENABLE          0x4
-#define VBE_DISPI_INDEX_BANK            0x5
-#define VBE_DISPI_INDEX_VIRT_WIDTH      0x6
-#define VBE_DISPI_INDEX_VIRT_HEIGHT     0x7
-#define VBE_DISPI_INDEX_X_OFFSET        0x8
-#define VBE_DISPI_INDEX_Y_OFFSET        0x9
-#define VBE_DISPI_INDEX_NB              0xa /* size of vbe_regs[] */
-#define VBE_DISPI_INDEX_VIDEO_MEMORY_64K 0xa /* read-only, not in vbe_regs */
-
-#define VBE_DISPI_ID0                   0xB0C0
-#define VBE_DISPI_ID1                   0xB0C1
-#define VBE_DISPI_ID2                   0xB0C2
-#define VBE_DISPI_ID3                   0xB0C3
-#define VBE_DISPI_ID4                   0xB0C4
-#define VBE_DISPI_ID5                   0xB0C5
-
-#define VBE_DISPI_DISABLED              0x00
-#define VBE_DISPI_ENABLED               0x01
-#define VBE_DISPI_GETCAPS               0x02
-#define VBE_DISPI_8BIT_DAC              0x20
-#define VBE_DISPI_LFB_ENABLED           0x40
-#define VBE_DISPI_NOCLEARMEM            0x80
-
-#define VBE_DISPI_LFB_PHYSICAL_ADDRESS  0xE0000000
-
 #define CH_ATTR_SIZE (160 * 100)
 #define VGA_MAX_HEIGHT 2048
 
diff --git a/include/hw/display/bochs-vbe.h b/include/hw/display/bochs-vbe.h
new file mode 100644
index 0000000000..6f27ed4a91
--- /dev/null
+++ b/include/hw/display/bochs-vbe.h
@@ -0,0 +1,64 @@
+/*
+ * bochs vesa bios extension interface
+ */
+
+#define VBE_DISPI_MAX_XRES              16000
+#define VBE_DISPI_MAX_YRES              12000
+#define VBE_DISPI_MAX_BPP               32
+
+#define VBE_DISPI_INDEX_ID              0x0
+#define VBE_DISPI_INDEX_XRES            0x1
+#define VBE_DISPI_INDEX_YRES            0x2
+#define VBE_DISPI_INDEX_BPP             0x3
+#define VBE_DISPI_INDEX_ENABLE          0x4
+#define VBE_DISPI_INDEX_BANK            0x5
+#define VBE_DISPI_INDEX_VIRT_WIDTH      0x6
+#define VBE_DISPI_INDEX_VIRT_HEIGHT     0x7
+#define VBE_DISPI_INDEX_X_OFFSET        0x8
+#define VBE_DISPI_INDEX_Y_OFFSET        0x9
+#define VBE_DISPI_INDEX_NB              0xa /* size of vbe_regs[] */
+#define VBE_DISPI_INDEX_VIDEO_MEMORY_64K 0xa /* read-only, not in vbe_regs */
+
+/* VBE_DISPI_INDEX_ID */
+#define VBE_DISPI_ID0                   0xB0C0
+#define VBE_DISPI_ID1                   0xB0C1
+#define VBE_DISPI_ID2                   0xB0C2
+#define VBE_DISPI_ID3                   0xB0C3
+#define VBE_DISPI_ID4                   0xB0C4
+#define VBE_DISPI_ID5                   0xB0C5
+
+/* VBE_DISPI_INDEX_ENABLE */
+#define VBE_DISPI_DISABLED              0x00
+#define VBE_DISPI_ENABLED               0x01
+#define VBE_DISPI_GETCAPS               0x02
+#define VBE_DISPI_8BIT_DAC              0x20
+#define VBE_DISPI_LFB_ENABLED           0x40
+#define VBE_DISPI_NOCLEARMEM            0x80
+
+/* only used by isa-vga, pci vga devices use a memory bar */
+#define VBE_DISPI_LFB_PHYSICAL_ADDRESS  0xE0000000
+
+
+/*
+ * qemu extension: mmio bar (region 2)
+ */
+
+#define PCI_VGA_MMIO_SIZE     0x1000
+
+/* vga register region */
+#define PCI_VGA_IOPORT_OFFSET 0x400
+#define PCI_VGA_IOPORT_SIZE   (0x3e0 - 0x3c0)
+
+/* bochs vbe register region */
+#define PCI_VGA_BOCHS_OFFSET  0x500
+#define PCI_VGA_BOCHS_SIZE    (0x0b * 2)
+
+/* qemu extension register region */
+#define PCI_VGA_QEXT_OFFSET   0x600
+#define PCI_VGA_QEXT_SIZE     (2 * 4)
+
+/* qemu extension registers */
+#define PCI_VGA_QEXT_REG_SIZE         (0 * 4)
+#define PCI_VGA_QEXT_REG_BYTEORDER    (1 * 4)
+#define  PCI_VGA_QEXT_LITTLE_ENDIAN   0x1e1e1e1e
+#define  PCI_VGA_QEXT_BIG_ENDIAN      0xbebebebe
diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index f312930664..fb3e4cd400 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -31,19 +31,6 @@
 #include "qemu/timer.h"
 #include "hw/loader.h"
 
-#define PCI_VGA_IOPORT_OFFSET 0x400
-#define PCI_VGA_IOPORT_SIZE   (0x3e0 - 0x3c0)
-#define PCI_VGA_BOCHS_OFFSET  0x500
-#define PCI_VGA_BOCHS_SIZE    (0x0b * 2)
-#define PCI_VGA_QEXT_OFFSET   0x600
-#define PCI_VGA_QEXT_SIZE     (2 * 4)
-#define PCI_VGA_MMIO_SIZE     0x1000
-
-#define PCI_VGA_QEXT_REG_SIZE         (0 * 4)
-#define PCI_VGA_QEXT_REG_BYTEORDER    (1 * 4)
-#define  PCI_VGA_QEXT_LITTLE_ENDIAN   0x1e1e1e1e
-#define  PCI_VGA_QEXT_BIG_ENDIAN      0xbebebebe
-
 enum vga_pci_flags {
     PCI_VGA_FLAG_ENABLE_MMIO = 1,
     PCI_VGA_FLAG_ENABLE_QEXT = 2,
-- 
2.9.3
