Received: from eggs.gnu.org ([209.51.188.92]:42791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjoWN-0007gC-2F
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:58:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjoWL-0008RU-87
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:58:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gjoWK-0008Qr-LA
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:58:28 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so7730907wrx.9
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 08:58:28 -0800 (PST)
References: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
	<1547566866-129386-8-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8c69f9f3-3ea1-6b29-8c5d-11a0139490dc@redhat.com>
Date: Wed, 16 Jan 2019 17:58:25 +0100
MIME-Version: 1.0
In-Reply-To: <1547566866-129386-8-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 07/14] tests: acpi: skip FACS table if
 board uses hw reduced ACPI profile
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
> If FADT has HW_REDUCED_ACPI flag set, do not attempt to fetch
> FACS as it's not provided by the board.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/bios-tables-test.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 0f04a0a..8887319 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -146,9 +146,13 @@ static void test_acpi_fadt_table(test_data *data)
>      g_assert(compare_signature(&table, "FACP"));
>  
>      /* Since DSDT/FACS isn't in RSDT, add them to ASL test list manually */
> -    acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
> -                     fadt_aml + 36 /* FIRMWARE_CTRL */, "FACS", false);
> -    g_array_append_val(data->tables, table);
> +    memcpy(&val, fadt_aml + 112 /* Flags */, 4);
> +    val = le32_to_cpu(val);
> +    if (!(val & 1UL << 20 /* HW_REDUCED_ACPI */)) {
> +        acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
> +                         fadt_aml + 36 /* FIRMWARE_CTRL */, "FACS", false);
> +        g_array_append_val(data->tables, table);
> +    }
>  
>      memcpy(&val, fadt_aml + dsdt_offset, 4);
>      if (!val) {
> 
