Received: from eggs.gnu.org ([2001:4830:134:3::10]:58296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTbqI-0005x3-T2
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 19:39:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTbqH-00043x-Nb
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 19:39:50 -0400
Date: Thu, 14 Jun 2018 22:42:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180614124237.GC19339@umbus.fritz.box>
References: <cover.1528935420.git.balaton@eik.bme.hu>
	<a9d502cce05cfa57895c415164efd288f4926fb6.1528935420.git.balaton@eik.bme.hu>
	<20180614013532.GE3042@umbus.fritz.box>
	<alpine.BSF.2.21.1806140955020.19899@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O3RTKUHj+75w1tg5"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1806140955020.19899@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v3 8/9] sm501: Perform a full update after
 palette change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Sebastian Bauer <mail@sebastianbauer.info>


--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2018 at 10:00:50AM +0200, BALATON Zoltan wrote:
> On Thu, 14 Jun 2018, David Gibson wrote:
> > On Thu, Jun 14, 2018 at 02:17:00AM +0200, BALATON Zoltan wrote:
> > > From: Sebastian Bauer <mail@sebastianbauer.info>
> > >=20
> > > Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>
> > > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >=20
> > Commit message.  Why is this necessary?
>=20
> Maybe because changing palette does not change display unless an update is
> done and dirty tracking which is used in update_display does not detect
> changes in device registers where palette is stored.
>=20
> I'm not sure this is needed in all modes but I guess palette is not used =
in
> modes that are not indexed so unecessary updates should not happen evem in
> those cases because if palette is not used anyway, guest is unlikely to
> change it unless doing something really strange but we haven't seen any
> guests yet that would do that. Therefore this simple way of handling this
> should be OK.

Sure, so, put that into a commit message in the next spin.

>=20
> Regards,
> BALATON Zoltan
>=20
> > > ---
> > >  hw/display/sm501.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >=20
> > > diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> > > index 0625cf5..a2ee6e3 100644
> > > --- a/hw/display/sm501.c
> > > +++ b/hw/display/sm501.c
> > > @@ -479,6 +479,7 @@ typedef struct SM501State {
> > >      MemoryRegion twoD_engine_region;
> > >      uint32_t last_width;
> > >      uint32_t last_height;
> > > +    uint32_t do_full_update; /* perform a full update next time */
> > >      I2CBus *i2c_bus;
> > >=20
> > >      /* mmio registers */
> > > @@ -1032,6 +1033,7 @@ static void sm501_palette_write(void *opaque, h=
waddr addr,
> > >=20
> > >      assert(range_covers_byte(0, 0x400 * 3, addr));
> > >      *(uint32_t *)&s->dc_palette[addr] =3D value;
> > > +    s->do_full_update =3D 1;
> > >  }
> > >=20
> > >  static uint64_t sm501_disp_ctrl_read(void *opaque, hwaddr addr,
> > > @@ -1620,6 +1622,12 @@ static void sm501_update_display(void *opaque)
> > >          full_update =3D 1;
> > >      }
> > >=20
> > > +    /* someone else requested a full update */
> > > +    if (s->do_full_update) {
> > > +        s->do_full_update =3D 0;
> > > +        full_update =3D 1;
> > > +    }
> > > +
> > >      /* draw each line according to conditions */
> > >      snap =3D memory_region_snapshot_and_clear_dirty(&s->local_mem_re=
gion,
> > >                offset, width * height * src_bpp, DIRTY_MEMORY_VGA);
> >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsiYr0ACgkQbDjKyiDZ
s5L+8RAA3wJoVHt1BBZjMO0/NOoAch867niVjQ6mIsdyXl4uyppDjLJ2O62xkUdg
ke2EnjlSixgHzdEiqEfjAbmmglBs8F/WDNEXAbNUhmJ06G+PW0CCyVRK79g33ZZS
/gMFnyKKRWdKGx1guwkEalJON3vXUS4mvFU8sNxj5BBioVNCL5aSg3mAvoFKf1Qh
EyF7ZCL8taT7FNqn1Hucf+S1Hxxi9pRMbvjYuVbdF1g4PAyqqEvAXXlLT+jfVbgR
KIftc69mUM34nuwUF7fJVV8FLhWOdiA5DaI19aFyyaR9Qsp+xhnH/shmLKcbr6dI
WSHSHb3IpR9jcLZGszJxhlWYoLmvKrDTqgVHSg7E/j5Uasb2miMJO3B8MVHs1+I1
HhcPZ0HyxJEMb3YiFsZ/ll1WXBmCDgo1HdGN0fwK3ubhjM35IJwnFWelMk3ANVt8
ryp9jfOmUKOrXfkXjaBaAj+AgtMZIJYvmVeWcAh8q9QvxHuf+u7pIEO/4+O+Y30J
QZTJFJ/BBpb91O7pV8RcqgbAJcFgH9/6417m8nH5/kwYlOQhLYmVFV2bKfsb0gr3
V8goVDMtwI2WLm2CLs7kjW03unPo/R11snziSoLUTmo8wGdSZMCk6v1coZ/fxhLd
hkK2skOVye6lMLlkh2nN64j837aOWjoqkF9VMJhNuj+wxU0FKWM=
=lnHE
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--
