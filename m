Received: from eggs.gnu.org ([2001:4830:134:3::10]:45522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dnIVE-0003IC-Rg
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 01:58:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dnIVD-0001Tr-J9
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 01:58:56 -0400
Date: Thu, 31 Aug 2017 15:54:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170831055448.GL3386@umbus.fritz.box>
References: <1503562911-2776-1-git-send-email-imammedo@redhat.com>
	<1503562911-2776-6-git-send-email-imammedo@redhat.com>
	<20170825041644.GB2772@umbus.fritz.box>
	<20170825094037.4973225e@nial.brq.redhat.com>
	<20170825093229.GH2772@umbus.fritz.box>
	<20170830125033.340d7ca2@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XbHSybK3LHOYQtWI"
Content-Disposition: inline
In-Reply-To: <20170830125033.340d7ca2@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 5/6] ppc: simplify cpu model
 lookup by PVR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>


--XbHSybK3LHOYQtWI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2017 at 12:50:33PM +0200, Igor Mammedov wrote:
> On Fri, 25 Aug 2017 19:32:29 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Fri, Aug 25, 2017 at 09:40:37AM +0200, Igor Mammedov wrote:
> > > On Fri, 25 Aug 2017 14:16:44 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >  =20
> > > > On Thu, Aug 24, 2017 at 10:21:50AM +0200, Igor Mammedov wrote: =20
> > > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > > > ---
> > > > >  target/ppc/translate_init.c | 27 +++++++++++----------------
> > > > >  1 file changed, 11 insertions(+), 16 deletions(-)
> > > > >=20
> > > > > diff --git a/target/ppc/translate_init.c b/target/ppc/translate_i=
nit.c
> > > > > index f1a559d..ca9f1e3 100644
> > > > > --- a/target/ppc/translate_init.c
> > > > > +++ b/target/ppc/translate_init.c
> > > > > @@ -34,6 +34,7 @@
> > > > >  #include "hw/ppc/ppc.h"
> > > > >  #include "mmu-book3s-v3.h"
> > > > >  #include "sysemu/qtest.h"
> > > > > +#include "qemu/cutils.h"
> > > > > =20
> > > > >  //#define PPC_DUMP_CPU
> > > > >  //#define PPC_DEBUG_SPR
> > > > > @@ -10203,22 +10204,16 @@ static ObjectClass *ppc_cpu_class_by_na=
me(const char *name)
> > > > >      char *cpu_model, *typename;
> > > > >      ObjectClass *oc;
> > > > >      const char *p;
> > > > > -    int i, len;
> > > > > -
> > > > > -    /* Check if the given name is a PVR */
> > > > > -    len =3D strlen(name);
> > > > > -    if (len =3D=3D 10 && name[0] =3D=3D '0' && name[1] =3D=3D 'x=
') {
> > > > > -        p =3D name + 2;
> > > > > -        goto check_pvr;
> > > > > -    } else if (len =3D=3D 8) {
> > > > > -        p =3D name;
> > > > > -    check_pvr:
> > > > > -        for (i =3D 0; i < 8; i++) {
> > > > > -            if (!qemu_isxdigit(*p++))
> > > > > -                break;
> > > > > -        }
> > > > > -        if (i =3D=3D 8) {
> > > > > -            return OBJECT_CLASS(ppc_cpu_class_by_pvr(strtoul(nam=
e, NULL, 16)));
> > > > > +    unsigned long pvr;
> > > > > +
> > > > > +    /* Lookup by PVR if cpu_model is valid 8 digit hex number
> > > > > +     * (excl: 0x prefix if present)
> > > > > +     */
> > > > > +    if (!qemu_strtoul(name, &p, 16, &pvr)) {
> > > > > +        int len =3D p - name;
> > > > > +        len =3D (len =3D=3D 10) && (name[1] =3D=3D 'x') ? len - =
2 : len;
> > > > > +        if (len =3D=3D 8) {
> > > > > +            return OBJECT_CLASS(ppc_cpu_class_by_pvr(pvr));   =
=20
> > > >=20
> > > > This doesn't look quite right.  A hex string of a PVR followed by
> > > > other stuff isn't a valid option, so if p (endptr) doesn't point to
> > > > the end of the string, then we shouldn't be using this path =20
> > > yep, my mistake, I've lost somewhere *p =3D=3D '\0' check when cleani=
ng up the patch =20
> >=20
> > Ok.
> >=20
> > > >(from the
> > > > looks of qemu_strtoul() we can simply omit the endptr parameter to =
get
> > > > that behaviour).  I'm not sure what the messing around with len is
> > > > for, either.  If it's a valid hex string we can try this, I don't s=
ee
> > > > that we need further checks. =20
> > > I've tried to keep current limitation here i.e. 8 hex symbols,
> > > but if any hex number is fine then doing
> > >  qemu_strtoul(name, NULL, 16, &pvr)
> > > is even better, so would you prefer to drop 8 symbol check altogether=
? =20
> >=20
> > Yeah, I don't see any value to the 8 character check.
> there are cpu models consisting of pure numbers =3D> valid hex number
> so if check is dropped then it lookup will go PVR route,
> that will fail there.
> So check should be there to avoid regression.

Ah.  Good point.

> I'll fix whole string consumption check that I've missed before
> and respin with it.
>=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XbHSybK3LHOYQtWI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmnpKQACgkQbDjKyiDZ
s5IXCQ/8DY6s9TSMtk4pMT3hD1kRSpHpMWNhDO5SYRstvpOJuWO0WG9GfGLNZL0y
RZWdHbaug3POe0DXCP/LsuojFr/O8YKommLPhcQVNXbgfN0Mdk9UuN6hf9rqZAvr
72g70lBmo4mXnvNe6Lv2ks1+u+9E8MHcJamczYAKJQ9tgfaCVWxoRPPwzl9eojHB
Ei6h+P9hBBwoWHdFxgp4iJF9GSRkiKKwhJ8hXf+mpoXrDPBUO87v8XG4+QTB+iQY
E7Zwe+RSnTgxatuchEO3qfBXbTLTz2hUdvWx6Y8wN+wcynGlnXKNflO0O/BpVowE
t8r3vZ5N/RBMe6+G6ghgmCIwhOE7E2wEHyl6DHIYWmetxWSfh99PV/csxhEpjfwA
2SKhmbr1sjtnUGCKr21xaZOp+oAUfJ8gBUsXckiJJ0hE/JbDDQb4xuNCOJyhwymu
8g/BAGo3sd6JbKAOW0zmGUrv8Ert2O6RySKBMHKgNpLWgV94khgMl50lfRfH9eSl
xaPCGfQo/IQlwuCiOZLEqPidwJoqIHVbCI5D0hGyzgOu1IWu3GS4AwmvP8HMk9Qo
GpaizuZrtZGWAT1cXVCgsMxgPtbsRJlCeWo2prlF52HUtfK2SM3h3zv7ipV8v7lb
ngpYKvOjNLx8DfRokivNpjyz9xhIvmwWAW0n21vaKRSAZUwKLyU=
=jNBs
-----END PGP SIGNATURE-----

--XbHSybK3LHOYQtWI--
