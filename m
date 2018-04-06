Received: from eggs.gnu.org ([2001:4830:134:3::10]:42375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f4LTF-0002eB-F4
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 03:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f4LTD-0003r6-Rf
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 03:07:37 -0400
Date: Fri, 6 Apr 2018 15:01:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180406050158.GD3212@umbus.fritz.box>
References: <20180405022002.17809-1-david@gibson.dropbear.id.au>
	<20180405022002.17809-2-david@gibson.dropbear.id.au>
	<20180405155636.288f9672@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GpGaEY17fSl8rd50"
Content-Disposition: inline
In-Reply-To: <20180405155636.288f9672@bahia.lan>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCHv2 for-2.13 1/2] Make
 qemu_mempath_getpagesize() accept NULL
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


--GpGaEY17fSl8rd50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 05, 2018 at 03:56:36PM +0200, Greg Kurz wrote:
> On Thu,  5 Apr 2018 12:20:01 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > qemu_mempath_getpagesize() gets the effective (host side) page size for
> > a block of memory backed by an mmap()ed file on the host.  It requires
> > the mem_path parameter to be non-NULL.
> >=20
> > This ends up meaning all the callers need a different case for handling
> > anonymous memory (for memory-backend-ram or default memory with -mem-pa=
th
> > is not specified).
> >=20
> > We can make all those callers a little simpler by
>=20
> by "having" ?

Yes, oops.

> > qemu_mempath_getpagesize() accept NULL, and treat that as the anonymous
> > memory case.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> >  exec.c            | 21 ++++++---------------
> >  target/ppc/kvm.c  |  8 ++------
> >  util/mmap-alloc.c | 26 ++++++++++++++------------
> >  3 files changed, 22 insertions(+), 33 deletions(-)
> >=20
> > diff --git a/exec.c b/exec.c
> > index 02b1efebb7..b38b004563 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -1488,19 +1488,14 @@ void ram_block_dump(Monitor *mon)
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
> > -            g_free(mem_path);
> > -            if (hpsize < *hpsize_min) {
> > -                *hpsize_min =3D hpsize;
> > -            }
> > -        } else {
> > -            *hpsize_min =3D getpagesize();
> > +        char *mem_path =3D object_property_get_str(obj, "mem-path", NU=
LL);
> > +        long hpsize =3D qemu_mempath_getpagesize(mem_path);
> > +        g_free(mem_path);
> > +        if (hpsize < *hpsize_min) {
> > +            *hpsize_min =3D hpsize;
> >          }
> >      }
> > =20
> > @@ -1513,11 +1508,7 @@ long qemu_getrampagesize(void)
> >      long mainrampagesize;
> >      Object *memdev_root;
> > =20
> > -    if (mem_path) {
> > -        mainrampagesize =3D qemu_mempath_getpagesize(mem_path);
> > -    } else {
> > -        mainrampagesize =3D getpagesize();
> > -    }
> > +    mainrampagesize =3D qemu_mempath_getpagesize(mem_path);
> > =20
> >      /* it's possible we have memory-backend objects with
> >       * hugepage-backed RAM. these may get mapped into system
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index 1bd38c6a90..f393eae127 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -496,12 +496,8 @@ bool kvmppc_is_mem_backend_page_size_ok(const char=
 *obj_path)
> >      char *mempath =3D object_property_get_str(mem_obj, "mem-path", NUL=
L);
> >      long pagesize;
> > =20
> > -    if (mempath) {
> > -        pagesize =3D qemu_mempath_getpagesize(mempath);
> > -        g_free(mempath);
> > -    } else {
> > -        pagesize =3D getpagesize();
> > -    }
> > +    pagesize =3D qemu_mempath_getpagesize(mempath);
> > +    g_free(mempath);
> > =20
> >      return pagesize >=3D max_cpu_page_size;
> >  }
> > diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> > index 2fd8cbcc6f..fd329eccd8 100644
> > --- a/util/mmap-alloc.c
> > +++ b/util/mmap-alloc.c
> > @@ -50,19 +50,21 @@ size_t qemu_mempath_getpagesize(const char *mem_pat=
h)
> >      struct statfs fs;
> >      int ret;
> > =20
> > -    do {
> > -        ret =3D statfs(mem_path, &fs);
> > -    } while (ret !=3D 0 && errno =3D=3D EINTR);
> > -
> > -    if (ret !=3D 0) {
> > -        fprintf(stderr, "Couldn't statfs() memory path: %s\n",
> > -                strerror(errno));
> > -        exit(1);
> > -    }
> > +    if (mem_path) {
> > +        do {
> > +            ret =3D statfs(mem_path, &fs);
> > +        } while (ret !=3D 0 && errno =3D=3D EINTR);
> > =20
> > -    if (fs.f_type =3D=3D HUGETLBFS_MAGIC) {
> > -        /* It's hugepage, return the huge page size */
> > -        return fs.f_bsize;
> > +        if (ret !=3D 0) {
> > +            fprintf(stderr, "Couldn't statfs() memory path: %s\n",
> > +                    strerror(errno));
> > +            exit(1);
> > +        }
> > +
> > +        if (fs.f_type =3D=3D HUGETLBFS_MAGIC) {
> > +            /* It's hugepage, return the huge page size */
> > +            return fs.f_bsize;
> > +        }
> >      }
> >  #ifdef __sparc__
> >      /* SPARC Linux needs greater alignment than the pagesize */
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GpGaEY17fSl8rd50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrG/0YACgkQbDjKyiDZ
s5KuSw//SO8fC+a1knILzoFsdeDv3n9ra/IP06JpSRTzPIgza5SvMgB6q0mwFRmS
nf6Ui5X3bQkvVBnyfPV77CNpJlsoTnRavQJ5LozeCLvoIcwsHhJRrjesrMybyKOX
dCCgT/sxqrJ/7kwCuLcgoNBcHP4Oc11Xssl0wsIKbqST/ILBgpmX7kUNsuUdirit
Tp0JDtX6KeKT+6VVVFzJXU2GWt7x0h1CfNOdOcOWWovveYGd5m+UV5rfExehoI2I
KHuyGMbcCElalLqXugzKh2Ue0vWxHX1raJmEQZSfxwUwdmNOZY0EpNwC8INzHDei
DzscWMB7a20ZUYziPI2BlK6BWDVTdR3CM6ObTbbU1ZpceJWfOlT8hYtXhNxlz8DD
F5gSeGBoMXuf2j0QXAgW572q0emUG8bnqKtjBJWdC67mNEFj+uO9M6Fh1Ogk3oMt
VdE/7yU7wNC2/+zqjx5+gC2igapaGjPCidNd3pCDVlYanbXUUkKtA0HAJSayUljA
Gff/5wFM7LWMZsUFviU0iiDW43Ldra2OaJWpj99/egxcdeltBB1pHtohBqU4WtOU
CwA61e0ZU4KCTXfpxng05d4QJFTcBnxSK9je9464U6zthdqqxi1i3zm/4eYCUBtb
T5fSsY36B3JZD8pFPBRbTiOHOkx0yFyEAxuPVaLPpVwDlKlW6ME=
=lp0w
-----END PGP SIGNATURE-----

--GpGaEY17fSl8rd50--
