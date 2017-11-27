Received: from eggs.gnu.org ([2001:4830:134:3::10]:58046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eJOij-0006OB-8Z
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 14:05:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eJOig-0002Yu-1p
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 14:05:33 -0500
References: <cover.1511731946.git.mdavidsaver@gmail.com>
	<92ee0ce46b0de7d60e3d7f053cc25f4dec20135c.1511731946.git.mdavidsaver@gmail.com>
	<20171127071228.GE11775@umbus.fritz.box>
From: Michael Davidsaver <mdavidsaver@gmail.com>
Message-ID: <a0ae1aea-c90d-aada-00db-8b90f3adc2c7@gmail.com>
Date: Mon, 27 Nov 2017 13:05:11 -0600
MIME-Version: 1.0
In-Reply-To: <20171127071228.GE11775@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8f7gNFKtkHHah5J5xqQcKtbR0BU0lRsuc"
Subject: Re: [Qemu-devel] [PATCH 03/17] i2c: add mpc8540 i2c controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8f7gNFKtkHHah5J5xqQcKtbR0BU0lRsuc
From: Michael Davidsaver <mdavidsaver@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Message-ID: <a0ae1aea-c90d-aada-00db-8b90f3adc2c7@gmail.com>
Subject: Re: [PATCH 03/17] i2c: add mpc8540 i2c controller
References: <cover.1511731946.git.mdavidsaver@gmail.com>
 <92ee0ce46b0de7d60e3d7f053cc25f4dec20135c.1511731946.git.mdavidsaver@gmail.com>
 <20171127071228.GE11775@umbus.fritz.box>
In-Reply-To: <20171127071228.GE11775@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 11/27/2017 01:12 AM, David Gibson wrote:
> On Sun, Nov 26, 2017 at 03:59:01PM -0600, Michael Davidsaver wrote:
>> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
>> ---
>>  hw/i2c/Makefile.objs |   1 +
>>  hw/i2c/mpc8540_i2c.c | 307 ++++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  hw/i2c/trace-events  |   6 +
>>  3 files changed, 314 insertions(+)
>>  create mode 100644 hw/i2c/mpc8540_i2c.c
>>
>> diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
>> index 0594dea3ae..79af1dd901 100644
>> --- a/hw/i2c/Makefile.objs
>> +++ b/hw/i2c/Makefile.objs
>> @@ -9,3 +9,4 @@ common-obj-$(CONFIG_IMX_I2C) +=3D imx_i2c.o
>>  common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_i2c.o
>>  obj-$(CONFIG_OMAP) +=3D omap_i2c.o
>>  obj-$(CONFIG_PPC4XX) +=3D ppc4xx_i2c.o
>> +obj-$(CONFIG_E500) +=3D mpc8540_i2c.o
>> diff --git a/hw/i2c/mpc8540_i2c.c b/hw/i2c/mpc8540_i2c.c
>> new file mode 100644
>> index 0000000000..b9f5773b35
>> --- /dev/null
>> +++ b/hw/i2c/mpc8540_i2c.c
>> @@ -0,0 +1,307 @@
>> +/*
>> + * MPC8540 I2C bus interface
>> + * As described in
>> + * MPC8540 PowerQUICC III Integrated Host Processor Reference Manual,=
 Rev. 1
>> + * Part 2 chapter 11
>> + *
>> + * Compatible I2C controllers are found on other Freescale chips
>> + * including mpc8544 and P2010.
>> + *
>> + * Copyright (c) 2015 Michael Davidsaver
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2.  =
See
>> + * the LICENSE file in the top-level directory.
>> + */
>> +#include "qemu/osdep.h"
>> +#include "qemu/log.h"
>> +#include "hw/hw.h"
>> +#include "hw/registerfields.h"
>> +#include "hw/i2c/i2c.h"
>> +#include "hw/sysbus.h"
>> +#include "qemu/error-report.h"
>> +
>> +#include "trace.h"
>> +
>> +/* #define DEBUG_LVL 0 */
>> +
>> +#ifdef DEBUG_LVL
>> +#define DPRINTK(LVL, FMT, ...) do { \
>> +    if ((LVL) <=3D DEBUG_LVL) {\
>> +        info_report(TYPE_MPC8540_I2C " : " FMT, ## __VA_ARGS__); \
>> +    } } while (0)
>> +#else
>> +#define DPRINTK(LVL, FMT, ...) do {} while (0)
>> +#endif
>=20
> So, you have both this DPRINTK stuff, and some trace events, which
> seems a bit odd?  Why not just one or the other.

My thinking is to have trace events for the commonly used points (by me a=
t least)
for troubleshooting devices on the i2c bus, but leave the others for trou=
bleshooting
the i2c controller itself as DPRINTK.

So this is mainly my laziness in not seeing sufficient benefit to definin=
g events for the
remaining 5 DPRINTK s.

>> +
>> +#define LOG(MSK, FMT, ...) qemu_log_mask(MSK, TYPE_MPC8540_I2C \
>> +    " : " FMT "\n", ## __VA_ARGS__)
>> +
>> +#define TYPE_MPC8540_I2C "mpc8540-i2c"
>> +#define MPC8540_I2C(obj) OBJECT_CHECK(MPC8540I2CState, (obj), TYPE_MP=
C8540_I2C)
>> +
>> +/* offsets relative to CCSR offset 0x3000 */
>> +#define R_I2CADR (0)
>> +#define R_I2CFDR (4)
>> +#define R_I2CCR  (8)
>> +#define R_I2CSR  (0xc)
>> +#define R_I2CDR  (0x10)
>> +#define R_I2CDFSRR (0x14)
>> +
>> +FIELD(I2CCR, MEN, 7, 1)
>> +FIELD(I2CCR, MIEN, 6, 1)
>> +FIELD(I2CCR, MSTA, 5, 1)
>> +FIELD(I2CCR, MTX, 4, 1)
>> +FIELD(I2CCR, TXAK, 3, 1)
>> +FIELD(I2CCR, RSTA, 2, 1)
>> +FIELD(I2CCR, BCST, 0, 1)
>> +
>> +FIELD(I2CSR, MCF, 7, 1)
>> +FIELD(I2CSR, MAAS, 6, 1)
>> +FIELD(I2CSR, MBB, 5, 1)
>> +FIELD(I2CSR, MAL, 4, 1)
>> +FIELD(I2CSR, BCSTM, 3, 1)
>> +FIELD(I2CSR, SRW, 2, 1)
>> +FIELD(I2CSR, MIF, 1, 1)
>> +FIELD(I2CSR, RXAK, 0, 1)
>> +
>> +typedef struct MPC8540I2CState {
>> +    SysBusDevice parent_obj;
>> +
>> +    I2CBus *bus;
>> +
>> +    uint8_t ctrl, sts;
>> +    uint8_t freq, filt;
>> +    /* Reads are pipelined, this is the next data value */
>> +    uint8_t dbuf, dbuf_valid;
>> +
>> +    qemu_irq irq;
>> +
>> +    MemoryRegion mmio;
>> +} MPC8540I2CState;
>> +
>> +#define I2CCR(BIT) FIELD_EX32(i2c->ctrl, I2CCR, BIT)
>> +#define I2CSR(BIT) FIELD_EX32(i2c->sts, I2CSR, BIT)
>> +
>> +#define I2CSR_SET(BIT, VAL) do {\
>> +        i2c->sts =3D FIELD_DP32(i2c->sts, I2CSR, BIT, VAL);\
>> +    } while (0)
>> +
>> +static
>> +void mpc8540_update_irq(MPC8540I2CState *i2c)
>> +{
>> +    int ena =3D i2c->ctrl & 0x40,
>> +        sts =3D i2c->sts & 0x02,
>> +        act =3D !!(ena && sts);
>> +
>> +    DPRINTK(1, "IRQ %c ena %c sts %c",
>> +            act ? 'X' : '_',
>> +            ena ? 'X' : '_',
>> +            sts ? 'X' : '_');
>> +
>> +    qemu_set_irq(i2c->irq, act);
>> +}
>> +
>> +static
>> +uint64_t mpc8540_i2c_read(void *opaque, hwaddr addr, unsigned size)
>> +{
>> +    MPC8540I2CState *i2c =3D opaque;
>> +    uint32_t val;
>> +
>> +    switch (addr) {
>> +    case R_I2CADR: /* ADDR */
>> +        val =3D 0;
>> +        break;
>> +    case R_I2CFDR: /* Freq Div. */
>> +        val =3D i2c->freq;
>> +        break;
>> +    case R_I2CCR: /* CONTROL */
>> +        val =3D i2c->ctrl & ~0x06;
>> +        break;
>> +    case R_I2CSR: /* STATUS */
>> +        val =3D i2c->sts;
>> +        break;
>> +    case R_I2CDR: /* DATA */
>> +        /* Reads are "pipelined" and so return the previous value of =
the
>> +         * register
>> +         */
>> +        val =3D i2c->dbuf;
>> +        if (I2CCR(MEN) && I2CSR(MBB)) { /* enabled and busy */
>> +            if (!i2c_bus_busy(i2c->bus) || I2CCR(MTX)) {
>> +                if (!i2c->dbuf_valid) {
>> +                    LOG(LOG_GUEST_ERROR, "Read during addr or tx");
>> +                }
>> +                i2c->dbuf =3D 0xff;
>> +                i2c->dbuf_valid =3D false;
>> +            } else {
>> +                int ret =3D i2c_recv(i2c->bus);
>> +                i2c->dbuf =3D (uint8_t)ret;
>> +                i2c->dbuf_valid =3D true;
>> +                trace_mpc8540_i2c_read(i2c->dbuf);
>> +                I2CSR_SET(MIF, 1);
>> +                I2CSR_SET(RXAK, 0);
>> +                mpc8540_update_irq(i2c);
>> +            }
>> +        } else {
>> +            i2c->dbuf =3D 0xff;
>> +            i2c->dbuf_valid =3D false;
>> +            LOG(LOG_GUEST_ERROR, "Read when not enabled or busy");
>> +        }
>> +        break;
>> +    case R_I2CDFSRR: /* FILTER */
>> +        val =3D i2c->filt;
>> +        break;
>> +    default:
>> +        val =3D 0xff;
>> +    }
>> +
>> +    DPRINTK(addr =3D=3D 0xc ? 2 : 1, " read %08x -> %08x",
>> +            (unsigned)addr, (unsigned)val);
>> +    return val;
>> +}
>> +
>> +static
>> +void mpc8540_i2c_write(void *opaque, hwaddr addr, uint64_t val, unsig=
ned size)
>> +{
>> +    MPC8540I2CState *i2c =3D opaque;
>> +
>> +    DPRINTK(1, " write %08x <- %08x", (unsigned)addr, (unsigned)val);=

>> +
>> +    switch (addr) {
>> +    case R_I2CADR: /* ADDR */
>> +        break;
>> +    case R_I2CFDR: /* Freq Div. */
>> +        i2c->freq =3D val & 0x3f;
>> +        break;
>> +    case R_I2CCR: /* CONTROL CCR */
>> +        if (!FIELD_EX32(val, I2CCR, MEN)) {
>> +            DPRINTK(0, "Not Enabled");
>> +
>> +        } else if (!I2CCR(MSTA) && FIELD_EX32(val, I2CCR, MSTA)) {
>> +            /* MSTA 0 -> 1 is START */
>> +
>> +            I2CSR_SET(MBB, 1);
>> +            if (I2CCR(MTX)) {
>> +                trace_mpc8540_i2c_event("START Tx");
>> +            } else {
>> +                trace_mpc8540_i2c_event("START Rx");
>> +            }
>> +            i2c_end_transfer(i2c->bus); /* paranoia */
>> +
>> +        } else if (I2CCR(MSTA) && !FIELD_EX32(val, I2CCR, MSTA)) {
>> +            /* MSTA 1 -> 0 is STOP */
>> +
>> +            I2CSR_SET(MBB, 0);
>> +            trace_mpc8540_i2c_event("STOP");
>> +            i2c_end_transfer(i2c->bus);
>> +
>> +        } else if (I2CCR(MSTA) && FIELD_EX32(val, I2CCR, RSTA)) {
>> +            i2c_end_transfer(i2c->bus);
>> +            I2CSR_SET(MBB, 1);
>> +            if (I2CCR(MTX)) {
>> +                trace_mpc8540_i2c_event("REPEAT START Tx");
>> +            } else {
>> +                trace_mpc8540_i2c_event("REPEAT START Rx");
>> +            }
>> +
>> +        }
>> +        /* RSTA always reads zero, bit 1 unusd */
>> +        val &=3D 0xf9;
>> +        i2c->ctrl =3D val;
>> +        mpc8540_update_irq(i2c);
>> +        break;
>> +    case R_I2CSR: /* STATUS CSR */
>> +        /* only MAL and MIF are writable */
>> +        val &=3D 0x12;
>> +        i2c->sts &=3D ~0x12;
>> +        i2c->sts |=3D val;
>> +        mpc8540_update_irq(i2c);
>> +        break;
>> +    case R_I2CDR: /* DATA CDR */
>> +        if (I2CCR(MEN) && I2CSR(MBB)) { /* enabled and busy */
>> +            if (!i2c_bus_busy(i2c->bus)) {
>> +                if (i2c_start_transfer(i2c->bus, val >> 1, val & 1)) =
{
>> +                    LOG(LOG_GUEST_ERROR, "I2C no device %02x",
>> +                        (unsigned)(val & 0xfe));
>> +                } else {
>> +                    trace_mpc8540_i2c_address((unsigned)(val & 0xfe),=

>> +                                              (val & 0x1) ? 'R' : 'T'=
);
>> +                }
>> +                I2CSR_SET(MIF, 1);
>> +                I2CSR_SET(RXAK, 0);
>> +
>> +            } else if (I2CCR(MTX)) {
>> +                trace_mpc8540_i2c_write((unsigned)val);
>> +                i2c_send(i2c->bus, val);
>> +                I2CSR_SET(MIF, 1);
>> +                I2CSR_SET(RXAK, 0);
>> +            } else {
>> +                LOG(LOG_GUEST_ERROR, "I2CDR Write during read");
>> +            }
>> +            mpc8540_update_irq(i2c);
>> +        } else {
>> +            LOG(LOG_GUEST_ERROR, "I2CDR Write when not enabled or bus=
y");
>> +        }
>> +        break;
>> +    case R_I2CDFSRR: /* FILTER */
>> +        val &=3D 0x3f;
>> +        i2c->filt =3D val;
>> +        break;
>> +    }
>> +
>> +    DPRINTK(1, "I2CCR =3D %02x I2SCR =3D %02x", i2c->ctrl, i2c->sts);=

>> +}
>> +
>> +static const MemoryRegionOps i2c_ops =3D {
>> +    .read =3D mpc8540_i2c_read,
>> +    .write =3D mpc8540_i2c_write,
>> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
>> +    .impl =3D {
>> +        .min_access_size =3D 1,
>> +        .max_access_size =3D 1,
>> +    },
>> +};
>> +
>> +static
>> +void mpc8540_i2c_reset(DeviceState *dev)
>> +{
>> +    MPC8540I2CState *i2c =3D MPC8540_I2C(dev);
>> +
>> +    i2c->sts =3D 0x81; /* transfer complete and ack received */
>> +    i2c->dbuf_valid =3D false;
>> +}
>> +
>> +static void mpc8540_i2c_inst_init(DeviceState *dev, Error **errp)
>> +{
>> +    MPC8540I2CState *i2c =3D MPC8540_I2C(dev);
>> +
>> +    i2c->bus =3D i2c_init_bus(dev, "bus");
>> +
>> +    memory_region_init_io(&i2c->mmio, OBJECT(dev),
>> +                          &i2c_ops, i2c, TYPE_MPC8540_I2C, 0x18);
>> +
>> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &i2c->mmio);
>> +    sysbus_init_irq(SYS_BUS_DEVICE(dev), &i2c->irq);
>> +}
>=20
> As someone pointed out on the earlier version, this stuff needs to go
> into a realize() function rather than instance_init - instance_init is
> called too early to go safely constructing and installing memory
> regions.

