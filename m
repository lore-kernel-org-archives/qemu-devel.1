Received: from eggs.gnu.org ([208.118.235.92]:38221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gesZb-0002Xb-5F
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 21:17:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gesZV-0004ta-8A
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 21:17:26 -0500
Date: Thu, 3 Jan 2019 12:54:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190103015457.GI10853@umbus.fritz.box>
References: <cover.1546394798.git.balaton@eik.bme.hu>
	<2403f70ea0cda1ba4e6345eb89a5aa5f3fe6e264.1546394798.git.balaton@eik.bme.hu>
	<20190102041133.GM27457@umbus.fritz.box>
	<alpine.BSF.2.21.9999.1901021336130.78010@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DwoPkXS38qd3dnhB"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.9999.1901021336130.78010@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH 2/8] sam460ex: Clean up SPD EEPROM creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--DwoPkXS38qd3dnhB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 01:49:44PM +0100, BALATON Zoltan wrote:
> On Wed, 2 Jan 2019, David Gibson wrote:
> > On Wed, Jan 02, 2019 at 03:06:38AM +0100, BALATON Zoltan wrote:
> > > +    /* IIC controllers and devices */
> > >      dev =3D sysbus_create_simple(TYPE_PPC4xx_I2C, 0x4ef600700, uic[0=
][2]);
> > > -    i2c[0] =3D PPC4xx_I2C(dev);
> > > -    object_property_set_bool(OBJECT(dev), true, "realized", NULL);
> > > -    smbus_eeprom_init(i2c[0]->bus, 8, smbus_eeprom_buf, smbus_eeprom=
_size);
> > > -    g_free(smbus_eeprom_buf);
> > > -    i2c_create_slave(i2c[0]->bus, "m41t80", 0x68);
> > > +    i2c =3D PPC4xx_I2C(dev)->bus;
> > > +    /* SPD EEPROM on RAM module */
> > > +    spd_data =3D spd_data_generate(DDR2, ram_sizes[0]);
> > > +    if (spd_data) {
> > > +        spd_data[20] =3D 4; /* SO-DIMM module */
> > > +        smbus_eeprom_init_one(i2c, 0x50, spd_data);
> >=20
> > Any specific reason this case is handled outside spd_data_generate()?
>=20
> As explained in previous reply I tried to keep number of options to the
> function to minimum and not handle every board specific case in that
> function. This board has SO-DIMM instead of regular DIMM socket but most =
of
> the SPD data is the same so it's easy enough to patch it here to match wh=
at
> real hardware may have. Otherwise spd_data_generate should have a lot of
> options for all different possibilites different boards might have.

Ok, fair enough.

>=20
> (Also this is an example that unexpected configs might still work:
>=20
> $ qemu-system-ppc -M sam460ex -m 64 -serial stdio
> qemu-system-ppc: warning: Memory size is too small for SDRAM type, adjust=
ing type
> [...]
> DRAM:  64 MiB (ECC not enabled, 460 MHz, CL0)
>=20
> This SoC has a DRAM controller which accepts both DDR and DDR2 and the
> firmware does not care either so it works even if this cannot happen on r=
eal
> hardware. The spd_data[20] is different for DDR2 and DDR/SDR but in the
> latter it's ~WE latency which does not matter either so it can be set
> unconditionally. If this was not working the board code could check
> spd_data[2] !=3D DDR2 and then abort itself.)
>=20
> Regards,
> BALATON Zoltan
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DwoPkXS38qd3dnhB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwta3EACgkQbDjKyiDZ
s5LfSRAAixeNr7SzLpcQ059OntZvi4OOZDRxVwfG9Jmn6oXwrNgV8ozjlme0hbX7
uF30X36jibQuA7kt7xp++2sVZgpxi6bXO8uQnmPIC5RnfQSHh4c7cBngTsM4WuQ4
zDvrnUwZEot48m/Qrxmaw0gsXiYTIRYYwSktMo7rtZc51Dy5TIMP9ov/uiKOFMGQ
aSR4VBIcC30GGqn0zvSCqzlKTo7Dpn2me7H5rkj+IIt8+Do+sF6rhkQILXXK7MyP
sKF+wCPp8bFMFDvj4VslVV2vItm8m/Cnc8lWbc3leyXz7xMt0zujDdzADW1d0/zI
7MzjU0l4Dzbdb2bZzDu3YGYy22Z/CaaC/Hq4AugNUoxS+dvpg5IwxJRaDsfQ7Qg3
Veno6IShDUAdOpGtBjH8IpLKs7s2A8v81zy2BBgXYddO/l6mYUrKh9AzJI9n4o/9
UFurgFhSDZdJZWeaDtDXMAKcbmpuNnvCo2SwwuPqNUscKOlm/GNxUnPYl3sjbdgm
N1ntBInwjd8fhQJdHG3K7j62J+90gIW/TA/8wRY/4OChMvUQsMEzBBkU7UPIE9ZY
c4VM1ZYJaM7MVKsNiunLHGnphfwT5bxc0dmQEA9demOvxEiiRj4IFSe/xAq8/it2
1t4acHIXgHyVTlWvEWS/6ZG4KM/DCGypq/xyOSGsui2M3AubJEI=
=IFGp
-----END PGP SIGNATURE-----

--DwoPkXS38qd3dnhB--
