Received: from eggs.gnu.org ([2001:4830:134:3::10]:55293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGGz1-0002tq-5x
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:08:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGGyz-0003PB-As
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:08:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cGGyz-0003P6-2N
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:08:53 -0500
From: Peter Xu <peterx@redhat.com>
Date: Mon, 12 Dec 2016 11:08:14 +0800
Message-Id: <1481512100-10380-9-git-send-email-peterx@redhat.com>
In-Reply-To: <1481512100-10380-1-git-send-email-peterx@redhat.com>
References: <1481512100-10380-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH v8 08/14] pci: introduce struct
 pci_dev
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

To extend current PCI framework, we need a per-device struct to store
device specific information. Time to have a pci_dev struct. Most of the
current PCI APIs are converted to use this pci_dev object as the first
argument. Currently it only contains one field "bdf", which is the bdf
of current device.

For a few APIs like pci_config_*() ops or pci_find_dev(), I kept the old
interface (use PCI BDF value rather than "struct pci_dev") since they
can be used in a open context that without any specific PCI device.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 lib/pci-host-generic.c | 17 ++++++++-------
 lib/pci-testdev.c      | 10 +++++----
 lib/pci.c              | 56 ++++++++++++++++++++++++++++++--------------------
 lib/pci.h              | 24 ++++++++++++++--------
 x86/vmexit.c           | 18 ++++++++--------
 5 files changed, 76 insertions(+), 49 deletions(-)

diff --git a/lib/pci-host-generic.c b/lib/pci-host-generic.c
index 6ac0f15..958ef70 100644
--- a/lib/pci-host-generic.c
+++ b/lib/pci-host-generic.c
@@ -165,7 +165,7 @@ static struct pci_host_bridge *pci_dt_probe(void)
 	return host;
 }
 
