Received: from eggs.gnu.org ([2001:4830:134:3::10]:37242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dImQb-0001IK-J1
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 21:40:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dImQY-0006o3-HB
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 21:40:01 -0400
Date: Thu, 8 Jun 2017 11:08:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170608010858.GO13397@umbus.fritz.box>
References: <20170606083221.9299-1-david@gibson.dropbear.id.au>
	<20170606083221.9299-7-david@gibson.dropbear.id.au>
	<149678307300.2548.13270966751879064274@loki>
	<20170607012851.GH13397@umbus.fritz.box>
	<149687706332.5725.5499034992685312407@loki>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fuid1o0BiVNrPGA3"
Content-Disposition: inline
In-Reply-To: <149687706332.5725.5499034992685312407@loki>
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


--fuid1o0BiVNrPGA3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2017 at 06:11:03PM -0500, Michael Roth wrote:
> Quoting David Gibson (2017-06-06 20:28:51)
> > On Tue, Jun 06, 2017 at 04:04:33PM -0500, Michael Roth wrote:
> > > Quoting David Gibson (2017-06-06 03:32:20)
> > > > There are 3 types of "indicator" associated with hotplug in the PAP=
R spec
> > > > the "allocation state", "isolation state" and "DR-indicator".  The =
first
> > > > two are intimately tied to the various state transitions associated=
 with
> > > > hotplug.  The DR-indicator, however, is different and simpler.
> > > >=20
> > > > It's basically just a guest controlled variable which can be used b=
y the
> > > > guest to flag state or problems associated with a device.  The idea=
 is that
> > > > the hypervisor can use it to present information back on management
> > > > consoles (on some machines with PowerVM it may even control physica=
l LEDs
> > > > on the machine case associated with the relevant device).
> > > >=20
> > > > For that reason, there's only ever likely to be a single update
> > > > implementation so the set_indicator_state method isn't useful.  Rep=
lace it
> > > > with a direct function call.
> > > >=20
> > > > While we're there, make some small associated cleanups:
> > > >   * PAPR doesn't use the term "indicator state", just "DR-indicator=
" and
> > > > the allocation state and isolation state are also considered "indic=
ators".
> > > > Rename things to be less confusing
> > > >   * Fold set_indicator_state() and rtas_set_indicator_state() into =
a single
> > > > rtas_set_dr_indicator() function.
> > > >=20
> > > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > > ---
> > > >  hw/ppc/spapr_drc.c         | 25 ++++++++-----------------
> > > >  hw/ppc/trace-events        |  2 +-
> > > >  include/hw/ppc/spapr_drc.h | 16 ++++++++--------
> > > >  3 files changed, 17 insertions(+), 26 deletions(-)
> > > >=20
> > > > diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> > > > index 6c2fa93..a4ece2e 100644
> > > > --- a/hw/ppc/spapr_drc.c
> > > > +++ b/hw/ppc/spapr_drc.c
> > > > @@ -116,14 +116,6 @@ static uint32_t set_isolation_state(sPAPRDRCon=
nector *drc,
> > > >      return RTAS_OUT_SUCCESS;
> > > >  }
> > > >=20
> > > > -static uint32_t set_indicator_state(sPAPRDRConnector *drc,
> > > > -                                    sPAPRDRIndicatorState state)
> > > > -{
> > > > -    trace_spapr_drc_set_indicator_state(spapr_drc_index(drc), stat=
e);
> > > > -    drc->indicator_state =3D state;
> > > > -    return RTAS_OUT_SUCCESS;
> > > > -}
> > > > -
> > > >  static uint32_t set_allocation_state(sPAPRDRConnector *drc,
> > > >                                       sPAPRDRAllocationState state)
> > > >  {
> > > > @@ -313,7 +305,7 @@ static void attach(sPAPRDRConnector *drc, Devic=
eState *d, void *fdt,
> > > >      if (spapr_drc_type(drc) =3D=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
> > > >          drc->isolation_state =3D SPAPR_DR_ISOLATION_STATE_UNISOLAT=
ED;
> > > >      }
> > > > -    drc->indicator_state =3D SPAPR_DR_INDICATOR_STATE_ACTIVE;
> > > > +    drc->dr_indicator =3D SPAPR_DR_INDICATOR_ACTIVE;
> > > >=20
> > > >      drc->dev =3D d;
> > > >      drc->fdt =3D fdt;
> > > > @@ -386,7 +378,7 @@ static void detach(sPAPRDRConnector *drc, Devic=
eState *d, Error **errp)
> > > >          }
> > > >      }
> > > >=20
> > > > -    drc->indicator_state =3D SPAPR_DR_INDICATOR_STATE_INACTIVE;
> > > > +    drc->dr_indicator =3D SPAPR_DR_INDICATOR_INACTIVE;
> > > >=20
> > > >      /* Calling release callbacks based on spapr_drc_type(drc). */
> > > >      switch (spapr_drc_type(drc)) {
> > > > @@ -499,7 +491,7 @@ static const VMStateDescription vmstate_spapr_d=
rc =3D {
> > > >      .fields  =3D (VMStateField []) {
> > > >          VMSTATE_UINT32(isolation_state, sPAPRDRConnector),
> > > >          VMSTATE_UINT32(allocation_state, sPAPRDRConnector),
> > > > -        VMSTATE_UINT32(indicator_state, sPAPRDRConnector),
> > > > +        VMSTATE_UINT32(dr_indicator, sPAPRDRConnector),
> > > >          VMSTATE_BOOL(configured, sPAPRDRConnector),
> > > >          VMSTATE_BOOL(awaiting_release, sPAPRDRConnector),
> > > >          VMSTATE_BOOL(awaiting_allocation, sPAPRDRConnector),
> > > > @@ -614,7 +606,6 @@ static void spapr_dr_connector_class_init(Objec=
tClass *k, void *data)
> > > >      dk->realize =3D realize;
> > > >      dk->unrealize =3D unrealize;
> > > >      drck->set_isolation_state =3D set_isolation_state;
> > > > -    drck->set_indicator_state =3D set_indicator_state;
> > > >      drck->set_allocation_state =3D set_allocation_state;
> > > >      drck->attach =3D attach;
> > > >      drck->detach =3D detach;
> > > > @@ -895,17 +886,17 @@ static uint32_t rtas_set_allocation_state(uin=
t32_t idx, uint32_t state)
> > > >      return drck->set_allocation_state(drc, state);
> > > >  }
> > > >=20
> > > > -static uint32_t rtas_set_indicator_state(uint32_t idx, uint32_t st=
ate)
> > > > +static uint32_t rtas_set_dr_indicator(uint32_t idx, uint32_t state)
> > > >  {
> > > >      sPAPRDRConnector *drc =3D spapr_drc_by_index(idx);
> > > > -    sPAPRDRConnectorClass *drck;
> > > >=20
> > > >      if (!drc) {
> > > >          return RTAS_OUT_PARAM_ERROR;
> > > >      }
> > > >=20
> > > > -    drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> > > > -    return drck->set_indicator_state(drc, state);
> > > > +    trace_spapr_drc_set_dr_indicator(idx, state);
> > > > +    drc->dr_indicator =3D state;
> > > > +    return RTAS_OUT_SUCCESS;
> > > >  }
> > > >=20
> > > >  static void rtas_set_indicator(PowerPCCPU *cpu, sPAPRMachineState =
*spapr,
> > > > @@ -930,7 +921,7 @@ static void rtas_set_indicator(PowerPCCPU *cpu,=
 sPAPRMachineState *spapr,
> > > >          ret =3D rtas_set_isolation_state(idx, state);
> > > >          break;
> > > >      case RTAS_SENSOR_TYPE_DR:
> > > > -        ret =3D rtas_set_indicator_state(idx, state);
> > > > +        ret =3D rtas_set_dr_indicator(idx, state);
> > > >          break;
> > > >      case RTAS_SENSOR_TYPE_ALLOCATION_STATE:
> > > >          ret =3D rtas_set_allocation_state(idx, state);
> > > > diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> > > > index 581fa85..3e8e3cf 100644
> > > > --- a/hw/ppc/trace-events
> > > > +++ b/hw/ppc/trace-events
> > > > @@ -39,7 +39,7 @@ spapr_iommu_ddw_reset(uint64_t buid, uint32_t cfg=
addr) "buid=3D%"PRIx64" addr=3D%"PR
> > > >  spapr_drc_set_isolation_state(uint32_t index, int state) "drc: 0x%=
"PRIx32", state: %"PRIx32
> > > >  spapr_drc_set_isolation_state_finalizing(uint32_t index) "drc: 0x%=
"PRIx32
> > > >  spapr_drc_set_isolation_state_deferring(uint32_t index) "drc: 0x%"=
PRIx32
> > > > -spapr_drc_set_indicator_state(uint32_t index, int state) "drc: 0x%=
"PRIx32", state: 0x%x"
> > > > +spapr_drc_set_dr_indicator(uint32_t index, int state) "drc: 0x%"PR=
Ix32", state: 0x%x"
> > >=20
> > > Since this only tracks the changes to dr_indicator via RTAS (as was a=
lso
> > > the case previously), it should probably be changed to an RTAS trace
> > > while we're here.
> >=20
> > That doesn't follow for me.  Yes, it's only triggered by RTAS, but
> > it's really about a DRC event.  It's when debugging DRC things that
> > you're going to care about it.
>=20
> My concern is more on the trace output side of things. As it stands it
> gives a false sense that you're seeing a full accounting of the state
> changes when really it's only a particular call-site that's being
> traced. Making it spapr_drc_set_dr_indicator_rtas would have been a
> better suggestion though.

Oh, I see.  That's not new though - the only other dr-indicator state
changes already didn't go through that call path.

> Then again, the issue is not unique to this particular value, so maybe
> a general rework of how we handle tracing would be better left for when
> the dust settles a bit instead of trying to patch it up along the
> way.

Yeah, I think that makes sense.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fuid1o0BiVNrPGA3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZOKOqAAoJEGw4ysog2bOSn5kQAJc6zlSdezCCpruVAthd5K4A
YWL0PMpHzpWbyVi1eJvrAatm4bcrjSUGNu4u4p8RgSOtoJXuoIjiYRIZJwA+T3R9
txSoE2fbvfDrg+XzFfl7F5gdP0IHSL17JUHUn5QGRdxnZOOythlz3/7wXdl7RxTe
yP5yq61bJoPHb4PeXkcbtjY2V/Ug2O2f2xOhEVhNeu9Gm5ZeDmUeq6r7dHK4Utt4
ezNrKsIZiNxi7lGwOEGx0C003/GYq+LPyyrILyTeyhxYUmd10OYx/NYaiI+78LXu
6redhQ3zHBciF1kteshyzqdGUVHAwuehjYEG1IDczSpfz4RFqykid2p0As6IDwuw
HZDDaAsZFS/dfGggIeBSI73O7wygzsgLgkdHGiw9MxiLC+Jv7TIHzpdNNQ1yQyF7
xi+kH8Z8PzZXYeh8P0cUXu6H+5Sv6Ic9QlbPPgXqo5Gu7QUBOf4GtIYT4jl4+eOd
Y6ZHImF6QfOIUVUzfaSdkSMYMySKTu4AMpaNglG2MdyCVcJIYrBnSoVNKiVcp/5k
Zo80MWzQ3LnN433+7DH2LrC6kpL2Iyra31CpdhVzyl9fF1UxGdOXsxCh8G6mwvPk
Si3+lL3WOITlnSmVrir6FGd9S1S9j7HUEa91PSdpexwXjzhMDxtePwai/hchTGZd
UO9TVLLKxZDYjscS9ppG
=OHvh
-----END PGP SIGNATURE-----

--fuid1o0BiVNrPGA3--
