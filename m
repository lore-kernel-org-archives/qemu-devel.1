Received: from eggs.gnu.org ([2001:4830:134:3::10]:59416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fO3gu-0001xr-Cs
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:11:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fO3gs-0004d6-UG
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:11:12 -0400
References: <1527690380-9782-1-git-send-email-eric.auger@redhat.com>
	<1527690380-9782-2-git-send-email-eric.auger@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f80946ef-0bf6-7e8b-e421-86dc3555fa80@redhat.com>
Date: Wed, 30 May 2018 18:11:01 +0200
MIME-Version: 1.0
In-Reply-To: <1527690380-9782-2-git-send-email-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/arm/virt: Add a new 256MB ECAM
 region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: drjones@redhat.com, wei@redhat.com, zhaoshenglong@huawei.com, ard.biesheuvel@linaro.org

On 05/30/18 16:26, Eric Auger wrote:
> This patch defines a new ECAM region located after the 256GB limit.
> 
> The virt machine state is augmented with a new highmem_ecam field
> which guards the usage of this new ECAM region instead of the legacy
> 16MB one. With the highmem ECAM region, up to 256 PCIe buses can be
> used.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> RFC -> PATCH:
> - remove the newline at the end of acpi_dsdt_add_pci
> - use vms->highmem_ecam to select the memmap id
> ---
>  hw/arm/virt-acpi-build.c | 21 +++++++++++++--------
>  hw/arm/virt.c            | 12 ++++++++----
>  include/hw/arm/virt.h    |  2 ++
>  3 files changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 92ceee9..c0370b2 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -150,16 +150,17 @@ static void acpi_dsdt_add_virtio(Aml *scope,
>  }
>  
>  static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
> -                              uint32_t irq, bool use_highmem)
> +                              uint32_t irq, bool use_highmem, bool highmem_ecam)
>  {
> +    int ecam_id = highmem_ecam ? VIRT_PCIE_ECAM_HIGH : VIRT_PCIE_ECAM;
>      Aml *method, *crs, *ifctx, *UUID, *ifctx1, *elsectx, *buf;
>      int i, bus_no;
>      hwaddr base_mmio = memmap[VIRT_PCIE_MMIO].base;
>      hwaddr size_mmio = memmap[VIRT_PCIE_MMIO].size;
>      hwaddr base_pio = memmap[VIRT_PCIE_PIO].base;
>      hwaddr size_pio = memmap[VIRT_PCIE_PIO].size;
> -    hwaddr base_ecam = memmap[VIRT_PCIE_ECAM].base;
> -    hwaddr size_ecam = memmap[VIRT_PCIE_ECAM].size;
> +    hwaddr base_ecam = memmap[ecam_id].base;
> +    hwaddr size_ecam = memmap[ecam_id].size;
>      int nr_pcie_buses = size_ecam / PCIE_MMCFG_SIZE_MIN;
>  
>      Aml *dev = aml_device("%s", "PCI0");
> @@ -173,7 +174,7 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
>      aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
>  
>      /* Declare the PCI Routing Table. */
> -    Aml *rt_pkg = aml_package(nr_pcie_buses * PCI_NUM_PINS);
> +    Aml *rt_pkg = aml_varpackage(nr_pcie_buses * PCI_NUM_PINS);
>      for (bus_no = 0; bus_no < nr_pcie_buses; bus_no++) {
>          for (i = 0; i < PCI_NUM_PINS; i++) {
>              int gsi = (i + bus_no) % PCI_NUM_PINS;
> @@ -316,7 +317,10 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
>      Aml *dev_res0 = aml_device("%s", "RES0");
>      aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));
>      crs = aml_resource_template();
> -    aml_append(crs, aml_memory32_fixed(base_ecam, size_ecam, AML_READ_WRITE));
> +    aml_append(crs,
> +        aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
> +                         AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000, base_ecam,
> +                         base_ecam + size_ecam - 1, 0x0000, size_ecam));
>      aml_append(dev_res0, aml_name_decl("_CRS", crs));
>      aml_append(dev, dev_res0);
>      aml_append(scope, dev);
> @@ -563,16 +567,17 @@ build_mcfg(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  {
>      AcpiTableMcfg *mcfg;
>      const MemMapEntry *memmap = vms->memmap;
> +    int ecam_id = vms->highmem_ecam ? VIRT_PCIE_ECAM_HIGH : VIRT_PCIE_ECAM;
>      int len = sizeof(*mcfg) + sizeof(mcfg->allocation[0]);
>      int mcfg_start = table_data->len;
>  
>      mcfg = acpi_data_push(table_data, len);
> -    mcfg->allocation[0].address = cpu_to_le64(memmap[VIRT_PCIE_ECAM].base);
> +    mcfg->allocation[0].address = cpu_to_le64(memmap[ecam_id].base);
>  
>      /* Only a single allocation so no need to play with segments */
>      mcfg->allocation[0].pci_segment = cpu_to_le16(0);
>      mcfg->allocation[0].start_bus_number = 0;
> -    mcfg->allocation[0].end_bus_number = (memmap[VIRT_PCIE_ECAM].size
> +    mcfg->allocation[0].end_bus_number = (memmap[ecam_id].size
>                                            / PCIE_MMCFG_SIZE_MIN) - 1;
>  
>      build_header(linker, table_data, (void *)(table_data->data + mcfg_start),
> @@ -747,7 +752,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
>                      (irqmap[VIRT_MMIO] + ARM_SPI_BASE), NUM_VIRTIO_TRANSPORTS);
>      acpi_dsdt_add_pci(scope, memmap, (irqmap[VIRT_PCIE] + ARM_SPI_BASE),
> -                      vms->highmem);
> +                      vms->highmem, vms->highmem_ecam);
>      acpi_dsdt_add_gpio(scope, &memmap[VIRT_GPIO],
>                         (irqmap[VIRT_GPIO] + ARM_SPI_BASE));
>      acpi_dsdt_add_power_button(scope);
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index a3a28e2..d4247d0 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -149,6 +149,7 @@ static const MemMapEntry a15memmap[] = {
>      [VIRT_PCIE_PIO] =           { 0x3eff0000, 0x00010000 },
>      [VIRT_PCIE_ECAM] =          { 0x3f000000, 0x01000000 },
>      [VIRT_MEM] =                { 0x40000000, RAMLIMIT_BYTES },
> +    [VIRT_PCIE_ECAM_HIGH] =     { 0x4010000000ULL, 0x10000000 },
>      /* Second PCIe window, 512GB wide at the 512GB boundary */
>      [VIRT_PCIE_MMIO_HIGH] =   { 0x8000000000ULL, 0x8000000000ULL },
>  };
> @@ -1001,10 +1002,9 @@ static void create_pcie(VirtMachineState *vms, qemu_irq *pic)
>      hwaddr size_mmio_high = vms->memmap[VIRT_PCIE_MMIO_HIGH].size;
>      hwaddr base_pio = vms->memmap[VIRT_PCIE_PIO].base;
>      hwaddr size_pio = vms->memmap[VIRT_PCIE_PIO].size;
> -    hwaddr base_ecam = vms->memmap[VIRT_PCIE_ECAM].base;
> -    hwaddr size_ecam = vms->memmap[VIRT_PCIE_ECAM].size;
> +    hwaddr base_ecam, size_ecam;
>      hwaddr base = base_mmio;
> -    int nr_pcie_buses = size_ecam / PCIE_MMCFG_SIZE_MIN;
> +    int nr_pcie_buses;
>      int irq = vms->irqmap[VIRT_PCIE];
>      MemoryRegion *mmio_alias;
>      MemoryRegion *mmio_reg;
> @@ -1012,12 +1012,16 @@ static void create_pcie(VirtMachineState *vms, qemu_irq *pic)
>      MemoryRegion *ecam_reg;
>      DeviceState *dev;
>      char *nodename;
> -    int i;
> +    int i, ecam_memmap_id;
>      PCIHostState *pci;
>  
>      dev = qdev_create(NULL, TYPE_GPEX_HOST);
>      qdev_init_nofail(dev);
>  
> +    ecam_memmap_id = vms->highmem_ecam ? VIRT_PCIE_ECAM_HIGH : VIRT_PCIE_ECAM;
> +    base_ecam = vms->memmap[ecam_memmap_id].base;
> +    size_ecam = vms->memmap[ecam_memmap_id].size;
> +    nr_pcie_buses = size_ecam / PCIE_MMCFG_SIZE_MIN;
>      /* Map only the first size_ecam bytes of ECAM space */
>      ecam_alias = g_new0(MemoryRegion, 1);
>      ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 4ac7ef6..e9423a7 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -69,6 +69,7 @@ enum {
>      VIRT_PCIE_MMIO,
>      VIRT_PCIE_PIO,
>      VIRT_PCIE_ECAM,
> +    VIRT_PCIE_ECAM_HIGH,
>      VIRT_PLATFORM_BUS,
>      VIRT_PCIE_MMIO_HIGH,
>      VIRT_GPIO,
> @@ -103,6 +104,7 @@ typedef struct {
>      FWCfgState *fw_cfg;
>      bool secure;
>      bool highmem;
> +    bool highmem_ecam;
>      bool its;
>      bool virt;
>      int32_t gic_version;
> 

At this point, the order (and values) of the VIRT_* enum constants look
mostly random :) , but I'm unaware of anything why that should be a problem.

I compared this against the RFC version; from my side:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Can you please do the following additionally:

- The aarch64 firmware packaged in Gerd's repo is built with the verbose
  log enabled, as far as I can see. Can you please capture two boot logs
  (from the serial console) until the guest kernel is reached, and send
  them to me (off-list if you prefer)? The first log should have the new
  feature disabled, the second one enabled; I'd like to compare them.

- (I think the same test is useful with the guest kernel dmesg as well,
  passing ignore_loglevel, but I don't think my assistance in reviewing
  that difference is necessary or helpful :) )

Thanks!
Laszlo
