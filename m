Received: from eggs.gnu.org ([2001:4830:134:3::10]:38419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSOJ-0007G8-Ja
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSOH-0001B7-BE
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:20:59 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 11 Sep 2017 12:19:55 -0500
Message-Id: <20170911172022.4738-12-eblake@redhat.com>
In-Reply-To: <20170911172022.4738-1-eblake@redhat.com>
References: <20170911172022.4738-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 11/38] libqos: Use explicit QTestState for
 pci operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, thuth@redhat.com, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, Amit Shah <amit@kernel.org>, "open list:sPAPR" <qemu-ppc@nongnu.org>, "open list:virtio-blk" <qemu-block@nongnu.org>

Now that the QPCIBus tracks QTestState, use that state instead
of an implicit reliance on global_qtest.

Pass an explicit QTestState to the remaining few functions in
the same file that don't have direct access to QPCIBus, and
update all callers.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v7: more sites with explicit state, drop R-b
---
 tests/libqos/pci.h       |  4 ++--
 tests/e1000e-test.c      |  4 ++--
 tests/ivshmem-test.c     |  4 ++--
 tests/libqos/pci-pc.c    | 47 ++++++++++++++++++++++++-----------------------
 tests/libqos/pci-spapr.c | 20 ++++++++++----------
 tests/libqos/pci.c       | 19 +++++++------------
 tests/virtio-blk-test.c  |  4 ++--
 tests/virtio-net-test.c  |  5 +++--
 tests/virtio-rng-test.c  |  5 +++--
 9 files changed, 55 insertions(+), 57 deletions(-)

diff --git a/tests/libqos/pci.h b/tests/libqos/pci.h
index fdda7eca6e..2943186819 100644
--- a/tests/libqos/pci.h
+++ b/tests/libqos/pci.h
@@ -109,7 +109,7 @@ QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr);
 void qpci_iounmap(QPCIDevice *dev, QPCIBar addr);
 QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr);

-void qpci_plug_device_test(const char *driver, const char *id,
+void qpci_plug_device_test(QTestState *qts, const char *driver, const char *id,
                            uint8_t slot, const char *opts);
-void qpci_unplug_device_test(const char *id, uint8_t slot);
+void qpci_unplug_device_test(QTestState *qts, const char *id, uint8_t slot);
 #endif
diff --git a/tests/e1000e-test.c b/tests/e1000e-test.c
index 4c663a3019..3cc081941e 100644
--- a/tests/e1000e-test.c
+++ b/tests/e1000e-test.c
@@ -460,8 +460,8 @@ static void test_e1000e_hotplug(gconstpointer data)

     qtest_start("-device e1000e");

-    qpci_plug_device_test("e1000e", "e1000e_net", slot, NULL);
-    qpci_unplug_device_test("e1000e_net", slot);
+    qpci_plug_device_test(global_qtest, "e1000e", "e1000e_net", slot, NULL);
+    qpci_unplug_device_test(global_qtest, "e1000e_net", slot);

     qtest_end();
 }
diff --git a/tests/ivshmem-test.c b/tests/ivshmem-test.c
index 8c9ed6a568..d35c922254 100644
--- a/tests/ivshmem-test.c
+++ b/tests/ivshmem-test.c
@@ -425,9 +425,9 @@ static void test_ivshmem_hotplug(void)

     opts = g_strdup_printf("'shm': '%s', 'size': '1M'", tmpshm);

-    qpci_plug_device_test("ivshmem", "iv1", PCI_SLOT_HP, opts);
+    qpci_plug_device_test(global_qtest, "ivshmem", "iv1", PCI_SLOT_HP, opts);
     if (strcmp(arch, "ppc64") != 0) {
-        qpci_unplug_device_test("iv1", PCI_SLOT_HP);
+        qpci_unplug_device_test(global_qtest, "iv1", PCI_SLOT_HP);
     }

     qtest_end();
