Received: from eggs.gnu.org ([2001:4830:134:3::10]:36411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cnfQR-0000AA-O7
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 01:55:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cnfQO-0004Vm-LZ
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 01:55:15 -0400
Date: Tue, 14 Mar 2017 16:40:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170314054021.GI12564@umbus.fritz.box>
References: <1488970371-8865-1-git-send-email-clg@kaod.org>
	<1488970371-8865-3-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qLni7iB6Dl8qUSwk"
Content-Disposition: inline
In-Reply-To: <1488970371-8865-3-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/8] ppc/xics: add an ics_eoi()
 handler to XICSFabric
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--qLni7iB6Dl8qUSwk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 08, 2017 at 11:52:45AM +0100, C=E9dric Le Goater wrote:
> This handler will be required by PowerPC machines using multiple ICS
> objects, like this is the case for PowerNV. Also update the sPAPR
> machine to use the new handler.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

I don't see why you need a new callback for this.  In this and the
subsequent patches, it looks like the callback is always just use the
fabric's ics_get() to find the right ICS state, then call ics_eoi() on
it.


> ---
>  hw/intc/xics.c        |  9 +++------
>  hw/ppc/spapr.c        | 11 +++++++++++
>  include/hw/ppc/xics.h |  2 ++
>  3 files changed, 16 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 209e1a75ecb9..e6fecd6e1a89 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -169,7 +169,7 @@ void ics_resend(ICSState *ics)
>      }
>  }
> =20
> -static void ics_eoi(ICSState *ics, int nr)
> +void ics_eoi(ICSState *ics, int nr)
>  {
>      ICSStateClass *k =3D ICS_BASE_GET_CLASS(ics);
> =20
> @@ -268,7 +268,6 @@ void icp_eoi(ICPState *icp, uint32_t xirr)
>  {
>      XICSFabric *xi =3D icp->xics;
>      XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(xi);
> -    ICSState *ics;
>      uint32_t irq;
> =20
>      /* Send EOI -> ICS */
> @@ -276,10 +275,8 @@ void icp_eoi(ICPState *icp, uint32_t xirr)
>      trace_xics_icp_eoi(icp->cs->cpu_index, xirr, icp->xirr);
>      irq =3D xirr & XISR_MASK;
> =20
> -    ics =3D xic->ics_get(xi, irq);
> -    if (ics) {
> -        ics_eoi(ics, irq);
> -    }
> +    xic->ics_eoi(xi, irq);
> +
>      if (!XISR(icp)) {
>          icp_resend(icp);
>      }
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index c3bb99160545..043629cc5c54 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3024,6 +3024,16 @@ static void spapr_ics_resend(XICSFabric *dev)
>      ics_resend(spapr->ics);
>  }
> =20
> +static void spapr_ics_eoi(XICSFabric *xi, int irq)
> +{
> +    ICSState *ics;
> +
> +    ics =3D spapr_ics_get(xi, irq);
> +    if (ics) {
> +        ics_eoi(ics, irq);
> +    }
> +}
> +
>  static ICPState *spapr_icp_get(XICSFabric *xi, int server)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
> @@ -3094,6 +3104,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      vhc->get_patbe =3D spapr_get_patbe;
>      xic->ics_get =3D spapr_ics_get;
>      xic->ics_resend =3D spapr_ics_resend;
> +    xic->ics_eoi =3D spapr_ics_eoi;
>      xic->icp_get =3D spapr_icp_get;
>      ispc->print_info =3D spapr_pic_print_info;
>  }
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 42bd24e975cb..00b003b2392d 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -155,6 +155,7 @@ typedef struct XICSFabricClass {
>      InterfaceClass parent;
>      ICSState *(*ics_get)(XICSFabric *xi, int irq);
>      void (*ics_resend)(XICSFabric *xi);
> +    void (*ics_eoi)(XICSFabric *xi, int irq);
>      ICPState *(*icp_get)(XICSFabric *xi, int server);
>  } XICSFabricClass;
> =20
> @@ -189,6 +190,7 @@ void icp_pic_print_info(ICPState *icp, Monitor *mon);
>  void ics_pic_print_info(ICSState *ics, Monitor *mon);
> =20
>  void ics_resend(ICSState *ics);
> +void ics_eoi(ICSState *ics, int irq);
>  void icp_resend(ICPState *ss);
> =20
>  typedef struct sPAPRMachineState sPAPRMachineState;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qLni7iB6Dl8qUSwk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYx4JFAAoJEGw4ysog2bOS1CIP/12epylGJECgkmuliafsS8Wv
/8K0ZhytWevh5a0SZ5aEeKYpo3uf02fIOjNbUmEZWo7gc3CHHjHS92DhWHGrv6v2
/2iBlC6QIXYeEIqtHdPQmogrx7uAzNR3UzL9JSGq8B4W4Q51EV9PZNEXMcUobrKG
oTwf207nuXpRhDVPYx8zfV/fhgLMHDEH8SkDUgx16kw7o6/jATC7Lki0nYbAoFS6
BJtKYW6b4qs9VZWeXEFROGe61RePzoFDCnVDUBCOI2D1qLwr26NjT4hSw9lGlQf9
pkopWZJ9kw3W8Of7IhtqQz48rMn75PRHxJIKQxN0ZcBEVSZzmIpbbDet/Sxm0i+y
gNsyce59tJahSJQtQGnGNnQqpzh+3h+J98MG2pcyiz7OVIHKsxWkgJpTbCvB82DD
5dYOM1Qn5bqaIIRSmjGoD0dSodZsVeqvVrJX/FMRfeA49bgObczPchDAydc9kbcd
wDph6YAwMYtAfAlop4DbtBfh8AK8D+Bq9TDOqUv+KF8F1DJlBXSvWj1F/7trjvho
g/BXid5r1mXhx+EajskkSKX/rETkCIZcUsJ5TAoC4IK4Tbu/9UHGsK4SfuiCWr2w
oek2DLj5NjYm+jUBnbjqyWjjAFwxO4v5m3DpFgpVqgAGHHQ2MFAQm5uT3naBrXB5
dpBfLjTbOJ9X6hgEyO2S
=/DK5
-----END PGP SIGNATURE-----

--qLni7iB6Dl8qUSwk--
