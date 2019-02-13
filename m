Received: from eggs.gnu.org ([209.51.188.92]:48370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gtuNx-0001wd-LZ
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:15:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gtuNw-0004h9-Ax
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:15:33 -0500
Received: from 7.mo1.mail-out.ovh.net ([87.98.158.110]:38236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gtuNw-0004g9-4l
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:15:32 -0500
Received: from player690.ha.ovh.net (unknown [10.109.146.137])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id DA8BE15BA6C
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 14:15:29 +0100 (CET)
Date: Wed, 13 Feb 2019 14:15:12 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190213141512.43fc21df@bahia.lan>
In-Reply-To: <20190213040522.GG1884@umbus.fritz.box>
References: <154999583316.690774.15072605479770041782.stgit@bahia.lan>
	<154999591892.690774.10674853078354564704.stgit@bahia.lan>
	<20190213040522.GG1884@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/rZ=lVyOpb4XQ8K8DDIr=vUO";
	protocol="application/pgp-signature"
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

--Sig_/rZ=lVyOpb4XQ8K8DDIr=vUO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Feb 2019 15:05:24 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Feb 12, 2019 at 07:25:19PM +0100, Greg Kurz wrote:
> > The current logic is to provide the FDT fragment when attaching a device
> > to a DRC. This works perfectly fine for our current hotplug support, but
> > soon we will add support for PHB hotplug which has some constraints, th=
at
> > CPU, PCI and LMB devices don't seem to have.
> >=20
> > The first constraint is that the "ibm,dma-window" property of the PHB
> > node requires the IOMMU to be configured, ie, spapr_tce_table_enable()
> > has been called, which happens during PHB reset. It is okay in the case
> > of hotplug since the device is reset before the hotplug handler is
> > called. On the contrary with coldplug, the hotplug handler is called
> > first and device is only reset during the initial system reset. Trying
> > to create the FDT fragment on the hotplug path in this case, would
> > result in somthing like this:
> >=20
> > ibm,dma-window =3D < 0x80000000 0x00 0x00 0x00 0x00 >;
> >=20
> > This will cause linux in the guest to panic, by simply removing and
> > re-adding the PHB using the drmgr command:
> >=20
> > 	page =3D alloc_pages_node(nid, GFP_KERNEL, get_order(sz));
> > 	if (!page)
> > 		panic("iommu_init_table: Can't allocate %ld bytes\n", sz);
> >=20
> > The second and maybe more problematic constraint is that the
> > "interrupt-map" property needs to reference the interrupt controller
> > node using the very same phandle that SLOF has already exposed to the
> > guest. QEMU requires SLOF to call the private KVMPPC_H_UPDATE_DT hcall
> > at some point to know about this phandle. With the latest QEMU and SLOF,
> > this happens when SLOF gets quiesced. This means that if the PHB gets
> > hotplugged after CAS but before SLOF quiesce, then we're sure that the
> > phandle is not known when the hotplug handler is called.
> >=20
> > The FDT is only needed when the guest first invokes RTAS to configure
> > the connector actually, long after SLOF quiesce. Let's postpone the
> > creation of FDT fragments for PHBs to rtas_ibm_configure_connector().
> >=20
> > Since we only need this for PHBs, introduce a new method in the base
> > DRC class for that. It will implemented for "spapr-drc-phb" DRCs in
> > a subsequent patch.
> >=20
> > Allow spapr_drc_attach() to be passed a NULL fdt argument if the method
> > is available.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
> The basic solution looks fine.  However I don't much like the fact
> that this leaves us with two ways to handle the fdt fragment - either
> at connect time or at configure connector time via a callback.  qemu
> already has way to many places where there are confusingly multiple
> ways to do things.
>=20
> I know it's a detour, but I'd really prefer to convert the existing
> DRC handling to this new callback scheme, rather than have two
> different approaches.
>=20

Ok. I'll introduce the new callback scheme and convert the existing code
in a separate series.

> > ---
> >  hw/ppc/spapr_drc.c         |   34 +++++++++++++++++++++++++++++-----
> >  include/hw/ppc/spapr_drc.h |    6 ++++++
> >  2 files changed, 35 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> > index 189ee681062a..c5a281915665 100644
> > --- a/hw/ppc/spapr_drc.c
> > +++ b/hw/ppc/spapr_drc.c
> > @@ -22,6 +22,7 @@
> >  #include "qemu/error-report.h"
> >  #include "hw/ppc/spapr.h" /* for RTAS return codes */
> >  #include "hw/pci-host/spapr.h" /* spapr_phb_remove_pci_device_cb callb=
ack */
> > +#include "sysemu/device_tree.h"
> >  #include "trace.h"
> > =20
> >  #define DRC_CONTAINER_PATH "/dr-connector"
> > @@ -376,6 +377,8 @@ static void prop_get_fdt(Object *obj, Visitor *v, c=
onst char *name,
> >  void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
> >                        int fdt_start_offset, Error **errp)
> >  {
> > +    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> > +
> >      trace_spapr_drc_attach(spapr_drc_index(drc));
> > =20
> >      if (drc->dev) {
> > @@ -384,11 +387,14 @@ void spapr_drc_attach(sPAPRDRConnector *drc, Devi=
ceState *d, void *fdt,
> >      }
> >      g_assert((drc->state =3D=3D SPAPR_DRC_STATE_LOGICAL_UNUSABLE)
> >               || (drc->state =3D=3D SPAPR_DRC_STATE_PHYSICAL_POWERON));
> > -    g_assert(fdt);
> > +    g_assert(fdt || drck->populate_dt);
> > =20
> >      drc->dev =3D d;
> > -    drc->fdt =3D fdt;
> > -    drc->fdt_start_offset =3D fdt_start_offset;
> > +
> > +    if (fdt) {
> > +        drc->fdt =3D fdt;
> > +        drc->fdt_start_offset =3D fdt_start_offset;
> > +    }
> > =20
> >      object_property_add_link(OBJECT(drc), "device",
> >                               object_get_typename(OBJECT(drc->dev)),
> > @@ -1118,10 +1124,28 @@ static void rtas_ibm_configure_connector(PowerP=
CCPU *cpu,
> >          goto out;
> >      }
> > =20
> > -    g_assert(drc->fdt);
> > -
> >      drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> > =20
> > +    g_assert(drc->fdt || drck->populate_dt);
> > +
> > +    if (!drc->fdt) {
> > +        Error *local_err =3D NULL;
> > +        void *fdt;
> > +        int fdt_size;
> > +
> > +        fdt =3D create_device_tree(&fdt_size);
> > +
> > +        if (drck->populate_dt(drc->dev, spapr, fdt, &drc->fdt_start_of=
fset,
> > +                               &local_err)) {
> > +            g_free(fdt);
> > +            error_free(local_err);
> > +            rc =3D SPAPR_DR_CC_RESPONSE_ERROR;
> > +            goto out;
> > +        }
> > +
> > +        drc->fdt =3D fdt;
> > +    }
> > +
> >      do {
> >          uint32_t tag;
> >          const char *name;
> > diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> > index 56bba36ad4da..e947d6987bf2 100644
> > --- a/include/hw/ppc/spapr_drc.h
> > +++ b/include/hw/ppc/spapr_drc.h
> > @@ -18,6 +18,7 @@
> >  #include "qom/object.h"
> >  #include "sysemu/sysemu.h"
> >  #include "hw/qdev.h"
> > +#include "qapi/error.h"
> > =20
> >  #define TYPE_SPAPR_DR_CONNECTOR "spapr-dr-connector"
> >  #define SPAPR_DR_CONNECTOR_GET_CLASS(obj) \
> > @@ -221,6 +222,8 @@ typedef struct sPAPRDRConnector {
> >      int fdt_start_offset;
> >  } sPAPRDRConnector;
> > =20
> > +struct sPAPRMachineState;
> > +
> >  typedef struct sPAPRDRConnectorClass {
> >      /*< private >*/
> >      DeviceClass parent;
> > @@ -236,6 +239,9 @@ typedef struct sPAPRDRConnectorClass {
> >      uint32_t (*isolate)(sPAPRDRConnector *drc);
> >      uint32_t (*unisolate)(sPAPRDRConnector *drc);
> >      void (*release)(DeviceState *dev);
> > +
> > +    int (*populate_dt)(DeviceState *dev, struct sPAPRMachineState *spa=
pr,
> > +                       void *fdt, int *fdt_start_offset, Error **errp);
> >  } sPAPRDRConnectorClass;
> > =20
> >  typedef struct sPAPRDRCPhysical {
> >  =20
>=20


--Sig_/rZ=lVyOpb4XQ8K8DDIr=vUO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlxkGGAACgkQcdTV5YIv
c9Z4zg/+LvNwwaaPoOCbWnjfJQB6yGvwjaa0KH70RgClnkxWfq0kQWUHmO7ItKxm
RwwYDmZPYAwfNKpYkCQj5WHzcwQAkxUeYGdY8VPOvZxh3ynsQIJCcblfxzQ50oc1
OSyzQLCyYlNHp94cuyzsXe0qtSEJ3D2U0yEsLyra1WhT/xYr4zDpa35v4aNrhaY1
5BnRQS2YUAXW33IRWHoV/96HNHWWMNY2YMBOZD2i8vKlLpphRrLKeBx+onpXo/zf
HNCmTVGjBNa6RYPmR+LcN7W02i16BoBNs8PxEEaGOuuwpmRnd/rw+8aoy0TPB4qW
pOce319aR9ewAvTfVZP4XM0g2nFYNhWEEBlNS4ZqUdVCi6w4NehXBU+Ze9UbLq5k
g4QrO+YSLziPJy9Kv/9reCLA1MMJkTtD5zIhCFovMgt+Ox5KEr8loWfkw1Dimits
v8v8vwa8Ukkcs0bWWlepn9CwY7k3ypV92UIymtjA84KV5sV16DLIWKMoEkWf4EJW
FKLCuvTuM1MqDFY++oBtVOITKdwUvE2v3WkVshDAK88MY7R7yt4SIX2d1So8qbP+
T5DnWE1m4sqJyxEVVbL+MwuDuPyG6yr4UebXhCRowauo8Vq+C+3+9KyuQoVembv9
FeK7XLGomyO60BShbTUD5iZBKn55yGs/DDYtcGNnx+LMRQkjlI8=
=c9mV
-----END PGP SIGNATURE-----

--Sig_/rZ=lVyOpb4XQ8K8DDIr=vUO--
