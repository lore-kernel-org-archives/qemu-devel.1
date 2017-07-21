Received: from eggs.gnu.org ([2001:4830:134:3::10]:48322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dYYN2-0007g2-Tv
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:53:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dYYN1-00046K-JJ
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:53:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dYYN1-00045T-9w
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:53:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3CD0F461FE
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 13:53:30 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 21 Jul 2017 15:53:23 +0200
Message-Id: <1500645206-13559-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1500645206-13559-1-git-send-email-armbru@redhat.com>
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 6/9] tests/libqos/pci: Clean up string
 interpolation into QMP input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Leaving interpolation into JSON to qmp() is more robust than building
QMP input manually, as explained in the commit before previous.

The case in qpci_plug_device_test() is a bit complicated: it
interpolates several JSON object members, not just a value.  Clean it
up by passing them in as QDict rather than string, so we can leave
interpolation to qmp() here and to qobject_from_jsonf() in callers.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/ivshmem-test.c    | 10 +++++-----
 tests/libqos/pci.c      | 33 ++++++++++++++++++---------------
 tests/libqos/pci.h      |  2 +-
 tests/virtio-blk-test.c |  5 ++++-
 4 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/tests/ivshmem-test.c b/tests/ivshmem-test.c
index 3776342..38044bb 100644
--- a/tests/ivshmem-test.c
+++ b/tests/ivshmem-test.c
@@ -14,6 +14,7 @@
 #include "libqos/libqos-pc.h"
 #include "libqos/libqos-spapr.h"
 #include "libqtest.h"
+#include "qapi/qmp/qjson.h"
 #include "qemu-common.h"
 
 #define TMPSHMSIZE (1 << 20)
@@ -419,19 +420,18 @@ static void test_ivshmem_server_irq(void)
 static void test_ivshmem_hotplug(void)
 {
     const char *arch = qtest_get_arch();
-    gchar *opts;
+    QObject *extra_args = qobject_from_jsonf("{ 'shm': '%s', 'size': '1M' }",
+                                             tmpshm);
 
     qtest_start("");
 
-    opts = g_strdup_printf("'shm': '%s', 'size': '1M'", tmpshm);
-
-    qpci_plug_device_test("ivshmem", "iv1", PCI_SLOT_HP, opts);
+    qpci_plug_device_test("ivshmem", "iv1", PCI_SLOT_HP,
+                          qobject_to_qdict(extra_args));
     if (strcmp(arch, "ppc64") != 0) {
         qpci_unplug_acpi_device_test("iv1", PCI_SLOT_HP);
     }
 
     qtest_end();
-    g_free(opts);
 }
 
 static void test_ivshmem_memdev(void)
diff --git a/tests/libqos/pci.c b/tests/libqos/pci.c
index 2dcdead..4068305 100644
--- a/tests/libqos/pci.c
+++ b/tests/libqos/pci.c
@@ -14,6 +14,7 @@
 #include "libqos/pci.h"
 
 #include "hw/pci/pci_regs.h"
+#include "qapi/qmp/qjson.h"
 #include "qemu/host-utils.h"
 
 void qpci_device_foreach(QPCIBus *bus, int vendor_id, int device_id,
@@ -392,23 +393,25 @@ QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr)
 }
 
 void qpci_plug_device_test(const char *driver, const char *id,
-                           uint8_t slot, const char *opts)
+                           uint8_t slot, QDict *extra_args)
 {
-    QDict *response;
-    char *cmd;
-
-    cmd = g_strdup_printf("{'execute': 'device_add',"
-                          " 'arguments': {"
-                          "   'driver': '%s',"
-                          "   'addr': '%d',"
-                          "   %s%s"
-                          "   'id': '%s'"
-                          "}}", driver, slot,
-                          opts ? opts : "", opts ? "," : "",
-                          id);
-    response = qmp(cmd);
-    g_free(cmd);
+    char addr[8];
+    QDict *args, *response;
+
+    sprintf(addr, "%d", slot);
+    args = qobject_to_qdict(
+        qobject_from_jsonf("{ 'driver': %s, 'addr': %s, 'id': %s}",
+                           driver, addr, id));
+
+    if (extra_args) {
+        qdict_join(args, extra_args, true);
+        QDECREF(extra_args);
+    }
+
+    response = qmp("{'execute': 'device_add', 'arguments': %p }", args);
+
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
+    QDECREF(args);
     QDECREF(response);
 }
diff --git a/tests/libqos/pci.h b/tests/libqos/pci.h
index ed48061..c981061 100644
--- a/tests/libqos/pci.h
+++ b/tests/libqos/pci.h
@@ -109,6 +109,6 @@ void qpci_iounmap(QPCIDevice *dev, QPCIBar addr);
 QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr);
 
 void qpci_plug_device_test(const char *driver, const char *id,
-                           uint8_t slot, const char *opts);
+                           uint8_t slot, QDict *extra_args);
 void qpci_unplug_acpi_device_test(const char *id, uint8_t slot);
 #endif
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 0576cb1..64a48f4 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -16,6 +16,7 @@
 #include "libqos/virtio-pci.h"
 #include "libqos/virtio-mmio.h"
 #include "libqos/malloc-generic.h"
+#include "qapi/qmp/qjson.h"
 #include "qemu/bswap.h"
 #include "standard-headers/linux/virtio_ids.h"
 #include "standard-headers/linux/virtio_config.h"
@@ -658,12 +659,13 @@ static void pci_hotplug(void)
     QVirtioPCIDevice *dev;
     QOSState *qs;
     const char *arch = qtest_get_arch();
+    QObject *extra_args = qobject_from_jsonf("{ 'drive': 'drive1' }");
 
     qs = pci_test_start();
 
     /* plug secondary disk */
     qpci_plug_device_test("virtio-blk-pci", "drv1", PCI_SLOT_HP,
-                          "'drive': 'drive1'");
+                          qobject_to_qdict(extra_args));
 
     dev = virtio_blk_pci_init(qs->pcibus, PCI_SLOT_HP);
     g_assert(dev);
@@ -674,6 +676,7 @@ static void pci_hotplug(void)
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         qpci_unplug_acpi_device_test("drv1", PCI_SLOT_HP);
     }
+
     qtest_shutdown(qs);
 }
 
-- 
2.7.5
