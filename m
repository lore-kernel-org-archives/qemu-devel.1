Received: from eggs.gnu.org ([2001:4830:134:3::10]:33927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAu-0008JJ-Rz
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAs-0005xc-TY
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:48 -0500
Received: from mail.kernel.org ([198.145.29.136]:48478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAs-0005xR-JP
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:46 -0500
Date: Tue, 10 Jan 2017 07:40:40 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484026704-28027-33-git-send-email-mst@redhat.com>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484026704-28027-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 32/41] tests: pc: add memory hotplug acpi tables
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eric Blake <eblake@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

This also adds SRAT and DSDT blobs for memory hotplug variant

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
---
 tests/bios-tables-test.c            |  24 ++++++++++++++++++++++++
 tests/acpi-test-data/pc/DSDT.memhp  | Bin 0 -> 6613 bytes
 tests/acpi-test-data/pc/SRAT.memhp  | Bin 0 -> 224 bytes
 tests/acpi-test-data/q35/DSDT.memhp | Bin 0 -> 9375 bytes
 tests/acpi-test-data/q35/SRAT.memhp | Bin 0 -> 224 bytes
 5 files changed, 24 insertions(+)
 create mode 100644 tests/acpi-test-data/pc/DSDT.memhp
 create mode 100644 tests/acpi-test-data/pc/SRAT.memhp
 create mode 100644 tests/acpi-test-data/q35/DSDT.memhp
 create mode 100644 tests/acpi-test-data/q35/SRAT.memhp

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
diff --git a/tests/acpi-test-data/pc/DSDT.memhp b/tests/acpi-test-data/pc/DSDT.memhp
new file mode 100644
index 0000000000000000000000000000000000000000..a1010c7fb5c526278d743891f2543d873f9ef9b9
GIT binary patch
literal 6613
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
Bd0PMg

literal 0
HcmV?d00001

diff --git a/tests/acpi-test-data/pc/SRAT.memhp b/tests/acpi-test-data/pc/SRAT.memhp
new file mode 100644
index 0000000000000000000000000000000000000000..66ce9a898191d1da961c0c968c04ec56810a5785
GIT binary patch
literal 224
zcmWFzatwLEz`(%x+sWVABUr&HBEUHqD8>jB1F=Cg2*ZH@DxXmUE(2w7!3B`@A=Cj4
c0D}+gFooFF!DO-12=n0X`2kbO3}XOk0FlrO0RR91

literal 0
HcmV?d00001

diff --git a/tests/acpi-test-data/q35/DSDT.memhp b/tests/acpi-test-data/q35/DSDT.memhp
new file mode 100644
index 0000000000000000000000000000000000000000..ecd0d8564b21016028d8ecd740f8647e0cbf8878
GIT binary patch
literal 9375
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

literal 0
HcmV?d00001

diff --git a/tests/acpi-test-data/q35/SRAT.memhp b/tests/acpi-test-data/q35/SRAT.memhp
new file mode 100644
index 0000000000000000000000000000000000000000..66ce9a898191d1da961c0c968c04ec56810a5785
GIT binary patch
literal 224
zcmWFzatwLEz`(%x+sWVABUr&HBEUHqD8>jB1F=Cg2*ZH@DxXmUE(2w7!3B`@A=Cj4
c0D}+gFooFF!DO-12=n0X`2kbO3}XOk0FlrO0RR91

literal 0
HcmV?d00001

-- 
MST
