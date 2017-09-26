Received: from eggs.gnu.org ([2001:4830:134:3::10]:38572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dwgv3-0003nB-2t
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 23:52:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dwgv1-0001fc-MX
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 23:52:25 -0400
Date: Tue, 26 Sep 2017 13:47:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170926034706.GG12504@umbus>
References: <1506264466-28252-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1506264466-28252-7-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9/eUdp+dLtKXvemk"
Content-Disposition: inline
In-Reply-To: <1506264466-28252-7-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 6/7] mac_dbdma: change
 DBDMA_register_channel to a MAC_DBDMA type method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--9/eUdp+dLtKXvemk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 24, 2017 at 03:47:45PM +0100, Mark Cave-Ayland wrote:
> Using this we can change the MACIO_IDE instance to register the channel
> itself via a type method instead of requiring a separate
> DBDMA_register_channel() function.
>=20
> As a consequence of this it is now possible to remove the old external
> macio_ide_register_dma() function.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Ok, two concerns about this.

First, you've added the function pointer to the instance, not to the
class, which is not how a QOM method would normally be done.

More generally, though, why is a method preferable to a plain
function?  AFAICT it's not plausible that there will ever be more than
one implementation of the method.

Same comments apply to patch 7/7.

> ---
>  hw/ide/macio.c             |   12 ++++++------
>  hw/misc/macio/mac_dbdma.c  |    9 +++++----
>  hw/misc/macio/macio.c      |    1 -
>  include/hw/ppc/mac_dbdma.h |    9 ++++-----
>  4 files changed, 15 insertions(+), 16 deletions(-)
>=20
> diff --git a/hw/ide/macio.c b/hw/ide/macio.c
> index ce194c6..b296017 100644
> --- a/hw/ide/macio.c
> +++ b/hw/ide/macio.c
> @@ -411,12 +411,18 @@ static const IDEDMAOps dbdma_ops =3D {
>  static void macio_ide_realizefn(DeviceState *dev, Error **errp)
>  {
>      MACIOIDEState *s =3D MACIO_IDE(dev);
> +    DBDMAState *dbdma;
> =20
>      ide_init2(&s->bus, s->ide_irq);
> =20
>      /* Register DMA callbacks */
>      s->dma.ops =3D &dbdma_ops;
>      s->bus.dma =3D &s->dma;
> +
> +    /* Register DBDMA channel */
> +    dbdma =3D MAC_DBDMA(object_property_get_link(OBJECT(dev), "dbdma", e=
rrp));
> +    dbdma->register_channel(dbdma, s->channel, s->dma_irq,
> +                            pmac_ide_transfer, pmac_ide_flush, s);
>  }
> =20
>  static void pmac_ide_irq(void *opaque, int n, int level)
> @@ -497,10 +503,4 @@ void macio_ide_init_drives(MACIOIDEState *s, DriveIn=
fo **hd_table)
>      }
>  }
> =20
> -void macio_ide_register_dma(MACIOIDEState *s)
> -{
> -    DBDMA_register_channel(s->dbdma, s->channel, s->dma_irq,
> -                           pmac_ide_transfer, pmac_ide_flush, s);
> -}
> -
>  type_init(macio_ide_register_types)
> diff --git a/hw/misc/macio/mac_dbdma.c b/hw/misc/macio/mac_dbdma.c
> index 0eddf2e..addb97d 100644
> --- a/hw/misc/macio/mac_dbdma.c
> +++ b/hw/misc/macio/mac_dbdma.c
> @@ -557,11 +557,10 @@ void DBDMA_kick(DBDMAState *dbdma)
>      qemu_bh_schedule(dbdma->bh);
>  }
> =20
> -void DBDMA_register_channel(void *dbdma, int nchan, qemu_irq irq,
> -                            DBDMA_rw rw, DBDMA_flush flush,
> -                            void *opaque)
> +static void
> +dbdma_register_channel(DBDMAState *s, int nchan, qemu_irq irq,
> +                       DBDMA_rw rw, DBDMA_flush flush, void *opaque)
>  {
> -    DBDMAState *s =3D dbdma;
>      DBDMA_channel *ch =3D &s->channels[nchan];
> =20
>      DBDMA_DPRINTFCH(ch, "DBDMA_register_channel 0x%x\n", nchan);
> @@ -903,6 +902,8 @@ static void mac_dbdma_init(Object *obj)
> =20
>      memory_region_init_io(&s->mem, obj, &dbdma_ops, s, "dbdma", 0x1000);
>      sysbus_init_mmio(sbd, &s->mem);
> +
> +    s->register_channel =3D dbdma_register_channel;
>  }
> =20
>  static void mac_dbdma_realize(DeviceState *dev, Error **errp)
> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
> index 9aa7e75..533331a 100644
> --- a/hw/misc/macio/macio.c
> +++ b/hw/misc/macio/macio.c
> @@ -161,7 +161,6 @@ static void macio_realize_ide(MacIOState *s, MACIOIDE=
State *ide,
>      sysbus_connect_irq(sysbus_dev, 1, irq1);
>      qdev_prop_set_uint32(DEVICE(ide), "channel", dmaid);
>      object_property_set_link(OBJECT(ide), OBJECT(s->dbdma), "dbdma", err=
p);
> -    macio_ide_register_dma(ide);
> =20
>      object_property_set_bool(OBJECT(ide), true, "realized", errp);
>  }
> diff --git a/include/hw/ppc/mac_dbdma.h b/include/hw/ppc/mac_dbdma.h
> index 26cc469..d6a38c5 100644
> --- a/include/hw/ppc/mac_dbdma.h
> +++ b/include/hw/ppc/mac_dbdma.h
> @@ -160,19 +160,18 @@ typedef struct DBDMA_channel {
>      dbdma_cmd current;
>  } DBDMA_channel;
> =20
> -typedef struct {
> +typedef struct DBDMAState {
>      SysBusDevice parent_obj;
> =20
>      MemoryRegion mem;
>      DBDMA_channel channels[DBDMA_CHANNELS];
>      QEMUBH *bh;
> +
> +    void (*register_channel)(struct DBDMAState *s, int nchan, qemu_irq i=
rq,
> +                             DBDMA_rw rw, DBDMA_flush flush, void *opaqu=
e);
>  } DBDMAState;
> =20
>  /* Externally callable functions */
> -
> -void DBDMA_register_channel(void *dbdma, int nchan, qemu_irq irq,
> -                            DBDMA_rw rw, DBDMA_flush flush,
> -                            void *opaque);
>  void DBDMA_kick(DBDMAState *dbdma);
> =20
>  #define TYPE_MAC_DBDMA "mac-dbdma"

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9/eUdp+dLtKXvemk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnJzbgACgkQbDjKyiDZ
s5LFQg//YhWEPKyzhO8q3s1ekrF3AmgTdsHy3058TlFy2Gt9hIWaRvobTAQ3LZBp
u9nxB1vkeRjqru7I/OBZwv03ic0rLCrkpFeSe/m7iIKsf4nsJq71fbAHCnVz+lAB
KMQ99CHHRgH+bJtgckUyzpFnmeumSCD6RVvS2MGgiK8/JfW66Trs9HDR5ld8KXZd
/lEI6fqsCrz42nf7ER4oyGb5SwG8+vm0q0nUoEIFtC2cFO9sIE4yaWVa8w6YI1NE
Y+cUbrXd16Q5BjGCLl+xYVpZrKH5XTH37qmXyXRJWXL9w7aiiR471qMWM6WSi8sG
AHZv3p3Bbd8p8kVGHinqScf2QdNPOiExI3YSVu2qh0Dd949i/dUkgGc5mr0X57+9
HxlzKrfDiMIBXG6qeY4rg4vvm8VqHN3G873QWqnzAQgekj4MZ/87RdMN6N/JAcZ9
THHOkKpfichwH+ZbiNhSvHJOLxX4cQetorWBcS7KbX9TJEM2wCXttMiPRqNH/kRg
ycA/Sgg/uVrjyDbi+lCY3jvPSPxmQ7DmvJJmQOO2yNB7jPf6Y57BOFLiMktZHBXK
sEXeBwKPeTbfQdjr/VzcKYW9Nd5hbvd6rjz29CBE7wsg3OzdCa6cuT7Vv8yKjo4G
FjC8dqr3Wh8h6yHWiDAtZqZmcpFQel4t6UQ2sVX2lGXqghpIfOo=
=o5c9
-----END PGP SIGNATURE-----

--9/eUdp+dLtKXvemk--
