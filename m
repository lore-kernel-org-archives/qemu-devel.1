Received: from eggs.gnu.org ([209.51.188.92]:57803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkp-0004zL-FB
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkm-0002Om-ON
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:07 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:28 +1100
Message-Id: <20190226045304.25618-15-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/50] tests/device-plug: Add a simple PCI
 unplug request test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Greg Kurz <groug@kaod.org>, Thomas Huth <thuth@redhat.com>, Collin Walling <walling@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

The issue with testing asynchronous unplug requests it that they usually
require a running guest to handle the request. However, to test if
unplug of PCI devices works, we can apply a nice little trick on some
architectures:

On system reset, x86 ACPI, s390x and spapr will perform the unplug,
resulting in the device of interest to get deleted and a DEVICE_DELETED
event getting sent.

On s390x, we still get a warning
    qemu-system-s390x: -device virtio-mouse-pci,id=3Ddev0:
    warning: Plugging a PCI/zPCI device without the 'zpci' CPU feature
    enabled; the guest will not be able to see/use this device

This will be fixed soon, when we enable the zpci CPU feature always
(Conny already has a patch for this queued).

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190218092202.26683-4-david@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 tests/Makefile.include   |  4 ++
 tests/device-plug-test.c | 93 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100644 tests/device-plug-test.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3741f8f6dd..b62d82beb4 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -192,6 +192,7 @@ check-qtest-i386-$(CONFIG_ISA_IPMI_KCS) +=3D tests/ip=
mi-kcs-test$(EXESUF)
 # check-qtest-i386-$(CONFIG_ISA_IPMI_BT) +=3D tests/ipmi-bt-test$(EXESUF=
)
 check-qtest-i386-y +=3D tests/i440fx-test$(EXESUF)
 check-qtest-i386-y +=3D tests/fw_cfg-test$(EXESUF)
+check-qtest-i386-y +=3D tests/device-plug-test$(EXESUF)
 check-qtest-i386-y +=3D tests/drive_del-test$(EXESUF)
 check-qtest-i386-$(CONFIG_WDT_IB700) +=3D tests/wdt_ib700-test$(EXESUF)
 check-qtest-i386-y +=3D tests/tco-test$(EXESUF)
@@ -256,6 +257,7 @@ check-qtest-ppc-$(CONFIG_M48T59) +=3D tests/m48t59-te=
st$(EXESUF)
=20
 check-qtest-ppc64-y +=3D $(check-qtest-ppc-y)
 check-qtest-ppc64-$(CONFIG_PSERIES) +=3D tests/spapr-phb-test$(EXESUF)
+check-qtest-ppc64-$(CONFIG_PSERIES) +=3D tests/device-plug-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_POWERNV) +=3D tests/pnv-xscom-test$(EXESUF)
 check-qtest-ppc64-y +=3D tests/migration-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_PSERIES) +=3D tests/rtas-test$(EXESUF)
@@ -310,6 +312,7 @@ check-qtest-s390x-$(CONFIG_SLIRP) +=3D tests/test-net=
filter$(EXESUF)
 check-qtest-s390x-$(CONFIG_POSIX) +=3D tests/test-filter-mirror$(EXESUF)
 check-qtest-s390x-$(CONFIG_POSIX) +=3D tests/test-filter-redirector$(EXE=
SUF)
 check-qtest-s390x-y +=3D tests/drive_del-test$(EXESUF)
+check-qtest-s390x-y +=3D tests/device-plug-test$(EXESUF)
 check-qtest-s390x-y +=3D tests/virtio-ccw-test$(EXESUF)
 check-qtest-s390x-y +=3D tests/cpu-plug-test$(EXESUF)
 check-qtest-s390x-y +=3D tests/migration-test$(EXESUF)
@@ -750,6 +753,7 @@ tests/ipoctal232-test$(EXESUF): tests/ipoctal232-test=
.o
 tests/qom-test$(EXESUF): tests/qom-test.o
 tests/test-hmp$(EXESUF): tests/test-hmp.o
 tests/machine-none-test$(EXESUF): tests/machine-none-test.o
+tests/device-plug-test$(EXESUF): tests/device-plug-test.o
 tests/drive_del-test$(EXESUF): tests/drive_del-test.o $(libqos-virtio-ob=
j-y)
 tests/nvme-test$(EXESUF): tests/nvme-test.o $(libqos-pc-obj-y)
 tests/pvpanic-test$(EXESUF): tests/pvpanic-test.o
diff --git a/tests/device-plug-test.c b/tests/device-plug-test.c
new file mode 100644
index 0000000000..cd9ada539d
--- /dev/null
+++ b/tests/device-plug-test.c
@@ -0,0 +1,93 @@
+/*
+ * QEMU device plug/unplug handling
+ *
+ * Copyright (C) 2019 Red Hat Inc.
+ *
+ * Authors:
+ *  David Hildenbrand <david@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qstring.h"
+
+static void device_del_request(QTestState *qtest, const char *id)
+{
+    QDict *resp;
+
+    resp =3D qtest_qmp(qtest,
+                     "{'execute': 'device_del', 'arguments': { 'id': %s =
} }",
+                     id);
+    g_assert(qdict_haskey(resp, "return"));
+    qobject_unref(resp);
+}
+
+static void system_reset(QTestState *qtest)
+{
+    QDict *resp;
+
+    resp =3D qtest_qmp(qtest, "{'execute': 'system_reset'}");
+    g_assert(qdict_haskey(resp, "return"));
+    qobject_unref(resp);
+}
+
+static void wait_device_deleted_event(QTestState *qtest, const char *id)
+{
+    QDict *resp, *data;
+    QString *qstr;
+
+    /*
+     * Other devices might get removed along with the removed device. Sk=
ip
+     * these. The device of interest will be the last one.
+     */
+    for (;;) {
+        resp =3D qtest_qmp_eventwait_ref(qtest, "DEVICE_DELETED");
+        data =3D qdict_get_qdict(resp, "data");
+        if (!data || !qdict_get(data, "device")) {
+            qobject_unref(resp);
+            continue;
+        }
+        qstr =3D qobject_to(QString, qdict_get(data, "device"));
+        g_assert(qstr);
+        if (!strcmp(qstring_get_str(qstr), id)) {
+            qobject_unref(resp);
+            break;
+        }
+        qobject_unref(resp);
+    }
+}
+
+static void test_pci_unplug_request(void)
+{
+    QTestState *qtest =3D qtest_initf("-device virtio-mouse-pci,id=3Ddev=
0");
+
+    /*
+     * Request device removal. As the guest is not running, the request =
won't
+     * be processed. However during system reset, the removal will be
+     * handled, removing the device.
+     */
+    device_del_request(qtest, "dev0");
+    system_reset(qtest);
+    wait_device_deleted_event(qtest, "dev0");
+
+    qtest_quit(qtest);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    /*
+     * We need a system that will process unplug requests during system =
resets
+     * and does not do PCI surprise removal. This holds for x86 ACPI,
+     * s390x and spapr.
+     */
+    qtest_add_func("/device-plug/pci-unplug-request",
+                   test_pci_unplug_request);
+
+    return g_test_run();
+}
--=20
2.20.1