In fact I did (see "dc->realize" below), but apparently managed to change=
 the argument list
without thinking to re-name the function.  I will do so now...

>> +
>> +static void mpc8540_i2c_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +
>> +    dc->realize =3D &mpc8540_i2c_inst_init;
>> +    dc->reset =3D &mpc8540_i2c_reset;
>> +}
>> +
>> +static const TypeInfo mpc8540_i2c_type =3D {
>> +    .name =3D TYPE_MPC8540_I2C,
>> +    .parent =3D TYPE_SYS_BUS_DEVICE,
>> +    .instance_size =3D sizeof(MPC8540I2CState),
>> +    .class_size =3D sizeof(SysBusDeviceClass),
>> +    .class_init =3D mpc8540_i2c_class_init,
>> +};
>> +
>> +static void mpc8540_i2c_register(void)
>> +{
>> +    type_register_static(&mpc8540_i2c_type);
>> +}
>> +
>> +type_init(mpc8540_i2c_register)
>> diff --git a/hw/i2c/trace-events b/hw/i2c/trace-events
>> index 9284b1fbad..ac38d76984 100644
>> --- a/hw/i2c/trace-events
>> +++ b/hw/i2c/trace-events
>> @@ -1 +1,7 @@
>>  # See docs/devel/tracing.txt for syntax documentation.
>> +
>> +# hw/i2c/mpc8540_i2c.c
>> +mpc8540_i2c_event(const char *evt) "Bus Event %s"
>> +mpc8540_i2c_address(uint8_t addr, const char direction) "Address devi=
ce 0x%02x for %cX"
>> +mpc8540_i2c_write(uint8_t byte) "Write 0x%02x"
>> +mpc8540_i2c_read(uint8_t byte) "Read 0x%02x"
>=20



