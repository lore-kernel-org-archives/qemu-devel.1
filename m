Received: from eggs.gnu.org ([2001:4830:134:3::10]:41410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dIkHZ-0004Id-Eb
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 19:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dIkHV-0002zb-8X
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 19:22:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37556
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dIkHV-0002z2-2T
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 19:22:29 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v57NJCFR047228
	for <qemu-devel@nongnu.org>; Wed, 7 Jun 2017 19:22:27 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2axmtt7n71-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 19:22:27 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 7 Jun 2017 17:22:26 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170607012851.GH13397@umbus.fritz.box>
References: <20170606083221.9299-1-david@gibson.dropbear.id.au>
	<20170606083221.9299-7-david@gibson.dropbear.id.au>
	<149678307300.2548.13270966751879064274@loki>
	<20170607012851.GH13397@umbus.fritz.box>
Date: Wed, 07 Jun 2017 18:11:03 -0500
Message-Id: <149687706332.5725.5499034992685312407@loki>
Subject: Re: [Qemu-devel] [PATCH 6/7] spapr: Clean up handling of
 DR-indicator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, sursingh@redhat.com, groug@kaod.org

Quoting David Gibson (2017-06-06 20:28:51)
> On Tue, Jun 06, 2017 at 04:04:33PM -0500, Michael Roth wrote:
> > Quoting David Gibson (2017-06-06 03:32:20)
> > > There are 3 types of "indicator" associated with hotplug in the PAPR =
spec
> > > the "allocation state", "isolation state" and "DR-indicator".  The fi=
rst
> > > two are intimately tied to the various state transitions associated w=
ith
> > > hotplug.  The DR-indicator, however, is different and simpler.
> > > =

> > > It's basically just a guest controlled variable which can be used by =
the
> > > guest to flag state or problems associated with a device.  The idea i=
s that
> > > the hypervisor can use it to present information back on management
> > > consoles (on some machines with PowerVM it may even control physical =
LEDs
> > > on the machine case associated with the relevant device).
> > > =

> > > For that reason, there's only ever likely to be a single update
> > > implementation so the set_indicator_state method isn't useful.  Repla=
ce it
> > > with a direct function call.
> > > =

> > > While we're there, make some small associated cleanups:
> > >   * PAPR doesn't use the term "indicator state", just "DR-indicator" =
and
> > > the allocation state and isolation state are also considered "indicat=
ors".
> > > Rename things to be less confusing
> > >   * Fold set_indicator_state() and rtas_set_indicator_state() into a =
single
> > > rtas_set_dr_indicator() function.
> > > =

> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > ---
> > >  hw/ppc/spapr_drc.c         | 25 ++++++++-----------------
> > >  hw/ppc/trace-events        |  2 +-
> > >  include/hw/ppc/spapr_drc.h | 16 ++++++++--------
> > >  3 files changed, 17 insertions(+), 26 deletions(-)
> > > =

> > > diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> > > index 6c2fa93..a4ece2e 100644
> > > --- a/hw/ppc/spapr_drc.c
> > > +++ b/hw/ppc/spapr_drc.c
> > > @@ -116,14 +116,6 @@ static uint32_t set_isolation_state(sPAPRDRConne=
ctor *drc,
> > >      return RTAS_OUT_SUCCESS;
> > >  }
> > > =

> > > -static uint32_t set_indicator_state(sPAPRDRConnector *drc,
> > > -                                    sPAPRDRIndicatorState state)
> > > -{
> > > -    trace_spapr_drc_set_indicator_state(spapr_drc_index(drc), state);
> > > -    drc->indicator_state =3D state;
> > > -    return RTAS_OUT_SUCCESS;
> > > -}
> > > -
> > >  static uint32_t set_allocation_state(sPAPRDRConnector *drc,
> > >                                       sPAPRDRAllocationState state)
> > >  {
> > > @@ -313,7 +305,7 @@ static void attach(sPAPRDRConnector *drc, DeviceS=
tate *d, void *fdt,
> > >      if (spapr_drc_type(drc) =3D=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
> > >          drc->isolation_state =3D SPAPR_DR_ISOLATION_STATE_UNISOLATED;
> > >      }
> > > -    drc->indicator_state =3D SPAPR_DR_INDICATOR_STATE_ACTIVE;
> > > +    drc->dr_indicator =3D SPAPR_DR_INDICATOR_ACTIVE;
> > > =

> > >      drc->dev =3D d;
> > >      drc->fdt =3D fdt;
> > > @@ -386,7 +378,7 @@ static void detach(sPAPRDRConnector *drc, DeviceS=
tate *d, Error **errp)
> > >          }
> > >      }
> > > =

> > > -    drc->indicator_state =3D SPAPR_DR_INDICATOR_STATE_INACTIVE;
> > > +    drc->dr_indicator =3D SPAPR_DR_INDICATOR_INACTIVE;
> > > =

> > >      /* Calling release callbacks based on spapr_drc_type(drc). */
> > >      switch (spapr_drc_type(drc)) {
> > > @@ -499,7 +491,7 @@ static const VMStateDescription vmstate_spapr_drc=
 =3D {
> > >      .fields  =3D (VMStateField []) {
> > >          VMSTATE_UINT32(isolation_state, sPAPRDRConnector),
> > >          VMSTATE_UINT32(allocation_state, sPAPRDRConnector),
> > > -        VMSTATE_UINT32(indicator_state, sPAPRDRConnector),
> > > +        VMSTATE_UINT32(dr_indicator, sPAPRDRConnector),
> > >          VMSTATE_BOOL(configured, sPAPRDRConnector),
> > >          VMSTATE_BOOL(awaiting_release, sPAPRDRConnector),
> > >          VMSTATE_BOOL(awaiting_allocation, sPAPRDRConnector),
> > > @@ -614,7 +606,6 @@ static void spapr_dr_connector_class_init(ObjectC=
lass *k, void *data)
> > >      dk->realize =3D realize;
> > >      dk->unrealize =3D unrealize;
> > >      drck->set_isolation_state =3D set_isolation_state;
> > > -    drck->set_indicator_state =3D set_indicator_state;
> > >      drck->set_allocation_state =3D set_allocation_state;
> > >      drck->attach =3D attach;
> > >      drck->detach =3D detach;
> > > @@ -895,17 +886,17 @@ static uint32_t rtas_set_allocation_state(uint3=
2_t idx, uint32_t state)
> > >      return drck->set_allocation_state(drc, state);
> > >  }
> > > =

> > > -static uint32_t rtas_set_indicator_state(uint32_t idx, uint32_t stat=
e)
> > > +static uint32_t rtas_set_dr_indicator(uint32_t idx, uint32_t state)
> > >  {
> > >      sPAPRDRConnector *drc =3D spapr_drc_by_index(idx);
> > > -    sPAPRDRConnectorClass *drck;
> > > =

> > >      if (!drc) {
> > >          return RTAS_OUT_PARAM_ERROR;
> > >      }
> > > =

> > > -    drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> > > -    return drck->set_indicator_state(drc, state);
> > > +    trace_spapr_drc_set_dr_indicator(idx, state);
> > > +    drc->dr_indicator =3D state;
> > > +    return RTAS_OUT_SUCCESS;
> > >  }
> > > =

> > >  static void rtas_set_indicator(PowerPCCPU *cpu, sPAPRMachineState *s=
papr,
> > > @@ -930,7 +921,7 @@ static void rtas_set_indicator(PowerPCCPU *cpu, s=
PAPRMachineState *spapr,
> > >          ret =3D rtas_set_isolation_state(idx, state);
> > >          break;
> > >      case RTAS_SENSOR_TYPE_DR:
> > > -        ret =3D rtas_set_indicator_state(idx, state);
> > > +        ret =3D rtas_set_dr_indicator(idx, state);
> > >          break;
> > >      case RTAS_SENSOR_TYPE_ALLOCATION_STATE:
> > >          ret =3D rtas_set_allocation_state(idx, state);
> > > diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> > > index 581fa85..3e8e3cf 100644
> > > --- a/hw/ppc/trace-events
> > > +++ b/hw/ppc/trace-events
> > > @@ -39,7 +39,7 @@ spapr_iommu_ddw_reset(uint64_t buid, uint32_t cfgad=
dr) "buid=3D%"PRIx64" addr=3D%"PR
> > >  spapr_drc_set_isolation_state(uint32_t index, int state) "drc: 0x%"P=
RIx32", state: %"PRIx32
> > >  spapr_drc_set_isolation_state_finalizing(uint32_t index) "drc: 0x%"P=
RIx32
> > >  spapr_drc_set_isolation_state_deferring(uint32_t index) "drc: 0x%"PR=
Ix32
> > > -spapr_drc_set_indicator_state(uint32_t index, int state) "drc: 0x%"P=
RIx32", state: 0x%x"
> > > +spapr_drc_set_dr_indicator(uint32_t index, int state) "drc: 0x%"PRIx=
32", state: 0x%x"
> > =

> > Since this only tracks the changes to dr_indicator via RTAS (as was also
> > the case previously), it should probably be changed to an RTAS trace
> > while we're here.
> =

> That doesn't follow for me.  Yes, it's only triggered by RTAS, but
> it's really about a DRC event.  It's when debugging DRC things that
> you're going to care about it.

My concern is more on the trace output side of things. As it stands it
gives a false sense that you're seeing a full accounting of the state
changes when really it's only a particular call-site that's being
traced. Making it spapr_drc_set_dr_indicator_rtas would have been a
better suggestion though.

Then again, the issue is not unique to this particular value, so maybe
a general rework of how we handle tracing would be better left for when
the dust settles a bit instead of trying to patch it up along the way.

> =

> > =

> > In either case:
> > =

> > Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > =

> > >  spapr_drc_set_allocation_state(uint32_t index, int state) "drc: 0x%"=
PRIx32", state: 0x%x"
> > >  spapr_drc_set_allocation_state_finalizing(uint32_t index) "drc: 0x%"=
PRIx32
> > >  spapr_drc_set_configured(uint32_t index) "drc: 0x%"PRIx32
> > > diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> > > index d437e0a..802c708 100644
> > > --- a/include/hw/ppc/spapr_drc.h
> > > +++ b/include/hw/ppc/spapr_drc.h
> > > @@ -125,7 +125,7 @@ typedef enum {
> > >  } sPAPRDRAllocationState;
> > > =

> > >  /*
> > > - * LED/visual indicator state
> > > + * DR-indicator (LED/visual indicator)
> > >   *
> > >   * set via set-indicator RTAS calls
> > >   * as documented by PAPR+ 2.7 13.5.3.4, Table 177,
> > > @@ -137,10 +137,10 @@ typedef enum {
> > >   * action: (currently unused)
> > >   */
> > >  typedef enum {
> > > -    SPAPR_DR_INDICATOR_STATE_INACTIVE   =3D 0,
> > > -    SPAPR_DR_INDICATOR_STATE_ACTIVE     =3D 1,
> > > -    SPAPR_DR_INDICATOR_STATE_IDENTIFY   =3D 2,
> > > -    SPAPR_DR_INDICATOR_STATE_ACTION     =3D 3,
> > > +    SPAPR_DR_INDICATOR_INACTIVE   =3D 0,
> > > +    SPAPR_DR_INDICATOR_ACTIVE     =3D 1,
> > > +    SPAPR_DR_INDICATOR_IDENTIFY   =3D 2,
> > > +    SPAPR_DR_INDICATOR_ACTION     =3D 3,
> > >  } sPAPRDRIndicatorState;
> > > =

> > >  /*
> > > @@ -186,10 +186,12 @@ typedef struct sPAPRDRConnector {
> > >      Object *owner;
> > >      char *name;
> > > =

> > > +    /* DR-indicator */
> > > +    uint32_t dr_indicator;
> > > +
> > >      /* sensor/indicator states */
> > >      uint32_t isolation_state;
> > >      uint32_t allocation_state;
> > > -    uint32_t indicator_state;
> > > =

> > >      /* configure-connector state */
> > >      void *fdt;
> > > @@ -219,8 +221,6 @@ typedef struct sPAPRDRConnectorClass {
> > >      /* accessors for guest-visible (generally via RTAS) DR state */
> > >      uint32_t (*set_isolation_state)(sPAPRDRConnector *drc,
> > >                                      sPAPRDRIsolationState state);
> > > -    uint32_t (*set_indicator_state)(sPAPRDRConnector *drc,
> > > -                                    sPAPRDRIndicatorState state);
> > >      uint32_t (*set_allocation_state)(sPAPRDRConnector *drc,
> > >                                       sPAPRDRAllocationState state);
> > > =

> > =

> =

> -- =

> David Gibson                    | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_ _othe=
r_
>                                 | _way_ _around_!
> http://www.ozlabs.org/~dgibson
