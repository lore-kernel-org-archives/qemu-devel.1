Received: from eggs.gnu.org ([2001:4830:134:3::10]:59216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e9dO3-0000xM-6X
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 16:43:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e9dO0-0004BA-2s
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 16:43:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1e9dNz-0004Ak-QX
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 16:43:48 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9VKeisl080699
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 16:43:45 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dxy79bsrp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 16:43:44 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 31 Oct 2017 14:43:44 -0600
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 31 Oct 2017 18:43:27 -0200
In-Reply-To: <20171031204330.14803-1-danielhb@linux.vnet.ibm.com>
References: <20171031204330.14803-1-danielhb@linux.vnet.ibm.com>
Message-Id: <20171031204330.14803-2-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 1/4] tests: adding 'check_exception' RTAS
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, mdroth@linux.vnet.ibm.com, lvivier@redhat.com

In the sPAPR guest, events such as device hotplug/unplug are
retrieved by the check_exception RTAS call after the guest
receives an IRQ pulse. For both hotplug and unplug operations,
guest intervention is required to transit the DRC state of
the attached device to the configured state.

Without guest intervention, we are still able of qtesting hotplug
devices in the same manner that we support device hotplug in
early (pre-CAS) stages.

Unfortunately, hot unplugs qtests relies on callbacks that demands
guest intervention to complete - otherwise we risk leaving the guest
in an inconsistent state that might impact other hotplug/unplug
operations later on. If we want to make hot unplug qtests we'll
need to simulate the guest behavior in the scenario in which a
hot unplug is received, allowing the hot unplug process to go
as intended.

This patch is the first step towards hot unplug qtests in sPAPR,
implementing the check_exception RTAS hypercall in libqos. This
hypercall is used to fetch events such as hotplug/hot unplug from
the sPAPR machine after the guest receives an IRQ pulse (or,
in the case of the test implemented here, we simply know when
there is/isn't an event to be retrieved).

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 tests/libqos/rtas.c | 37 +++++++++++++++++++++++++
 tests/libqos/rtas.h |  2 ++
 tests/rtas-test.c   | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+)

diff --git a/tests/libqos/rtas.c b/tests/libqos/rtas.c
index 0269803ce0..fdeab448f7 100644
--- a/tests/libqos/rtas.c
+++ b/tests/libqos/rtas.c
@@ -114,3 +114,40 @@ int qrtas_ibm_write_pci_config(QGuestAllocator *alloc, uint64_t buid,
 
     return 0;
 }
+
+/*
+ * check_exception as defined by PAPR 2.7+, 7.3.3.2
+ *
+ * nargs = 7 (with Extended Information)
+ * nrets = 1
+ *
+ * arg[2] = mask of event classes to process
+ * arg[4] = real address of error log
+ * arg[5] = length of error log
+ *
+ * arg[0] (Vector Offset), arg[1] and arg[6] (Additional information)
+ * and arg[3] (Critical) aren't used in the logic of check_exception
+ * in hw/ppc/spapr_events.c and can be ignored.
+ *
+ * If there is an event that matches the given mask, check-exception writes
+ * it in buf_addr up to a max of buf_len bytes.
+ *
+ */
+int qrtas_check_exception(QGuestAllocator *alloc, uint32_t mask,
+                          uint32_t buf_addr, uint32_t buf_len)
+{
+    uint32_t args[7], ret[1];
+    int res;
+
+    args[0] = args[1] = args[3] = args[6] = 0;
+    args[2] = mask;
+    args[4] = buf_addr;
+    args[5] = buf_len;
+
+    res = qrtas_call(alloc, "check-exception", 7, args, 1, ret);
+    if (res != 0) {
+        return -1;
+    }
+
+    return ret[0];
+}
diff --git a/tests/libqos/rtas.h b/tests/libqos/rtas.h
index 498eb19230..330ecfd397 100644
--- a/tests/libqos/rtas.h
+++ b/tests/libqos/rtas.h
@@ -12,4 +12,6 @@ uint32_t qrtas_ibm_read_pci_config(QGuestAllocator *alloc, uint64_t buid,
                                    uint32_t addr, uint32_t size);
 int qrtas_ibm_write_pci_config(QGuestAllocator *alloc, uint64_t buid,
                                uint32_t addr, uint32_t size, uint32_t val);
