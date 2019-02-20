Received: from eggs.gnu.org ([209.51.188.92]:53821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gwIbF-0005NJ-82
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:31:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gwIbD-0003Tj-UB
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:31:09 -0500
Date: Wed, 20 Feb 2019 14:27:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190220032721.GJ9345@umbus.fritz.box>
References: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<155059670389.1466090.10015601248906623076.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WTEzZvM72OaERIi0"
Content-Disposition: inline
In-Reply-To: <155059670389.1466090.10015601248906623076.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 10/17] spapr: create DR connectors for
 PHBs
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


--WTEzZvM72OaERIi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2019 at 06:18:23PM +0100, Greg Kurz wrote:
> From: Michael Roth <mdroth@linux.vnet.ibm.com>
>=20
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
>  hw/ppc/spapr.c             |   13 +++++++++++++
>  hw/ppc/spapr_drc.c         |   17 +++++++++++++++++
>  include/hw/ppc/spapr.h     |    1 +
>  include/hw/ppc/spapr_drc.h |    8 ++++++++
>  4 files changed, 39 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 9364d07364ac..96bea7580a3f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2875,6 +2875,19 @@ static void spapr_machine_init(MachineState *machi=
ne)
>      /* We always have at least the nvram device on VIO */
>      spapr_create_nvram(spapr);
> =20
> +    /*
> +     * Setup hotplug / dynamic-reconfiguration connectors. top-level
> +     * connectors (described in root DT node's "ibm,drc-types" property)
> +     * are pre-initialized here. additional child connectors (such as
> +     * connectors for a PHBs PCI slots) are added as needed during their
> +     * parent's realization.
> +     */
> +    if (smc->dr_phb_enabled) {
> +        for (i =3D 0; i < SPAPR_MAX_PHBS; i++) {
> +            spapr_dr_connector_new(OBJECT(machine), TYPE_SPAPR_DRC_PHB, =
i);
> +        }
> +    }
> +
>      /* Set up PCI */
>      spapr_pci_rtas_init();
> =20
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 87ca7d973564..fd6380adb367 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -696,6 +696,15 @@ static void spapr_drc_lmb_class_init(ObjectClass *k,=
 void *data)
>      drck->dt_populate =3D spapr_lmb_dt_populate;
>  }
> =20
> +static void spapr_drc_phb_class_init(ObjectClass *k, void *data)
> +{
> +    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_CLASS(k);
> +
> +    drck->typeshift =3D SPAPR_DR_CONNECTOR_TYPE_SHIFT_PHB;
> +    drck->typename =3D "PHB";
> +    drck->drc_name_prefix =3D "PHB ";
> +}
> +
>  static const TypeInfo spapr_dr_connector_info =3D {
>      .name          =3D TYPE_SPAPR_DR_CONNECTOR,
>      .parent        =3D TYPE_DEVICE,
> @@ -739,6 +748,13 @@ static const TypeInfo spapr_drc_lmb_info =3D {
>      .class_init    =3D spapr_drc_lmb_class_init,
>  };
> =20
> +static const TypeInfo spapr_drc_phb_info =3D {
> +    .name          =3D TYPE_SPAPR_DRC_PHB,
> +    .parent        =3D TYPE_SPAPR_DRC_LOGICAL,
> +    .instance_size =3D sizeof(sPAPRDRConnector),
> +    .class_init    =3D spapr_drc_phb_class_init,
> +};
> +
>  /* helper functions for external users */
> =20
>  sPAPRDRConnector *spapr_drc_by_index(uint32_t index)
> @@ -1207,6 +1223,7 @@ static void spapr_drc_register_types(void)
>      type_register_static(&spapr_drc_cpu_info);
>      type_register_static(&spapr_drc_pci_info);
>      type_register_static(&spapr_drc_lmb_info);
> +    type_register_static(&spapr_drc_phb_info);
> =20
>      spapr_rtas_register(RTAS_SET_INDICATOR, "set-indicator",
>                          rtas_set_indicator);
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 5e3c76072505..b173fd714904 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -104,6 +104,7 @@ struct sPAPRMachineClass {
> =20
>      /*< public >*/
>      bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of LMB=
s */
> +    bool dr_phb_enabled;       /* enable dynamic-reconfig/hotplug of PHB=
s */
>      bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
>      bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
>      bool pre_2_10_has_unused_icps;
> diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> index f32758ec8487..46b0f6216d83 100644
> --- a/include/hw/ppc/spapr_drc.h
> +++ b/include/hw/ppc/spapr_drc.h
> @@ -71,6 +71,14 @@
>  #define SPAPR_DRC_LMB(obj) OBJECT_CHECK(sPAPRDRConnector, (obj), \
>                                          TYPE_SPAPR_DRC_LMB)
> =20
> +#define TYPE_SPAPR_DRC_PHB "spapr-drc-phb"
> +#define SPAPR_DRC_PHB_GET_CLASS(obj) \
> +        OBJECT_GET_CLASS(sPAPRDRConnectorClass, obj, TYPE_SPAPR_DRC_PHB)
> +#define SPAPR_DRC_PHB_CLASS(klass) \
> +        OBJECT_CLASS_CHECK(sPAPRDRConnectorClass, klass, TYPE_SPAPR_DRC_=
PHB)
> +#define SPAPR_DRC_PHB(obj) OBJECT_CHECK(sPAPRDRConnector, (obj), \
> +                                        TYPE_SPAPR_DRC_PHB)
> +
>  /*
>   * Various hotplug types managed by sPAPRDRConnector
>   *
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WTEzZvM72OaERIi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxsyRgACgkQbDjKyiDZ
s5JsmA//YPm3cKXJnxRbaMbDkUBIfuoIrTuWh51XhE5PQcRgsWPr854R1Uirbuxz
z5psd9IYSdOi0SAN7o9+idYfn9GDBD0PyDO1KFR0uJ6dd9s8hB8BVU/CxvKu9ry0
CJFwcw5o7y0Uc+RnKkNMvwHI8p6YQ3nMJBhyzJ/ojwZ5k1FuywPOP82CQGzE3PZa
t7R43BhBTeAf6i0I+jJjbzomBLH1j/7bLedctEsyfTsB/1vHUeF158jTEmBs9Baa
McTtafKlL50/+kevpsIRVax29XHi7qFU/lCLp52yVBC8/GFLLcNPdB4NYulRYtC1
yKgcJ4sWqvqnHbN/C2QwtEED+X4K335v/qbNW6gGc8Zw03ZobC91hOGtcCAOUy2n
LhJw4LbdFn9yvdnBBEsKCr/UuC+mMBe6dd9wC/ys4l11u+EGJMy/eIqW/NH27n+a
f6nU52juXKoUxhD8WfOuNxumop7TfreRDNxJemTyfcsr+HR9l/AsIbIRp9lBxHrC
DuQqwKXm9rh1VETPMwbr68RqURPlBGlt33Gu3J4H61hbHtwGmWr+oFz78MdLMLus
v+oqAsZXYE5tBLWawsrCIee5ZAFAkRgJzZy672+nvI2ei7jHy2+GLRFV7TmdWwl8
9sErphO5kv08Pv7fhRm7sZUKGkzKBSlgXdWbX4wzmHyyg5eXQoI=
=6rM2
-----END PGP SIGNATURE-----

--WTEzZvM72OaERIi0--
