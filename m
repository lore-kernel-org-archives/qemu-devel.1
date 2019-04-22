Received: from eggs.gnu.org ([209.51.188.92]:58647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIexu-0004b9-6E
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 15:50:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIexq-00089K-7X
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 15:50:58 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon, 22 Apr 2019 21:50:15 +0200
Message-Id: <20190422195020.1494-3-philmd@redhat.com>
In-Reply-To: <20190422195020.1494-1-philmd@redhat.com>
References: <20190422195020.1494-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 2/7] hw/nvram/fw_cfg: Add
 fw_cfg_arch_key_name()
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

Add fw_cfg_arch_key_name() which returns the name of
an architecture-specific key.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS               |  1 +
 hw/nvram/fw_cfg.c         |  2 +-
 include/hw/nvram/fw_cfg.h | 11 +++++++++++
 stubs/Makefile.objs       |  1 +
 stubs/fw_cfg.c            | 21 +++++++++++++++++++++
 5 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100644 stubs/fw_cfg.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 56139ac8ab0..444783bb652 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1675,6 +1675,7 @@ R: Gerd Hoffmann <kraxel@redhat.com>
 S: Supported
 F: docs/specs/fw_cfg.txt
 F: hw/nvram/fw_cfg.c
+F: stubs/fw_cfg.c
 F: include/hw/nvram/fw_cfg.h
 F: include/standard-headers/linux/qemu_fw_cfg.h
 F: tests/libqos/fw_cfg.c
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index d374a970fea..b2dc0a80cbc 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -100,7 +100,7 @@ static const char *key_name(uint16_t key)
     };
=20
     if (key & FW_CFG_ARCH_LOCAL) {
-        return NULL;
+        return fw_cfg_arch_key_name(key);
     }
     if (key < FW_CFG_FILE_FIRST) {
         return fw_cfg_wellknown_keys[key];
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index f5a6895a740..828ad9dedc6 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -226,4 +226,15 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
 FWCfgState *fw_cfg_find(void);
 bool fw_cfg_dma_enabled(void *opaque);
=20
+/**
+ * fw_cfg_arch_key_name:
+ *
+ * @key: The uint16 selector key.
+ *
+ * Returns: The stringified architecture-specific name if the selector
+ *          refers to a well-known numerically defined item, or NULL on
+ *          key lookup failure.
+ */
+const char *fw_cfg_arch_key_name(uint16_t key);
+
 #endif
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 269dfa58326..73452ad2657 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -39,3 +39,4 @@ stub-obj-y +=3D xen-hvm.o
 stub-obj-y +=3D pci-host-piix.o
 stub-obj-y +=3D ram-block.o
 stub-obj-y +=3D ramfb.o
+stub-obj-y +=3D fw_cfg.o
diff --git a/stubs/fw_cfg.c b/stubs/fw_cfg.c
new file mode 100644
index 00000000000..bb1e3c8aa95
--- /dev/null
+++ b/stubs/fw_cfg.c
@@ -0,0 +1,21 @@
+/*
+ * fw_cfg stubs
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
+#include "hw/nvram/fw_cfg.h"
+
+const char *fw_cfg_arch_key_name(uint16_t key)
+{
+    return NULL;
+}
--=20
2.20.1
