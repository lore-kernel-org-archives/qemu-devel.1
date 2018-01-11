Received: from eggs.gnu.org ([2001:4830:134:3::10]:42389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eZZV0-0007wp-IY
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 04:50:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eZZUu-0001Pi-3r
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 04:50:14 -0500
Date: Thu, 11 Jan 2018 20:49:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180111094908.GH24770@umbus.fritz.box>
References: <20180111040832.28383-1-aik@ozlabs.ru>
	<b56b4e0b-0cb0-e45d-6821-6291414bee8e@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hAW+M2+FUO+onfmf"
Content-Disposition: inline
In-Reply-To: <b56b4e0b-0cb0-e45d-6821-6291414bee8e@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH qemu] target/ppc: Yet another fix for
 KVM-HV HPTE accessors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--hAW+M2+FUO+onfmf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2018 at 08:06:13AM +0000, Mark Cave-Ayland wrote:
> On 11/01/18 04:08, Alexey Kardashevskiy wrote:
>=20
> > As stated in the 1ad9f0a464fe commit log, the returned entries are not
> > a while PTEG. It was not a problem before 1ad9f0a464fe as it would read
>=20
> s/while/whole/?

I already merged, so I adjusted this in my tree.  Come to that
although the fix is correct, I don't think the current message
explains it very well.  I'll think about adjusting it.

>=20
> > a single record assuming it contains a whole PTEG but now the code tries
> > reading the entire PTEG and "if ((n - i) < invalid)" produces negative
> > values which then are converted to size_t for memset() and that throws
> > seg fault.
> >=20
> > This fixes the math.
> >=20
> > While here, fix the last @i increment as well.
> >=20
> > Fixes: 1ad9f0a464fe "target/ppc: Fix KVM-HV HPTE accessors"
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> >=20
> > Record #0:
> > (gdb) p *hdr
> > $13 =3D {
> >    index =3D <ptr>,
> >    n_valid =3D 0x1,
> >    n_invalid =3D 0x6
> > }
> >=20
> > Record #1:
> > (gdb) p *hdr
> > $18 =3D {
> >    index =3D <ptr>,
> >    n_valid =3D 0x2,
> >    n_invalid =3D 0x6
> > }
> >=20
> >=20
> > i.e. in the second iteration of the loop right before
> > "if ((n - i) < invalid)":
> > (gdb) p n
> > $16 =3D 0x8
> > (gdb) p i
> > $17 =3D 0x9
> >=20
> > and @invalid becomes -1.
> >=20
> > ---
> >   target/ppc/kvm.c | 11 +++++++----
> >   1 file changed, 7 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index 0566af7..c2dea81 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -2657,21 +2657,24 @@ void kvmppc_read_hptes(ppc_hash_pte64_t *hptes,=
 hwaddr ptex, int n)
> >           hdr =3D (struct kvm_get_htab_header *)buf;
> >           while ((i < n) && ((char *)hdr < (buf + rc))) {
> > -            int invalid =3D hdr->n_invalid;
> > +            int invalid =3D hdr->n_invalid, valid =3D hdr->n_valid;
> >               if (hdr->index !=3D (ptex + i)) {
> >                   hw_error("kvmppc_read_hptes: Unexpected HPTE index %"=
PRIu32
> >                            " !=3D (%"HWADDR_PRIu" + %d", hdr->index, pt=
ex, i);
> >               }
> > -            memcpy(hptes + i, hdr + 1, HASH_PTE_SIZE_64 * hdr->n_valid=
);
> > -            i +=3D hdr->n_valid;
> > +            if (n - i < valid) {
> > +                valid =3D n - i;
> > +            }
> > +            memcpy(hptes + i, hdr + 1, HASH_PTE_SIZE_64 * valid);
> > +            i +=3D valid;
> >               if ((n - i) < invalid) {
> >                   invalid =3D n - i;
> >               }
> >               memset(hptes + i, 0, invalid * HASH_PTE_SIZE_64);
> > -            i +=3D hdr->n_invalid;
> > +            i +=3D invalid;
> >               hdr =3D (struct kvm_get_htab_header *)
> >                   ((char *)(hdr + 1) + HASH_PTE_SIZE_64 * hdr->n_valid);
> >=20
>=20
>=20
> ATB,
>=20
> Mark.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hAW+M2+FUO+onfmf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpXMxIACgkQbDjKyiDZ
s5JroA/+OLs2Wj3yHegzxbi/EWo7r4SgwJUUNY5JzEboWskQS+uOJ8yi19dTrH7Q
RQxktl+8H/1qom8Z4NuW2tRVHykNzBq2nPwa83AhxHK5oD1+gB/MNUyACQJNEu7R
46X9/21E+DOGNeAieETF7+1n/HQErXNMoFAQcmK6iSlVBhZUISHAQCTfwsSuvrKY
pxWpc5e+A8yj4DKKjqrTSaPeMeNLZJu46CRTg7INewxnOGzpY8dbHl8tLM+UgYcs
r9pQZTq3D3ClFdoEznfJlwTHmWv4qG+BK3bRcBUHduUdJKcxqSJYFlJP6Q1i3Lzt
pwWQtA1fbuiNVObQ5986SF6Gq0u9fzLqqoIjnhtZwM4Vb6BJ3/yRnY+3KSJJZZss
N19I49LCdo8gOSjA0L9m9vFj2nh+vaWmrgsXHd09500zBFn6+3Uwy5LP+HhxfSzn
s6sxvaWJGzycaBlx+9HuqxQCEY8EsFWEf34aOmU8t5U2EuWkGtbUg5rT493FlKUT
yZGrHyi5I26bZLbp9n9cBiNl+VcLO+BEVQWLQgnW6cN6OTBcGW28bYrUa9TLJU3+
zrEyhQxeW42B9KY5clJu2tBLuqBPvFlvBbz0SqcTNzyzGRF/btwEgd8+a0GaiTs6
jaEPLFuUXCLHgRkyrBJydUhjCPUE4tAg6ycqRJ2CsGPfmuMNjpY=
=1bZb
-----END PGP SIGNATURE-----

--hAW+M2+FUO+onfmf--
