Received: from eggs.gnu.org ([2001:4830:134:3::10]:59383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1djePE-0004u5-Uk
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 00:33:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1djePB-0005Ht-QI
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 00:33:40 -0400
Date: Mon, 21 Aug 2017 14:10:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170821041040.GF12356@umbus.fritz.box>
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<25eb9dc6c387f03754114e4a0584516847f1da7d.1503249785.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oFbHfjnMgUMsrGjO"
Content-Disposition: inline
In-Reply-To: <25eb9dc6c387f03754114e4a0584516847f1da7d.1503249785.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH 03/15] ohci: Allow sysbus version to be
 used as a companion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Francois Revol <revol@free.fr>, Gerd Hoffmann <kraxel@redhat.com>


--oFbHfjnMgUMsrGjO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 20, 2017 at 07:23:05PM +0200, BALATON Zoltan wrote:
1;4803;0c> Some PPC SoCs have an EHCI with OHCI companion USB controller. To
> emulate this allow the sysbus version of OHCI to be used as a companion.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Gerd,  if you're happy with this, I can queue it for 2.11.  Let me
know what you'd prefer.

> ---
>  hw/usb/hcd-ohci.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> index 267982e..17beedd 100644
> --- a/hw/usb/hcd-ohci.c
> +++ b/hw/usb/hcd-ohci.c
> @@ -1999,7 +1999,9 @@ typedef struct {
>      /*< public >*/
> =20
>      OHCIState ohci;
> +    char *masterbus;
>      uint32_t num_ports;
> +    uint32_t firstport;
>      dma_addr_t dma_offset;
>  } OHCISysBusState;
> =20
> @@ -2007,10 +2009,15 @@ static void ohci_realize_pxa(DeviceState *dev, Er=
ror **errp)
>  {
>      OHCISysBusState *s =3D SYSBUS_OHCI(dev);
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> +    Error *err =3D NULL;
> =20
> -    /* Cannot fail as we pass NULL for masterbus */
> -    usb_ohci_init(&s->ohci, dev, s->num_ports, s->dma_offset, NULL, 0,
> -                  &address_space_memory, &error_abort);
> +    usb_ohci_init(&s->ohci, dev, s->num_ports, s->dma_offset,
> +                  s->masterbus, s->firstport,
> +                  &address_space_memory, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>      sysbus_init_irq(sbd, &s->ohci.irq);
>      sysbus_init_mmio(sbd, &s->ohci.mem);
>  }
> @@ -2142,7 +2149,9 @@ static const TypeInfo ohci_pci_info =3D {
>  };
> =20
>  static Property ohci_sysbus_properties[] =3D {
> +    DEFINE_PROP_STRING("masterbus", OHCISysBusState, masterbus),
>      DEFINE_PROP_UINT32("num-ports", OHCISysBusState, num_ports, 3),
> +    DEFINE_PROP_UINT32("firstport", OHCISysBusState, firstport, 0),
>      DEFINE_PROP_DMAADDR("dma-offset", OHCISysBusState, dma_offset, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oFbHfjnMgUMsrGjO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmaXT4ACgkQbDjKyiDZ
s5JTgA/+InNOkdZFo+N7TKSuYaGYh1S4AWSuqHD3Pq3INLoAAJD/WW9KiRGnvsiO
MnLbhszp3+P7FVS/DwB4svzQfpaN9TeJw4qKOPDDo6iJd4f7t/Qu/vhjceb2eoeM
rEBsJObieRBa7io405Bpp+cGdVeDU30OTELwPiZX2u08hDhwqOPwpA2+JRdC/PCe
iNUjXPdg47nRMOnsJkATQqKeSU/0mXes2GobD2K3JropsXgaYGiazr0wOaTV+Ei3
iA8JHiCnr61G9O9cMH76MnxoaQ3tPtXNMWYpydH75EFG9/uuchVMmmxx3XZGhzvB
KIsXaMg/BuwJTFGy4RMf2evgsU2R+0RHFzEVheNfAIrLMFbbuqgKWBfISQrpSp2Q
5mPNbef2Ho/n3YbRmJ/ITyduBJFg3Io/IcVmsVrA501+yZ0bIhMiobi9c9BEnMA/
5XBdysyTmD0UoY+S+PgFohP3AAxsWbirIoEMcmeMr6TGmnkkd18bNV5czfYUQDZD
OrzUSG3HMy7KyG+GpraZHTiPjDkNrzBsKKI+Y4g3KTwNnut4Q8Ytbs5mEFz+XwW6
0ls6Jx1r26E3HL5t0cFwqZoShAal1bkm/w9sXQOJvZ1HIVuzUY5v/nqMa5zqNF1x
7D7C4TEYOQosIJ799oiWl19C1uoAkwh1MnT1ZtdOTaevKvkVgNA=
=QYhT
-----END PGP SIGNATURE-----

--oFbHfjnMgUMsrGjO--