--8f7gNFKtkHHah5J5xqQcKtbR0BU0lRsuc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEYyRdrpxuENu06SOrlAHmyz1/GOoFAlocYegACgkQlAHmyz1/
GOoMlA//Yd4XSgZBiEna5IGgkSJ6w23ai2Andbj04duYhwRshtst1MbRHXxAA/EQ
GLt+OPdi4RxX/Y6W5mQtzyBW2TRnQwO7QCiV/RGF17Hrm977s5nT18T9aEHkg9uL
IKpl4jZDh6vD4ZFgDYZGKNcKJtDdffvWvxEo8AxuiOmbrUzrRE2LVLk3N+J0UPmH
0x4h1sGuH5x+qCPCFgiG+T723wbhLI8qIlfuExwmtOG0HHZt4DPtRn/lrBsK3Qq2
wDLi7WTBJPJaoFJmDnF+KfvvAWJ4V+9u+bGQVt9MYz1O0i2109BHNn+pKdv1Sb9m
7Am8O1S8IUlXw870OsAdyA9HJW8bIWAqJLUIXV6gh/8zZuAsrUefkiNIaNLUvwLW
YIKhsdC93ah0mvkHTKBhu/duV9NrzCBHliVfwZ5G7ik3I/f4zdr2beVNZDPoL4ex
jxbHJlOz5+cI8H70aD5rIFo/gDEkZXK6r3gb4vBwCD0pptKQQ0JcwBPYNPxUsZ7D
W8NvkIdbhAf89/RuJnhyB6AEzIah+VE/4zUDBPi5BSlw6G9RCWotAVamzcWP+odV
4fyrg7E9qPR0ZV8+qEJmHh/mGnyADkOlmkKPnXCADZMNxLCioue9LyoHKF6x42m9
RR+IwisPn354OcodxuWP6cSNMOSe9V3MZN+zmCc4Shba8NsKKoE=
=IygW
-----END PGP SIGNATURE-----

--8f7gNFKtkHHah5J5xqQcKtbR0BU0lRsuc--
