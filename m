Received: from eggs.gnu.org ([2001:4830:134:3::10]:53627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHMOo-0002hv-IN
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 23:12:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHMOn-0002Xg-3d
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 23:12:34 -0500
Date: Wed, 22 Nov 2017 15:10:02 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171122041002.GN2380@umbus.fritz.box>
References: <20171120032420.9134-1-mdavidsaver@gmail.com>
	<20171120032420.9134-10-mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nb8zVy0QMK3AA1xu"
Content-Disposition: inline
In-Reply-To: <20171120032420.9134-10-mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 09/12] nvram: add AT24Cx i2c eeprom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--nb8zVy0QMK3AA1xu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2017 at 09:24:17PM -0600, Michael Davidsaver wrote:
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>

Applied to ppc-for-2.12.

> ---
>  hw/nvram/Makefile.objs  |   1 +
>  hw/nvram/eeprom_at24c.c | 205 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 206 insertions(+)
>  create mode 100644 hw/nvram/eeprom_at24c.c
>=20
> diff --git a/hw/nvram/Makefile.objs b/hw/nvram/Makefile.objs
> index c018f6b2ff..0f4ee71dcb 100644
> --- a/hw/nvram/Makefile.objs
> +++ b/hw/nvram/Makefile.objs
> @@ -1,5 +1,6 @@
>  common-obj-$(CONFIG_DS1225Y) +=3D ds1225y.o
>  common-obj-y +=3D eeprom93xx.o
> +common-obj-y +=3D eeprom_at24c.o
>  common-obj-y +=3D fw_cfg.o
>  common-obj-y +=3D chrp_nvram.o
>  common-obj-$(CONFIG_MAC_NVRAM) +=3D mac_nvram.o
> diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
> new file mode 100644
> index 0000000000..efa3621ac6
> --- /dev/null
> +++ b/hw/nvram/eeprom_at24c.c
> @@ -0,0 +1,205 @@
> +/*
> + * *AT24C* series I2C EEPROM
> + *
> + * Copyright (c) 2015 Michael Davidsaver
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the LICENSE file in the top-level directory.
> + */
> +
> +#include <string.h>
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/hw.h"
> +#include "hw/i2c/i2c.h"
> +#include "sysemu/block-backend.h"
> +
> +/* #define DEBUG_AT24C */
> +
> +#ifdef DEBUG_AT24C
> +#define DPRINTK(FMT, ...) printf(TYPE_AT24C_EE " : " FMT, ## __VA_ARGS__)
> +#else
> +#define DPRINTK(FMT, ...) do {} while (0)
> +#endif
> +
> +#define ERR(FMT, ...) fprintf(stderr, TYPE_AT24C_EE " : " FMT, \
> +                            ## __VA_ARGS__)
> +
> +#define TYPE_AT24C_EE "at24c-eeprom"
> +#define AT24C_EE(obj) OBJECT_CHECK(EEPROMState, (obj), TYPE_AT24C_EE)
> +
> +typedef struct EEPROMState {
> +    I2CSlave parent_obj;
> +
> +    /* address counter */
> +    uint16_t cur;
> +    /* total size in bytes */
> +    uint32_t rsize;
> +    bool writable;
> +    /* cells changed since last START? */
> +    bool changed;
> +    /* during WRITE, # of address bytes transfered */
> +    uint8_t haveaddr;
> +
> +    uint8_t *mem;
> +
> +    BlockBackend *blk;
> +} EEPROMState;
> +
> +static
> +int at24c_eeprom_event(I2CSlave *s, enum i2c_event event)
> +{
> +    EEPROMState *ee =3D container_of(s, EEPROMState, parent_obj);
> +
> +    switch (event) {
> +    case I2C_START_SEND:
> +    case I2C_START_RECV:
> +    case I2C_FINISH:
> +        ee->haveaddr =3D 0;
> +        DPRINTK("clear\n");
> +        if (ee->blk && ee->changed) {
> +            int len =3D blk_pwrite(ee->blk, 0, ee->mem, ee->rsize, 0);
> +            if (len !=3D ee->rsize) {
> +                ERR(TYPE_AT24C_EE
> +                        " : failed to write backing file\n");
> +            }
> +            DPRINTK("Wrote to backing file\n");
> +        }
> +        ee->changed =3D false;
> +        break;
> +    case I2C_NACK:
> +        break;
> +    }
> +    return 0;
> +}
> +
> +static
> +int at24c_eeprom_recv(I2CSlave *s)
> +{
> +    EEPROMState *ee =3D AT24C_EE(s);
> +    int ret;
> +
> +    ret =3D ee->mem[ee->cur];
> +
> +    ee->cur =3D (ee->cur + 1u) % ee->rsize;
> +    DPRINTK("Recv %02x %c\n", ret, ret);
> +
> +    return ret;
> +}
> +
> +static
> +int at24c_eeprom_send(I2CSlave *s, uint8_t data)
> +{
> +    EEPROMState *ee =3D AT24C_EE(s);
> +
> +    if (ee->haveaddr < 2) {
> +        ee->cur <<=3D 8;
> +        ee->cur |=3D data;
> +        ee->haveaddr++;
> +        if (ee->haveaddr =3D=3D 2) {
> +            ee->cur %=3D ee->rsize;
> +            DPRINTK("Set pointer %04x\n", ee->cur);
> +        }
> +
> +    } else {
> +        if (ee->writable) {
> +            DPRINTK("Send %02x\n", data);
> +            ee->mem[ee->cur] =3D data;
> +            ee->changed =3D true;
> +        } else {
> +            DPRINTK("Send error %02x read-only\n", data);
> +        }
> +        ee->cur =3D (ee->cur + 1u) % ee->rsize;
> +
> +    }
> +
> +    return 0;
> +}
> +
> +static
> +int at24c_eeprom_init(I2CSlave *i2c)
> +{
> +    EEPROMState *ee =3D AT24C_EE(i2c);
> +
> +    ee->mem =3D g_malloc0(ee->rsize);
> +
> +    if (ee->blk) {
> +        int64_t len =3D blk_getlength(ee->blk);
> +
> +        if (len !=3D ee->rsize) {
> +            ERR(TYPE_AT24C_EE " : Backing file size %lu !=3D %u\n",
> +                    (unsigned long)len, (unsigned)ee->rsize);
> +            exit(1);
> +        }
> +
> +        if (blk_set_perm(ee->blk, BLK_PERM_CONSISTENT_READ | BLK_PERM_WR=
ITE,
> +                         BLK_PERM_ALL, &error_fatal) < 0)
> +        {
> +            ERR(TYPE_AT24C_EE
> +                    " : Backing file incorrect permission\n");
> +            exit(1);
> +        }
> +    }
> +    return 0;
> +}
> +
> +static
> +void at24c_eeprom_reset(DeviceState *state)
> +{
> +    EEPROMState *ee =3D AT24C_EE(state);
> +
> +    ee->changed =3D false;
> +    ee->cur =3D 0;
> +    ee->haveaddr =3D 0;
> +
> +    memset(ee->mem, 0, ee->rsize);
> +
> +    if (ee->blk) {
> +        int len =3D blk_pread(ee->blk, 0, ee->mem, ee->rsize);
> +
> +        if (len !=3D ee->rsize) {
> +            ERR(TYPE_AT24C_EE
> +                    " : Failed initial sync with backing file\n");
> +        }
> +        DPRINTK("Reset read backing file\n");
> +    }
> +}
> +
> +static Property at24c_eeprom_props[] =3D {
> +    DEFINE_PROP_UINT32("rom-size", EEPROMState, rsize, 0),
> +    DEFINE_PROP_BOOL("writable", EEPROMState, writable, true),
> +    DEFINE_PROP_DRIVE("drive", EEPROMState, blk),
> +    DEFINE_PROP_END_OF_LIST()
> +};
> +
> +static
> +void at24c_eeprom_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
> +
> +    k->init =3D &at24c_eeprom_init;
> +    k->event =3D &at24c_eeprom_event;
> +    k->recv =3D &at24c_eeprom_recv;
> +    k->send =3D &at24c_eeprom_send;
> +
> +    dc->props =3D at24c_eeprom_props;
> +    dc->reset =3D at24c_eeprom_reset;
> +}
> +
> +static
> +const TypeInfo at24c_eeprom_type =3D {
> +    .name =3D TYPE_AT24C_EE,
> +    .parent =3D TYPE_I2C_SLAVE,
> +    .instance_size =3D sizeof(EEPROMState),
> +    .class_size =3D sizeof(I2CSlaveClass),
> +    .class_init =3D at24c_eeprom_class_init,
> +};
> +
> +static void at24c_eeprom_register(void)
> +{
> +    type_register_static(&at24c_eeprom_type);
> +}
> +
> +type_init(at24c_eeprom_register)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nb8zVy0QMK3AA1xu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloU+JoACgkQbDjKyiDZ
s5JZyA/+MbkmkwzP3EbF890H5OSiiIV3q5CfrBrquhnPPAhFZLDm2D5yhPUBBoCx
O0k5rdrQB8hoGo9GK9WYYD+DJkQq561hFFVz665vxq18B2dO4AunCIOr1zjpk3IE
1ZuHwES+WYhJYiXDI+CMgqUvyWC0q30J+bGTTciZYjEji3Kza8hKvsWb3TUY9vPq
1JQ3pg5H+R6nzs4+Pq2SaEYsT78kId/JEPbI/GX/D9LmDnE3+lDq3eEOipHpefdT
jCSZf9LFNzQmafoRyi8ObO72VTWhTKvGe9r67qCPPHQ4NkpkBObSrnSZYvHwS6at
3pSvAJktFFiVlrI2ma3uzMredi/xXrrE6bC2mO0NK2fE7F56fJTio9Nnkw5yfp+4
xvMHaUw3fSkdkgbREUZy8ueVMOk08RbIjLyRjsoYJVd4BZUZO4d3egPs4oD+bhUY
YoSyegZnNiOfOzBVVL1BEYd2OMfgWO4/bcOvX2536+uIt+55oRlAgQwRdCjspaup
Q+8mRAI3MUfqn6S2wX4yfhIM3fQHzuXeTKWvKdlrDbnMths9SVJzSMu2mzOKZWpL
Nc/BLs01YNjgScG+ptQkohZXy2vt1BrIRTy4X+3AMYQmx73Fqy9MEPZSHqJzsQKT
PEUgZYE6s8IMprpmH9HoDlD26Wds2QdKpD5j7a8g4cgToR96YFU=
=DaFd
-----END PGP SIGNATURE-----

--nb8zVy0QMK3AA1xu--
