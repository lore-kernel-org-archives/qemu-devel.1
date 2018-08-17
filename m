Received: from eggs.gnu.org ([2001:4830:134:3::10]:41057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fqhNz-0000Hz-Kr
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:14:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fqh9u-0005vQ-3S
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:59:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47786 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fqh9t-0005tV-Tz
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:59:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9CD52407048B
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 15:59:29 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 17 Aug 2018 17:59:10 +0200
Message-Id: <20180817155910.5722-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180817155910.5722-1-marcandre.lureau@redhat.com>
References: <20180817155910.5722-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] fw_cfg: import & use linux/qemu_fw_cfg.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Use kernel common header for fw_cfg.

(unfortunately, optionrom.h must have its own define, since it's
actually an assembler header)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/misc/vmcoreinfo.h                 | 12 +--
 include/hw/nvram/fw_cfg.h                    | 18 +---
 include/hw/nvram/fw_cfg_keys.h               | 45 ---------
 include/standard-headers/linux/qemu_fw_cfg.h | 97 ++++++++++++++++++++
 pc-bios/optionrom/optionrom.h                | 15 ++-
 dump.c                                       |  2 +-
 hw/misc/vmcoreinfo.c                         |  6 +-
 pc-bios/optionrom/linuxboot_dma.c            |  4 +-
 tests/boot-order-test.c                      |  2 +-
 tests/fw_cfg-test.c                          |  2 +-
 tests/libqos/malloc-pc.c                     |  2 +-
 11 files changed, 125 insertions(+), 80 deletions(-)
 delete mode 100644 include/hw/nvram/fw_cfg_keys.h
 create mode 100644 include/standard-headers/linux/qemu_fw_cfg.h

diff --git a/include/hw/misc/vmcoreinfo.h b/include/hw/misc/vmcoreinfo.h
index c3aa856545..0d11578059 100644
--- a/include/hw/misc/vmcoreinfo.h
+++ b/include/hw/misc/vmcoreinfo.h
@@ -13,20 +13,12 @@
 #define VMCOREINFO_H
=20
 #include "hw/qdev.h"
+#include "standard-headers/linux/qemu_fw_cfg.h"
=20
 #define VMCOREINFO_DEVICE "vmcoreinfo"
 #define VMCOREINFO(obj) OBJECT_CHECK(VMCoreInfoState, (obj), VMCOREINFO_=
DEVICE)
=20
-#define VMCOREINFO_FORMAT_NONE 0x0
-#define VMCOREINFO_FORMAT_ELF 0x1
-
-/* all fields are little-endian */
-typedef struct FWCfgVMCoreInfo {
-    uint16_t host_format; /* set on reset */
-    uint16_t guest_format;
-    uint32_t size;
-    uint64_t paddr;
-} QEMU_PACKED FWCfgVMCoreInfo;
+typedef struct fw_cfg_vmcoreinfo FWCfgVMCoreInfo;
=20
 typedef struct VMCoreInfoState {
     DeviceClass parent_obj;
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index b2259cc4a3..f5a6895a74 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -2,7 +2,7 @@
 #define FW_CFG_H
=20
 #include "exec/hwaddr.h"
-#include "hw/nvram/fw_cfg_keys.h"
+#include "standard-headers/linux/qemu_fw_cfg.h"
 #include "hw/sysbus.h"
 #include "sysemu/dma.h"
=20
@@ -14,12 +14,7 @@
 #define FW_CFG_IO(obj)  OBJECT_CHECK(FWCfgIoState,  (obj), TYPE_FW_CFG_I=
O)
 #define FW_CFG_MEM(obj) OBJECT_CHECK(FWCfgMemState, (obj), TYPE_FW_CFG_M=
EM)
=20
-typedef struct FWCfgFile {
-    uint32_t  size;        /* file size */
-    uint16_t  select;      /* write this to 0x510 to read it */
-    uint16_t  reserved;
-    char      name[FW_CFG_MAX_FILE_PATH];
-} FWCfgFile;
+typedef struct fw_cfg_file FWCfgFile;
=20
 #define FW_CFG_ORDER_OVERRIDE_VGA    70
 #define FW_CFG_ORDER_OVERRIDE_NIC    80
@@ -34,14 +29,7 @@ typedef struct FWCfgFiles {
     FWCfgFile f[];
 } FWCfgFiles;
