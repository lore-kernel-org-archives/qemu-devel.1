Received: from eggs.gnu.org ([2001:4830:134:3::10]:37955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIRWH-0003Zl-B3
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 23:20:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIRWF-0002Sb-LQ
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 23:20:29 -0400
Date: Wed, 7 Jun 2017 11:28:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170607012851.GH13397@umbus.fritz.box>
References: <20170606083221.9299-1-david@gibson.dropbear.id.au>
	<20170606083221.9299-7-david@gibson.dropbear.id.au>
	<149678307300.2548.13270966751879064274@loki>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ESr4fftwSwE2Rzwi"
Content-Disposition: inline
In-Reply-To: <149678307300.2548.13270966751879064274@loki>
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
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, sursingh@redhat.com, groug@kaod.org


--ESr4fftwSwE2Rzwi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 06, 2017 at 04:04:33PM -0500, Michael Roth wrote:
> Quoting David Gibson (2017-06-06 03:32:20)
> > There are 3 types of "indicator" associated with hotplug in the PAPR sp=
ec
> > the "allocation state", "isolation state" and "DR-indicator".  The first
> > two are intimately tied to the various state transitions associated with
> > hotplug.  The DR-indicator, however, is different and simpler.
> >=20
> > It's basically just a guest controlled variable which can be used by the
> > guest to flag state or problems associated with a device.  The idea is =
that
> > the hypervisor can use it to present information back on management
> > consoles (on some machines with PowerVM it may even control physical LE=
Ds
> > on the machine case associated with the relevant device).
> >=20
> > For that reason, there's only ever likely to be a single update
> > implementation so the set_indicator_state method isn't useful.  Replace=
 it
> > with a direct function call.
> >=20
> > While we're there, make some small associated cleanups:
> >   * PAPR doesn't use the term "indicator state", just "DR-indicator" and
> > the allocation state and isolation state are also considered "indicator=
s".
> > Rename things to be less confusing
> >   * Fold set_indicator_state() and rtas_set_indicator_state() into a si=
ngle
> > rtas_set_dr_indicator() function.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr_drc.c         | 25 ++++++++-----------------
> >  hw/ppc/trace-events        |  2 +-
> >  include/hw/ppc/spapr_drc.h | 16 ++++++++--------
> >  3 files changed, 17 insertions(+), 26 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> > index 6c2fa93..a4ece2e 100644
> > --- a/hw/ppc/spapr_drc.c
> > +++ b/hw/ppc/spapr_drc.c
> > @@ -116,14 +116,6 @@ static uint32_t set_isolation_state(sPAPRDRConnect=
or *drc,
> >      return RTAS_OUT_SUCCESS;
> >  }
> >=20
> > -static uint32_t set_indicator_state(sPAPRDRConnector *drc,
> > -                                    sPAPRDRIndicatorState state)
> > -{
> > -    trace_spapr_drc_set_indicator_state(spapr_drc_index(drc), state);
> > -    drc->indicator_state =3D state;
> > -    return RTAS_OUT_SUCCESS;
> > -}
> > -
> >  static uint32_t set_allocation_state(sPAPRDRConnector *drc,
> >                                       sPAPRDRAllocationState state)
> >  {
> > @@ -313,7 +305,7 @@ static void attach(sPAPRDRConnector *drc, DeviceSta=
te *d, void *fdt,
> >      if (spapr_drc_type(drc) =3D=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
> >          drc->isolation_state =3D SPAPR_DR_ISOLATION_STATE_UNISOLATED;
> >      }
> > -    drc->indicator_state =3D SPAPR_DR_INDICATOR_STATE_ACTIVE;
> > +    drc->dr_indicator =3D SPAPR_DR_INDICATOR_ACTIVE;
> >=20
> >      drc->dev =3D d;
> >      drc->fdt =3D fdt;
> > @@ -386,7 +378,7 @@ static void detach(sPAPRDRConnector *drc, DeviceSta=
te *d, Error **errp)
> >          }
> >      }
> >=20
> > -    drc->indicator_state =3D SPAPR_DR_INDICATOR_STATE_INACTIVE;
> > +    drc->dr_indicator =3D SPAPR_DR_INDICATOR_INACTIVE;
> >=20
> >      /* Calling release callbacks based on spapr_drc_type(drc). */
> >      switch (spapr_drc_type(drc)) {
> > @@ -499,7 +491,7 @@ static const VMStateDescription vmstate_spapr_drc =
=3D {
> >      .fields  =3D (VMStateField []) {
> >          VMSTATE_UINT32(isolation_state, sPAPRDRConnector),
> >          VMSTATE_UINT32(allocation_state, sPAPRDRConnector),
> > -        VMSTATE_UINT32(indicator_state, sPAPRDRConnector),
> > +        VMSTATE_UINT32(dr_indicator, sPAPRDRConnector),
> >          VMSTATE_BOOL(configured, sPAPRDRConnector),
> >          VMSTATE_BOOL(awaiting_release, sPAPRDRConnector),
> >          VMSTATE_BOOL(awaiting_allocation, sPAPRDRConnector),
> > @@ -614,7 +606,6 @@ static void spapr_dr_connector_class_init(ObjectCla=
ss *k, void *data)
> >      dk->realize =3D realize;
> >      dk->unrealize =3D unrealize;
> >      drck->set_isolation_state =3D set_isolation_state;
> > -    drck->set_indicator_state =3D set_indicator_state;
> >      drck->set_allocation_state =3D set_allocation_state;
> >      drck->attach =3D attach;
> >      drck->detach =3D detach;
> > @@ -895,17 +886,17 @@ static uint32_t rtas_set_allocation_state(uint32_=
t idx, uint32_t state)
> >      return drck->set_allocation_state(drc, state);
> >  }
> >=20
> > -static uint32_t rtas_set_indicator_state(uint32_t idx, uint32_t state)
> > +static uint32_t rtas_set_dr_indicator(uint32_t idx, uint32_t state)
> >  {
> >      sPAPRDRConnector *drc =3D spapr_drc_by_index(idx);
> > -    sPAPRDRConnectorClass *drck;
> >=20
> >      if (!drc) {
> >          return RTAS_OUT_PARAM_ERROR;
> >      }
> >=20
> > -    drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> > -    return drck->set_indicator_state(drc, state);
> > +    trace_spapr_drc_set_dr_indicator(idx, state);
> > +    drc->dr_indicator =3D state;
> > +    return RTAS_OUT_SUCCESS;
> >  }
> >=20
> >  static void rtas_set_indicator(PowerPCCPU *cpu, sPAPRMachineState *spa=
pr,
> > @@ -930,7 +921,7 @@ static void rtas_set_indicator(PowerPCCPU *cpu, sPA=
PRMachineState *spapr,
> >          ret =3D rtas_set_isolation_state(idx, state);
> >          break;
> >      case RTAS_SENSOR_TYPE_DR:
> > -        ret =3D rtas_set_indicator_state(idx, state);
> > +        ret =3D rtas_set_dr_indicator(idx, state);
> >          break;
> >      case RTAS_SENSOR_TYPE_ALLOCATION_STATE:
> >          ret =3D rtas_set_allocation_state(idx, state);
> > diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> > index 581fa85..3e8e3cf 100644
> > --- a/hw/ppc/trace-events
> > +++ b/hw/ppc/trace-events
> > @@ -39,7 +39,7 @@ spapr_iommu_ddw_reset(uint64_t buid, uint32_t cfgaddr=
) "buid=3D%"PRIx64" addr=3D%"PR
> >  spapr_drc_set_isolation_state(uint32_t index, int state) "drc: 0x%"PRI=
x32", state: %"PRIx32
> >  spapr_drc_set_isolation_state_finalizing(uint32_t index) "drc: 0x%"PRI=
x32
> >  spapr_drc_set_isolation_state_deferring(uint32_t index) "drc: 0x%"PRIx=
32
> > -spapr_drc_set_indicator_state(uint32_t index, int state) "drc: 0x%"PRI=
x32", state: 0x%x"
> > +spapr_drc_set_dr_indicator(uint32_t index, int state) "drc: 0x%"PRIx32=
", state: 0x%x"
>=20
> Since this only tracks the changes to dr_indicator via RTAS (as was also
> the case previously), it should probably be changed to an RTAS trace
> while we're here.

That doesn't follow for me.  Yes, it's only triggered by RTAS, but
it's really about a DRC event.  It's when debugging DRC things that
you're going to care about it.

>=20
> In either case:
>=20
> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>=20
> >  spapr_drc_set_allocation_state(uint32_t index, int state) "drc: 0x%"PR=
Ix32", state: 0x%x"
> >  spapr_drc_set_allocation_state_finalizing(uint32_t index) "drc: 0x%"PR=
Ix32
> >  spapr_drc_set_configured(uint32_t index) "drc: 0x%"PRIx32
> > diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> > index d437e0a..802c708 100644
> > --- a/include/hw/ppc/spapr_drc.h
> > +++ b/include/hw/ppc/spapr_drc.h
> > @@ -125,7 +125,7 @@ typedef enum {
> >  } sPAPRDRAllocationState;
> >=20
> >  /*
> > - * LED/visual indicator state
> > + * DR-indicator (LED/visual indicator)
> >   *
> >   * set via set-indicator RTAS calls
> >   * as documented by PAPR+ 2.7 13.5.3.4, Table 177,
> > @@ -137,10 +137,10 @@ typedef enum {
> >   * action: (currently unused)
> >   */
> >  typedef enum {
> > -    SPAPR_DR_INDICATOR_STATE_INACTIVE   =3D 0,
> > -    SPAPR_DR_INDICATOR_STATE_ACTIVE     =3D 1,
> > -    SPAPR_DR_INDICATOR_STATE_IDENTIFY   =3D 2,
> > -    SPAPR_DR_INDICATOR_STATE_ACTION     =3D 3,
> > +    SPAPR_DR_INDICATOR_INACTIVE   =3D 0,
> > +    SPAPR_DR_INDICATOR_ACTIVE     =3D 1,
> > +    SPAPR_DR_INDICATOR_IDENTIFY   =3D 2,
> > +    SPAPR_DR_INDICATOR_ACTION     =3D 3,
> >  } sPAPRDRIndicatorState;
> >=20
> >  /*
> > @@ -186,10 +186,12 @@ typedef struct sPAPRDRConnector {
> >      Object *owner;
> >      char *name;
> >=20
> > +    /* DR-indicator */
> > +    uint32_t dr_indicator;
> > +
> >      /* sensor/indicator states */
> >      uint32_t isolation_state;
> >      uint32_t allocation_state;
> > -    uint32_t indicator_state;
> >=20
> >      /* configure-connector state */
> >      void *fdt;
> > @@ -219,8 +221,6 @@ typedef struct sPAPRDRConnectorClass {
> >      /* accessors for guest-visible (generally via RTAS) DR state */
> >      uint32_t (*set_isolation_state)(sPAPRDRConnector *drc,
> >                                      sPAPRDRIsolationState state);
> > -    uint32_t (*set_indicator_state)(sPAPRDRConnector *drc,
> > -                                    sPAPRDRIndicatorState state);
> >      uint32_t (*set_allocation_state)(sPAPRDRConnector *drc,
> >                                       sPAPRDRAllocationState state);
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ESr4fftwSwE2Rzwi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZN1bQAAoJEGw4ysog2bOSQSsP/27nBF7G9Fw3J6oclrnl9lLo
qElcHMKxxaE1nlIn+wVnHLl7OYaVgUVOr2kWI10itlCiShwKVp7beNjBP1dq5gou
B7y8OYm9zrqvG0Rlj6rx8p+qVOPIQQNPVezhnqtG91mr3SHWO2tjtRzFt8it63Ss
5tpsJU/O7YUg3vUXFLvrJsESZNShejVsNxgp51GITFHydKlncQuz844T8MJigght
OUQGbmqlNSO8e+OhLHXBD07wpj2al4xwRQHT/itdk+9eQjxZziVM8xT3kpfTbxNz
JGdCn6iSO4cHm2++NmQW5R+8bUbznh9FA2RPOHYWnKUpWFXp68tIiemYdB4yRulq
Jix9yypFjsyS61g2rZHnyiuMNWPUdXEejjLqNRWUM/+iwTz6Ooq1IQxq5wrSDLQN
mOutRvlPsLlgpmYoXN7NJt9RwmRVjZlKhphikLQrHZ5X43NNoLQ974nUoIAOwigp
w63c1N9w42G5yYJMy1c+jhe+5XoMN5ukx/boNrZK6Z6k7mocQLPBQVtX5LzDat/Z
KobVoYH7FjQg4qqzq5eU5E3nJj6nOcbi1kbdHxm35ijqCJ0/bS1O54ITPMIprG5x
Z1dRv+rxtPfvNiQ5MOfYL4UAhV/lc2oY9mJW9oxAwfLdu6ydj5YFNQGexXoNZZeH
y3z7e1ZJ6EY2X+yAQUqg
=Zv1q
-----END PGP SIGNATURE-----

--ESr4fftwSwE2Rzwi--
