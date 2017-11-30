Received: from eggs.gnu.org ([2001:4830:134:3::10]:54851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKLsk-00075t-MT
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 05:15:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKLsh-0002Wd-Lm
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 05:15:50 -0500
Date: Thu, 30 Nov 2017 16:13:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171130051315.GF3023@umbus.fritz.box>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
	<f16023f8456fc137647cd6c60d5e2138d8a9afa2.1511731946.git.mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m1G908gh+QHqN0Gd"
Content-Disposition: inline
In-Reply-To: <f16023f8456fc137647cd6c60d5e2138d8a9afa2.1511731946.git.mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 05/17] timer: generalize Dallas/Maxim RTC
 i2c devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--m1G908gh+QHqN0Gd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 26, 2017 at 03:59:03PM -0600, Michael Davidsaver wrote:
> Support for: ds1307, ds1337, ds1338, ds1339,
> ds1340, ds1375, ds1388, and ds3231.
>=20
> Tested with ds1338 and ds1375.
>=20
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>

I certainly like the idea of consolidating this code, but reviewing to
see that the new code really is a generalization of the old is
something I won't have time for for a while.

Also, hw/timer is not within my purview so it'll probably need to go
another path to merge.

> ---
>  default-configs/arm-softmmu.mak |   2 +-
>  hw/timer/Makefile.objs          |   2 +-
>  hw/timer/ds-rtc-i2c.c           | 461 ++++++++++++++++++++++++++++++++++=
++++++
>  hw/timer/ds1338.c               | 239 ---------------------
>  4 files changed, 463 insertions(+), 241 deletions(-)
>  create mode 100644 hw/timer/ds-rtc-i2c.c
>  delete mode 100644 hw/timer/ds1338.c
>=20
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
> index d37edc4312..b857823681 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -31,7 +31,7 @@ CONFIG_SMC91C111=3Dy
>  CONFIG_ALLWINNER_EMAC=3Dy
>  CONFIG_IMX_FEC=3Dy
>  CONFIG_FTGMAC100=3Dy
> -CONFIG_DS1338=3Dy
> +CONFIG_DSRTCI2C=3Dy
>  CONFIG_PFLASH_CFI01=3Dy
>  CONFIG_PFLASH_CFI02=3Dy
>  CONFIG_MICRODRIVE=3Dy
> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index 8c19eac3b6..290015ebec 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -3,7 +3,7 @@ common-obj-$(CONFIG_ARM_MPTIMER) +=3D arm_mptimer.o
>  common-obj-$(CONFIG_ARM_V7M) +=3D armv7m_systick.o
>  common-obj-$(CONFIG_A9_GTIMER) +=3D a9gtimer.o
>  common-obj-$(CONFIG_CADENCE) +=3D cadence_ttc.o
> -common-obj-$(CONFIG_DS1338) +=3D ds1338.o
> +common-obj-$(CONFIG_DSRTCI2C) +=3D ds-rtc-i2c.o
>  common-obj-$(CONFIG_HPET) +=3D hpet.o
>  common-obj-$(CONFIG_I8254) +=3D i8254_common.o i8254.o
>  common-obj-$(CONFIG_M48T59) +=3D m48t59.o
> diff --git a/hw/timer/ds-rtc-i2c.c b/hw/timer/ds-rtc-i2c.c
> new file mode 100644
> index 0000000000..ad2f8f2a68
> --- /dev/null
> +++ b/hw/timer/ds-rtc-i2c.c
> @@ -0,0 +1,461 @@
> +/* Emulation of various Dallas/Maxim RTCs accessed via I2C bus
> + *
> + * Copyright (c) 2017 Michael Davidsaver
> + * Copyright (c) 2009 CodeSourcery
> + *
> + * Authors: Michael Davidsaver
> + *          Paul Brook
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the LICENSE file in the top-level directory.
> + *
> + * Models real time read/set and NVRAM.
> + * Does not model alarms, or control/status registers.
> + *
> + * Generalized register map is:
> + *   [Current time]
> + *   [Alarm settings] (optional)
> + *   [Control/Status] (optional)
> + *   [Non-volatile memory] (optional)
> + *
> + * The current time registers are almost always the same,
> + * with the exception being that some have a CENTURY bit
> + * in the month register.
> + */
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/timer.h"
> +#include "qemu/bcd.h"
> +#include "hw/hw.h"
> +#include "hw/registerfields.h"
> +#include "hw/i2c/i2c.h"
> +#include "sysemu/qtest.h"
> +#include "qemu/error-report.h"
> +
> +/* #define DEBUG_DSRTC */
> +
> +#ifdef DEBUG_DSRTC
> +#define DPRINTK(FMT, ...) info_report(TYPE_DSRTC " : " FMT, ## __VA_ARGS=
__)
> +#else
> +#define DPRINTK(FMT, ...) do {} while (0)
> +#endif
> +
> +#define LOG(MSK, FMT, ...) qemu_log_mask(MSK, TYPE_DSRTC " : " FMT "\n",=
 \