-static bool pci_alloc_resource(pcidevaddr_t dev, int bar_num, u64 *addr)
+static bool pci_alloc_resource(struct pci_dev *dev, int bar_num, u64 *addr)
 {
 	struct pci_host_bridge *host = pci_host_bridge;
 	struct pci_addr_space *as = &host->addr_space[0];
@@ -192,7 +192,7 @@ static bool pci_alloc_resource(pcidevaddr_t dev, int bar_num, u64 *addr)
 
 	if (i >= host->nr_addr_spaces) {
 		printf("%s: warning: can't satisfy request for ", __func__);
-		pci_dev_print_id(dev);
+		pci_dev_print_id(dev->bdf);
 		printf(" ");
 		pci_bar_print(dev, bar_num);
 		printf("\n");
@@ -211,6 +211,7 @@ static bool pci_alloc_resource(pcidevaddr_t dev, int bar_num, u64 *addr)
 
 bool pci_probe(void)
 {
+	struct pci_dev pci_dev;
 	pcidevaddr_t dev;
 	u8 header;
 	u32 cmd;
@@ -221,10 +222,12 @@ bool pci_probe(void)
 	if (!pci_host_bridge)
 		return false;
 
-	for (dev = 0; dev < 256; dev++) {
+	for (dev = 0; dev < PCI_DEVFN_MAX; dev++) {
 		if (!pci_dev_exists(dev))
 			continue;
 
+		pci_dev_init(&pci_dev, dev);
+
 		/* We are only interested in normal PCI devices */
 		header = pci_config_readb(dev, PCI_HEADER_TYPE);
 		if ((header & PCI_HEADER_TYPE_MASK) != PCI_HEADER_TYPE_NORMAL)
@@ -235,16 +238,16 @@ bool pci_probe(void)
 		for (i = 0; i < 6; i++) {
 			u64 addr;
 
-			if (pci_alloc_resource(dev, i, &addr)) {
-				pci_bar_set_addr(dev, i, addr);
+			if (pci_alloc_resource(&pci_dev, i, &addr)) {
+				pci_bar_set_addr(&pci_dev, i, addr);
 
-				if (pci_bar_is_memory(dev, i))
+				if (pci_bar_is_memory(&pci_dev, i))
 					cmd |= PCI_COMMAND_MEMORY;
 				else
 					cmd |= PCI_COMMAND_IO;
 			}
 
-			if (pci_bar_is64(dev, i))
+			if (pci_bar_is64(&pci_dev, i))
 				i++;
 		}
 
diff --git a/lib/pci-testdev.c b/lib/pci-testdev.c
index ad482d3..7d298e6 100644
--- a/lib/pci-testdev.c
+++ b/lib/pci-testdev.c
@@ -163,9 +163,10 @@ static int pci_testdev_all(struct pci_test_dev_hdr *test,
 
 int pci_testdev(void)
 {
+	struct pci_dev pci_dev;
+	pcidevaddr_t dev;
 	phys_addr_t addr;
 	void __iomem *mem, *io;
-	pcidevaddr_t dev;
 	int nr_tests = 0;
 	bool ret;
 
@@ -175,14 +176,15 @@ int pci_testdev(void)
 		       "check QEMU '-device pci-testdev' parameter\n");
 		return -1;
 	}
+	pci_dev_init(&pci_dev, dev);
 
-	ret = pci_bar_is_valid(dev, 0) && pci_bar_is_valid(dev, 1);
+	ret = pci_bar_is_valid(&pci_dev, 0) && pci_bar_is_valid(&pci_dev, 1);
 	assert(ret);
 
-	addr = pci_bar_get_addr(dev, 0);
+	addr = pci_bar_get_addr(&pci_dev, 0);
 	mem = ioremap(addr, PAGE_SIZE);
 
-	addr = pci_bar_get_addr(dev, 1);
+	addr = pci_bar_get_addr(&pci_dev, 1);
 	io = (void *)(unsigned long)addr;
 
 	nr_tests += pci_testdev_all(mem, &pci_testdev_mem_ops);
diff --git a/lib/pci.c b/lib/pci.c
index 6bd54cb..8f2356d 100644
--- a/lib/pci.c
+++ b/lib/pci.c
@@ -13,12 +13,18 @@ bool pci_dev_exists(pcidevaddr_t dev)
 		pci_config_readw(dev, PCI_DEVICE_ID) != 0xffff);
 }
 
+void pci_dev_init(struct pci_dev *dev, pcidevaddr_t bdf)
+{
+       memset(dev, 0, sizeof(*dev));
+       dev->bdf = bdf;
+}
+
 /* Scan bus look for a specific device. Only bus 0 scanned for now. */
 pcidevaddr_t pci_find_dev(uint16_t vendor_id, uint16_t device_id)
 {
 	pcidevaddr_t dev;
 
-	for (dev = 0; dev < 256; ++dev) {
+	for (dev = 0; dev < PCI_DEVFN_MAX; ++dev) {
 		if (pci_config_readw(dev, PCI_VENDOR_ID) == vendor_id &&
 		    pci_config_readw(dev, PCI_DEVICE_ID) == device_id)
 			return dev;
@@ -33,12 +39,13 @@ uint32_t pci_bar_mask(uint32_t bar)
 		PCI_BASE_ADDRESS_IO_MASK : PCI_BASE_ADDRESS_MEM_MASK;
 }
 
-uint32_t pci_bar_get(pcidevaddr_t dev, int bar_num)
+uint32_t pci_bar_get(struct pci_dev *dev, int bar_num)
 {
-	return pci_config_readl(dev, PCI_BASE_ADDRESS_0 + bar_num * 4);
+	return pci_config_readl(dev->bdf, PCI_BASE_ADDRESS_0 +
+				bar_num * 4);
 }
 
-phys_addr_t pci_bar_get_addr(pcidevaddr_t dev, int bar_num)
+phys_addr_t pci_bar_get_addr(struct pci_dev *dev, int bar_num)
 {
 	uint32_t bar = pci_bar_get(dev, bar_num);
 	uint32_t mask = pci_bar_mask(bar);
@@ -47,17 +54,18 @@ phys_addr_t pci_bar_get_addr(pcidevaddr_t dev, int bar_num)
 	if (pci_bar_is64(dev, bar_num))
 		addr |= (uint64_t)pci_bar_get(dev, bar_num + 1) << 32;
 
-	return pci_translate_addr(dev, addr);
+	return pci_translate_addr(dev->bdf, addr);
 }
 
-void pci_bar_set_addr(pcidevaddr_t dev, int bar_num, phys_addr_t addr)
+void pci_bar_set_addr(struct pci_dev *dev, int bar_num, phys_addr_t addr)
 {
 	int off = PCI_BASE_ADDRESS_0 + bar_num * 4;
 
-	pci_config_writel(dev, off, (uint32_t)addr);
+	pci_config_writel(dev->bdf, off, (uint32_t)addr);
 
 	if (pci_bar_is64(dev, bar_num))
-		pci_config_writel(dev, off + 4, (uint32_t)(addr >> 32));
+		pci_config_writel(dev->bdf, off + 4,
+				  (uint32_t)(addr >> 32));
 }
 
 /*
@@ -70,20 +78,21 @@ void pci_bar_set_addr(pcidevaddr_t dev, int bar_num, phys_addr_t addr)
  * The following pci_bar_size_helper() and pci_bar_size() functions
  * implement the algorithm.
  */
-static uint32_t pci_bar_size_helper(pcidevaddr_t dev, int bar_num)
+static uint32_t pci_bar_size_helper(struct pci_dev *dev, int bar_num)
 {
 	int off = PCI_BASE_ADDRESS_0 + bar_num * 4;
+	uint16_t bdf = dev->bdf;
 	uint32_t bar, val;
 
-	bar = pci_config_readl(dev, off);
-	pci_config_writel(dev, off, ~0u);
-	val = pci_config_readl(dev, off);
-	pci_config_writel(dev, off, bar);
+	bar = pci_config_readl(bdf, off);
+	pci_config_writel(bdf, off, ~0u);
+	val = pci_config_readl(bdf, off);
+	pci_config_writel(bdf, off, bar);
 
 	return val;
 }
 
-phys_addr_t pci_bar_size(pcidevaddr_t dev, int bar_num)
+phys_addr_t pci_bar_size(struct pci_dev *dev, int bar_num)
 {
 	uint32_t bar, size;
 
@@ -104,19 +113,19 @@ phys_addr_t pci_bar_size(pcidevaddr_t dev, int bar_num)
 	}
 }
 
-bool pci_bar_is_memory(pcidevaddr_t dev, int bar_num)
+bool pci_bar_is_memory(struct pci_dev *dev, int bar_num)
 {
 	uint32_t bar = pci_bar_get(dev, bar_num);
 
 	return !(bar & PCI_BASE_ADDRESS_SPACE_IO);
 }
 
-bool pci_bar_is_valid(pcidevaddr_t dev, int bar_num)
+bool pci_bar_is_valid(struct pci_dev *dev, int bar_num)
 {
 	return pci_bar_get(dev, bar_num);
 }
 
-bool pci_bar_is64(pcidevaddr_t dev, int bar_num)
+bool pci_bar_is64(struct pci_dev *dev, int bar_num)
 {
 	uint32_t bar = pci_bar_get(dev, bar_num);
 
@@ -127,7 +136,7 @@ bool pci_bar_is64(pcidevaddr_t dev, int bar_num)
 		      PCI_BASE_ADDRESS_MEM_TYPE_64;
 }
 
-void pci_bar_print(pcidevaddr_t dev, int bar_num)
+void pci_bar_print(struct pci_dev *dev, int bar_num)
 {
 	phys_addr_t size, start, end;
 	uint32_t bar;
@@ -186,8 +195,11 @@ static void pci_dev_print(pcidevaddr_t dev)
 	uint8_t progif = pci_config_readb(dev, PCI_CLASS_PROG);
 	uint8_t subclass = pci_config_readb(dev, PCI_CLASS_DEVICE);
 	uint8_t class = pci_config_readb(dev, PCI_CLASS_DEVICE + 1);
+	struct pci_dev pci_dev;
 	int i;
 
+	pci_dev_init(&pci_dev, dev);
+
 	pci_dev_print_id(dev);
 	printf(" type %02x progif %02x class %02x subclass %02x\n",
 	       header, progif, class, subclass);
@@ -196,12 +208,12 @@ static void pci_dev_print(pcidevaddr_t dev)
 		return;
 
 	for (i = 0; i < 6; i++) {
-		if (pci_bar_size(dev, i)) {
+		if (pci_bar_size(&pci_dev, i)) {
 			printf("\t");
-			pci_bar_print(dev, i);
+			pci_bar_print(&pci_dev, i);
 			printf("\n");
 		}
-		if (pci_bar_is64(dev, i))
+		if (pci_bar_is64(&pci_dev, i))
 			i++;
 	}
 }
@@ -210,7 +222,7 @@ void pci_print(void)
 {
 	pcidevaddr_t dev;
 
-	for (dev = 0; dev < 256; ++dev) {
+	for (dev = 0; dev < PCI_DEVFN_MAX; ++dev) {
 		if (pci_dev_exists(dev))
 			pci_dev_print(dev);
 	}
diff --git a/lib/pci.h b/lib/pci.h
index 86d6b42..355acd0 100644
--- a/lib/pci.h
+++ b/lib/pci.h
@@ -15,6 +15,14 @@ enum {
 	PCIDEVADDR_INVALID = 0xffff,
 };
 
+#define PCI_DEVFN_MAX                   256
+
+struct pci_dev {
+	uint16_t bdf;
+};
+
+extern void pci_dev_init(struct pci_dev *dev, pcidevaddr_t bdf);
+
 extern bool pci_probe(void);
 extern void pci_print(void);
 extern bool pci_dev_exists(pcidevaddr_t dev);
@@ -32,15 +40,15 @@ extern pcidevaddr_t pci_find_dev(uint16_t vendor_id, uint16_t device_id);
  * It is expected the caller is aware of the device BAR layout and never
  * tries to address the middle of a 64-bit register.
  */
-extern phys_addr_t pci_bar_get_addr(pcidevaddr_t dev, int bar_num);
-extern void pci_bar_set_addr(pcidevaddr_t dev, int bar_num, phys_addr_t addr);
-extern phys_addr_t pci_bar_size(pcidevaddr_t dev, int bar_num);
-extern uint32_t pci_bar_get(pcidevaddr_t dev, int bar_num);
+extern phys_addr_t pci_bar_get_addr(struct pci_dev *dev, int bar_num);
+extern void pci_bar_set_addr(struct pci_dev *dev, int bar_num, phys_addr_t addr);
+extern phys_addr_t pci_bar_size(struct pci_dev *dev, int bar_num);
+extern uint32_t pci_bar_get(struct pci_dev *dev, int bar_num);
 extern uint32_t pci_bar_mask(uint32_t bar);
-extern bool pci_bar_is64(pcidevaddr_t dev, int bar_num);
-extern bool pci_bar_is_memory(pcidevaddr_t dev, int bar_num);
-extern bool pci_bar_is_valid(pcidevaddr_t dev, int bar_num);
-extern void pci_bar_print(pcidevaddr_t dev, int bar_num);
+extern bool pci_bar_is64(struct pci_dev *dev, int bar_num);
+extern bool pci_bar_is_memory(struct pci_dev *dev, int bar_num);
+extern bool pci_bar_is_valid(struct pci_dev *dev, int bar_num);
+extern void pci_bar_print(struct pci_dev *dev, int bar_num);
 extern void pci_dev_print_id(pcidevaddr_t dev);
 
 extern int pci_testdev(void);
diff --git a/x86/vmexit.c b/x86/vmexit.c
index 2d99d5f..63fa070 100644
--- a/x86/vmexit.c
+++ b/x86/vmexit.c
@@ -372,7 +372,8 @@ int main(int ac, char **av)
 	struct fadt_descriptor_rev1 *fadt;
 	int i;
 	unsigned long membar = 0;
-	pcidevaddr_t pcidev;
+	struct pci_dev pcidev;
+	int ret;
 
 	smp_init();
 	setup_vm();
@@ -385,21 +386,22 @@ int main(int ac, char **av)
 	pm_tmr_blk = fadt->pm_tmr_blk;
 	printf("PM timer port is %x\n", pm_tmr_blk);
 
-	pcidev = pci_find_dev(PCI_VENDOR_ID_REDHAT, PCI_DEVICE_ID_REDHAT_TEST);
-	if (pcidev != PCIDEVADDR_INVALID) {
+	ret = pci_find_dev(PCI_VENDOR_ID_REDHAT, PCI_DEVICE_ID_REDHAT_TEST);
+	if (ret != PCIDEVADDR_INVALID) {
+		pci_dev_init(&pcidev, ret);
 		for (i = 0; i < PCI_TESTDEV_NUM_BARS; i++) {
-			if (!pci_bar_is_valid(pcidev, i)) {
+			if (!pci_bar_is_valid(&pcidev, i)) {
 				continue;
 			}
-			if (pci_bar_is_memory(pcidev, i)) {
-				membar = pci_bar_get_addr(pcidev, i);
+			if (pci_bar_is_memory(&pcidev, i)) {
+				membar = pci_bar_get_addr(&pcidev, i);
 				pci_test.memaddr = ioremap(membar, PAGE_SIZE);
 			} else {
-				pci_test.iobar = pci_bar_get_addr(pcidev, i);
+				pci_test.iobar = pci_bar_get_addr(&pcidev, i);
 			}
 		}
 		printf("pci-testdev at 0x%x membar %lx iobar %x\n",
-		       pcidev, membar, pci_test.iobar);
+		       pcidev.bdf, membar, pci_test.iobar);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(tests); ++i)
-- 
2.7.4
