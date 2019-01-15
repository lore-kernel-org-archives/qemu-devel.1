Received: from eggs.gnu.org ([209.51.188.92]:34045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gjR2S-00024v-LK
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:54:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gjR2R-0006dQ-Na
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:54:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gjR2R-0006dD-I9
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:54:03 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 15 Jan 2019 16:41:05 +0100
Message-Id: <1547566866-129386-14-git-send-email-imammedo@redhat.com>
In-Reply-To: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
References: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 13/14] tests: acpi: add simple arm/virt testcase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gonglei <arei.gonglei@huawei.com>, Laszlo Ersek <lersek@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Andrew Jones <drjones@redhat.com>

adds simple arm/virt test case that starts guest with default values
(modulo cortex-a57)

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/Makefile.include   |  1 +
 tests/bios-tables-test.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index e1201d9..a62de4c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -296,6 +296,7 @@ check-qtest-aarch64-$(CONFIG_SDHCI) += tests/sdhci-test$(EXESUF)
 check-qtest-aarch64-y += tests/boot-serial-test$(EXESUF)
 check-qtest-aarch64-y += tests/migration-test$(EXESUF)
 qtest-uefi-images-aarch64 = avmf.img avmf_vars.img
+check-qtest-aarch64-y += tests/bios-tables-test$(EXESUF)
 
 check-qtest-microblazeel-y += $(check-qtest-microblaze-y)
 
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index a64d0c2..197ae26 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -797,6 +797,20 @@ static void test_acpi_piix4_tcg_dimm_pxm(void)
     test_acpi_tcg_dimm_pxm(MACHINE_PC);
 }
 
+static void test_acpi_virt_tcg(void)
+{
+    test_data data;
+
+    memset(&data, 0, sizeof(data));
+    data.machine = "virt";
+    data.required_struct_types = base_required_struct_types;
+    data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
+    data.uefi_fl1 = "avmf.img";
+    data.uefi_fl2 = "avmf_vars.img";
+    test_acpi_one("-cpu cortex-a57 ", &data);
+    free_test_data(&data);
+}
+
 int main(int argc, char *argv[])
 {
     const char *arch = qtest_get_arch();
@@ -824,6 +838,8 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/q35/numamem", test_acpi_q35_tcg_numamem);
         qtest_add_func("acpi/piix4/dimmpxm", test_acpi_piix4_tcg_dimm_pxm);
         qtest_add_func("acpi/q35/dimmpxm", test_acpi_q35_tcg_dimm_pxm);
+    } else if (strcmp(arch, "aarch64") == 0) {
+        qtest_add_func("acpi/virt", test_acpi_virt_tcg);
     }
     ret = g_test_run();
     boot_sector_cleanup(disk);
-- 
2.7.4