> +                            ## __VA_ARGS__)
> +
> +#define DSRTC_REGSIZE (0x40)
> +
> +/* values stored in BCD */
> +/* 00-59 */
> +#define R_SEC   (0x0)
> +/* 00-59 */
> +#define R_MIN   (0x1)
> +#define R_HOUR  (0x2)
> +/* 1-7 */
> +#define R_WDAY  (0x3)
> +/* 0-31 */
> +#define R_DATE  (0x4)
> +#define R_MONTH (0x5)
> +/* 0-99 */
> +#define R_YEAR  (0x6)
> +
> +/* use 12 hour mode when set */
> +FIELD(HOUR, SET12, 6, 1)
> +/* 00-23 */
> +FIELD(HOUR, HOUR24, 0, 6)
> +FIELD(HOUR, AMPM, 5, 1)
> +/* 1-12 (not 0-11!) */
> +FIELD(HOUR, HOUR12, 0, 5)
> +
> +/* 1-12 */
> +FIELD(MONTH, MONTH, 0, 5)
> +FIELD(MONTH, CENTURY, 7, 1)
> +
> +typedef struct DSRTCInfo {
> +    /* if bit 7 of the Month register is set after Y2K */
> +    bool has_century;
> +    /* address of first non-volatile memory cell.
> +     * nv_start >=3D reg_end means no NV memory.
> +     */
> +    uint8_t nv_start;
> +    /* total size of register range.  When address counter rolls over. */
> +    uint8_t reg_size;
> +} DSRTCInfo;
> +
> +typedef struct DSRTCState {
> +    I2CSlave parent_obj;
> +
> +    const DSRTCInfo *info;
> +
> +    qemu_irq alarm_irq;
> +
> +    /* register address counter */
> +    uint8_t addr;
> +    /* when writing, whether the address has been sent */
> +    bool addrd;
> +
> +    int64_t time_offset;
> +    int8_t wday_offset;
> +
> +    uint8_t regs[DSRTC_REGSIZE];
> +} DSRTCState;
> +
> +typedef struct DSRTCClass {
> +    I2CSlaveClass parent_class;
> +
> +    const DSRTCInfo *info;
> +} DSRTCClass;
> +
> +#define TYPE_DSRTC "ds-rtc-i2c"
> +#define DSRTC(obj) OBJECT_CHECK(DSRTCState, (obj), TYPE_DSRTC)
> +#define DSRTC_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(DSRTCClass, obj, TYPE_DSRTC)
> +#define DSRTC_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(DSRTCClass, klass, TYPE_DSRTC)
> +
> +static const VMStateDescription vmstate_dsrtc =3D {
> +    .name =3D TYPE_DSRTC,
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_I2C_SLAVE(parent_obj, DSRTCState),
> +        VMSTATE_INT64(time_offset, DSRTCState),
> +        VMSTATE_INT8_V(wday_offset, DSRTCState, 2),
> +        VMSTATE_UINT8_ARRAY(regs, DSRTCState, DSRTC_REGSIZE),
> +        VMSTATE_UINT8(addr, DSRTCState),
> +        VMSTATE_BOOL(addrd, DSRTCState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void dsrtc_reset(DeviceState *device);
> +
> +/* update current time registers */
> +static
> +void dsrtc_latch(DSRTCState *ds)
> +{
> +    struct tm now;
> +    bool use12;
> +
> +    qemu_get_timedate(&now, ds->time_offset);
> +
> +    DPRINTK("Current Time %3u/%2u/%u %2u:%2u:%2u (wday %u)",
> +            now.tm_year, now.tm_mon, now.tm_mday,
> +            now.tm_hour, now.tm_min, now.tm_sec,
> +            now.tm_wday);
> +
> +    use12 =3D ARRAY_FIELD_EX32(ds->regs, HOUR, SET12);
> +
> +    /* ensure unused bits are zero */
> +    memset(ds->regs, 0, R_YEAR + 1);
> +
> +    ds->regs[R_SEC] =3D to_bcd(now.tm_sec);
> +    ds->regs[R_MIN] =3D to_bcd(now.tm_min);
> +
> +    if (!use12) {
> +        /* 24 hour (0-23) */
> +        ARRAY_FIELD_DP32(ds->regs, HOUR, HOUR24, to_bcd(now.tm_hour));
> +    } else {
> +        /* 12 hour am/pm (1-12) */
> +        ARRAY_FIELD_DP32(ds->regs, HOUR, SET12, 1);
> +        ARRAY_FIELD_DP32(ds->regs, HOUR, AMPM, now.tm_hour >=3D 12u);
> +        ARRAY_FIELD_DP32(ds->regs, HOUR, HOUR12,
> +                         to_bcd(1u + (now.tm_hour % 12u)));
> +    }
> +
> +    ds->regs[R_WDAY] =3D (now.tm_wday + ds->wday_offset) % 7u + 1u;
> +    ds->regs[R_DATE] =3D to_bcd(now.tm_mday);
> +
> +    ARRAY_FIELD_DP32(ds->regs, MONTH, MONTH, to_bcd(now.tm_mon + 1));
> +    if (ds->info->has_century) {
> +        ARRAY_FIELD_DP32(ds->regs, MONTH, CENTURY, now.tm_year >=3D 100u=
);
> +    }
> +
> +    ds->regs[R_YEAR] =3D to_bcd(now.tm_year % 100u);
> +
> +    DPRINTK("Latched time");
> +}
> +
> +/* call after guest writes to current time registers
> + * to re-compute our offset from host time.
> + */
> +static
> +void dsrtc_update(DSRTCState *ds)
> +{
> +    int user_wday;
> +    struct tm now;
> +
> +    now.tm_sec =3D from_bcd(ds->regs[R_SEC]);
> +    now.tm_min =3D from_bcd(ds->regs[R_MIN]);
> +
> +    if (ARRAY_FIELD_EX32(ds->regs, HOUR, SET12)) {
> +        /* 12 hour (1-12) */
> +        now.tm_hour =3D from_bcd(ARRAY_FIELD_EX32(ds->regs, HOUR, HOUR12=
)) - 1u;
> +        if (ARRAY_FIELD_EX32(ds->regs, HOUR, AMPM)) {
> +            now.tm_hour +=3D 12;
> +        }
> +
> +    } else {
> +        /* 23 hour (0-23) */
> +        now.tm_hour =3D from_bcd(ARRAY_FIELD_EX32(ds->regs, HOUR, HOUR24=
));
> +    }
> +
> +    now.tm_wday =3D from_bcd(ds->regs[R_WDAY]) - 1u;
> +    now.tm_mday =3D from_bcd(ds->regs[R_DATE]);
> +    now.tm_mon =3D from_bcd(ARRAY_FIELD_EX32(ds->regs, MONTH, MONTH)) - =
1;
> +
> +    now.tm_year =3D from_bcd(ds->regs[R_YEAR]);
> +    if (ARRAY_FIELD_EX32(ds->regs, MONTH, CENTURY) || !ds->info->has_cen=
tury) {
> +        now.tm_year +=3D 100;
> +    }
> +
> +    DPRINTK("New Time %3u/%2u/%u %2u:%2u:%2u (wday %u)",
> +            now.tm_year, now.tm_mon, now.tm_mday,
> +            now.tm_hour, now.tm_min, now.tm_sec,
> +            now.tm_wday);
> +
> +    /* round trip to get real wday_offset based on time delta */
> +    user_wday =3D now.tm_wday;
> +    ds->time_offset =3D qemu_timedate_diff(&now);
> +    /* race possible if we run at midnight
> +     * TODO: make qemu_timedate_diff() calculate wday offset as well?
> +     */
> +    qemu_get_timedate(&now, ds->time_offset);
> +    /* calculate wday_offset to achieve guest requested wday */
> +    ds->wday_offset =3D user_wday - now.tm_wday;
> +
> +    DPRINTK("Update offset =3D %" PRId64 ", wday_offset =3D %d",
> +            ds->time_offset, ds->wday_offset);
> +}
> +
> +static
> +void dsrtc_advance(DSRTCState *ds)
> +{
> +    ds->addr =3D (ds->addr + 1) % ds->info->reg_size;
> +    if (ds->addr =3D=3D 0) {
> +        /* latch time on roll over */
> +        dsrtc_latch(ds);
> +    }
> +}
> +
> +static
> +int dsrtc_event(I2CSlave *s, enum i2c_event event)
> +{
> +    DSRTCState *ds =3D DSRTC(s);
> +
> +    switch (event) {
> +    case I2C_START_SEND:
> +        ds->addrd =3D false;
> +        /* fall through */
> +    case I2C_START_RECV:
> +        dsrtc_latch(ds);
> +        /* fall through */
> +    case I2C_FINISH:
> +        DPRINTK("Event %d", (int)event);
> +        /* fall through */
> +    case I2C_NACK:
> +        break;
> +    }
> +    return 0;
> +}
> +
> +static
> +int dsrtc_recv(I2CSlave *s)
> +{
> +    DSRTCState *ds =3D DSRTC(s);
> +    int ret =3D 0;
> +
> +    ret =3D ds->regs[ds->addr];
> +
> +    if (ds->addr > R_YEAR && ds->addr < ds->info->nv_start) {
> +        LOG(LOG_UNIMP, "Read from unimplemented (%02x) %02x", ds->addr, =
ret);
> +    }
> +
> +    DPRINTK("Recv (%02x) %02x", ds->addr, ret);
> +
> +    dsrtc_advance(ds);
> +
> +    return ret;
> +}
> +
> +static
> +int dsrtc_send(I2CSlave *s, uint8_t data)
> +{
> +    DSRTCState *ds =3D DSRTC(s);
> +
> +    if (!ds->addrd) {
> +        if (data =3D=3D 0xff && qtest_enabled()) {
> +            /* allow test runner to zero offsets */
> +            DPRINTK("Testing reset");
> +            dsrtc_reset(DEVICE(s));
> +            return 0;
> +        }
> +        ds->addr =3D data % DSRTC_REGSIZE;
> +        ds->addrd =3D true;
> +        DPRINTK("Set address pointer %02x", data);
> +        return 0;
> +    }
> +
> +    DPRINTK("Send (%02x) %02x", ds->addr, data);
> +
> +    if (ds->addr <=3D R_YEAR) {
> +        ds->regs[ds->addr] =3D data;
> +        dsrtc_update(ds);
> +
> +    } else if (ds->addr >=3D ds->info->nv_start) {
> +        ds->regs[ds->addr] =3D data;
> +
> +    } else {
> +        LOG(LOG_UNIMP, "Register not modeled");
> +    }
> +
> +    dsrtc_advance(ds);
> +
> +    return 0;
> +}
> +
> +static
> +void dsrtc_reset(DeviceState *device)
> +{
> +    DSRTCState *ds =3D DSRTC(device);
> +
> +    memset(ds->regs, 0, sizeof(ds->regs));
> +
> +    ds->addr =3D 0;
> +    ds->addrd =3D false;
> +    ds->time_offset =3D 0;
> +    ds->wday_offset =3D 0;
> +
> +    DPRINTK("Reset");
> +}
> +
> +static
> +void dsrtc_realize(DeviceState *device, Error **errp)
> +{
> +    DSRTCState *ds =3D DSRTC(device);
> +    DSRTCClass *r =3D DSRTC_GET_CLASS(device);
> +
> +    ds->info =3D r->info;
> +
> +    /* Alarms not yet implemented, but allow
> +     * board code to wire up the alarm interrupt
> +     * output anyway.
> +     */
> +    qdev_init_gpio_out(device, &ds->alarm_irq, 1);
> +}
> +
> +static
> +void dsrtc_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
> +    DSRTCClass *r =3D DSRTC_CLASS(klass);
> +
> +    r->info =3D data;
> +
> +    k->event =3D &dsrtc_event;
> +    k->recv =3D &dsrtc_recv;
> +    k->send =3D &dsrtc_send;
> +
> +    dc->vmsd =3D &vmstate_dsrtc;
> +    dc->realize =3D dsrtc_realize;
> +    dc->reset =3D dsrtc_reset;
> +    dc->user_creatable =3D true;
> +}
> +
> +static
> +const TypeInfo ds_rtc_base_type =3D {
> +    .abstract =3D true,
> +    .name =3D TYPE_DSRTC,
> +    .parent =3D TYPE_I2C_SLAVE,
> +    .instance_size =3D sizeof(DSRTCState),
> +};
> +
> +#define DSRTC_CONFIG(NAME) \
> +static const TypeInfo NAME##_type =3D { \
> +    .name =3D #NAME, \
> +    .parent =3D TYPE_DSRTC, \
> +    .class_size =3D sizeof(I2CSlaveClass), \
> +    .class_init =3D dsrtc_class_init, \
> +    .class_data =3D (void *)&NAME##_info, \
> +};
> +
> +/* ds3231 - alarms, no eeprom */
> +static const DSRTCInfo ds3231_info =3D {
> +    .has_century =3D true,
> +    .nv_start    =3D 0x13, /* no nv memory */
> +    .reg_size    =3D 0x13,
> +};
> +DSRTC_CONFIG(ds3231)
> +
> +/* only model block 0 (RTC), blocks 1,2 (eeprom) not modeled.
> + * blocks have different i2c addresses
> + */
> +static const DSRTCInfo ds1388_info =3D {
> +    .has_century =3D false,
> +    .nv_start    =3D 0x0d,
> +    .reg_size    =3D 0x0d,
> +};
> +DSRTC_CONFIG(ds1388)
> +
> +/* alarms, eeprom */
> +static const DSRTCInfo ds1375_info =3D {
> +    .has_century =3D true,
> +    .nv_start    =3D 0x10,
> +    .reg_size    =3D 0x20,
> +};
> +DSRTC_CONFIG(ds1375)
> +
> +/* no alarms, no eeprom */
> +static const DSRTCInfo ds1340_info =3D {
> +    .has_century =3D false,
> +    .nv_start    =3D 0x10,
> +    .reg_size    =3D 0x10,
> +};
> +DSRTC_CONFIG(ds1340)
> +
> +/* alarms, no eeprom */
> +static const DSRTCInfo ds1339_info =3D {
> +    .has_century =3D false,
> +    .nv_start    =3D 0x11,
> +    .reg_size    =3D 0x11,
> +};
> +DSRTC_CONFIG(ds1339)
> +
> +/* no alarms, eeprom */
> +static const DSRTCInfo ds1338_info =3D {
> +    .has_century =3D false,
> +    .nv_start    =3D 0x08,
> +    .reg_size    =3D 0x40,
> +};
> +DSRTC_CONFIG(ds1338)
> +
> +/* alarms, no eeprom */
> +static const DSRTCInfo ds1337_info =3D {
> +    .has_century =3D true,
> +    .nv_start    =3D 0x10,
> +    .reg_size    =3D 0x10,
> +};
> +DSRTC_CONFIG(ds1337)
> +
> +/* ds1307 registers are identical to ds1338 */
> +static
> +const TypeInfo ds1307_type =3D {
> +    .name =3D "ds1307",
> +    .parent =3D "ds1338",
> +};
> +
> +static void ds_rtc_i2c_register(void)
> +{
> +    type_register_static(&ds_rtc_base_type);
> +    type_register_static(&ds3231_type);
> +    type_register_static(&ds1388_type);
> +    type_register_static(&ds1375_type);
> +    type_register_static(&ds1340_type);
> +    type_register_static(&ds1339_type);
> +    type_register_static(&ds1338_type);
> +    type_register_static(&ds1337_type);
> +    type_register_static(&ds1307_type);
> +}
> +
> +type_init(ds_rtc_i2c_register)
> diff --git a/hw/timer/ds1338.c b/hw/timer/ds1338.c
> deleted file mode 100644
> index 3849b74a68..0000000000
> --- a/hw/timer/ds1338.c
> +++ /dev/null
> @@ -1,239 +0,0 @@
> -/*
> - * MAXIM DS1338 I2C RTC+NVRAM
> - *
> - * Copyright (c) 2009 CodeSourcery.
> - * Written by Paul Brook
> - *
> - * This code is licensed under the GNU GPL v2.
> - *
> - * Contributions after 2012-01-13 are licensed under the terms of the
> - * GNU GPL, version 2 or (at your option) any later version.
> - */
> -
> -#include "qemu/osdep.h"
> -#include "qemu-common.h"
> -#include "hw/i2c/i2c.h"
> -#include "qemu/bcd.h"
> -
> -/* Size of NVRAM including both the user-accessible area and the
> - * secondary register area.
> - */
> -#define NVRAM_SIZE 64
> -
> -/* Flags definitions */
> -#define SECONDS_CH 0x80
> -#define HOURS_12   0x40
> -#define HOURS_PM   0x20
> -#define CTRL_OSF   0x20
> -
> -#define TYPE_DS1338 "ds1338"
> -#define DS1338(obj) OBJECT_CHECK(DS1338State, (obj), TYPE_DS1338)
> -
> -typedef struct DS1338State {
> -    I2CSlave parent_obj;
> -
> -    int64_t offset;
> -    uint8_t wday_offset;
> -    uint8_t nvram[NVRAM_SIZE];
> -    int32_t ptr;
> -    bool addr_byte;
> -} DS1338State;
> -
> -static const VMStateDescription vmstate_ds1338 =3D {
> -    .name =3D "ds1338",
> -    .version_id =3D 2,
> -    .minimum_version_id =3D 1,
> -    .fields =3D (VMStateField[]) {
> -        VMSTATE_I2C_SLAVE(parent_obj, DS1338State),
> -        VMSTATE_INT64(offset, DS1338State),
> -        VMSTATE_UINT8_V(wday_offset, DS1338State, 2),
> -        VMSTATE_UINT8_ARRAY(nvram, DS1338State, NVRAM_SIZE),
> -        VMSTATE_INT32(ptr, DS1338State),
> -        VMSTATE_BOOL(addr_byte, DS1338State),
> -        VMSTATE_END_OF_LIST()
> -    }
> -};
> -
> -static void capture_current_time(DS1338State *s)
> -{
> -    /* Capture the current time into the secondary registers
> -     * which will be actually read by the data transfer operation.
> -     */
> -    struct tm now;
> -    qemu_get_timedate(&now, s->offset);
> -    s->nvram[0] =3D to_bcd(now.tm_sec);
> -    s->nvram[1] =3D to_bcd(now.tm_min);
> -    if (s->nvram[2] & HOURS_12) {
> -        int tmp =3D now.tm_hour;
> -        if (tmp % 12 =3D=3D 0) {
> -            tmp +=3D 12;
> -        }
> -        if (tmp <=3D 12) {
> -            s->nvram[2] =3D HOURS_12 | to_bcd(tmp);
> -        } else {
> -            s->nvram[2] =3D HOURS_12 | HOURS_PM | to_bcd(tmp - 12);
> -        }
> -    } else {
> -        s->nvram[2] =3D to_bcd(now.tm_hour);
> -    }
> -    s->nvram[3] =3D (now.tm_wday + s->wday_offset) % 7 + 1;
> -    s->nvram[4] =3D to_bcd(now.tm_mday);
> -    s->nvram[5] =3D to_bcd(now.tm_mon + 1);
> -    s->nvram[6] =3D to_bcd(now.tm_year - 100);
> -}
> -
> -static void inc_regptr(DS1338State *s)
> -{
> -    /* The register pointer wraps around after 0x3F; wraparound
> -     * causes the current time/date to be retransferred into
> -     * the secondary registers.
> -     */
> -    s->ptr =3D (s->ptr + 1) & (NVRAM_SIZE - 1);
> -    if (!s->ptr) {
> -        capture_current_time(s);
> -    }
> -}
> -
> -static int ds1338_event(I2CSlave *i2c, enum i2c_event event)
> -{
> -    DS1338State *s =3D DS1338(i2c);
> -
> -    switch (event) {
> -    case I2C_START_RECV:
> -        /* In h/w, capture happens on any START condition, not just a
> -         * START_RECV, but there is no need to actually capture on
> -         * START_SEND, because the guest can't get at that data
> -         * without going through a START_RECV which would overwrite it.
> -         */
> -        capture_current_time(s);
> -        break;
> -    case I2C_START_SEND:
> -        s->addr_byte =3D true;
> -        break;
> -    default:
> -        break;
> -    }
> -
> -    return 0;
> -}
> -
> -static int ds1338_recv(I2CSlave *i2c)
> -{
> -    DS1338State *s =3D DS1338(i2c);
> -    uint8_t res;
> -
> -    res  =3D s->nvram[s->ptr];
> -    inc_regptr(s);
> -    return res;
> -}
> -
> -static int ds1338_send(I2CSlave *i2c, uint8_t data)
> -{
> -    DS1338State *s =3D DS1338(i2c);
> -
> -    if (s->addr_byte) {
> -        s->ptr =3D data & (NVRAM_SIZE - 1);
> -        s->addr_byte =3D false;
> -        return 0;
> -    }
> -    if (s->ptr < 7) {
> -        /* Time register. */
> -        struct tm now;
> -        qemu_get_timedate(&now, s->offset);
> -        switch(s->ptr) {
> -        case 0:
> -            /* TODO: Implement CH (stop) bit.  */
> -            now.tm_sec =3D from_bcd(data & 0x7f);
> -            break;
> -        case 1:
> -            now.tm_min =3D from_bcd(data & 0x7f);
> -            break;
> -        case 2:
> -            if (data & HOURS_12) {
> -                int tmp =3D from_bcd(data & (HOURS_PM - 1));
> -                if (data & HOURS_PM) {
> -                    tmp +=3D 12;
> -                }
> -                if (tmp % 12 =3D=3D 0) {
> -                    tmp -=3D 12;
> -                }
> -                now.tm_hour =3D tmp;
> -            } else {
> -                now.tm_hour =3D from_bcd(data & (HOURS_12 - 1));
> -            }
> -            break;
> -        case 3:
> -            {
> -                /* The day field is supposed to contain a value in
> -                   the range 1-7. Otherwise behavior is undefined.
> -                 */
> -                int user_wday =3D (data & 7) - 1;
> -                s->wday_offset =3D (user_wday - now.tm_wday + 7) % 7;
> -            }
> -            break;
> -        case 4:
> -            now.tm_mday =3D from_bcd(data & 0x3f);
> -            break;
> -        case 5:
> -            now.tm_mon =3D from_bcd(data & 0x1f) - 1;
> -            break;
> -        case 6:
> -            now.tm_year =3D from_bcd(data) + 100;
> -            break;
> -        }
> -        s->offset =3D qemu_timedate_diff(&now);
> -    } else if (s->ptr =3D=3D 7) {
> -        /* Control register. */
> -
> -        /* Ensure bits 2, 3 and 6 will read back as zero. */
> -        data &=3D 0xB3;
> -
> -        /* Attempting to write the OSF flag to logic 1 leaves the
> -           value unchanged. */
> -        data =3D (data & ~CTRL_OSF) | (data & s->nvram[s->ptr] & CTRL_OS=
F);
> -
> -        s->nvram[s->ptr] =3D data;
> -    } else {
> -        s->nvram[s->ptr] =3D data;
> -    }
> -    inc_regptr(s);
> -    return 0;
> -}
> -
> -static void ds1338_reset(DeviceState *dev)
> -{
> -    DS1338State *s =3D DS1338(dev);
> -
> -    /* The clock is running and synchronized with the host */
> -    s->offset =3D 0;
> -    s->wday_offset =3D 0;
> -    memset(s->nvram, 0, NVRAM_SIZE);
> -    s->ptr =3D 0;
> -    s->addr_byte =3D false;
> -}
> -
> -static void ds1338_class_init(ObjectClass *klass, void *data)
> -{
> -    DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
> -
> -    k->event =3D ds1338_event;
> -    k->recv =3D ds1338_recv;
> -    k->send =3D ds1338_send;
> -    dc->reset =3D ds1338_reset;
> -    dc->vmsd =3D &vmstate_ds1338;
> -}
> -
> -static const TypeInfo ds1338_info =3D {
> -    .name          =3D TYPE_DS1338,
> -    .parent        =3D TYPE_I2C_SLAVE,
> -    .instance_size =3D sizeof(DS1338State),
> -    .class_init    =3D ds1338_class_init,
> -};
> -
> -static void ds1338_register_types(void)
> -{
> -    type_register_static(&ds1338_info);
> -}
> -
> -type_init(ds1338_register_types)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--m1G908gh+QHqN0Gd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlofk2sACgkQbDjKyiDZ
s5K4ARAAmSDmuaIW34FopI+SOPGClopcxiaRNtGkDzcqElGP9SAEC1YDDXvjIqqA
3yLVT0Ouc2ZtLv2P/5xnxtOg8slQevyt99Scs6OYOycvtfXj9KdYjKSrpcfbr332
DN8HYrh4zptLAm+MaeReqVFmJ76Ne0XxANhzYVF2UPDplinGSF65H7WuHpVX8Is7
yYWk1hAzorQlQKIAgmbWjGnlWSuBwKiHQutMwI5dv0ONsBuMEJddiEakZUs7jQVO
mOCd0jZLlx3UIUSWv9RWPBJgq3tGzZtETdo1kpuxEzRH3JkGtWvYqSz8tY1nmFmC
8TrkAw/mGX9w1Zua3NrQLY/bu4ojfyfF7w8SGkd8wjd2+I2SUZDz/S5vYw8Cc16i
BS9rVDUlvdpOyPiHFxeuVKLjH1/1HxiBrZSG79wheR97UVhBDhXm2aaM1urdzjYN
cYNxDMTdTHlkH3efo6BkdCM2lWzWI2y0tu+aZVHYVZP/+h4B+FDFIoi0Hgku60HF
TDwH2xNFCOcai7KNeNq317eRlM1VjcZAe/SE5xid1oM55XglRESAOoN3ahaXp1Im
Sp/9k4XkVwPerOwRVNKSx7z42MQrUdbXMXijFFmmQvg6ivavxdcfYVwj5If2Jnq/
9N53/dI9SDzB6I+TVN4T7Cxi7qbPdLioA/fiH2nr7V9cBfAhwr0=
=DQ/V
-----END PGP SIGNATURE-----

--m1G908gh+QHqN0Gd--
