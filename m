Received: from eggs.gnu.org ([209.51.188.92]:58440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gvf8d-0002H1-5u
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 04:23:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gvf8c-00038p-Av
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 04:22:59 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Feb 2019 10:22:01 +0100
Message-Id: <20190218092202.26683-6-david@redhat.com>
In-Reply-To: <20190218092202.26683-1-david@redhat.com>
References: <20190218092202.26683-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 5/6] tests/device-plug: Add CPU core unplug
 request test for spapr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>

We can easily test this, just like PCI. On s390x, cpu unplug is not
supported. On x86 ACPI, cpu unplug requires guest interaction to work, so
it can't be tested that easily. We might add tests for ACPI later.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
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
 
+static void test_spapr_cpu_unplug_request(void)
+{
+    QTestState *qtest;
+
+    qtest = qtest_initf("-cpu power9_v2.0 -smp 1,maxcpus=2 "
+                        "-device power9_v2.0-spapr-cpu-core,core-id=1,id=dev0");
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
     const char *arch = qtest_get_arch();
@@ -120,5 +135,10 @@ int main(int argc, char **argv)
                        test_ccw_unplug);
     }
 
+    if (!strcmp(arch, "ppc64")) {
+        qtest_add_func("/device-plug/spapr-cpu-unplug-request",
+                       test_spapr_cpu_unplug_request);
+    }
+
     return g_test_run();
 }
-- 
2.17.2
