Received: from eggs.gnu.org ([209.51.188.92]:58646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUmI-0006PI-UW
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:55:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUmD-0003kv-7Y
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:55:36 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:59 +1100
Message-Id: <20190226045304.25618-46-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 45/50] tests/device-plug: Add PHB unplug request
 test for spapr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

We can easily test this, just like PCI. PHB unplug is not supported
on s390x and x86 ACPI.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155059673939.1466090.14354001937819612724.stgit@bahia.lab.to=
ulouse-stg.fr.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 tests/device-plug-test.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/device-plug-test.c b/tests/device-plug-test.c
index 87593d9ecf..318e422d51 100644
--- a/tests/device-plug-test.c
+++ b/tests/device-plug-test.c
@@ -132,6 +132,20 @@ static void test_spapr_memory_unplug_request(void)
     qtest_quit(qtest);
 }
=20
+static void test_spapr_phb_unplug_request(void)
+{
+    QTestState *qtest;
+
+    qtest =3D qtest_initf("-device spapr-pci-host-bridge,index=3D1,id=3D=
dev0");
+
+    /* similar to test_pci_unplug_request */
+    device_del_request(qtest, "dev0");
+    system_reset(qtest);
+    wait_device_deleted_event(qtest, "dev0");
+
+    qtest_quit(qtest);
+}
+
 int main(int argc, char **argv)
 {
     const char *arch =3D qtest_get_arch();
@@ -156,6 +170,8 @@ int main(int argc, char **argv)
                        test_spapr_cpu_unplug_request);
         qtest_add_func("/device-plug/spapr-memory-unplug-request",
                        test_spapr_memory_unplug_request);
+        qtest_add_func("/device-plug/spapr-phb-unplug-request",
+                       test_spapr_phb_unplug_request);
     }
=20
     return g_test_run();
--=20
2.20.1
