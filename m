Received: from eggs.gnu.org ([209.51.188.92]:53799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gwIbE-0005ND-Q4
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:31:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gwIbD-0003Ta-L1
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:31:08 -0500
Date: Wed, 20 Feb 2019 14:25:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190220032544.GH9345@umbus.fritz.box>
References: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<155059669374.1466090.12943228478046223856.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tQHaQFR6K/xpRpl8"
Content-Disposition: inline
In-Reply-To: <155059669374.1466090.12943228478046223856.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 08/17] spapr_irq: Expose the phandle of
 the interrupt controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>


--tQHaQFR6K/xpRpl8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2019 at 06:18:13PM +0100, Greg Kurz wrote:
> This will be used by PHB hotplug in order to create the "interrupt-map"
> property of the PHB node.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
> v5: - return phandle by value
> v4: - return phandle via a pointer
> ---
>  hw/ppc/spapr_irq.c         |   21 +++++++++++++++++++++
>  include/hw/ppc/spapr_irq.h |    1 +
>  2 files changed, 22 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 359761494c6e..4145079d7fa5 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -638,6 +638,27 @@ void spapr_irq_reset(sPAPRMachineState *spapr, Error=
 **errp)
>      }
>  }
> =20
> +int spapr_irq_get_phandle(sPAPRMachineState *spapr, void *fdt, Error **e=
rrp)
> +{
> +    const char *nodename =3D spapr->irq->get_nodename(spapr);
> +    int offset, phandle;
> +
> +    offset =3D fdt_subnode_offset(fdt, 0, nodename);
> +    if (offset < 0) {
> +        error_setg(errp, "Can't find node \"%s\": %s", nodename,
> +                   fdt_strerror(offset));
> +        return -1;
> +    }
> +
> +    phandle =3D fdt_get_phandle(fdt, offset);
> +    if (!phandle) {
> +        error_setg(errp, "Can't get phandle of node \"%s\"", nodename);
> +        return -1;
> +    }
> +
> +    return phandle;
> +}
> +
>  /*
>   * XICS legacy routines - to deprecate one day
>   */
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 8bf1a7291966..ec1ee64fa62b 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -61,6 +61,7 @@ void spapr_irq_free(sPAPRMachineState *spapr, int irq, =
int num);
>  qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
>  int spapr_irq_post_load(sPAPRMachineState *spapr, int version_id);
>  void spapr_irq_reset(sPAPRMachineState *spapr, Error **errp);
> +int spapr_irq_get_phandle(sPAPRMachineState *spapr, void *fdt, Error **e=
rrp);
> =20
>  /*
>   * XICS legacy routines
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tQHaQFR6K/xpRpl8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxsyLgACgkQbDjKyiDZ
s5LZsBAAgEcVvN1+1Fj9HYjOhNFWb9Fr/KO7hWMLZkkyx5iXCewziv31gpUTgNUp
G7nA+axMr5QtlhN83TvpyN4b5+xzN8LkErWREUy7FwMm1hEVuiyMWh1by7KETHC0
t1mOTyImjcZmWM2C63VYpxzvERjC6CBIPC/s8XwYJ9hVa1Mwl/dllT7inmPO0EMR
yf0HlMwnqY1JV48YN1keCfqQN8DtcDOQCcYEp/wXFMPPfFEel41AspLGYNraOYzg
o6CQcvXXmUFnnvCHVCrpxBblHJwi1tsv2FAovAy6LoXkLXSorwWNXRLNKG/+wzm4
vZkkvaX8cSNr/cHHNyF5cUQ5CqubDFpqk2kO8Ru4Ww5nPpGd4BDcECft8APLuA6f
HD+tMWV8OZ5cLMqTlY6sKqqLkRSGgWp9Q82B0EaIgZvv7TdQ2POsnJ4EQbNs+fs0
1xPCB0wHktjka/u8sJcnzzYIPjAdeShnL5OLSYXcgYUFnV5mpay+hWyLOlI1QHto
jN55vNoogq1EEjrWzNLKhTbmOC79lXMbYhEf6Arct481nCQHetDbDeM7a6X6Neyh
fXZf014zbOxSBD354kldfADeSki6qWlWvBWKehb9x809rL42ivEcy0hT4px18C+X
qEDXD4XzfuhNXobNYs1MDl0l7m8sGDD/nTlq/HS5lkoFDNeXKNA=
=t6/R
-----END PGP SIGNATURE-----

--tQHaQFR6K/xpRpl8--
