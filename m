Received: from eggs.gnu.org ([2001:4830:134:3::10]:37804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzgPt-00037Y-MM
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:56:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzgPp-0004Io-Nn
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:56:37 -0400
Date: Wed, 4 Oct 2017 20:44:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171004094425.GY3260@umbus.fritz.box>
References: <150710775137.16096.2606042109300213433.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="g3IWFuR7/O9KKcN6"
Content-Disposition: inline
In-Reply-To: <150710775137.16096.2606042109300213433.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] spapr: sanity check size of the CAS buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>


--g3IWFuR7/O9KKcN6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2017 at 11:02:31AM +0200, Greg Kurz wrote:
> The CAS buffer is provided by SLOF. A broken SLOF could pass a silly
> size: either smaller than the diff header, in which case the current
> code will try to allocate 16 Exabytes of memory and g_malloc0() will
> abort, or bigger than the maximum memory provisioned for SLOF (ie,
> 40 Megabytes), which doesn't make sense. Both cases indicate that
> SLOF has a bug.

Actually, it's much worse than that: SLOF is what's *expected* to call
H_CAS, but nothing actually prevents anything in the guest from
calling it and blowing up qemu.  Or, worse, allocating a large amount
of memory outside the guest's address space.

> Let's print out an explicit error message and exit since rebooting as
> we do with other errors would only result in a reset loop.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied.

> ---
>  hw/ppc/spapr.c |    7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index b284e0b9d43e..1a2ca8a22b6d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -819,6 +819,13 @@ int spapr_h_cas_compose_response(sPAPRMachineState *=
spapr,
>          return 1;
>      }
> =20
> +    if (size < sizeof(hdr) || size > FW_MAX_SIZE) {
> +        error_report("SLOF provided an unexpected CAS buffer size "
> +                     TARGET_FMT_lu " (min: %lu, max: %u)",
> +                     size, sizeof(hdr), FW_MAX_SIZE);
> +        exit(EXIT_FAILURE);
> +    }
> +
>      size -=3D sizeof(hdr);
> =20
>      /* Create skeleton */
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--g3IWFuR7/O9KKcN6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnUrXkACgkQbDjKyiDZ
s5LbshAA3lTG+OBZySIueV5EZfsbaxMbX/8+HofSDoSOLktL8JeAVz74dMtAEMAf
DVS44y4zgMI1uacEWtlIlLrD5byXW9Oiji0pNX+UxI+PYAUTQxi8//1Uw2+6vBeY
Jvb022dh7G9XjZ1iakb7/lu/htQyXaIAwbhlKQnH0rreYv8/u4u+Jq/wVPbA+qVN
aondngrtBRU6eUC5f27P9vxq3WtHsXcw//olGpnlMroUAKX/7AOJF2hfBlLrLkKi
Bw8wMCr+iDstwpNZnm6CrFf9NRn2WzAQ5ZBgAQBiafNEDV6gjrI6sZ3nIyWiuZuY
Wm2ca/F8Z0xrZMmA0H+wZQQinvwto6CPtpN5l8gbFvwxMT/WmS3TQUEab/ht+GKJ
k/F5aZSaFIGrARz9nH331hOWsbnYAEDTFkGNAJrqWjBF6tpUF/2FeP1thOPcSdp2
XDwSejJjAFnJh7HVhniPkeUbOQvv6dmuZ5muSoTPZm3fs1rPlnoJZUkvSkYCnT+r
7/SmP819bZ667l/zHmeXefCKkHzyIDlN6AdiKi/50Fckf012rlOLLd97w6SYnX2/
x8z/8VuYNGA8VNU8n550vtlZt6iEaPbXttrsAi3A7zSehs+NXpw91vXKGWE6+lbT
As6Y4FkUbP5VjiTnxNQY4P9tys0qSDaZzikDnynlhPKocSZmgbg=
=1sHD
-----END PGP SIGNATURE-----

--g3IWFuR7/O9KKcN6--
