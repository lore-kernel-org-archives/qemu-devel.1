Received: from eggs.gnu.org ([2001:4830:134:3::10]:40709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eQsSA-0005h4-IB
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:15:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eQsS6-00062d-Cw
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:15:22 -0500
Date: Mon, 18 Dec 2017 21:15:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171218101510.GA4786@umbus.fritz.box>
References: <20171218092024.21645-1-david@gibson.dropbear.id.au>
	<20171218092024.21645-2-david@gibson.dropbear.id.au>
	<20171218105800.397859df@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20171218105800.397859df@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 1/6] spapr: Capabilities infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: surajjs@au1.ibm.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, abologna@redhat.com


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2017 at 10:58:00AM +0100, Greg Kurz wrote:
> On Mon, 18 Dec 2017 20:20:19 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
[snip]
> > +void spapr_caps_reset(sPAPRMachineState *spapr)
> > +{
> > +    Error *local_err =3D NULL;
> > +    sPAPRCapabilities caps;
> > +    int i;
> > +
> > +    /* First compute the actual set of caps we're running with.. */
> > +    caps =3D default_caps_with_cpu(spapr, first_cpu);
> > +
> > +    caps.mask |=3D spapr->forced_caps.mask;
> > +    caps.mask &=3D ~spapr->forbidden_caps.mask;
> > +
> > +    spapr->effective_caps =3D caps;
> > +
> > +    /* .. then apply those caps to the virtual hardware */
> > +
> > +    for (i =3D 0; i < ARRAY_SIZE(capability_table); i++) {
> > +        sPAPRCapabilityInfo *info =3D &capability_table[i];
> > +
> > +        if (spapr->effective_caps.mask & info->flag) {
> > +            /* Failure to allow a cap is fatal - if the guest doesn't
> > +             * have it, we'll be supplying an incorrect environment */
> > +            if (info->allow) {
> > +                info->allow(spapr, &error_fatal);
> > +            }
> > +        } else {
> > +            /* Failure to enforce a cap is only a warning.  The guest
> > +             * shouldn't be using it, since it's not advertised, so it
> > +             * doesn't get to complain about weird behaviour if it
> > +             * goes ahead anyway */
> > +            if (info->disallow) {
> > +                info->disallow(spapr, &local_err);
> > +            }
> > +            if (local_err) {
> > +                warn_report_err(local_err);
> > +                error_free(local_err);
>=20
> double free.
>=20
> /*
>  * Convenience function to warn_report() and free @err.
>  */
> void warn_report_err(Error *err);

Drat, I've made that mistake before.  Fixed now.

> The rest of the patch is fine, so with the above fixed, you can add:
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> > +                local_err =3D NULL;
> > +            }
> > +        }
> > +    }
> > +}
> > +
> > +static void spapr_cap_get(Object *obj, Visitor *v, const char *name,
> > +                          void *opaque, Error **errp)
> > +{
> > +    sPAPRCapabilityInfo *cap =3D opaque;
> > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> > +    bool value =3D spapr_has_cap(spapr, cap->flag);
> > +
> > +    /* TODO: Could this get called before effective_caps is finalized
> > +     * in spapr_caps_reset()? */
> > +
> > +    visit_type_bool(v, name, &value, errp);
> > +}
> > +
> > +static void spapr_cap_set(Object *obj, Visitor *v, const char *name,
> > +                          void *opaque, Error **errp)
> > +{
> > +    sPAPRCapabilityInfo *cap =3D opaque;
> > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> > +    bool value;
> > +    Error *local_err =3D NULL;
> > +
> > +    visit_type_bool(v, name, &value, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +
> > +    if (value) {
> > +        spapr->forced_caps.mask |=3D cap->flag;
> > +    } else {
> > +        spapr->forbidden_caps.mask |=3D cap->flag;
> > +    }
> > +}
> > +
> > +void spapr_caps_validate(sPAPRMachineState *spapr, Error **errp)
> > +{
> > +    uint64_t allcaps =3D 0;
> > +    int i;
> > +
> > +    for (i =3D 0; i < ARRAY_SIZE(capability_table); i++) {
> > +        g_assert((allcaps & capability_table[i].flag) =3D=3D 0);
> > +        allcaps |=3D capability_table[i].flag;
> > +    }
> > +
> > +    g_assert((spapr->forced_caps.mask & ~allcaps) =3D=3D 0);
> > +    g_assert((spapr->forbidden_caps.mask & ~allcaps) =3D=3D 0);
> > +
> > +    if (spapr->forced_caps.mask & spapr->forbidden_caps.mask) {
> > +        error_setg(errp, "Some sPAPR capabilities set both on and off"=
);
> > +        return;
> > +    }
> > +
> > +    /* Check for any caps incompatible with other caps.  Nothing to do
> > +     * yet */
> > +}
> > +
> > +void spapr_caps_add_properties(sPAPRMachineClass *smc, Error **errp)
> > +{
> > +    Error *local_err =3D NULL;
> > +    ObjectClass *klass =3D OBJECT_CLASS(smc);
> > +    int i;
> > +
> > +    for (i =3D 0; i < ARRAY_SIZE(capability_table); i++) {
> > +        sPAPRCapabilityInfo *cap =3D &capability_table[i];
> > +        const char *name =3D g_strdup_printf("cap-%s", cap->name);
> > +
> > +        object_class_property_add(klass, name, "bool",
> > +                                  spapr_cap_get, spapr_cap_set, NULL,
> > +                                  cap, &local_err);
> > +        if (local_err) {
> > +            error_propagate(errp, local_err);
> > +            return;
> > +        }
> > +
> > +        object_class_property_set_description(klass, name, cap->descri=
ption,
> > +                                              &local_err);
> > +        if (local_err) {
> > +            error_propagate(errp, local_err);
> > +            return;
> > +        }
> > +    }
> > +}
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index 14757b805e..5569caf1d4 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -50,6 +50,15 @@ typedef enum {
> >      SPAPR_RESIZE_HPT_REQUIRED,
> >  } sPAPRResizeHPT;
> > =20
> > +/**
> > + * Capabilities
> > + */
> > +
> > +typedef struct sPAPRCapabilities sPAPRCapabilities;
> > +struct sPAPRCapabilities {
> > +    uint64_t mask;
> > +};
> > +
> >  /**
> >   * sPAPRMachineClass:
> >   */
> > @@ -66,6 +75,7 @@ struct sPAPRMachineClass {
> >                            hwaddr *mmio32, hwaddr *mmio64,
> >                            unsigned n_dma, uint32_t *liobns, Error **er=
rp);
> >      sPAPRResizeHPT resize_hpt_default;
> > +    sPAPRCapabilities default_caps;
> >  };
> > =20
> >  /**
> > @@ -127,6 +137,9 @@ struct sPAPRMachineState {
> >      MemoryHotplugState hotplug_memory;
> > =20
> >      const char *icp_type;
> > +
> > +    sPAPRCapabilities forced_caps, forbidden_caps;
> > +    sPAPRCapabilities effective_caps;
> >  };
> > =20
> >  #define H_SUCCESS         0
> > @@ -724,4 +737,22 @@ int spapr_irq_alloc_block(sPAPRMachineState *spapr=
, int num, bool lsi,
> >  void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
> >  qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
> > =20
> > +/*
> > + * Handling of optional capabilities
> > + */
> > +static inline sPAPRCapabilities spapr_caps(uint64_t mask)
> > +{
> > +    sPAPRCapabilities caps =3D { mask };
> > +    return caps;
> > +}
> > +
> > +static inline bool spapr_has_cap(sPAPRMachineState *spapr, uint64_t ca=
p)
> > +{
> > +    return !!(spapr->effective_caps.mask & cap);
> > +}
> > +
> > +void spapr_caps_reset(sPAPRMachineState *spapr);
> > +void spapr_caps_validate(sPAPRMachineState *spapr, Error **errp);
> > +void spapr_caps_add_properties(sPAPRMachineClass *smc, Error **errp);
> > +
> >  #endif /* HW_SPAPR_H */
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlo3lSwACgkQbDjKyiDZ
s5IDfRAA0YeUlrI8xKldozzmIIUFspIAupNOI6PD+s+pFsXyfLLSDj0o6F+DtlX8
iphhTckBFNLaB3gKTRYWo5DIezu4IQYNi776KyvhA2MzuZ3/bwg7keQ8xS7CC781
lOr8YZ3SjvIOuuH19a++AL+NSj89j+Yn7GF77I6ses6V1tL81xuGfWHrnxlcQq7f
21odWVbLU4ytHHRL7ay2kV2p+6VBu3akiYyn92zwMFJ6vNtbFOkqqb0I+A5yI+s2
uufEwmTLdM8hpuo70lKbHJL5G9f96DaleK2hUiVTZA/hhRF0zDxYkPPknBPFgQqS
SV3bAqd+tNlb8Lnk+ChyXSzifr0pQbN65VVKk3S/n7Fw2XT8+ndc+gN7meR7R7zW
LeC2g8gsHFFEdOM/C8vvTEiROhbN7VHqZx+oqKU8jr2NnjTg3Y6ZVyqZG4iIf5pR
SivFJdy4bgrPMQ85SMkHKUVS2PZR4vlXvshvh6YhL7qkkSRY79JBUbjfilGIFQsU
qGKpVb9xt83ZNdzb/8gw/cra3mdBXc5+swRlYDIy715KjEhONbqHLd5qymfFxBx+
I0Q+28IPdFFoU+Io/K3eSzkVepKCjvd3Nc7lAKWdOiv/mUMJ/hYp2MVSemPhxlNQ
wayrKrtciu0berLaOoi60vr7zTIipdncpRm6vyHoZCPUcLrz+0g=
=FA0V
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
