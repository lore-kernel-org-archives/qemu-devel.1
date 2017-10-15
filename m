Received: from eggs.gnu.org ([2001:4830:134:3::10]:48792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZVx-000293-8C
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:22:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZVw-0006DJ-47
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:22:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1e3ZVv-0006D0-Qk
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:22:56 -0400
Date: Sun, 15 Oct 2017 06:22:52 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1508036858-13479-5-git-send-email-mst@redhat.com>
References: <1508036858-13479-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1508036858-13479-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/26] hw/misc: add vmcoreinfo device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

See docs/specs/vmcoreinfo.txt for details.

"etc/vmcoreinfo" fw_cfg entry is added when using "-device vmcoreinfo".

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/specs/vmcoreinfo.txt    | 41 +++++++++++++++++++
 include/hw/misc/vmcoreinfo.h | 46 +++++++++++++++++++++
 hw/misc/vmcoreinfo.c         | 96 ++++++++++++++++++++++++++++++++++++++=
++++++
 hw/misc/Makefile.objs        |  1 +
 4 files changed, 184 insertions(+)
 create mode 100644 docs/specs/vmcoreinfo.txt
 create mode 100644 include/hw/misc/vmcoreinfo.h
 create mode 100644 hw/misc/vmcoreinfo.c

