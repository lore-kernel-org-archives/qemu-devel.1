Received: from eggs.gnu.org ([209.51.188.92]:38097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h1Dto-0001NZ-5R
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:30:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h1Dtn-0006gC-8V
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:30:40 -0500
References: <20190304194857.9780-1-philmd@redhat.com>
	<20190304194857.9780-4-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <265e566a-f2f5-5eb8-2839-781030bc479a@redhat.com>
Date: Tue, 5 Mar 2019 18:30:11 +0100
MIME-Version: 1.0
In-Reply-To: <20190304194857.9780-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] hw/i386/pc_sysfw: Let
 pc_system_firmware_init() access PCMachineState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On 03/04/19 20:48, Philippe Mathieu-Daud=C3=A9 wrote:
> PCMachineState will be used in the next patch.
> Since We can access PCMachineClass from it, directly use it.
> We can also access pcmc->pci_enabled, remove the isapc_ram_fw
> argument.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> [PMD: Extracted from bigger patch]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/i386/pc.c         | 2 +-
>  hw/i386/pc_sysfw.c   | 8 +++++---
>  include/hw/i386/pc.h | 3 +--
>  3 files changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 3889eccdc3..3cd8ed1794 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1830,7 +1830,7 @@ void pc_memory_init(PCMachineState *pcms,
>      }
> =20
>      /* Initialize PC system firmware */
> -    pc_system_firmware_init(rom_memory, !pcmc->pci_enabled);
> +    pc_system_firmware_init(pcms, rom_memory);
> =20
>      option_rom_mr =3D g_malloc(sizeof(*option_rom_mr));
>      memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index 46b87afe23..55a3c563df 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -231,15 +231,17 @@ static void old_pc_system_rom_init(MemoryRegion *=
rom_memory, bool isapc_ram_fw)
>                                  bios);
>  }
> =20
> -void pc_system_firmware_init(MemoryRegion *rom_memory, bool isapc_ram_=
fw)
> +void pc_system_firmware_init(PCMachineState *pcms,
> +                             MemoryRegion *rom_memory)
>  {
> +    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
>      DriveInfo *pflash_drv;
> =20
>      pflash_drv =3D drive_get(IF_PFLASH, 0, 0);
> =20
> -    if (isapc_ram_fw || pflash_drv =3D=3D NULL) {
> +    if (!pcmc->pci_enabled || pflash_drv =3D=3D NULL) {
>          /* When a pflash drive is not found, use rom-mode */
> -        old_pc_system_rom_init(rom_memory, isapc_ram_fw);
> +        old_pc_system_rom_init(rom_memory, true);
>          return;
>      }
> =20

This code extraction (as a pure refactoring) is incorrect.

In Markus's patch at
<https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg06804.html>,
the condition that guards the old_pc_system_rom_init() call loses one
half of the disjunction:

-    if (isapc_ram_fw || pflash_drv =3D=3D NULL) {
+    if (!pcmc->pci_enabled) {

namely the "pflash_drv =3D=3D NULL" sub-condition. Therefore the
old_pc_system_rom_init() call can hardwire the second argument as "true":

-        old_pc_system_rom_init(rom_memory, isapc_ram_fw);
+        old_pc_system_rom_init(rom_memory, true);

However, in this refactoring, the (pflash_drv =3D=3D NULL) subcondition i=
s
not deleted; only the original condition is expressed differently.
Therefore we can't replace the "isapc_ram_fw" argument of
old_pc_system_rom_init() with plain "true", we have to use
"!pcmc->pci_enabled" instead.

However, if we write down "!pcmc->pci_enabled" twice for this purpose,
then it becomes too complex to read (for me anyway). So in that case I'd
even suggest keeping the "isapc_ram_fw" local variable, just turn it
into a normal local variable rather than take it as a parameter.

In the next patch, "isapc_ram_fw" can be killed just the same.

Thanks
Laszlo

> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 3ff127ebd0..eb7360feac 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -278,8 +278,7 @@ extern PCIDevice *piix4_dev;
>  int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn);
> =20
>  /* pc_sysfw.c */
> -void pc_system_firmware_init(MemoryRegion *rom_memory,
> -                             bool isapc_ram_fw);
> +void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_m=
emory);
> =20
>  /* acpi-build.c */
>  void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
>=20
