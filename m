Received: from eggs.gnu.org ([209.51.188.92]:59961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtlvx-0003Iu-9a
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 23:14:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtlvv-0005Go-50
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 23:14:05 -0500
Date: Wed, 13 Feb 2019 15:05:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190213040522.GG1884@umbus.fritz.box>
References: <154999583316.690774.15072605479770041782.stgit@bahia.lan>
	<154999591892.690774.10674853078354564704.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nE/5a/j5SCML90Nq"
Content-Disposition: inline
In-Reply-To: <154999591892.690774.10674853078354564704.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v4 13/15] spapr_drc: Allow FDT fragment to
 be added later
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


--nE/5a/j5SCML90Nq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 07:25:19PM +0100, Greg Kurz wrote:
> The current logic is to provide the FDT fragment when attaching a device
> to a DRC. This works perfectly fine for our current hotplug support, but
> soon we will add support for PHB hotplug which has some constraints, that
> CPU, PCI and LMB devices don't seem to have.
>=20
> The first constraint is that the "ibm,dma-window" property of the PHB
> node requires the IOMMU to be configured, ie, spapr_tce_table_enable()
> has been called, which happens during PHB reset. It is okay in the case
> of hotplug since the device is reset before the hotplug handler is
> called. On the contrary with coldplug, the hotplug handler is called
> first and device is only reset during the initial system reset. Trying
> to create the FDT fragment on the hotplug path in this case, would
> result in somthing like this:
>=20
> ibm,dma-window =3D < 0x80000000 0x00 0x00 0x00 0x00 >;
>=20
> This will cause linux in the guest to panic, by simply removing and
> re-adding the PHB using the drmgr command:
>=20
> 	page =3D alloc_pages_node(nid, GFP_KERNEL, get_order(sz));
> 	if (!page)
> 		panic("iommu_init_table: Can't allocate %ld bytes\n", sz);
>=20
> The second and maybe more problematic constraint is that the
> "interrupt-map" property needs to reference the interrupt controller
> node using the very same phandle that SLOF has already exposed to the
> guest. QEMU requires SLOF to call the private KVMPPC_H_UPDATE_DT hcall
> at some point to know about this phandle. With the latest QEMU and SLOF,
> this happens when SLOF gets quiesced. This means that if the PHB gets
> hotplugged after CAS but before SLOF quiesce, then we're sure that the
> phandle is not known when the hotplug handler is called.
>=20
> The FDT is only needed when the guest first invokes RTAS to configure
> the connector actually, long after SLOF quiesce. Let's postpone the
> creation of FDT fragments for PHBs to rtas_ibm_configure_connector().
>=20
> Since we only need this for PHBs, introduce a new method in the base
> DRC class for that. It will implemented for "spapr-drc-phb" DRCs in
> a subsequent patch.
>=20
> Allow spapr_drc_attach() to be passed a NULL fdt argument if the method
> is available.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

The basic solution looks fine.  However I don't much like the fact
that this leaves us with two ways to handle the fdt fragment - either
at connect time or at configure connector time via a callback.  qemu
already has way to many places where there are confusingly multiple
ways to do things.

I know it's a detour, but I'd really prefer to convert the existing
DRC handling to this new callback scheme, rather than have two
different approaches.