diff --git a/docs/specs/vmcoreinfo.txt b/docs/specs/vmcoreinfo.txt
new file mode 100644
index 0000000..2868a77
--- /dev/null
+++ b/docs/specs/vmcoreinfo.txt
@@ -0,0 +1,41 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+VMCoreInfo device
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The `-device vmcoreinfo` will create a fw_cfg entry for a guest to
+store dump details.
+
+etc/vmcoreinfo
+**************
+
+A guest may use this fw_cfg entry to add information details to qemu
+dumps.
+
+The entry of 16 bytes has the following layout, in little-endian::
+
+#define VMCOREINFO_FORMAT_NONE 0x0
+#define VMCOREINFO_FORMAT_ELF 0x1
+
+    struct FWCfgVMCoreInfo {
+        uint16_t host_format;  /* formats host supports */
+        uint16_t guest_format; /* format guest supplies */
+        uint32_t size;         /* size of vmcoreinfo region */
+        uint64_t paddr;        /* physical address of vmcoreinfo region =
*/
+    };
+
+Only full write (of 16 bytes) are considered valid for further
+processing of entry values.
+
+A write of 0 in guest_format will disable further processing of
+vmcoreinfo entry values & content.
+
+Format & content
+****************
+
+As of qemu 2.11, only VMCOREINFO_FORMAT_ELF is supported.
+
+The entry gives location and size of an ELF note that is appended in
+qemu dumps.
+
+The note format/class must be of the target bitness and the size must
+be less than 1Mb.
diff --git a/include/hw/misc/vmcoreinfo.h b/include/hw/misc/vmcoreinfo.h
new file mode 100644
index 0000000..c3aa856
--- /dev/null
+++ b/include/hw/misc/vmcoreinfo.h
@@ -0,0 +1,46 @@
+/*
+ * Virtual Machine coreinfo device
+ *
+ * Copyright (C) 2017 Red Hat, Inc.
+ *
+ * Authors: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+#ifndef VMCOREINFO_H
+#define VMCOREINFO_H
+
+#include "hw/qdev.h"
+
+#define VMCOREINFO_DEVICE "vmcoreinfo"
+#define VMCOREINFO(obj) OBJECT_CHECK(VMCoreInfoState, (obj), VMCOREINFO_=
DEVICE)
+
+#define VMCOREINFO_FORMAT_NONE 0x0
+#define VMCOREINFO_FORMAT_ELF 0x1
+
+/* all fields are little-endian */
+typedef struct FWCfgVMCoreInfo {
+    uint16_t host_format; /* set on reset */
+    uint16_t guest_format;
+    uint32_t size;
+    uint64_t paddr;
+} QEMU_PACKED FWCfgVMCoreInfo;
+
+typedef struct VMCoreInfoState {
+    DeviceClass parent_obj;
+
+    bool has_vmcoreinfo;
+    FWCfgVMCoreInfo vmcoreinfo;
+} VMCoreInfoState;
+
+/* returns NULL unless there is exactly one device */
+static inline VMCoreInfoState *vmcoreinfo_find(void)
+{
+    Object *o =3D object_resolve_path_type("", VMCOREINFO_DEVICE, NULL);
+
+    return o ? VMCOREINFO(o) : NULL;
+}
+
+#endif
diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
new file mode 100644
index 0000000..a618e12
--- /dev/null
+++ b/hw/misc/vmcoreinfo.c
@@ -0,0 +1,96 @@
+/*
+ * Virtual Machine coreinfo device
+ *
+ * Copyright (C) 2017 Red Hat, Inc.
+ *
+ * Authors: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/nvram/fw_cfg.h"
+#include "hw/misc/vmcoreinfo.h"
+
+static void fw_cfg_vmci_write(void *dev, off_t offset, size_t len)
+{
+    VMCoreInfoState *s =3D VMCOREINFO(dev);
+
+    s->has_vmcoreinfo =3D offset =3D=3D 0 && len =3D=3D sizeof(s->vmcore=
info)
+        && s->vmcoreinfo.guest_format !=3D VMCOREINFO_FORMAT_NONE;
+}
+
+static void vmcoreinfo_reset(void *dev)
+{
+    VMCoreInfoState *s =3D VMCOREINFO(dev);
+
+    s->has_vmcoreinfo =3D false;
+    memset(&s->vmcoreinfo, 0, sizeof(s->vmcoreinfo));
+    s->vmcoreinfo.host_format =3D cpu_to_le16(VMCOREINFO_FORMAT_ELF);
+}
+
+static void vmcoreinfo_realize(DeviceState *dev, Error **errp)
+{
+    VMCoreInfoState *s =3D VMCOREINFO(dev);
+    FWCfgState *fw_cfg =3D fw_cfg_find();
+
+    /* Given that this function is executing, there is at least one VMCO=
REINFO
+     * device. Check if there are several.
+     */
+    if (!vmcoreinfo_find()) {
+        error_setg(errp, "at most one %s device is permitted",
+                   VMCOREINFO_DEVICE);
+        return;
+    }
+
+    if (!fw_cfg || !fw_cfg->dma_enabled) {
+        error_setg(errp, "%s device requires fw_cfg with DMA",
+                   VMCOREINFO_DEVICE);
+        return;
+    }
+
+    fw_cfg_add_file_callback(fw_cfg, "etc/vmcoreinfo",
+                             NULL, fw_cfg_vmci_write, s,
+                             &s->vmcoreinfo, sizeof(s->vmcoreinfo), fals=
e);
+
+    qemu_register_reset(vmcoreinfo_reset, dev);
+}
+
+static const VMStateDescription vmstate_vmcoreinfo =3D {
+    .name =3D "vmcoreinfo",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_BOOL(has_vmcoreinfo, VMCoreInfoState),
+        VMSTATE_UINT16(vmcoreinfo.host_format, VMCoreInfoState),
+        VMSTATE_UINT16(vmcoreinfo.guest_format, VMCoreInfoState),
+        VMSTATE_UINT32(vmcoreinfo.size, VMCoreInfoState),
+        VMSTATE_UINT64(vmcoreinfo.paddr, VMCoreInfoState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void vmcoreinfo_device_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->vmsd =3D &vmstate_vmcoreinfo;
+    dc->realize =3D vmcoreinfo_realize;
+    dc->hotpluggable =3D false;
+}
+
+static const TypeInfo vmcoreinfo_device_info =3D {
+    .name          =3D VMCOREINFO_DEVICE,
+    .parent        =3D TYPE_DEVICE,
+    .instance_size =3D sizeof(VMCoreInfoState),
+    .class_init    =3D vmcoreinfo_device_class_init,
+};
+
+static void vmcoreinfo_register_types(void)
+{
+    type_register_static(&vmcoreinfo_device_info);
+}
+
+type_init(vmcoreinfo_register_types)
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index e8f0a02..19202d9 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -9,6 +9,7 @@ common-obj-$(CONFIG_PCI_TESTDEV) +=3D pci-testdev.o
 common-obj-$(CONFIG_EDU) +=3D edu.o
=20
 common-obj-y +=3D unimp.o
+common-obj-y +=3D vmcoreinfo.o
=20
 obj-$(CONFIG_VMPORT) +=3D vmport.o
=20
--=20
MST
