Received: from eggs.gnu.org ([2001:4830:134:3::10]:52383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI1ph-0001BT-4J
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 19:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI1pg-00038w-24
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 19:54:49 -0400
Date: Tue, 6 Jun 2017 09:23:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170605232309.GD13397@umbus.fritz.box>
References: <149639817593.15167.7338592152743589651.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y77xulteysKOarq0"
Content-Disposition: inline
In-Reply-To: <149639817593.15167.7338592152743589651.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] spapr/drc: don't migrate DRC of
 cold-plugged CPUs and LMBs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>


--y77xulteysKOarq0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 02, 2017 at 12:09:35PM +0200, Greg Kurz wrote:
> As explained in commit 5c0139a8c2f0 ("spapr: fix default DRC state for
> coldplugged LMBs"), guests expect cold-plugged LMBs to be pre-allocated
> and unisolated. The same goes for cold-plugged CPUs.
>=20
> While here, let's convert g_assert(false) to the better self documenting
> g_assert_not_reached().
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

I've applied this to ppc-for-2.10.  I'm a bit concerned that this is
just another bandaid thrown at the mess which is the DRC code.  I'm
hoping to clean this up more thoroughly, which will obsolete this, but
in the meantime it shouldn't be any worse than what we have.
> ---
>=20
> FWIW
>=20
> $ git grep -i -E '(g_)?assert\((0|false)\)' | wc -l
> 100
> $ git grep g_assert_not_reached | wc -l
> 244
> ---
>  hw/ppc/spapr_drc.c |   10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index cc2400bcd57f..ab5f7cdf569c 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -538,20 +538,16 @@ static bool spapr_drc_needed(void *opaque)
>       */
>      switch (drc->type) {
>      case SPAPR_DR_CONNECTOR_TYPE_PCI:
> -        rc =3D !((drc->isolation_state =3D=3D SPAPR_DR_ISOLATION_STATE_U=
NISOLATED) &&
> -               (drc->allocation_state =3D=3D SPAPR_DR_ALLOCATION_STATE_U=
SABLE) &&
> -               drc->configured && drc->signalled && !drc->awaiting_relea=
se);
> -        break;
>      case SPAPR_DR_CONNECTOR_TYPE_CPU:
>      case SPAPR_DR_CONNECTOR_TYPE_LMB:
> -        rc =3D !((drc->isolation_state =3D=3D SPAPR_DR_ISOLATION_STATE_I=
SOLATED) &&
> -               (drc->allocation_state =3D=3D SPAPR_DR_ALLOCATION_STATE_U=
NUSABLE) &&
> +        rc =3D !((drc->isolation_state =3D=3D SPAPR_DR_ISOLATION_STATE_U=
NISOLATED) &&
> +               (drc->allocation_state =3D=3D SPAPR_DR_ALLOCATION_STATE_U=
SABLE) &&
>                 drc->configured && drc->signalled && !drc->awaiting_relea=
se);
>          break;
>      case SPAPR_DR_CONNECTOR_TYPE_PHB:
>      case SPAPR_DR_CONNECTOR_TYPE_VIO:
>      default:
> -        g_assert(false);
> +        g_assert_not_reached();
>      }
>      return rc;
>  }
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--y77xulteysKOarq0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZNefcAAoJEGw4ysog2bOS9zIP/iFdF8mGP5mTwSWVchcN4v5V
y2FvWQi6FwTIby1LbfZ/0B+XVio0es1TIdzRFuNJ9juHRdLYS4RgT7ehYmE0b3pQ
q+SLCPz6/ZEgAOJkBGe/Icffoa1y/V9MZlnlQN0MeNVFk/wLRZtggO+e/BAKrZuv
yWmAj1dFE0WLYQqW1OV6kz0557Clb18DnyYqNp0l/H+ps5biQENCM9F+NMlOeK/r
ihtIlnmyk93roTpduMTKz06H7ynGcvDFwDdm5taSM6gwk+uPdFlcJ0vndVbr18o7
DtV6RYKkcCORxDRMYQLmUsXxgCUw4OnuAz+ouPcIEtKaUf/3DSqLqmJIEhmP3bm8
RWXiPS/WX1VBAZPkph7wmrGcUu7X5+szUZ8ojRQqQk5r7H36OJ8I2a8Ebeu5JrAH
QKBaa2By4GW5cEU5MulAjrVWC/P1klueK3A6FOY8SfI4Av4UFt/dHUH2zbZeA6LS
w4fOh0MFabHjBfg/xBLZxXDEeQauvurlxvYXIc5FBehUdeNgXAMqvccxPHNlxM7E
C9jHnGI8YxIBAa0r/eT3/RejrXxtnnz1nvLbJmXyB4dvGi6eWmon+eax3UTBfer1
0OM9G9AjPh5H0O2o40n/EbBXri3gLnWy36gtuQjx8nZwjJRRPqe5S5PkQyaNdAo+
K4R1WX7qPEoxyd4vGn+h
=HBOf
-----END PGP SIGNATURE-----

--y77xulteysKOarq0--
