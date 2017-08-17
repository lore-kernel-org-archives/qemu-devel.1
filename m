Received: from eggs.gnu.org ([2001:4830:134:3::10]:46767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1diTy5-0005JU-PB
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:12:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1diTy2-000701-KO
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:12:49 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:34488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1diTy2-0006zh-Ct
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:12:46 -0400
Received: by mail-lf0-x241.google.com with SMTP id o85so5235796lff.1
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 16:12:46 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Fri, 18 Aug 2017 02:12:30 +0300
Message-Id: <1503011551-7246-3-git-send-email-zuban32s@gmail.com>
In-Reply-To: <1503011551-7246-1-git-send-email-zuban32s@gmail.com>
References: <1503011551-7246-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [PATCH v7 2/3] pci: add QEMU-specific PCI capability
 structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: seabios@seabios.org
Cc: marcel@redhat.com, mst@redhat.com, kraxel@redhat.com, kevin@koconnor.net, lersek@redhat.com, qemu-devel@nongnu.org, Aleksandr Bezzubikov <zuban32s@gmail.com>

On PCI init PCI bridge devices may need some
extra info about bus number to reserve, IO, memory and
prefetchable memory limits. QEMU can provide this
with special vendor-specific PCI capability.

This capability is intended to be used only
for Red Hat PCI bridges, i.e. QEMU cooperation.

Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
---
 src/fw/dev-pci.h | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 src/fw/dev-pci.h

diff --git a/src/fw/dev-pci.h b/src/fw/dev-pci.h
new file mode 100644
index 0000000..0dc5556
--- /dev/null
+++ b/src/fw/dev-pci.h
@@ -0,0 +1,53 @@
+#ifndef _PCI_CAP_H
+#define _PCI_CAP_H
+
+#include "types.h"
+
+/*
+ *
+ * QEMU-specific vendor(Red Hat)-specific capability.
+ * It's intended to provide some hints for firmware to init PCI devices.
+ *
+ * Its structure is shown below:
+ *
+ * Header:
+ *
+ * u8 id;       Standard PCI Capability Header field
+ * u8 next;     Standard PCI Capability Header field
+ * u8 len;      Standard PCI Capability Header field
+ * u8 type;     Red Hat vendor-specific capability type
+ * Data:
+ *
+ * u32 bus_res;     minimum bus number to reserve;
+ *                  this is necessary for PCI Express Root Ports
+ *                  to support PCI bridges hotplug
+ * u64 io;          IO space to reserve
+ * u32 mem;         non-prefetchable memory to reserve
+ *
+ * At most of the following two fields may be set to a value
+ * different from 0xFF...F:
+ * u32 prefetchable_mem_32;     prefetchable memory to reserve (32-bit MMIO)
+ * u64 prefetchable_mem_64;     prefetchable memory to reserve (64-bit MMIO)
+ *
+ * If any field value in Data section is 0xFF...F,
+ * it means that such kind of reservation is not needed and must be ignored.
+ *
+*/
+
+/* Offset of vendor-specific capability type field */
+#define PCI_CAP_REDHAT_TYPE_OFFSET  3
+
+/* List of valid Red Hat vendor-specific capability types */
+#define REDHAT_CAP_RESOURCE_RESERVE 1
+
+
+/* Offsets of RESOURCE_RESERVE capability fields */
+#define RES_RESERVE_BUS_RES        4
+#define RES_RESERVE_IO             8
+#define RES_RESERVE_MEM            16
+#define RES_RESERVE_PREF_MEM_32    20
+#define RES_RESERVE_PREF_MEM_64    24
+#define RES_RESERVE_CAP_SIZE       32
+
+#endif /* _PCI_CAP_H */
+
-- 
2.7.4
