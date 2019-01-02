Received: from eggs.gnu.org ([208.118.235.92]:57754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geYK2-0001iD-ON
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 23:40:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geYK1-0007oF-5m
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 23:40:02 -0500
Date: Wed, 2 Jan 2019 15:11:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190102041133.GM27457@umbus.fritz.box>
References: <cover.1546394798.git.balaton@eik.bme.hu>
	<2403f70ea0cda1ba4e6345eb89a5aa5f3fe6e264.1546394798.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dzI2QqkSBOAresgT"
Content-Disposition: inline
In-Reply-To: <2403f70ea0cda1ba4e6345eb89a5aa5f3fe6e264.1546394798.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH 2/8] sam460ex: Clean up SPD EEPROM creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--dzI2QqkSBOAresgT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 03:06:38AM +0100, BALATON Zoltan wrote:
> Get rid of code from MIPS Malta board used to create SPD EEPROM data
> (parts of which was not even needed for sam460ex) and use the generic
> spd_data_generate() function to simplify this.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/ppc/sam460ex.c | 169 ++++++------------------------------------------=
------
>  1 file changed, 16 insertions(+), 153 deletions(-)
>=20
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 4b051c0950..2bb91ed21b 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -2,7 +2,7 @@
>   * QEMU aCube Sam460ex board emulation
>   *
>   * Copyright (c) 2012 Fran=E7ois Revol
> - * Copyright (c) 2016-2018 BALATON Zoltan
> + * Copyright (c) 2016-2019 BALATON Zoltan
>   *
>   * This file is derived from hw/ppc440_bamboo.c,
>   * the copyright for that material belongs to the original owners.
> @@ -87,135 +87,6 @@ struct boot_info {
>      uint32_t entry;
>  };
> =20
> -/***********************************************************************=
******/
> -/* SPD eeprom content from mips_malta.c */
> -
> -struct _eeprom24c0x_t {
> -  uint8_t tick;
> -  uint8_t address;
> -  uint8_t command;
> -  uint8_t ack;
> -  uint8_t scl;
> -  uint8_t sda;
> -  uint8_t data;
> -  uint8_t contents[256];
> -};
> -
> -typedef struct _eeprom24c0x_t eeprom24c0x_t;
> -
> -static eeprom24c0x_t spd_eeprom =3D {
> -    .contents =3D {
> -        /* 00000000: */ 0x80, 0x08, 0xFF, 0x0D, 0x0A, 0xFF, 0x40, 0x00,
> -        /* 00000008: */ 0x04, 0x75, 0x54, 0x00, 0x82, 0x08, 0x00, 0x01,
> -        /* 00000010: */ 0x8F, 0x04, 0x02, 0x01, 0x01, 0x00, 0x00, 0x00,
> -        /* 00000018: */ 0x00, 0x00, 0x00, 0x14, 0x0F, 0x14, 0x2D, 0xFF,
> -        /* 00000020: */ 0x15, 0x08, 0x15, 0x08, 0x00, 0x00, 0x00, 0x00,
> -        /* 00000028: */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -        /* 00000030: */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -        /* 00000038: */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x12, 0xD0,
> -        /* 00000040: */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -        /* 00000048: */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -        /* 00000050: */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -        /* 00000058: */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -        /* 00000060: */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -        /* 00000068: */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -        /* 00000070: */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -        /* 00000078: */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x64, 0xF4,
> -    },
> -};
> -
> -static void generate_eeprom_spd(uint8_t *eeprom, ram_addr_t ram_size)
> -{
> -    enum { SDR =3D 0x4, DDR1 =3D 0x7, DDR2 =3D 0x8 } type;
> -    uint8_t *spd =3D spd_eeprom.contents;
> -    uint8_t nbanks =3D 0;
> -    uint16_t density =3D 0;
> -    int i;
> -
> -    /* work in terms of MB */
> -    ram_size /=3D MiB;
> -
> -    while ((ram_size >=3D 4) && (nbanks <=3D 2)) {
> -        int sz_log2 =3D MIN(31 - clz32(ram_size), 14);
> -        nbanks++;
> -        density |=3D 1 << (sz_log2 - 2);
> -        ram_size -=3D 1 << sz_log2;
> -    }
> -
> -    /* split to 2 banks if possible */
> -    if ((nbanks =3D=3D 1) && (density > 1)) {
> -        nbanks++;
> -        density >>=3D 1;
> -    }
> -
> -    if (density & 0xff00) {
> -        density =3D (density & 0xe0) | ((density >> 8) & 0x1f);
> -        type =3D DDR2;
> -    } else if (!(density & 0x1f)) {
> -        type =3D DDR2;
> -    } else {
> -        type =3D SDR;
> -    }
> -
> -    if (ram_size) {
> -        warn_report("SPD cannot represent final " RAM_ADDR_FMT "MB"
> -                    " of SDRAM", ram_size);
> -    }
> -
> -    /* fill in SPD memory information */
> -    spd[2] =3D type;
> -    spd[5] =3D nbanks;
> -    spd[31] =3D density;
> -
> -    /* XXX: this is totally random */
> -    spd[9] =3D 0x10; /* CAS tcyc */
> -    spd[18] =3D 0x20; /* CAS bit */
> -    spd[23] =3D 0x10; /* CAS tcyc */
> -    spd[25] =3D 0x10; /* CAS tcyc */
> -
> -    /* checksum */
> -    spd[63] =3D 0;
> -    for (i =3D 0; i < 63; i++) {
> -        spd[63] +=3D spd[i];
> -    }
> -
> -    /* copy for SMBUS */
> -    memcpy(eeprom, spd, sizeof(spd_eeprom.contents));
> -}
> -
> -static void generate_eeprom_serial(uint8_t *eeprom)
> -{
> -    int i, pos =3D 0;
> -    uint8_t mac[6] =3D { 0x00 };
> -    uint8_t sn[5] =3D { 0x01, 0x23, 0x45, 0x67, 0x89 };
> -
> -    /* version */
> -    eeprom[pos++] =3D 0x01;
> -
> -    /* count */
> -    eeprom[pos++] =3D 0x02;
> -
> -    /* MAC address */
> -    eeprom[pos++] =3D 0x01; /* MAC */
> -    eeprom[pos++] =3D 0x06; /* length */
> -    memcpy(&eeprom[pos], mac, sizeof(mac));
> -    pos +=3D sizeof(mac);
> -
> -    /* serial number */
> -    eeprom[pos++] =3D 0x02; /* serial */
> -    eeprom[pos++] =3D 0x05; /* length */
> -    memcpy(&eeprom[pos], sn, sizeof(sn));
> -    pos +=3D sizeof(sn);
> -
> -    /* checksum */
> -    eeprom[pos] =3D 0;
> -    for (i =3D 0; i < pos; i++) {
> -        eeprom[pos] +=3D eeprom[i];
> -    }
> -}
> -
> -/***********************************************************************=
******/
> -
>  static int sam460ex_load_uboot(void)
>  {
>      DriveInfo *dinfo;
> @@ -393,24 +264,22 @@ static void sam460ex_init(MachineState *machine)
>      MemoryRegion *address_space_mem =3D get_system_memory();
>      MemoryRegion *isa =3D g_new(MemoryRegion, 1);
>      MemoryRegion *ram_memories =3D g_new(MemoryRegion, SDRAM_NR_BANKS);
> -    hwaddr ram_bases[SDRAM_NR_BANKS];
> -    hwaddr ram_sizes[SDRAM_NR_BANKS];
> +    hwaddr ram_bases[SDRAM_NR_BANKS] =3D {0};
> +    hwaddr ram_sizes[SDRAM_NR_BANKS] =3D {0};
>      MemoryRegion *l2cache_ram =3D g_new(MemoryRegion, 1);
>      qemu_irq *irqs, *uic[4];
>      PCIBus *pci_bus;
>      PowerPCCPU *cpu;
>      CPUPPCState *env;
> -    PPC4xxI2CState *i2c[2];
> +    I2CBus *i2c;
>      hwaddr entry =3D UBOOT_ENTRY;
>      hwaddr loadaddr =3D 0;
>      target_long initrd_size =3D 0;
>      DeviceState *dev;
>      SysBusDevice *sbdev;
> -    int success;
> -    int i;
>      struct boot_info *boot_info;
> -    const size_t smbus_eeprom_size =3D 8 * 256;
> -    uint8_t *smbus_eeprom_buf =3D g_malloc0(smbus_eeprom_size);
> +    uint8_t *spd_data;
> +    int success;
> =20
>      cpu =3D POWERPC_CPU(cpu_create(machine->cpu_type));
>      env =3D &cpu->env;
> @@ -439,8 +308,6 @@ static void sam460ex_init(MachineState *machine)
>      uic[3] =3D ppcuic_init(env, &uic[0][16], 0xf0, 0, 1);
> =20
>      /* SDRAM controller */
> -    memset(ram_bases, 0, sizeof(ram_bases));
> -    memset(ram_sizes, 0, sizeof(ram_sizes));
>      /* put all RAM on first bank because board has one slot
>       * and firmware only checks that */
>      machine->ram_size =3D ppc4xx_sdram_adjust(machine->ram_size, 1,
> @@ -451,23 +318,19 @@ static void sam460ex_init(MachineState *machine)
>      ppc440_sdram_init(env, SDRAM_NR_BANKS, ram_memories,
>                        ram_bases, ram_sizes, 1);
> =20
> -    /* generate SPD EEPROM data */
> -    for (i =3D 0; i < SDRAM_NR_BANKS; i++) {
> -        generate_eeprom_spd(&smbus_eeprom_buf[i * 256], ram_sizes[i]);
> -    }
> -    generate_eeprom_serial(&smbus_eeprom_buf[4 * 256]);
> -    generate_eeprom_serial(&smbus_eeprom_buf[6 * 256]);
> -
> -    /* IIC controllers */
> +    /* IIC controllers and devices */
>      dev =3D sysbus_create_simple(TYPE_PPC4xx_I2C, 0x4ef600700, uic[0][2]=
);
> -    i2c[0] =3D PPC4xx_I2C(dev);
> -    object_property_set_bool(OBJECT(dev), true, "realized", NULL);
> -    smbus_eeprom_init(i2c[0]->bus, 8, smbus_eeprom_buf, smbus_eeprom_siz=
e);
> -    g_free(smbus_eeprom_buf);
> -    i2c_create_slave(i2c[0]->bus, "m41t80", 0x68);
> +    i2c =3D PPC4xx_I2C(dev)->bus;
> +    /* SPD EEPROM on RAM module */
> +    spd_data =3D spd_data_generate(DDR2, ram_sizes[0]);
> +    if (spd_data) {
> +        spd_data[20] =3D 4; /* SO-DIMM module */
> +        smbus_eeprom_init_one(i2c, 0x50, spd_data);

Any specific reason this case is handled outside spd_data_generate()?

> +    }
> +    /* RTC */
> +    i2c_create_slave(i2c, "m41t80", 0x68);
> =20
>      dev =3D sysbus_create_simple(TYPE_PPC4xx_I2C, 0x4ef600800, uic[0][3]=
);
> -    i2c[1] =3D PPC4xx_I2C(dev);
> =20
>      /* External bus controller */
>      ppc405_ebc_init(env);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dzI2QqkSBOAresgT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwsOfUACgkQbDjKyiDZ
s5IlzhAA0E8A+Y5coey+zbx8F0sB7YJfXkd+kIUHQDNIaQlthrimlnNNYrO0q+BG
SFF/1/JZKWd6JsW1oJ8ERNNrZbJsK06oGNNKnfZJGQfXEqudBgfjz5quFgsneIXt
9zVYRX/+fllFbRYfRryhbJWMckQ4hg2CYCxkb8MiRzZvz0nYa1aL3HCWtC2XUW6b
tNd4jWyxdZz6PSHe5csFP7bGpc5ruH5Su+Naktvy+5f+HlmOmRGEoXmM1Gcq4IBb
guj0eL/u+F9FFNOL6k6a6Nb7DYLHPB6zoAg5dWUL6ktn8TvjZf7mkby58NKMyqeR
yK3JH7FXTu2bLwZeg7GjFj5RdblpDm0uMCj12MpgB/98c9Io4yhl1CWPsJDaxw/i
XC2she+m3PzXSCS4Lql4rAXQRlQ6WZcP1nvMY/6f9vHpLlJaBjw+6CXH7NH+8iPE
3akqbH30BqDA6QP1WHAU4pesTXVYoXI/Ah+S/2lrXjOxrIe4SfhVUEVXDJ7Y/6N+
xKFRLZZw5PX1imADwG/kx745nG6iRukL9iamCijekKL0ng8ODhBQlVdIFt3xHWTo
QcWD2e5TWww5mpywUDJxza1j4SIadbxEqONRhAM5e2P70O270efW50nuWwLJsDZ2
a+1Nxz+6CaFModkgJf8mCNirWvOza+0jLBcyAsO+uwGgMlpLcbE=
=C3zw
-----END PGP SIGNATURE-----

--dzI2QqkSBOAresgT--
