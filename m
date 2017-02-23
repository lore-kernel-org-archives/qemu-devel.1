Received: from eggs.gnu.org ([2001:4830:134:3::10]:40603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgjkf-0003wU-Ah
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:07:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgjkd-0005Me-L3
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:07:29 -0500
Date: Thu, 23 Feb 2017 13:21:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170223022153.GU12577@umbus.fritz.box>
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
	<1487252865-12064-7-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pzbqGaOtRNiVr7w4"
Content-Disposition: inline
In-Reply-To: <1487252865-12064-7-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 06/22] ppc/xics: use the QOM interface
 under the sPAPR machine
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


--pzbqGaOtRNiVr7w4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2017 at 02:47:29PM +0100, C=E9dric Le Goater wrote:
> Add 'ics_get' and 'ics_resend' handlers to the sPAPR machine. These
> are relatively simple for a single ICS.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/intc/xics.c        |  2 +-
>  hw/ppc/spapr.c        | 18 ++++++++++++++++++
>  include/hw/ppc/xics.h |  1 +
>  3 files changed, 20 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 3e80d2d0f0d9..39c442f70116 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -193,7 +193,7 @@ static void ics_reject(ICSState *ics, uint32_t nr)
>      }
>  }
> =20
> -static void ics_resend(ICSState *ics)
> +void ics_resend(ICSState *ics)
>  {
>      ICSStateClass *k =3D ICS_BASE_GET_CLASS(ics);
> =20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 045f2323a4e9..85a973cce7ae 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2901,6 +2901,20 @@ static void spapr_phb_placement(sPAPRMachineState =
*spapr, uint32_t index,
>      *mmio64 =3D SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM64_WIN_SIZE;
>  }
> =20
> +static ICSState *spapr_ics_get(XICSInterface *dev, int irq)
> +{
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(dev);
> +
> +    return ics_valid_irq(spapr->ics, irq) ? spapr->ics : NULL;
> +}
> +
> +static void spapr_ics_resend(XICSInterface *dev)
> +{
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(dev);
> +
> +    ics_resend(spapr->ics);
> +}
> +
>  static void spapr_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> @@ -2909,6 +2923,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      NMIClass *nc =3D NMI_CLASS(oc);
>      HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(oc);
>      PPCVirtualHypervisorClass *vhc =3D PPC_VIRTUAL_HYPERVISOR_CLASS(oc);
> +    XICSInterfaceClass *xic =3D XICS_INTERFACE_CLASS(oc);
> =20
>      mc->desc =3D "pSeries Logical Partition (PAPR compliant)";
> =20
> @@ -2942,6 +2957,8 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      nc->nmi_monitor_handler =3D spapr_nmi;
>      smc->phb_placement =3D spapr_phb_placement;
>      vhc->hypercall =3D emulate_spapr_hypercall;
> +    xic->ics_get =3D spapr_ics_get;
> +    xic->ics_resend =3D spapr_ics_resend;
>  }
> =20
>  static const TypeInfo spapr_machine_info =3D {
> @@ -2958,6 +2975,7 @@ static const TypeInfo spapr_machine_info =3D {
>          { TYPE_NMI },
>          { TYPE_HOTPLUG_HANDLER },
>          { TYPE_PPC_VIRTUAL_HYPERVISOR },
> +        { TYPE_XICS_INTERFACE },
>          { }
>      },
>  };
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index fe2bb5c8ef54..640603b3d76d 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -222,5 +222,6 @@ void ics_simple_write_xive(ICSState *ics, int nr, int=
 server,
>  void ics_set_irq_type(ICSState *ics, int srcno, bool lsi);
> =20
>  ICSState *xics_find_source(XICSState *icp, int irq);
> +void ics_resend(ICSState *ics);
> =20
>  #endif /* XICS_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pzbqGaOtRNiVr7w4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYrkdBAAoJEGw4ysog2bOSg/kQAJ9F/zUOKPEiNpb69p0jaxCd
SEuokPkm7Eglwcow/COBPqtYnTNrB2mQ0dWVuXYEmAuUc8M7kYSQxlp4fGUba1gV
cynftkXOEDz1VzKsVKpbfRiwXn2qRS2DkS2j7GTfiNInvGfYa7LdeaIfDchYPI7S
XMDwE9oVOi5Mtxp1ZdvVOimICK1qvDaWJ4PesNnzXnE+NGaQQpXDc1YHwKl60m+M
GYriJs0yO+GAMz9pEYTDeA/E2ASZrbyq6dHgEVNXKMFBbdd70J9j3LpGDQS/5oT8
TCOt8ysqYAKar8kg1AIB5eSy1HgMtuZAsD5xoVZKKrM9m9YoJ0hYuoyz2+1g6fyx
NBxSCZLEwzPxPalFFJjenvvaXpYD95gc9EM42JMuoi5F7dQ+u399FIUF5IENIXNe
ZbYMha7ipsBgKyrFOLCtGLeIqpvFGpQqT08V8z76DjVqB0xuzbzpUAfZHHNH/3Ek
kWqJBXaYAMCftOaYzH5Rtpn04mrTtBJTjTerfHwP8OJPladdfp5MbSZSLM1UfHzN
xNs2gFyUxlsZj26OkliPH5kfR6z7DJjdk3X65V/5nYDvuK8uSimRvvvRbj/Mh1rI
Jb7/0InaY4S8ln6pBgUT85wEKO3cph4ZaUkZzF2QU109Bq1QvzevmBZPTFhekkA2
1LLwRaRJofdNLXjGOCG7
=t9Dq
-----END PGP SIGNATURE-----

--pzbqGaOtRNiVr7w4--
