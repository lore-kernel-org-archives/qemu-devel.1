Received: from eggs.gnu.org ([2001:4830:134:3::10]:60270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ejvXi-0006b7-EO
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 18:23:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ejvXf-0005uH-6X
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 18:23:50 -0500
Date: Fri, 9 Feb 2018 10:08:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180208230848.GB11634@umbus.fritz.box>
References: <20180208094241.13839-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
In-Reply-To: <20180208094241.13839-1-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] spapr: check smp_threads <= vsmt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2018 at 10:42:41AM +0100, Laurent Vivier wrote:
> We ignore silently the value of smp_threads when we set
> the default VSMT value, and if smp_threads is greater than VSMT
> kernel is going into trouble later.
>=20
> Fixes: 8904e5a750
> ("spapr: Adjust default VSMT value for better migration compatibility")
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

I don't think this is quite the rigth appoach.  Instead, I think we
want:

	spapr->vsmt =3D MAX(8, smp_threads);

The real point of 8904e5a750 was to replace the host-derived kvm_smt
with a fixed value (8).  I only removed the MAX, because I mistakenly
thought that checks elsewhere would prevent smp_threads > 8.

> ---
>=20
> Notes:
>     v2: display a specific error message when the default VSMT is used
>         fix subject
>=20
>  hw/ppc/spapr.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 32a876be56..11de276cd5 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2311,6 +2311,12 @@ static void spapr_set_vsmt_mode(sPAPRMachineState =
*spapr, Error **errp)
>           * overwhelmingly common case in production systems.
>           */
>          spapr->vsmt =3D 8;
> +        if (spapr->vsmt < smp_threads) {
> +            error_setg(&local_err, "Cannot support %d threads/core"
> +                         " because it must be <=3D to default VSMT mode =
(%d)",
> +                         smp_threads, spapr->vsmt);
> +            goto out;
> +        }
>      }
> =20
>      /* KVM: If necessary, set the SMT mode: */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlp82H0ACgkQbDjKyiDZ
s5KRjhAAoNcctoIp+G/2mzChS8nNCIP0ABIVwTXPdqv3QwFFoNFRh3YNMS/rdQPc
u/H/FgxKy8WS9ZBrenz4pfBDV2taSUH4An5PkfP/kRvdT2yefLFuZq6KxWcjniEF
Jmo3rG6MkkINPbm7bikvpbZkOY2ATUXGWjm4P7K0tkHsVPLyMhHr+o/YXySQgwCW
DdaeWN5b+LyzFwdkj1z2CtTexL5lxU0MFmBqXCbYdqYQhHXDxKbFJC+GZI+nXEOA
Syz2t3bAcW+KL2Ef1KTUFUgGJ4rKvzlfsWjKAWKxeP3jeLkJvmlc2YxPrhmLQ3da
5P9VtqqH/okYsxZ+tPP4V/Jm02LKhmQpRcpYDFYX0nBikKjHmhyeg2ma3smARNZ+
LeQUVU6elj3Y6n80GcGXd2oq8LtFHgaPKPF6HgKrzPVhJZd/edcv6NFCVFqklml6
123K/PQsViTPX2q6BUz93eMHXwMQ6t3nmgo4hUOlOe+MYTqKKVeDUNMKR1keyULZ
p+d3qnka3FPdhwOdQWmPKc1+IQnWA3O81nYEo2RwELKV4o5fR32nvVi9cBJXtJiU
Arst+xp16iocpJgrPo+d50bKHhGcptLbvkRJvd2zTCLpWwRWbv3y0vJBoo6JM48V
eds7R5ODI5FC3Hrk8bq1++8sPyfOIDTjNroAV1A8n9F/w9LGTYY=
=+cRV
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