diff --git a/tests/libqos/pci-pc.c b/tests/libqos/pci-pc.c
index 6305d142a5..e5af083f0c 100644
--- a/tests/libqos/pci-pc.c
+++ b/tests/libqos/pci-pc.c
@@ -26,90 +26,91 @@ typedef struct QPCIBusPC

 static uint8_t qpci_pc_pio_readb(QPCIBus *bus, uint32_t addr)
 {
-    return inb(addr);
+    return qtest_inb(bus->qts, addr);
 }

 static void qpci_pc_pio_writeb(QPCIBus *bus, uint32_t addr, uint8_t val)
 {
-    outb(addr, val);
+    qtest_outb(bus->qts, addr, val);
 }

 static uint16_t qpci_pc_pio_readw(QPCIBus *bus, uint32_t addr)
 {
-    return inw(addr);
+    return qtest_inw(bus->qts, addr);
 }

 static void qpci_pc_pio_writew(QPCIBus *bus, uint32_t addr, uint16_t val)
 {
-    outw(addr, val);
+    qtest_outw(bus->qts, addr, val);
 }

 static uint32_t qpci_pc_pio_readl(QPCIBus *bus, uint32_t addr)
 {
-    return inl(addr);
+    return qtest_inl(bus->qts, addr);
 }

 static void qpci_pc_pio_writel(QPCIBus *bus, uint32_t addr, uint32_t val)
 {
-    outl(addr, val);
+    qtest_outl(bus->qts, addr, val);
 }

 static uint64_t qpci_pc_pio_readq(QPCIBus *bus, uint32_t addr)
 {
-    return (uint64_t)inl(addr) + ((uint64_t)inl(addr + 4) << 32);
+    return (uint64_t)qtest_inl(bus->qts, addr) +
+        ((uint64_t)qtest_inl(bus->qts, addr + 4) << 32);
 }

 static void qpci_pc_pio_writeq(QPCIBus *bus, uint32_t addr, uint64_t val)
 {
-    outl(addr, val & 0xffffffff);
-    outl(addr + 4, val >> 32);
+    qtest_outl(bus->qts, addr, val & 0xffffffff);
+    qtest_outl(bus->qts, addr + 4, val >> 32);
 }

 static void qpci_pc_memread(QPCIBus *bus, uint32_t addr, void *buf, size_t len)
 {
-    memread(addr, buf, len);
+    qtest_memread(bus->qts, addr, buf, len);
 }

 static void qpci_pc_memwrite(QPCIBus *bus, uint32_t addr,
                              const void *buf, size_t len)
 {
-    memwrite(addr, buf, len);
+    qtest_memwrite(bus->qts, addr, buf, len);
 }

 static uint8_t qpci_pc_config_readb(QPCIBus *bus, int devfn, uint8_t offset)
 {
-    outl(0xcf8, (1U << 31) | (devfn << 8) | offset);
-    return inb(0xcfc);
+    qtest_outl(bus->qts, 0xcf8, (1U << 31) | (devfn << 8) | offset);
+    return qtest_inb(bus->qts, 0xcfc);
 }

 static uint16_t qpci_pc_config_readw(QPCIBus *bus, int devfn, uint8_t offset)
 {
-    outl(0xcf8, (1U << 31) | (devfn << 8) | offset);
-    return inw(0xcfc);
+    qtest_outl(bus->qts, 0xcf8, (1U << 31) | (devfn << 8) | offset);
+    return qtest_inw(bus->qts, 0xcfc);
 }

 static uint32_t qpci_pc_config_readl(QPCIBus *bus, int devfn, uint8_t offset)
 {
-    outl(0xcf8, (1U << 31) | (devfn << 8) | offset);
-    return inl(0xcfc);
+    qtest_outl(bus->qts, 0xcf8, (1U << 31) | (devfn << 8) | offset);
+    return qtest_inl(bus->qts, 0xcfc);
 }

 static void qpci_pc_config_writeb(QPCIBus *bus, int devfn, uint8_t offset, uint8_t value)
 {
-    outl(0xcf8, (1U << 31) | (devfn << 8) | offset);
-    outb(0xcfc, value);
+    qtest_outl(bus->qts, 0xcf8, (1U << 31) | (devfn << 8) | offset);
+    qtest_outb(bus->qts, 0xcfc, value);
 }

 static void qpci_pc_config_writew(QPCIBus *bus, int devfn, uint8_t offset, uint16_t value)
 {
-    outl(0xcf8, (1U << 31) | (devfn << 8) | offset);
-    outw(0xcfc, value);
+    qtest_outl(bus->qts, 0xcf8, (1U << 31) | (devfn << 8) | offset);
+    qtest_outw(bus->qts, 0xcfc, value);
 }

 static void qpci_pc_config_writel(QPCIBus *bus, int devfn, uint8_t offset, uint32_t value)
 {
-    outl(0xcf8, (1U << 31) | (devfn << 8) | offset);
-    outl(0xcfc, value);
+    qtest_outl(bus->qts, 0xcf8, (1U << 31) | (devfn << 8) | offset);
+    qtest_outl(bus->qts, 0xcfc, value);
 }

 QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc)
