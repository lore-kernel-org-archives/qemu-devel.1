Received: from eggs.gnu.org ([2001:4830:134:3::10]:50749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqDmt-0001Ch-Ro
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqDmq-0005XH-Hu
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51378 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqDmf-0005CO-HT
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C6DCD4005F79
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 08:37:04 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Aug 2018 10:36:50 +0200
Message-Id: <20180816083701.3932-15-armbru@redhat.com>
In-Reply-To: <20180816083701.3932-1-armbru@redhat.com>
References: <20180816083701.3932-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 14/25] tests: Clean up string interpolation
 around qtest_qmp_device_add()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

Leaving interpolation into JSON to qmp() is more robust than building
QMP input manually, as explained in the commit before previous.

qtest_qmp_device_add() and its wrappers interpolate into JSON as
follows:

* qtest_qmp_device_add() interpolates members into a JSON object.

* So do its wrappers qpci_plug_device_test() and usb_test_hotplug().

* usb_test_hotplug() additionally interpolates strings and numbers
  into JSON strings.

Clean them up:

* Have qtest_qmp_device_add() take its extra device properties as
  arguments for qdict_from_jsonf_nofail() instead of a string
  containing JSON members.

* Drop qpci_plug_device_test(), use qtest_qmp_device_add()
  directly.

* Change usb_test_hotplug() parameter @port to string, to avoid
  interpolation.  Interpolate @hcd_id separately.

Bonus: gets rid of a non-literal format string.  A step towards
compile-time format string checking without triggering
-Wformat-nonliteral.

Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180806065344.7103-15-armbru@redhat.com>
---
 tests/cpu-plug-test.c      |  7 ++++---
 tests/e1000e-test.c        |  6 ++----
 tests/ivshmem-test.c       |  8 +++-----
 tests/libqos/pci.c         |  7 -------
 tests/libqos/pci.h         |  2 --
 tests/libqos/usb.c         | 10 ++++++----
 tests/libqos/usb.h         |  2 +-
 tests/libqtest.c           | 27 +++++++++++----------------
 tests/libqtest.h           |  4 +++-
 tests/usb-hcd-ehci-test.c  |  2 +-
 tests/usb-hcd-ohci-test.c  |  2 +-
 tests/usb-hcd-uhci-test.c  |  4 ++--
 tests/usb-hcd-xhci-test.c  | 10 +++++-----
 tests/virtio-blk-test.c    |  5 +++--
 tests/virtio-net-test.c    |  3 ++-
 tests/virtio-rng-test.c    |  3 ++-
 tests/virtio-scsi-test.c   |  2 +-
 tests/virtio-serial-test.c |  2 +-
 18 files changed, 48 insertions(+), 58 deletions(-)

diff --git a/tests/cpu-plug-test.c b/tests/cpu-plug-test.c
index ab3bf6df90..f5d57da60e 100644
--- a/tests/cpu-plug-test.c
+++ b/tests/cpu-plug-test.c
@@ -88,8 +88,9 @@ static void test_plug_with_device_add_x86(gconstpointer data)
         for (c = 0; c < td->cores; c++) {
             for (t = 0; t < td->threads; t++) {
                 char *id = g_strdup_printf("id-%i-%i-%i", s, c, t);
-                qtest_qmp_device_add(td->device_model, id, "'socket-id':%u, "
-                                     "'core-id':%u, 'thread-id':%u",
+                qtest_qmp_device_add(td->device_model, id,
+                                     "{'socket-id':%u, 'core-id':%u,"
+                                     " 'thread-id':%u}",
                                      s, c, t);
                 g_free(id);
             }
@@ -114,7 +115,7 @@ static void test_plug_with_device_add_coreid(gconstpointer data)
 
     for (c = td->cores; c < td->maxcpus / td->sockets / td->threads; c++) {
         char *id = g_strdup_printf("id-%i", c);
-        qtest_qmp_device_add(td->device_model, id, "'core-id':%u", c);
+        qtest_qmp_device_add(td->device_model, id, "{'core-id':%u}", c);
         g_free(id);
     }
 
diff --git a/tests/e1000e-test.c b/tests/e1000e-test.c
index 32aa738b72..c9408a5d1f 100644
--- a/tests/e1000e-test.c
+++ b/tests/e1000e-test.c
@@ -456,12 +456,10 @@ static void test_e1000e_multiple_transfers(gconstpointer data)
 
 static void test_e1000e_hotplug(gconstpointer data)
 {
-    static const uint8_t slot = 0x06;
-
     qtest_start("-device e1000e");
 
-    qpci_plug_device_test("e1000e", "e1000e_net", slot, NULL);
-    qpci_unplug_acpi_device_test("e1000e_net", slot);
+    qtest_qmp_device_add("e1000e", "e1000e_net", "{'addr': '0x06'}");
+    qpci_unplug_acpi_device_test("e1000e_net", 0x06);
 
     qtest_end();
 }
diff --git a/tests/ivshmem-test.c b/tests/ivshmem-test.c
index 9b407a3e42..c37b196b32 100644
--- a/tests/ivshmem-test.c
+++ b/tests/ivshmem-test.c
@@ -420,19 +420,17 @@ static void test_ivshmem_server_irq(void)
 static void test_ivshmem_hotplug(void)
 {
     const char *arch = qtest_get_arch();
-    gchar *opts;
 
     qtest_start("");
 
-    opts = g_strdup_printf("'shm': '%s', 'size': '1M'", tmpshm);
-
-    qpci_plug_device_test("ivshmem", "iv1", PCI_SLOT_HP, opts);
+    qtest_qmp_device_add("ivshmem",
+                         "iv1", "{'addr': %s, 'shm': %s, 'size': '1M'}",
+                         stringify(PCI_SLOT_HP), tmpshm);
     if (strcmp(arch, "ppc64") != 0) {
         qpci_unplug_acpi_device_test("iv1", PCI_SLOT_HP);
     }
 
     qtest_end();
-    g_free(opts);
 }
 
 static void test_ivshmem_memdev(void)
diff --git a/tests/libqos/pci.c b/tests/libqos/pci.c
index 0b73cb23d0..e8c342c257 100644
--- a/tests/libqos/pci.c
+++ b/tests/libqos/pci.c
@@ -395,10 +395,3 @@ QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr)
     QPCIBar bar = { .addr = addr };
     return bar;
 }
