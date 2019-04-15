Received: from eggs.gnu.org ([209.51.188.92]:49180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hG2AF-0007Pq-18
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 10:00:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hG2AA-0000tA-7k
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 10:00:50 -0400
Date: Mon, 15 Apr 2019 16:00:36 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190415160036.53bed360@Igors-MacBook-Pro.local>
In-Reply-To: <20190415070307.13668-3-richardw.yang@linux.intel.com>
References: <20190415070307.13668-1-richardw.yang@linux.intel.com>
	<20190415070307.13668-3-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/4] i386,
 acpi: remove mcfg_ prefix in AcpiMcfgInfo members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com, shannon.zhaosl@gmail.com, peter.maydell@linaro.org, marcel.apfelbaum@gmail.com, yang.zhong@intel.com

On Mon, 15 Apr 2019 15:03:05 +0800
Wei Yang <richardw.yang@linux.intel.com> wrote:

> This is obvious the member in AcpiMcfgInfo describe MCFG's property.
> 
> Remove the mcfg_ prefix.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/acpi-build.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index d009176072..f0d27bffd6 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -87,8 +87,8 @@
>  #define ACPI_BUILD_IOAPIC_ID 0x0
>  
>  typedef struct AcpiMcfgInfo {
> -    uint64_t mcfg_base;
> -    uint32_t mcfg_size;
> +    uint64_t base;
> +    uint32_t size;
>  } AcpiMcfgInfo;
>  
>  typedef struct AcpiPmInfo {
> @@ -2404,11 +2404,11 @@ build_mcfg_q35(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
>      int len = sizeof(*mcfg) + 1 * sizeof(mcfg->allocation[0]);
>  
>      mcfg = acpi_data_push(table_data, len);
> -    mcfg->allocation[0].address = cpu_to_le64(info->mcfg_base);
> +    mcfg->allocation[0].address = cpu_to_le64(info->base);
>      /* Only a single allocation so no need to play with segments */
>      mcfg->allocation[0].pci_segment = cpu_to_le16(0);
>      mcfg->allocation[0].start_bus_number = 0;
> -    mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->mcfg_size - 1);
> +    mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->size - 1);
>  
>      build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL, NULL);
>  }
> @@ -2577,15 +2577,15 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
>      if (!o) {
>          return false;
>      }
> -    mcfg->mcfg_base = qnum_get_uint(qobject_to(QNum, o));
> +    mcfg->base = qnum_get_uint(qobject_to(QNum, o));
>      qobject_unref(o);
> -    if (mcfg->mcfg_base == PCIE_BASE_ADDR_UNMAPPED) {
> +    if (mcfg->base == PCIE_BASE_ADDR_UNMAPPED) {
>          return false;
>      }
>  
>      o = object_property_get_qobject(pci_host, PCIE_HOST_MCFG_SIZE, NULL);
>      assert(o);
> -    mcfg->mcfg_size = qnum_get_uint(qobject_to(QNum, o));
> +    mcfg->size = qnum_get_uint(qobject_to(QNum, o));
>      qobject_unref(o);
>      return true;
>  }
