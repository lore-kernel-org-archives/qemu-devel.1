Received: from eggs.gnu.org ([209.51.188.92]:49607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMD4b-0005Sc-Tp
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMD4a-0002z8-0A
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hMD4Y-0002xN-0d
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:31 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  2 May 2019 16:51:57 +0200
Message-Id: <1556808723-226478-10-git-send-email-imammedo@redhat.com>
In-Reply-To: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
References: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v4 09/15] tests: acpi: add a way to start tests
 with UEFI firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gonglei <arei.gonglei@huawei.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Wei Yang <richardw.yang@linux.intel.com>, Andrew Jones <drjones@redhat.com>, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Ben Warren <ben@skyportsystems.com>, xuwei5@hisilicon.com, xuwei5@huawei.com, linuxarm@huawei.com

For testcase to use UEFI firmware, one needs to provide and specify
firmware and varstore blob names in test_data { uefi_fl1, uefi_fl2 }
fields respectively and RAM start address plus size where to look for
test structure signature. Additionally testcase should specify
bootable cdrom image from uefi-boot-images with EFI test utility.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
---
v4:
  * fixup commit message (typo/spelling) (Wei Yang <richardw.yang@linux.intel.com>)
  * get rid of test_acpi_rsdp_address()
v3:
  * drop data_dir prefix and firmware will come from pc-bios directly
  * add cdrom option so test could use it for providing boot cdrom image
  * add TODO comment convert '-drive if=pflash' to new syntax (Laszlo)
v2:
  * move RAM start address and size to test_data, as it could differ
    between boards (and even versions)

dfd
---
 tests/bios-tables-test.c | 52 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 4d13a3c..84e1ce2 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -26,6 +26,11 @@
 typedef struct {
     const char *machine;
     const char *variant;
+    const char *uefi_fl1;
+    const char *uefi_fl2;
+    const char *cd;
+    const uint64_t ram_start;
+    const uint64_t scan_len;
     uint64_t rsdp_addr;
     uint8_t rsdp_table[36 /* ACPI 2.0+ RSDP size */];
     GArray *tables;
@@ -77,13 +82,6 @@ static void free_test_data(test_data *data)
     g_array_free(data->tables, true);
 }
 
-static void test_acpi_rsdp_address(test_data *data)
-{
-    uint32_t off = acpi_find_rsdp_address(data->qts);
-    g_assert_cmphex(off, <, 0x100000);
-    data->rsdp_addr = off;
-}
-
 static void test_acpi_rsdp_table(test_data *data)
 {
     uint8_t *rsdp_table = data->rsdp_table;
@@ -524,21 +522,41 @@ static void test_smbios_structs(test_data *data)
 static void test_acpi_one(const char *params, test_data *data)
 {
     char *args;
-
-    /* Disable kernel irqchip to be able to override apic irq0. */
-    args = g_strdup_printf("-machine %s,accel=%s,kernel-irqchip=off "
-                           "-net none -display none %s "
-                           "-drive id=hd0,if=none,file=%s,format=raw "
-                           "-device ide-hd,drive=hd0 ",
-                           data->machine, "kvm:tcg",
-                           params ? params : "", disk);
+    bool use_uefi = data->uefi_fl1 && data->uefi_fl2;
+
+    if (use_uefi) {
+        /*
+         * TODO: convert '-drive if=pflash' to new syntax (see e33763be7cd3)
+         * when arm/virt boad starts to support it.
+         */
+        args = g_strdup_printf("-machine %s,accel=%s -nodefaults -nographic "
+            "-drive if=pflash,format=raw,file=%s,readonly "
+            "-drive if=pflash,format=raw,file=%s,snapshot=on -cdrom %s %s",
+            data->machine, "kvm:tcg", data->uefi_fl1, data->uefi_fl2,
+            data->cd, params ? params : "");
+
+    } else {
+        /* Disable kernel irqchip to be able to override apic irq0. */
+        args = g_strdup_printf("-machine %s,accel=%s,kernel-irqchip=off "
+            "-net none -display none %s "
+            "-drive id=hd0,if=none,file=%s,format=raw "
+            "-device ide-hd,drive=hd0 ",
+             data->machine, "kvm:tcg", params ? params : "", disk);
+    }
 
     data->qts = qtest_init(args);
 
-    boot_sector_test(data->qts);
+    if (use_uefi) {
+        g_assert(data->scan_len);
+        data->rsdp_addr = acpi_find_rsdp_address_uefi(data->qts,
+            data->ram_start, data->scan_len);
+    } else {
+        boot_sector_test(data->qts);
+        data->rsdp_addr = acpi_find_rsdp_address(data->qts);
+        g_assert_cmphex(data->rsdp_addr, <, 0x100000);
+    }
 
     data->tables = g_array_new(false, true, sizeof(AcpiSdtTable));
-    test_acpi_rsdp_address(data);
     test_acpi_rsdp_table(data);
     test_acpi_rxsdt_table(data);
     test_acpi_fadt_table(data);
-- 
2.7.4
