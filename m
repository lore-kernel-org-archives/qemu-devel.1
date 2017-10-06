Received: from eggs.gnu.org ([2001:4830:134:3::10]:45538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0Re2-0007YX-BB
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0Rdz-00013p-J9
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:22:22 -0400
Date: Fri, 6 Oct 2017 22:25:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171006112503.GB10050@umbus.fritz.box>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-19-git-send-email-imammedo@redhat.com>
	<20171006083419.GW3260@umbus.fritz.box>
	<20171006113054.2af54a45@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline
In-Reply-To: <20171006113054.2af54a45@nial.brq.redhat.com>
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


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2017 at 11:30:54AM +0200, Igor Mammedov wrote:
> On Fri, 6 Oct 2017 19:34:19 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Oct 05, 2017 at 06:24:45PM +0200, Igor Mammedov wrote:
> > > use common cpu_model prasing in vl.c and set default cpu_model
> > > using generic MachineClass::default_cpu_type.
> > >=20
> > > Beside of switching to generic infrastructure it solves several
> > > issues.
> > >=20
> > >  * ppc_cpu_class_by_name() is used to deal with lower/upper case
> > >    and alias translations into actual cpu type, which fixes
> > >     '-M powernv -cpu power8' and '-M powernv -cpu power9_v1.0'
> > >    usecases which error out with:
> > >     'invalid CPU model 'FOO' for powernv machine'
> > >  * allows to switch to lower-case typenames in pnv chip/core name
> > >    (by convention typnames should be lower-case)
> > >  * replace aliased names /power8, power9, .../ with exact cpu model
> > >    names (i.e. typenames should be stable but aliases might decide to
> > >    point to other cpu model withi family or changed by kvm). It will
> > >    also help to simplify pnv_chip/core code and get rid of dependency
> > >    on cpu_model parsing.
> > >=20
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > ---
> > >  include/hw/ppc/pnv.h |  8 ++++----
> > >  hw/ppc/pnv.c         | 22 ++++++++++------------
> > >  hw/ppc/pnv_core.c    |  2 +-
> > >  3 files changed, 15 insertions(+), 17 deletions(-)
> > >=20
> > > diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> > > index 9c5437d..2525f7f 100644
> > > --- a/include/hw/ppc/pnv.h
> > > +++ b/include/hw/ppc/pnv.h
> > > @@ -80,19 +80,19 @@ typedef struct PnvChipClass {
> > >      uint32_t (*core_pir)(PnvChip *chip, uint32_t core_id);
> > >  } PnvChipClass;
> > > =20
> > > -#define TYPE_PNV_CHIP_POWER8E TYPE_PNV_CHIP "-POWER8E"
> > > +#define TYPE_PNV_CHIP_POWER8E TYPE_PNV_CHIP "-power8e_v2.1"
> > >  #define PNV_CHIP_POWER8E(obj) \
> > >      OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP_POWER8E)
> > > =20
> > > -#define TYPE_PNV_CHIP_POWER8 TYPE_PNV_CHIP "-POWER8"
> > > +#define TYPE_PNV_CHIP_POWER8 TYPE_PNV_CHIP "-power8_v2.0"
> > >  #define PNV_CHIP_POWER8(obj) \
> > >      OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP_POWER8)
> > > =20
> > > -#define TYPE_PNV_CHIP_POWER8NVL TYPE_PNV_CHIP "-POWER8NVL"
> > > +#define TYPE_PNV_CHIP_POWER8NVL TYPE_PNV_CHIP "-power8nvl_v1.0"
> > >  #define PNV_CHIP_POWER8NVL(obj) \
> > >      OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP_POWER8NVL)
> > > =20
> > > -#define TYPE_PNV_CHIP_POWER9 TYPE_PNV_CHIP "-POWER9"
> > > +#define TYPE_PNV_CHIP_POWER9 TYPE_PNV_CHIP "-power9_v1.0" =20
> >=20
> > Uh.. we really should add a DD2 power9 before we make this change.
> > Making a DD1.0 (read, buggy as hell) chip the default is not
> > sensible.  Especially since we don't implement the various DD1 bugs
> > and differences in qemu.
> I guess pnv owner will have to it,
> I can't help here /me uses whatever is in code right now/

I just committed a patch to ppc-for-2.11 that adds POWER9 v2.0 to the
code (and makes it the default).  Sorry, this will probably require a
rebase of your stuff.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnXaA0ACgkQbDjKyiDZ
s5KBAQ//T6BhTImxxX9ju2ZUBIWU5gFa/x138AahC/opbpktkzNHaX62XoXhX1JF
zZXE0ZAOB1QBhoCtFQ03eHIPMpVuH/XVgkWwyc/5OWk0FNYu/VLHG65ZMr6c8Pve
7oOtujte7fJ+GrtxE4DRtRJ9Ik+nxjQ1entV2cKLvmuoxZW01nuiyBJ+V0HXBBzY
RIrIl3OnA9Fhak7B/gzMkawHUTpg+3r6bUOGs7WCU7EaEkmdBYNHFuNOuCEftUBx
VczD8Li4lEuI/5e87gKOjTWGZyH71OrTeZbEWOnjD7B/+pEwilcJU6t1w+d1guQM
7lW2Dnq4ExsURh61/11IfLSG+YkhHzMlBNaJRxnpQmBqP1yZDRMwv07+X21GqeGH
TpR3c0UtP+41CGEJjd17kt7R9g1gllf6wc9tmwGlDQJwlenG4q6xaf3BMMEiemuh
rqoUtBDAHli2nIUStSWoUpzWHJJsnOt/plj/YeH3DKw15vbJk0CsHYYxBS+JbSOe
x2z/ksEkRZdS5Zw1njWpvJRji3rok4TPMrUxc2vGRVIPBbpbeWTBCbabhkVZT2lm
n5jO1mGMaiIP3LbN9Q/+7lBhQxho3kAviRbcRcZ6JgZpHqttRjDWZo37rQi/VBox
k3N+FwGyMkakrHTOdqFPaA2bIfdAduJyOs890BkZXcxQgyZ7Tjc=
=FQXm
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
