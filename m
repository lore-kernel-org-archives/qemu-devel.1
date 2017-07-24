Received: from eggs.gnu.org ([2001:4830:134:3::10]:58907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZVgf-0003aU-KX
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 01:13:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZVge-0008Du-In
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 01:13:45 -0400
Date: Mon, 24 Jul 2017 15:13:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170724051334.GH17228@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-12-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y0Ed1hDcWxc3B7cn"
Content-Disposition: inline
In-Reply-To: <1499274819-15607-12-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH 11/26] ppc/xics: introduce a
 print_info() handler to the ICS and ICP objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--y0Ed1hDcWxc3B7cn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2017 at 07:13:24PM +0200, C=E9dric Le Goater wrote:
> This handler will be used to customize the ouput of the XIVE interrupt
> source and presenter objects.

I'm not really happy with this without having a clear idea of where
this is heading - are you trying to share ICP and or ICS object
classes between XICS and XIVE, or will they eventually be separated
again?

>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/xics.c        | 36 ++++++++++++++++++++++++------------
>  include/hw/ppc/xics.h |  2 ++
>  2 files changed, 26 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index faa5c631f655..7837c2022b4a 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -40,18 +40,26 @@
> =20
>  void icp_pic_print_info(ICPState *icp, Monitor *mon)
>  {
> +    ICPStateClass *k =3D ICP_GET_CLASS(icp);
>      int cpu_index =3D icp->cs ? icp->cs->cpu_index : -1;
> =20
>      if (!icp->output) {
>          return;
>      }
> -    monitor_printf(mon, "CPU %d XIRR=3D%08x (%p) PP=3D%02x MFRR=3D%02x\n=
",
> -                   cpu_index, icp->xirr, icp->xirr_owner,
> -                   icp->pending_priority, icp->mfrr);
> +
> +    monitor_printf(mon, "CPU %d ", cpu_index);
> +    if (k->print_info) {
> +        k->print_info(icp, mon);
> +    } else {
> +        monitor_printf(mon, "XIRR=3D%08x (%p) PP=3D%02x MFRR=3D%02x\n",
> +                       icp->xirr, icp->xirr_owner,
> +                       icp->pending_priority, icp->mfrr);
> +    }
>  }
> =20
>  void ics_pic_print_info(ICSState *ics, Monitor *mon)
>  {
> +    ICSStateClass *k =3D ICS_BASE_GET_CLASS(ics);
>      uint32_t i;
> =20
>      monitor_printf(mon, "ICS %4x..%4x %p\n",
> @@ -61,17 +69,21 @@ void ics_pic_print_info(ICSState *ics, Monitor *mon)
>          return;
>      }
> =20
> -    for (i =3D 0; i < ics->nr_irqs; i++) {
> -        ICSIRQState *irq =3D ics->irqs + i;
> +    if (k->print_info) {
> +        k->print_info(ics, mon);
> +    } else {
> +        for (i =3D 0; i < ics->nr_irqs; i++) {
> +            ICSIRQState *irq =3D ics->irqs + i;
> =20
> -        if (!(irq->flags & XICS_FLAGS_IRQ_MASK)) {
> -            continue;
> +            if (!(irq->flags & XICS_FLAGS_IRQ_MASK)) {
> +                continue;
> +            }
> +            monitor_printf(mon, "  %4x %s %02x %02x\n",
> +                           ics->offset + i,
> +                           (irq->flags & XICS_FLAGS_IRQ_LSI) ?
> +                           "LSI" : "MSI",
> +                           irq->priority, irq->status);
>          }
> -        monitor_printf(mon, "  %4x %s %02x %02x\n",
> -                       ics->offset + i,
> -                       (irq->flags & XICS_FLAGS_IRQ_LSI) ?
> -                       "LSI" : "MSI",
> -                       irq->priority, irq->status);
>      }
>  }
> =20
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 28d248abad61..902f3bfd0e33 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -69,6 +69,7 @@ struct ICPStateClass {
>      void (*pre_save)(ICPState *icp);
>      int (*post_load)(ICPState *icp, int version_id);
>      void (*reset)(ICPState *icp);
> +    void (*print_info)(ICPState *icp, Monitor *mon);
>  };
> =20
>  struct ICPState {
> @@ -119,6 +120,7 @@ struct ICSStateClass {
>      void (*reject)(ICSState *s, uint32_t irq);
>      void (*resend)(ICSState *s);
>      void (*eoi)(ICSState *s, uint32_t irq);
> +    void (*print_info)(ICSState *s, Monitor *mon);
>  };
> =20
>  struct ICSState {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--y0Ed1hDcWxc3B7cn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll1gf4ACgkQbDjKyiDZ
s5JEIg/+MTZXPzZe/lMsfUdvQwriZbaF2ngGb80KI47LdW84azf0QZS8ane5489f
4YDm59Y3YsHgSvq+aK+ar5WmU/qD1vqjHXeoJD+oVcCqqhm+C/UHdmikUJCE5yx7
6xiba0mxd3yn6DTd0Er3ZZ97cZaRApOaf1pU7oPLnIeznJK89QPLJp6qpTfOnky1
HKafUUARJGnP6qqCJeiSUt2NlLlQY13zyW9qK11qaG2fRYtDt7ibfCAFk9qAh0XI
5TdB7laH+Xe+832SRmx7PvQ1LUfdwlfY2UhI0kmkmaLGKfijXBEGIBbOd9j9qQdz
p56eurQG3XpAiyk1LN+/xcB1vXpNV+8Dfhwe7nCsaAMXdNlOtaTAmDeqnbewLtGr
xEJAy6IKiKwMM/eb6QsjSbS62ZL29gYNI6QC9mF2VC9bgIpD+8V5UulH2xxeHzio
aHJa53AdFhZroG2Kb/QI5okKVEJZQcC2B+a5Ag5IO85M3evuruZfoi3AIscSeOAY
CaRV3vjD2MsWCeg9mvhLmrjkHIqNm3bemMSreB7ymf3omAd3W64qrrzPbnBZTCag
sThGXiWTtf5gmpIaaUG3bzmX/nZFBSw/qAAFkcRp1rSEGEUQcuJtzxB+UIxaWRRm
1ZRTmAeLSIbPqKwrgIlSTVUVuaMDNx96YEkxtm+3LpQRVYu6568=
=u3JK
-----END PGP SIGNATURE-----

--y0Ed1hDcWxc3B7cn--
