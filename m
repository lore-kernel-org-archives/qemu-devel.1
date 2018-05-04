Received: from eggs.gnu.org ([2001:4830:134:3::10]:50070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEUEp-0006FP-3h
	for qemu-devel@nongnu.org; Fri, 04 May 2018 02:30:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEUEo-00018L-35
	for qemu-devel@nongnu.org; Fri, 04 May 2018 02:30:39 -0400
Date: Fri, 4 May 2018 16:30:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180504063027.GA13229@umbus.fritz.box>
References: <20180419062917.31486-1-david@gibson.dropbear.id.au>
	<20180419062917.31486-4-david@gibson.dropbear.id.au>
	<20180503155709.GA32363@kermit-br-ibm-com.br.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1mpN54+oXr72ab9j"
Content-Disposition: inline
In-Reply-To: <20180503155709.GA32363@kermit-br-ibm-com.br.ibm.com>
Subject: Re: [Qemu-devel] [RFC for-2.13 3/7] target/ppc: Add
 ppc_hash64_filter_pagesizes()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: groug@kaod.org, abologna@redhat.com, aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org


--1mpN54+oXr72ab9j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 12:57:09PM -0300, Murilo Opsfelder Araujo wrote:
> On Thu, Apr 19, 2018 at 04:29:13PM +1000, David Gibson wrote:
> > The paravirtualized PAPR platform sometimes needs to restrict the guest=
 to
> > using only some of the page sizes actually supported by the host's MMU.
> > At the moment this is handled in KVM specific code, but for consistency=
 we
> > want to apply the same limitations to all accelerators.
> >=20
> > This makes a start on this by providing a helper function in the cpu co=
de
> > to allow platform code to remove some of the cpu's page size definitions
> > via a caller supplied callback.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  target/ppc/mmu-hash64.c | 59 +++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  target/ppc/mmu-hash64.h |  3 +++
> >  2 files changed, 62 insertions(+)
> >=20
> > diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> > index a1db20e3a8..b6e62864fd 100644
> > --- a/target/ppc/mmu-hash64.c
> > +++ b/target/ppc/mmu-hash64.c
> > @@ -1165,3 +1165,62 @@ const PPCHash64Options ppc_hash64_opts_POWER7 =
=3D {
> >          },
> >      }
> >  };
> > +
> > +void ppc_hash64_filter_pagesizes(PowerPCCPU *cpu,
> > +                                 bool (*cb)(void *, uint32_t, uint32_t=
),
> > +                                 void *opaque)
> > +{
> > +    PPCHash64Options *opts =3D cpu->hash64_opts;
> > +    int i;
> > +    int n =3D 0;
> > +    bool ci_largepage =3D false;
> > +
> > +    assert(opts);
> > +
> > +    n =3D 0;
> > +    for (i =3D 0; i < ARRAY_SIZE(opts->sps); i++) {
> > +        PPCHash64SegmentPageSizes *sps =3D &opts->sps[i];
> > +        int j;
> > +        int m =3D 0;
> > +
> > +        assert(n <=3D i);
> > +
> > +        if (!sps->page_shift) {
> > +            break;
> > +        }
> > +
> > +        for (j =3D 0; j < ARRAY_SIZE(sps->enc); j++) {
> > +            PPCHash64PageSize *ps =3D &sps->enc[j];
> > +
> > +            assert(m <=3D j);
> > +            if (!ps->page_shift) {
> > +                break;
> > +            }
> > +
> > +            if (cb(opaque, sps->page_shift, ps->page_shift)) {
> > +                if (ps->page_shift =3D=3D 16) {
> > +                    ci_largepage =3D true;
> > +                }
> > +                sps->enc[m++] =3D *ps;
> > +            }
>=20
> Hi, David.
>=20
> Is it possible that both sps->page_shift and ps->page_shift value 24?
> This seems to be a true case for spapr_pagesize_cb(), if I'm reading
> correctly.

Yes, that's possible; in fact, typical.

> Shouldn't ci_largepage also be set to true when ps->page_shift =3D=3D
> 24?

Ah.. yeah.. in order to match the existing logic this should be >=3D
16.  I've changed it in my draft.

Of course, I doubt that any guest would attempt to use 16MiB IO pages,
so I'm not sure it really matters, but.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1mpN54+oXr72ab9j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrr/gMACgkQbDjKyiDZ
s5KpQw//ZOpnDEwLniKmdi6PZlX1+n3PKPTtW0Ec931wY2IBDYbnd4clplfL3oI1
h76b+yr5LEIT1kp8Lb0HHHPcrJdj7J45vbhxT0hAHZetNSDRauQHUxvHgm37OvtU
9N7KidO7uRUXPYk8O+tNrXAT/iutD7XWcBTTZXKo9qb3iqyMOnKrLP6btNh/hLyU
5hbVIhqAmMjvDf2hDsjZew6agZlJwI6TS/VRZAruRTCvpnwmkckwsOytaUpKQ4pX
IvAZG3KgbN1xYYMTWVWG1iSwVf+R8fTWZJD/H92XyB38X3trzoD9Eq+px8JPG7WJ
J4ntuiG2XQ/NKvGUxNKcLNGLCn36FZcfSHieLNVQtksxgJo+lIkZ+OmzgS8iROfs
QLepjuRw2YkrwBhJkXX3ou6FCrDpiEwykGr2xBdajTl1MhlgDTNyy1tUDBv3xglA
Fle/RRg/RI+ncg6YQKvh056A5NWbp3kTlbhX3O0Qbx7u+4TdcU6HDmESVXpy2VvZ
1ZlM9CihuPh7vZbEMsmuTDnIdJVIUMF7jafoOvqbE6l2VI/rgtO+oVxMPeuOFmo+
yOyFESkHBmEuYxBO95QiG//qFyx2lC90DXjKDxX4FMR/OFMv6lj7KGeHY+3M7bzB
B8vR8NoVtLNudUzIbnVUZWk49+zVZLq+RmHpq/PFhEZe9PB0u/k=
=Uxj/
-----END PGP SIGNATURE-----

--1mpN54+oXr72ab9j--