diff --git a/tests/libqos/pci-spapr.c b/tests/libqos/pci-spapr.c
index ef52fcbe2b..9121913af6 100644
--- a/tests/libqos/pci-spapr.c
+++ b/tests/libqos/pci-spapr.c
@@ -45,63 +45,63 @@ typedef struct QPCIBusSPAPR {
 static uint8_t qpci_spapr_pio_readb(QPCIBus *bus, uint32_t addr)
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
-    return readb(s->pio_cpu_base + addr);
+    return qtest_readb(bus->qts, s->pio_cpu_base + addr);
 }

 static void qpci_spapr_pio_writeb(QPCIBus *bus, uint32_t addr, uint8_t val)
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
-    writeb(s->pio_cpu_base + addr, val);
+    qtest_writeb(bus->qts, s->pio_cpu_base + addr, val);
 }

 static uint16_t qpci_spapr_pio_readw(QPCIBus *bus, uint32_t addr)
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
-    return bswap16(readw(s->pio_cpu_base + addr));
+    return bswap16(qtest_readw(bus->qts, s->pio_cpu_base + addr));
 }

 static void qpci_spapr_pio_writew(QPCIBus *bus, uint32_t addr, uint16_t val)
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
-    writew(s->pio_cpu_base + addr, bswap16(val));
+    qtest_writew(bus->qts, s->pio_cpu_base + addr, bswap16(val));
 }

 static uint32_t qpci_spapr_pio_readl(QPCIBus *bus, uint32_t addr)
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
-    return bswap32(readl(s->pio_cpu_base + addr));
+    return bswap32(qtest_readl(bus->qts, s->pio_cpu_base + addr));
 }

 static void qpci_spapr_pio_writel(QPCIBus *bus, uint32_t addr, uint32_t val)
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
-    writel(s->pio_cpu_base + addr, bswap32(val));
+    qtest_writel(bus->qts, s->pio_cpu_base + addr, bswap32(val));
 }

 static uint64_t qpci_spapr_pio_readq(QPCIBus *bus, uint32_t addr)
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
-    return bswap64(readq(s->pio_cpu_base + addr));
+    return bswap64(qtest_readq(bus->qts, s->pio_cpu_base + addr));
 }

 static void qpci_spapr_pio_writeq(QPCIBus *bus, uint32_t addr, uint64_t val)
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
-    writeq(s->pio_cpu_base + addr, bswap64(val));
+    qtest_writeq(bus->qts, s->pio_cpu_base + addr, bswap64(val));
 }

 static void qpci_spapr_memread(QPCIBus *bus, uint32_t addr,
                                void *buf, size_t len)
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
-    memread(s->mmio32_cpu_base + addr, buf, len);
+    qtest_memread(bus->qts, s->mmio32_cpu_base + addr, buf, len);
 }

 static void qpci_spapr_memwrite(QPCIBus *bus, uint32_t addr,
                                 const void *buf, size_t len)
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
-    memwrite(s->mmio32_cpu_base + addr, buf, len);
+    qtest_memwrite(bus->qts, s->mmio32_cpu_base + addr, buf, len);
 }

 static uint8_t qpci_spapr_config_readb(QPCIBus *bus, int devfn, uint8_t offset)
