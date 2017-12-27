Received: from eggs.gnu.org ([2001:4830:134:3::10]:43956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eU7H6-00050W-OU
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 03:41:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eU7H5-0003ZI-Ms
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 03:41:20 -0500
Date: Wed, 27 Dec 2017 09:41:09 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20171227084109.ruylcg2dimvr6bbe@hawk.localdomain>
References: <1514362572-1624-1-git-send-email-zhaoshenglong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1514362572-1624-1-git-send-email-zhaoshenglong@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v2] Virt: ACPI: fix qemu assert due to
 re-assigned table data address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, lersek@redhat.com, qemu-devel@nongnu.org

On Wed, Dec 27, 2017 at 04:16:12PM +0800, Shannon Zhao wrote:
> From: Zhaoshenglong <zhaoshenglong@huawei.com>
> 
> acpi_data_push uses g_array_set_size to resize the memory size. If there
> is no enough contiguous memory, the address will be changed. If we use
> the old value, it will assert.
> qemu-kvm: hw/acpi/bios-linker-loader.c:214: bios_linker_loader_add_checksum:
> Assertion `start_offset < file->blob->len' failed.`
> 
> This issue only happens in building SRAT table now but here we unify the
> pattern for other tables as well to avoid possible issues in the future.
> 
> Signed-off-by: Zhaoshenglong <zhaoshenglong@huawei.com>
> ---
> v2: update the commit message according to Andrew's comments
> ---
>  hw/arm/virt-acpi-build.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 3d78ff6..5901142 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -453,6 +453,7 @@ build_spcr(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      AcpiSerialPortConsoleRedirection *spcr;
>      const MemMapEntry *uart_memmap = &vms->memmap[VIRT_UART];
>      int irq = vms->irqmap[VIRT_UART] + ARM_SPI_BASE;
> +    int spcr_start = table_data->len;
>  
>      spcr = acpi_data_push(table_data, sizeof(*spcr));
>  
> @@ -476,8 +477,8 @@ build_spcr(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      spcr->pci_device_id = 0xffff;  /* PCI Device ID: not a PCI device */
>      spcr->pci_vendor_id = 0xffff;  /* PCI Vendor ID: not a PCI device */
>  
> -    build_header(linker, table_data, (void *)spcr, "SPCR", sizeof(*spcr), 2,
> -                 NULL, NULL);
> +    build_header(linker, table_data, (void *)(table_data->data + spcr_start),
> +                 "SPCR", table_data->len - spcr_start, 2, NULL, NULL);
>  }
>  
>  static void
> @@ -512,8 +513,8 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          mem_base += numa_info[i].node_mem;
>      }
>  
> -    build_header(linker, table_data, (void *)srat, "SRAT",
> -                 table_data->len - srat_start, 3, NULL, NULL);
> +    build_header(linker, table_data, (void *)(table_data->data + srat_start),
> +                 "SRAT", table_data->len - srat_start, 3, NULL, NULL);
>  }
>  
>  static void
> @@ -522,6 +523,7 @@ build_mcfg(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      AcpiTableMcfg *mcfg;
>      const MemMapEntry *memmap = vms->memmap;
>      int len = sizeof(*mcfg) + sizeof(mcfg->allocation[0]);
> +    int mcfg_start = table_data->len;
>  
>      mcfg = acpi_data_push(table_data, len);
>      mcfg->allocation[0].address = cpu_to_le64(memmap[VIRT_PCIE_ECAM].base);
> @@ -532,7 +534,8 @@ build_mcfg(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      mcfg->allocation[0].end_bus_number = (memmap[VIRT_PCIE_ECAM].size
>                                            / PCIE_MMCFG_SIZE_MIN) - 1;
>  
> -    build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL, NULL);
> +    build_header(linker, table_data, (void *)(table_data->data + mcfg_start),
> +                 "MCFG", len, 1, NULL, NULL);

If we're going to change all of them for the new pattern, then len should
be changed here to table_data->len - mcfg_start

>  }
>  
>  /* GTDT */
> @@ -651,6 +654,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  static void build_fadt(GArray *table_data, BIOSLinker *linker,
>                         VirtMachineState *vms, unsigned dsdt_tbl_offset)
>  {
> +    int fadt_start = table_data->len;
>      AcpiFadtDescriptorRev5_1 *fadt = acpi_data_push(table_data, sizeof(*fadt));
>      unsigned xdsdt_entry_offset = (char *)&fadt->x_dsdt - table_data->data;
>      uint16_t bootflags;
> @@ -681,8 +685,8 @@ static void build_fadt(GArray *table_data, BIOSLinker *linker,
>          ACPI_BUILD_TABLE_FILE, xdsdt_entry_offset, sizeof(fadt->x_dsdt),
>          ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset);
>  
> -    build_header(linker, table_data,
> -                 (void *)fadt, "FACP", sizeof(*fadt), 5, NULL, NULL);
> +    build_header(linker, table_data, (void *)(table_data->data + fadt_start),
> +                 "FACP", table_data->len - fadt_start, 5, NULL, NULL);
>  }
>  
>  /* DSDT */
> -- 
> 2.0.4
> 
> 
>

Thanks,
drew 
