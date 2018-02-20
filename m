Received: from eggs.gnu.org ([2001:4830:134:3::10]:50769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1enyc6-0001LP-Eh
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 22:29:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1enyc3-0006TL-8z
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 22:29:06 -0500
Date: Tue, 20 Feb 2018 14:28:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180220032835.GJ1109@umbus.fritz.box>
References: <20180219181922.21586-1-mark.cave-ayland@ilande.co.uk>
	<20180219181922.21586-2-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ed/6oDxOLijJh8b0"
Content-Disposition: inline
In-Reply-To: <20180219181922.21586-2-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 01/11] macio: embed DBDMA device directly
 within macio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--ed/6oDxOLijJh8b0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2018 at 06:19:12PM +0000, Mark Cave-Ayland wrote:
> The current recommendation is to embed subdevices directly within their c=
ontainer
> device, so do this for the DBDMA device.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied, thanks.

> ---
>  hw/misc/macio/macio.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
> index 024f8557ab..7174135c8b 100644
> --- a/hw/misc/macio/macio.c
> +++ b/hw/misc/macio/macio.c
> @@ -42,7 +42,7 @@ typedef struct MacIOState
> =20
>      MemoryRegion bar;
>      CUDAState cuda;
> -    DBDMAState *dbdma;
> +    DBDMAState dbdma;
>      MemoryRegion *pic_mem;
>      MemoryRegion *escc_mem;
>      uint64_t frequency;
> @@ -129,12 +129,12 @@ static void macio_common_realize(PCIDevice *d, Erro=
r **errp)
>      SysBusDevice *sysbus_dev;
>      Error *err =3D NULL;
> =20
> -    object_property_set_bool(OBJECT(s->dbdma), true, "realized", &err);
> +    object_property_set_bool(OBJECT(&s->dbdma), true, "realized", &err);
>      if (err) {
>          error_propagate(errp, err);
>          return;
>      }
> -    sysbus_dev =3D SYS_BUS_DEVICE(s->dbdma);
> +    sysbus_dev =3D SYS_BUS_DEVICE(&s->dbdma);
>      memory_region_add_subregion(&s->bar, 0x08000,
>                                  sysbus_mmio_get_region(sysbus_dev, 0));
> =20
> @@ -161,7 +161,7 @@ static void macio_realize_ide(MacIOState *s, MACIOIDE=
State *ide,
>      sysbus_connect_irq(sysbus_dev, 0, irq0);
>      sysbus_connect_irq(sysbus_dev, 1, irq1);
>      qdev_prop_set_uint32(DEVICE(ide), "channel", dmaid);
> -    object_property_set_link(OBJECT(ide), OBJECT(s->dbdma), "dbdma", err=
p);
> +    object_property_set_link(OBJECT(ide), OBJECT(&s->dbdma), "dbdma", er=
rp);
>      macio_ide_register_dma(ide);
> =20
>      object_property_set_bool(OBJECT(ide), true, "realized", errp);
> @@ -344,8 +344,9 @@ static void macio_instance_init(Object *obj)
>      qdev_set_parent_bus(DEVICE(&s->cuda), sysbus_get_default());
>      object_property_add_child(obj, "cuda", OBJECT(&s->cuda), NULL);
> =20
> -    s->dbdma =3D MAC_DBDMA(object_new(TYPE_MAC_DBDMA));
> -    object_property_add_child(obj, "dbdma", OBJECT(s->dbdma), NULL);
> +    object_initialize(&s->dbdma, sizeof(s->dbdma), TYPE_MAC_DBDMA);
> +    qdev_set_parent_bus(DEVICE(&s->dbdma), sysbus_get_default());
> +    object_property_add_child(obj, "dbdma", OBJECT(&s->dbdma), NULL);
>  }
> =20
>  static const VMStateDescription vmstate_macio_oldworld =3D {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ed/6oDxOLijJh8b0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqLleMACgkQbDjKyiDZ
s5INtBAAsbFn8KHo9qQc9ORG/jvwFBI0ulNeP/QG7XGzlmAzYesOynfem735GrJY
InF++POcNLiNTld19IrkIdkTuI2/NGURQ3Zqt/m2TiQa0D15g/WGgfHFzxeB4Br5
faTsnLzSjd6pBAoXqLSbgCdnRdpMg/jCTzTZ3hPIQ7Pb+gryks01TceqrjQy0Pvb
NTlPgRP27WRNbOe2DVA1XepUC4a44ckUbDSp6q0ShcN8ww0ox0DcOpGHnxoeOgGG
gEcmYdDLHclM1LbeXd0GVYyrRmmzzTPgT5DZJmK9PJY4iW1cUFkcZicE6b4hmzmp
KRsVBEG/ewtzMIqGsA5AhWCUKiAZ7lUEAE7u8Xm9+yKH88lRTZF0XbqOTRdBfn2P
txUMOLi0Cyu2P28t/xozPshdOS9yaLB00F6g88jg/uTnc4cKBpZH7gUKJ4vCjOsC
eAX/fs1vCcr8B42sYC4k0Ylw1NlvrCx/OfOKNLiH7YMp+GNHr66+xaqYynT5/ixT
OYJx+aHwS5OTiujcIAs48OP1s3bka1vhVh53zEyIkR7ZF4BZ14Z0hcRyt32N96y9
gJNeKKMV1Yoh0SiMiwo0+ZCvg0kyHWtI3EdawyroNLCiRgkTIUE6OD9GrhY1CPBj
Fm+rLke97R88um5KrTCqlOFTUi7d4x7ON5zihP+xNgO/uupok/0=
=vhVw
-----END PGP SIGNATURE-----

--ed/6oDxOLijJh8b0--
