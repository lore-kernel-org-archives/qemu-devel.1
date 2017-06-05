Received: from eggs.gnu.org ([2001:4830:134:3::10]:52407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI1pi-0001Bi-K0
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 19:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI1pg-00039F-Ad
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 19:54:50 -0400
Date: Tue, 6 Jun 2017 09:37:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170605233715.GE13397@umbus.fritz.box>
References: <20170602072952.25454-1-david@gibson.dropbear.id.au>
	<20170602072952.25454-2-david@gibson.dropbear.id.au>
	<20170605033112.GZ13397@umbus.fritz.box>
	<149668032708.2695.15159219784832245925@loki>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qicme7IxPpkH/pPU"
Content-Disposition: inline
In-Reply-To: <149668032708.2695.15159219784832245925@loki>
Subject: Re: [Qemu-devel] [PATCHv2 1/5] spapr: Introduce DRC subclasses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, sursingh@redhat.com, groug@kaod.org


--qicme7IxPpkH/pPU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 05, 2017 at 11:32:07AM -0500, Michael Roth wrote:
> Quoting David Gibson (2017-06-04 22:31:12)
> > Currently we only have a single QOM type for all DRCs, but lots of
> > places where we switch behaviour based on the DRC's PAPR defined type.
> > This is a poor use of our existing type system.
> >=20
> > So, instead create QOM subclasses for each PAPR defined DRC type.  We
> > also introduce intermediate subclasses for physical and logical DRCs,
> > a division which will be useful later on.
> >=20
> > Instead of being stored in the DRC object itself, the PAPR type is now
> > stored in the class structure.  There are still many places where we
> > switch directly on the PAPR type value, but this at least provides the
> > basis to start to remove those.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>=20
> > ---
> >  hw/ppc/spapr.c             |   5 +-
> >  hw/ppc/spapr_drc.c         | 123 +++++++++++++++++++++++++++++++++----=
--------
> >  hw/ppc/spapr_pci.c         |   3 +-
> >  include/hw/ppc/spapr_drc.h |  47 +++++++++++++++--
> >  4 files changed, 139 insertions(+), 39 deletions(-)
> >=20
> > Mike, here's an updated version of the patch addressing the problems
> > you pointed out.  If I can get an ack, I can merge the series, which
> > would be nice.
>=20
> Series:
>=20
> Acked-by: Michael Roth <mdroth@linux.vnet.ibm.com>

Thanks, I've merged this into ppc-for-2.10.

>=20
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 5d10366..456f9e7 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1911,7 +1911,7 @@ static void spapr_create_lmb_dr_connectors(sPAPRM=
achineState *spapr)
> >          uint64_t addr;
> > =20
> >          addr =3D i * lmb_size + spapr->hotplug_memory.base;
> > -        drc =3D spapr_dr_connector_new(OBJECT(spapr), SPAPR_DR_CONNECT=
OR_TYPE_LMB,
> > +        drc =3D spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_L=
MB,
> >                                       addr/lmb_size);
> >          qemu_register_reset(spapr_drc_reset, drc);
> >      }
> > @@ -2008,8 +2008,7 @@ static void spapr_init_cpus(sPAPRMachineState *sp=
apr)
> > =20
> >          if (mc->has_hotpluggable_cpus) {
> >              sPAPRDRConnector *drc =3D
> > -                spapr_dr_connector_new(OBJECT(spapr),
> > -                                       SPAPR_DR_CONNECTOR_TYPE_CPU,
> > +                spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_C=
PU,
> >                                         (core_id / smp_threads) * smt);
> > =20
> >              qemu_register_reset(spapr_drc_reset, drc);
> > diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> > index a35314e..8575022 100644
> > --- a/hw/ppc/spapr_drc.c
> > +++ b/hw/ppc/spapr_drc.c
> > @@ -70,14 +70,23 @@ static sPAPRDRConnectorTypeShift get_type_shift(sPA=
PRDRConnectorType type)
> >      return shift;
> >  }
> > =20
> > +sPAPRDRConnectorType spapr_drc_type(sPAPRDRConnector *drc)
> > +{
> > +    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> > +
> > +    return 1 << drck->typeshift;
> > +}
> > +
> >  uint32_t spapr_drc_index(sPAPRDRConnector *drc)
> >  {
> > +    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> > +
> >      /* no set format for a drc index: it only needs to be globally
> >       * unique. this is how we encode the DRC type on bare-metal
> >       * however, so might as well do that here
> >       */
> > -    return (get_type_shift(drc->type) << DRC_INDEX_TYPE_SHIFT) |
> > -            (drc->id & DRC_INDEX_ID_MASK);
> > +    return (drck->typeshift << DRC_INDEX_TYPE_SHIFT)
> > +        | (drc->id & DRC_INDEX_ID_MASK);
> >  }
> > =20
> >  static uint32_t set_isolation_state(sPAPRDRConnector *drc,
> > @@ -107,7 +116,7 @@ static uint32_t set_isolation_state(sPAPRDRConnecto=
r *drc,
> >       * If the LMB being removed doesn't belong to a DIMM device that is
> >       * actually being unplugged, fail the isolation request here.
> >       */
> > -    if (drc->type =3D=3D SPAPR_DR_CONNECTOR_TYPE_LMB) {
> > +    if (spapr_drc_type(drc) =3D=3D SPAPR_DR_CONNECTOR_TYPE_LMB) {
> >          if ((state =3D=3D SPAPR_DR_ISOLATION_STATE_ISOLATED) &&
> >               !drc->awaiting_release) {
> >              return RTAS_OUT_HW_ERROR;
> > @@ -177,7 +186,7 @@ static uint32_t set_allocation_state(sPAPRDRConnect=
or *drc,
> >          }
> >      }
> > =20
> > -    if (drc->type !=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
> > +    if (spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
> >          drc->allocation_state =3D state;
> >          if (drc->awaiting_release &&
> >              drc->allocation_state =3D=3D SPAPR_DR_ALLOCATION_STATE_UNU=
SABLE) {
> > @@ -191,11 +200,6 @@ static uint32_t set_allocation_state(sPAPRDRConnec=
tor *drc,
> >      return RTAS_OUT_SUCCESS;
> >  }
> > =20
> > -sPAPRDRConnectorType spapr_drc_type(sPAPRDRConnector *drc)
> > -{
> > -    return drc->type;
> > -}
> > -
> >  static const char *get_name(sPAPRDRConnector *drc)
> >  {
> >      return drc->name;
> > @@ -217,7 +221,7 @@ static void set_signalled(sPAPRDRConnector *drc)
> >  static uint32_t entity_sense(sPAPRDRConnector *drc, sPAPRDREntitySense=
 *state)
> >  {
> >      if (drc->dev) {
> > -        if (drc->type !=3D SPAPR_DR_CONNECTOR_TYPE_PCI &&
> > +        if (spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PCI &&
> >              drc->allocation_state =3D=3D SPAPR_DR_ALLOCATION_STATE_UNU=
SABLE) {
> >              /* for logical DR, we return a state of UNUSABLE
> >               * iff the allocation state UNUSABLE.
> > @@ -235,7 +239,7 @@ static uint32_t entity_sense(sPAPRDRConnector *drc,=
 sPAPRDREntitySense *state)
> >              *state =3D SPAPR_DR_ENTITY_SENSE_PRESENT;
> >          }
> >      } else {
> > -        if (drc->type =3D=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
> > +        if (spapr_drc_type(drc) =3D=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
> >              /* PCI devices, and only PCI devices, use EMPTY
> >               * in cases where we'd otherwise use UNUSABLE
> >               */
> > @@ -368,7 +372,7 @@ static void attach(sPAPRDRConnector *drc, DeviceSta=
te *d, void *fdt,
> >          error_setg(errp, "an attached device is still awaiting release=
");
> >          return;
> >      }
> > -    if (drc->type =3D=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
> > +    if (spapr_drc_type(drc) =3D=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
> >          g_assert(drc->allocation_state =3D=3D SPAPR_DR_ALLOCATION_STAT=
E_USABLE);
> >      }
> >      g_assert(fdt || coldplug);
> > @@ -380,7 +384,7 @@ static void attach(sPAPRDRConnector *drc, DeviceSta=
te *d, void *fdt,
> >       * may be accessing the device, we can easily crash the guest, so =
we
> >       * we defer completion of removal in such cases to the reset() hoo=
k.
> >       */
> > -    if (drc->type =3D=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
> > +    if (spapr_drc_type(drc) =3D=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
> >          drc->isolation_state =3D SPAPR_DR_ISOLATION_STATE_UNISOLATED;
> >      }
> >      drc->indicator_state =3D SPAPR_DR_INDICATOR_STATE_ACTIVE;
> > @@ -398,10 +402,10 @@ static void attach(sPAPRDRConnector *drc, DeviceS=
tate *d, void *fdt,
> >       * 'physical' DR resources such as PCI where each device/resource =
is
> >       * signalled individually.
> >       */
> > -    drc->signalled =3D (drc->type !=3D SPAPR_DR_CONNECTOR_TYPE_PCI)
> > +    drc->signalled =3D (spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TY=
PE_PCI)
> >                       ? true : coldplug;
> > =20
> > -    if (drc->type !=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
> > +    if (spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
> >          drc->awaiting_allocation =3D true;
> >      }
> > =20
> > @@ -441,7 +445,7 @@ static void detach(sPAPRDRConnector *drc, DeviceSta=
te *d, Error **errp)
> >          return;
> >      }
> > =20
> > -    if (drc->type !=3D SPAPR_DR_CONNECTOR_TYPE_PCI &&
> > +    if (spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PCI &&
> >          drc->allocation_state !=3D SPAPR_DR_ALLOCATION_STATE_UNUSABLE)=
 {
> >          trace_spapr_drc_awaiting_unusable(spapr_drc_index(drc));
> >          drc->awaiting_release =3D true;
> > @@ -458,8 +462,8 @@ static void detach(sPAPRDRConnector *drc, DeviceSta=
te *d, Error **errp)
> > =20
> >      drc->indicator_state =3D SPAPR_DR_INDICATOR_STATE_INACTIVE;
> > =20
> > -    /* Calling release callbacks based on drc->type. */
> > -    switch (drc->type) {
> > +    /* Calling release callbacks based on spapr_drc_type(drc). */
> > +    switch (spapr_drc_type(drc)) {
> >      case SPAPR_DR_CONNECTOR_TYPE_CPU:
> >          spapr_core_release(drc->dev);
> >          break;
> > @@ -515,7 +519,7 @@ static void reset(DeviceState *d)
> >          }
> > =20
> >          /* non-PCI devices may be awaiting a transition to UNUSABLE */
> > -        if (drc->type !=3D SPAPR_DR_CONNECTOR_TYPE_PCI &&
> > +        if (spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PCI &&
> >              drc->awaiting_release) {
> >              drck->set_allocation_state(drc, SPAPR_DR_ALLOCATION_STATE_=
UNUSABLE);
> >          }
> > @@ -544,7 +548,7 @@ static bool spapr_drc_needed(void *opaque)
> >       * If there is dev plugged in, we need to migrate the DRC state wh=
en
> >       * it is different from cold-plugged state
> >       */
> > -    switch (drc->type) {
> > +    switch (spapr_drc_type(drc)) {
> >      case SPAPR_DR_CONNECTOR_TYPE_PCI:
> >          rc =3D !((drc->isolation_state =3D=3D SPAPR_DR_ISOLATION_STATE=
_UNISOLATED) &&
> >                 (drc->allocation_state =3D=3D SPAPR_DR_ALLOCATION_STATE=
_USABLE) &&
> > @@ -630,17 +634,12 @@ static void unrealize(DeviceState *d, Error **err=
p)
> >      }
> >  }
> > =20
> > -sPAPRDRConnector *spapr_dr_connector_new(Object *owner,
> > -                                         sPAPRDRConnectorType type,
> > +sPAPRDRConnector *spapr_dr_connector_new(Object *owner, const char *ty=
pe,
> >                                           uint32_t id)
> >  {
> > -    sPAPRDRConnector *drc =3D
> > -        SPAPR_DR_CONNECTOR(object_new(TYPE_SPAPR_DR_CONNECTOR));
> > +    sPAPRDRConnector *drc =3D SPAPR_DR_CONNECTOR(object_new(type));
> >      char *prop_name;
> > =20
> > -    g_assert(type);
> > -
> > -    drc->type =3D type;
> >      drc->id =3D id;
> >      drc->owner =3D owner;
> >      prop_name =3D g_strdup_printf("dr-connector[%"PRIu32"]",
> > @@ -670,7 +669,7 @@ sPAPRDRConnector *spapr_dr_connector_new(Object *ow=
ner,
> >       * DRC names as documented by PAPR+ v2.7, 13.5.2.4
> >       * location codes as documented by PAPR+ v2.7, 12.3.1.5
> >       */
> > -    switch (drc->type) {
> > +    switch (spapr_drc_type(drc)) {
> >      case SPAPR_DR_CONNECTOR_TYPE_CPU:
> >          drc->name =3D g_strdup_printf("CPU %d", id);
> >          break;
> > @@ -689,7 +688,7 @@ sPAPRDRConnector *spapr_dr_connector_new(Object *ow=
ner,
> >      }
> > =20
> >      /* PCI slot always start in a USABLE state, and stay there */
> > -    if (drc->type =3D=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
> > +    if (spapr_drc_type(drc) =3D=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
> >          drc->allocation_state =3D SPAPR_DR_ALLOCATION_STATE_USABLE;
> >      }
> > =20
> > @@ -741,6 +740,27 @@ static void spapr_dr_connector_class_init(ObjectCl=
ass *k, void *data)
> >      dk->user_creatable =3D false;
> >  }
> > =20
> > +static void spapr_drc_cpu_class_init(ObjectClass *k, void *data)
> > +{
> > +    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_CLASS(k);
> > +
> > +    drck->typeshift =3D SPAPR_DR_CONNECTOR_TYPE_SHIFT_CPU;
> > +}
> > +
> > +static void spapr_drc_pci_class_init(ObjectClass *k, void *data)
> > +{
> > +    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_CLASS(k);
> > +
> > +    drck->typeshift =3D SPAPR_DR_CONNECTOR_TYPE_SHIFT_PCI;
> > +}
> > +
> > +static void spapr_drc_lmb_class_init(ObjectClass *k, void *data)
> > +{
> > +    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_CLASS(k);
> > +
> > +    drck->typeshift =3D SPAPR_DR_CONNECTOR_TYPE_SHIFT_LMB;
> > +}
> > +
> >  static const TypeInfo spapr_dr_connector_info =3D {
> >      .name          =3D TYPE_SPAPR_DR_CONNECTOR,
> >      .parent        =3D TYPE_DEVICE,
> > @@ -748,6 +768,42 @@ static const TypeInfo spapr_dr_connector_info =3D {
> >      .instance_init =3D spapr_dr_connector_instance_init,
> >      .class_size    =3D sizeof(sPAPRDRConnectorClass),
> >      .class_init    =3D spapr_dr_connector_class_init,
> > +    .abstract      =3D true,
> > +};
> > +
> > +static const TypeInfo spapr_drc_physical_info =3D {
> > +    .name          =3D TYPE_SPAPR_DRC_PHYSICAL,
> > +    .parent        =3D TYPE_SPAPR_DR_CONNECTOR,
> > +    .instance_size =3D sizeof(sPAPRDRConnector),
> > +    .abstract      =3D true,
> > +};
> > +
> > +static const TypeInfo spapr_drc_logical_info =3D {
> > +    .name          =3D TYPE_SPAPR_DRC_LOGICAL,
> > +    .parent        =3D TYPE_SPAPR_DR_CONNECTOR,
> > +    .instance_size =3D sizeof(sPAPRDRConnector),
> > +    .abstract      =3D true,
> > +};
> > +
> > +static const TypeInfo spapr_drc_cpu_info =3D {
> > +    .name          =3D TYPE_SPAPR_DRC_CPU,
> > +    .parent        =3D TYPE_SPAPR_DRC_LOGICAL,
> > +    .instance_size =3D sizeof(sPAPRDRConnector),
> > +    .class_init    =3D spapr_drc_cpu_class_init,
> > +};
> > +
> > +static const TypeInfo spapr_drc_pci_info =3D {
> > +    .name          =3D TYPE_SPAPR_DRC_PCI,
> > +    .parent        =3D TYPE_SPAPR_DRC_PHYSICAL,
> > +    .instance_size =3D sizeof(sPAPRDRConnector),
> > +    .class_init    =3D spapr_drc_pci_class_init,
> > +};
> > +
> > +static const TypeInfo spapr_drc_lmb_info =3D {
> > +    .name          =3D TYPE_SPAPR_DRC_LMB,
> > +    .parent        =3D TYPE_SPAPR_DRC_LOGICAL,
> > +    .instance_size =3D sizeof(sPAPRDRConnector),
> > +    .class_init    =3D spapr_drc_lmb_class_init,
> >  };
> > =20
> >  /* helper functions for external users */
> > @@ -858,7 +914,7 @@ int spapr_drc_populate_dt(void *fdt, int fdt_offset=
, Object *owner,
> >              continue;
> >          }
> > =20
> > -        if ((drc->type & drc_type_mask) =3D=3D 0) {
> > +        if ((spapr_drc_type(drc) & drc_type_mask) =3D=3D 0) {
> >              continue;
> >          }
> > =20
> > @@ -878,7 +934,7 @@ int spapr_drc_populate_dt(void *fdt, int fdt_offset=
, Object *owner,
> > =20
> >          /* ibm,drc-types */
> >          drc_types =3D g_string_append(drc_types,
> > -                                    spapr_drc_get_type_str(drc->type));
> > +                                    spapr_drc_get_type_str(spapr_drc_t=
ype(drc)));
> >          drc_types =3D g_string_insert_len(drc_types, -1, "\0", 1);
> >      }
> > =20
> > @@ -1210,6 +1266,11 @@ out:
> >  static void spapr_drc_register_types(void)
> >  {
> >      type_register_static(&spapr_dr_connector_info);
> > +    type_register_static(&spapr_drc_physical_info);
> > +    type_register_static(&spapr_drc_logical_info);
> > +    type_register_static(&spapr_drc_cpu_info);
> > +    type_register_static(&spapr_drc_pci_info);
> > +    type_register_static(&spapr_drc_lmb_info);
> > =20
> >      spapr_rtas_register(RTAS_SET_INDICATOR, "set-indicator",
> >                          rtas_set_indicator);
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index 7a208a7..50d673b 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -1761,8 +1761,7 @@ static void spapr_phb_realize(DeviceState *dev, E=
rror **errp)
> >      /* allocate connectors for child PCI devices */
> >      if (sphb->dr_enabled) {
> >          for (i =3D 0; i < PCI_SLOT_MAX * 8; i++) {
> > -            spapr_dr_connector_new(OBJECT(phb),
> > -                                   SPAPR_DR_CONNECTOR_TYPE_PCI,
> > +            spapr_dr_connector_new(OBJECT(phb), TYPE_SPAPR_DRC_PCI,
> >                                     (sphb->index << 16) | i);
> >          }
> >      }
> > diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> > index 10e7c24..969c16d 100644
> > --- a/include/hw/ppc/spapr_drc.h
> > +++ b/include/hw/ppc/spapr_drc.h
> > @@ -26,6 +26,48 @@
> >  #define SPAPR_DR_CONNECTOR(obj) OBJECT_CHECK(sPAPRDRConnector, (obj), \
> >                                               TYPE_SPAPR_DR_CONNECTOR)
> > =20
> > +#define TYPE_SPAPR_DRC_PHYSICAL "spapr-drc-physical"
> > +#define SPAPR_DRC_PHYSICAL_GET_CLASS(obj) \
> > +        OBJECT_GET_CLASS(sPAPRDRConnectorClass, obj, TYPE_SPAPR_DRC_PH=
YSICAL)
> > +#define SPAPR_DRC_PHYSICAL_CLASS(klass) \
> > +        OBJECT_CLASS_CHECK(sPAPRDRConnectorClass, klass, \
> > +                           TYPE_SPAPR_DRC_PHYSICAL)
> > +#define SPAPR_DRC_PHYSICAL(obj) OBJECT_CHECK(sPAPRDRConnector, (obj), \
> > +                                             TYPE_SPAPR_DRC_PHYSICAL)
> > +
> > +#define TYPE_SPAPR_DRC_LOGICAL "spapr-drc-logical"
> > +#define SPAPR_DRC_LOGICAL_GET_CLASS(obj) \
> > +        OBJECT_GET_CLASS(sPAPRDRConnectorClass, obj, TYPE_SPAPR_DRC_LO=
GICAL)
> > +#define SPAPR_DRC_LOGICAL_CLASS(klass) \
> > +        OBJECT_CLASS_CHECK(sPAPRDRConnectorClass, klass, \
> > +                           TYPE_SPAPR_DRC_LOGICAL)
> > +#define SPAPR_DRC_LOGICAL(obj) OBJECT_CHECK(sPAPRDRConnector, (obj), \
> > +                                             TYPE_SPAPR_DRC_LOGICAL)
> > +
> > +#define TYPE_SPAPR_DRC_CPU "spapr-drc-cpu"
> > +#define SPAPR_DRC_CPU_GET_CLASS(obj) \
> > +        OBJECT_GET_CLASS(sPAPRDRConnectorClass, obj, TYPE_SPAPR_DRC_CP=
U)
> > +#define SPAPR_DRC_CPU_CLASS(klass) \
> > +        OBJECT_CLASS_CHECK(sPAPRDRConnectorClass, klass, TYPE_SPAPR_DR=
C_CPU)
> > +#define SPAPR_DRC_CPU(obj) OBJECT_CHECK(sPAPRDRConnector, (obj), \
> > +                                        TYPE_SPAPR_DRC_CPU)
> > +
> > +#define TYPE_SPAPR_DRC_PCI "spapr-drc-pci"
> > +#define SPAPR_DRC_PCI_GET_CLASS(obj) \
> > +        OBJECT_GET_CLASS(sPAPRDRConnectorClass, obj, TYPE_SPAPR_DRC_PC=
I)
> > +#define SPAPR_DRC_PCI_CLASS(klass) \
> > +        OBJECT_CLASS_CHECK(sPAPRDRConnectorClass, klass, TYPE_SPAPR_DR=
C_PCI)
> > +#define SPAPR_DRC_PCI(obj) OBJECT_CHECK(sPAPRDRConnector, (obj), \
> > +                                        TYPE_SPAPR_DRC_PCI)
> > +
> > +#define TYPE_SPAPR_DRC_LMB "spapr-drc-lmb"
> > +#define SPAPR_DRC_LMB_GET_CLASS(obj) \
> > +        OBJECT_GET_CLASS(sPAPRDRConnectorClass, obj, TYPE_SPAPR_DRC_LM=
B)
> > +#define SPAPR_DRC_LMB_CLASS(klass) \
> > +        OBJECT_CLASS_CHECK(sPAPRDRConnectorClass, klass, TYPE_SPAPR_DR=
C_LMB)
> > +#define SPAPR_DRC_LMB(obj) OBJECT_CHECK(sPAPRDRConnector, (obj), \
> > +                                        TYPE_SPAPR_DRC_LMB)
> > +
> >  /*
> >   * Various hotplug types managed by sPAPRDRConnector
> >   *
> > @@ -134,7 +176,6 @@ typedef struct sPAPRDRConnector {
> >      /*< private >*/
> >      DeviceState parent;
> > =20
> > -    sPAPRDRConnectorType type;
> >      uint32_t id;
> >      Object *owner;
> >      const char *name;
> > @@ -163,6 +204,7 @@ typedef struct sPAPRDRConnectorClass {
> >      DeviceClass parent;
> > =20
> >      /*< public >*/
> > +    sPAPRDRConnectorTypeShift typeshift;
> > =20
> >      /* accessors for guest-visible (generally via RTAS) DR state */
> >      uint32_t (*set_isolation_state)(sPAPRDRConnector *drc,
> > @@ -186,8 +228,7 @@ typedef struct sPAPRDRConnectorClass {
> >  uint32_t spapr_drc_index(sPAPRDRConnector *drc);
> >  sPAPRDRConnectorType spapr_drc_type(sPAPRDRConnector *drc);
> > =20
> > -sPAPRDRConnector *spapr_dr_connector_new(Object *owner,
> > -                                         sPAPRDRConnectorType type,
> > +sPAPRDRConnector *spapr_dr_connector_new(Object *owner, const char *ty=
pe,
> >                                           uint32_t id);
> >  sPAPRDRConnector *spapr_dr_connector_by_index(uint32_t index);
> >  sPAPRDRConnector *spapr_dr_connector_by_id(sPAPRDRConnectorType type,
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qicme7IxPpkH/pPU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZNesoAAoJEGw4ysog2bOSizsQALYLJOwJiwUe6GHaaJfcKbLE
ewM7J0io6P4iIXRN+wKfbGarxuM1KBcBdzD51cMM4eGJ/tiBnX86h1VW2qJQ3kTJ
h3KBMeVmw7IYqvtFJJ3uNOJtiFDzMxfJaOAzIF97yIP16D6yS0fcp0agcOlbdyL3
9IBaLwwEW+cC8hE9aA+0bnZeTbXTPTzk5HK2eBE9rJ1r+7wlCh99Yi5aKNC/ZjMm
9mxaV137L5SbYuvMDeN+Q86hSlg9Hjuu4hNppnKZkYBOB7lPtU4GsOsQCxRpocRr
cC9CvI2c9vcamu0GICe45eTtIgE/Gjzz2auKfbwJSthIwETZQT87m5k0YOtz41/Q
3u8CRtR4RYBLhDd69sAZtzBdoIIky/8lO92FHKV/lBsFIJ1Xx8Fnh8A81VKsbww8
VasUYUM5XmWbSyioImkNxFQHaTfErOPlFQXvppGgE29FOY4VJxDP3NzESjkhOqpO
+LkdjVhjVrvqD61QiabaV1cpDc60LXmJeyYpRLL7b61HtzCGJwduYavQa4fMtbcd
PA3ok1CswVg28dvIM/dUrHCyuuMV5U4lw2w3RgjxaVnSsOa+lj0FZkhpHdIDzf0N
ZSkUYke7dh77IPX9E7hYUACfaDPEcXl9fS/F/iWnIg90Jl62N208g3mhobnKoqkw
b+TbkZbkSMYQ9d6WMU3M
=M9X7
-----END PGP SIGNATURE-----

--qicme7IxPpkH/pPU--