=20
-/* Control as first field allows for different structures selected by th=
is
- * field, which might be useful in the future
- */
-typedef struct FWCfgDmaAccess {
-    uint32_t control;
-    uint32_t length;
-    uint64_t address;
-} QEMU_PACKED FWCfgDmaAccess;
+typedef struct fw_cfg_dma_access FWCfgDmaAccess;
=20
 typedef void (*FWCfgCallback)(void *opaque);
 typedef void (*FWCfgWriteCallback)(void *opaque, off_t start, size_t len=
);
diff --git a/include/hw/nvram/fw_cfg_keys.h b/include/hw/nvram/fw_cfg_key=
s.h
deleted file mode 100644
index b6919451f5..0000000000
--- a/include/hw/nvram/fw_cfg_keys.h
+++ /dev/null
@@ -1,45 +0,0 @@
-#ifndef FW_CFG_KEYS_H
-#define FW_CFG_KEYS_H
-
-#define FW_CFG_SIGNATURE        0x00
-#define FW_CFG_ID               0x01
-#define FW_CFG_UUID             0x02
-#define FW_CFG_RAM_SIZE         0x03
-#define FW_CFG_NOGRAPHIC        0x04
-#define FW_CFG_NB_CPUS          0x05
-#define FW_CFG_MACHINE_ID       0x06
-#define FW_CFG_KERNEL_ADDR      0x07
-#define FW_CFG_KERNEL_SIZE      0x08
-#define FW_CFG_KERNEL_CMDLINE   0x09
-#define FW_CFG_INITRD_ADDR      0x0a
-#define FW_CFG_INITRD_SIZE      0x0b
-#define FW_CFG_BOOT_DEVICE      0x0c
-#define FW_CFG_NUMA             0x0d
-#define FW_CFG_BOOT_MENU        0x0e
-#define FW_CFG_MAX_CPUS         0x0f
-#define FW_CFG_KERNEL_ENTRY     0x10
-#define FW_CFG_KERNEL_DATA      0x11
-#define FW_CFG_INITRD_DATA      0x12
-#define FW_CFG_CMDLINE_ADDR     0x13
-#define FW_CFG_CMDLINE_SIZE     0x14
-#define FW_CFG_CMDLINE_DATA     0x15
-#define FW_CFG_SETUP_ADDR       0x16
-#define FW_CFG_SETUP_SIZE       0x17
-#define FW_CFG_SETUP_DATA       0x18
-#define FW_CFG_FILE_DIR         0x19
-
-#define FW_CFG_FILE_FIRST       0x20
-#define FW_CFG_FILE_SLOTS_MIN   0x10
-
-#define FW_CFG_WRITE_CHANNEL    0x4000
-#define FW_CFG_ARCH_LOCAL       0x8000
-#define FW_CFG_ENTRY_MASK       (~(FW_CFG_WRITE_CHANNEL | FW_CFG_ARCH_LO=
CAL))
-
-#define FW_CFG_INVALID          0xffff
-
-/* width in bytes of fw_cfg control register */
-#define FW_CFG_CTL_SIZE         0x02
-
-#define FW_CFG_MAX_FILE_PATH    56
-
-#endif
diff --git a/include/standard-headers/linux/qemu_fw_cfg.h b/include/stand=
ard-headers/linux/qemu_fw_cfg.h
new file mode 100644
index 0000000000..cb93f6678d
--- /dev/null
+++ b/include/standard-headers/linux/qemu_fw_cfg.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+#ifndef _LINUX_FW_CFG_H
+#define _LINUX_FW_CFG_H
+
+#include "standard-headers/linux/types.h"
+
+#define FW_CFG_ACPI_DEVICE_ID	"QEMU0002"
+
+/* selector key values for "well-known" fw_cfg entries */
+#define FW_CFG_SIGNATURE	0x00
+#define FW_CFG_ID		0x01
+#define FW_CFG_UUID		0x02
+#define FW_CFG_RAM_SIZE		0x03
+#define FW_CFG_NOGRAPHIC	0x04
+#define FW_CFG_NB_CPUS		0x05
+#define FW_CFG_MACHINE_ID	0x06
+#define FW_CFG_KERNEL_ADDR	0x07
+#define FW_CFG_KERNEL_SIZE	0x08
+#define FW_CFG_KERNEL_CMDLINE	0x09
+#define FW_CFG_INITRD_ADDR	0x0a
+#define FW_CFG_INITRD_SIZE	0x0b
+#define FW_CFG_BOOT_DEVICE	0x0c
+#define FW_CFG_NUMA		0x0d
+#define FW_CFG_BOOT_MENU	0x0e
+#define FW_CFG_MAX_CPUS		0x0f
+#define FW_CFG_KERNEL_ENTRY	0x10
+#define FW_CFG_KERNEL_DATA	0x11
+#define FW_CFG_INITRD_DATA	0x12
+#define FW_CFG_CMDLINE_ADDR	0x13
+#define FW_CFG_CMDLINE_SIZE	0x14
+#define FW_CFG_CMDLINE_DATA	0x15
+#define FW_CFG_SETUP_ADDR	0x16
+#define FW_CFG_SETUP_SIZE	0x17
+#define FW_CFG_SETUP_DATA	0x18
+#define FW_CFG_FILE_DIR		0x19
+
+#define FW_CFG_FILE_FIRST	0x20
+#define FW_CFG_FILE_SLOTS_MIN	0x10
+
+#define FW_CFG_WRITE_CHANNEL	0x4000
+#define FW_CFG_ARCH_LOCAL	0x8000
+#define FW_CFG_ENTRY_MASK	(~(FW_CFG_WRITE_CHANNEL | FW_CFG_ARCH_LOCAL))
+
+#define FW_CFG_INVALID		0xffff
+
+/* width in bytes of fw_cfg control register */
+#define FW_CFG_CTL_SIZE		0x02
+
+/* fw_cfg "file name" is up to 56 characters (including terminating nul)=
 */
