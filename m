Received: from eggs.gnu.org ([2001:4830:134:3::10]:42880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f3EY8-0001HT-1s
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 01:32:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f3EY4-00077T-UU
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 01:32:04 -0400
Date: Tue, 3 Apr 2018 15:29:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180403052948.GA1984@umbus.fritz.box>
References: <20180329052537.32163-1-david@gibson.dropbear.id.au>
	<20180403022206.GK5046@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20180403022206.GK5046@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH for-2.13] Add
 host_memory_backend_pagesize() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: imammedo@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 02, 2018 at 11:22:06PM -0300, Eduardo Habkost wrote:
> On Thu, Mar 29, 2018 at 04:25:37PM +1100, David Gibson wrote:
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
>=20
> qemu_mempath_getpagesize() returns size_t.  Why are you using
> long here?

Because qemu_getrampagesize() returns long.  But size_t is better, so
I've changed it.

> > +{
> > +    const char *path =3D NULL;
> > +
> > +#ifdef __linux__
> > +    if (memdev) {
> > +        path =3D object_property_get_str(OBJECT(memdev), "mem-path", N=
ULL);
> > +    } else {
> > +        path =3D mem_path;
> > +    }
> > +#endif
> > +
> > +    if (path) {
> > +        return qemu_mempath_getpagesize(path);
> > +    } else {
> > +        return getpagesize();
>=20
> Isn't it simpler to make qemu_mempath_getpagesize() handle
> path=3D=3DNULL?

Uh.. possibly not, but things you bring up later kind of make it moot.

> > +    }
> > +}
> > +
> >  static void
> >  host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
> >  {
> > diff --git a/exec.c b/exec.c
> > index c09bd93df3..04856c2402 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -1488,18 +1488,13 @@ void ram_block_dump(Monitor *mon)
> >   */
> >  static int find_max_supported_pagesize(Object *obj, void *opaque)
> >  {
> > -    char *mem_path;
> >      long *hpsize_min =3D opaque;
> > =20
> >      if (object_dynamic_cast(obj, TYPE_MEMORY_BACKEND)) {
> > -        mem_path =3D object_property_get_str(obj, "mem-path", NULL);
> > -        if (mem_path) {
> > -            long hpsize =3D qemu_mempath_getpagesize(mem_path);
> > -            if (hpsize < *hpsize_min) {
> > -                *hpsize_min =3D hpsize;
> > -            }
> > -        } else {
> > -            *hpsize_min =3D getpagesize();
> > +        long hpsize =3D host_memory_backend_pagesize(MEMORY_BACKEND(ob=
j));
>=20
> So in this caller, `backend` is always non-NULL...
>=20
> > +
> > +        if (hpsize < *hpsize_min) {
> > +            *hpsize_min =3D hpsize;
> >          }
> >      }
> > =20
> > @@ -1509,15 +1504,9 @@ static int find_max_supported_pagesize(Object *o=
bj, void *opaque)
> >  long qemu_getrampagesize(void)
> >  {
> >      long hpsize =3D LONG_MAX;
> > -    long mainrampagesize;
> > +    long mainrampagesize =3D host_memory_backend_pagesize(NULL);
>=20
> ...on this caller `backend` is always NULL...
>=20
>=20
> >      Object *memdev_root;
> > =20
> > -    if (mem_path) {
> > -        mainrampagesize =3D qemu_mempath_getpagesize(mem_path);
> > -    } else {
> > -        mainrampagesize =3D getpagesize();
> > -    }
> > -
> >      /* it's possible we have memory-backend objects with
> >       * hugepage-backed RAM. these may get mapped into system
> >       * address space via -numa parameters or memory hotplug
> [...]
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index b329cd8173..0adcf18c9f 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -493,15 +493,7 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
> >  bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
> >  {
> >      Object *mem_obj =3D object_resolve_path(obj_path, NULL);
> > -    char *mempath =3D object_property_get_str(mem_obj, "mem-path", NUL=
L);
> > -    long pagesize;
> > -
> > -    if (mempath) {
> > -        pagesize =3D qemu_mempath_getpagesize(mempath);
> > -        g_free(mempath);
> > -    } else {
> > -        pagesize =3D getpagesize();
> > -    }
> > +    long pagesize =3D host_memory_backend_pagesize(MEMORY_BACKEND(mem_=
obj));
> > =20
>=20
> ...and here `backend` is always non-NULL.
>=20
> If there's no caller that relies on both code paths, why overload
> a single function for two different operations?

Good point. =20

> I would simply make qemu_mempath_getpagesize() work if path is
> NULL, use qemu_mempath_getpagesize(mem_path) at
> qemu_getrampagesize(), and make host_memory_backend_pagesize()
> assume require a non-NULL `memdev`.

Yeah, that makes sense.  I thought I might have more need for a
unified entry point in the code I have in the works, but looking at
the latest draft, probably not.

I'll change it as you suggest.

> > +long host_memory_backend_pagesize(HostMemoryBackend *memdev)
>=20
> Why is the code duplicated in target/ppc/kvm.c?

Leftover from an early version, I think.  I'll fix that.

>=20
>=20
> > +{
> > +    const char *path =3D NULL;
> > +
> > +#ifdef __linux__
> > +    if (memdev) {
> > +        path =3D object_property_get_str(OBJECT(memdev), "mem-path", N=
ULL);
> > +    } else {
> > +        path =3D mem_path;
> > +    }
> > +#endif
> > +
> > +    if (path) {
> > +        return qemu_mempath_getpagesize(path);
> > +    } else {
> > +        return getpagesize();
> > +    }
> > +}
> > +
> >      return pagesize >=3D max_cpu_page_size;
> >  }
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrDEUoACgkQbDjKyiDZ
s5JA8w//aSXVM3xhmEdWP6VmqHjl5c37FbZQNGaFsPtws+j6/BHUEHtUpGBSy0qT
s84gzZwI6Do8BoCLA4aCQ744C0PFbb67vFfzVHQFKMCs3UE5GCavee9LL/E8WWt9
Z6jpNUJA/mVlN/JPw1UNsUVq+2ke7WgO3wS4FcTauZSAEWVR2qRwtUifpdIwZn5k
UIoGjH62KpeT706ih3lZgBuTqnL5v3tUcLg8pems06xqgDf0vOvjaZL+S7QMRm52
7HjzeksaOE1n1dAWqMLZwfpg7Vvjk9WW59yWt8b/H/Yy2DS8bMGOYJ32RtAlnTep
P2tn3E7Jy2fZuSjErLR3N+xfJiDVhk7WTdG4GBx+Yb4SMwaf0/Ogc3MVfQ0HKQJf
JzMQFNqg66og5ttrRFnfJwAVHNvE2k2vwzdIJatCT1g4REXx/kXQVYIe+WqS9z6V
AY7YKJ960QZ9Onk3wXwsw7je92tLztJjiiZnRP/r0XKkbvWMO6gphMAnCV3j8GVf
RpUnJb6W4d1feL6LeTd9CXbKnMGUQStqgQnJHjmGey9h1kDFARssGOplRb3K6Zl9
T7AVwg7P5qeNER1Tmy0S5qh+Swv91iYCJSh2px6L4q+im1IZu4KYTiQhDu7347PD
4LDvI6l2019kwny5NW+7n8Rl+ReWtOGZwq+jGke1EQ5Wa9YDW8o=
=KAK/
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
