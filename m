Received: from eggs.gnu.org ([2001:4830:134:3::10]:36352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dawrD-0003F9-0v
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 00:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dawr6-0007q3-Dh
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 00:26:32 -0400
Date: Fri, 28 Jul 2017 13:49:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170728034925.GF3098@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100571083.27487.4628655387393519076.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="27ZtN5FSuKKSZcBU"
Content-Disposition: inline
In-Reply-To: <150100571083.27487.4628655387393519076.stgit@bahia>
Subject: Re: [Qemu-devel] [for-2.11 PATCH 18/26] spapr: create DR connectors
 for PHBs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>


--27ZtN5FSuKKSZcBU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 08:01:50PM +0200, Greg Kurz wrote:
> From: Michael Roth <mdroth@linux.vnet.ibm.com>
>=20
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Greg Kurz <groug@kaod.org>



> ---
> Changes since RFC:
> - rebased against ppc-for-2.10 (reset hooks registering already merged)
> - added new DRC type for PHB
> ---
>  hw/ppc/spapr.c             |   15 +++++++++++++++
>  hw/ppc/spapr_drc.c         |   17 +++++++++++++++++
>  include/hw/ppc/spapr_drc.h |    8 ++++++++
>  3 files changed, 40 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 8dc505343c0f..5950c009ab7e 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -98,6 +98,9 @@
> =20
>  #define PHANDLE_XICP            0x00001111
> =20
> +/* maximum number of hotpluggable PHBs */
> +#define SPAPR_DRC_MAX_PHB       256

I wonder if we should actually make this a machine property.

>  static ICSState *spapr_ics_create(sPAPRMachineState *spapr,
>                                    const char *type_ics,
>                                    int nr_irqs, Error **errp)
> @@ -2384,6 +2387,18 @@ static void ppc_spapr_init(MachineState *machine)
> =20
>      spapr->dr_phb_enabled =3D smc->dr_phb_enabled;
> =20
> +    /* Setup hotplug / dynamic-reconfiguration connectors. top-level
> +     * connectors (described in root DT node's "ibm,drc-types" property)
> +     * are pre-initialized here. additional child connectors (such as
> +     * connectors for a PHBs PCI slots) are added as needed during their
> +     * parent's realization.
> +     */
> +    if (spapr->dr_phb_enabled) {
> +        for (i =3D 0; i < SPAPR_DRC_MAX_PHB; i++) {
> +            spapr_dr_connector_new(OBJECT(machine), TYPE_SPAPR_DRC_PHB, =
i);
> +        }
> +    }
> +
>      /* Set up PCI */
>      spapr_pci_rtas_init();
> =20
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index eb8024d37c54..2e1049ce61c7 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -697,6 +697,15 @@ static void spapr_drc_lmb_class_init(ObjectClass *k,=
 void *data)
>      drck->release =3D spapr_lmb_release;
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
> @@ -740,6 +749,13 @@ static const TypeInfo spapr_drc_lmb_info =3D {
>      .class_init    =3D spapr_drc_lmb_class_init,
>  };
> =20
> +static const TypeInfo spapr_drc_phb_info =3D {
> +    .name          =3D TYPE_SPAPR_DRC_PHB,
> +    .parent        =3D TYPE_SPAPR_DRC_LOGICAL,

I thought PHB DRCs were physical..

> +    .instance_size =3D sizeof(sPAPRDRConnector),
> +    .class_init    =3D spapr_drc_phb_class_init,
> +};
> +
>  /* helper functions for external users */
> =20
>  sPAPRDRConnector *spapr_drc_by_index(uint32_t index)
> @@ -1179,6 +1195,7 @@ static void spapr_drc_register_types(void)
>      type_register_static(&spapr_drc_cpu_info);
>      type_register_static(&spapr_drc_pci_info);
>      type_register_static(&spapr_drc_lmb_info);
> +    type_register_static(&spapr_drc_phb_info);
> =20
>      spapr_rtas_register(RTAS_SET_INDICATOR, "set-indicator",
>                          rtas_set_indicator);
> diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> index a7958d0a8d14..535fc61b98a8 100644
> --- a/include/hw/ppc/spapr_drc.h
> +++ b/include/hw/ppc/spapr_drc.h
> @@ -69,6 +69,14 @@
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

--27ZtN5FSuKKSZcBU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll6tEUACgkQbDjKyiDZ
s5Ja3Q//ae81LScMxQ6OSkrG66KtfwcCjPu0hsNLnNUILLXjHZcbY2HHY7wxO8H9
CDe+woN5EDWQR2Io99RNLD8Nhdfq2iDn2nSliveudvF9+J4zL6vXsbkcP9xpyJxc
dkdgyZKoGJcSR8lmcge02Q9MCklphrByTJSze+sG16DbXx42ynhoT6QMgMO1AlrP
KV0JmcK8Ic6ghoC5JqPOiLnOotJ2YwfEWb5FHXKHcN5Arl53dzemMHtaXZe07aky
OkZfoQCjrburl+h8vB0OzewU3hXqga/khOMNYSYPap4M+cyueOUtgFfTtvyaQaqw
9w+5n9sn2uTh4hOF9MqOEgmJL2ekXEA8LfkXZ1+LZZYqmOkP4T46ITU1W2UmTSRs
0BHnH8cRjVjbc0W76VLuHwcoqntLPKwJ6EEmWa7/UlNQp1yXES9beLB2uGWc3QzF
cnlP/1EmTc6iJa86l12v43pBC/bJLvB+vhjWTTuX6JgPooqhgTfK53g9MnKV+uw0
oSpcB7wCQGS9WHfA06KRgOtSsVvVfZTOreCAESI9zk5baLbsSIKFL8R33OUU6maP
6kJ1TvyYf58xgW9EXACziNwAC5vPIeGlZtN/0cqvfW0iNGcxPOerDOCx8cwa3g86
t+dkLBZx9fMYAz7yOcsEW93/JV7Twh7M5sTFqYtluGEJusSWlzg=
=/h1P
-----END PGP SIGNATURE-----

--27ZtN5FSuKKSZcBU--
