Received: from eggs.gnu.org ([2001:4830:134:3::10]:57979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dctDA-0001Ap-IL
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dctD7-0006n4-He
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:57:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dctD7-0006mi-BA
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:57:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1F3367F3E3
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 12:57:12 +0000 (UTC)
References: <1501515652-33372-1-git-send-email-imammedo@redhat.com>
	<1501515652-33372-2-git-send-email-imammedo@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <c019b947-fda6-6a4f-5722-c45e77c3defd@redhat.com>
Date: Wed, 2 Aug 2017 15:57:06 +0300
MIME-Version: 1.0
In-Reply-To: <1501515652-33372-2-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/5] tests: acpi: move tested
 tables array allocation outside of test_acpi_dsdt_table()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>

On 31/07/2017 18:40, Igor Mammedov wrote:
> at best it's confusing that array for list of tables to be tested
> against reference tables is allocated within test_acpi_dsdt_table()
> and at worst it would just overwrite list of tables if they were
> added before test_acpi_dsdt_table().
> Move array initialization to test_acpi_one() before we start
> processing tables.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   tests/bios-tables-test.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 63da978..b72fa80 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -229,12 +229,11 @@ static void test_acpi_dsdt_table(test_data *data)
>       uint32_t addr = data->fadt_table.dsdt;
>   
>       memset(&dsdt_table, 0, sizeof(dsdt_table));
> -    data->tables = g_array_new(false, true, sizeof(AcpiSdtTable));
>   
>       test_dst_table(&dsdt_table, addr);
>       ACPI_ASSERT_CMP(dsdt_table.header.signature, "DSDT");
>   
> -    /* Place DSDT first */
> +    /* Since DSDT isn't in RSDT, add DSDT to ASL test tables list manually */
>       g_array_append_val(data->tables, dsdt_table);
>   }
>   
> @@ -634,6 +633,7 @@ static void test_acpi_one(const char *params, test_data *data)
>   
>       boot_sector_test();
>   
> +    data->tables = g_array_new(false, true, sizeof(AcpiSdtTable));
>       test_acpi_rsdp_address(data);
>       test_acpi_rsdp_table(data);
>       test_acpi_rsdt_table(data);
> 

Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
