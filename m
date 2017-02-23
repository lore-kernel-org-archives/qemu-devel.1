Received: from eggs.gnu.org ([2001:4830:134:3::10]:40503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgjkb-0003tu-LA
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:07:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgjka-0005L1-HF
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:07:25 -0500
Date: Thu, 23 Feb 2017 13:18:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170223021816.GT12577@umbus.fritz.box>
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
	<1487252865-12064-6-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aEcIyhw0mmnxygNd"
Content-Disposition: inline
In-Reply-To: <1487252865-12064-6-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 05/22] ppc/xics: introduce a QOM
 interface to handle ICSs
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


--aEcIyhw0mmnxygNd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2017 at 02:47:28PM +0100, C=E9dric Le Goater wrote:
> This QOM interface provides two simple handlers. One is to get an ICS
> object from an irq number and a second to resend the irqs when needed.

Maybe call this XICSFabric rather than XicsInterface.  While it's an
interface from the QOM point-of-view, that doesn't really describe
where it sits in the hardware model, and it's the ics and icp objects
which provide all the interfaces which are visible to the guest or to
interrupt generating devices.

Apart from that,

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/xics.c        |  7 +++++++
>  include/hw/ppc/xics.h | 18 ++++++++++++++++++
>  2 files changed, 25 insertions(+)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index b1294417a0ae..3e80d2d0f0d9 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -726,6 +726,12 @@ static const TypeInfo ics_base_info =3D {
>      .class_size =3D sizeof(ICSStateClass),
>  };
> =20
> +static const TypeInfo xics_interface_info =3D {
> +    .name =3D TYPE_XICS_INTERFACE,
> +    .parent =3D TYPE_INTERFACE,
> +    .class_size =3D sizeof(XICSInterfaceClass),
> +};
> +
>  /*
>   * Exported functions
>   */
> @@ -766,6 +772,7 @@ static void xics_register_types(void)
>      type_register_static(&ics_simple_info);
>      type_register_static(&ics_base_info);
>      type_register_static(&icp_info);
> +    type_register_static(&xics_interface_info);
>  }
> =20
>  type_init(xics_register_types)
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 6d443ce09dba..fe2bb5c8ef54 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -177,6 +177,24 @@ struct ICSIRQState {
>      uint8_t flags;
>  };
> =20
> +typedef struct XICSInterface {
> +    Object parent;
> +} XICSInterface;
> +
> +#define TYPE_XICS_INTERFACE "xics-interface"
> +#define XICS_INTERFACE(obj)                                     \
> +    OBJECT_CHECK(XICSInterface, (obj), TYPE_XICS_INTERFACE)
> +#define XICS_INTERFACE_CLASS(klass)                                     \
> +    OBJECT_CLASS_CHECK(XICSInterfaceClass, (klass), TYPE_XICS_INTERFACE)
> +#define XICS_INTERFACE_GET_CLASS(obj)                                   \
> +    OBJECT_GET_CLASS(XICSInterfaceClass, (obj), TYPE_XICS_INTERFACE)
> +
> +typedef struct XICSInterfaceClass {
> +    InterfaceClass parent;
> +    ICSState *(*ics_get)(XICSInterface *xi, int irq);
> +    void (*ics_resend)(XICSInterface *xi);
> +} XICSInterfaceClass;
> +
>  #define XICS_IRQS_SPAPR               1024
> =20
>  qemu_irq xics_get_qirq(XICSState *icp, int irq);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--aEcIyhw0mmnxygNd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYrkZoAAoJEGw4ysog2bOST6wQAIUMai7lPbJ6wex5WKxiAPgp
2/gRS3JDD13W22neXr2OHBhvEa7H9Hgt6z1zhiggxdu68MWJ5Mzywa6hUGW6xPnP
7NcewhvuUzKH20/3WAuVWqBXTwgwlU1f+wv7yHhfSH319RbVc8l/5+lAe2M3tw9O
8OPnvYXxbpN7P2v+ydjR7tDwfXOerJb7SX0ep3nvfirZzboTq1redpJ/jDy3dBKc
LwEvptqRMCuzTxPbnpYtm5B0eIADorQZ8fDBYt9oQpt6YeLt/MslScxgiSKgH2US
gte+Qaa1bVl6Imo+AxI7vuXxGlLNoYV3GNs1n9nAQ60eGrWII4YQgu66gkjg9PfT
w0XjCUEAEwy6KjTtLyeRrG80ZcUKayOaeMs+Qwsf3QslfrqaWqzNrlkSpolgGBXV
/0VCv/+O7hVOQZvV98N7O8r1fq3+5NtVBs/IuPljt32j100ENdlhfHXGJwnKWoK4
dg84P0Uoq7darxUmDKd5TsUYv8sVD68XjQDQ1vacWGQ0YcmVTlc6ffSZWh+droNt
sGkKXmEAAzK4b46tWKWJAiALWG2IqC+CBLrM4Q2/Hf6rLE6kgkboTwDMgMNXmMpJ
6F6rxnWbUTTU0oXnXBOUD4Qbvh3nRFquGzxOrWfQwPmehssJZ6q0aZ0Czc6veq4s
decem8yTmj4P+F+kmQkR
=d9vF
-----END PGP SIGNATURE-----

--aEcIyhw0mmnxygNd--
