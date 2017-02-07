Received: from eggs.gnu.org ([2001:4830:134:3::10]:54837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbDuc-0006Ck-54
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 17:06:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbDuY-0006EO-QJ
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 17:06:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cbDuY-0006E8-Jp
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 17:06:54 -0500
References: <cover.1486285434.git.ben@skyportsystems.com>
	<91b9bb30a86d2b303bab813f7f5ad361810c3149.1486285434.git.ben@skyportsystems.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <458f1608-0fe2-60cf-2407-4d45c6aa8639@redhat.com>
Date: Tue, 7 Feb 2017 23:06:50 +0100
MIME-Version: 1.0
In-Reply-To: <91b9bb30a86d2b303bab813f7f5ad361810c3149.1486285434.git.ben@skyportsystems.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 04/10] ACPI: Add vmgenid storage entries
 to the build tables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ben@skyportsystems.com, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, mst@redhat.com

On 02/05/17 10:11, ben@skyportsystems.com wrote:
> From: Ben Warren <ben@skyportsystems.com>
> 
> This allows them to be centrally initialized and destroyed
> 
> Signed-off-by: Ben Warren <ben@skyportsystems.com>
> ---
>  hw/acpi/aml-build.c         | 2 ++
>  include/hw/acpi/aml-build.h | 1 +
>  2 files changed, 3 insertions(+)

Please replace "storage entries" in the subject line with "blob
storage", and add the following to the commit message:

----
The "AcpiBuildTables.vmgenid" array will be used to construct the
"etc/vmgenid" fw_cfg blob.

Its contents will be linked into fw_cfg after being built on the
pc_machine_done() -> acpi_setup() -> acpi_build() call path, and dropped
without use on the subsequent, guest triggered, acpi_build_update() ->
acpi_build() call path.
----

... This commit message update actually exposes an important flaw in the
implementation (one that entirely escaped me in the previous round!!!),
but as I've now read forward a little bit, into patch 5, I see that
Michael caught it, which is awesome!

So, with the new fw-cfg callback (on which I'll comment under the next
patch), and with the above commit message / subject updates, please add:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks!
Laszlo

> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 03b6c6c..0f39eaf 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1594,6 +1594,7 @@ void acpi_build_tables_init(AcpiBuildTables *tables)
>      tables->rsdp = g_array_new(false, true /* clear */, 1);
>      tables->table_data = g_array_new(false, true /* clear */, 1);
>      tables->tcpalog = g_array_new(false, true /* clear */, 1);
> +    tables->vmgenid = g_array_new(false, true /* clear */, 1);
>      tables->linker = bios_linker_loader_init();
>  }
>  
> @@ -1603,6 +1604,7 @@ void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre)
>      g_array_free(tables->rsdp, true);
>      g_array_free(tables->table_data, true);
>      g_array_free(tables->tcpalog, mfre);
> +    g_array_free(tables->vmgenid, mfre);
>  }
>  
>  /* Build rsdt table */
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index dbf63cf..6f4e239 100644
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
