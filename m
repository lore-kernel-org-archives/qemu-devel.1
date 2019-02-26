Received: from eggs.gnu.org ([209.51.188.92]:57737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkn-0004xH-PE
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkm-0002NU-FB
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:05 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:30 +1100
Message-Id: <20190226045304.25618-17-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/50] tests/device-plug: Add CPU core unplug
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

We can easily test this, just like PCI. On s390x, cpu unplug is not
supported. On x86 ACPI, cpu unplug requires guest interaction to work, so
it can't be tested that easily. We might add tests for ACPI later.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190218092202.26683-6-david@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 tests/device-plug-test.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tests/device-plug-test.c b/tests/device-plug-test.c
index d1a6c94af2..0262ad6be6 100644
--- a/tests/device-plug-test.c
+++ b/tests/device-plug-test.c
@@ -101,6 +101,21 @@ static void test_ccw_unplug(void)
     qtest_quit(qtest);
 }
=20
+static void test_spapr_cpu_unplug_request(void)
+{
+    QTestState *qtest;
+
+    qtest =3D qtest_initf("-cpu power9_v2.0 -smp 1,maxcpus=3D2 "
+                        "-device power9_v2.0-spapr-cpu-core,core-id=3D1,=
id=3Ddev0");
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
@@ -120,5 +135,10 @@ int main(int argc, char **argv)
                        test_ccw_unplug);
     }
=20
+    if (!strcmp(arch, "ppc64")) {
+        qtest_add_func("/device-plug/spapr-cpu-unplug-request",
+                       test_spapr_cpu_unplug_request);
+    }
+
     return g_test_run();
 }
--=20
2.20.1
