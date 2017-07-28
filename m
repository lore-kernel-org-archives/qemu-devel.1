Received: from eggs.gnu.org ([2001:4830:134:3::10]:57505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dbEmR-0000au-G7
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dbEmP-0007dp-6R
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:34:51 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:38802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dbEmO-0007d4-VL
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:34:49 -0400
Received: by mail-lf0-x242.google.com with SMTP id y15so11398895lfd.5
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 16:34:48 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Sat, 29 Jul 2017 02:34:31 +0300
Message-Id: <1501284872-2078-3-git-send-email-zuban32s@gmail.com>
In-Reply-To: <1501284872-2078-1-git-send-email-zuban32s@gmail.com>
References: <1501284872-2078-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [PATCH v3 2/3] pci: add QEMU-specific PCI capability
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
Cc: marcel@redhat.com, mst@redhat.com, kevin@koconnor.net, lersek@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, Aleksandr Bezzubikov <zuban32s@gmail.com>

On PCI init PCI bridge devices may need some
extra info about bus number to reserve, IO, memory and
prefetchable memory limits. QEMU can provide this
with special vendor-specific PCI capability.

This capability is intended to be used only
for Red Hat PCI bridges, i.e. QEMU cooperation.

Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
---
 src/fw/dev-pci.h | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 src/fw/dev-pci.h

diff --git a/src/fw/dev-pci.h b/src/fw/dev-pci.h
new file mode 100644
index 0000000..fbd49ed
--- /dev/null
+++ b/src/fw/dev-pci.h
@@ -0,0 +1,62 @@
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
+Its is shown below:
+
+Header:
+
+u8 id;       Standard PCI Capability Header field
+u8 next;     Standard PCI Capability Header field
+u8 len;      Standard PCI Capability Header field
+u8 type;     Red Hat vendor-specific capability type:
+               now only REDHAT_QEMU_CAP 1 exists
+Data:
+
+u16 non_prefetchable_16;     non-prefetchable memory limit
+
+u8 bus_res;  minimum bus number to reserve;
+             this is necessary for PCI Express Root Ports
+             to support PCIE-to-PCI bridge hotplug
+
+u8 io_8;     IO limit in case of 8-bit limit value
+u32 io_32;   IO limit in case of 16-bit limit value
+             io_8 and io_16 are mutually exclusive, in other words,
+             they can't be non-zero simultaneously
+
+u32 prefetchable_32;         non-prefetchable memory limit
+                             in case of 32-bit limit value
+u64 prefetchable_64;         non-prefetchable memory limit
+                             in case of 64-bit limit value
+                             prefetachable_32 and prefetchable_64 are
+                             mutually exclusive, in other words,
+                             they can't be non-zero simultaneously
+If any field in Data section is 0,
+it means that such kind of reservation
+is not needed.
+
+*/
+
+/* Offset of vendor-specific capability type field */
+#define PCI_CAP_VNDR_SPEC_TYPE  3
+
+/* List of valid Red Hat vendor-specific capability types */
+#define REDHAT_CAP_TYPE_QEMU    1
+
+
+/* Offsets of QEMU capability fields */
+#define QEMU_PCI_CAP_NON_PREF   4
+#define QEMU_PCI_CAP_BUS_RES    6
+#define QEMU_PCI_CAP_IO_8       7
+#define QEMU_PCI_CAP_IO_32      8
+#define QEMU_PCI_CAP_PREF_32    12
+#define QEMU_PCI_CAP_PREF_64    16
+#define QEMU_PCI_CAP_SIZE       24
+
+#endif /* _PCI_CAP_H */
-- 
2.7.4