-
-void qpci_plug_device_test(const char *driver, const char *id,
-                           uint8_t slot, const char *opts)
-{
-    qtest_qmp_device_add(driver, id, "'addr': '%d'%s%s", slot,
-                         opts ? ", " : "", opts ? opts : "");
-}
diff --git a/tests/libqos/pci.h b/tests/libqos/pci.h
index 429c382282..0b7e936174 100644
--- a/tests/libqos/pci.h
+++ b/tests/libqos/pci.h
@@ -109,7 +109,5 @@ QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr);
 void qpci_iounmap(QPCIDevice *dev, QPCIBar addr);
 QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr);
 
-void qpci_plug_device_test(const char *driver, const char *id,
-                           uint8_t slot, const char *opts);
 void qpci_unplug_acpi_device_test(const char *id, uint8_t slot);
 #endif
diff --git a/tests/libqos/usb.c b/tests/libqos/usb.c
index 2a476049a8..49e2f4bc0a 100644
--- a/tests/libqos/usb.c
+++ b/tests/libqos/usb.c
@@ -37,13 +37,14 @@ void uhci_port_test(struct qhc *hc, int port, uint16_t expect)
     g_assert((value & mask) == (expect & mask));
 }
 
-void usb_test_hotplug(const char *hcd_id, const int port,
+void usb_test_hotplug(const char *hcd_id, const char *port,
                       void (*port_check)(void))
 {
-    char  *id = g_strdup_printf("usbdev%d", port);
+    char *id = g_strdup_printf("usbdev%s", port);
+    char *bus = g_strdup_printf("%s.0", hcd_id);
 
-    qtest_qmp_device_add("usb-tablet", id, "'port': '%d', 'bus': '%s.0'",
-                         port, hcd_id);
+    qtest_qmp_device_add("usb-tablet", id, "{'port': %s, 'bus': %s}",
+                         port, bus);
 
     if (port_check) {
         port_check();
@@ -51,5 +52,6 @@ void usb_test_hotplug(const char *hcd_id, const int port,
 
     qtest_qmp_device_del(id);
 
+    g_free(bus);
     g_free(id);
 }
diff --git a/tests/libqos/usb.h b/tests/libqos/usb.h
index 297cfc564d..c506418a13 100644
--- a/tests/libqos/usb.h
+++ b/tests/libqos/usb.h
@@ -13,6 +13,6 @@ void qusb_pci_init_one(QPCIBus *pcibus, struct qhc *hc,
 void uhci_port_test(struct qhc *hc, int port, uint16_t expect);
 void uhci_deinit(struct qhc *hc);
 
-void usb_test_hotplug(const char *bus_name, const int port,
+void usb_test_hotplug(const char *bus_name, const char *port,
                       void (*port_check)(void));
 #endif
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 81b17f6fc9..17c91f5c47 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -1007,26 +1007,21 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine))
 /*
  * Generic hot-plugging test via the device_add QMP command.
  */
-void qtest_qmp_device_add(const char *driver, const char *id, const char *fmt,
-                          ...)
+void qtest_qmp_device_add(const char *driver, const char *id,
+                          const char *fmt, ...)
 {
-    QDict *response;
-    char *cmd, *opts = NULL;
-    va_list va;
+    QDict *args, *response;
+    va_list ap;
 
-    if (fmt) {
-        va_start(va, fmt);
-        opts = g_strdup_vprintf(fmt, va);
-        va_end(va);
-    }
+    va_start(ap, fmt);
+    args = qdict_from_vjsonf_nofail(fmt, ap);
+    va_end(ap);
 
-    cmd = g_strdup_printf("{'execute': 'device_add',"
-                          " 'arguments': { 'driver': '%s', 'id': '%s'%s%s }}",
-                          driver, id, opts ? ", " : "", opts ? opts : "");
-    g_free(opts);
+    g_assert(!qdict_haskey(args, "driver") && !qdict_haskey(args, "id"));
+    qdict_put_str(args, "driver", driver);
+    qdict_put_str(args, "id", id);
 
-    response = qmp(cmd);
-    g_free(cmd);
+    response = qmp("{'execute': 'device_add', 'arguments': %p}", args);
     g_assert(response);
     g_assert(!qdict_haskey(response, "event")); /* We don't expect any events */
     g_assert(!qdict_haskey(response, "error"));
diff --git a/tests/libqtest.h b/tests/libqtest.h
index 0eff8763ce..70e9c5157c 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -943,7 +943,9 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine));
  * qtest_qmp_device_add:
  * @driver: Name of the device that should be added
  * @id: Identification string
- * @fmt: printf-like format string for further options to device_add
+ * @fmt...: QMP message to send to qemu, formatted like
+ * qobject_from_jsonf_nofail().  See parse_escape() for what's
+ * supported after '%'.
  *
  * Generic hot-plugging test via the device_add QMP command.
  */
diff --git a/tests/usb-hcd-ehci-test.c b/tests/usb-hcd-ehci-test.c
index 55d4743a2a..f28ea27f37 100644
--- a/tests/usb-hcd-ehci-test.c
+++ b/tests/usb-hcd-ehci-test.c
@@ -139,7 +139,7 @@ static void pci_ehci_port_3_hotplug(void)
 
 static void pci_ehci_port_hotplug(void)
 {
-    usb_test_hotplug("ich9-ehci-1", 3, pci_ehci_port_3_hotplug);
+    usb_test_hotplug("ich9-ehci-1", "3", pci_ehci_port_3_hotplug);
 }
 
 
diff --git a/tests/usb-hcd-ohci-test.c b/tests/usb-hcd-ohci-test.c
index 4758813d78..48ddbfd26d 100644
--- a/tests/usb-hcd-ohci-test.c
+++ b/tests/usb-hcd-ohci-test.c
@@ -19,7 +19,7 @@ static void test_ohci_init(void)
 
 static void test_ohci_hotplug(void)
 {
-    usb_test_hotplug("ohci", 1, NULL);
+    usb_test_hotplug("ohci", "1", NULL);
 }
 
 int main(int argc, char **argv)
diff --git a/tests/usb-hcd-uhci-test.c b/tests/usb-hcd-uhci-test.c
index 6a7e5a2fed..a119d6d5c8 100644
--- a/tests/usb-hcd-uhci-test.c
+++ b/tests/usb-hcd-uhci-test.c
@@ -43,12 +43,12 @@ static void test_port_2(void)
 
 static void test_uhci_hotplug(void)
 {
-    usb_test_hotplug("uhci", 2, test_port_2);
+    usb_test_hotplug("uhci", "2", test_port_2);
 }
 
 static void test_usb_storage_hotplug(void)
 {
-    qtest_qmp_device_add("usb-storage", "usbdev0", "'drive': 'drive0'");
+    qtest_qmp_device_add("usb-storage", "usbdev0", "{'drive': 'drive0'}");
 
     qtest_qmp_device_del("usbdev0");
 }
diff --git a/tests/usb-hcd-xhci-test.c b/tests/usb-hcd-xhci-test.c
index 5b1b681bf2..9eb24b00e4 100644
--- a/tests/usb-hcd-xhci-test.c
+++ b/tests/usb-hcd-xhci-test.c
@@ -18,13 +18,13 @@ static void test_xhci_init(void)
 
 static void test_xhci_hotplug(void)
 {
-    usb_test_hotplug("xhci", 1, NULL);
+    usb_test_hotplug("xhci", "1", NULL);
 }
 
 static void test_usb_uas_hotplug(void)
 {
-    qtest_qmp_device_add("usb-uas", "uas", NULL);
-    qtest_qmp_device_add("scsi-hd", "scsihd", "'drive': 'drive0'");
+    qtest_qmp_device_add("usb-uas", "uas", "{}");
+    qtest_qmp_device_add("scsi-hd", "scsihd", "{'drive': 'drive0'}");
 
     /* TODO:
         UAS HBA driver in libqos, to check that
@@ -37,10 +37,10 @@ static void test_usb_uas_hotplug(void)
 
 static void test_usb_ccid_hotplug(void)
 {
-    qtest_qmp_device_add("usb-ccid", "ccid", NULL);
+    qtest_qmp_device_add("usb-ccid", "ccid", "{}");
     qtest_qmp_device_del("ccid");
     /* check the device can be added again */
-    qtest_qmp_device_add("usb-ccid", "ccid", NULL);
+    qtest_qmp_device_add("usb-ccid", "ccid", "{}");
     qtest_qmp_device_del("ccid");
 }
 
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 06226b8717..571489d763 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -666,8 +666,9 @@ static void pci_hotplug(void)
     qs = pci_test_start();
 
     /* plug secondary disk */
-    qpci_plug_device_test("virtio-blk-pci", "drv1", PCI_SLOT_HP,
-                          "'drive': 'drive1'");
+    qtest_qmp_device_add("virtio-blk-pci", "drv1",
+                         "{'addr': %s, 'drive': 'drive1'}",
+                         stringify(PCI_SLOT_HP));
 
     dev = virtio_blk_pci_init(qs->pcibus, PCI_SLOT_HP);
     g_assert(dev);
diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index b285a262e9..dcb87a8b6e 100644
--- a/tests/virtio-net-test.c
+++ b/tests/virtio-net-test.c
@@ -249,7 +249,8 @@ static void hotplug(void)
 
     qtest_start("-device virtio-net-pci");
 
-    qpci_plug_device_test("virtio-net-pci", "net1", PCI_SLOT_HP, NULL);
+    qtest_qmp_device_add("virtio-net-pci", "net1",
+                         "{'addr': %s}", stringify(PCI_SLOT_HP));
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         qpci_unplug_acpi_device_test("net1", PCI_SLOT_HP);
diff --git a/tests/virtio-rng-test.c b/tests/virtio-rng-test.c
index dcecf77463..657d9a4105 100644
--- a/tests/virtio-rng-test.c
+++ b/tests/virtio-rng-test.c
@@ -22,7 +22,8 @@ static void hotplug(void)
 {
     const char *arch = qtest_get_arch();
 
-    qpci_plug_device_test("virtio-rng-pci", "rng1", PCI_SLOT_HP, NULL);
+    qtest_qmp_device_add("virtio-rng-pci", "rng1",
+                         "{'addr': %s}", stringify(PCI_SLOT_HP));
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         qpci_unplug_acpi_device_test("rng1", PCI_SLOT_HP);
diff --git a/tests/virtio-scsi-test.c b/tests/virtio-scsi-test.c
index 037872bb98..0d4f25d369 100644
--- a/tests/virtio-scsi-test.c
+++ b/tests/virtio-scsi-test.c
@@ -199,7 +199,7 @@ static void hotplug(void)
 
     qs = qvirtio_scsi_start(
             "-drive id=drv1,if=none,file=null-co://,format=raw");
-    qtest_qmp_device_add("scsi-hd", "scsihd", "'drive': 'drv1'");
+    qtest_qmp_device_add("scsi-hd", "scsihd", "{'drive': 'drv1'}");
     qtest_qmp_device_del("scsihd");
     qvirtio_scsi_stop(qs);
 }
diff --git a/tests/virtio-serial-test.c b/tests/virtio-serial-test.c
index 7cc7060264..e4b18b1c8a 100644
--- a/tests/virtio-serial-test.c
+++ b/tests/virtio-serial-test.c
@@ -18,7 +18,7 @@ static void virtio_serial_nop(void)
 
 static void hotplug(void)
 {
-    qtest_qmp_device_add("virtserialport", "hp-port", NULL);
+    qtest_qmp_device_add("virtserialport", "hp-port", "{}");
 
     qtest_qmp_device_del("hp-port");
 }
-- 
2.17.1
