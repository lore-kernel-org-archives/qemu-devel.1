Received: from eggs.gnu.org ([209.51.188.92]:57731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkn-0004wb-BV
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkm-0002NL-EY
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:05 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:31 +1100
Message-Id: <20190226045304.25618-18-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 17/50] tests/device-plug: Add memory unplug
 request test for spapr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Greg Kurz <groug@kaod.org>, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: David Hildenbrand <david@redhat.com>

We can easily test this, just like PCI. On x86 ACPI, we need guest
interaction to make it work, so it is not that easy to test. We might
add tests for that later on.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190218092202.26683-7-david@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 tests/device-plug-test.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tests/device-plug-test.c b/tests/device-plug-test.c
index 0262ad6be6..87593d9ecf 100644
--- a/tests/device-plug-test.c
+++ b/tests/device-plug-test.c
@@ -116,6 +116,22 @@ static void test_spapr_cpu_unplug_request(void)
     qtest_quit(qtest);
 }
=20
+static void test_spapr_memory_unplug_request(void)
+{
+    QTestState *qtest;
+
+    qtest =3D qtest_initf("-m 256M,slots=3D1,maxmem=3D768M "
+                        "-object memory-backend-ram,id=3Dmem0,size=3D512=
M "
+                        "-device pc-dimm,id=3Ddev0,memdev=3Dmem0");
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
@@ -138,6 +154,8 @@ int main(int argc, char **argv)
     if (!strcmp(arch, "ppc64")) {
         qtest_add_func("/device-plug/spapr-cpu-unplug-request",
                        test_spapr_cpu_unplug_request);
+        qtest_add_func("/device-plug/spapr-memory-unplug-request",
+                       test_spapr_memory_unplug_request);
     }
=20
     return g_test_run();
--=20
2.20.1
