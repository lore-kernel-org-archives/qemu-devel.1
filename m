Received: from eggs.gnu.org ([2001:4830:134:3::10]:48084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fWrbX-00016F-3e
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 19:06:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fWrbT-0005rB-Rw
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 19:06:03 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:55574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1fWrbT-0005pK-B8
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 19:05:59 -0400
Date: Sun, 24 Jun 2018 01:05:56 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <0240b908-ee0b-84ca-b10c-fbae34720f6d@amsat.org>
Message-ID: <alpine.BSF.2.21.1806232312500.73730@zero.eik.bme.hu>
References: <cover.1529568501.git.balaton@eik.bme.hu>
	<9933d3e471467712047b5e60627bad2e3a38bcae.1529568501.git.balaton@eik.bme.hu>
	<0240b908-ee0b-84ca-b10c-fbae34720f6d@amsat.org>
MIME-Version: 1.0
Content-ID: <alpine.BSF.2.21.1806240026300.73730@zero.eik.bme.hu>
Content-Type: text/plain; CHARSET=ISO-8859-15; FORMAT=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/5] sm501: Implement i2c part for reading
 monitor EDID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Sebastian Bauer <mail@sebastianbauer.info>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, David Gibson <david@gibson.dropbear.id.au>

Hello,

Thanks for review, see some questions below.

On Fri, 22 Jun 2018, Philippe Mathieu-Daud=E9 wrote:
> On 06/21/2018 05:08 AM, BALATON Zoltan wrote:
>> Emulate the i2c part of SM501 which is used to access the EDID info
>> from a monitor.
>>
>> The vmstate structure is changed and its version is increased but
>> SM501 is only used on SH and PPC sam460ex machines that don't support
>> cross-version migration.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  default-configs/ppc-softmmu.mak    |   1 +
>>  default-configs/ppcemb-softmmu.mak |   1 +
>>  default-configs/sh4-softmmu.mak    |   2 +
>>  default-configs/sh4eb-softmmu.mak  |   2 +
>>  hw/display/sm501.c                 | 136 ++++++++++++++++++++++++++++=
+++++++--
>>  5 files changed, 138 insertions(+), 4 deletions(-)
>>
[...]
>> @@ -487,6 +492,11 @@ typedef struct SM501State {
>>      uint32_t misc_timing;
>>      uint32_t power_mode_control;
>>
>> +    uint8_t i2c_byte_count;
>> +    uint8_t i2c_status;
>> +    uint8_t i2c_addr;
>> +    uint8_t i2c_data[16];
>
> Using:
>       uint8_t i2c_regs[0x20];
>
> Would ease vmstate management and further refactors.

Hmm, all other regions have named variables like this and not indexed=20
arrays so that would not fit the current way device is implemented.

>> +
>>      uint32_t uart0_ier;
>>      uint32_t uart0_lcr;
>>      uint32_t uart0_mcr;
>> @@ -897,6 +907,107 @@ static const MemoryRegionOps sm501_system_config=
_ops =3D {
>>      .endianness =3D DEVICE_LITTLE_ENDIAN,
>>  };
>>
>
> To help code review you can use the "hw/registerfields.h" API:
>
> FIELD(CTRL, ENABLE,       0, 1)
> FIELD(CTRL, BUS_SPEED,    1, 1)
> FIELD(CTRL, START,        2, 1)
> FIELD(CTRL, INT_ENABLE,   4, 1)
> FIELD(CTRL, INT_ACK,      5, 1)
> FIELD(CTRL, REPEAT_START, 6, 1)
>
> FIELD(STATUS, BUSY,       0, 1)
> FIELD(STATUS, ACK,        1, 1)
> FIELD(STATUS, ERROR,      2, 1)
> FIELD(STATUS, COMPLETE,   3, 1)
>
> FIELD(RESET, ERROR,       2, 1)
>
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
>
> At some point we should replace the SM501_DPRINTF() macro by trace even=
ts.

This and to convert to use registerfields as suggested above could be don=
e=20
in separate clean up, not in this patch. That's why I've followed existin=
g=20
usage of SM501_DPRINTF here.

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
>
>               value & R_CTRL_ENABLE_MASK
>
>> +            if (value & 4) {
>
>                   value & R_CTRL_START_MASK
>
>> +                int res =3D i2c_start_transfer(s->i2c_bus,
>> +                                             s->i2c_addr >> 1,
>> +                                             s->i2c_addr & 1);
>> +                s->i2c_status |=3D (res ? 1 << 2 : 0);
>
> Hmm if you previously had the ERROR bit set, you don't clear it.
>
>                   s->i2c_status =3D FIELD_DP32(s->i2c_status, STATUS,
>                                              ERROR, res);
>
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
>
> Ditto.
>
> This could be a goto transfer_error at end of func.

Where do you see in spec or elsewhere when should the error bit be=20
cleared?

>
>> +                            return;
>> +                        }
>> +                    }
>> +                    if (i) {
>> +                        SM501_DPRINTF("sm501 i2c : transferred %d byt=
es\n", i);
>> +                        s->i2c_status =3D 8;
>
>                           s->i2c_status =3D R_STATUS_COMPLETE_MASK;
>
>> +                    }
>> +                }
>> +            } else {
>> +                SM501_DPRINTF("sm501 i2c : end transfer\n");
>> +                i2c_end_transfer(s->i2c_bus);
>> +                s->i2c_status &=3D ~4;
>
>                   s->i2c_status &=3D ~R_STATUS_ERROR_MASK;
>
>> +            }
>> +        }
>> +        break;
>> +    case SM501_I2C_RESET:
>> +            s->i2c_status &=3D ~4;
>
> I understand "0 clear" as:
>
>               if (FIELD_EX32(value, RESET, ERROR) =3D=3D 0) {
>                   s->i2c_status &=3D ~R_STATUS_ERROR_MASK;
>               }
>
> also:
>
>               value &=3D ~R_RESET_ERROR_MASK;
>               if (value) {
>                   qemu_log_mask(LOG_GUEST_ERROR,
>                                 "sm501_i2c_write(RESET) bad value...",
>                                 value);
>               }

