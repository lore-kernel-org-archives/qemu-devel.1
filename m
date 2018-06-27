Received: from eggs.gnu.org ([2001:4830:134:3::10]:38595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fYB0z-0003cZ-Mf
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fYB0u-0000xz-LG
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:01:45 -0400
Date: Wed, 27 Jun 2018 16:01:35 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180627160135.7799d7a1@redhat.com>
In-Reply-To: <20180625124238.25339-34-f4bug@amsat.org>
References: <20180625124238.25339-1-f4bug@amsat.org>
	<20180625124238.25339-34-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 33/46] hw/i386: Use the IEC binary
 prefix definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On Mon, 25 Jun 2018 09:42:25 -0300
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
> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

non important nit below

> ---
>  include/hw/i386/ich9.h |  3 ++-
>  hw/i386/acpi-build.c   |  5 +++--
>  hw/i386/pc.c           | 19 ++++++++++---------
>  hw/i386/pc_piix.c      |  4 ++--
>  hw/i386/pc_q35.c       |  3 ++-
>  hw/i386/pc_sysfw.c     |  9 +++++----
>  hw/intc/apic_common.c  |  3 ++-
>  hw/pci-host/piix.c     |  5 +++--
>  hw/pci-host/q35.c      | 17 +++++++++--------
>  9 files changed, 38 insertions(+), 30 deletions(-)
>=20
> diff --git a/include/hw/i386/ich9.h b/include/hw/i386/ich9.h
> index 673d13d28f..3f0b80f0da 100644
> --- a/include/hw/i386/ich9.h
> +++ b/include/hw/i386/ich9.h
> @@ -1,6 +1,7 @@
>  #ifndef HW_ICH9_H
>  #define HW_ICH9_H
> =20
> +#include "qemu/units.h"
>  #include "hw/hw.h"
>  #include "hw/isa/isa.h"
>  #include "hw/sysbus.h"
> @@ -22,7 +23,7 @@ I2CBus *ich9_smb_init(PCIBus *bus, int devfn, uint32_t =
smb_io_base);
> =20
>  void ich9_generate_smi(void);
> =20
> -#define ICH9_CC_SIZE (16 * 1024) /* 16KB. Chipset configuration register=
s */
> +#define ICH9_CC_SIZE (16 * KiB) /* Chipset configuration registers */
> =20
>  #define TYPE_ICH9_LPC_DEVICE "ICH9-LPC"
>  #define ICH9_LPC_DEVICE(obj) \
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 9bc6d97ea1..05fed5af44 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -21,6 +21,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "qapi/error.h"
>  #include "qapi/qmp/qnum.h"
>  #include "acpi-build.h"
> @@ -2248,8 +2249,8 @@ build_tpm2(GArray *table_data, BIOSLinker *linker, =
GArray *tcpalog)
>                   (void *)tpm2_ptr, "TPM2", sizeof(*tpm2_ptr), 4, NULL, N=
ULL);
>  }
> =20
> -#define HOLE_640K_START  (640 * 1024)
> -#define HOLE_640K_END   (1024 * 1024)
> +#define HOLE_640K_START  (640 * KiB)
> +#define HOLE_640K_END   (1024 * KiB)
> =20
>  static void build_srat_hotpluggable_memory(GArray *table_data, uint64_t =
base,
>                                             uint64_t len, int default_nod=
e)
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 622e49d6bc..41c434d7e3 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -23,6 +23,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "hw/hw.h"
>  #include "hw/i386/pc.h"
>  #include "hw/char/serial.h"
> @@ -452,8 +453,8 @@ void pc_cmos_init(PCMachineState *pcms,
>      rtc_set_memory(s, 0x15, val);
>      rtc_set_memory(s, 0x16, val >> 8);
>      /* extended memory (next 64MiB) */
> -    if (pcms->below_4g_mem_size > 1024 * 1024) {
> -        val =3D (pcms->below_4g_mem_size - 1024 * 1024) / 1024;
> +    if (pcms->below_4g_mem_size > 1 * MiB) {
> +        val =3D (pcms->below_4g_mem_size - 1 * MiB) / 1024;
could be:
   val =3D (pcms->below_4g_mem_size - 1 * MiB) / KiB

>      } else {
>          val =3D 0;
>      }
> @@ -464,8 +465,8 @@ void pc_cmos_init(PCMachineState *pcms,
>      rtc_set_memory(s, 0x30, val);
>      rtc_set_memory(s, 0x31, val >> 8);
>      /* memory between 16MiB and 4GiB */
> -    if (pcms->below_4g_mem_size > 16 * 1024 * 1024) {
> -        val =3D (pcms->below_4g_mem_size - 16 * 1024 * 1024) / 65536;
> +    if (pcms->below_4g_mem_size > 16 * MiB) {
> +        val =3D (pcms->below_4g_mem_size - 16 * MiB) / 65536;
>      } else {
>          val =3D 0;
>      }
> @@ -1392,11 +1393,11 @@ void pc_memory_init(PCMachineState *pcms,
>          }
> =20
>          machine->device_memory->base =3D
> -            ROUND_UP(0x100000000ULL + pcms->above_4g_mem_size, 1ULL << 3=
0);
> +            ROUND_UP(0x100000000ULL + pcms->above_4g_mem_size, GiB);
> =20
>          if (pcmc->enforce_aligned_dimm) {
>              /* size device region assuming 1G page max alignment per slo=
t */
> -            device_mem_size +=3D (1ULL << 30) * machine->ram_slots;
> +            device_mem_size +=3D machine->ram_slots * GiB;
>          }
> =20
>          if ((machine->device_memory->base + device_mem_size) <
> @@ -1438,7 +1439,7 @@ void pc_memory_init(PCMachineState *pcms,
>          if (!pcmc->broken_reserved_end) {
>              res_mem_end +=3D memory_region_size(&machine->device_memory-=
>mr);
>          }
> -        *val =3D cpu_to_le64(ROUND_UP(res_mem_end, 0x1ULL << 30));
> +        *val =3D cpu_to_le64(ROUND_UP(res_mem_end, GiB));
>          fw_cfg_add_file(fw_cfg, "etc/reserved-memory-end", val, sizeof(*=
val));
>      }
> =20
> @@ -1475,7 +1476,7 @@ uint64_t pc_pci_hole64_start(void)
>          hole64_start =3D 0x100000000ULL + pcms->above_4g_mem_size;
>      }
> =20
> -    return ROUND_UP(hole64_start, 1ULL << 30);
> +    return ROUND_UP(hole64_start, 1 * GiB);
>  }
> =20
>  qemu_irq pc_allocate_cpu_irq(void)
> @@ -2100,7 +2101,7 @@ static void pc_machine_set_max_ram_below_4g(Object =
*obj, Visitor *v,
>          return;
>      }
> =20
> -    if (value < (1ULL << 20)) {
> +    if (value < 1 * MiB) {
>          warn_report("Only %" PRIu64 " bytes of RAM below the 4GiB bounda=
ry,"
>                      "BIOS may not work with less than 1MiB", value);
>      }
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index e9b6f064fb..fd740bbc9c 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -23,7 +23,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> -
> +#include "qemu/units.h"
>  #include "hw/hw.h"
>  #include "hw/loader.h"
>  #include "hw/i386/pc.h"
> @@ -131,7 +131,7 @@ static void pc_init1(MachineState *machine,
>                  if (lowmem > 0xc0000000) {
>                      lowmem =3D 0xc0000000;
>                  }
> -                if (lowmem & ((1ULL << 30) - 1)) {
> +                if (lowmem & (1 * GiB - 1)) {
>                      warn_report("Large machine and max_ram_below_4g "
>                                  "(%" PRIu64 ") not a multiple of 1G; "
>                                  "possible bad performance.",
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 1a73e1848a..532241e3f8 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -29,6 +29,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "hw/hw.h"
>  #include "hw/loader.h"
>  #include "sysemu/arch_init.h"
> @@ -105,7 +106,7 @@ static void pc_q35_init(MachineState *machine)
>      if (lowmem > pcms->max_ram_below_4g) {
>          lowmem =3D pcms->max_ram_below_4g;
>          if (machine->ram_size - lowmem > lowmem &&
> -            lowmem & ((1ULL << 30) - 1)) {
> +            lowmem & (1 * GiB - 1)) {
>              warn_report("There is possibly poor performance as the ram s=
ize "
>                          " (0x%" PRIx64 ") is more then twice the size of"
>                          " max-ram-below-4g (%"PRIu64") and"
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index 73ac783f20..a9e2a72736 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -24,6 +24,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "qapi/error.h"
>  #include "sysemu/block-backend.h"
>  #include "qemu/error-report.h"
> @@ -56,7 +57,7 @@ static void pc_isa_bios_init(MemoryRegion *rom_memory,
>      flash_size =3D memory_region_size(flash_mem);
> =20
>      /* map the last 128KB of the BIOS in ISA space */
> -    isa_bios_size =3D MIN(flash_size, 128 * 1024);
> +    isa_bios_size =3D MIN(flash_size, 128 * KiB);
>      isa_bios =3D g_malloc(sizeof(*isa_bios));
>      memory_region_init_ram(isa_bios, NULL, "isa-bios", isa_bios_size,
>                             &error_fatal);
> @@ -83,7 +84,7 @@ static void pc_isa_bios_init(MemoryRegion *rom_memory,
>   * only 18MB-4KB below 4G. For now, restrict the cumulative mapping to 8=
MB in
>   * size.
>   */
> -#define FLASH_MAP_BASE_MIN ((hwaddr)(0x100000000ULL - 8*1024*1024))
> +#define FLASH_MAP_BASE_MIN ((hwaddr)(0x100000000ULL - 8 * MiB))
> =20
>  /* This function maps flash drives from 4G downward, in order of their u=
nit
>   * numbers. The mapping starts at unit#0, with unit number increments of=
 1, and
> @@ -222,8 +223,8 @@ static void old_pc_system_rom_init(MemoryRegion *rom_=
memory, bool isapc_ram_fw)
> =20
>      /* map the last 128KB of the BIOS in ISA space */
>      isa_bios_size =3D bios_size;
> -    if (isa_bios_size > (128 * 1024)) {
> -        isa_bios_size =3D 128 * 1024;
> +    if (isa_bios_size > 128 * KiB) {
> +        isa_bios_size =3D 128 * KiB;
>      }
>      isa_bios =3D g_malloc(sizeof(*isa_bios));
>      memory_region_init_alias(isa_bios, NULL, "isa-bios", bios,
> diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
> index 78903ea909..75fa49cbc3 100644
> --- a/hw/intc/apic_common.c
> +++ b/hw/intc/apic_common.c
> @@ -18,6 +18,7 @@
>   * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "qemu-common.h"
> @@ -319,7 +320,7 @@ static void apic_common_realize(DeviceState *dev, Err=
or **errp)
> =20
>      /* Note: We need at least 1M to map the VAPIC option ROM */
>      if (!vapic && s->vapic_control & VAPIC_ENABLE_MASK &&
> -        !hax_enabled() && ram_size >=3D 1024 * 1024) {
> +        !hax_enabled() && ram_size >=3D 1 * MiB) {
>          vapic =3D sysbus_create_simple("kvmvapic", -1, NULL);
>      }
>      s->vapic =3D vapic;
> diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
> index 0e608347c1..391dd6c9b8 100644
> --- a/hw/pci-host/piix.c
> +++ b/hw/pci-host/piix.c
> @@ -23,6 +23,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "hw/hw.h"
>  #include "hw/i386/pc.h"
>  #include "hw/pci/pci.h"
> @@ -284,7 +285,7 @@ static void i440fx_pcihost_get_pci_hole64_end(Object =
*obj, Visitor *v,
> =20
>      pci_bus_get_w64_range(h->bus, &w64);
>      value =3D range_is_empty(&w64) ? 0 : range_upb(&w64) + 1;
> -    hole64_end =3D ROUND_UP(hole64_start + s->pci_hole64_size, 1ULL << 3=
0);
> +    hole64_end =3D ROUND_UP(hole64_start + s->pci_hole64_size, 1 * GiB);
>      if (s->pci_hole64_fix && value < hole64_end) {
>          value =3D hole64_end;
>      }
> @@ -430,7 +431,7 @@ PCIBus *i440fx_init(const char *host_type, const char=
 *pci_type,
> =20
>      *piix3_devfn =3D piix3->dev.devfn;
> =20
> -    ram_size =3D ram_size / 8 / 1024 / 1024;
> +    ram_size /=3D 8 * MiB;
>      if (ram_size > 255) {
>          ram_size =3D 255;
>      }
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index 02f9576588..fbc255ca39 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -28,6 +28,7 @@
>   * THE SOFTWARE.
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "hw/hw.h"
>  #include "hw/pci-host/q35.h"
>  #include "qapi/error.h"
> @@ -144,7 +145,7 @@ static void q35_host_get_pci_hole64_end(Object *obj, =
Visitor *v,
> =20
>      pci_bus_get_w64_range(h->bus, &w64);
>      value =3D range_is_empty(&w64) ? 0 : range_upb(&w64) + 1;
> -    hole64_end =3D ROUND_UP(hole64_start + s->mch.pci_hole64_size, 1ULL =
<< 30);
> +    hole64_end =3D ROUND_UP(hole64_start + s->mch.pci_hole64_size, 1 * G=
iB);
>      if (s->pci_hole64_fix && value < hole64_end) {
>          value =3D hole64_end;
>      }
> @@ -310,15 +311,15 @@ static void mch_update_pciexbar(MCHPCIState *mch)
>      addr_mask =3D MCH_HOST_BRIDGE_PCIEXBAR_ADMSK;
>      switch (pciexbar & MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_MASK) {
>      case MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_256M:
> -        length =3D 256 * 1024 * 1024;
> +        length =3D 256 * MiB;
>          break;
>      case MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_128M:
> -        length =3D 128 * 1024 * 1024;
> +        length =3D 128 * MiB;
>          addr_mask |=3D MCH_HOST_BRIDGE_PCIEXBAR_128ADMSK |
>              MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK;
>          break;
>      case MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_64M:
> -        length =3D 64 * 1024 * 1024;
> +        length =3D 64 * MiB;
>          addr_mask |=3D MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK;
>          break;
>      case MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_RVD:
> @@ -396,16 +397,16 @@ static void mch_update_smram(MCHPCIState *mch)
>          switch (pd->config[MCH_HOST_BRIDGE_ESMRAMC] &
>                  MCH_HOST_BRIDGE_ESMRAMC_TSEG_SZ_MASK) {
>          case MCH_HOST_BRIDGE_ESMRAMC_TSEG_SZ_1MB:
> -            tseg_size =3D 1024 * 1024;
> +            tseg_size =3D 1 * MiB;
>              break;
>          case MCH_HOST_BRIDGE_ESMRAMC_TSEG_SZ_2MB:
> -            tseg_size =3D 1024 * 1024 * 2;
> +            tseg_size =3D 2 * MiB;
>              break;
>          case MCH_HOST_BRIDGE_ESMRAMC_TSEG_SZ_8MB:
> -            tseg_size =3D 1024 * 1024 * 8;
> +            tseg_size =3D 8 * MiB;
>              break;
>          default:
> -            tseg_size =3D 1024 * 1024 * (uint32_t)mch->ext_tseg_mbytes;
> +            tseg_size =3D (uint32_t)mch->ext_tseg_mbytes * MiB;
>              break;
>          }
>      } else {
