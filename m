Received: from eggs.gnu.org ([2001:4830:134:3::10]:50002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVXUa-0001ab-BU
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:25:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVXUW-0008EL-1e
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:25:24 -0400
Date: Wed, 20 Jun 2018 17:17:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180620071747.GD24636@umbus.fritz.box>
References: <cover.1529398335.git.balaton@eik.bme.hu>
	<6d266faa2251da21cb7eb7e0a4a9001e0d814d5a.1529398335.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zbGR4y+acU1DwHSi"
Content-Disposition: inline
In-Reply-To: <6d266faa2251da21cb7eb7e0a4a9001e0d814d5a.1529398335.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v4 07/11] sm501: Implement i2c part for
 reading monitor EDID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>


--zbGR4y+acU1DwHSi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 19, 2018 at 10:52:15AM +0200, BALATON Zoltan wrote:
> Emulate the i2c part of SM501 which is used to access the EDID info
> from a monitor.
>=20
> The vmstate structure is changed and its version is increased but
> SM501 is only used on SH and PPC sam460ex machines that don't support
> cross-version migration.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> v4: Updated commit message

This patch breaks compile on SH - sm501 now needs various i2c symbols
that aren't configured into the SH builds.

As a rule, it's always wise to try compiling with a bare ./configure
before you post to make sure you didn't break some platform you
weren't thinking about.  Doing a "make check" like that is even better.

