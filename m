Received: from eggs.gnu.org ([209.51.188.92]:58451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gvf8d-0002HE-H2
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 04:23:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gvf8c-00039O-Gi
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 04:22:59 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Feb 2019 10:22:02 +0100
Message-Id: <20190218092202.26683-7-david@redhat.com>
In-Reply-To: <20190218092202.26683-1-david@redhat.com>
References: <20190218092202.26683-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 6/6] tests/device-plug: Add memory unplug
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

We can easily test this, just like PCI. On x86 ACPI, we need guest
interaction to make it work, so it is not that easy to test. We might
add tests for that later on.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
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
 
+static void test_spapr_memory_unplug_request(void)
+{
+    QTestState *qtest;
+
+    qtest = qtest_initf("-m 256M,slots=1,maxmem=768M "
+                        "-object memory-backend-ram,id=mem0,size=512M "
+                        "-device pc-dimm,id=dev0,memdev=mem0");
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
@@ -138,6 +154,8 @@ int main(int argc, char **argv)
     if (!strcmp(arch, "ppc64")) {
         qtest_add_func("/device-plug/spapr-cpu-unplug-request",
                        test_spapr_cpu_unplug_request);
+        qtest_add_func("/device-plug/spapr-memory-unplug-request",
+                       test_spapr_memory_unplug_request);
     }
 
     return g_test_run();
-- 
2.17.2
