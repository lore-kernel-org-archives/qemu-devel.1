Received: from eggs.gnu.org ([209.51.188.92]:59951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtlvw-0003I7-OG
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 23:14:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtlvv-0005Gh-2N
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 23:14:04 -0500
Date: Wed, 13 Feb 2019 14:52:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190213035203.GD1884@umbus.fritz.box>
References: <154999583316.690774.15072605479770041782.stgit@bahia.lan>
	<154999586635.690774.6503848986369114097.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bnBIwIKtMHAVL+3z"
Content-Disposition: inline
In-Reply-To: <154999586635.690774.6503848986369114097.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v4 05/15] spapr_irq: Expose the phandle of
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


--bnBIwIKtMHAVL+3z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 07:24:26PM +0100, Greg Kurz wrote:
> This will be used by PHB hotplug in order to create the "interrupt-map"
> property of the PHB node.
>=20
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v4: - return phandle via a pointer

You don't really need to do this.  You already have an Error ** to
return errors via, so you don't need an error return code.  Plus
phandles are not permitted to be 0 or -1, so you have some safe values
even for that case.

> ---
>  hw/ppc/spapr_irq.c         |   26 ++++++++++++++++++++++++++
>  include/hw/ppc/spapr_irq.h |    2 ++
>  2 files changed, 28 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index b8d725e251ba..31495033c37c 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -692,6 +692,32 @@ void spapr_irq_reset(sPAPRMachineState *spapr, Error=
 **errp)
>      }
>  }
> =20
> +int spapr_irq_get_phandle(sPAPRMachineState *spapr, void *fdt,
> +                          uint32_t *phandle, Error **errp)
> +{
> +    const char *nodename =3D spapr->irq->get_nodename(spapr);
> +    int offset, ph;
> +
> +    offset =3D fdt_subnode_offset(fdt, 0, nodename);
> +    if (offset < 0) {
> +        error_setg(errp, "Can't find node \"%s\": %s", nodename,
> +                   fdt_strerror(offset));
> +        return -1;
> +    }
> +
> +    ph =3D fdt_get_phandle(fdt, offset);
> +    if (!ph) {
> +        error_setg(errp, "Can't get phandle of node \"%s\"", nodename);
> +        return -1;
> +    }
> +
> +    if (phandle) {
> +        *phandle =3D ph;
> +    }
> +
> +    return 0;
> +}
> +
>  /*
>   * XICS legacy routines - to deprecate one day
>   */
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index ad7127355441..4b3303ef4f6a 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -62,6 +62,8 @@ void spapr_irq_free(sPAPRMachineState *spapr, int irq, =
int num);
>  qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
>  int spapr_irq_post_load(sPAPRMachineState *spapr, int version_id);
>  void spapr_irq_reset(sPAPRMachineState *spapr, Error **errp);
> +int spapr_irq_get_phandle(sPAPRMachineState *spapr, void *fdt,
> +                          uint32_t *phandle, Error **errp);
> =20
>  /*
>   * XICS legacy routines
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bnBIwIKtMHAVL+3z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxjlGMACgkQbDjKyiDZ
s5K9wA//QHInEevT7u9nFZXMrIwTwFqNjcY5E9y6exd1kpRRnM9+SkBJkgMmcLiR
1fCJ87eP+5ebBvt6k3m9NUAalu5WWTrIEvKJf+W+aVpj0WOzXNeiRorbVDxCJOSY
QhXgOkmNGvAcaWovxFn8p+nsH2gE4bcvjBPJn19Qn/GSbjmVEVodl1la0Da03EO2
XYOiUg7sX4EGmDznXqCCLczkDfJQ0ZAFGcHeh+4VGCu1IUHlYvihihohluaOCEy0
ZIfvIXByW/W5iqVox+BhYZgEMkagIrJFRApcNyJsACUQt+0Noco08Qg6EZsvrbsY
SbVb5E+/EJ44Ez8PFmMk78KWvVCyDs1TNmkWz3kBOphTy3yM0cuOmoXoJOQP7Q8l
PboZGeMfrBOTlbY52W7GiLs5KEKIkLmD/bzvQL9AC0T3iR031H1bvu7VcTjd9u7i
NKhVD1PAZ1CPbna5g8xZoj/p+W7pjpNw2H/38FJh8uvIdHH9HzWsf0TExkCiq/yP
YN6MXwc6c8+tb7YTTd3kY7OXxQBt/1vlEjdq/KxZLSF0xZgvUFMXCCJN/5WQ2Gp6
booSBdYb8iT3endVo2qMgCUhxasDOjKCkmeWEcpxZSBeQcJczzaZG51VqyPG2bJg
1lCb6xECgJvhJQmx2/6mFsQ/aDqGxJ6EBp2x7v6RjKmnMppGgG8=
=QQUS
-----END PGP SIGNATURE-----

--bnBIwIKtMHAVL+3z--
