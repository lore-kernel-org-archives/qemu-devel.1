Received: from eggs.gnu.org ([2001:4830:134:3::10]:59285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e9dO7-00010i-Aa
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 16:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e9dO4-0004DO-PM
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 16:43:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56388)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1e9dO4-0004CJ-Hi
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 16:43:52 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9VKeoji086163
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 16:43:51 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dxv42nqf3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 16:43:51 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 31 Oct 2017 14:43:50 -0600
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 31 Oct 2017 18:43:29 -0200
In-Reply-To: <20171031204330.14803-1-danielhb@linux.vnet.ibm.com>
References: <20171031204330.14803-1-danielhb@linux.vnet.ibm.com>
Message-Id: <20171031204330.14803-4-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 3/4] tests: ibm,
 configure-connector RTAS call implementation
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

'ibm,configure-connector' hypercall is used by the guest OS
to start the configuration of a given device, where the
machine configures the said device and all its sub-devices,
giving back FDTs to the caller for each sub-device.

This hypercall is supposed to be called multiple times by the
guest OS until it returns RTAS_OUT_SUCESS (code 0), indicating
that the device is now properly configured and ready
to be used, or a return value < 0 when an error occurs.

This patch implements the 'ibm,configure-connector' RTAS
hypercall in tests/libqos/rtas.c, with an extra test
case for it inside tests/rtas-tests.c.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 tests/libqos/rtas.c | 35 +++++++++++++++++++++++++++
 tests/libqos/rtas.h |  1 +
 tests/rtas-test.c   | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+)

diff --git a/tests/libqos/rtas.c b/tests/libqos/rtas.c
index ade572a84f..1cb9e2b495 100644
--- a/tests/libqos/rtas.c
+++ b/tests/libqos/rtas.c
@@ -184,3 +184,38 @@ int qrtas_set_indicator(QGuestAllocator *alloc, uint32_t type, uint32_t idx,
 
     return ret[0];
 }
+
+/*
+ * ibm,configure-connector as defined by PAPR 2.7+, 13.5.3.5
+ *
+ * nargs = 2
+ * nrets = 1
+ *
+ * args[0] and args[1] compose the 64 bit Work Area address.
+ *
+ * This call will configure not only the device reported in the first
+ * offset of the Work Area but all of its siblingis as well, returning
+ * the FDT of each configured sub-device as well as a return code
+ * 'Next child', 'Next property' or 'Previous parent'. When the whole
+ * configuration is done, 'Configuration completed' (0) is returned.
+ *
+ * configure-connector will always reply with status code 'Next child'(2)
+ * on the first successful call. The DRC configuration will be
+ * completed when configure-connector returns status 0. Any return
+ * status < 0 indicates an error.
+ */
+int qrtas_ibm_configure_connector(QGuestAllocator *alloc, uintptr_t wa_addr)
+{
+    uint32_t args[2], ret[1];
+    int res;
+
+    args[0] = (uint32_t)(wa_addr);
+    args[1] = (uint32_t)(wa_addr >> 32);
+
+    res = qrtas_call(alloc, "ibm,configure-connector", 2, args, 1, ret);
+    if (res != 0) {
+        return -1;
+    }
+
+    return ret[0];
+}
diff --git a/tests/libqos/rtas.h b/tests/libqos/rtas.h
index 9dfa18f32b..35c44fb967 100644
--- a/tests/libqos/rtas.h
+++ b/tests/libqos/rtas.h
@@ -16,4 +16,5 @@ int qrtas_check_exception(QGuestAllocator *alloc, uint32_t mask,
                           uint32_t buf_addr, uint32_t buf_len);
 int qrtas_set_indicator(QGuestAllocator *alloc, uint32_t type, uint32_t idx,
                         uint32_t new_state);
+int qrtas_ibm_configure_connector(QGuestAllocator *alloc, uintptr_t wa_addr);
 #endif /* LIBQOS_RTAS_H */
