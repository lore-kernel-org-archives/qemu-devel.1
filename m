Received: from eggs.gnu.org ([2001:4830:134:3::10]:53653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dXJLB-0008Ia-Pt
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:38:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dXJL7-0007hT-Ib
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:38:29 -0400
Date: Tue, 18 Jul 2017 13:37:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170718033708.GA3140@umbus.fritz.box>
References: <20170630104632.27942-1-david@gibson.dropbear.id.au>
	<20170630104632.27942-7-david@gibson.dropbear.id.au>
	<a189522d-c798-097d-b985-13e15f48db41@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <a189522d-c798-097d-b985-13e15f48db41@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 06/21] spapr: Add a "no HPT"
 encoding to HTAB migration stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: peter.maydell@linaro.org, thuth@redhat.com, qemu-devel@nongnu.org, sursingh@redhat.com, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, sbobroff@redhat.com


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2017 at 09:54:45PM +0200, Laurent Vivier wrote:
> On 30/06/2017 12:46, David Gibson wrote:
> > From: Bharata B Rao <bharata@linux.vnet.ibm.com>
> >=20
> > Add a "no HPT" encoding (using value -1) to the HTAB migration
> > stream (in the place of HPT size) when the guest doesn't allocate HPT.
> > This will help the target side to match target HPT with the source HPT
> > and thus enable successful migration.
> >=20
> > Suggested-by: David Gibson <david@gibson.dropbear.id.au>
> > Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr.c | 29 +++++++++++++++++++++++++----
> >  1 file changed, 25 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 52f4e72..f3e0b9b 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1560,13 +1560,19 @@ static int htab_save_setup(QEMUFile *f, void *o=
paque)
> >      sPAPRMachineState *spapr =3D opaque;
> > =20
> >      /* "Iteration" header */
> > -    qemu_put_be32(f, spapr->htab_shift);
> > +    if (!spapr->htab_shift) {
> > +        qemu_put_be32(f, -1);
> > +    } else {
> > +        qemu_put_be32(f, spapr->htab_shift);
> > +    }
> > =20
> >      if (spapr->htab) {
> >          spapr->htab_save_index =3D 0;
> >          spapr->htab_first_pass =3D true;
> >      } else {
> > -        assert(kvm_enabled());
> > +        if (spapr->htab_shift) {
> > +            assert(kvm_enabled());
> > +        }
> >      }
> > =20
> > =20
> > @@ -1712,7 +1718,12 @@ static int htab_save_iterate(QEMUFile *f, void *=
opaque)
> >      int rc =3D 0;
> > =20
> >      /* Iteration header */
> > -    qemu_put_be32(f, 0);
> > +    if (!spapr->htab_shift) {
> > +        qemu_put_be32(f, -1);
> > +        return 0;
> > +    } else {
> > +        qemu_put_be32(f, 0);
> > +    }
> > =20
> >      if (!spapr->htab) {
> >          assert(kvm_enabled());
> > @@ -1746,7 +1757,12 @@ static int htab_save_complete(QEMUFile *f, void =
*opaque)
> >      int fd;
> > =20
> >      /* Iteration header */
> > -    qemu_put_be32(f, 0);
> > +    if (!spapr->htab_shift) {
> > +        qemu_put_be32(f, -1);
> > +        return 0;
> > +    } else {
> > +        qemu_put_be32(f, 0);
> > +    }
> > =20
> >      if (!spapr->htab) {
> >          int rc;
> > @@ -1790,6 +1806,11 @@ static int htab_load(QEMUFile *f, void *opaque, =
int version_id)
> > =20
> >      section_hdr =3D qemu_get_be32(f);
> > =20
> > +    if (section_hdr =3D=3D -1) {
> > +        spapr_free_hpt(spapr);
> > +        return 0;
> > +    }
> > +
> >      if (section_hdr) {
> >          Error *local_err =3D NULL;
> > =20
> >=20
>=20
> It seems there is a bug in this patch: when using from QEMU console the
> command "savevm", it never stops and the qcow2 image grows without limit.
>=20
> I think this is because htab_save_iterate() and htab_save_complete()
> should mark the end of the sequence (the empty one, -1) by returning 1
> and not 0 (see kvmppc_save_htab()).

Ah, yes, I think you're right.  The end condition is one of the subtle
differences between the savevm and migration paths.

> This fixes the problem for me:
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 970093e..fa01511 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1827,7 +1827,7 @@ static int htab_save_iterate(QEMUFile *f, void
> *opaque)
>      /* Iteration header */
>      if (!spapr->htab_shift) {
>          qemu_put_be32(f, -1);
> -        return 0;
> +        return 1;
>      } else {
>          qemu_put_be32(f, 0);
>      }
> @@ -1866,7 +1866,7 @@ static int htab_save_complete(QEMUFile *f, void
> *opaque)
>      /* Iteration header */
>      if (!spapr->htab_shift) {
>          qemu_put_be32(f, -1);
> -        return 0;
> +        return 1;
>      } else {
>          qemu_put_be32(f, 0);
>      }

Can you polish this up and submit for merge, please?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlltgmMACgkQbDjKyiDZ
s5LOyRAAh+QvmN7QMZDZOzXTbs2pIWfMY+nh3dmwPXsyPgPxTJyT6Doj3O53ZNbw
jLKuS8YoYzuGLn3O+3cVPPZ/bXk+VFrjNm2pVmleTspcw/EVhwz7SGqnpgnYCbyG
P+DvKLmYBgOEdjINTGyS/AWieCP2iYwE03I9T+Zo1Dr+Dsgsii787Qh3peJ/LDHV
BCVunvxTfPbh63tQXeQ6mdpG41fqPZ7Zsim2z8pXTpF9xh59rRtE+cjMv490UqoO
ycH7yk6ccF5ZtGGENaRxpq8O9yQQa7CdOsWctMfuXY2oVXNOyl3CEoPZBskz0o8E
sY/6xoP5oeziD3/E/Pd6E/zdS70qbS/pATq+FsNvAW6RM7h5INi71T+KrTy44rHG
jwcKywaigpI4QTcMy+hEEpusILziMX5A/Py4CrcBmWUNaUav3QAgdfcDSwP+DW8r
ulOoLSwH3qQRU+pXTbYqhSHPRe91yB6mogmL1K5QebBe7pc5cgDQNX/a4LzlQkDg
xt5kJRI64KsBH2b3VqoUHysj83MXDm+9iW57hO/BSxRKYfXnc3nDDYhrYKQocUHE
FwIog2xJ3p0OWR4HcFA4FklSKHp+MJ1GJslm8w9IdR7KZByz641kJV+5tz+5nhoS
uh+k459dD8+pUs+U7cYQji//EHhM369n/WS/4jpMHmcGLGMQkwE=
=1QOV
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