diff --git a/tests/libqos/pci.c b/tests/libqos/pci.c
index 9f36ec73ef..d3ee21fdfd 100644
--- a/tests/libqos/pci.c
+++ b/tests/libqos/pci.c
@@ -394,7 +394,7 @@ QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr)
     return bar;
 }

-void qpci_plug_device_test(const char *driver, const char *id,
+void qpci_plug_device_test(QTestState *qts, const char *driver, const char *id,
                            uint8_t slot, const char *opts)
 {
     QDict *response;
@@ -409,29 +409,24 @@ void qpci_plug_device_test(const char *driver, const char *id,
                           "}}", driver, slot,
                           opts ? opts : "", opts ? "," : "",
                           id);
-    response = qmp(cmd);
+    response = qtest_qmp(qts, cmd);
     g_free(cmd);
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);
 }

-void qpci_unplug_device_test(const char *id, uint8_t slot)
+void qpci_unplug_device_test(QTestState *qts, const char *id, uint8_t slot)
 {
     QDict *response;
-    char *cmd;

-    cmd = g_strdup_printf("{'execute': 'device_del',"
-                          " 'arguments': {"
-                          "   'id': '%s'"
-                          "}}", id);
-    response = qmp(cmd);
-    g_free(cmd);
+    response = qtest_qmp(qts, "{'execute': 'device_del',"
+                         " 'arguments': { 'id': %s }}", id);
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);

-    outb(ACPI_PCIHP_ADDR + PCI_EJ_BASE, 1 << slot);
+    qtest_outb(qts, ACPI_PCIHP_ADDR + PCI_EJ_BASE, 1 << slot);

-    qmp_eventwait("DEVICE_DELETED");
+    qtest_qmp_eventwait(qts, "DEVICE_DELETED");
 }
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 8441ab91ed..2d38c49bfe 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -662,7 +662,7 @@ static void pci_hotplug(void)
     qs = pci_test_start();

     /* plug secondary disk */
-    qpci_plug_device_test("virtio-blk-pci", "drv1", PCI_SLOT_HP,
+    qpci_plug_device_test(global_qtest, "virtio-blk-pci", "drv1", PCI_SLOT_HP,
                           "'drive': 'drive1'");

     dev = virtio_blk_pci_init(qs->pcibus, PCI_SLOT_HP);
@@ -672,7 +672,7 @@ static void pci_hotplug(void)

     /* unplug secondary disk */
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        qpci_unplug_device_test("drv1", PCI_SLOT_HP);
+        qpci_unplug_device_test(global_qtest, "drv1", PCI_SLOT_HP);
     }
     qtest_shutdown(qs);
 }
diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index 24e0f774f0..8b43d3dd65 100644
--- a/tests/virtio-net-test.c
+++ b/tests/virtio-net-test.c
@@ -245,10 +245,11 @@ static void hotplug(void)

     qtest_start("-device virtio-net-pci");

-    qpci_plug_device_test("virtio-net-pci", "net1", PCI_SLOT_HP, NULL);
+    qpci_plug_device_test(global_qtest, "virtio-net-pci", "net1",
+                          PCI_SLOT_HP, NULL);

     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        qpci_unplug_device_test("net1", PCI_SLOT_HP);
+        qpci_unplug_device_test(global_qtest, "net1", PCI_SLOT_HP);
     }

     test_end();
diff --git a/tests/virtio-rng-test.c b/tests/virtio-rng-test.c
index fc4a36474b..0e21125cb4 100644
--- a/tests/virtio-rng-test.c
+++ b/tests/virtio-rng-test.c
@@ -22,10 +22,11 @@ static void hotplug(void)
 {
     const char *arch = qtest_get_arch();

-    qpci_plug_device_test("virtio-rng-pci", "rng1", PCI_SLOT_HP, NULL);
+    qpci_plug_device_test(global_qtest, "virtio-rng-pci", "rng1",
+                          PCI_SLOT_HP, NULL);

     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        qpci_unplug_device_test("rng1", PCI_SLOT_HP);
+        qpci_unplug_device_test(global_qtest, "rng1", PCI_SLOT_HP);
     }
 }

-- 
2.13.5
