Received: from eggs.gnu.org ([2001:4830:134:3::10]:38251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e1SsZ-0005qN-S8
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 03:53:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e1SsW-0001WU-2L
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 03:53:35 -0400
Date: Mon, 9 Oct 2017 17:59:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171009065932.GR10050@umbus.fritz.box>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-19-git-send-email-imammedo@redhat.com>
	<20171006083419.GW3260@umbus.fritz.box>
	<20171006113054.2af54a45@nial.brq.redhat.com>
	<20171006112503.GB10050@umbus.fritz.box>
	<20171009074415.71d9dbba@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FiqEyLLt06qkB6ow"
Content-Disposition: inline
In-Reply-To: <20171009074415.71d9dbba@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH 18/23] ppc: pnv: use generic cpu_model
 parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>


--FiqEyLLt06qkB6ow
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 09, 2017 at 07:44:15AM +0200, Igor Mammedov wrote:
> On Fri, 6 Oct 2017 22:25:03 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Fri, Oct 06, 2017 at 11:30:54AM +0200, Igor Mammedov wrote:
> > > On Fri, 6 Oct 2017 19:34:19 +1100
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >  =20
> > > > On Thu, Oct 05, 2017 at 06:24:45PM +0200, Igor Mammedov wrote: =20
> > > > > use common cpu_model prasing in vl.c and set default cpu_model
> > > > > using generic MachineClass::default_cpu_type.
> > > > >=20
> > > > > Beside of switching to generic infrastructure it solves several
> > > > > issues.
> > > > >=20
> > > > >  * ppc_cpu_class_by_name() is used to deal with lower/upper case
> > > > >    and alias translations into actual cpu type, which fixes
> > > > >     '-M powernv -cpu power8' and '-M powernv -cpu power9_v1.0'
> > > > >    usecases which error out with:
> > > > >     'invalid CPU model 'FOO' for powernv machine'
> > > > >  * allows to switch to lower-case typenames in pnv chip/core name
> > > > >    (by convention typnames should be lower-case)
> > > > >  * replace aliased names /power8, power9, .../ with exact cpu mod=
el
> > > > >    names (i.e. typenames should be stable but aliases might decid=
e to
> > > > >    point to other cpu model withi family or changed by kvm). It w=
ill
> > > > >    also help to simplify pnv_chip/core code and get rid of depend=
ency
> > > > >    on cpu_model parsing.
> > > > >=20
> > > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > > > ---
> > > > >  include/hw/ppc/pnv.h |  8 ++++----
> > > > >  hw/ppc/pnv.c         | 22 ++++++++++------------
> > > > >  hw/ppc/pnv_core.c    |  2 +-
> > > > >  3 files changed, 15 insertions(+), 17 deletions(-)
> > > > >=20
> > > > > diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> > > > > index 9c5437d..2525f7f 100644
> > > > > --- a/include/hw/ppc/pnv.h
> > > > > +++ b/include/hw/ppc/pnv.h
> > > > > @@ -80,19 +80,19 @@ typedef struct PnvChipClass {
> > > > >      uint32_t (*core_pir)(PnvChip *chip, uint32_t core_id);
> > > > >  } PnvChipClass;
> > > > > =20
> > > > > -#define TYPE_PNV_CHIP_POWER8E TYPE_PNV_CHIP "-POWER8E"
> > > > > +#define TYPE_PNV_CHIP_POWER8E TYPE_PNV_CHIP "-power8e_v2.1"
> > > > >  #define PNV_CHIP_POWER8E(obj) \
> > > > >      OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP_POWER8E)
> > > > > =20
> > > > > -#define TYPE_PNV_CHIP_POWER8 TYPE_PNV_CHIP "-POWER8"
> > > > > +#define TYPE_PNV_CHIP_POWER8 TYPE_PNV_CHIP "-power8_v2.0"
> > > > >  #define PNV_CHIP_POWER8(obj) \
> > > > >      OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP_POWER8)
> > > > > =20
> > > > > -#define TYPE_PNV_CHIP_POWER8NVL TYPE_PNV_CHIP "-POWER8NVL"
> > > > > +#define TYPE_PNV_CHIP_POWER8NVL TYPE_PNV_CHIP "-power8nvl_v1.0"
> > > > >  #define PNV_CHIP_POWER8NVL(obj) \
> > > > >      OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP_POWER8NVL)
> > > > > =20
> > > > > -#define TYPE_PNV_CHIP_POWER9 TYPE_PNV_CHIP "-POWER9"
> > > > > +#define TYPE_PNV_CHIP_POWER9 TYPE_PNV_CHIP "-power9_v1.0"   =20
> > > >=20
> > > > Uh.. we really should add a DD2 power9 before we make this change.
> > > > Making a DD1.0 (read, buggy as hell) chip the default is not
> > > > sensible.  Especially since we don't implement the various DD1 bugs
> > > > and differences in qemu. =20
> > > I guess pnv owner will have to it,
> > > I can't help here /me uses whatever is in code right now/ =20
> >=20
> > I just committed a patch to ppc-for-2.11 that adds POWER9 v2.0 to the
> > code (and makes it the default).  Sorry, this will probably require a
> > rebase of your stuff.
> Do you have a pointer to the patch or even better ppc staging tree to reb=
ase on?

Oh, sorry, when I say 'ppc-for-2.11' I'm referring to that staging
tree.  You can find it at:

git://github.com/dgibson/qemu.git branch 'ppc-for-2.11'.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FiqEyLLt06qkB6ow
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnbHk8ACgkQbDjKyiDZ
s5KWEw//caYqieqWl/CWrI1OQ6yeuiFC+kjbopOnB1umjExgILwCNjqUiQKVUcaB
X2YFo88wCjK92HzbJ1wQu1sTgaZJGJXjSKyakMIWIwsvs1f0b1hfhaZwX18jDqVL
VOpPS0+u2CCx9spswVeO74UUaFV2EXV2nR3w2Ls9UO5asUu9CeA0mjh6x5H9mP7F
cvQKX/+mLt1ARTKrsldjSwqka9v9XERLke+AAK2K1jgytaRktn0T7SDg9kqPODfl
w+hdd20c2TJt3lOtd+8EWrr2gUR/MwX565L6UYw/DTs70uNTCYJZ9xzaISufSxJS
Ren2wUMSTEGjHlD6QhRRrxkZ0R2xD5re9b1YaVBLsOGMmeQKl2BRUcOQbvJwCVem
+AmvmwOtBkwpfwGBnZuPNbOBbwHKXXC9OD5mNa9NpuACbxh4hF0+5lUFF+euVL1p
RSfceRb+qsyWMScGoEWB4K0b7JixWqSj7tympI63ndpwbvx8TviqdDS2gsRy79Qs
HZbAetZWTTNWZwC5+fy5whNHS6EQAFFghJWRkUT4mwtnG1te6XH/Rmd7hupH6i6w
+qem13VTRrVnzuJcVfqLDhw2eArByp0FlzRFignGS3xjqBlxtrGi1AhC5Gj0mn9P
GdDh3BsURe/ATV/v2j6j1C7Xf0mGR2QjDwNsg+mHDzLwz6kG86I=
=C6j3
-----END PGP SIGNATURE-----

--FiqEyLLt06qkB6ow--
