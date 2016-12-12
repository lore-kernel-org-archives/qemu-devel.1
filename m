Received: from eggs.gnu.org ([2001:4830:134:3::10]:55324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGGz6-0002y0-IQ
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:09:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGGz5-0003Q0-QA
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:09:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cGGz5-0003Pv-KF
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:08:59 -0500
From: Peter Xu <peterx@redhat.com>
Date: Mon, 12 Dec 2016 11:08:16 +0800
Message-Id: <1481512100-10380-11-git-send-email-peterx@redhat.com>
In-Reply-To: <1481512100-10380-1-git-send-email-peterx@redhat.com>
References: <1481512100-10380-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH v8 10/14] pci: provide
 pci_enable_defaults()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: drjones@redhat.com, agordeev@redhat.com, jan.kiszka@web.de, rkrcmar@redhat.com, pbonzini@redhat.com, peterx@redhat.com

One helper function to set/clear specific bit in PCI_COMMAND register is
introduced. Then, provide a function to do most of the common PCI init
work.

Suggested-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 lib/pci.c | 19 +++++++++++++++++++
 lib/pci.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/lib/pci.c b/lib/pci.c
index d4521be..bf2a3df 100644
--- a/lib/pci.c
+++ b/lib/pci.c
@@ -7,6 +7,18 @@
 #include "pci.h"
 #include "asm/pci.h"
 
+void pci_cmd_set_clr(struct pci_dev *dev, uint16_t set, uint16_t clr)
+{
+	uint16_t val = pci_config_readw(dev->bdf, PCI_COMMAND);
+
+	/* No overlap is allowed */
+	assert((set & clr) == 0);
+	val |= set;
+	val &= ~clr;
+
+	pci_config_writew(dev->bdf, PCI_COMMAND, val);
+}
+
 bool pci_dev_exists(pcidevaddr_t dev)
 {
 	return (pci_config_readw(dev, PCI_VENDOR_ID) != 0xffff &&
@@ -242,3 +254,10 @@ void pci_scan_bars(struct pci_dev *dev)
 		}
 	}
 }
+
+void pci_enable_defaults(struct pci_dev *dev)
+{
+	pci_scan_bars(dev);
+	/* Enable device DMA operations */
+	pci_cmd_set_clr(dev, PCI_COMMAND_MASTER, 0);
+}
diff --git a/lib/pci.h b/lib/pci.h
index 8215c9d..d3052ef 100644
--- a/lib/pci.h
+++ b/lib/pci.h
@@ -25,6 +25,8 @@ struct pci_dev {
 
 extern void pci_dev_init(struct pci_dev *dev, pcidevaddr_t bdf);
 extern void pci_scan_bars(struct pci_dev *dev);
+extern void pci_cmd_set_clr(struct pci_dev *dev, uint16_t set, uint16_t clr);
+extern void pci_enable_defaults(struct pci_dev *dev);
 
 extern bool pci_probe(void);
 extern void pci_print(void);
-- 
2.7.4
