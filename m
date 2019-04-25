Received: from eggs.gnu.org ([209.51.188.92]:60610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJcPg-0004pd-AD
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 07:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJcPf-0002yi-2d
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 07:19:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hJcPe-0002wv-QX
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 07:19:35 -0400
Date: Thu, 25 Apr 2019 13:19:22 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190425131922.7f72a963@redhat.com>
In-Reply-To: <20190425080842.GE24829@richard>
References: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
	<1556170489-131927-9-git-send-email-imammedo@redhat.com>
	<20190425080842.GE24829@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 08/13] tests: acpi: add a way to start
 tests with UEFI firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: Andrew Jones <drjones@redhat.com>, Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Gonglei <arei.gonglei@huawei.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>

On Thu, 25 Apr 2019 16:08:42 +0800
Wei Yang <richardw.yang@linux.intel.com> wrote:

> On Thu, Apr 25, 2019 at 07:34:44AM +0200, Igor Mammedov wrote:
> >For testcase to use UEFI firmware, one needs to provide and specify
> >firmwarei and varstore blobs names in test_data { uefi_fl1, uefi_fl2) }  
>                                                                      ^
> 					               a typo here?

fixed
 
> >fields respectively and RAM start address plus size where to look for
> >test structure signature. Additionally testcase should specify
> >bootable cdrom image uefi-boot-images EFI test utility.
> >
> >Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> >---
> >v3:
> >  * drop data_dir prefix and firmware will come from pc-bios directly
> >  * add cdrom option so test could use it for providing boot cdrom image
> >  * add TODO comment convert '-drive if=pflash' to new syntax (Laszlo)
> >v2:
> >  * move RAM start address and size to test_data, as it could differ
> >    between boards (and even versions)
> >---
> > tests/bios-tables-test.c | 44 ++++++++++++++++++++++++++++++++++----------
> > 1 file changed, 34 insertions(+), 10 deletions(-)
> >
> >diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> >index 5790ee4..0f24540 100644
> >--- a/tests/bios-tables-test.c
> >+++ b/tests/bios-tables-test.c
> >@@ -26,6 +26,11 @@
> > typedef struct {
> >     const char *machine;
> >     const char *variant;
> >+    const char *uefi_fl1;
> >+    const char *uefi_fl2;
> >+    const char *cd;
> >+    const uint64_t ram_start;
> >+    const uint64_t scan_len;
> >     uint64_t rsdp_addr;
> >     uint8_t rsdp_table[36 /* ACPI 2.0+ RSDP size */];
> >     GArray *tables;
> >@@ -522,21 +527,40 @@ static void test_smbios_structs(test_data *data)
> > static void test_acpi_one(const char *params, test_data *data)
> > {
> >     char *args;
> >-
> >-    /* Disable kernel irqchip to be able to override apic irq0. */
> >-    args = g_strdup_printf("-machine %s,accel=%s,kernel-irqchip=off "
> >-                           "-net none -display none %s "
> >-                           "-drive id=hd0,if=none,file=%s,format=raw "
> >-                           "-device ide-hd,drive=hd0 ",
> >-                           data->machine, "kvm:tcg",
> >-                           params ? params : "", disk);
> >+    bool use_uefi = data->uefi_fl1 && data->uefi_fl2;
> >+
> >+    if (use_uefi) {
> >+        /*
> >+         * TODO: convert '-drive if=pflash' to new syntax (see e33763be7cd3)
> >+         * when arm/virt boad starts to support it.
> >+         */
> >+        args = g_strdup_printf("-machine %s,accel=%s -nodefaults -nographic "
> >+            "-drive if=pflash,format=raw,file=%s,readonly "
> >+            "-drive if=pflash,format=raw,file=%s,snapshot=on -cdrom %s %s",
> >+            data->machine, "kvm:tcg", data->uefi_fl1, data->uefi_fl2,
> >+            data->cd, params ? params : "");
> >+
> >+    } else {
> >+        /* Disable kernel irqchip to be able to override apic irq0. */
> >+        args = g_strdup_printf("-machine %s,accel=%s,kernel-irqchip=off "
> >+            "-net none -display none %s "
> >+            "-drive id=hd0,if=none,file=%s,format=raw "
> >+            "-device ide-hd,drive=hd0 ",
> >+             data->machine, "kvm:tcg", params ? params : "", disk);
> >+    }
> > 
> >     data->qts = qtest_init(args);
> > 
> >-    boot_sector_test(data->qts);
> >+    if (use_uefi) {
> >+        g_assert(data->scan_len);
> >+        data->rsdp_addr = acpi_find_rsdp_address_uefi(data->qts,
> >+            data->ram_start, data->scan_len);  
> 
> Is this possible to merge this in test_acpi_rsdp_address()? Both of them set
> the data->rsdp_addr.

I didn't want to duplicate use_uefi calculation and well test_acpi_rsdp_address()
isn't doing much and not reused elsewhere. I'll fold in here.

> 
> >+    } else {
> >+        boot_sector_test(data->qts);
> >+        test_acpi_rsdp_address(data);
> >+    }
> > 
> >     data->tables = g_array_new(false, true, sizeof(AcpiSdtTable));
> >-    test_acpi_rsdp_address(data);
> >     test_acpi_rsdp_table(data);
> >     test_acpi_rxsdt_table(data);
> >     test_acpi_fadt_table(data);
> >-- 
> >2.7.4  
> 
