Received: from eggs.gnu.org ([2001:4830:134:3::10]:37298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGgco-0008Dy-FI
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:04:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGgcm-0000sH-I6
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:03:58 -0400
Date: Fri, 2 Jun 2017 13:21:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170602032108.GJ13397@umbus.fritz.box>
References: <20170601015218.9299-1-david@gibson.dropbear.id.au>
	<20170601015218.9299-2-david@gibson.dropbear.id.au>
	<20e745b0-a1ed-8be4-d587-377b4b7610b1@redhat.com>
	<149633313755.3207.17440798093242250707@loki>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j+MD90OnwjQyWNYt"
Content-Disposition: inline
In-Reply-To: <149633313755.3207.17440798093242250707@loki>
Subject: Re: [Qemu-devel] [PATCH 1/4] spapr: Move DRC RTAS calls into
 spapr_drc.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Laurent Vivier <lvivier@redhat.com>, sursingh@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, nikunj@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com


--j+MD90OnwjQyWNYt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2017 at 11:05:37AM -0500, Michael Roth wrote:
> Quoting Laurent Vivier (2017-06-01 08:36:36)
> > On 01/06/2017 03:52, David Gibson wrote:
> > > Currently implementations of the RTAS calls related to DRCs are in
> > > spapr_rtas.c.  They belong better in spapr_drc.c - that way they're c=
loser
> > > to related code, and we'll be able to make some more things local.
> > >=20
> > > spapr_rtas.c was intended to contain the RTAS infrastructure and core=
 calls
> > > that don't belong anywhere else, not every RTAS implementation.
> > >=20
> > > Code motion only.
> > >=20
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > ---
> > >  hw/ppc/spapr_drc.c  | 322 ++++++++++++++++++++++++++++++++++++++++++=
++++++++--
> > >  hw/ppc/spapr_rtas.c | 304 ------------------------------------------=
-------
> > >  2 files changed, 315 insertions(+), 311 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> > > index cc2400b..ae8800d 100644
> > > --- a/hw/ppc/spapr_drc.c
> > > +++ b/hw/ppc/spapr_drc.c
> > > @@ -27,6 +27,34 @@
> > >  #define DRC_INDEX_TYPE_SHIFT 28
> > >  #define DRC_INDEX_ID_MASK ((1ULL << DRC_INDEX_TYPE_SHIFT) - 1)
> > > =20
> > > +static sPAPRConfigureConnectorState *spapr_ccs_find(sPAPRMachineStat=
e *spapr,
> > > +                                                    uint32_t drc_ind=
ex)
> > > +{
> > > +    sPAPRConfigureConnectorState *ccs =3D NULL;
> > > +
> > > +    QTAILQ_FOREACH(ccs, &spapr->ccs_list, next) {
> > > +        if (ccs->drc_index =3D=3D drc_index) {
> > > +            break;
> > > +        }
> > > +    }
> > > +
> > > +    return ccs;
> > > +}
> > > +
> > > +static void spapr_ccs_add(sPAPRMachineState *spapr,
> > > +                          sPAPRConfigureConnectorState *ccs)
> > > +{
> > > +    g_assert(!spapr_ccs_find(spapr, ccs->drc_index));
> > > +    QTAILQ_INSERT_HEAD(&spapr->ccs_list, ccs, next);
> > > +}
> > > +
> > > +static void spapr_ccs_remove(sPAPRMachineState *spapr,
> > > +                             sPAPRConfigureConnectorState *ccs)
> > > +{
> > > +    QTAILQ_REMOVE(&spapr->ccs_list, ccs, next);
> > > +    g_free(ccs);
> > > +}
> > > +
> > >  static sPAPRDRConnectorTypeShift get_type_shift(sPAPRDRConnectorType=
 type)
> > >  {
> > >      uint32_t shift =3D 0;
> > > @@ -747,13 +775,6 @@ static const TypeInfo spapr_dr_connector_info =
=3D {
> > >      .class_init    =3D spapr_dr_connector_class_init,
> > >  };
> > > =20
> > > -static void spapr_drc_register_types(void)
> > > -{
> > > -    type_register_static(&spapr_dr_connector_info);
> > > -}
> > > -
> > > -type_init(spapr_drc_register_types)
> > > -
> > >  /* helper functions for external users */
> > > =20
> > >  sPAPRDRConnector *spapr_dr_connector_by_index(uint32_t index)
> > > @@ -932,3 +953,290 @@ out:
> > > =20
> > >      return ret;
> > >  }
> > > +
> > > +/*
> > > + * RTAS calls
> > > + */
> > > +
> > > +static bool sensor_type_is_dr(uint32_t sensor_type)
> > > +{
> > > +    switch (sensor_type) {
> > > +    case RTAS_SENSOR_TYPE_ISOLATION_STATE:
> > > +    case RTAS_SENSOR_TYPE_DR:
> > > +    case RTAS_SENSOR_TYPE_ALLOCATION_STATE:
> > > +        return true;
> > > +    }
> > > +
> > > +    return false;
> > > +}
> > > +
> > > +static void rtas_set_indicator(PowerPCCPU *cpu, sPAPRMachineState *s=
papr,
> > > +                               uint32_t token, uint32_t nargs,
> > > +                               target_ulong args, uint32_t nret,
> > > +                               target_ulong rets)
> > > +{
> > > +    uint32_t sensor_type;
> > > +    uint32_t sensor_index;
> > > +    uint32_t sensor_state;
> > > +    uint32_t ret =3D RTAS_OUT_SUCCESS;
> > > +    sPAPRDRConnector *drc;
> > > +    sPAPRDRConnectorClass *drck;
> > > +
> > > +    if (nargs !=3D 3 || nret !=3D 1) {
> > > +        ret =3D RTAS_OUT_PARAM_ERROR;
> > > +        goto out;
> > > +    }
> > > +
> > > +    sensor_type =3D rtas_ld(args, 0);
> > > +    sensor_index =3D rtas_ld(args, 1);
> > > +    sensor_state =3D rtas_ld(args, 2);
> > > +
> > > +    if (!sensor_type_is_dr(sensor_type)) {
> > > +        goto out_unimplemented;
> > > +    }
> > > +
> > > +    /* if this is a DR sensor we can assume sensor_index =3D=3D drc_=
index */
> > > +    drc =3D spapr_dr_connector_by_index(sensor_index);
> > > +    if (!drc) {
> > > +        trace_spapr_rtas_set_indicator_invalid(sensor_index);
> > > +        ret =3D RTAS_OUT_PARAM_ERROR;
> > > +        goto out;
> > > +    }
> > > +    drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> > > +
> > > +    switch (sensor_type) {
> > > +    case RTAS_SENSOR_TYPE_ISOLATION_STATE:
> > > +        /* if the guest is configuring a device attached to this
> > > +         * DRC, we should reset the configuration state at this
> > > +         * point since it may no longer be reliable (guest released
> > > +         * device and needs to start over, or unplug occurred so
> > > +         * the FDT is no longer valid)
> > > +         */
> > > +        if (sensor_state =3D=3D SPAPR_DR_ISOLATION_STATE_ISOLATED) {
> > > +            sPAPRConfigureConnectorState *ccs =3D spapr_ccs_find(spa=
pr,
> > > +                                                               senso=
r_index);
> > > +            if (ccs) {
> > > +                spapr_ccs_remove(spapr, ccs);
> > > +            }
> > > +        }
> > > +        ret =3D drck->set_isolation_state(drc, sensor_state);
> > > +        break;
> > > +    case RTAS_SENSOR_TYPE_DR:
> > > +        ret =3D drck->set_indicator_state(drc, sensor_state);
> > > +        break;
> > > +    case RTAS_SENSOR_TYPE_ALLOCATION_STATE:
> > > +        ret =3D drck->set_allocation_state(drc, sensor_state);
> > > +        break;
> > > +    default:
> > > +        goto out_unimplemented;
> > > +    }
> > > +
> > > +out:
> > > +    rtas_st(rets, 0, ret);
> > > +    return;
> > > +
> > > +out_unimplemented:
> > > +    /* currently only DR-related sensors are implemented */
> > > +    trace_spapr_rtas_set_indicator_not_supported(sensor_index, senso=
r_type);
> > > +    rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> > > +}
> > > +
> > > +static void rtas_get_sensor_state(PowerPCCPU *cpu, sPAPRMachineState=
 *spapr,
> > > +                                  uint32_t token, uint32_t nargs,
> > > +                                  target_ulong args, uint32_t nret,
> > > +                                  target_ulong rets)
> > > +{
> > > +    uint32_t sensor_type;
> > > +    uint32_t sensor_index;
> > > +    uint32_t sensor_state =3D 0;
> > > +    sPAPRDRConnector *drc;
> > > +    sPAPRDRConnectorClass *drck;
> > > +    uint32_t ret =3D RTAS_OUT_SUCCESS;
> > > +
> > > +    if (nargs !=3D 2 || nret !=3D 2) {
> > > +        ret =3D RTAS_OUT_PARAM_ERROR;
> > > +        goto out;
> > > +    }
> > > +
> > > +    sensor_type =3D rtas_ld(args, 0);
> > > +    sensor_index =3D rtas_ld(args, 1);
> > > +
> > > +    if (sensor_type !=3D RTAS_SENSOR_TYPE_ENTITY_SENSE) {
> > > +        /* currently only DR-related sensors are implemented */
> > > +        trace_spapr_rtas_get_sensor_state_not_supported(sensor_index,
> > > +                                                        sensor_type);
> > > +        ret =3D RTAS_OUT_NOT_SUPPORTED;
> > > +        goto out;
> > > +    }
> > > +
> > > +    drc =3D spapr_dr_connector_by_index(sensor_index);
> > > +    if (!drc) {
> > > +        trace_spapr_rtas_get_sensor_state_invalid(sensor_index);
> > > +        ret =3D RTAS_OUT_PARAM_ERROR;
> > > +        goto out;
> > > +    }
> > > +    drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> > > +    ret =3D drck->entity_sense(drc, &sensor_state);
> > > +
> > > +out:
> > > +    rtas_st(rets, 0, ret);
> > > +    rtas_st(rets, 1, sensor_state);
> > > +}
> > > +
> > > +/* configure-connector work area offsets, int32_t units for field
> > > + * indexes, bytes for field offset/len values.
> > > + *
> > > + * as documented by PAPR+ v2.7, 13.5.3.5
> > > + */
> > > +#define CC_IDX_NODE_NAME_OFFSET 2
> > > +#define CC_IDX_PROP_NAME_OFFSET 2
> > > +#define CC_IDX_PROP_LEN 3
> > > +#define CC_IDX_PROP_DATA_OFFSET 4
> > > +#define CC_VAL_DATA_OFFSET ((CC_IDX_PROP_DATA_OFFSET + 1) * 4)
> > > +#define CC_WA_LEN 4096
> > > +
> > > +static void configure_connector_st(target_ulong addr, target_ulong o=
ffset,
> > > +                                   const void *buf, size_t len)
> > > +{
> > > +    cpu_physical_memory_write(ppc64_phys_to_real(addr + offset),
> > > +                              buf, MIN(len, CC_WA_LEN - offset));
> > > +}
> > > +
> > > +void spapr_ccs_reset_hook(void *opaque)
> > > +{
> > > +    sPAPRMachineState *spapr =3D opaque;
> > > +    sPAPRConfigureConnectorState *ccs, *ccs_tmp;
> > > +
> > > +    QTAILQ_FOREACH_SAFE(ccs, &spapr->ccs_list, next, ccs_tmp) {
> > > +        spapr_ccs_remove(spapr, ccs);
> > > +    }
> > > +}
> >=20
> >=20
> > Why do you move this function in the middle of the "RTAS calls" whereas
> > previously it was with spapr_ccs_find(), spapr_ccs_add() and
> > spapr_ccs_remove() and it is only used by a reset handler in spapr.c?
>=20
> I think it's as good a spot as any after the move, and allows
> spapr_ccs_* functions to remain static.

Yeah, what he said.

> But all the CCS stuff got hung off of sPAPRMachineState in the first
> place due to an attempt to separate "RTAS" state from the DRC state.

Ah, right.  I think that was a mistake - RTAS is just an interface to
various subsystems; it doesn't have state of its own.

> Now
> that we're treating both as internal state, I think a logical follow-up
> would be to drop the CCS list completely and instead hang each instance
> off of the corresponding DRC. At that point we'd probably want to move
> the reset functionality into the DRC reset hook anyway.

I'll look into that.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--j+MD90OnwjQyWNYt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZMNmiAAoJEGw4ysog2bOSnqAQAOX7/gqJEwBTOtILyU6TYzAD
nT52eGy65hj7Q9bOXPS75g2tdxQNTmPTczH1NgxmFezbuInJePmsCITc4GW9K+If
x12MrNfCQ3nBQ0JbxBZ+dOK5HsYDbdaIxU4jUkyyZiYY1KcTHbfCj/zuVjmQbrq0
9HsLRgfkUys02nYc0wtpxewRMRKCVyJjrdS7g2Yyh8SrDUjEZNuBTvfoPJwynkIR
ZtNJTYV8bveQKOQYYNENIYpstM7aAQSZeBksQJHatqf+P+fqB90p1jJW/pG0h/2S
S6XhLb/TJHkHryKvXAtl8hakKQc2oj+/xDM0pxKI0br80aysS0pvY6lTEHuPCBeW
DH5kZOIdjuQHDlXJuFCFJovrOYShM3SA8KPGc89PgxC+bI7RDcU7hQIt3YAyUE/F
FPKoEzz/poWhqU776Vn5xFOO4zYPJAnQOngP6YB7zwj+sWppM5+optgGwGd++FDp
/TZG9hQhrkh8xvIN+mbzuX1pTHIkQtZKkuNFMBDbl2FQaE1WK8GkUDJtMdI7vvmv
H2ItbDbREGfvxZbsnVZxf55QaRZECn4DlLhMg56B+Rr0tHUfAE/tM4vVrTTAKgl4
G7Ubf4aDfRUaeO76oM93zPpx91JFsYyzpJpqBCJanVJeuFcg0T8/kuZkKYCTwNTa
oHktPEcYmuUBPK443nW6
=umH7
-----END PGP SIGNATURE-----

--j+MD90OnwjQyWNYt--
