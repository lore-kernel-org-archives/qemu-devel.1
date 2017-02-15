Received: from eggs.gnu.org ([2001:4830:134:3::10]:32940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ce0bi-0003E7-9K
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:30:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ce0bd-0004Fk-Cq
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:30:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1ce0bd-0004FD-6H
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:30:53 -0500
References: <cover.1487139038.git.ben@skyportsystems.com>
	<60b6ece3ce0a24aec79c1061627fa2e6ab058fc2.1487139038.git.ben@skyportsystems.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a155508d-4b44-6ca3-02cb-d36bb9b8f100@redhat.com>
Date: Wed, 15 Feb 2017 15:30:50 +0100
MIME-Version: 1.0
In-Reply-To: <60b6ece3ce0a24aec79c1061627fa2e6ab058fc2.1487139038.git.ben@skyportsystems.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 3/7] ACPI: Add vmgenid blob storage to
 the build tables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ben@skyportsystems.com, qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com

On 02/15/17 07:15, ben@skyportsystems.com wrote:
> From: Ben Warren <ben@skyportsystems.com>
> 
> This allows them to be centrally initialized and destroyed
> 
> The "AcpiBuildTables.vmgenid" array will be used to construct the
> "etc/vmgenid" fw_cfg blob.

Trivial wart: the blob is now called "etc/vmgenid_guid".

If you send a v7, feel free to fix it up. Not critical.

My R-b stands.

Thanks!
Laszlo

> Its contents will be linked into fw_cfg after being built on the
> pc_machine_done() -> acpi_setup() -> acpi_build() call path, and dropped
> without use on the subsequent, guest triggered, acpi_build_update() ->
> acpi_build() call path.
> 
> Signed-off-by: Ben Warren <ben@skyportsystems.com>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  hw/acpi/aml-build.c         | 2 ++
>  include/hw/acpi/aml-build.h | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index b2a1e40..c6f2032 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1559,6 +1559,7 @@ void acpi_build_tables_init(AcpiBuildTables *tables)
>      tables->rsdp = g_array_new(false, true /* clear */, 1);
>      tables->table_data = g_array_new(false, true /* clear */, 1);
>      tables->tcpalog = g_array_new(false, true /* clear */, 1);
> +    tables->vmgenid = g_array_new(false, true /* clear */, 1);
>      tables->linker = bios_linker_loader_init();
>  }
>  
> @@ -1568,6 +1569,7 @@ void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre)
>      g_array_free(tables->rsdp, true);
>      g_array_free(tables->table_data, true);
>      g_array_free(tables->tcpalog, mfre);
> +    g_array_free(tables->vmgenid, mfre);
>  }
>  
>  /* Build rsdt table */
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index 559326c..00c21f1 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -210,6 +210,7 @@ struct AcpiBuildTables {
>      GArray *table_data;
>      GArray *rsdp;
>      GArray *tcpalog;
> +    GArray *vmgenid;
>      BIOSLinker *linker;
>  } AcpiBuildTables;
>  
> 
