Received: from eggs.gnu.org ([2001:4830:134:3::10]:40611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgjkf-0003we-EK
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:07:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgjkd-0005MY-Jx
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:07:29 -0500
Date: Thu, 23 Feb 2017 13:39:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170223023946.GA12577@umbus.fritz.box>
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
	<1487252865-12064-13-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="va9XEZk9/dJ5GUjX"
Content-Disposition: inline
In-Reply-To: <1487252865-12064-13-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 12/22] ppc/xics: extend the QOM
 interface to handle ICPs
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


--va9XEZk9/dJ5GUjX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2017 at 02:47:35PM +0100, C=E9dric Le Goater wrote:
> Let's add two new handlers for ICPs. One is to get an ICP object from
> a server number and a second is to resend the irqs when needed.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/xics.c        |  2 +-
>  hw/ppc/spapr.c        | 20 ++++++++++++++++++++
>  include/hw/ppc/xics.h |  3 +++
>  3 files changed, 24 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 5131587ce088..7168c2cfd8a1 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -216,7 +216,7 @@ static void icp_check_ipi(ICPState *ss)
>      qemu_irq_raise(ss->output);
>  }
> =20
> -static void icp_resend(XICSInterface *xi, ICPState *ss)
> +void icp_resend(XICSInterface *xi, ICPState *ss)
>  {
>      XICSInterfaceClass *xic =3D XICS_INTERFACE_GET_CLASS(xi);
> =20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index d1946ebcac69..eb7da32296d8 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2915,6 +2915,24 @@ static void spapr_ics_resend(XICSInterface *dev)
>      ics_resend(spapr->ics);
>  }
> =20
> +static ICPState *spapr_icp_get(XICSInterface *xi, int server)
> +{
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
> +
> +    return (server < spapr->xics->nr_servers) ? &spapr->xics->ss[server]=
 :
> +        NULL;
> +}
> +
> +static void spapr_icp_resend(XICSInterface *xi)
> +{
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
> +    int i;
> +
> +    for (i =3D 0; i < spapr->xics->nr_servers; i++) {
> +        icp_resend(xi, &spapr->xics->ss[i]);
> +    }
> +}

I'm not quite sure where you plan to use the resend hook.  AFAICT all
the existing users of this path can do fine using icp_get() then
icp_resend() directly.

> +
>  static void spapr_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> @@ -2959,6 +2977,8 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      vhc->hypercall =3D emulate_spapr_hypercall;
>      xic->ics_get =3D spapr_ics_get;
>      xic->ics_resend =3D spapr_ics_resend;
> +    xic->icp_get =3D spapr_icp_get;
> +    xic->icp_resend =3D spapr_icp_resend;
>  }
> =20
>  static const TypeInfo spapr_machine_info =3D {
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index c15d8e2a8ae6..7004c851e250 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -191,6 +191,8 @@ typedef struct XICSInterfaceClass {
>      InterfaceClass parent;
>      ICSState *(*ics_get)(XICSInterface *xi, int irq);
>      void (*ics_resend)(XICSInterface *xi);
> +    ICPState *(*icp_get)(XICSInterface *xi, int server);
> +    void (*icp_resend)(XICSInterface *xi);
>  } XICSInterfaceClass;
> =20
>  #define XICS_IRQS_SPAPR               1024
> @@ -221,5 +223,6 @@ void ics_simple_write_xive(ICSState *ics, int nr, int=
 server,
>  void ics_set_irq_type(ICSState *ics, int srcno, bool lsi);
> =20
>  void ics_resend(ICSState *ics);
> +void icp_resend(XICSInterface *xi, ICPState *ss);
> =20
>  #endif /* XICS_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--va9XEZk9/dJ5GUjX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYrktyAAoJEGw4ysog2bOSt9QP/3hKFGA3UdFU6juUYzC78SJn
O9Tx2kOAnkyBraEbS3ikk+af2LyqFK0+UOoCCuWBATmuUNmCP5NfBfNujoZAP3iQ
GnmbJcfnBiYnGAebWYguB1SDptAacjiv+xSUVRvbdgykgrg6PrPZtIEcQQZ2TpHp
gOnrs4AlKLnq/9A5PMmAmkBFYb1aL2DyoNbcCD1hUEK7YTovbvkfZesBMq9zdJGC
ucHj0YDzvOjQF7CIHdeEHPo+Z0vMXCdFPBgDbRjZhNPpsk3rXBh8W4KjTSY4LBA3
fGhjAjqg1pi/1Lo7IHd4Ek9F3t7mUPr53snMK5fCtPbsnTNzcRyz7eRUazvu3+R3
cAPugzmKavXvosqBfc9WYOl+I2b9iM38+/oA8zaUQZJOZh+gkppIxzv52TYgzWg6
YLNbiLPv4spR9b6e4LX5Zb3gflBJXVdYnEDp6Qrkvd76XvYSOLmvSf0Xou+Ik75j
VZBMgrLK9va9wAjpW7395jR+yGygs7k94L8NsEA1GT5M6t7nwdJHsb9JD+45McfD
qH31r6hgAaU2fQeN/ThygTK3dKcy2IyaIiU+LlHuCgNFjohmpTAHK4doNWRdsqES
bM32+weT1oBo16MnHWmUF77C+bn70H+YXND6dy5ijSYtT7AA/2CgWCRwIzTTNFbC
1Ky1g7zQGS+3zx89j9Wq
=sJKR
-----END PGP SIGNATURE-----

--va9XEZk9/dJ5GUjX--
