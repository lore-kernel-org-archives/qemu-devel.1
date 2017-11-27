Received: from eggs.gnu.org ([2001:4830:134:3::10]:45340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJE02-0008Cc-NI
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 02:38:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJE00-00005S-Ph
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 02:38:42 -0500
Date: Mon, 27 Nov 2017 18:12:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171127071228.GE11775@umbus.fritz.box>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
	<92ee0ce46b0de7d60e3d7f053cc25f4dec20135c.1511731946.git.mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gMR3gsNFwZpnI/Ts"
Content-Disposition: inline
In-Reply-To: <92ee0ce46b0de7d60e3d7f053cc25f4dec20135c.1511731946.git.mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 03/17] i2c: add mpc8540 i2c controller
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


--gMR3gsNFwZpnI/Ts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 26, 2017 at 03:59:01PM -0600, Michael Davidsaver wrote:
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> ---
>  hw/i2c/Makefile.objs |   1 +
>  hw/i2c/mpc8540_i2c.c | 307 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/i2c/trace-events  |   6 +
>  3 files changed, 314 insertions(+)
>  create mode 100644 hw/i2c/mpc8540_i2c.c
>=20
> diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
> index 0594dea3ae..79af1dd901 100644
> --- a/hw/i2c/Makefile.objs
> +++ b/hw/i2c/Makefile.objs
> @@ -9,3 +9,4 @@ common-obj-$(CONFIG_IMX_I2C) +=3D imx_i2c.o
>  common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_i2c.o
>  obj-$(CONFIG_OMAP) +=3D omap_i2c.o
>  obj-$(CONFIG_PPC4XX) +=3D ppc4xx_i2c.o
> +obj-$(CONFIG_E500) +=3D mpc8540_i2c.o
> diff --git a/hw/i2c/mpc8540_i2c.c b/hw/i2c/mpc8540_i2c.c
> new file mode 100644
> index 0000000000..b9f5773b35
> --- /dev/null
> +++ b/hw/i2c/mpc8540_i2c.c
> @@ -0,0 +1,307 @@
> +/*
> + * MPC8540 I2C bus interface
> + * As described in
> + * MPC8540 PowerQUICC III Integrated Host Processor Reference Manual, Re=
v. 1
> + * Part 2 chapter 11
> + *
> + * Compatible I2C controllers are found on other Freescale chips
> + * including mpc8544 and P2010.
> + *
> + * Copyright (c) 2015 Michael Davidsaver
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the LICENSE file in the top-level directory.
> + */
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/hw.h"
> +#include "hw/registerfields.h"
> +#include "hw/i2c/i2c.h"
> +#include "hw/sysbus.h"
> +#include "qemu/error-report.h"
> +
> +#include "trace.h"
> +
> +/* #define DEBUG_LVL 0 */
> +
> +#ifdef DEBUG_LVL
> +#define DPRINTK(LVL, FMT, ...) do { \
> +    if ((LVL) <=3D DEBUG_LVL) {\
> +        info_report(TYPE_MPC8540_I2C " : " FMT, ## __VA_ARGS__); \
> +    } } while (0)
> +#else
> +#define DPRINTK(LVL, FMT, ...) do {} while (0)
> +#endif

So, you have both this DPRINTK stuff, and some trace events, which
seems a bit odd?  Why not just one or the other.

