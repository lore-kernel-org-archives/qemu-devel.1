Received: from eggs.gnu.org ([2001:4830:134:3::10]:42879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f3EY8-0001HS-1f
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 01:32:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f3EY4-00077O-UO
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 01:32:04 -0400
Date: Tue, 3 Apr 2018 15:31:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180403053146.GB1984@umbus.fritz.box>
References: <20180329052537.32163-1-david@gibson.dropbear.id.au>
	<20180329083748.15264f31@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
In-Reply-To: <20180329083748.15264f31@bahia.lan>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH for-2.13] Add
 host_memory_backend_pagesize() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 29, 2018 at 08:37:48AM +0200, Greg Kurz wrote:
> On Thu, 29 Mar 2018 16:25:37 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > There are a couple places (one generic, one target specific) where we n=
eed
> > to get the host page size associated with a particular memory backend. =
 I
> > have some upcoming code which will add another place which wants this. =
 So,
> > for convenience, add a helper function to calculate this.
> >=20
> > host_memory_backend_pagesize() returns the host pagesize for a given
> > HostMemoryBackend object, or for the default backend (-mem-path) if pas=
sed
> > NULL.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
>=20
> The idea is good but there's a small issue. See below.
>=20
> >  backends/hostmem.c       | 20 ++++++++++++++++++++
> >  exec.c                   | 21 +++++----------------
> >  include/sysemu/hostmem.h |  2 ++
> >  target/ppc/kvm.c         | 10 +---------
> >  4 files changed, 28 insertions(+), 25 deletions(-)
> >=20
> > diff --git a/backends/hostmem.c b/backends/hostmem.c
> > index f61093654e..b6a60cfc5d 100644
> > --- a/backends/hostmem.c
> > +++ b/backends/hostmem.c
> > @@ -18,6 +18,7 @@
> >  #include "qapi/visitor.h"
> >  #include "qemu/config-file.h"
> >  #include "qom/object_interfaces.h"
> > +#include "qemu/mmap-alloc.h"
> > =20
> >  #ifdef CONFIG_NUMA
> >  #include <numaif.h>
> > @@ -262,6 +263,25 @@ bool host_memory_backend_is_mapped(HostMemoryBacke=
nd *backend)
> >      return backend->is_mapped;
> >  }
> > =20
> > +long host_memory_backend_pagesize(HostMemoryBackend *memdev)
> > +{
> > +    const char *path =3D NULL;
> > +
> > +#ifdef __linux__
> > +    if (memdev) {
> > +        path =3D object_property_get_str(OBJECT(memdev), "mem-path", N=
ULL);
>=20
> object_property_get_str() returns an allocated string. It should be freed
> before returning.

Ah, nice catch, I'll correct that.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrDEcIACgkQbDjKyiDZ
s5I0Xw//TzD2XCtJSWdyo8GQ/qIzCrGO7aKJ1X0bEuCesILweoCQRMasxiO5q6ky
WPuXwvRtvvzGlGyT7JjjVh1mvJzocdDt8LPKR5pcP6WxrtcXC2GvUqESbeYfMmZA
dZd2GLI7K/JBL/vk7nW+a1gzTWzTuZZ0PfXwfnPzI4sQbHhwbkh6sCuTR2GLHT1z
ZqMG5vomgQ0f/n/Aa16HTL4ng1vR3FV0+1AhqiZZmRq/jj7q2grxwk0BN+wvyP4w
dGOjMXhJmXGtbifelNEu2KoFEpe1gbjRcVX+lBy8jUdD3P1xZygJ9azTdulfzJrv
8gIi2861H4/RnOplHk+sPjW7AeL82mD9mkrCpRfGt9byxAxPLRUQEdM7KD5dESpx
g1bdzDX240jPjQ0+37eLJfbv9auckc3B5GAdIWD1mnmmHZsRo4LIv66xjTIxh9Mr
orLCm7+r5HIMfuLiYsqxxRHsNuiFwIMseOmrRRAkBrM9OUPdIASuFpfCkd5oPAqy
rgOnJOJ3NASnDqsHyZAfLkQbcJFpgqMqu8ulyMwF6lnBMVUIGxTEcfWRAHlZx/Lq
l++HM7mLkOy7l2yJ4k7dDhWMPUDZ9Q3zxfUUcOLom+k6IlZjIvoGIUuPnZ6pgaI6
jrXrXg1CiXDNhsTgfbBzQlboHEURtLezolIWi/yJd8EnAvGwnNo=
=K+Yx
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
