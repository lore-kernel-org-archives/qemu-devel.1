Received: from eggs.gnu.org ([208.118.235.92]:40238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gcwMc-0003Nu-VD
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 12:56:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gcwLc-0004np-SE
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 12:55:03 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:46023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gcwLc-0004lr-MO
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 12:55:00 -0500
Received: by mail-wr1-f48.google.com with SMTP id t6so21533496wrr.12
	for <qemu-devel@nongnu.org>; Fri, 28 Dec 2018 09:55:00 -0800 (PST)
References: <1545920014-114011-1-git-send-email-imammedo@redhat.com>
	<1545920014-114011-7-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e4697a43-f49f-4adb-5b40-365ce45ebc90@redhat.com>
Date: Fri, 28 Dec 2018 18:54:57 +0100
MIME-Version: 1.0
In-Reply-To: <1545920014-114011-7-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 6/8] tests: smbios: fetch whole table in
 one step instead of reading it step by step
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, wainersm@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>

On 12/27/18 3:13 PM, Igor Mammedov wrote:
> replace a bunch of ACPI_READ_ARRAY/ACPI_READ_FIELD macro, that read
> SMBIOS table field by field with one memread() to fetch whole table
> at once and drop no longer used ACPI_READ_ARRAY/ACPI_READ_FIELD macro.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> V2:
>   rebase: s/memread/qtest_memread/
> ---
>  tests/acpi-utils.h       | 17 -----------------
>  tests/bios-tables-test.c | 15 +--------------
>  2 files changed, 1 insertion(+), 31 deletions(-)
> 
> diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
> index 1aa00db..cb7183e 100644
> --- a/tests/acpi-utils.h
> +++ b/tests/acpi-utils.h
> @@ -30,23 +30,6 @@ typedef struct {
>      bool tmp_files_retain;   /* do not delete the temp asl/aml */
>  } AcpiSdtTable;
>  
> -#define ACPI_READ_FIELD(qts, field, addr)                \
> -    do {                                                 \
> -        qtest_memread(qts, addr, &field, sizeof(field)); \
> -        addr += sizeof(field);                           \
> -    } while (0)
> -
> -#define ACPI_READ_ARRAY_PTR(qts, arr, length, addr)      \
> -    do {                                                 \
> -        int idx;                                         \
> -        for (idx = 0; idx < length; ++idx) {             \
> -            ACPI_READ_FIELD(qts, arr[idx], addr);        \
> -        }                                                \
> -    } while (0)
> -
> -#define ACPI_READ_ARRAY(qts, arr, addr)                                 \
> -    ACPI_READ_ARRAY_PTR(qts, arr, sizeof(arr) / sizeof(arr[0]), addr)
> -
>  #define ACPI_ASSERT_CMP(actual, expected) do { \
>      char ACPI_ASSERT_CMP_str[5] = {}; \
>      memcpy(ACPI_ASSERT_CMP_str, &actual, 4); \
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 8fdd1c1..dcd6be8 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -406,32 +406,19 @@ static bool smbios_ep_table_ok(test_data *data)
>      struct smbios_21_entry_point *ep_table = &data->smbios_ep_table;
>      uint32_t addr = data->smbios_ep_addr;
>  
> -    ACPI_READ_ARRAY(data->qts, ep_table->anchor_string, addr);
> +    qtest_memread(data->qts, addr, ep_table, sizeof(*ep_table));
>      if (memcmp(ep_table->anchor_string, "_SM_", 4)) {
>          return false;
>      }
> -    ACPI_READ_FIELD(data->qts, ep_table->checksum, addr);
> -    ACPI_READ_FIELD(data->qts, ep_table->length, addr);
> -    ACPI_READ_FIELD(data->qts, ep_table->smbios_major_version, addr);
> -    ACPI_READ_FIELD(data->qts, ep_table->smbios_minor_version, addr);
> -    ACPI_READ_FIELD(data->qts, ep_table->max_structure_size, addr);
> -    ACPI_READ_FIELD(data->qts, ep_table->entry_point_revision, addr);
> -    ACPI_READ_ARRAY(data->qts, ep_table->formatted_area, addr);
> -    ACPI_READ_ARRAY(data->qts, ep_table->intermediate_anchor_string, addr);
>      if (memcmp(ep_table->intermediate_anchor_string, "_DMI_", 5)) {
>          return false;
>      }
> -    ACPI_READ_FIELD(data->qts, ep_table->intermediate_checksum, addr);
> -    ACPI_READ_FIELD(data->qts, ep_table->structure_table_length, addr);
>      if (ep_table->structure_table_length == 0) {
>          return false;
>      }
> -    ACPI_READ_FIELD(data->qts, ep_table->structure_table_address, addr);
> -    ACPI_READ_FIELD(data->qts, ep_table->number_of_structures, addr);
>      if (ep_table->number_of_structures == 0) {
>          return false;
>      }
> -    ACPI_READ_FIELD(data->qts, ep_table->smbios_bcd_revision, addr);
>      if (acpi_calc_checksum((uint8_t *)ep_table, sizeof *ep_table) ||
>          acpi_calc_checksum((uint8_t *)ep_table + 0x10,
>                             sizeof *ep_table - 0x10)) {
> 