> +
> +#define LOG(MSK, FMT, ...) qemu_log_mask(MSK, TYPE_MPC8540_I2C \
> +    " : " FMT "\n", ## __VA_ARGS__)
> +
> +#define TYPE_MPC8540_I2C "mpc8540-i2c"
> +#define MPC8540_I2C(obj) OBJECT_CHECK(MPC8540I2CState, (obj), TYPE_MPC85=
40_I2C)
> +
> +/* offsets relative to CCSR offset 0x3000 */
> +#define R_I2CADR (0)
> +#define R_I2CFDR (4)
> +#define R_I2CCR  (8)
> +#define R_I2CSR  (0xc)
> +#define R_I2CDR  (0x10)
> +#define R_I2CDFSRR (0x14)
> +
> +FIELD(I2CCR, MEN, 7, 1)
> +FIELD(I2CCR, MIEN, 6, 1)
> +FIELD(I2CCR, MSTA, 5, 1)
> +FIELD(I2CCR, MTX, 4, 1)
> +FIELD(I2CCR, TXAK, 3, 1)
> +FIELD(I2CCR, RSTA, 2, 1)
> +FIELD(I2CCR, BCST, 0, 1)
> +
> +FIELD(I2CSR, MCF, 7, 1)
> +FIELD(I2CSR, MAAS, 6, 1)
> +FIELD(I2CSR, MBB, 5, 1)
> +FIELD(I2CSR, MAL, 4, 1)
> +FIELD(I2CSR, BCSTM, 3, 1)
> +FIELD(I2CSR, SRW, 2, 1)
> +FIELD(I2CSR, MIF, 1, 1)
> +FIELD(I2CSR, RXAK, 0, 1)
> +
> +typedef struct MPC8540I2CState {
> +    SysBusDevice parent_obj;
> +
> +    I2CBus *bus;
> +
> +    uint8_t ctrl, sts;
> +    uint8_t freq, filt;
> +    /* Reads are pipelined, this is the next data value */
> +    uint8_t dbuf, dbuf_valid;
> +
> +    qemu_irq irq;
> +
> +    MemoryRegion mmio;
> +} MPC8540I2CState;
> +
> +#define I2CCR(BIT) FIELD_EX32(i2c->ctrl, I2CCR, BIT)
> +#define I2CSR(BIT) FIELD_EX32(i2c->sts, I2CSR, BIT)
> +
> +#define I2CSR_SET(BIT, VAL) do {\
> +        i2c->sts =3D FIELD_DP32(i2c->sts, I2CSR, BIT, VAL);\
> +    } while (0)
> +
> +static
> +void mpc8540_update_irq(MPC8540I2CState *i2c)
> +{
> +    int ena =3D i2c->ctrl & 0x40,
> +        sts =3D i2c->sts & 0x02,
> +        act =3D !!(ena && sts);
> +
> +    DPRINTK(1, "IRQ %c ena %c sts %c",
> +            act ? 'X' : '_',
> +            ena ? 'X' : '_',
> +            sts ? 'X' : '_');
> +
> +    qemu_set_irq(i2c->irq, act);
> +}
> +
> +static
> +uint64_t mpc8540_i2c_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    MPC8540I2CState *i2c =3D opaque;
> +    uint32_t val;
> +
> +    switch (addr) {
> +    case R_I2CADR: /* ADDR */
> +        val =3D 0;
> +        break;
> +    case R_I2CFDR: /* Freq Div. */
> +        val =3D i2c->freq;
> +        break;
> +    case R_I2CCR: /* CONTROL */
> +        val =3D i2c->ctrl & ~0x06;
> +        break;
> +    case R_I2CSR: /* STATUS */
> +        val =3D i2c->sts;
> +        break;
> +    case R_I2CDR: /* DATA */
> +        /* Reads are "pipelined" and so return the previous value of the
> +         * register
> +         */
> +        val =3D i2c->dbuf;
> +        if (I2CCR(MEN) && I2CSR(MBB)) { /* enabled and busy */
> +            if (!i2c_bus_busy(i2c->bus) || I2CCR(MTX)) {
> +                if (!i2c->dbuf_valid) {
> +                    LOG(LOG_GUEST_ERROR, "Read during addr or tx");
> +                }
> +                i2c->dbuf =3D 0xff;
> +                i2c->dbuf_valid =3D false;
> +            } else {
> +                int ret =3D i2c_recv(i2c->bus);
> +                i2c->dbuf =3D (uint8_t)ret;
> +                i2c->dbuf_valid =3D true;
> +                trace_mpc8540_i2c_read(i2c->dbuf);
> +                I2CSR_SET(MIF, 1);
> +                I2CSR_SET(RXAK, 0);
> +                mpc8540_update_irq(i2c);
> +            }
> +        } else {
> +            i2c->dbuf =3D 0xff;
> +            i2c->dbuf_valid =3D false;
> +            LOG(LOG_GUEST_ERROR, "Read when not enabled or busy");
> +        }
> +        break;
> +    case R_I2CDFSRR: /* FILTER */
> +        val =3D i2c->filt;
> +        break;
> +    default:
> +        val =3D 0xff;
> +    }
> +
> +    DPRINTK(addr =3D=3D 0xc ? 2 : 1, " read %08x -> %08x",
> +            (unsigned)addr, (unsigned)val);
> +    return val;
> +}
> +
> +static
> +void mpc8540_i2c_write(void *opaque, hwaddr addr, uint64_t val, unsigned=
 size)
