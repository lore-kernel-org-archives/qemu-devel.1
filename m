Received: from eggs.gnu.org ([2001:4830:134:3::10]:55906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqIc-0007Fo-NG
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:04:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqIb-0001jy-A6
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:04:10 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri,  1 Sep 2017 13:03:26 -0500
Message-Id: <20170901180340.30009-16-eblake@redhat.com>
In-Reply-To: <20170901180340.30009-1-eblake@redhat.com>
References: <20170901180340.30009-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v6 15/29] libqos: Use explicit QTestState for
 rtas operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, "open list:sPAPR" <qemu-ppc@nongnu.org>

Drop one more client of global_qtest by teaching all rtas test
functionality to pass in an explicit QTestState, adjusting all
callers.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqos/rtas.h      |  9 ++++++---
 tests/libqos/pci-spapr.c | 18 ++++++++++++------
 tests/libqos/rtas.c      | 21 ++++++++++++---------
 tests/rtas-test.c        |  2 +-
 4 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/tests/libqos/rtas.h b/tests/libqos/rtas.h
index 498eb19230..e3d0f850a7 100644
--- a/tests/libqos/rtas.h
+++ b/tests/libqos/rtas.h
@@ -7,9 +7,12 @@
 #define LIBQOS_RTAS_H
 #include "libqos/malloc.h"

-int qrtas_get_time_of_day(QGuestAllocator *alloc, struct tm *tm, uint32_t *ns);
-uint32_t qrtas_ibm_read_pci_config(QGuestAllocator *alloc, uint64_t buid,
+int qrtas_get_time_of_day(QTestState *qts, QGuestAllocator *alloc,
+                          struct tm *tm, uint32_t *ns);
+uint32_t qrtas_ibm_read_pci_config(QTestState *qts, QGuestAllocator *alloc,
+                                   uint64_t buid,
                                    uint32_t addr, uint32_t size);
-int qrtas_ibm_write_pci_config(QGuestAllocator *alloc, uint64_t buid,
+int qrtas_ibm_write_pci_config(QTestState *qts, QGuestAllocator *alloc,
+                               uint64_t buid,
                                uint32_t addr, uint32_t size, uint32_t val);
 #endif /* LIBQOS_RTAS_H */
diff --git a/tests/libqos/pci-spapr.c b/tests/libqos/pci-spapr.c
index d7b2aa75e6..b7199501b4 100644
--- a/tests/libqos/pci-spapr.c
+++ b/tests/libqos/pci-spapr.c
@@ -108,21 +108,24 @@ static uint8_t qpci_spapr_config_readb(QPCIBus *bus, int devfn, uint8_t offset)
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
     uint32_t config_addr = (devfn << 8) | offset;
-    return qrtas_ibm_read_pci_config(s->alloc, s->buid, config_addr, 1);
+    return qrtas_ibm_read_pci_config(bus->qts, s->alloc, s->buid,
+                                     config_addr, 1);
 }

 static uint16_t qpci_spapr_config_readw(QPCIBus *bus, int devfn, uint8_t offset)
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
     uint32_t config_addr = (devfn << 8) | offset;
-    return qrtas_ibm_read_pci_config(s->alloc, s->buid, config_addr, 2);
+    return qrtas_ibm_read_pci_config(bus->qts, s->alloc, s->buid,
+                                     config_addr, 2);
 }

 static uint32_t qpci_spapr_config_readl(QPCIBus *bus, int devfn, uint8_t offset)
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
     uint32_t config_addr = (devfn << 8) | offset;
