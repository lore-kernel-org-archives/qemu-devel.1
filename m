Received: from eggs.gnu.org ([2001:4830:134:3::10]:55294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f9MMs-0002fa-Ib
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 23:05:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f9MMr-0007LU-DP
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 23:05:46 -0400
Date: Fri, 20 Apr 2018 12:18:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180420021803.GC2434@umbus.fritz.box>
References: <20180419072123.682-1-david@gibson.dropbear.id.au>
	<20180419183037.21826f8a@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DSayHWYpDlRfCAAQ"
Content-Disposition: inline
In-Reply-To: <20180419183037.21826f8a@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH for-2.13] Clear mem_path if we fall back to
 anonymous RAM allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: pbonzini@redhat.com, imammedo@redhat.com, ehabkost@redhat.com, clg@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2018 at 06:30:37PM +0200, Greg Kurz wrote:
> On Thu, 19 Apr 2018 17:21:23 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > If the -mem-path option is set, we attempt to map the guest's RAM from a
> > file in the given path; it's usually used to back guest RAM with hugepa=
ges.
> > If we're unable to (e.g. not enough free hugepages) then we fall back to
> > allocating normal anonymous pages.  This behaviour can be surprising, b=
ut a
> > comment in allocate_system_memory_nonnuma() suggests it's legacy behavi=
our
> > we can't change.
> >=20
> > What really isn't ok, though, is that in this case we leave mem_path se=
t.
> > That means functions which attempt to determine the pagesize of main RAM
> > can erroneously think it is hugepage based on the requested path, even
> > though it's not.
> >=20
> > This is particular bad for the pseries machine type.  KVM HV limitations
> > mean the guest can't use pagesizes larger than the host page size used =
to
> > back RAM.  That means that such a fallback, rather than merely giving
> > poorer performance that expected will cause the guest to freeze up earl=
y in
>=20
> s/that expected/than expected/

Adjusted, thanks.

>=20
> > boot as it attempts to use large page mappings that can't work.
> >=20
> > This patch addresses the problem by clearing the mem_path variable when=
 we
> > fall back to anonymous pages, meaning that subsequent attempts to
> > determine the RAM page size will get an accurate result.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  numa.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > Paolo et al, as with my earlier patches adding some extensions to the
> > helpers for determining backing page sizes, if there are no objections
> > can I get an ack to merge this via my ppc tree?
> >=20
> > diff --git a/numa.c b/numa.c
> > index 1116c90af9..78a869e598 100644
> > --- a/numa.c
> > +++ b/numa.c
> > @@ -469,6 +469,7 @@ static void allocate_system_memory_nonnuma(MemoryRe=
gion *mr, Object *owner,
> >              /* Legacy behavior: if allocation failed, fall back to
> >               * regular RAM allocation.
> >               */
> > +            mem_path =3D NULL;
> >              memory_region_init_ram_nomigrate(mr, owner, name, ram_size=
, &error_fatal);
> >          }
> >  #else
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrZTdoACgkQbDjKyiDZ
s5J07Q/9FJjjzcz+VC78b9l6o73+5PRGJIJ3LQ2oeIoqjia1e034hFmwvdMhTfsH
RgkiXJeZH+kSVHi/kRYib8MgdILs9u+BsJuO0aBhAnkCOrTqnZnegYeA3DOZ8rBb
0rnQSdFzrQtlnYMblsKhgo9vr5yt6PBkCY0epNbjNammTIJb8QsmUSC8xrirGekw
gmM7LUG1Go1cJH4j75W1UNYyEwt4lEJFLS5tNd4JU0VWF+k6CNeuNDvO3GODR3y8
X//Hx6tdhy1kHvuQ8TWKvXmuqYqHLTgjbWDqE32k1DJ47G3HulkRuF95/tP7BjNa
/yMxMe9DH+SlolPWXydzOZRtTRmN+NzFzvhn4mdAn778pbuxkYEy8YNSfOBvyKL+
Y0szj/Xxl2zU4X5gEIWoNT3LwEtJjfK2GbCZn35B+JtXItQDOnRbmgG7i1nPD+B2
+tyrSCnTDRffAcx6J/8awG8m5iYV6Fb3fUYIM6/d4H3/hTXfpQR+VwkgDJqoYc5w
Jjf8h0sOm2EtohIQvgGqSAz5gxB8rCb7mtoJkHpE+0iP/Qs2MoouOS67QWV24Jsm
wbJb0xl8MX8QJnHS5bxLJ1fRNPojTNK27cDgEzrQV/C4kOEv2zH4D3NCjorr5+K/
B/PPOEb77LyGyOHC6HOj5CkNNU/lg3AzQ9IyY+DKX1uqbALExrc=
=09OL
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--
