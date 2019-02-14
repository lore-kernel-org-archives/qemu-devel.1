Received: from eggs.gnu.org ([209.51.188.92]:55687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1guKdg-0006ia-V1
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:17:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1guKcG-0008Rh-Tl
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:16:06 -0500
Received: from mail-eopbgr720114.outbound.protection.outlook.com
	([40.107.72.114]:19523
	helo=NAM05-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1guKc5-00085M-NH
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:15:59 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 14 Feb 2019 17:15:34 +0000
Message-ID: <BN6PR2201MB1251275AF7447D9252214C27C6670@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <cover.1549857716.git.balaton@eik.bme.hu>,
	<c86280648f23e89d6a864e4ab72912429c6277f2.1549857716.git.balaton@eik.bme.hu>
In-Reply-To: <c86280648f23e89d6a864e4ab72912429c6277f2.1549857716.git.balaton@eik.bme.hu>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 3/4] mips_fulong2e: Dynamically generate
 SPD EEPROM data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>, Huacai Chen <zltjiangshi@gmail.com>

> From: BALATON Zoltan <balaton@eik.bme.hu>
> Sent: Monday, February 11, 2019 5:01 AM
> To: qemu-devel@nongnu.org
> Cc: Aurelien Jarno; Aleksandar Markovic; Huacai Chen
> Subject: [PATCH 3/4] mips_fulong2e: Dynamically generate SPD EEPROM data
>=20
> The machine comes with 256M memory module by default but it's
> upgradable so it could have different memory size. There was a TODO
> comment to replace static SPD EEPROM data with dynamically generated
> one to support this. Now that we have a function for that, it's easy
> to do. Although this would allow larger RAM sizes, the peculiar memory
> map of the machine may need some special handling to map it as low and
> high memory. Because I don't know what the correct place would be for
> highmem, I've left memory size fixed at 256M for now and TODO is moved
> there instead.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/mips/mips_fulong2e.c | 31 +++++++++++++------------------
>  1 file changed, 13 insertions(+), 18 deletions(-)
>=20

Hello, Zoltan.

Thank you for your work in this area. I genarally support this series.
(When can we expect v2? I would like to integrate this series before
4.0 soft freeze planned for March 12th.)

However, I have just a couple of questions:

1. Is this series dependent on the patches outside of this series?
(meaning, the functionality won't work unless those other patches
are in the tree?)

2. Can you spell out the test procedure that you used, after this
series (and possibly other needed patches) is applied?

3. What exactly this series fixes, or improves?

Thanks again!

Aleksandar

> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index 10e6ed585a..eec6fd02c8 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -214,20 +214,6 @@ static void main_cpu_reset(void *opaque)
>      }
>  }
>=20
> -static const uint8_t eeprom_spd[0x80] =3D {
> -    0x80,0x08,0x07,0x0d,0x09,0x02,0x40,0x00,0x04,0x70,
> -    0x70,0x00,0x82,0x10,0x00,0x01,0x0e,0x04,0x0c,0x01,
> -    0x02,0x20,0x80,0x75,0x70,0x00,0x00,0x50,0x3c,0x50,
> -    0x2d,0x20,0xb0,0xb0,0x50,0x50,0x00,0x00,0x00,0x00,
> -    0x00,0x41,0x48,0x3c,0x32,0x75,0x00,0x00,0x00,0x00,
> -    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> -    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
> -    0x00,0x00,0x00,0x9c,0x7b,0x07,0x00,0x00,0x00,0x00,
> -    0x00,0x00,0x00,0x00,0x48,0x42,0x35,0x34,0x41,0x32,
> -    0x35,0x36,0x38,0x4b,0x4e,0x2d,0x41,0x37,0x35,0x42,
> -    0x20,0x30,0x20
> -};
> -
>  static void vt82c686b_southbridge_init(PCIBus *pci_bus, int slot, qemu_i=
rq intc,
>                                         I2CBus **i2c_bus, ISABus **p_isa_=
bus)
>  {
> @@ -284,7 +270,6 @@ static void network_init (PCIBus *pci_bus)
>=20
>  static void mips_fulong2e_init(MachineState *machine)
>  {
> -    ram_addr_t ram_size =3D machine->ram_size;
>      const char *kernel_filename =3D machine->kernel_filename;
>      const char *kernel_cmdline =3D machine->kernel_cmdline;
>      const char *initrd_filename =3D machine->initrd_filename;
> @@ -292,7 +277,10 @@ static void mips_fulong2e_init(MachineState *machine=
)
>      MemoryRegion *address_space_mem =3D get_system_memory();
>      MemoryRegion *ram =3D g_new(MemoryRegion, 1);
>      MemoryRegion *bios =3D g_new(MemoryRegion, 1);
> +    ram_addr_t ram_size =3D machine->ram_size;
>      long bios_size;
> +    uint8_t *spd_data;
> +    Error *err =3D NULL;
>      int64_t kernel_entry;
>      PCIBus *pci_bus;
>      ISABus *isa_bus;
> @@ -306,7 +294,7 @@ static void mips_fulong2e_init(MachineState *machine)
>=20
>      qemu_register_reset(main_cpu_reset, cpu);
>=20
> -    /* fulong 2e has 256M ram. */
> +    /* TODO: support more than 256M RAM as highmem */
>      ram_size =3D 256 * MiB;
>=20
>      /* allocate RAM */
> @@ -359,8 +347,14 @@ static void mips_fulong2e_init(MachineState *machine=
)
>      vt82c686b_southbridge_init(pci_bus, FULONG2E_VIA_SLOT, env->irq[5],
>                                 &smbus, &isa_bus);
>=20
> -    /* TODO: Populate SPD eeprom data.  */
> -    smbus_eeprom_init(smbus, 1, eeprom_spd, sizeof(eeprom_spd));
> +    /* Populate SPD eeprom data */
> +    spd_data =3D spd_data_generate(DDR, ram_size, &err);
> +    if (err) {
> +        warn_report_err(err);
> +    }
> +    if (spd_data) {
> +        smbus_eeprom_init_one(smbus, 0x50, spd_data);
> +    }
>=20
>      mc146818_rtc_init(isa_bus, 2000, NULL);
>=20
> @@ -374,6 +368,7 @@ static void mips_fulong2e_machine_init(MachineClass *=
mc)
>      mc->init =3D mips_fulong2e_init;
>      mc->block_default_type =3D IF_IDE;
>      mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("Loongson-2E");
> +    mc->default_ram_size =3D 256 * MiB;
>  }
>=20
>  DEFINE_MACHINE("fulong2e", mips_fulong2e_machine_init)
> --
> 2.13.7
>=20