-    return qrtas_ibm_read_pci_config(s->alloc, s->buid, config_addr, 4);
+    return qrtas_ibm_read_pci_config(bus->qts, s->alloc, s->buid,
+                                     config_addr, 4);
 }

 static void qpci_spapr_config_writeb(QPCIBus *bus, int devfn, uint8_t offset,
@@ -130,7 +133,8 @@ static void qpci_spapr_config_writeb(QPCIBus *bus, int devfn, uint8_t offset,
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
     uint32_t config_addr = (devfn << 8) | offset;
-    qrtas_ibm_write_pci_config(s->alloc, s->buid, config_addr, 1, value);
+    qrtas_ibm_write_pci_config(bus->qts, s->alloc, s->buid,
+                               config_addr, 1, value);
 }

 static void qpci_spapr_config_writew(QPCIBus *bus, int devfn, uint8_t offset,
@@ -138,7 +142,8 @@ static void qpci_spapr_config_writew(QPCIBus *bus, int devfn, uint8_t offset,
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
     uint32_t config_addr = (devfn << 8) | offset;
-    qrtas_ibm_write_pci_config(s->alloc, s->buid, config_addr, 2, value);
+    qrtas_ibm_write_pci_config(bus->qts, s->alloc, s->buid,
+                               config_addr, 2, value);
 }

 static void qpci_spapr_config_writel(QPCIBus *bus, int devfn, uint8_t offset,
@@ -146,7 +151,8 @@ static void qpci_spapr_config_writel(QPCIBus *bus, int devfn, uint8_t offset,
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
     uint32_t config_addr = (devfn << 8) | offset;
-    qrtas_ibm_write_pci_config(s->alloc, s->buid, config_addr, 4, value);
+    qrtas_ibm_write_pci_config(bus->qts, s->alloc, s->buid,
+                               config_addr, 4, value);
 }

 #define SPAPR_PCI_BASE               (1ULL << 45)
diff --git a/tests/libqos/rtas.c b/tests/libqos/rtas.c
index 0269803ce0..fb25f91723 100644
--- a/tests/libqos/rtas.c
+++ b/tests/libqos/rtas.c
@@ -26,7 +26,8 @@ static void qrtas_copy_ret(uint64_t target_ret, uint32_t nret, uint32_t *ret)
     }
 }

-static uint64_t qrtas_call(QGuestAllocator *alloc, const char *name,
+static uint64_t qrtas_call(QTestState *qts, QGuestAllocator *alloc,
+                           const char *name,
                            uint32_t nargs, uint32_t *args,
                            uint32_t nret, uint32_t *ret)
 {
@@ -37,8 +38,7 @@ static uint64_t qrtas_call(QGuestAllocator *alloc, const char *name,
     target_ret = guest_alloc(alloc, nret * sizeof(uint32_t));

     qrtas_copy_args(target_args, nargs, args);
-    res = qtest_rtas_call(global_qtest, name,
-                          nargs, target_args, nret, target_ret);
+    res = qtest_rtas_call(qts, name, nargs, target_args, nret, target_ret);
     qrtas_copy_ret(target_ret, nret, ret);

     guest_free(alloc, target_ret);
@@ -47,12 +47,13 @@ static uint64_t qrtas_call(QGuestAllocator *alloc, const char *name,
     return res;
 }

-int qrtas_get_time_of_day(QGuestAllocator *alloc, struct tm *tm, uint32_t *ns)
+int qrtas_get_time_of_day(QTestState *qts, QGuestAllocator *alloc,
+                          struct tm *tm, uint32_t *ns)
 {
     int res;
     uint32_t ret[8];

-    res = qrtas_call(alloc, "get-time-of-day", 0, NULL, 8, ret);
+    res = qrtas_call(qts, alloc, "get-time-of-day", 0, NULL, 8, ret);
     if (res != 0) {
         return res;
     }
@@ -70,7 +71,8 @@ int qrtas_get_time_of_day(QGuestAllocator *alloc, struct tm *tm, uint32_t *ns)
     return res;
 }

-uint32_t qrtas_ibm_read_pci_config(QGuestAllocator *alloc, uint64_t buid,
+uint32_t qrtas_ibm_read_pci_config(QTestState *qts, QGuestAllocator *alloc,
+                                   uint64_t buid,
                                    uint32_t addr, uint32_t size)
 {
     int res;
@@ -80,7 +82,7 @@ uint32_t qrtas_ibm_read_pci_config(QGuestAllocator *alloc, uint64_t buid,
     args[1] = buid >> 32;
     args[2] = buid & 0xffffffff;
     args[3] = size;
-    res = qrtas_call(alloc, "ibm,read-pci-config", 4, args, 2, ret);
+    res = qrtas_call(qts, alloc, "ibm,read-pci-config", 4, args, 2, ret);
     if (res != 0) {
         return -1;
     }
@@ -92,7 +94,8 @@ uint32_t qrtas_ibm_read_pci_config(QGuestAllocator *alloc, uint64_t buid,
     return ret[1];
 }

-int qrtas_ibm_write_pci_config(QGuestAllocator *alloc, uint64_t buid,
+int qrtas_ibm_write_pci_config(QTestState *qts, QGuestAllocator *alloc,
+                               uint64_t buid,
                                uint32_t addr, uint32_t size, uint32_t val)
 {
     int res;
@@ -103,7 +106,7 @@ int qrtas_ibm_write_pci_config(QGuestAllocator *alloc, uint64_t buid,
     args[2] = buid & 0xffffffff;
     args[3] = size;
     args[4] = val;
-    res = qrtas_call(alloc, "ibm,write-pci-config", 5, args, 1, ret);
+    res = qrtas_call(qts, alloc, "ibm,write-pci-config", 5, args, 1, ret);
     if (res != 0) {
         return -1;
     }
diff --git a/tests/rtas-test.c b/tests/rtas-test.c
index 276c87ef84..34a692163f 100644
--- a/tests/rtas-test.c
+++ b/tests/rtas-test.c
@@ -16,7 +16,7 @@ static void test_rtas_get_time_of_day(void)
     qs = qtest_spapr_boot("-machine pseries");

     t1 = time(NULL);
-    ret = qrtas_get_time_of_day(qs->alloc, &tm, &ns);
+    ret = qrtas_get_time_of_day(qs->qts, qs->alloc, &tm, &ns);
     g_assert_cmpint(ret, ==, 0);
     t2 = mktimegm(&tm);
     g_assert(t2 - t1 < 5); /* 5 sec max to run the test */
-- 
2.13.5
