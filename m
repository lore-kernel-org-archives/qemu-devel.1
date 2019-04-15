Received: from eggs.gnu.org ([209.51.188.92]:37620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hG1G0-0004Hi-1q
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:02:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hG1Ft-0004zL-C1
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:02:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hG1Fp-0004ir-M2
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:02:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so21810999wra.12
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 06:02:22 -0700 (PDT)
References: <20190415070307.13668-1-richardw.yang@linux.intel.com>
	<20190415070307.13668-2-richardw.yang@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d4d6f1d4-9df8-a73e-4086-6c43e5ba7b4a@redhat.com>
Date: Mon, 15 Apr 2019 15:02:20 +0200
MIME-Version: 1.0
In-Reply-To: <20190415070307.13668-2-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/4] hw/arm/virt-acpi-build: remove
 unnecessary variable mcfg_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, mst@redhat.com, shannon.zhaosl@gmail.com, imammedo@redhat.com

On 4/15/19 9:03 AM, Wei Yang wrote:
> mcfg_start points to the start of MCFG table and is used in
> build_header. While this information could be derived from mcfg.
> 
> This patch removes the unnecessary variable mcfg_start.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/arm/virt-acpi-build.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 857989362a..e09e7eff8d 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -552,7 +552,6 @@ build_mcfg(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      const MemMapEntry *memmap = vms->memmap;
>      int ecam_id = VIRT_ECAM_ID(vms->highmem_ecam);
>      int len = sizeof(*mcfg) + sizeof(mcfg->allocation[0]);
> -    int mcfg_start = table_data->len;
>  
>      mcfg = acpi_data_push(table_data, len);
>      mcfg->allocation[0].address = cpu_to_le64(memmap[ecam_id].base);
> @@ -563,8 +562,7 @@ build_mcfg(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      mcfg->allocation[0].end_bus_number =
>          PCIE_MMCFG_BUS(memmap[ecam_id].size - 1);
>  
> -    build_header(linker, table_data, (void *)(table_data->data + mcfg_start),
> -                 "MCFG", table_data->len - mcfg_start, 1, NULL, NULL);
> +    build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL, NULL);
>  }
>  
>  /* GTDT */
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
