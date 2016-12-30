Received: from eggs.gnu.org ([2001:4830:134:3::10]:34446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cMsz7-0008JT-MK
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 03:56:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cMsz4-0008CL-Ke
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 03:56:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cMsz4-0008CF-Ed
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 03:56:18 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri, 30 Dec 2016 16:55:54 +0800
Message-Id: <1483088160-6714-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1483088160-6714-1-git-send-email-peterx@redhat.com>
References: <1483088160-6714-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH 2/8] pci: introduce
 pci_msi_set_enable()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: Jan Kiszka <jan.kiszka@web.de>, Paolo Bonzini <pbonzini@redhat.com>, agordeev@redhat.com, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Andrew Jones <drjones@redhat.com>, peterx@redhat.com

Generalize this function out of pci_setup_msi(), then it can be further
used to enable INTx (or, disable MSI).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 lib/pci.c | 19 +++++++++++++++++--
 lib/pci.h |  1 +
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/lib/pci.c b/lib/pci.c
index a7cfacb..5062036 100644
--- a/lib/pci.c
+++ b/lib/pci.c
@@ -39,6 +39,22 @@ void pci_cap_walk(struct pci_dev *dev)
 	}
 }
 
+void pci_msi_set_enable(struct pci_dev *dev, bool enabled)
+{
+	uint16_t msi_control;
+	uint16_t offset;
+
+	offset = dev->msi_offset;
+	msi_control = pci_config_readw(dev->bdf, offset + PCI_MSI_FLAGS);
+
+	if (enabled)
+		msi_control |= PCI_MSI_FLAGS_ENABLE;
+	else
+		msi_control &= ~PCI_MSI_FLAGS_ENABLE;
+
+	pci_config_writew(dev->bdf, offset + PCI_MSI_FLAGS, msi_control);
+}
+
 bool pci_setup_msi(struct pci_dev *dev, uint64_t msi_addr, uint32_t msi_data)
 {
 	uint16_t msi_control;
@@ -69,8 +85,7 @@ bool pci_setup_msi(struct pci_dev *dev, uint64_t msi_addr, uint32_t msi_data)
 	}
 	printf("addr=0x%lx, data=0x%x\n", msi_addr, msi_data);
 
-	msi_control |= PCI_MSI_FLAGS_ENABLE;
-	pci_config_writew(addr, offset + PCI_MSI_FLAGS, msi_control);
+	pci_msi_set_enable(dev, true);
 
 	return true;
 }
diff --git a/lib/pci.h b/lib/pci.h
index df86951..0815754 100644
--- a/lib/pci.h
+++ b/lib/pci.h
@@ -65,6 +65,7 @@ extern bool pci_bar_is_valid(struct pci_dev *dev, int bar_num);
 extern void pci_bar_print(struct pci_dev *dev, int bar_num);
 extern void pci_dev_print_id(pcidevaddr_t dev);
 extern uint8_t pci_intx_line(struct pci_dev *dev);
+void pci_msi_set_enable(struct pci_dev *dev, bool enabled);
 
 extern int pci_testdev(void);
 
-- 
2.7.4
