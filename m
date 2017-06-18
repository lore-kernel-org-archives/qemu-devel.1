Received: from eggs.gnu.org ([2001:4830:134:3::10]:42141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dMZGH-00008T-Qb
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 08:25:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dMZGE-0000rZ-Mn
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 08:25:01 -0400
Date: Sun, 18 Jun 2017 19:30:43 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170618113043.GE22449@umbus>
References: <1497245555-32472-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1497245555-32472-2-git-send-email-bharata@linux.vnet.ibm.com>
	<20170612091044.GE18542@umbus> <20170613044818.GE27525@in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PPYy/fEw/8QCHSq3"
Content-Disposition: inline
In-Reply-To: <20170613044818.GE27525@in.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v6 1/2] spapr: Add a "no HPT" encoding to
 HTAB migration stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com, sjitindarsingh@gmail.com


--PPYy/fEw/8QCHSq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2017 at 10:18:18AM +0530, Bharata B Rao wrote:
> On Mon, Jun 12, 2017 at 05:10:44PM +0800, David Gibson wrote:
> > On Mon, Jun 12, 2017 at 11:02:34AM +0530, Bharata B Rao wrote:
> > > Add a "no HPT" encoding (using value -1) to the HTAB migration
> > > stream (in the place of HPT size) when the guest doesn't allocate HPT.
> > > This will help the target side to match target HPT with the source HPT
> > > and thus enable successful migration.
> > >=20
> > > Suggested-by: David Gibson <david@gibson.dropbear.id.au>
> > > Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> > > ---
> > >  hw/ppc/spapr.c | 29 +++++++++++++++++++++++++----
> > >  1 file changed, 25 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 8b541d9..c425499 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -1558,13 +1558,19 @@ static int htab_save_setup(QEMUFile *f, void =
*opaque)
> > >      sPAPRMachineState *spapr =3D opaque;
> > > =20
> > >      /* "Iteration" header */
> > > -    qemu_put_be32(f, spapr->htab_shift);
> > > +    if (!spapr->htab_shift) {
> > > +        qemu_put_be32(f, -1);
> > > +    } else {
> > > +        qemu_put_be32(f, spapr->htab_shift);
> > > +    }
> > > =20
> > >      if (spapr->htab) {
> > >          spapr->htab_save_index =3D 0;
> > >          spapr->htab_first_pass =3D true;
> > >      } else {
> > > -        assert(kvm_enabled());
> > > +        if (spapr->htab_shift) {
> > > +            assert(kvm_enabled());
> > > +        }
> > >      }
> > > =20
> > > =20
> > > @@ -1710,7 +1716,12 @@ static int htab_save_iterate(QEMUFile *f, void=
 *opaque)
> > >      int rc =3D 0;
> > > =20
> > >      /* Iteration header */
> > > -    qemu_put_be32(f, 0);
> > > +    if (!spapr->htab_shift) {
> > > +        qemu_put_be32(f, -1);
> > > +        return 0;
> > > +    } else {
> > > +        qemu_put_be32(f, 0);
> > > +    }
> > > =20
> > >      if (!spapr->htab) {
> > >          assert(kvm_enabled());
> > > @@ -1744,7 +1755,12 @@ static int htab_save_complete(QEMUFile *f, voi=
d *opaque)
> > >      int fd;
> > > =20
> > >      /* Iteration header */
> > > -    qemu_put_be32(f, 0);
> > > +    if (!spapr->htab_shift) {
> > > +        qemu_put_be32(f, -1);
> > > +        return 0;
> > > +    } else {
> > > +        qemu_put_be32(f, 0);
> > > +    }
> >=20
> > Do you actually need the modifications for _iterate and _complete?  I
> > would have thought you just wouldn't need to send any more of the HPT
> > stream at all after sending the -1 header. =20
>=20
> _setup, _iterate, _complete handler routines for HTAB always get interspe=
rsed
> with similar routines for ram savevm handlers as per what I have seen.
> And moreover these are called by the core migration code and hence we the=
y get
> called, we need these changes to ensure that we don't attempt to send HPT
> stream.

Ah, yes of course.

> > We should also adjust the downtime estimation logic so we don't allow
> > for transferring an HPT that isn't there.
>=20
> I will have to check that out.
>=20
> >=20
> > >      if (!spapr->htab) {
> > >          int rc;
> > > @@ -1788,6 +1804,11 @@ static int htab_load(QEMUFile *f, void *opaque=
, int version_id)
> > > =20
> > >      section_hdr =3D qemu_get_be32(f);
> > > =20
> > > +    if (section_hdr =3D=3D -1) {
> > > +        spapr_free_hpt(spapr);
> > > +        return 0;
> > > +    }
> >=20
> > Strictly speaking we probably shouldn't just return here.  We should
> > wait and see if there is more data in the stream.
>=20
> Because of the way the source sends data (with HPT data getting
> interspersed with ram data, I don't think we can say for sure if
> we got or will get any HPT data following the no-HPT indication.

We definitely shouldn't - there's no way the destination could handle
it without knowing the size first.  We could get a new header giving
an HPT size, and then get HPT data.


> > Any actual content
> > (i.e. section_hdr =3D=3D 0 sections) would be an error at this point.
> > However, a reset to an HPT guest would be represented by a new
> > non-zero section header, then more data.  This isn't urgent, but it
> > would be nice to fix at some point.
>=20
> Sure.
>=20
> Regards,
> Bharata.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PPYy/fEw/8QCHSq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZRmRgAAoJEGw4ysog2bOSy6IQAOCnEDtJm6E4zG+FkZW6PwZd
/QWGJ/ifuGlmmBrgGMU8HPwbFmrqpnvuJgeuOcEywt5GHlhQ7dRe0DZfOAXiOKJg
L2/m4JgVvaQvJVhuD5JaM2ZWRkZh7f+MtL8+egG8MeUK/ZAal7fJEFv2ESvZ/M/o
a3nghu13lo5tL2HuFb9vyT2Kwr1KFggpVfzALw9fMz6Dw/C7HgASGWIbM9IJ2w0E
ngKHI7gloBZ0LNvxq55DbHhsDZK7cBlr+Zrei6rT/4smFWUS/Xwljnz5bgC6Ehcz
72Br6g+UphxOmaoPAuKdUdLCsnjx25Zk3m83aIJ+XLQ4Bay10NnvSsebNaLUkvGl
0sPnxj5aMWdHddqCCmt8jTwSOBEMKIt1nuPjwSjzINzDUZK/qfPrR/c/uOrOjCl2
eRYL23YTxFD1ma6gO+Br+fFsNSJ5164LL28ngFmbgJ9vrFJ0IuV60SphMTyvdkYy
P54GXuHYGdHwzO82JeJafphmCkJEiEqh1L99aoxTsOA/uKMLUbMlTKottsYXiKik
PoXTdykcI6xycGRH9dNrg+nozZvoMcBYDJEd4oLsttfnWyIKfNNe4YKxZMhsqOqE
z8PfNH5PZXQ5nCLAhDymNA1BZkuO+UkeVpi4CuR141zI1Idx2w/gkfbIEpL7N3q8
BAowlwC9Pq2FHt3JZaPQ
=Qu+U
-----END PGP SIGNATURE-----

--PPYy/fEw/8QCHSq3--
