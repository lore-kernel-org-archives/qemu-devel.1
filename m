Received: from eggs.gnu.org ([209.51.188.92]:43145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gk8G5-0000Rj-E6
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:03:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gk8G4-0007qL-8F
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:03:01 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gk8G4-0007oZ-2O
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:03:00 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so11090897wrt.11
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 06:03:00 -0800 (PST)
References: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
	<1547566866-129386-6-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2dd66229-b11e-4081-8934-bec2c5a16364@redhat.com>
Date: Thu, 17 Jan 2019 15:02:57 +0100
MIME-Version: 1.0
In-Reply-To: <1547566866-129386-6-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/14] tests: acpi: fetch X_DSDT if pointer
 to DSDT is 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Gonglei <arei.gonglei@huawei.com>, Laszlo Ersek <lersek@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Andrew Jones <drjones@redhat.com>

On 1/15/19 4:40 PM, Igor Mammedov wrote:
> that way it would be possible to test a DSDT pointed by
> 64bit X_DSDT field in FADT.
> 
> PS:
> it will allow to enable testing arm/virt board, which sets
> only newer X_DSDT field.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  tests/bios-tables-test.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index c28c5c7..0f04a0a 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -140,6 +140,8 @@ static void test_acpi_fadt_table(test_data *data)
>      AcpiSdtTable table = g_array_index(data->tables, typeof(table), 0);
>      uint8_t *fadt_aml = table.aml;
>      uint32_t fadt_len = table.aml_len;
> +    uint32_t val;
> +    int dsdt_offset = 40 /* DSDT */;
>  
>      g_assert(compare_signature(&table, "FACP"));
>  
> @@ -148,8 +150,12 @@ static void test_acpi_fadt_table(test_data *data)
>                       fadt_aml + 36 /* FIRMWARE_CTRL */, "FACS", false);
>      g_array_append_val(data->tables, table);
>  
> +    memcpy(&val, fadt_aml + dsdt_offset, 4);

Maybe in case someone extend this test, add:

       val = le32_to_cpu(val);

Regardless:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +    if (!val) {
> +        dsdt_offset = 140 /* X_DSDT */;
> +    }
>      acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
> -                     fadt_aml + 40 /* DSDT */, "DSDT", true);
> +                     fadt_aml + dsdt_offset, "DSDT", true);
>      g_array_append_val(data->tables, table);
>  
>      memset(fadt_aml + 36, 0, 4); /* sanitize FIRMWARE_CTRL ptr */
> 