+int qrtas_check_exception(QGuestAllocator *alloc, uint32_t mask,
+                          uint32_t buf_addr, uint32_t buf_len);
 #endif /* LIBQOS_RTAS_H */
diff --git a/tests/rtas-test.c b/tests/rtas-test.c
index 276c87ef84..c5a6080043 100644
--- a/tests/rtas-test.c
+++ b/tests/rtas-test.c
@@ -5,6 +5,9 @@
 #include "libqos/libqos-spapr.h"
 #include "libqos/rtas.h"
 
+#define EVENT_MASK_EPOW (1 << 30)
+#define EVENT_LOG_LEN 2048
+
 static void test_rtas_get_time_of_day(void)
 {
     QOSState *qs;
@@ -24,6 +27,76 @@ static void test_rtas_get_time_of_day(void)
     qtest_shutdown(qs);
 }
 
+static void test_rtas_check_exception_no_events(void)
+{
+    QOSState *qs;
+    uint64_t ret;
+    uintptr_t guest_buf_addr;
+    uint8_t *buf = g_malloc0(EVENT_LOG_LEN);
+
+    qs = qtest_spapr_boot("-machine pseries");
+    guest_buf_addr = guest_alloc(qs->alloc, EVENT_LOG_LEN * sizeof(uint8_t));
+
+    /*
+     * mask = 0 should return no events, returning
+     * RTAS_OUT_NO_ERRORS_FOUND (1).
+     */
+    ret = qrtas_check_exception(qs->alloc, 0, guest_buf_addr, EVENT_LOG_LEN);
+    g_assert_cmpint(ret, ==, 1);
+
+    /*
+     * Using a proper event mask should also return
+     * no events since no hotplugs happened.
+     */
+    ret = qrtas_check_exception(qs->alloc, EVENT_MASK_EPOW, guest_buf_addr,
+                                EVENT_LOG_LEN);
+    g_assert_cmpint(ret, ==, 1);
+
+    guest_free(qs->alloc, guest_buf_addr);
+    g_free(buf);
+
+    qtest_shutdown(qs);
+}
+
+static void test_rtas_check_exception_hotplug_event(void)
+{
+    QOSState *qs;
+    uint64_t ret;
+    uintptr_t guest_buf_addr;
+    uint8_t *buf = g_malloc0(EVENT_LOG_LEN);
+    uint8_t *zero_buf = g_malloc0(EVENT_LOG_LEN);
+
+    qs = qtest_spapr_boot("-machine pseries -cpu POWER8_v2.0 "
+                          "-smp 1,sockets=4,cores=1,threads=1,maxcpus=4");
+
+    guest_buf_addr = guest_alloc(qs->alloc, EVENT_LOG_LEN * sizeof(uint8_t));
+
+    qtest_qmp_device_add("power8_v2.0-spapr-cpu-core", "id-1",
+                         "'core-id':'1'");
+    /*
+     * We use EPOW mask instead of HOTPLUG because the code defaults
+     * the hotplug interrupt source to EPOW if the guest didn't change
+     * OV5_HP_EVT during CAS.
+     */
+    ret = qrtas_check_exception(qs->alloc, EVENT_MASK_EPOW,
+                                guest_buf_addr, EVENT_LOG_LEN);
+
+    memread(guest_buf_addr, buf, EVENT_LOG_LEN);
+    guest_free(qs->alloc, guest_buf_addr);
+
+    /*
+     * Calling check_exception after a hotplug needs to return
+     * RTAS_OUT_SUCCESS (0) and a non-zero error_log.
+     */
+    g_assert_cmpint(ret, ==, 0);
+    g_assert(memcmp(buf, zero_buf, EVENT_LOG_LEN) != 0);
+
+    g_free(buf);
+    g_free(zero_buf);
+
+    qtest_shutdown(qs);
+}
+
 int main(int argc, char *argv[])
 {
     const char *arch = qtest_get_arch();
@@ -35,6 +108,10 @@ int main(int argc, char *argv[])
         exit(EXIT_FAILURE);
     }
     qtest_add_func("rtas/get-time-of-day", test_rtas_get_time_of_day);
+    qtest_add_func("rtas/rtas-check-exception-no-events",
+                   test_rtas_check_exception_no_events);
+    qtest_add_func("rtas/rtas-check-exception-hotplug-event",
+                   test_rtas_check_exception_hotplug_event);
 
     return g_test_run();
 }
-- 
2.13.6
