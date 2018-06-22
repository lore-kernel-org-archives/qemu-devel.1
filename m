Received: from eggs.gnu.org ([2001:4830:134:3::10]:39076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWKk7-00071K-Sr
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:00:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWKk3-0008Rz-AD
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:00:43 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1529398335.git.balaton@eik.bme.hu>
	<6d266faa2251da21cb7eb7e0a4a9001e0d814d5a.1529398335.git.balaton@eik.bme.hu>
	<20180620071747.GD24636@umbus.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <24463254-c605-83fa-572f-b8d78267ca82@amsat.org>
Date: Fri, 22 Jun 2018 09:00:30 -0300
MIME-Version: 1.0
In-Reply-To: <20180620071747.GD24636@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="Yk3wxpgTu41AqqJX7nOpbDYV8XyuoZFf5"
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
To: David Gibson <david@gibson.dropbear.id.au>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Yk3wxpgTu41AqqJX7nOpbDYV8XyuoZFf5
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>
Message-ID: <24463254-c605-83fa-572f-b8d78267ca82@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v4 07/11] sm501: Implement i2c part for
 reading monitor EDID
References: <cover.1529398335.git.balaton@eik.bme.hu>
 <6d266faa2251da21cb7eb7e0a4a9001e0d814d5a.1529398335.git.balaton@eik.bme.hu>
 <20180620071747.GD24636@umbus.fritz.box>
In-Reply-To: <20180620071747.GD24636@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 06/20/2018 04:17 AM, David Gibson wrote:
> On Tue, Jun 19, 2018 at 10:52:15AM +0200, BALATON Zoltan wrote:
>> Emulate the i2c part of SM501 which is used to access the EDID info
>> from a monitor.
>>
>> The vmstate structure is changed and its version is increased but
>> SM501 is only used on SH and PPC sam460ex machines that don't support
>> cross-version migration.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>> v4: Updated commit message
>=20
> This patch breaks compile on SH - sm501 now needs various i2c symbols
> that aren't configured into the SH builds.
>=20
> As a rule, it's always wise to try compiling with a bare ./configure
> before you post to make sure you didn't break some platform you
> weren't thinking about.  Doing a "make check" like that is even better.=


Or if you lack horsepower and have time (~2h), push your branch to a
github repo with Travis CI enabled, and Travis will build/check testing
all for you.