diff --git a/tests/rtas-test.c b/tests/rtas-test.c
index 2c34b6e83c..b3538bf878 100644
--- a/tests/rtas-test.c
+++ b/tests/rtas-test.c
@@ -15,6 +15,8 @@
 #define SPAPR_DR_ALLOCATION_STATE_USABLE  1
 #define SPAPR_DR_ISOLATION_STATE_UNISOLATED 1
 
+#define CC_WA_LEN 4096
+
 static void test_rtas_get_time_of_day(void)
 {
     QOSState *qs;
@@ -169,6 +171,70 @@ static void test_rtas_set_indicator(void)
     qtest_shutdown(qs);
 }
 
+static void test_rtas_ibm_configure_connector(void)
+{
+    QOSState *qs;
+    uint64_t ret;
+    uintptr_t guest_buf_addr, guest_drc_addr;
+    uint32_t drc_index;
+    uint8_t *buf = g_malloc0(EVENT_LOG_LEN);
+
+    qs = qtest_spapr_boot("-machine pseries -cpu POWER8_v2.0 "
+                          "-smp 1,sockets=4,cores=1,threads=1,maxcpus=4");
+
+    guest_buf_addr = guest_alloc(qs->alloc, EVENT_LOG_LEN * sizeof(uint8_t));
+    qtest_qmp_device_add("power8_v2.0-spapr-cpu-core", "id-1",
+                         "'core-id':'1'");
+
+    ret = qrtas_check_exception(qs->alloc, EVENT_MASK_EPOW,
+                                guest_buf_addr, EVENT_LOG_LEN);
+
+    memread(guest_buf_addr, buf, EVENT_LOG_LEN);
+    guest_free(qs->alloc, guest_buf_addr);
+
+    g_assert_cmpint(ret, ==, 0);
+
+    /*
+     * Same 108 bytes offset magic used and explained in
+     * test_rtas_set_indicator.
+     */
+    drc_index = be32toh(*((uint32_t *)(buf + 108)));
+    g_free(buf);
+
+    ret = qrtas_set_indicator(qs->alloc, RTAS_SENSOR_TYPE_ALLOCATION_STATE,
+                              drc_index, SPAPR_DR_ALLOCATION_STATE_USABLE);
+    g_assert_cmpint(ret, ==, 0);
+
+    ret = qrtas_set_indicator(qs->alloc, RTAS_SENSOR_TYPE_ISOLATION_STATE,
+                              drc_index, SPAPR_DR_ISOLATION_STATE_UNISOLATED);
+    g_assert_cmpint(ret, ==, 0);
+
+    /*
+     * Call ibm,configure-connector to finish the hotplugged device
+     * configuration, putting its DRC into 'ready' state.
+     *
+     * We're not interested in the generated FDTs during the config
+     * process, thus we simply keep calling configure-connector
+     * until it returns SUCCESS(0) or an error.
+     *
+     * The full explanation logic behind this process can be found
+     * at PAPR 2.7+, 13.5.3.5.
+     */
+    guest_drc_addr = guest_alloc(qs->alloc, CC_WA_LEN * sizeof(uint32_t));
+    writel(guest_drc_addr, drc_index);
+    writel(guest_drc_addr + sizeof(uint32_t), 0);
+
+    do {
+        ret = qrtas_ibm_configure_connector(qs->alloc, guest_drc_addr);
+    } while (ret > 0);
+
+    guest_free(qs->alloc, guest_drc_addr);
+
+    g_assert_cmpint(ret, ==, 0);
+
+    qtest_shutdown(qs);
+}
+
 int main(int argc, char *argv[])
 {
     const char *arch = qtest_get_arch();
@@ -185,6 +251,8 @@ int main(int argc, char *argv[])
     qtest_add_func("rtas/rtas-check-exception-hotplug-event",
                    test_rtas_check_exception_hotplug_event);
     qtest_add_func("rtas/test_rtas_set_indicator", test_rtas_set_indicator);
+    qtest_add_func("rtas/test_rtas_ibm_configure_connector",
+                   test_rtas_ibm_configure_connector);
 
     return g_test_run();
 }
-- 
2.13.6
