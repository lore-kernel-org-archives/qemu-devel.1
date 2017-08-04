Received: from eggs.gnu.org ([2001:4830:134:3::10]:60528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRNo-0000Ab-1O
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRNm-0004fX-QT
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:31 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu,  3 Aug 2017 20:25:49 -0500
Message-Id: <20170804012551.2714-21-eblake@redhat.com>
In-Reply-To: <20170804012551.2714-1-eblake@redhat.com>
References: <20170804012551.2714-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 20/22] tests/libqos/pci: Clean up string
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
Cc: armbru@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, "open list:virtio-blk" <qemu-block@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

Leaving interpolation into JSON to qmp() is more robust than building
QMP input manually, as explained in previous commits.

The case in qpci_plug_device_test() is a bit complicated: it
interpolates several JSON object members, not just a value.  Clean it
up by passing them in as QDict rather than string, so we can leave
interpolation to qmp() here and to qobject_from_jsonf() in callers.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1500645206-13559-7-git-send-email-armbru@redhat.com>
[use qmp_args_dict for a slightly smaller diff, fix '%s' typo in ivshmem-test]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqos/pci.h      |  2 +-
 tests/ivshmem-test.c    | 10 +++++-----
 tests/libqos/pci.c      | 32 +++++++++++++++++---------------
 tests/virtio-blk-test.c |  5 ++++-
 4 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/tests/libqos/pci.h b/tests/libqos/pci.h
index ed480614ff..c981061703 100644
--- a/tests/libqos/pci.h
+++ b/tests/libqos/pci.h
@@ -109,6 +109,6 @@ void qpci_iounmap(QPCIDevice *dev, QPCIBar addr);
 QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr);

 void qpci_plug_device_test(const char *driver, const char *id,
-                           uint8_t slot, const char *opts);
+                           uint8_t slot, QDict *extra_args);
 void qpci_unplug_acpi_device_test(const char *id, uint8_t slot);
 #endif
diff --git a/tests/ivshmem-test.c b/tests/ivshmem-test.c
index 37763425ee..4cb5a030da 100644
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
+    QObject *extra_args = qobject_from_jsonf("{ 'shm': %s, 'size': '1M' }",
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
index 2dcdeade2a..68623795b7 100644
--- a/tests/libqos/pci.c
+++ b/tests/libqos/pci.c
@@ -14,6 +14,7 @@
 #include "libqos/pci.h"

 #include "hw/pci/pci_regs.h"
+#include "qapi/qmp/qjson.h"
 #include "qemu/host-utils.h"

 void qpci_device_foreach(QPCIBus *bus, int vendor_id, int device_id,
@@ -392,22 +393,23 @@ QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr)
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
+    response = qmp_args_dict("device_add", args);
+
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 649ba03c92..78a9ebfb0d 100644
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
@@ -656,12 +657,13 @@ static void pci_hotplug(void)
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
@@ -672,6 +674,7 @@ static void pci_hotplug(void)
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         qpci_unplug_acpi_device_test("drv1", PCI_SLOT_HP);
     }
+
     qtest_shutdown(qs);
 }

-- 
2.13.3