> +{
> +    MPC8540I2CState *i2c =3D opaque;
> +
> +    DPRINTK(1, " write %08x <- %08x", (unsigned)addr, (unsigned)val);
> +
> +    switch (addr) {
> +    case R_I2CADR: /* ADDR */
> +        break;
> +    case R_I2CFDR: /* Freq Div. */
> +        i2c->freq =3D val & 0x3f;
> +        break;
> +    case R_I2CCR: /* CONTROL CCR */
> +        if (!FIELD_EX32(val, I2CCR, MEN)) {
> +            DPRINTK(0, "Not Enabled");
> +
> +        } else if (!I2CCR(MSTA) && FIELD_EX32(val, I2CCR, MSTA)) {
> +            /* MSTA 0 -> 1 is START */
> +
> +            I2CSR_SET(MBB, 1);
> +            if (I2CCR(MTX)) {
> +                trace_mpc8540_i2c_event("START Tx");
> +            } else {
> +                trace_mpc8540_i2c_event("START Rx");
> +            }
> +            i2c_end_transfer(i2c->bus); /* paranoia */
> +
> +        } else if (I2CCR(MSTA) && !FIELD_EX32(val, I2CCR, MSTA)) {
> +            /* MSTA 1 -> 0 is STOP */
> +
> +            I2CSR_SET(MBB, 0);
> +            trace_mpc8540_i2c_event("STOP");
> +            i2c_end_transfer(i2c->bus);
> +
> +        } else if (I2CCR(MSTA) && FIELD_EX32(val, I2CCR, RSTA)) {
> +            i2c_end_transfer(i2c->bus);
> +            I2CSR_SET(MBB, 1);
> +            if (I2CCR(MTX)) {
> +                trace_mpc8540_i2c_event("REPEAT START Tx");
> +            } else {
> +                trace_mpc8540_i2c_event("REPEAT START Rx");
> +            }
> +
> +        }
> +        /* RSTA always reads zero, bit 1 unusd */
> +        val &=3D 0xf9;
> +        i2c->ctrl =3D val;
> +        mpc8540_update_irq(i2c);
> +        break;
> +    case R_I2CSR: /* STATUS CSR */
> +        /* only MAL and MIF are writable */
> +        val &=3D 0x12;
> +        i2c->sts &=3D ~0x12;
> +        i2c->sts |=3D val;
> +        mpc8540_update_irq(i2c);
> +        break;
> +    case R_I2CDR: /* DATA CDR */
> +        if (I2CCR(MEN) && I2CSR(MBB)) { /* enabled and busy */
> +            if (!i2c_bus_busy(i2c->bus)) {
> +                if (i2c_start_transfer(i2c->bus, val >> 1, val & 1)) {
> +                    LOG(LOG_GUEST_ERROR, "I2C no device %02x",
> +                        (unsigned)(val & 0xfe));
> +                } else {
> +                    trace_mpc8540_i2c_address((unsigned)(val & 0xfe),
> +                                              (val & 0x1) ? 'R' : 'T');
> +                }
> +                I2CSR_SET(MIF, 1);
> +                I2CSR_SET(RXAK, 0);
> +
> +            } else if (I2CCR(MTX)) {
> +                trace_mpc8540_i2c_write((unsigned)val);
> +                i2c_send(i2c->bus, val);
> +                I2CSR_SET(MIF, 1);
> +                I2CSR_SET(RXAK, 0);
> +            } else {
> +                LOG(LOG_GUEST_ERROR, "I2CDR Write during read");
> +            }
> +            mpc8540_update_irq(i2c);
> +        } else {
> +            LOG(LOG_GUEST_ERROR, "I2CDR Write when not enabled or busy");
> +        }
> +        break;
> +    case R_I2CDFSRR: /* FILTER */
> +        val &=3D 0x3f;
> +        i2c->filt =3D val;
> +        break;
> +    }
> +
> +    DPRINTK(1, "I2CCR =3D %02x I2SCR =3D %02x", i2c->ctrl, i2c->sts);
> +}
> +
> +static const MemoryRegionOps i2c_ops =3D {
> +    .read =3D mpc8540_i2c_read,
> +    .write =3D mpc8540_i2c_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .impl =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 1,
> +    },
> +};
> +
> +static
> +void mpc8540_i2c_reset(DeviceState *dev)
> +{
> +    MPC8540I2CState *i2c =3D MPC8540_I2C(dev);
> +
> +    i2c->sts =3D 0x81; /* transfer complete and ack received */
> +    i2c->dbuf_valid =3D false;
> +}
> +
> +static void mpc8540_i2c_inst_init(DeviceState *dev, Error **errp)
> +{
> +    MPC8540I2CState *i2c =3D MPC8540_I2C(dev);
> +
> +    i2c->bus =3D i2c_init_bus(dev, "bus");
> +
> +    memory_region_init_io(&i2c->mmio, OBJECT(dev),
> +                          &i2c_ops, i2c, TYPE_MPC8540_I2C, 0x18);
> +
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &i2c->mmio);
> +    sysbus_init_irq(SYS_BUS_DEVICE(dev), &i2c->irq);
> +}

