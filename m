Received: from eggs.gnu.org ([209.51.188.92]:49653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMD4f-0005WL-RV
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMD4e-00031Z-QU
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42907)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hMD4e-00030t-IX
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:36 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  2 May 2019 16:51:59 +0200
Message-Id: <1556808723-226478-12-git-send-email-imammedo@redhat.com>
In-Reply-To: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
References: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v4 11/15] tests: acpi: allow to override
 default accelerator
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

By default test cases were run with 'kvm:tcg' accelerators to speed up
tests execution. While it works for x86, were change of accelerator
doesn't affect ACPI tables, the approach doesn't works for ARM usecase
though.

In arm/virt case, KVM mode requires using 'host' cpu model, which
isn't available in TCG mode. That could be worked around with 'max'
cpu model, which works both for KVM and TCG. However in KVM mode it
is necessary to specify matching GIC version, which also could use
'max' value to automatically pick GIC version suitable for host's CPU.
Depending on host cpu type, different GIC versions would be used,
which in turn leads to different ACPI tables (APIC) generated.
As result while comparing with reference blobs, test would fail if
host's GIC version won't match the version on the host where
reference blobs where generated.

Let's keep testing simple for now and allow ARM tests run in TCG only
mode. To do so introduce 'accel' parameter in test configuration, so
test case could override default "kvm:tcg" with accelerator of choice.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/bios-tables-test.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 8302ffc..39c1e24 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -24,6 +24,7 @@
 #define ACPI_REBUILD_EXPECTED_AML "TEST_ACPI_REBUILD_AML"
 
 typedef struct {
+    const char *accel;
     const char *machine;
     const char *variant;
     const char *uefi_fl1;
@@ -532,8 +533,8 @@ static void test_acpi_one(const char *params, test_data *data)
         args = g_strdup_printf("-machine %s,accel=%s -nodefaults -nographic "
             "-drive if=pflash,format=raw,file=%s,readonly "
             "-drive if=pflash,format=raw,file=%s,snapshot=on -cdrom %s %s",
-            data->machine, "kvm:tcg", data->uefi_fl1, data->uefi_fl2,
-            data->cd, params ? params : "");
+            data->machine, data->accel ? data->accel : "kvm:tcg",
+            data->uefi_fl1, data->uefi_fl2, data->cd, params ? params : "");
 
     } else {
         /* Disable kernel irqchip to be able to override apic irq0. */
@@ -541,7 +542,8 @@ static void test_acpi_one(const char *params, test_data *data)
             "-net none -display none %s "
             "-drive id=hd0,if=none,file=%s,format=raw "
             "-device ide-hd,drive=hd0 ",
-             data->machine, "kvm:tcg", params ? params : "", disk);
+             data->machine, data->accel ? data->accel : "kvm:tcg",
+             params ? params : "", disk);
     }
 
     data->qts = qtest_init(args);
-- 
2.7.4