> ---
>  hw/ppc/spapr_drc.c         |   34 +++++++++++++++++++++++++++++-----
>  include/hw/ppc/spapr_drc.h |    6 ++++++
>  2 files changed, 35 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 189ee681062a..c5a281915665 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -22,6 +22,7 @@
>  #include "qemu/error-report.h"
>  #include "hw/ppc/spapr.h" /* for RTAS return codes */
>  #include "hw/pci-host/spapr.h" /* spapr_phb_remove_pci_device_cb callbac=
k */
> +#include "sysemu/device_tree.h"
>  #include "trace.h"
> =20
>  #define DRC_CONTAINER_PATH "/dr-connector"
> @@ -376,6 +377,8 @@ static void prop_get_fdt(Object *obj, Visitor *v, con=
st char *name,
>  void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
>                        int fdt_start_offset, Error **errp)
>  {
> +    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> +
>      trace_spapr_drc_attach(spapr_drc_index(drc));
> =20
>      if (drc->dev) {
> @@ -384,11 +387,14 @@ void spapr_drc_attach(sPAPRDRConnector *drc, Device=
State *d, void *fdt,
>      }
>      g_assert((drc->state =3D=3D SPAPR_DRC_STATE_LOGICAL_UNUSABLE)
>               || (drc->state =3D=3D SPAPR_DRC_STATE_PHYSICAL_POWERON));
> -    g_assert(fdt);
> +    g_assert(fdt || drck->populate_dt);
> =20
>      drc->dev =3D d;
> -    drc->fdt =3D fdt;
> -    drc->fdt_start_offset =3D fdt_start_offset;
> +
> +    if (fdt) {
> +        drc->fdt =3D fdt;
> +        drc->fdt_start_offset =3D fdt_start_offset;
> +    }
> =20
>      object_property_add_link(OBJECT(drc), "device",
>                               object_get_typename(OBJECT(drc->dev)),
> @@ -1118,10 +1124,28 @@ static void rtas_ibm_configure_connector(PowerPCC=
PU *cpu,
>          goto out;
>      }
> =20
> -    g_assert(drc->fdt);
> -
>      drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> =20
> +    g_assert(drc->fdt || drck->populate_dt);
> +
> +    if (!drc->fdt) {
> +        Error *local_err =3D NULL;
> +        void *fdt;
> +        int fdt_size;
> +
> +        fdt =3D create_device_tree(&fdt_size);
> +
> +        if (drck->populate_dt(drc->dev, spapr, fdt, &drc->fdt_start_offs=
et,
> +                               &local_err)) {
> +            g_free(fdt);
> +            error_free(local_err);
> +            rc =3D SPAPR_DR_CC_RESPONSE_ERROR;
> +            goto out;
> +        }
> +
> +        drc->fdt =3D fdt;
> +    }
> +
>      do {
>          uint32_t tag;
>          const char *name;
> diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> index 56bba36ad4da..e947d6987bf2 100644
> --- a/include/hw/ppc/spapr_drc.h
> +++ b/include/hw/ppc/spapr_drc.h
> @@ -18,6 +18,7 @@
>  #include "qom/object.h"
>  #include "sysemu/sysemu.h"
>  #include "hw/qdev.h"
> +#include "qapi/error.h"
> =20
>  #define TYPE_SPAPR_DR_CONNECTOR "spapr-dr-connector"
>  #define SPAPR_DR_CONNECTOR_GET_CLASS(obj) \
> @@ -221,6 +222,8 @@ typedef struct sPAPRDRConnector {
>      int fdt_start_offset;
>  } sPAPRDRConnector;
> =20
> +struct sPAPRMachineState;
> +
>  typedef struct sPAPRDRConnectorClass {
>      /*< private >*/
>      DeviceClass parent;
> @@ -236,6 +239,9 @@ typedef struct sPAPRDRConnectorClass {
>      uint32_t (*isolate)(sPAPRDRConnector *drc);
>      uint32_t (*unisolate)(sPAPRDRConnector *drc);
>      void (*release)(DeviceState *dev);
> +
> +    int (*populate_dt)(DeviceState *dev, struct sPAPRMachineState *spapr,
> +                       void *fdt, int *fdt_start_offset, Error **errp);
>  } sPAPRDRConnectorClass;
> =20
>  typedef struct sPAPRDRCPhysical {
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nE/5a/j5SCML90Nq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxjl4IACgkQbDjKyiDZ
s5J4rA/5Aa7beCATb8fKm8G2YFqIUOzewhvlvDGnrDzauC1FyIR52I3enr2bcAzX
BScdmJoi93hNakXX8ZJKyaaYFfE7GPiD/AxNAMZPnU9NhHdM/upF9dIj5MMDworO
ZQjHccaMvPgIDNxlXzn89EhLgSYZxl/i90HJ3wpV2YXMAoAjOXk81kAWTmSYsNFu
JKelmO70QNRr8aXK1FkRf+Jn4/B1zUSZuvc7LKAG1W+lioQMl84ODZkxQz5eMHjL
NC0w2usCXz6STO0pPAbIEoHGT60bYWpvRmnFTEFfL4zc1DG1StkxYhi+KJBLt/kN
ogcmwzv/FgZnk2cvhCcPOA2JjMqjmp5iBZkJrfmBKTahXYpLujqdW1PiFvcGMXpa
wYZMzyF5s2AkhAYufERSW1DM0TBcZrosY0ocXISuLfmjFcewmbAOyRQLUhSUxxiI
ZqaeNxF4bp1nLkjZJ6X93TDpKD61Sxn41xlMUjUHXL5x+IdCd6o/Lg9Kah1dRSq8
kT8GtLPUyHGBEm5fz3ktgFo5y9+dtML2244g2beO8VGq49fIAOXroGCuai9AFx7/
yRiLWjpxoSDC09QsPd7kWLCs2LaEp2N6Opb9xrgsRN+a6tvFs65b1h50QhVJEO3N
UcrmFzfA33/77l3U9UD3FNfkTlUTCun60mu3UjA/+tx+bvfGDZE=
=sG62
-----END PGP SIGNATURE-----

--nE/5a/j5SCML90Nq--