As someone pointed out on the earlier version, this stuff needs to go
into a realize() function rather than instance_init - instance_init is
called too early to go safely constructing and installing memory
regions.

> +
> +static void mpc8540_i2c_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->realize =3D &mpc8540_i2c_inst_init;
> +    dc->reset =3D &mpc8540_i2c_reset;
> +}
> +
> +static const TypeInfo mpc8540_i2c_type =3D {
> +    .name =3D TYPE_MPC8540_I2C,
> +    .parent =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(MPC8540I2CState),
> +    .class_size =3D sizeof(SysBusDeviceClass),
> +    .class_init =3D mpc8540_i2c_class_init,
> +};
> +
> +static void mpc8540_i2c_register(void)
> +{
> +    type_register_static(&mpc8540_i2c_type);
> +}
> +
> +type_init(mpc8540_i2c_register)
> diff --git a/hw/i2c/trace-events b/hw/i2c/trace-events
> index 9284b1fbad..ac38d76984 100644
> --- a/hw/i2c/trace-events
> +++ b/hw/i2c/trace-events
> @@ -1 +1,7 @@
>  # See docs/devel/tracing.txt for syntax documentation.
> +
> +# hw/i2c/mpc8540_i2c.c
> +mpc8540_i2c_event(const char *evt) "Bus Event %s"
> +mpc8540_i2c_address(uint8_t addr, const char direction) "Address device =
0x%02x for %cX"
> +mpc8540_i2c_write(uint8_t byte) "Write 0x%02x"
> +mpc8540_i2c_read(uint8_t byte) "Read 0x%02x"

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gMR3gsNFwZpnI/Ts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlobutwACgkQbDjKyiDZ
s5LpWBAA1ovJ3gqCt7fAWo9eE87zNeAnlxjEEzqs3ChwG1UxCKZl6XYIFK7/lWOS
jmZQd042YVzODmuaA5U1XRuslfIGJ/918dgsmlRZlorv3XonRU6X+Quw7Xe3p5gQ
6RYTbqtA5o25tojHcjnpw0qE8qxxe3dbYBcbrvr6aK1+CV2rCG+CSkE3o0juJ4GD
7hpIJhaTzUwZANs6TXMFRAqvxvVJT7Lh8zhEUs4OPr59DuxnD0EKQZIfG2VYhscx
GjsIjhwUffAxto6zLyiMPVYDuKgEISXWx51BLor6+aVxt+vG+Exbno4QGY/lFgOx
J3I5E+dT27Xc06ZjJOCNJJvEeXnaX+zjr4tP7Qpc4YE1mhfZfA41x3xxEX3IQZlu
NuKEySqxuS+5LfO3hsAGZSeAb3qyC1XHvGrSQCca4uGBBK7g74hR4M5qV40LDlzV
04aTLnNrwzXEDCRnyYOS4ABuVUzIeaa6QdmwRpyPChXwC8inWbEKHAVylTS8leM1
R7bN49n5orC3gMhp8idfgBHI8ciZpF+DIfewxJwrufcHOW8N6SFEvHgLcMnxw+vs
XuMzBWVC8cMPTWYuQd5SmITh71RHtDlvDEgDAxkgP51iCwoGvr3gF2WSrF9nD+L+
HUJ3bCAeg3La687LHk/brXHuzJBe1iTYbxQ6hwtC6sQUaUBv29w=
=LJJh
-----END PGP SIGNATURE-----

--gMR3gsNFwZpnI/Ts--
