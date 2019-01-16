Received: from eggs.gnu.org ([209.51.188.92]:37877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjoMB-0002g1-CU
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:48:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjoM9-0003sk-8l
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:47:59 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gjoM7-0003qm-6y
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:47:55 -0500
Received: by mail-wr1-f67.google.com with SMTP id z5so7664871wrt.11
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 08:47:53 -0800 (PST)
References: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
	<1547566866-129386-3-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3860135c-2f7a-1204-a16e-b7ea0d1dc229@redhat.com>
Date: Wed, 16 Jan 2019 17:47:45 +0100
MIME-Version: 1.0
In-Reply-To: <1547566866-129386-3-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 02/14] tests: acpi: make RSDT test routine
 handle XSDT
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
> If RSDP revision is more than 0 fetch table pointed by XSDT
> and fallback to legacy RSDT table otherwise.
> 
> While at it drop unused acpi_get_xsdt_address().
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> PS:
>  it doesn't affect existing pc/q35 machines as they use RSDP.revision == 0
>  but it will be used by followup patch to enable testing arm/virt
>  board which uses provides XSDT table.
> ---
>  tests/acpi-utils.h       |  3 +--
>  tests/acpi-utils.c       | 14 +-------------
>  tests/bios-tables-test.c | 18 +++++++++++++-----
>  3 files changed, 15 insertions(+), 20 deletions(-)
> 
> diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
> index 3b11f47..398900c 100644
> --- a/tests/acpi-utils.h
> +++ b/tests/acpi-utils.h
> @@ -47,8 +47,7 @@ typedef struct {
>  uint8_t acpi_calc_checksum(const uint8_t *data, int len);
>  uint32_t acpi_find_rsdp_address(QTestState *qts);
>  uint64_t uefi_find_rsdp_addr(QTestState *qts, uint64_t start, uint64_t size);
> -uint64_t acpi_get_xsdt_address(uint8_t *rsdp_table);
> -void acpi_parse_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table);
> +void acpi_parse_rsdp_table(QTestState *qts, uint64_t addr, uint8_t *rsdp_table);
>  void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
>                        const uint8_t *addr_ptr, const char *sig,
>                        bool verify_checksum);
> diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
> index b9ff9df..84068a8 100644
> --- a/tests/acpi-utils.c
> +++ b/tests/acpi-utils.c
> @@ -51,19 +51,7 @@ uint32_t acpi_find_rsdp_address(QTestState *qts)
>      return off;
>  }
>  
> -uint64_t acpi_get_xsdt_address(uint8_t *rsdp_table)
> -{
> -    uint64_t xsdt_physical_address;
> -    uint8_t revision = rsdp_table[15 /* Revision offset */];
> -
> -    /* We must have revision 2 if we're looking for an XSDT pointer */
> -    g_assert(revision == 2);
> -
> -    memcpy(&xsdt_physical_address, &rsdp_table[24 /* XsdtAddress offset */], 8);
> -    return le64_to_cpu(xsdt_physical_address);
> -}
> -
> -void acpi_parse_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table)
> +void acpi_parse_rsdp_table(QTestState *qts, uint64_t addr, uint8_t *rsdp_table)
>  {
>      uint8_t revision;
>  
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 0bf7164..529bfc4 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -107,17 +107,25 @@ static void test_acpi_rsdp_table(test_data *data)
>      }
>  }
>  
> -static void test_acpi_rsdt_table(test_data *data)
> +static void test_acpi_rxsdt_table(test_data *data)
>  {
> +    const char *sig = "RSDT";
>      AcpiSdtTable rsdt = {};
> +    int entry_size = 4;
> +    int addr_off = 16 /* RsdtAddress */;
>      uint8_t *ent;
>  
> -    /* read RSDT table */
> +    if (data->rsdp_table[15 /* Revision offset */] != 0) {
> +        addr_off = 24 /* XsdtAddress */;
> +        entry_size = 8;
> +        sig = "XSDT";
> +    }
> +    /* read [RX]SDT table */
>      acpi_fetch_table(data->qts, &rsdt.aml, &rsdt.aml_len,
> -                     &data->rsdp_table[16 /* RsdtAddress */], "RSDT", true);
> +                     &data->rsdp_table[addr_off], sig, true);
>  
>      /* Load all tables and add to test list directly RSDT referenced tables */
> -    ACPI_FOREACH_RSDT_ENTRY(rsdt.aml, rsdt.aml_len, ent, 4 /* Entry size */) {
> +    ACPI_FOREACH_RSDT_ENTRY(rsdt.aml, rsdt.aml_len, ent, entry_size) {
>          AcpiSdtTable ssdt_table = {};
>  
>          acpi_fetch_table(data->qts, &ssdt_table.aml, &ssdt_table.aml_len, ent,
> @@ -519,7 +527,7 @@ static void test_acpi_one(const char *params, test_data *data)
>      data->tables = g_array_new(false, true, sizeof(AcpiSdtTable));
>      test_acpi_rsdp_address(data);
>      test_acpi_rsdp_table(data);
> -    test_acpi_rsdt_table(data);
> +    test_acpi_rxsdt_table(data);
>      test_acpi_fadt_table(data);
>  
>      if (iasl) {
> 
