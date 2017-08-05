Received: from eggs.gnu.org ([2001:4830:134:3::10]:58197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1de5i5-0007wW-66
	for qemu-devel@nongnu.org; Sat, 05 Aug 2017 16:30:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1de5i4-0006Is-4M
	for qemu-devel@nongnu.org; Sat, 05 Aug 2017 16:30:09 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:38534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1de5i3-0006GD-Th
	for qemu-devel@nongnu.org; Sat, 05 Aug 2017 16:30:08 -0400
Received: by mail-lf0-x243.google.com with SMTP id y15so3063292lfd.5
	for <qemu-devel@nongnu.org>; Sat, 05 Aug 2017 13:30:07 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Sat,  5 Aug 2017 23:29:53 +0300
Message-Id: <1501964994-5257-3-git-send-email-zuban32s@gmail.com>
In-Reply-To: <1501964994-5257-1-git-send-email-zuban32s@gmail.com>
References: <1501964994-5257-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [PATCH v4 2/3] pci: add QEMU-specific PCI capability
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
Cc: mst@redhat.com, marcel@redhat.com, kevin@koconnor.net, kraxel@redhat.com, lersek@redhat.com, qemu-devel@nongnu.org, Aleksandr Bezzubikov <zuban32s@gmail.com>

On PCI init PCI bridge devices may need some
extra info about bus number to reserve, IO, memory and
prefetchable memory limits. QEMU can provide this
with special vendor-specific PCI capability.

This capability is intended to be used only
for Red Hat PCI bridges, i.e. QEMU cooperation.

Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
---
 src/fw/dev-pci.h | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 src/fw/dev-pci.h

diff --git a/src/fw/dev-pci.h b/src/fw/dev-pci.h
new file mode 100644
index 0000000..2c8ddb0
--- /dev/null
+++ b/src/fw/dev-pci.h
@@ -0,0 +1,50 @@
+#ifndef _PCI_CAP_H
+#define _PCI_CAP_H
+
+#include "types.h"
+
+/*
+
+QEMU-specific vendor(Red Hat)-specific capability.
+It's intended to provide some hints for firmware to init PCI devices.
+
+Its structure is shown below:
+
+Header:
+
+u8 id;       Standard PCI Capability Header field
+u8 next;     Standard PCI Capability Header field
+u8 len;      Standard PCI Capability Header field
+u8 type;     Red Hat vendor-specific capability type:
+               now only REDHAT_CAP_TYP_QEMU=1 exists
+Data:
+
+u32 bus_res;            minimum bus number to reserve;
+                        this is necessary for PCI Express Root Ports
+                        to support PCIE-to-PCI bridge hotplug
+u64 io;                 IO space to reserve
+u64 mem;                non-prefetchable memory space to reserve
+u64 prefetchable_mem;   prefetchable memory space to reserve
+
+If any field value in Data section is -1,
+it means that such kind of reservation
+is not needed and must be ignored.
+
+*/
+
+/* Offset of vendor-specific capability type field */
+#define PCI_CAP_REDHAT_TYPE  3
+
+/* List of valid Red Hat vendor-specific capability types */
+#define REDHAT_CAP_TYPE_QEMU    1
+
+
+/* Offsets of QEMU capability fields */
+#define QEMU_PCI_CAP_BUS_RES        4
+#define QEMU_PCI_CAP_LIMITS_OFFSET  8
+#define QEMU_PCI_CAP_IO             8
+#define QEMU_PCI_CAP_MEM            16
+#define QEMU_PCI_CAP_PREF_MEM       24
+#define QEMU_PCI_CAP_SIZE           32
+
+#endif /* _PCI_CAP_H */
-- 
2.7.4
