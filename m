Received: from eggs.gnu.org ([2001:4830:134:3::10]:33748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fbJZE-0008GQ-AM
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 01:46:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fbJZA-0000Yj-9f
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 01:46:04 -0400
Date: Fri, 6 Jul 2018 15:44:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180706054458.GQ3450@umbus.fritz.box>
References: <20180619140729.21949-1-clg@kaod.org>
	<20180619140729.21949-2-clg@kaod.org>
	<eb1ad8ca-89f7-b059-3a3c-412375871113@kaod.org>
	<bc3ec7a5-a6c5-2a0d-7ac1-6583a182807b@kaod.org>
	<dc0f292f-6f1f-791b-4073-88f347495d2c@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1MCZUn4MZNv/LeVo"
Content-Disposition: inline
In-Reply-To: <dc0f292f-6f1f-791b-4073-88f347495d2c@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v3 1/3] spapr: introduce a fixed IRQ number
 space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>


--1MCZUn4MZNv/LeVo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2018 at 05:19:56PM +0200, C=E9dric Le Goater wrote:
> On 07/02/2018 01:11 PM, C=E9dric Le Goater wrote:
> > On 07/02/2018 12:03 PM, C=E9dric Le Goater wrote:
> >>> --- a/hw/ppc/spapr_vio.c
> >>> +++ b/hw/ppc/spapr_vio.c
> >>> @@ -436,6 +436,9 @@ static void spapr_vio_busdev_reset(DeviceState *q=
dev)
> >>>      }
> >>>  }
> >>> =20
> >>> +/* TODO : poor VIO device indexing ... */
> >>> +static uint32_t vio_index;
> >>
> >> I think we could also use (dev->reg & 0xff) as an index for=20
> >> the VIO devices.
> >>
> >> The unit address of the virtual IOA is simply allocated using=20
> >> an increment of bus->next_reg, next_reg being initialized at
> >> 0x71000000.
> >>
> >> I did not see any restrictions in the PAPR specs or in QEMU=20
> >> that would break the above.
> >=20
> > That was until I discovered this macro :=20
> >=20
> >   #define DEFINE_SPAPR_PROPERTIES(type, field)           \
> >         DEFINE_PROP_UINT32("reg", type, field.reg, -1)
> > =20
> > so 'reg' could have any value. We can not use it ...
>=20
> Would moving vio_index under the bus and incrementing it each time
> a VIO device is created be acceptable ?=20

Not really, no.

> It does look like an allocator but I really don't know what else to=20
> propose :/ See below.

Not only is it a stealth allocator, it also means we have two
different unique ids for VIO devices - the 'reg' and this new index.
That sounds like a recipe for confusion.

I think we can do better.  I had a look at how these are allocated and
it seems to be this:

In qemu:
	VIO devices start at reg=3D0x71000000, and just increment by one
	from there.

In libvirt:
	VIO net devices start at reg=3D0x1000
	VIO scsi devices start at reg=3D0x2000
	VIO nvram devices start at reg=3D0x3000
	VIO vty devices start at reg=3D0x30000000
	    and increment by 0x1000 each type

So we could go for say:
	irq =3D (reg & 0xf) ^ ((reg >> 12) & 0xf);

Obviously it's easily to construct cases where that will result in
collisions, but I don't think it'll happen for anyone not going out of
there way to make it happen.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1MCZUn4MZNv/LeVo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls/AdcACgkQbDjKyiDZ
s5JMGhAAl0LqVYLSp5eg3USoCPnhpnAtbVELpSbE66WM6B3zWC80UT0mzgvTIj4Z
JnFvbJB2UFj0YIFkD0A75ia/rHonHc6rtJMK+bFz/4EE7km6GnnD8o/7nNCEiW3G
1VmTusqkwKCunPcxPzKj2AT8JoPlNIt9LxA9nxRsbGn+6X+4DpJD35Le2pZU6lOt
kATbS1eQZsG3STWwIDinTixICr61AOwfTXQm0ZpE5M45aXFXm7TSAaeAckxpESy5
1XbHr6OSlwrA/6F4UfR+iCYHMVClui041QyGs45izM9QdJWK+SfPePwalu1/GXDa
qtVzM41EahOwNtcEixJUUwQLSD9A3TfOy/RS4q3m5Lg8AdcM4LOGRWJlrlsE13tF
wF2VcDGS7soZQ7MVyzTtCj454C/OOUHvyNeMPRlFVp/a1ZHBgMqbRMtw5kh3+hkF
znfgPcjsOypVVC1fxEIIzBeb0lYuMaFD9Lj73e8WJhmwkd3LY7Gmffvb+PVSbmg/
+eUPHEI2LiLxGbiFB2wS6gJtBOEFHU+JCj1FNPav4Lm9aSWi0UI4HqQCEJkCaJsV
JOllt135lAwpxceMnUn1ufWmJodZ1QdGJcc5yAdqNMTcd9XshR40NOb/XJKJG5XE
dTHPdnvzxT4KkXV8wCHz1TcVEbycEbgQDHIntlvAIhGBaJQUFx0=
=fvcY
-----END PGP SIGNATURE-----

--1MCZUn4MZNv/LeVo--