>=20
>  default-configs/ppc-softmmu.mak    |   1 +
>  default-configs/ppcemb-softmmu.mak |   1 +
>  default-configs/sh4-softmmu.mak    |   1 +
>  default-configs/sh4eb-softmmu.mak  |   1 +
>  hw/display/sm501.c                 | 136 +++++++++++++++++++++++++++++++=
++++--
>  5 files changed, 136 insertions(+), 4 deletions(-)
>=20
> diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmm=
u.mak
> index b8b0526..e131e24 100644
> --- a/default-configs/ppc-softmmu.mak
> +++ b/default-configs/ppc-softmmu.mak
> @@ -24,6 +24,7 @@ CONFIG_ETSEC=3Dy
>  # For Sam460ex
>  CONFIG_USB_EHCI_SYSBUS=3Dy
>  CONFIG_SM501=3Dy
> +CONFIG_DDC=3Dy
>  CONFIG_IDE_SII3112=3Dy
>  CONFIG_I2C=3Dy
>  CONFIG_BITBANG_I2C=3Dy
> diff --git a/default-configs/ppcemb-softmmu.mak b/default-configs/ppcemb-=
softmmu.mak
> index 37af193..ac44f15 100644
> --- a/default-configs/ppcemb-softmmu.mak
> +++ b/default-configs/ppcemb-softmmu.mak
> @@ -17,6 +17,7 @@ CONFIG_XILINX=3Dy
>  CONFIG_XILINX_ETHLITE=3Dy
>  CONFIG_USB_EHCI_SYSBUS=3Dy
>  CONFIG_SM501=3Dy
> +CONFIG_DDC=3Dy
>  CONFIG_IDE_SII3112=3Dy
>  CONFIG_I2C=3Dy
>  CONFIG_BITBANG_I2C=3Dy
> diff --git a/default-configs/sh4-softmmu.mak b/default-configs/sh4-softmm=
u.mak
> index 546d855..72d8fca 100644
> --- a/default-configs/sh4-softmmu.mak
> +++ b/default-configs/sh4-softmmu.mak
> @@ -9,6 +9,7 @@ CONFIG_PFLASH_CFI02=3Dy
>  CONFIG_SH4=3Dy
>  CONFIG_IDE_MMIO=3Dy
>  CONFIG_SM501=3Dy
> +CONFIG_DDC=3Dy
>  CONFIG_ISA_TESTDEV=3Dy
>  CONFIG_I82378=3Dy
>  CONFIG_I8259=3Dy
> diff --git a/default-configs/sh4eb-softmmu.mak b/default-configs/sh4eb-so=
ftmmu.mak
> index 2d3fd49..c686637 100644
> --- a/default-configs/sh4eb-softmmu.mak
> +++ b/default-configs/sh4eb-softmmu.mak
> @@ -9,6 +9,7 @@ CONFIG_PFLASH_CFI02=3Dy
>  CONFIG_SH4=3Dy
>  CONFIG_IDE_MMIO=3Dy
>  CONFIG_SM501=3Dy
> +CONFIG_DDC=3Dy
>  CONFIG_ISA_TESTDEV=3Dy
>  CONFIG_I82378=3Dy
>  CONFIG_I8259=3Dy
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 8206ae8..a076248 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -26,6 +26,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/cutils.h"
>  #include "qapi/error.h"
> +#include "qemu/log.h"
>  #include "qemu-common.h"
>  #include "cpu.h"
>  #include "hw/hw.h"
> @@ -34,6 +35,8 @@
>  #include "hw/devices.h"
>  #include "hw/sysbus.h"
>  #include "hw/pci/pci.h"
> +#include "hw/i2c/i2c.h"
> +#include "hw/i2c/i2c-ddc.h"
>  #include "qemu/range.h"
>  #include "ui/pixel_ops.h"
> =20
> @@ -471,10 +474,12 @@ typedef struct SM501State {
>      MemoryRegion local_mem_region;
>      MemoryRegion mmio_region;
>      MemoryRegion system_config_region;
> +    MemoryRegion i2c_region;
>      MemoryRegion disp_ctrl_region;
>      MemoryRegion twoD_engine_region;
>      uint32_t last_width;
>      uint32_t last_height;
> +    I2CBus *i2c_bus;
> =20
>      /* mmio registers */
>      uint32_t system_control;
> @@ -487,6 +492,11 @@ typedef struct SM501State {
>      uint32_t misc_timing;
>      uint32_t power_mode_control;
> =20
> +    uint8_t i2c_byte_count;
> +    uint8_t i2c_status;
> +    uint8_t i2c_addr;
> +    uint8_t i2c_data[16];
> +
>      uint32_t uart0_ier;
>      uint32_t uart0_lcr;
>      uint32_t uart0_mcr;
> @@ -897,6 +907,107 @@ static const MemoryRegionOps sm501_system_config_op=
s =3D {
>      .endianness =3D DEVICE_LITTLE_ENDIAN,
>  };
> =20
> +static uint64_t sm501_i2c_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    SM501State *s =3D (SM501State *)opaque;
> +    uint8_t ret =3D 0;
> +
> +    switch (addr) {
> +    case SM501_I2C_BYTE_COUNT:
> +        ret =3D s->i2c_byte_count;
> +        break;
> +    case SM501_I2C_STATUS:
> +        ret =3D s->i2c_status;
> +        break;
> +    case SM501_I2C_SLAVE_ADDRESS:
> +        ret =3D s->i2c_addr;
> +        break;
> +    case SM501_I2C_DATA ... SM501_I2C_DATA + 15:
> +        ret =3D s->i2c_data[addr - SM501_I2C_DATA];
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "sm501 i2c : not implemented register r=
ead."
> +                      " addr=3D0x%" HWADDR_PRIx "\n", addr);
> +    }
> +
> +    SM501_DPRINTF("sm501 i2c regs : read addr=3D%" HWADDR_PRIx " val=3D%=
x\n",
> +                  addr, ret);
> +    return ret;
> +}
> +
> +static void sm501_i2c_write(void *opaque, hwaddr addr, uint64_t value,
> +                            unsigned size)
> +{
> +    SM501State *s =3D (SM501State *)opaque;
> +    SM501_DPRINTF("sm501 i2c regs : write addr=3D%" HWADDR_PRIx
> +                  " val=3D%" PRIx64 "\n", addr, value);
> +
> +    switch (addr) {
> +    case SM501_I2C_BYTE_COUNT:
> +        s->i2c_byte_count =3D value & 0xf;
> +        break;
> +    case SM501_I2C_CONTROL:
> +        if (value & 1) {
> +            if (value & 4) {
> +                int res =3D i2c_start_transfer(s->i2c_bus,
> +                                             s->i2c_addr >> 1,
> +                                             s->i2c_addr & 1);
> +                s->i2c_status |=3D (res ? 1 << 2 : 0);
> +                if (!res) {
> +                    int i;
> +                    SM501_DPRINTF("sm501 i2c : transferring %d bytes to =
0x%x\n",
> +                                  s->i2c_byte_count + 1, s->i2c_addr >> =
1);
> +                    for (i =3D 0; i <=3D s->i2c_byte_count; i++) {
> +                        res =3D i2c_send_recv(s->i2c_bus, &s->i2c_data[i=
],
> +                                            !(s->i2c_addr & 1));
> +                        if (res) {
> +                            SM501_DPRINTF("sm501 i2c : transfer failed"
> +                                          " i=3D%d, res=3D%d\n", i, res);
> +                            s->i2c_status |=3D (res ? 1 << 2 : 0);
> +                            return;
> +                        }
> +                    }
> +                    if (i) {
> +                        SM501_DPRINTF("sm501 i2c : transferred %d bytes\=
n", i);
> +                        s->i2c_status =3D 8;
> +                    }
> +                }
> +            } else {
> +                SM501_DPRINTF("sm501 i2c : end transfer\n");
> +                i2c_end_transfer(s->i2c_bus);
> +                s->i2c_status &=3D ~4;
> +            }
> +        }
> +        break;
> +    case SM501_I2C_RESET:
> +            s->i2c_status &=3D ~4;
> +        break;
> +    case SM501_I2C_SLAVE_ADDRESS:
> +        s->i2c_addr =3D value & 0xff;
> +        break;
> +    case SM501_I2C_DATA ... SM501_I2C_DATA + 15:
> +        s->i2c_data[addr - SM501_I2C_DATA] =3D value & 0xff;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "sm501 i2c : not implemented register w=
rite. "
> +                      "addr=3D0x%" HWADDR_PRIx " val=3D%" PRIx64 "\n", a=
ddr, value);
> +    }
> +}
> +
> +static const MemoryRegionOps sm501_i2c_ops =3D {
> +    .read =3D sm501_i2c_read,
> +    .write =3D sm501_i2c_write,
> +    .valid =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 4,
> +    },
> +    .impl =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 1,
> +    },
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +};
> +
>  static uint32_t sm501_palette_read(void *opaque, hwaddr addr)
>  {
>      SM501State *s =3D (SM501State *)opaque;
> @@ -1577,6 +1688,10 @@ static void sm501_reset(SM501State *s)
>      s->irq_mask =3D 0;
>      s->misc_timing =3D 0;
>      s->power_mode_control =3D 0;
> +    s->i2c_byte_count =3D 0;
> +    s->i2c_status =3D 0;
> +    s->i2c_addr =3D 0;
> +    memset(s->i2c_data, 0, 16);
>      s->dc_panel_control =3D 0x00010000; /* FIFO level 3 */
>      s->dc_video_control =3D 0;
>      s->dc_crt_control =3D 0x00010000;
> @@ -1615,6 +1730,11 @@ static void sm501_init(SM501State *s, DeviceState =
*dev,
>      memory_region_set_log(&s->local_mem_region, true, DIRTY_MEMORY_VGA);
>      s->local_mem =3D memory_region_get_ram_ptr(&s->local_mem_region);
> =20
> +    /* i2c */
> +    s->i2c_bus =3D i2c_init_bus(dev, "sm501.i2c");
> +    I2CDDCState *ddc =3D I2CDDC(qdev_create(BUS(s->i2c_bus), TYPE_I2CDDC=
));
> +    i2c_set_slave_address(I2C_SLAVE(ddc), 0x50);
> +
>      /* mmio */
>      memory_region_init(&s->mmio_region, OBJECT(dev), "sm501.mmio", MMIO_=
SIZE);
>      memory_region_init_io(&s->system_config_region, OBJECT(dev),
> @@ -1622,6 +1742,9 @@ static void sm501_init(SM501State *s, DeviceState *=
dev,
>                            "sm501-system-config", 0x6c);
>      memory_region_add_subregion(&s->mmio_region, SM501_SYS_CONFIG,
>                                  &s->system_config_region);
> +    memory_region_init_io(&s->i2c_region, OBJECT(dev), &sm501_i2c_ops, s,
> +                          "sm501-i2c", 0x14);
> +    memory_region_add_subregion(&s->mmio_region, SM501_I2C, &s->i2c_regi=
on);
>      memory_region_init_io(&s->disp_ctrl_region, OBJECT(dev),
>                            &sm501_disp_ctrl_ops, s,
>                            "sm501-disp-ctrl", 0x1000);
> @@ -1705,6 +1828,11 @@ static const VMStateDescription vmstate_sm501_stat=
e =3D {
>          VMSTATE_UINT32(twoD_destination_base, SM501State),
>          VMSTATE_UINT32(twoD_alpha, SM501State),
>          VMSTATE_UINT32(twoD_wrap, SM501State),
> +        /* Added in version 2 */
> +        VMSTATE_UINT8(i2c_byte_count, SM501State),
> +        VMSTATE_UINT8(i2c_status, SM501State),
> +        VMSTATE_UINT8(i2c_addr, SM501State),
> +        VMSTATE_UINT8_ARRAY(i2c_data, SM501State, 16),
>          VMSTATE_END_OF_LIST()
>       }
>  };
> @@ -1770,8 +1898,8 @@ static void sm501_reset_sysbus(DeviceState *dev)
> =20
>  static const VMStateDescription vmstate_sm501_sysbus =3D {
>      .name =3D TYPE_SYSBUS_SM501,
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> +    .version_id =3D 2,
> +    .minimum_version_id =3D 2,
>      .fields =3D (VMStateField[]) {
>          VMSTATE_STRUCT(state, SM501SysBusState, 1,
>                         vmstate_sm501_state, SM501State),
> @@ -1843,8 +1971,8 @@ static void sm501_reset_pci(DeviceState *dev)
> =20
>  static const VMStateDescription vmstate_sm501_pci =3D {
>      .name =3D TYPE_PCI_SM501,
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> +    .version_id =3D 2,
> +    .minimum_version_id =3D 2,
>      .fields =3D (VMStateField[]) {
>          VMSTATE_PCI_DEVICE(parent_obj, SM501PCIState),
>          VMSTATE_STRUCT(state, SM501PCIState, 1,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zbGR4y+acU1DwHSi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsp/5kACgkQbDjKyiDZ
s5KA/BAAvB0BKQ2g5iHBtJeA18hMt6SfobPIMkbioh153IvRnpyBUqoDpOjolfDS
96lyMKJZW+8X+sQcXWCdn8yyDBtnrEa7f7bSKuxcVj1nt5FAmUvSxDSCVQgXxEZK
P7fNU19g8XEPwtyFpy6Xk7YFpwU98k32a0pehEdS1njVVqzq/h4ebIpZqjKp4Byq
IPTw6u2yHiCdSgWjsS4i9rNrIPbtehEYBorQj2hHZu98LppjDyppNyqRrcrty0lS
/4lrUts2eJYt3o6TTbzwx/leeX9yBHj1Nz7CcqLhhRtMsVTWCcaTIIf9A5o4rRQU
FxT3LhUClnyTAja2+rYV14NW5gFr+4JD+jQPqjuRGM3PNVpS7vQIugKIsJ7TWcvs
53D81Y1oXD3SKXvLlAxneDqP6ny7aEyPL85slC6CrWe+MvZ3trD5TyPObZiYN3Hs
vvSD2i2cPeTXco4Oogc5J+ew0027CTdoH01F4BJz0QBB90aKC5CckIRgrsZuqquX
v0O4OqZKY/J3owwsWBK7UGnsZfqznpG15PdG602mhJ9EXutVefodVtIWGbVnZuPT
sDQpOtoOeoagCvzmFvIQsSKED+8GFhQ8UJAXuFXmnzUblsA7MJ+Y751OIFqaxjCG
/GxDntPWl0bXtxCju+XB9dAThUzZ9Eo1r95JWwWHDZIkHQLVDV0=
=5ZPR
-----END PGP SIGNATURE-----

--zbGR4y+acU1DwHSi--
