Received: from eggs.gnu.org ([2001:4830:134:3::10]:57158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cE2kR-0002jG-Jj
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 18:32:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cE2kN-0005ya-PE
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 18:32:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cE2kN-0005yN-K1
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 18:32:35 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AD8CBC01095C
	for <qemu-devel@nongnu.org>; Mon,  5 Dec 2016 23:32:34 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue,  6 Dec 2016 00:32:20 +0100
Message-Id: <1480980749-182204-2-git-send-email-imammedo@redhat.com>
In-Reply-To: <1480980749-182204-1-git-send-email-imammedo@redhat.com>
References: <1480980749-182204-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 01/10] tests: pc: add memory hotplug
 acpi tables tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/bios-tables-test.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 812f830..5404805 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -867,6 +867,28 @@ static void test_acpi_piix4_tcg_ipmi(void)
     free_test_data(&data);
 }
 
+static void test_acpi_q35_tcg_memhp(void)
+{
+    test_data data;
+
+    memset(&data, 0, sizeof(data));
+    data.machine = MACHINE_Q35;
+    data.variant = ".memhp";
+    test_acpi_one(" -m 128,slots=3,maxmem=1G -numa node", &data);
+    free_test_data(&data);
+}
+
+static void test_acpi_piix4_tcg_memhp(void)
+{
+    test_data data;
+
+    memset(&data, 0, sizeof(data));
+    data.machine = MACHINE_PC;
+    data.variant = ".memhp";
+    test_acpi_one(" -m 128,slots=3,maxmem=1G -numa node", &data);
+    free_test_data(&data);
+}
+
 int main(int argc, char *argv[])
 {
     const char *arch = qtest_get_arch();
@@ -887,6 +909,8 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/q35/ipmi", test_acpi_q35_tcg_ipmi);
         qtest_add_func("acpi/piix4/cpuhp", test_acpi_piix4_tcg_cphp);
         qtest_add_func("acpi/q35/cpuhp", test_acpi_q35_tcg_cphp);
+        qtest_add_func("acpi/piix4/memhp", test_acpi_piix4_tcg_memhp);
+        qtest_add_func("acpi/q35/memhp", test_acpi_q35_tcg_memhp);
     }
     ret = g_test_run();
     boot_sector_cleanup(disk);
-- 
2.7.4
