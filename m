Received: from eggs.gnu.org ([208.118.235.92]:38218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gesZb-0002Xa-4l
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 21:17:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gesZV-0004tb-8c
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 21:17:26 -0500
Date: Thu, 3 Jan 2019 11:33:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190103003324.GF10853@umbus.fritz.box>
References: <154535246529.862554.6113740443866753456.stgit@bahia.lan>
	<154535250941.862554.15763512831843902652.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3yNHWXBV/QO9xKNm"
Content-Disposition: inline
In-Reply-To: <154535250941.862554.15763512831843902652.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 02/15] spapr: move spapr_create_phb() to
 core machine code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>


--3yNHWXBV/QO9xKNm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 21, 2018 at 01:35:09AM +0100, Greg Kurz wrote:
> This function is only used when creating the default PHB. Let's rename
> it and move it to the core machine code for clarity.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Applied to ppc-for-4.0, thanks.

> ---
>  hw/ppc/spapr.c              |   13 ++++++++++++-
>  hw/ppc/spapr_pci.c          |   11 -----------
>  include/hw/pci-host/spapr.h |    2 --
>  3 files changed, 12 insertions(+), 14 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 8ea680fcde1e..1f17b5d01f4f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2551,6 +2551,17 @@ static void spapr_init_cpus(sPAPRMachineState *spa=
pr)
>      }
>  }
> =20
> +static PCIHostState *spapr_create_default_phb(void)
> +{
> +    DeviceState *dev;
> +
> +    dev =3D qdev_create(NULL, TYPE_SPAPR_PCI_HOST_BRIDGE);
> +    qdev_prop_set_uint32(dev, "index", 0);
> +    qdev_init_nofail(dev);
> +
> +    return PCI_HOST_BRIDGE(dev);
> +}
> +
>  /* pSeries LPAR / sPAPR hardware init */
>  static void spapr_machine_init(MachineState *machine)
>  {
> @@ -2782,7 +2793,7 @@ static void spapr_machine_init(MachineState *machin=
e)
>      /* Set up PCI */
>      spapr_pci_rtas_init();
> =20
> -    phb =3D spapr_create_phb(spapr, 0);
> +    phb =3D spapr_create_default_phb();
> =20
>      for (i =3D 0; i < nb_nics; i++) {
>          NICInfo *nd =3D &nd_table[i];
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 2374d55fc112..e59adbe706bb 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1979,17 +1979,6 @@ static const TypeInfo spapr_phb_info =3D {
>      }
>  };
> =20
> -PCIHostState *spapr_create_phb(sPAPRMachineState *spapr, int index)
> -{
> -    DeviceState *dev;
> -
> -    dev =3D qdev_create(NULL, TYPE_SPAPR_PCI_HOST_BRIDGE);
> -    qdev_prop_set_uint32(dev, "index", index);
> -    qdev_init_nofail(dev);
> -
> -    return PCI_HOST_BRIDGE(dev);
> -}
> -
>  typedef struct sPAPRFDT {
>      void *fdt;
>      int node_off;
> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> index 7c66c3872f96..a65cfef16945 100644
> --- a/include/hw/pci-host/spapr.h
> +++ b/include/hw/pci-host/spapr.h
> @@ -111,8 +111,6 @@ static inline qemu_irq spapr_phb_lsi_qirq(struct sPAP=
RPHBState *phb, int pin)
>      return spapr_qirq(spapr, phb->lsi_table[pin].irq);
>  }
> =20
> -PCIHostState *spapr_create_phb(sPAPRMachineState *spapr, int index);
> -
>  int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t xics_phandle, voi=
d *fdt,
>                            uint32_t nr_msis);
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3yNHWXBV/QO9xKNm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwtWFQACgkQbDjKyiDZ
s5IRZhAAzG28PO7JseL1RgnMiQx+Z4zUITA7e6WxXCu0RhMIyXrh7jPtod45olTT
AYCb8v1YB2AIJASQw9/JLdkGtr9OlGe5VRe2xxbETN6pNcynjMcZZY5R7FU3jyPP
bbQzW1kiXVtUMsSw57ovgL0LMpRHizYk9Q9NXaRILoHAHQVtaSQ24U9fGnyXGni2
er6V2NyRPKQyENuQ+S0desAQyCm1X/4/O5tGaI+uQS/+R6Vi3qc9A6Cba5n7Y2Qz
zAZaoEFSvnAxv1TcjQPHn2mmsKwAtnFqsRlm64NJq8v9sPpxAozZEm1iOKIUo51+
D1YLfmMtOQcRJJ2yPU2MLgrant1BvZomr65zzFyCATZ7Cxv1Hc98CZ9jFMZ3mm8q
5t4GCttQdBAmD0SG6kfwC6BK0/Rce3QZTwHnQd/ZooB8NNHyuBazDEguvtYDSt0B
/aFBpsnznxbrRTzhmc+nKXF2n/EQCA4gzxA+Jo95hzVkrxHZroF4fNaKTeI/sKtN
NDDFAGUOXxo9DMARve53w/VSyXRObU2+JTeNFWvyIlReAq8ew76x5rmKQKYWOtMA
Iw5taaK6mYUr+Jt4akTzksi+i9Z7VmDgWOYDt5ZmsIJl7dk0NIyxkwy8dXaJSFtQ
YkzoNKFYKcv2CwglpWSJ/K8ovcirL361UrTJWjfyRPumF9fFQxY=
=ANqt
-----END PGP SIGNATURE-----

--3yNHWXBV/QO9xKNm--
