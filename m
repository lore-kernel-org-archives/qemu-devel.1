Received: from eggs.gnu.org ([2001:4830:134:3::10]:39321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1etBwC-0004ck-Lp
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:43:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1etBw9-0004s5-Hq
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:43:24 -0500
Date: Tue, 6 Mar 2018 13:43:10 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180306134310.70b631b4@redhat.com>
In-Reply-To: <20180305112732.26471-9-f4bug@amsat.org>
References: <20180305112732.26471-1-f4bug@amsat.org>
	<20180305112732.26471-9-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 08/30] hw/i386: use the BYTE-based
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: qemu-trivial@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Richard Henderson <rth@twiddle.net>

On Mon,  5 Mar 2018 08:27:10 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> It eases code review, unit is explicit.
>=20
> Patch generated using:
>=20
>   $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/h=
w/
>=20
> and modified manually.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
My apologies,
compilation errors were my mistake of not applying 1-2/30 patches first.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/i386/ich9.h     |  2 +-
>  hw/i386/acpi-build.c       |  4 ++--
>  hw/i386/pc.c               | 18 +++++++++---------
>  hw/i386/pc_piix.c          |  2 +-
>  hw/i386/pc_q35.c           |  2 +-
>  hw/i386/pc_sysfw.c         |  8 ++++----
>  hw/i386/xen/xen-mapcache.c |  2 +-
>  hw/intc/apic_common.c      |  2 +-
>  hw/pci-host/gpex.c         |  2 +-
>  hw/pci-host/piix.c         |  4 ++--
>  hw/pci-host/q35.c          | 16 ++++++++--------
>  11 files changed, 31 insertions(+), 31 deletions(-)
>=20
> diff --git a/include/hw/i386/ich9.h b/include/hw/i386/ich9.h
> index 673d13d28f..87628dd867 100644
> --- a/include/hw/i386/ich9.h
> +++ b/include/hw/i386/ich9.h
> @@ -22,7 +22,7 @@ I2CBus *ich9_smb_init(PCIBus *bus, int devfn, uint32_t =
smb_io_base);
> =20
>  void ich9_generate_smi(void);
> =20
> -#define ICH9_CC_SIZE (16 * 1024) /* 16KB. Chipset configuration register=
s */
> +#define ICH9_CC_SIZE (16 * K_BYTE) /* Chipset configuration registers */
> =20
>  #define TYPE_ICH9_LPC_DEVICE "ICH9-LPC"
>  #define ICH9_LPC_DEVICE(obj) \
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index deb440f286..9ccc6192b5 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2320,8 +2320,8 @@ build_tpm2(GArray *table_data, BIOSLinker *linker, =
GArray *tcpalog)
>                   (void *)tpm2_ptr, "TPM2", sizeof(*tpm2_ptr), 4, NULL, N=
ULL);
>  }
> =20
> -#define HOLE_640K_START  (640 * 1024)
> -#define HOLE_640K_END   (1024 * 1024)
> +#define HOLE_640K_START  (640 * K_BYTE)
> +#define HOLE_640K_END   (1024 * K_BYTE)
> =20
>  static void
>  build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 55e69d66fe..94a1f3bc7b 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -452,8 +452,8 @@ void pc_cmos_init(PCMachineState *pcms,
>      rtc_set_memory(s, 0x15, val);
>      rtc_set_memory(s, 0x16, val >> 8);
>      /* extended memory (next 64MiB) */
> -    if (pcms->below_4g_mem_size > 1024 * 1024) {
> -        val =3D (pcms->below_4g_mem_size - 1024 * 1024) / 1024;
> +    if (pcms->below_4g_mem_size > 1 * M_BYTE) {
> +        val =3D (pcms->below_4g_mem_size - 1 * M_BYTE) / 1024;
>      } else {
>          val =3D 0;
>      }
> @@ -464,8 +464,8 @@ void pc_cmos_init(PCMachineState *pcms,
>      rtc_set_memory(s, 0x30, val);
>      rtc_set_memory(s, 0x31, val >> 8);
>      /* memory between 16MiB and 4GiB */
> -    if (pcms->below_4g_mem_size > 16 * 1024 * 1024) {
> -        val =3D (pcms->below_4g_mem_size - 16 * 1024 * 1024) / 65536;
> +    if (pcms->below_4g_mem_size > 16 * M_BYTE) {
> +        val =3D (pcms->below_4g_mem_size - 16 * M_BYTE) / 65536;
>      } else {
>          val =3D 0;
>      }
> @@ -1390,11 +1390,11 @@ void pc_memory_init(PCMachineState *pcms,
>          }
> =20
>          pcms->hotplug_memory.base =3D
> -            ROUND_UP(0x100000000ULL + pcms->above_4g_mem_size, 1ULL << 3=
0);
> +            ROUND_UP(0x100000000ULL + pcms->above_4g_mem_size, G_BYTE);
> =20
>          if (pcmc->enforce_aligned_dimm) {
>              /* size hotplug region assuming 1G page max alignment per sl=
ot */
> -            hotplug_mem_size +=3D (1ULL << 30) * machine->ram_slots;
> +            hotplug_mem_size +=3D machine->ram_slots * G_BYTE;
>          }
> =20
>          if ((pcms->hotplug_memory.base + hotplug_mem_size) <
> @@ -1436,7 +1436,7 @@ void pc_memory_init(PCMachineState *pcms,
>          if (!pcmc->broken_reserved_end) {
>              res_mem_end +=3D memory_region_size(&pcms->hotplug_memory.mr=
);
>          }
> -        *val =3D cpu_to_le64(ROUND_UP(res_mem_end, 0x1ULL << 30));
> +        *val =3D cpu_to_le64(ROUND_UP(res_mem_end, G_BYTE));
>          fw_cfg_add_file(fw_cfg, "etc/reserved-memory-end", val, sizeof(*=
val));
>      }
> =20
> @@ -1472,7 +1472,7 @@ uint64_t pc_pci_hole64_start(void)
>          hole64_start =3D 0x100000000ULL + pcms->above_4g_mem_size;
>      }
> =20
> -    return ROUND_UP(hole64_start, 1ULL << 30);
> +    return ROUND_UP(hole64_start, G_BYTE);
>  }
> =20
>  qemu_irq pc_allocate_cpu_irq(void)
> @@ -2114,7 +2114,7 @@ static void pc_machine_set_max_ram_below_4g(Object =
*obj, Visitor *v,
>          return;
>      }
> =20
> -    if (value < (1ULL << 20)) {
> +    if (value < 1 * M_BYTE) {
>          warn_report("Only %" PRIu64 " bytes of RAM below the 4GiB bounda=
ry,"
>                      "BIOS may not work with less than 1MiB", value);
>      }
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 456dc9e9f0..975dfc848e 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -131,7 +131,7 @@ static void pc_init1(MachineState *machine,
>                  if (lowmem > 0xc0000000) {
>                      lowmem =3D 0xc0000000;
>                  }
> -                if (lowmem & ((1ULL << 30) - 1)) {
> +                if (lowmem & ((1 * G_BYTE) - 1)) {
>                      warn_report("Large machine and max_ram_below_4g "
>                                  "(%" PRIu64 ") not a multiple of 1G; "
>                                  "possible bad performance.",
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index aba7541a82..79b84bc559 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -104,7 +104,7 @@ static void pc_q35_init(MachineState *machine)
>      if (lowmem > pcms->max_ram_below_4g) {
>          lowmem =3D pcms->max_ram_below_4g;
>          if (machine->ram_size - lowmem > lowmem &&
> -            lowmem & ((1ULL << 30) - 1)) {
> +            lowmem & ((1 * G_BYTE) - 1)) {
>              warn_report("There is possibly poor performance as the ram s=
ize "
>                          " (0x%" PRIx64 ") is more then twice the size of"
>                          " max-ram-below-4g (%"PRIu64") and"
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index 4325575e7d..97488a832d 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -56,7 +56,7 @@ static void pc_isa_bios_init(MemoryRegion *rom_memory,
>      flash_size =3D memory_region_size(flash_mem);
> =20
>      /* map the last 128KB of the BIOS in ISA space */
> -    isa_bios_size =3D MIN(flash_size, 128 * 1024);
> +    isa_bios_size =3D MIN(flash_size, 128 * K_BYTE);
>      isa_bios =3D g_malloc(sizeof(*isa_bios));
>      memory_region_init_ram(isa_bios, NULL, "isa-bios", isa_bios_size,
>                             &error_fatal);
> @@ -83,7 +83,7 @@ static void pc_isa_bios_init(MemoryRegion *rom_memory,
>   * only 18MB-4KB below 4G. For now, restrict the cumulative mapping to 8=
MB in
>   * size.
>   */
> -#define FLASH_MAP_BASE_MIN ((hwaddr)(0x100000000ULL - 8*1024*1024))
> +#define FLASH_MAP_BASE_MIN ((hwaddr)(0x100000000ULL - 8 * M_BYTE))
> =20
>  /* This function maps flash drives from 4G downward, in order of their u=
nit
>   * numbers. The mapping starts at unit#0, with unit number increments of=
 1, and
> @@ -209,8 +209,8 @@ static void old_pc_system_rom_init(MemoryRegion *rom_=
memory, bool isapc_ram_fw)
> =20
>      /* map the last 128KB of the BIOS in ISA space */
>      isa_bios_size =3D bios_size;
> -    if (isa_bios_size > (128 * 1024)) {
> -        isa_bios_size =3D 128 * 1024;
> +    if (isa_bios_size > 128 * K_BYTE) {
> +        isa_bios_size =3D 128 * K_BYTE;
>      }
>      isa_bios =3D g_malloc(sizeof(*isa_bios));
>      memory_region_init_alias(isa_bios, NULL, "isa-bios", bios,
> diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
> index efa35dc6e0..5f48fde799 100644
> --- a/hw/i386/xen/xen-mapcache.c
> +++ b/hw/i386/xen/xen-mapcache.c
> @@ -47,7 +47,7 @@
>   * From empirical tests I observed that qemu use 75MB more than the
>   * max_mcache_size.
>   */
> -#define NON_MCACHE_MEMORY_SIZE (80 * 1024 * 1024)
> +#define NON_MCACHE_MEMORY_SIZE (80 * M_BYTE)
> =20
>  typedef struct MapCacheEntry {
>      hwaddr paddr_index;
> diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
> index 78903ea909..3a6c297c52 100644
> --- a/hw/intc/apic_common.c
> +++ b/hw/intc/apic_common.c
> @@ -319,7 +319,7 @@ static void apic_common_realize(DeviceState *dev, Err=
or **errp)
> =20
>      /* Note: We need at least 1M to map the VAPIC option ROM */
>      if (!vapic && s->vapic_control & VAPIC_ENABLE_MASK &&
> -        !hax_enabled() && ram_size >=3D 1024 * 1024) {
> +        !hax_enabled() && ram_size >=3D 1 * M_BYTE) {
>          vapic =3D sysbus_create_simple("kvmvapic", -1, NULL);
>      }
>      s->vapic =3D vapic;
> diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
> index 2583b151a4..9cab9d0e7d 100644
> --- a/hw/pci-host/gpex.c
> +++ b/hw/pci-host/gpex.c
> @@ -79,7 +79,7 @@ static void gpex_host_realize(DeviceState *dev, Error *=
*errp)
> =20
>      pcie_host_mmcfg_init(pex, PCIE_MMCFG_SIZE_MAX);
>      memory_region_init(&s->io_mmio, OBJECT(s), "gpex_mmio", UINT64_MAX);
> -    memory_region_init(&s->io_ioport, OBJECT(s), "gpex_ioport", 64 * 102=
4);
> +    memory_region_init(&s->io_ioport, OBJECT(s), "gpex_ioport", 64 * K_B=
YTE);
> =20
>      sysbus_init_mmio(sbd, &pex->mmio);
>      sysbus_init_mmio(sbd, &s->io_mmio);
> diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
> index 0e608347c1..7fc1822ec0 100644
> --- a/hw/pci-host/piix.c
> +++ b/hw/pci-host/piix.c
> @@ -284,7 +284,7 @@ static void i440fx_pcihost_get_pci_hole64_end(Object =
*obj, Visitor *v,
> =20
>      pci_bus_get_w64_range(h->bus, &w64);
>      value =3D range_is_empty(&w64) ? 0 : range_upb(&w64) + 1;
> -    hole64_end =3D ROUND_UP(hole64_start + s->pci_hole64_size, 1ULL << 3=
0);
> +    hole64_end =3D ROUND_UP(hole64_start + s->pci_hole64_size, G_BYTE);
>      if (s->pci_hole64_fix && value < hole64_end) {
>          value =3D hole64_end;
>      }
> @@ -430,7 +430,7 @@ PCIBus *i440fx_init(const char *host_type, const char=
 *pci_type,
> =20
>      *piix3_devfn =3D piix3->dev.devfn;
> =20
> -    ram_size =3D ram_size / 8 / 1024 / 1024;
> +    ram_size /=3D 8 * M_BYTE;
>      if (ram_size > 255) {
>          ram_size =3D 255;
>      }
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index a36a1195e4..a54b6736e5 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -144,7 +144,7 @@ static void q35_host_get_pci_hole64_end(Object *obj, =
Visitor *v,
> =20
>      pci_bus_get_w64_range(h->bus, &w64);
>      value =3D range_is_empty(&w64) ? 0 : range_upb(&w64) + 1;
> -    hole64_end =3D ROUND_UP(hole64_start + s->mch.pci_hole64_size, 1ULL =
<< 30);
> +    hole64_end =3D ROUND_UP(hole64_start + s->mch.pci_hole64_size, G_BYT=
E);
>      if (s->pci_hole64_fix && value < hole64_end) {
>          value =3D hole64_end;
>      }
> @@ -310,15 +310,15 @@ static void mch_update_pciexbar(MCHPCIState *mch)
>      addr_mask =3D MCH_HOST_BRIDGE_PCIEXBAR_ADMSK;
>      switch (pciexbar & MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_MASK) {
>      case MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_256M:
> -        length =3D 256 * 1024 * 1024;
> +        length =3D 256 * M_BYTE;
>          break;
>      case MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_128M:
> -        length =3D 128 * 1024 * 1024;
> +        length =3D 128 * M_BYTE;
>          addr_mask |=3D MCH_HOST_BRIDGE_PCIEXBAR_128ADMSK |
>              MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK;
>          break;
>      case MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_64M:
> -        length =3D 64 * 1024 * 1024;
> +        length =3D 64 * M_BYTE;
>          addr_mask |=3D MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK;
>          break;
>      case MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_RVD:
> @@ -396,16 +396,16 @@ static void mch_update_smram(MCHPCIState *mch)
>          switch (pd->config[MCH_HOST_BRIDGE_ESMRAMC] &
>                  MCH_HOST_BRIDGE_ESMRAMC_TSEG_SZ_MASK) {
>          case MCH_HOST_BRIDGE_ESMRAMC_TSEG_SZ_1MB:
> -            tseg_size =3D 1024 * 1024;
> +            tseg_size =3D 1 * M_BYTE;
>              break;
>          case MCH_HOST_BRIDGE_ESMRAMC_TSEG_SZ_2MB:
> -            tseg_size =3D 1024 * 1024 * 2;
> +            tseg_size =3D 2 * M_BYTE;
>              break;
>          case MCH_HOST_BRIDGE_ESMRAMC_TSEG_SZ_8MB:
> -            tseg_size =3D 1024 * 1024 * 8;
> +            tseg_size =3D 8 * M_BYTE;
>              break;
>          default:
> -            tseg_size =3D 1024 * 1024 * (uint32_t)mch->ext_tseg_mbytes;
> +            tseg_size =3D (uint32_t)mch->ext_tseg_mbytes * M_BYTE;
>              break;
>          }
>      } else {
