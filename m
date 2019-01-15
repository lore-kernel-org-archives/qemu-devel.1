Received: from eggs.gnu.org ([209.51.188.92]:53122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gjVAa-0002Qs-FH
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:18:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gjVAY-0005e6-1W
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:18:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gjVAX-0005W1-Kn
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:18:41 -0500
References: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
	<1547566866-129386-9-git-send-email-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <21a83c4e-056b-f749-1b66-abaa5fe51e32@redhat.com>
Date: Tue, 15 Jan 2019 21:18:18 +0100
MIME-Version: 1.0
In-Reply-To: <1547566866-129386-9-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/14] tests: acpi: introduce an abilty
 start tests with UEFI firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Gonglei <arei.gonglei@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Andrew Jones <drjones@redhat.com>

On 01/15/19 16:41, Igor Mammedov wrote:
> For testcase to use UEFI firmware, one needs to provide and specify
> firmware and varstore blobs names in test_data { uefi_fl1, uefi_fl2) }
> fields respectively.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  tests/bios-tables-test.c | 36 ++++++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 8887319..d290dd2 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -26,6 +26,8 @@
>  typedef struct {
>      const char *machine;
>      const char *variant;
> +    const char *uefi_fl1;
> +    const char *uefi_fl2;
>      uint64_t rsdp_addr;
>      uint8_t rsdp_table[36 /* ACPI 2.0+ RSDP size */];
>      GArray *tables;
> @@ -519,21 +521,35 @@ static void test_smbios_structs(test_data *data)
>  static void test_acpi_one(const char *params, test_data *data)
>  {
>      char *args;
> -
> -    /* Disable kernel irqchip to be able to override apic irq0. */
> -    args = g_strdup_printf("-machine %s,accel=%s,kernel-irqchip=off "
> -                           "-net none -display none %s "
> -                           "-drive id=hd0,if=none,file=%s,format=raw "
> -                           "-device ide-hd,drive=hd0 ",
> -                           data->machine, "kvm:tcg",
> -                           params ? params : "", disk);
> +    bool use_uefi = data->uefi_fl1 && data->uefi_fl2;
> +
> +    if (use_uefi) {
> +        args = g_strdup_printf("-machine %s,accel=%s -nodefaults -nographic "
> +            "-drive if=pflash,format=raw,file=%s/%s,readonly "
> +            "-drive if=pflash,format=raw,file=%s/%s,snapshot=on %s",

Today I Learned: about "snapshot=on". Thanks :) The command line looks good.

> +            data->machine, "kvm:tcg", data_dir, data->uefi_fl1, data_dir,

You could open-code "kvm:tcg" in the format string at once (unless you
turn that into a parameter in a later patch in the series). But, I see
the pre-patch code passes "kvm:tcg" as an argument too.

> +            data->uefi_fl2, params ? params : "");
> +
> +    } else {
> +        /* Disable kernel irqchip to be able to override apic irq0. */
> +        args = g_strdup_printf("-machine %s,accel=%s,kernel-irqchip=off "
> +            "-net none -display none %s "
> +            "-drive id=hd0,if=none,file=%s,format=raw "
> +            "-device ide-hd,drive=hd0 ",
> +             data->machine, "kvm:tcg", params ? params : "", disk);
> +    }
>  
>      data->qts = qtest_init(args);
>  
> -    boot_sector_test(data->qts);
> +    if (use_uefi) {
> +        data->rsdp_addr = uefi_find_rsdp_addr(data->qts,
> +            0x40000000ULL, 128ULL * 1024 * 1024);

I think open-coding the DRAM size is valid; after all, it depends on the
QEMU command line, and you control the QEMU command line above. However,
do we really want to open-code the DRAM base here? That's
board-specific. Should we pass that too through the "test_data" structure?

> +    } else {
> +        boot_sector_test(data->qts);
> +        test_acpi_rsdp_address(data);
> +    }
>  
>      data->tables = g_array_new(false, true, sizeof(AcpiSdtTable));
> -    test_acpi_rsdp_address(data);
>      test_acpi_rsdp_table(data);
>      test_acpi_rxsdt_table(data);
>      test_acpi_fadt_table(data);
> 

Thanks,
Laszlo