+#define FW_CFG_MAX_FILE_PATH	56
+
+/* size in bytes of fw_cfg signature */
+#define FW_CFG_SIG_SIZE 4
+
+/* FW_CFG_ID bits */
+#define FW_CFG_VERSION		0x01
+#define FW_CFG_VERSION_DMA	0x02
+
+/* fw_cfg file directory entry type */
+struct fw_cfg_file {
+	uint32_t size;
+	uint16_t select;
+	uint16_t reserved;
+	char name[FW_CFG_MAX_FILE_PATH];
+};
+
+/* FW_CFG_DMA_CONTROL bits */
+#define FW_CFG_DMA_CTL_ERROR	0x01
+#define FW_CFG_DMA_CTL_READ	0x02
+#define FW_CFG_DMA_CTL_SKIP	0x04
+#define FW_CFG_DMA_CTL_SELECT	0x08
+#define FW_CFG_DMA_CTL_WRITE	0x10
+
+#define FW_CFG_DMA_SIGNATURE    0x51454d5520434647ULL /* "QEMU CFG" */
+
+/* Control as first field allows for different structures selected by th=
is
+ * field, which might be useful in the future
+ */
+struct fw_cfg_dma_access {
+	uint32_t control;
+	uint32_t length;
+	uint64_t address;
+};
+
+#define FW_CFG_VMCOREINFO_FILENAME "etc/vmcoreinfo"
+
+#define FW_CFG_VMCOREINFO_FORMAT_NONE 0x0
+#define FW_CFG_VMCOREINFO_FORMAT_ELF 0x1
+
+struct fw_cfg_vmcoreinfo {
+	uint16_t host_format;
+	uint16_t guest_format;
+	uint32_t size;
+	uint64_t paddr;
+};
+
+#endif
diff --git a/pc-bios/optionrom/optionrom.h b/pc-bios/optionrom/optionrom.=
h
index 6c4c2c82f4..a2b612f1a7 100644
--- a/pc-bios/optionrom/optionrom.h
+++ b/pc-bios/optionrom/optionrom.h
@@ -19,7 +19,20 @@
  */
=20
=20
-#include "../../include/hw/nvram/fw_cfg_keys.h"
+#define FW_CFG_KERNEL_ADDR      0x07
+#define FW_CFG_KERNEL_SIZE      0x08
+#define FW_CFG_KERNEL_CMDLINE   0x09
+#define FW_CFG_INITRD_ADDR      0x0a
+#define FW_CFG_INITRD_SIZE      0x0b
+#define FW_CFG_KERNEL_ENTRY     0x10
+#define FW_CFG_KERNEL_DATA      0x11
+#define FW_CFG_INITRD_DATA      0x12
+#define FW_CFG_CMDLINE_ADDR     0x13
+#define FW_CFG_CMDLINE_SIZE     0x14
+#define FW_CFG_CMDLINE_DATA     0x15
+#define FW_CFG_SETUP_ADDR       0x16
+#define FW_CFG_SETUP_SIZE       0x17
+#define FW_CFG_SETUP_DATA       0x18
=20
 #define BIOS_CFG_IOPORT_CFG	0x510
 #define BIOS_CFG_IOPORT_DATA	0x511
