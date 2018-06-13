Received: from eggs.gnu.org ([2001:4830:134:3::10]:36967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fT29P-0007Fb-Np
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:33:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fT29O-0006tx-JN
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:33:11 -0400
Date: Wed, 13 Jun 2018 19:14:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180613091426.GB30690@umbus.fritz.box>
References: <20180613065707.30766-1-david@gibson.dropbear.id.au>
	<20180613065707.30766-5-david@gibson.dropbear.id.au>
	<dff8eff9-89da-5fcb-579d-656b356924a4@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="78WCQgNEg63vc82l"
Content-Disposition: inline
In-Reply-To: <dff8eff9-89da-5fcb-579d-656b356924a4@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 4/7] pnv: Clean up cpu realize path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--78WCQgNEg63vc82l
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2018 at 10:20:43AM +0200, C=E9dric Le Goater wrote:
> On 06/13/2018 08:57 AM, David Gibson wrote:
> > pnv_cpu_init() is only called from the the pnv cpu core realize path, a=
nd
> > really only can be called from there.  So fold it into its caller, which
> > we also rename for brevity.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> I think we should set the default CPU settings (PIR) before creating
> the 'intc' object. I have cleanup for that in the pnv patchset.=20
> Nevertheless,

Ok.

> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> Thanks,
>=20
> C.
>=20
> > ---
> >  hw/ppc/pnv_core.c | 56 ++++++++++++++++++-----------------------------
> >  1 file changed, 21 insertions(+), 35 deletions(-)
> >=20
> > diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> > index 59309e149c..c9648fd1ad 100644
> > --- a/hw/ppc/pnv_core.c
> > +++ b/hw/ppc/pnv_core.c
> > @@ -54,28 +54,6 @@ static void pnv_cpu_reset(void *opaque)
> >      env->msr |=3D MSR_HVB; /* Hypervisor mode */
> >  }
> > =20
> > -static void pnv_cpu_init(PowerPCCPU *cpu, Error **errp)
> > -{
> > -    CPUPPCState *env =3D &cpu->env;
> > -    int core_pir;
> > -    int thread_index =3D 0; /* TODO: TCG supports only one thread */
> > -    ppc_spr_t *pir =3D &env->spr_cb[SPR_PIR];
> > -
> > -    core_pir =3D object_property_get_uint(OBJECT(cpu), "core-pir", &er=
ror_abort);
> > -
> > -    /*
> > -     * The PIR of a thread is the core PIR + the thread index. We will
> > -     * need to find a way to get the thread index when TCG supports
> > -     * more than 1. We could use the object name ?
> > -     */
> > -    pir->default_value =3D core_pir + thread_index;
> > -
> > -    /* Set time-base frequency to 512 MHz */
> > -    cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
> > -
> > -    qemu_register_reset(pnv_cpu_reset, cpu);
> > -}
> > -
> >  /*
> >   * These values are read by the PowerNV HW monitors under Linux
> >   */
> > @@ -121,29 +99,39 @@ static const MemoryRegionOps pnv_core_xscom_ops =
=3D {
> >      .endianness =3D DEVICE_BIG_ENDIAN,
> >  };
> > =20
> > -static void pnv_core_realize_child(Object *child, XICSFabric *xi, Erro=
r **errp)
> > +static void pnv_realize_vcpu(PowerPCCPU *cpu, XICSFabric *xi, Error **=
errp)
> >  {
> > +    CPUPPCState *env =3D &cpu->env;
> > +    int core_pir;
> > +    int thread_index =3D 0; /* TODO: TCG supports only one thread */
> > +    ppc_spr_t *pir =3D &env->spr_cb[SPR_PIR];
> >      Error *local_err =3D NULL;
> > -    CPUState *cs =3D CPU(child);
> > -    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > =20
> > -    object_property_set_bool(child, true, "realized", &local_err);
> > +    object_property_set_bool(OBJECT(cpu), true, "realized", &local_err=
);
> >      if (local_err) {
> >          error_propagate(errp, local_err);
> >          return;
> >      }
> > =20
> > -    cpu->intc =3D icp_create(child, TYPE_PNV_ICP, xi, &local_err);
> > +    cpu->intc =3D icp_create(OBJECT(cpu), TYPE_PNV_ICP, xi, &local_err=
);
> >      if (local_err) {
> >          error_propagate(errp, local_err);
> >          return;
> >      }
> > =20
> > -    pnv_cpu_init(cpu, &local_err);
> > -    if (local_err) {
> > -        error_propagate(errp, local_err);
> > -        return;
> > -    }
> > +    core_pir =3D object_property_get_uint(OBJECT(cpu), "core-pir", &er=
ror_abort);
> > +
> > +    /*
> > +     * The PIR of a thread is the core PIR + the thread index. We will
> > +     * need to find a way to get the thread index when TCG supports
> > +     * more than 1. We could use the object name ?
> > +     */
> > +    pir->default_value =3D core_pir + thread_index;
> > +
> > +    /* Set time-base frequency to 512 MHz */
> > +    cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
> > +
> > +    qemu_register_reset(pnv_cpu_reset, cpu);
> >  }
> > =20
> >  static void pnv_core_realize(DeviceState *dev, Error **errp)
> > @@ -184,9 +172,7 @@ static void pnv_core_realize(DeviceState *dev, Erro=
r **errp)
> >      }
> > =20
> >      for (j =3D 0; j < cc->nr_threads; j++) {
> > -        obj =3D OBJECT(pc->threads[j]);
> > -
> > -        pnv_core_realize_child(obj, XICS_FABRIC(xi), &local_err);
> > +        pnv_realize_vcpu(pc->threads[j], XICS_FABRIC(xi), &local_err);
> >          if (local_err) {
> >              goto err;
> >          }
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--78WCQgNEg63vc82l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsg4HIACgkQbDjKyiDZ
s5LqPQ//QNhVECexwszE/7wNuSuLZvv032F46jIMMdRsRAtPKv5BIYIabpV8YZ9P
sENuskVsksqbAvXlYlbT/tXoyyLq3e2HQqKVqzLoNqyPgSu0vypfDpQk5aBYByUB
SrB6vBP5JaszX5yTdRqVhDKki1uDTS81bY6+MAM1S4k+beMoM8l+MPdOPNX9RzHE
x9En1X6E6V1psnozm0DzVCRy6JuNfZKIz93rou6MehPCMZGN8ePZPADkEhQbKdmz
ascA7vI5OsWirEbXLzCoTnsBXLjy98+WYEs8v5wK9BIxxpEkyNgp8c5T1PYJPeXA
MGbcu+/NENyscdQdRzQhxB4oAbnul6oqNgbi5zavwH3pCgV6ie7B2nznkVacQFJ7
cVy7fs1AQ62f6I3btZ5TXhPqBPbde1rz7y4w4PjAkHM4/D5BHccfUnND/wv8nb7d
wG2zkiXhnb2CjH0hJj3nEEy28xzEVMFkQoiNQZCHYfGMV26tHxGdiFUDPfHE8bIm
hXOiMYCGs0/3uf6YQMxe41C8MtfCKmfBSiP3ivaRpzZCGXr5Snfv5HeUqlruCn/a
O6ed7/xxBtAZAEzVxqqzfPTO6T2/YQjSmirnCaFqinvsfM7ShALoGrqKXH879EvM
RDZK4RD8lTokURxX8XpSFsyFaG+BsyrAkg5345Cbheh1WcVSf08=
=dbt8
-----END PGP SIGNATURE-----

--78WCQgNEg63vc82l--
