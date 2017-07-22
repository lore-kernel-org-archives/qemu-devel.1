Received: from eggs.gnu.org ([2001:4830:134:3::10]:59928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZ2dF-0000Qx-5e
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 18:12:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZ2dE-0006lU-BV
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 18:12:17 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:36879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dZ2dE-0006l8-4M
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 18:12:16 -0400
Received: by mail-lf0-x243.google.com with SMTP id x16so861265lfb.4
	for <qemu-devel@nongnu.org>; Sat, 22 Jul 2017 15:12:16 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Sun, 23 Jul 2017 01:11:49 +0300
Message-Id: <1500761510-1556-4-git-send-email-zuban32s@gmail.com>
In-Reply-To: <1500761510-1556-1-git-send-email-zuban32s@gmail.com>
References: <1500761510-1556-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [RFC PATCH v2 3/4] pci: add QEMU-specific PCI
 capability structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: seabios@seabios.org
Cc: marcel@redhat.com, kraxel@redhat.com, kevin@koconnor.net, lersek@redhat.com, qemu-devel@nongnu.org, konrad.wilk@oracle.com, mst@redhat.com, Aleksandr Bezzubikov <zuban32s@gmail.com>

On PCI init PCI bridge devices may need some
extra info about bus number to reserve, IO, memory and
prefetchable memory limits. QEMU can provide this
with special vendor-specific PCI capability.

This capability is intended to be used only
for Red Hat PCI bridges, i.e. QEMU cooperation.

Sizes of limits match ones from 
PCI Type 1 Configuration Space Header,
number of buses to reserve occupies only 1 byte 
since it is the size of Subordinate Bus Number register.

Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
---
 src/hw/pci_cap.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 src/hw/pci_cap.h

diff --git a/src/hw/pci_cap.h b/src/hw/pci_cap.h
new file mode 100644
index 0000000..1382b0b
--- /dev/null
+++ b/src/hw/pci_cap.h
@@ -0,0 +1,23 @@
+#ifndef _PCI_CAP_H
+#define _PCI_CAP_H
+
+#include "types.h"
+
+struct vendor_pci_cap {
+    u8 id;
+    u8 next;
+    u8 len;
+};
+
+struct redhat_pci_bridge_cap {
+    struct vendor_pci_cap hdr;
+    u8 bus_res;
+    u32 pref_lim_upper;
+    u16 pref_lim;
+    u16 mem_lim;
+    u16 io_lim_upper;
+    u8 io_lim;
+    u8 padd;
+};
+
+#endif /* _PCI_CAP_H */
-- 
2.7.4