diff --git a/dump.c b/dump.c
index 04467b353e..500b554523 100644
--- a/dump.c
+++ b/dump.c
@@ -1742,7 +1742,7 @@ static void dump_init(DumpState *s, int fd, bool ha=
s_format,
             warn_report("guest note is not present");
         } else if (size < note_head_size || size > MAX_GUEST_NOTE_SIZE) =
{
             warn_report("guest note size is invalid: %" PRIu32, size);
-        } else if (format !=3D VMCOREINFO_FORMAT_ELF) {
+        } else if (format !=3D FW_CFG_VMCOREINFO_FORMAT_ELF) {
             warn_report("guest note format is unsupported: %" PRIu16, fo=
rmat);
         } else {
             s->guest_note =3D g_malloc(size + 1); /* +1 for adding \0 */
diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
index a2805527cb..304c6287c7 100644
--- a/hw/misc/vmcoreinfo.c
+++ b/hw/misc/vmcoreinfo.c
@@ -19,7 +19,7 @@ static void fw_cfg_vmci_write(void *dev, off_t offset, =
size_t len)
     VMCoreInfoState *s =3D VMCOREINFO(dev);
=20
     s->has_vmcoreinfo =3D offset =3D=3D 0 && len =3D=3D sizeof(s->vmcore=
info)
-        && s->vmcoreinfo.guest_format !=3D VMCOREINFO_FORMAT_NONE;
+        && s->vmcoreinfo.guest_format !=3D FW_CFG_VMCOREINFO_FORMAT_NONE=
;
 }
=20
 static void vmcoreinfo_reset(void *dev)
@@ -28,7 +28,7 @@ static void vmcoreinfo_reset(void *dev)
=20
     s->has_vmcoreinfo =3D false;
     memset(&s->vmcoreinfo, 0, sizeof(s->vmcoreinfo));
-    s->vmcoreinfo.host_format =3D cpu_to_le16(VMCOREINFO_FORMAT_ELF);
+    s->vmcoreinfo.host_format =3D cpu_to_le16(FW_CFG_VMCOREINFO_FORMAT_E=
LF);
 }
=20
 static void vmcoreinfo_realize(DeviceState *dev, Error **errp)
@@ -53,7 +53,7 @@ static void vmcoreinfo_realize(DeviceState *dev, Error =
**errp)
         return;
     }
=20
-    fw_cfg_add_file_callback(fw_cfg, "etc/vmcoreinfo",
+    fw_cfg_add_file_callback(fw_cfg, FW_CFG_VMCOREINFO_FILENAME,
                              NULL, fw_cfg_vmci_write, s,
                              &s->vmcoreinfo, sizeof(s->vmcoreinfo), fals=
e);
=20
diff --git a/pc-bios/optionrom/linuxboot_dma.c b/pc-bios/optionrom/linuxb=
oot_dma.c
index 4754282ad7..d856d41b55 100644
--- a/pc-bios/optionrom/linuxboot_dma.c
+++ b/pc-bios/optionrom/linuxboot_dma.c
@@ -58,8 +58,6 @@ asm(
 "   jmp load_kernel\n"
 );
=20
-#include "../../include/hw/nvram/fw_cfg_keys.h"
-
 /* QEMU_CFG_DMA_CONTROL bits */
 #define BIOS_CFG_DMA_CTL_ERROR   0x01
 #define BIOS_CFG_DMA_CTL_READ    0x02
@@ -73,6 +71,8 @@ asm(
 #define uint32_t unsigned int
 #define uint16_t unsigned short
=20
+#include "../../include/standard-headers/linux/qemu_fw_cfg.h"
+
 #define barrier() asm("" : : : "memory")
=20
 typedef struct FWCfgDmaAccess {
diff --git a/tests/boot-order-test.c b/tests/boot-order-test.c
index 9d98c48a3d..c60ebcf9d9 100644
--- a/tests/boot-order-test.c
+++ b/tests/boot-order-test.c
@@ -14,7 +14,7 @@
 #include "libqos/fw_cfg.h"
 #include "libqtest.h"
 #include "qapi/qmp/qdict.h"
-#include "hw/nvram/fw_cfg_keys.h"
+#include "standard-headers/linux/qemu_fw_cfg.h"
=20
 /* TODO actually test the results and get rid of this */
 #define qmp_discard_response(...) qobject_unref(qmp(__VA_ARGS__))
diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
index 1548bf14b2..1c5103fe1c 100644
--- a/tests/fw_cfg-test.c
+++ b/tests/fw_cfg-test.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
=20
 #include "libqtest.h"
-#include "hw/nvram/fw_cfg_keys.h"
+#include "standard-headers/linux/qemu_fw_cfg.h"
 #include "libqos/fw_cfg.h"
=20
 static uint64_t ram_size =3D 128 << 20;
diff --git a/tests/libqos/malloc-pc.c b/tests/libqos/malloc-pc.c
index 634b9c288a..b83cb8f0af 100644
--- a/tests/libqos/malloc-pc.c
+++ b/tests/libqos/malloc-pc.c
@@ -14,7 +14,7 @@
 #include "libqos/malloc-pc.h"
 #include "libqos/fw_cfg.h"
=20
-#include "hw/nvram/fw_cfg_keys.h"
+#include "standard-headers/linux/qemu_fw_cfg.h"
=20
 #include "qemu-common.h"
=20
--=20
2.18.0.547.g1d89318c48