>=20
>>
>>  default-configs/ppc-softmmu.mak    |   1 +
>>  default-configs/ppcemb-softmmu.mak |   1 +
>>  default-configs/sh4-softmmu.mak    |   1 +
>>  default-configs/sh4eb-softmmu.mak  |   1 +
>>  hw/display/sm501.c                 | 136 ++++++++++++++++++++++++++++=
+++++++--
>>  5 files changed, 136 insertions(+), 4 deletions(-)
>>
>> diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-sof=
tmmu.mak
>> index b8b0526..e131e24 100644
>> --- a/default-configs/ppc-softmmu.mak
>> +++ b/default-configs/ppc-softmmu.mak
>> @@ -24,6 +24,7 @@ CONFIG_ETSEC=3Dy
>>  # For Sam460ex
>>  CONFIG_USB_EHCI_SYSBUS=3Dy
>>  CONFIG_SM501=3Dy
>> +CONFIG_DDC=3Dy
>>  CONFIG_IDE_SII3112=3Dy
>>  CONFIG_I2C=3Dy
>>  CONFIG_BITBANG_I2C=3Dy
>> diff --git a/default-configs/ppcemb-softmmu.mak b/default-configs/ppce=
mb-softmmu.mak
>> index 37af193..ac44f15 100644
>> --- a/default-configs/ppcemb-softmmu.mak
>> +++ b/default-configs/ppcemb-softmmu.mak
>> @@ -17,6 +17,7 @@ CONFIG_XILINX=3Dy
>>  CONFIG_XILINX_ETHLITE=3Dy
>>  CONFIG_USB_EHCI_SYSBUS=3Dy
>>  CONFIG_SM501=3Dy
>> +CONFIG_DDC=3Dy
>>  CONFIG_IDE_SII3112=3Dy
>>  CONFIG_I2C=3Dy
>>  CONFIG_BITBANG_I2C=3Dy
>> diff --git a/default-configs/sh4-softmmu.mak b/default-configs/sh4-sof=
tmmu.mak
>> index 546d855..72d8fca 100644
>> --- a/default-configs/sh4-softmmu.mak
>> +++ b/default-configs/sh4-softmmu.mak
>> @@ -9,6 +9,7 @@ CONFIG_PFLASH_CFI02=3Dy
>>  CONFIG_SH4=3Dy
>>  CONFIG_IDE_MMIO=3Dy
>>  CONFIG_SM501=3Dy
>> +CONFIG_DDC=3Dy
>>  CONFIG_ISA_TESTDEV=3Dy
>>  CONFIG_I82378=3Dy
>>  CONFIG_I8259=3Dy
>> diff --git a/default-configs/sh4eb-softmmu.mak b/default-configs/sh4eb=
-softmmu.mak
>> index 2d3fd49..c686637 100644
>> --- a/default-configs/sh4eb-softmmu.mak
>> +++ b/default-configs/sh4eb-softmmu.mak
>> @@ -9,6 +9,7 @@ CONFIG_PFLASH_CFI02=3Dy
>>  CONFIG_SH4=3Dy
>>  CONFIG_IDE_MMIO=3Dy
>>  CONFIG_SM501=3Dy
>> +CONFIG_DDC=3Dy
>>  CONFIG_ISA_TESTDEV=3Dy
>>  CONFIG_I82378=3Dy
>>  CONFIG_I8259=3Dy
>> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
>> index 8206ae8..a076248 100644
>> --- a/hw/display/sm501.c
>> +++ b/hw/display/sm501.c
>> @@ -26,6 +26,7 @@
>>  #include "qemu/osdep.h"
>>  #include "qemu/cutils.h"
>>  #include "qapi/error.h"
>> +#include "qemu/log.h"
>>  #include "qemu-common.h"
>>  #include "cpu.h"
>>  #include "hw/hw.h"
>> @@ -34,6 +35,8 @@
>>  #include "hw/devices.h"
>>  #include "hw/sysbus.h"
>>  #include "hw/pci/pci.h"
>> +#include "hw/i2c/i2c.h"
>> +#include "hw/i2c/i2c-ddc.h"
>>  #include "qemu/range.h"
>>  #include "ui/pixel_ops.h"
>> =20
>> @@ -471,10 +474,12 @@ typedef struct SM501State {
>>      MemoryRegion local_mem_region;
>>      MemoryRegion mmio_region;
>>      MemoryRegion system_config_region;
>> +    MemoryRegion i2c_region;
>>      MemoryRegion disp_ctrl_region;
>>      MemoryRegion twoD_engine_region;
>>      uint32_t last_width;
>>      uint32_t last_height;
>> +    I2CBus *i2c_bus;
>> =20
>>      /* mmio registers */
>>      uint32_t system_control;
>> @@ -487,6 +492,11 @@ typedef struct SM501State {
>>      uint32_t misc_timing;
>>      uint32_t power_mode_control;
>> =20
>> +    uint8_t i2c_byte_count;
>> +    uint8_t i2c_status;
>> +    uint8_t i2c_addr;
>> +    uint8_t i2c_data[16];
>> +
>>      uint32_t uart0_ier;
>>      uint32_t uart0_lcr;
>>      uint32_t uart0_mcr;
>> @@ -897,6 +907,107 @@ static const MemoryRegionOps sm501_system_config=
_ops =3D {
>>      .endianness =3D DEVICE_LITTLE_ENDIAN,
>>  };
>> =20
>> +static uint64_t sm501_i2c_read(void *opaque, hwaddr addr, unsigned si=
ze)
>> +{
>> +    SM501State *s =3D (SM501State *)opaque;
>> +    uint8_t ret =3D 0;
>> +
>> +    switch (addr) {
>> +    case SM501_I2C_BYTE_COUNT:
>> +        ret =3D s->i2c_byte_count;
>> +        break;
>> +    case SM501_I2C_STATUS:
>> +        ret =3D s->i2c_status;
>> +        break;
>> +    case SM501_I2C_SLAVE_ADDRESS:
>> +        ret =3D s->i2c_addr;
>> +        break;
>> +    case SM501_I2C_DATA ... SM501_I2C_DATA + 15:
>> +        ret =3D s->i2c_data[addr - SM501_I2C_DATA];
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_UNIMP, "sm501 i2c : not implemented registe=
r read."
>> +                      " addr=3D0x%" HWADDR_PRIx "\n", addr);
>> +    }
>> +
>> +    SM501_DPRINTF("sm501 i2c regs : read addr=3D%" HWADDR_PRIx " val=3D=
%x\n",
>> +                  addr, ret);
>> +    return ret;
>> +}
>> +
>> +static void sm501_i2c_write(void *opaque, hwaddr addr, uint64_t value=
,
>> +                            unsigned size)
>> +{
>> +    SM501State *s =3D (SM501State *)opaque;
>> +    SM501_DPRINTF("sm501 i2c regs : write addr=3D%" HWADDR_PRIx
>> +                  " val=3D%" PRIx64 "\n", addr, value);
>> +
>> +    switch (addr) {
>> +    case SM501_I2C_BYTE_COUNT:
>> +        s->i2c_byte_count =3D value & 0xf;
>> +        break;
>> +    case SM501_I2C_CONTROL:
>> +        if (value & 1) {
>> +            if (value & 4) {
>> +                int res =3D i2c_start_transfer(s->i2c_bus,
>> +                                             s->i2c_addr >> 1,
>> +                                             s->i2c_addr & 1);
>> +                s->i2c_status |=3D (res ? 1 << 2 : 0);
>> +                if (!res) {
>> +                    int i;
>> +                    SM501_DPRINTF("sm501 i2c : transferring %d bytes =
to 0x%x\n",
>> +                                  s->i2c_byte_count + 1, s->i2c_addr =
>> 1);
>> +                    for (i =3D 0; i <=3D s->i2c_byte_count; i++) {
>> +                        res =3D i2c_send_recv(s->i2c_bus, &s->i2c_dat=
a[i],
>> +                                            !(s->i2c_addr & 1));
>> +                        if (res) {
>> +                            SM501_DPRINTF("sm501 i2c : transfer faile=
d"
>> +                                          " i=3D%d, res=3D%d\n", i, r=
es);
>> +                            s->i2c_status |=3D (res ? 1 << 2 : 0);
>> +                            return;
>> +                        }
>> +                    }
>> +                    if (i) {
>> +                        SM501_DPRINTF("sm501 i2c : transferred %d byt=
es\n", i);
>> +                        s->i2c_status =3D 8;
>> +                    }
>> +                }
>> +            } else {
>> +                SM501_DPRINTF("sm501 i2c : end transfer\n");
>> +                i2c_end_transfer(s->i2c_bus);
>> +                s->i2c_status &=3D ~4;
>> +            }
>> +        }
>> +        break;
>> +    case SM501_I2C_RESET:
>> +            s->i2c_status &=3D ~4;
>> +        break;
>> +    case SM501_I2C_SLAVE_ADDRESS:
>> +        s->i2c_addr =3D value & 0xff;
>> +        break;
>> +    case SM501_I2C_DATA ... SM501_I2C_DATA + 15:
>> +        s->i2c_data[addr - SM501_I2C_DATA] =3D value & 0xff;
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_UNIMP, "sm501 i2c : not implemented registe=
r write. "
>> +                      "addr=3D0x%" HWADDR_PRIx " val=3D%" PRIx64 "\n"=
, addr, value);
>> +    }
>> +}
>> +
>> +static const MemoryRegionOps sm501_i2c_ops =3D {
>> +    .read =3D sm501_i2c_read,
>> +    .write =3D sm501_i2c_write,
>> +    .valid =3D {
>> +        .min_access_size =3D 1,
>> +        .max_access_size =3D 4,
>> +    },
>> +    .impl =3D {
>> +        .min_access_size =3D 1,
>> +        .max_access_size =3D 1,
>> +    },
>> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>> +};
>> +
>>  static uint32_t sm501_palette_read(void *opaque, hwaddr addr)
>>  {
>>      SM501State *s =3D (SM501State *)opaque;
>> @@ -1577,6 +1688,10 @@ static void sm501_reset(SM501State *s)
>>      s->irq_mask =3D 0;
>>      s->misc_timing =3D 0;
>>      s->power_mode_control =3D 0;
>> +    s->i2c_byte_count =3D 0;
>> +    s->i2c_status =3D 0;
>> +    s->i2c_addr =3D 0;
>> +    memset(s->i2c_data, 0, 16);
>>      s->dc_panel_control =3D 0x00010000; /* FIFO level 3 */
>>      s->dc_video_control =3D 0;
>>      s->dc_crt_control =3D 0x00010000;
>> @@ -1615,6 +1730,11 @@ static void sm501_init(SM501State *s, DeviceSta=
te *dev,
>>      memory_region_set_log(&s->local_mem_region, true, DIRTY_MEMORY_VG=
A);
>>      s->local_mem =3D memory_region_get_ram_ptr(&s->local_mem_region);=

>> =20
>> +    /* i2c */
>> +    s->i2c_bus =3D i2c_init_bus(dev, "sm501.i2c");
>> +    I2CDDCState *ddc =3D I2CDDC(qdev_create(BUS(s->i2c_bus), TYPE_I2C=
DDC));
>> +    i2c_set_slave_address(I2C_SLAVE(ddc), 0x50);
>> +
>>      /* mmio */
>>      memory_region_init(&s->mmio_region, OBJECT(dev), "sm501.mmio", MM=
IO_SIZE);
>>      memory_region_init_io(&s->system_config_region, OBJECT(dev),
>> @@ -1622,6 +1742,9 @@ static void sm501_init(SM501State *s, DeviceStat=
e *dev,
>>                            "sm501-system-config", 0x6c);
>>      memory_region_add_subregion(&s->mmio_region, SM501_SYS_CONFIG,
>>                                  &s->system_config_region);
>> +    memory_region_init_io(&s->i2c_region, OBJECT(dev), &sm501_i2c_ops=
, s,
>> +                          "sm501-i2c", 0x14);
>> +    memory_region_add_subregion(&s->mmio_region, SM501_I2C, &s->i2c_r=
egion);
>>      memory_region_init_io(&s->disp_ctrl_region, OBJECT(dev),
>>                            &sm501_disp_ctrl_ops, s,
>>                            "sm501-disp-ctrl", 0x1000);
>> @@ -1705,6 +1828,11 @@ static const VMStateDescription vmstate_sm501_s=
tate =3D {
>>          VMSTATE_UINT32(twoD_destination_base, SM501State),
>>          VMSTATE_UINT32(twoD_alpha, SM501State),
>>          VMSTATE_UINT32(twoD_wrap, SM501State),
>> +        /* Added in version 2 */
>> +        VMSTATE_UINT8(i2c_byte_count, SM501State),
>> +        VMSTATE_UINT8(i2c_status, SM501State),
>> +        VMSTATE_UINT8(i2c_addr, SM501State),
>> +        VMSTATE_UINT8_ARRAY(i2c_data, SM501State, 16),
>>          VMSTATE_END_OF_LIST()
>>       }
>>  };
>> @@ -1770,8 +1898,8 @@ static void sm501_reset_sysbus(DeviceState *dev)=

>> =20
>>  static const VMStateDescription vmstate_sm501_sysbus =3D {
>>      .name =3D TYPE_SYSBUS_SM501,
>> -    .version_id =3D 1,
>> -    .minimum_version_id =3D 1,
>> +    .version_id =3D 2,
>> +    .minimum_version_id =3D 2,
>>      .fields =3D (VMStateField[]) {
>>          VMSTATE_STRUCT(state, SM501SysBusState, 1,
>>                         vmstate_sm501_state, SM501State),
>> @@ -1843,8 +1971,8 @@ static void sm501_reset_pci(DeviceState *dev)
>> =20
>>  static const VMStateDescription vmstate_sm501_pci =3D {
>>      .name =3D TYPE_PCI_SM501,
>> -    .version_id =3D 1,
>> -    .minimum_version_id =3D 1,
>> +    .version_id =3D 2,
>> +    .minimum_version_id =3D 2,
>>      .fields =3D (VMStateField[]) {
>>          VMSTATE_PCI_DEVICE(parent_obj, SM501PCIState),
>>          VMSTATE_STRUCT(state, SM501PCIState, 1,
>=20


--Yk3wxpgTu41AqqJX7nOpbDYV8XyuoZFf5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlss5N4ACgkQ4+MsLN6t
wN4YPA//eWAwQsUP4rW3bLgl5k2LWAsFuMb36irWxFt+HADSIgQ4XP4k0brw+UE4
r91Et2AU29LQGl0MmniITprRAGf9zmp+MeqI+I9H5iodQfZf3oeJOTZLrzI8Dt8W
wvGdBcK/9ixYyp6ObOPCZm1iVfxIaxgeLWJYMlyij1yn6Z9HyrO5f36B8jUCQyHt
wDolrazhtL6vsCYwSGSIfmgwPIOQxthtOXuHygNLKSSqjD8tkkzcSFGI8td8jAJD
T7XR1sI9uADiVjYdAYNqkdY0/eQIhJHueNiMcYe0a5qE6g+AedS+p1JNWyegLbi5
vUTw73thbIcqqq3v7ydiWMOVKA01t7Jo32x+oTU0oxtmNnOaJfnr9fjo6GN+7Xz9
32elcBPbjMRQ6SPmjBo4Ky8SP5V7BtbEbwKXsoD0xb6sWBkU7UfBqI+ImwzW+Nq4
DcBJTJJpr7yovIl+TR5z4uMemNbBPNyCFAmt6D4+mW0lMkMYQJvHK6LrjQzhkWIt
1PNsAbIH0mV/caRvSEXUCTh0qr41O2wtMVDAYPAWQITV4yTFi4MiHdV8P419ai4G
cdNUbxxvcfT4hJlhTM0aiKzwipWbkkehmMkW/eC9qSyJQx2DX1l5w6oYtKNg0/Zq
dEcLaAS6UYJCZU8T0s/wWCya0PKp0Mw7tNnjC9a6BOwzbW6Yuzc=
=NOvI
-----END PGP SIGNATURE-----

--Yk3wxpgTu41AqqJX7nOpbDYV8XyuoZFf5--
