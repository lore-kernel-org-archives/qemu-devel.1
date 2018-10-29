Received: from eggs.gnu.org ([2001:4830:134:3::10]:34102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHCnQ-0001eb-T9
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 15:01:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHCnL-0006Vp-Q5
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 15:01:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42447)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHCnL-0006UJ-Jj
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 15:01:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id y15-v6so9908183wru.9
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 12:01:47 -0700 (PDT)
References: <20181029170159.3801-1-sameo@linux.intel.com>
	<20181029170159.3801-3-sameo@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fe55aa00-45c3-5779-b84a-874fae3236bb@redhat.com>
Date: Mon, 29 Oct 2018 20:01:44 +0100
MIME-Version: 1.0
In-Reply-To: <20181029170159.3801-3-sameo@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 02/19] hw: acpi: Export ACPI build
 alignment API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On 29/10/18 18:01, Samuel Ortiz wrote:
> This is going to be needed by the Hardware-reduced ACPI routines.
> 
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> ---
>   hw/acpi/aml-build.c         | 8 ++++++++
>   hw/i386/acpi-build.c        | 8 --------
>   include/hw/acpi/aml-build.h | 2 ++
>   3 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 1e43cd736d..51b608432f 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1565,6 +1565,14 @@ unsigned acpi_data_len(GArray *table)
>       return table->len;
>   }
>   
> +void acpi_align_size(GArray *blob, unsigned align)
> +{
> +    /* Align size to multiple of given size. This reduces the chance
> +     * we need to change size in the future (breaking cross version migration).
> +     */
> +    g_array_set_size(blob, ROUND_UP(acpi_data_len(blob), align));
> +}
> +
>   void acpi_add_table(GArray *table_offsets, GArray *table_data)
>   {
>       uint32_t offset = table_data->len;
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index c8545238c4..1bf02b6a93 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -282,14 +282,6 @@ static void acpi_get_pci_holes(Range *hole, Range *hole64)
>                                                  NULL));
>   }
>   
> -static void acpi_align_size(GArray *blob, unsigned align)
> -{
> -    /* Align size to multiple of given size. This reduces the chance
> -     * we need to change size in the future (breaking cross version migration).
> -     */
> -    g_array_set_size(blob, ROUND_UP(acpi_data_len(blob), align));
> -}
> -
>   /* FACS */
>   static void
>   build_facs(GArray *table_data, BIOSLinker *linker)
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index 6c36903c0a..813f51317c 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -6,6 +6,7 @@
>   
>   /* Reserve RAM space for tables: add another order of magnitude. */
>   #define ACPI_BUILD_TABLE_MAX_SIZE         0x200000
> +#define ACPI_BUILD_ALIGN_SIZE             0x1000

This definition doesn't seem used in this series.

>   
>   #define ACPI_BUILD_APPNAME6 "BOCHS "
>   #define ACPI_BUILD_APPNAME4 "BXPC"
> @@ -384,6 +385,7 @@ build_header(BIOSLinker *linker, GArray *table_data,
>                const char *oem_id, const char *oem_table_id);
>   void *acpi_data_push(GArray *table_data, unsigned size);
>   unsigned acpi_data_len(GArray *table);

With a 1 line documentation comment here:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +void acpi_align_size(GArray *blob, unsigned align);
>   void acpi_add_table(GArray *table_offsets, GArray *table_data);
>   void acpi_build_tables_init(AcpiBuildTables *tables);
>   void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre);
> 
