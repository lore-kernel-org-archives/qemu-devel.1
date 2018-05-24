Received: from eggs.gnu.org ([2001:4830:134:3::10]:52843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fLsRG-0000LU-OA
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:46:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fLsRC-0002zy-Tk
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:46:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34678 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fLsRC-0002zO-Oe
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:45:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CC221401EF00
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 15:45:57 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 24 May 2018 17:45:51 +0200
Message-Id: <20180524154556.17876-3-kraxel@redhat.com>
In-Reply-To: <20180524154556.17876-1-kraxel@redhat.com>
References: <20180524154556.17876-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/7] vga: move bochs vbe defines to header file
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
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20180522165058.15404-2-kraxel@redhat.com
---
 hw/display/vga_int.h           | 35 ++-------------------
 include/hw/display/bochs-vbe.h | 69 ++++++++++++++++++++++++++++++++++++=
++++++
 hw/display/vga-pci.c           | 13 --------
 3 files changed, 71 insertions(+), 46 deletions(-)
 create mode 100644 include/hw/display/bochs-vbe.h

diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
index fe23b81442..313cff84fc 100644
--- a/hw/display/vga_int.h
+++ b/hw/display/vga_int.h
@@ -29,42 +29,11 @@
 #include "exec/memory.h"
 #include "ui/console.h"
=20
+#include "hw/display/bochs-vbe.h"
+
 #define ST01_V_RETRACE      0x08
 #define ST01_DISP_ENABLE    0x01
=20
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
-#define VBE_DISPI_INDEX_VIDEO_MEMORY_64K 0xa /* read-only, not in vbe_re=
gs */
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
=20
diff --git a/include/hw/display/bochs-vbe.h b/include/hw/display/bochs-vb=
e.h
new file mode 100644
index 0000000000..bc2f046eee
--- /dev/null
+++ b/include/hw/display/bochs-vbe.h
@@ -0,0 +1,69 @@
+#ifndef HW_DISPLAY_BOCHS_VBE_H
+#define HW_DISPLAY_BOCHS_VBE_H
+
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
+#define VBE_DISPI_INDEX_VIDEO_MEMORY_64K 0xa /* read-only, not in vbe_re=
gs */
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
+
+#endif /* HW_DISPLAY_BOCHS_VBE_H */
diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index f312930664..fb3e4cd400 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -31,19 +31,6 @@
 #include "qemu/timer.h"
 #include "hw/loader.h"
=20
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
     PCI_VGA_FLAG_ENABLE_MMIO =3D 1,
     PCI_VGA_FLAG_ENABLE_QEXT =3D 2,
--=20
2.9.3