In my copy of the spec all other bits are reserved (should contain 0) and=
=20
error bit is write only.

>> +        break;
>> +    case SM501_I2C_SLAVE_ADDRESS:
>> +        s->i2c_addr =3D value & 0xff;
>
> Implicit mask, fine.
>
>> +        break;
>> +    case SM501_I2C_DATA ... SM501_I2C_DATA + 15:
>> +        s->i2c_data[addr - SM501_I2C_DATA] =3D value & 0xff;
>
> Ditto.
>
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
>
> Per "Table 9-1: GPIO and I2C Register Summary" valid.max_access_size is
> 1 (8-bit registers) for registers 0, 1, 2, 3;
> and 4 for registers 4 to 15.
>
> To keep things simple you could add in sm501_i2c_read/sm501_i2c_write
> prologue:
>
>       if (addr < 4 && size > 1) {
>           qemu_log_mask(LOG_GUEST_ERROR, ...
>           return ...
>       }

Actually the copy I have lists all i2c regs as 8 bits in table 9-1 so=20
maybe I should have .max_access_size =3D 1 instead. Or where have you see=
n=20
access size 4 for regs >=3D 4 ?

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
>>      s->local_mem =3D memory_region_get_ram_ptr(&s->local_mem_region);
>>
>> +    /* i2c */
>> +    s->i2c_bus =3D i2c_init_bus(dev, "sm501.i2c");
>
>       /* ddc */
>
>> +    I2CDDCState *ddc =3D I2CDDC(qdev_create(BUS(s->i2c_bus), TYPE_I2C=
DDC));
>> +    i2c_set_slave_address(I2C_SLAVE(ddc), 0x50);
>
> I think this is board/screen related but that's way easier this way.
>
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
>
> Per "Figure 9-2: GPIO / I2C Master Register Space" the region size is 0=
x20.

But registers are only defined for 0x40-0x53 so what should the rest of=20
this region contain?

Regards,
BALATON Zoltan

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
>> @@ -1770,8 +1898,8 @@ static void sm501_reset_sysbus(DeviceState *dev)
>>
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
>>
>>  static const VMStateDescription vmstate_sm501_pci =3D {
>>      .name =3D TYPE_PCI_SM501,
>> -    .version_id =3D 1,
>> -    .minimum_version_id =3D 1,
>> +    .version_id =3D 2,
>> +    .minimum_version_id =3D 2,
>>      .fields =3D (VMStateField[]) {
>>          VMSTATE_PCI_DEVICE(parent_obj, SM501PCIState),
>>          VMSTATE_STRUCT(state, SM501PCIState, 1,
>>
>
> Fixing "0 clear" and region size to 0x20:
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>
> Regards,
>
> Phil.
>
>
