Received: from eggs.gnu.org ([2001:4830:134:3::10]:59647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYkob-0002uJ-0q
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 21:38:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYkoX-0004sT-4C
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 21:38:33 -0500
Date: Wed, 1 Feb 2017 13:25:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170201022545.GK30639@umbus.fritz.box>
References: <1485868446-10587-1-git-send-email-mst@redhat.com>
	<1485868446-10587-4-git-send-email-mst@redhat.com>
	<20170131221628.GN14879@umbus.fritz.box>
	<20170201033722-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J2pR2RtFp0tAjF3C"
Content-Disposition: inline
In-Reply-To: <20170201033722-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PULL v3 03/21] ppc: switch to constants within
 BUILD_BUG_ON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


--J2pR2RtFp0tAjF3C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 01, 2017 at 03:37:54AM +0200, Michael S. Tsirkin wrote:
> On Wed, Feb 01, 2017 at 09:16:28AM +1100, David Gibson wrote:
> > On Tue, Jan 31, 2017 at 03:14:29PM +0200, Michael S. Tsirkin wrote:
> > > We are switching BUILD_BUG_ON to verify that it's parameter is a
> > > compile-time constant, and it turns out that some gcc versions
> > > (specifically gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609) are
> > > not smart enough to figure it out for expressions involving local
> > > variables. This is harmless but means that the check is ineffective f=
or
> > > these platforms.  To fix, replace the variable with macros.
> > >=20
> > > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >=20
> > Ugh.. I pulled this into my tree already (I've been having trouble
> > with my test setup, which is why I haven't sent my own pullreq yet).
> > However, it needs a s/%u/%llu/ to compile correctly on some platforms.
>=20
> I need it to avoid breaking build. I fixed it up - want to drop it
> from you tree? Or leave it there - git will resolve the trivial
> conflict.

Since you've already sent a pull, I'm guessing it will be merged by
the time I'm able to get my pullreq together.  Since I'll rebase
before that, I expect it will drop out of my tree naturally.

>=20
> > > ---
> > >  hw/ppc/spapr.c | 14 ++++++++------
> > >  1 file changed, 8 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index a642e66..b81f2ac 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -2630,8 +2630,8 @@ static void spapr_phb_placement(sPAPRMachineSta=
te *spapr, uint32_t index,
> > >       * 1TiB 64-bit MMIO windows for each PHB.
> > >       */
> > >      const uint64_t base_buid =3D 0x800000020000000ULL;
> > > -    const int max_phbs =3D
> > > -        (SPAPR_PCI_LIMIT - SPAPR_PCI_BASE) / SPAPR_PCI_MEM64_WIN_SIZ=
E - 1;
> > > +#define SPAPR_MAX_PHBS ((SPAPR_PCI_LIMIT - SPAPR_PCI_BASE) / \
> > > +                        SPAPR_PCI_MEM64_WIN_SIZE - 1)
> > >      int i;
> > > =20
> > >      /* Sanity check natural alignments */
> > > @@ -2640,12 +2640,14 @@ static void spapr_phb_placement(sPAPRMachineS=
tate *spapr, uint32_t index,
> > >      QEMU_BUILD_BUG_ON((SPAPR_PCI_MEM64_WIN_SIZE % SPAPR_PCI_MEM32_WI=
N_SIZE) !=3D 0);
> > >      QEMU_BUILD_BUG_ON((SPAPR_PCI_MEM32_WIN_SIZE % SPAPR_PCI_IO_WIN_S=
IZE) !=3D 0);
> > >      /* Sanity check bounds */
> > > -    QEMU_BUILD_BUG_ON((max_phbs * SPAPR_PCI_IO_WIN_SIZE) > SPAPR_PCI=
_MEM32_WIN_SIZE);
> > > -    QEMU_BUILD_BUG_ON((max_phbs * SPAPR_PCI_MEM32_WIN_SIZE) > SPAPR_=
PCI_MEM64_WIN_SIZE);
> > > +    QEMU_BUILD_BUG_ON((SPAPR_MAX_PHBS * SPAPR_PCI_IO_WIN_SIZE) >
> > > +                      SPAPR_PCI_MEM32_WIN_SIZE);
> > > +    QEMU_BUILD_BUG_ON((SPAPR_MAX_PHBS * SPAPR_PCI_MEM32_WIN_SIZE) >
> > > +                      SPAPR_PCI_MEM64_WIN_SIZE);
> > > =20
> > > -    if (index >=3D max_phbs) {
> > > +    if (index >=3D SPAPR_MAX_PHBS) {
> > >          error_setg(errp, "\"index\" for PAPR PHB is too large (max %=
u)",
> > > -                   max_phbs - 1);
> > > +                   SPAPR_MAX_PHBS - 1);
> > >          return;
> > >      }
> > > =20
> >=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--J2pR2RtFp0tAjF3C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYkUcpAAoJEGw4ysog2bOS6lkP/3L2d8Z1w/erZ/5TJCQwU7I/
f5SLVED3/6IEqg5OYNDVSuKCmNpxdFwU3Lmry46RrBBXjoVzkujk1bbrwGXH8SlR
w1qP6PXLzVLxf32QK2qBoGVkxgvrrKVRt8Eer1evxH13YEfgGoLLgzxaU+aLbvcc
TJnMRWIW9CU/ew+0k/dVaXID6XOQ2fwCIWQ2ItEHw3PzCK4+YD5bMTI+KzyxICLA
qRbUXbbv0ECIG/vdd0lYoesY2R+cFlqe8iXs6fwiWg0ExFHZnCG8tICZMQiINfwX
HnKrh1On6NfkPNrUnSnAbbOh7D0HME8anwO/4IdI59NSYUWazwSTepsGsvIUIzyz
rLAaAn6alP3R4C497Sc5KPNGKbZ7b6JVKpLN8WBqkwJn4AH+h8AXFluvKsHXzArA
oFTSMRhlh5G+GtBVDnKDn7ls0gKI3Tbek367/FTot+f4vCxxX4+38zmUs6S3DCDv
6mtxMH1ev9nrXZDf3+WnooDg7m0gRdiFjCH4h6xH8wZ5upEhNdEGgSENnYrkNuQA
aQP4x2kbYaNwxjBS3MXZiCpS/7o2mIzn7Bc4VVXeOJrID/smcDyALvJ/CIe3E4uE
cc/cuG6XgENpd2C6YOpw2Z73t3bqwzJPqujcLxluKeTdZ8PzCepmRvcbEzJBsByQ
ip+L9bpqsn1CkxOenwTv
=4mPN
-----END PGP SIGNATURE-----

--J2pR2RtFp0tAjF3C--
