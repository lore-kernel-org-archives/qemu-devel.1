Received: from eggs.gnu.org ([209.51.188.92]:33609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hH68I-0001Bk-Of
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hH68H-0007xE-O0
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:27:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53725)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hH68H-0007wU-HU
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:27:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id q16so2551062wmj.3
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 05:27:13 -0700 (PDT)
References: <20190417014038.26018-1-richardw.yang@linux.intel.com>
	<20190417014038.26018-2-richardw.yang@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a96d8f02-4a90-9205-2f7e-82e68e88bca3@redhat.com>
Date: Thu, 18 Apr 2019 14:27:10 +0200
MIME-Version: 1.0
In-Reply-To: <20190417014038.26018-2-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 1/6] q35: acpi: do not create dummy MCFG
 table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, shannon.zhaosl@gmail.com, peter.maydell@linaro.org, marcel.apfelbaum@gmail.com, yang.zhong@intel.com

On 4/17/19 3:40 AM, Wei Yang wrote:
> From: Igor Mammedov <imammedo@redhat.com>
> 
> Dummy table (with signature "QEMU") creation came from original SeaBIOS
> codebase. And QEMU would have to keep it around if there were Q35 machine
> that depended on keeping ACPI tables blob constant size. Luckily there
> were no versioned Q35 machine types before commit:
>   (since 2.3) a1666142db acpi-build: make ROMs RAM blocks resizeable
> which obsoleted need to keep ACPI tables blob the same size on source/destination.
> 
> Considering the 1st versioned machine is pc-q35-2.4, the dummy table
> is not really necessary and it's safe to drop it without breaking
> cross version migration in both directions unconditionally.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  hw/i386/acpi-build.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index b17d4a711d..d009176072 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2401,7 +2401,6 @@ static void
>  build_mcfg_q35(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
>  {
>      AcpiTableMcfg *mcfg;
> -    const char *sig;
>      int len = sizeof(*mcfg) + 1 * sizeof(mcfg->allocation[0]);
>  
>      mcfg = acpi_data_push(table_data, len);
> @@ -2411,19 +2410,7 @@ build_mcfg_q35(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
>      mcfg->allocation[0].start_bus_number = 0;
>      mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->mcfg_size - 1);
>  
> -    /* MCFG is used for ECAM which can be enabled or disabled by guest.
> -     * To avoid table size changes (which create migration issues),
> -     * always create the table even if there are no allocations,
> -     * but set the signature to a reserved value in this case.
> -     * ACPI spec requires OSPMs to ignore such tables.
> -     */
> -    if (info->mcfg_base == PCIE_BASE_ADDR_UNMAPPED) {
> -        /* Reserved signature: ignored by OSPM */
> -        sig = "QEMU";
> -    } else {
> -        sig = "MCFG";
> -    }
> -    build_header(linker, table_data, (void *)mcfg, sig, len, 1, NULL, NULL);
> +    build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL, NULL);
>  }
>  
>  /*
> @@ -2592,6 +2579,9 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
>      }
>      mcfg->mcfg_base = qnum_get_uint(qobject_to(QNum, o));
>      qobject_unref(o);
> +    if (mcfg->mcfg_base == PCIE_BASE_ADDR_UNMAPPED) {
> +        return false;
> +    }
>  
>      o = object_property_get_qobject(pci_host, PCIE_HOST_MCFG_SIZE, NULL);
>      assert(o);
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
