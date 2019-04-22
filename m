Received: from eggs.gnu.org ([209.51.188.92]:58843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIeyG-0004sJ-Ij
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 15:51:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIeyF-0008MX-FF
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 15:51:20 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon, 22 Apr 2019 21:50:18 +0200
Message-Id: <20190422195020.1494-6-philmd@redhat.com>
In-Reply-To: <20190422195020.1494-1-philmd@redhat.com>
References: <20190422195020.1494-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 5/7] hw/ppc: Implement fw_cfg_arch_key_name()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>, Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Implement fw_cfg_arch_key_name(), which returns the name of a
ppc-specific key.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/ppc/Makefile.objs |  2 +-
 hw/ppc/fw_cfg.c      | 45 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)
 create mode 100644 hw/ppc/fw_cfg.c

diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 1111b218a04..ae940981553 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -1,5 +1,5 @@
 # shared objects
-obj-y +=3D ppc.o ppc_booke.o fdt.o
+obj-y +=3D ppc.o ppc_booke.o fdt.o fw_cfg.o
 # IBM pSeries (sPAPR)
 obj-$(CONFIG_PSERIES) +=3D spapr.o spapr_caps.o spapr_vio.o spapr_events=
.o
 obj-$(CONFIG_PSERIES) +=3D spapr_hcall.o spapr_iommu.o spapr_rtas.o
diff --git a/hw/ppc/fw_cfg.c b/hw/ppc/fw_cfg.c
new file mode 100644
index 00000000000..a88b5c4bde2
--- /dev/null
+++ b/hw/ppc/fw_cfg.c
@@ -0,0 +1,45 @@
+/*
+ * fw_cfg helpers (PPC specific)
+ *
+ * Copyright (c) 2019 Red Hat, Inc.
+ *
+ * Author:
+ *   Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/ppc/ppc.h"
+#include "hw/nvram/fw_cfg.h"
+
+const char *fw_cfg_arch_key_name(uint16_t key)
+{
+    static const struct {
+        uint16_t key;
+        const char *name;
+    } fw_cfg_arch_wellknown_keys[] =3D {
+        {FW_CFG_PPC_WIDTH, "width"},
+        {FW_CFG_PPC_HEIGHT, "height"},
+        {FW_CFG_PPC_DEPTH, "depth"},
+        {FW_CFG_PPC_TBFREQ, "tbfreq"},
+        {FW_CFG_PPC_CLOCKFREQ, "clockfreq"},
+        {FW_CFG_PPC_IS_KVM, "is_kvm"},
+        {FW_CFG_PPC_KVM_HC, "kvm_hc"},
+        {FW_CFG_PPC_KVM_PID, "pid"},
+        {FW_CFG_PPC_NVRAM_ADDR, "nvram_addr"},
+        {FW_CFG_PPC_BUSFREQ, "busfreq"},
+        {FW_CFG_PPC_NVRAM_FLAT, "nvram_flat"},
+        {FW_CFG_PPC_VIACONFIG, "viaconfig"},
+    };
+
+    for (size_t i =3D 0; i < ARRAY_SIZE(fw_cfg_arch_wellknown_keys); i++=
) {
+        if (fw_cfg_arch_wellknown_keys[i].key =3D=3D key) {
+            return fw_cfg_arch_wellknown_keys[i].name;
+        }
+    }
+    return NULL;
+}
--=20
2.20.1
