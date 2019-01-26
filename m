Received: from eggs.gnu.org ([209.51.188.92]:46559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gnZIs-0005ad-7a
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 20:32:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gnZIr-00021r-6P
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 20:32:06 -0500
Date: Sat, 26 Jan 2019 15:37:12 +1300
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190126023712.GG22942@umbus>
References: <20190117075327.22194-1-clg@kaod.org>
	<20190117075327.22194-3-clg@kaod.org>
	<20190117091302.1d46e737@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V32M1hWVjliPHW+c"
Content-Disposition: inline
In-Reply-To: <20190117091302.1d46e737@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 2/4] ppc/pnv: introduce a CPU machine_data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--V32M1hWVjliPHW+c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2019 at 09:13:02AM +0100, Greg Kurz wrote:
> On Thu, 17 Jan 2019 08:53:25 +0100
> C=E9dric Le Goater <clg@kaod.org> wrote:
>=20
> > Include the interrupt presenter under the machine_data as we plan to
> > remove it from under PowerPCCPU
> >=20
> > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > ---
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

>=20
> >  include/hw/ppc/pnv_core.h |  9 +++++++++
> >  hw/ppc/pnv.c              |  7 ++++---
> >  hw/ppc/pnv_core.c         | 12 +++++++++++-
> >  3 files changed, 24 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> > index 447ae761f7ae..9961ea3a92cd 100644
> > --- a/include/hw/ppc/pnv_core.h
> > +++ b/include/hw/ppc/pnv_core.h
> > @@ -47,4 +47,13 @@ typedef struct PnvCoreClass {
> >  #define PNV_CORE_TYPE_SUFFIX "-" TYPE_PNV_CORE
> >  #define PNV_CORE_TYPE_NAME(cpu_model) cpu_model PNV_CORE_TYPE_SUFFIX
> > =20
> > +typedef struct PnvCPUState {
> > +    struct ICPState *icp;
> > +} PnvCPUState;
> > +
> > +static inline PnvCPUState *pnv_cpu_state(PowerPCCPU *cpu)
> > +{
> > +    return (PnvCPUState *)cpu->machine_data;
> > +}
> > +
> >  #endif /* _PPC_PNV_CORE_H */
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index d84acef55b69..da540860a2b0 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -673,6 +673,7 @@ static void pnv_chip_power8_intc_create(PnvChip *ch=
ip, PowerPCCPU *cpu,
> >  {
> >      Error *local_err =3D NULL;
> >      Object *obj;
> > +    PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
> > =20
> >      obj =3D icp_create(OBJECT(cpu), TYPE_PNV_ICP, XICS_FABRIC(qdev_get=
_machine()),
> >                       &local_err);
> > @@ -681,7 +682,7 @@ static void pnv_chip_power8_intc_create(PnvChip *ch=
ip, PowerPCCPU *cpu,
> >          return;
> >      }
> > =20
> > -    cpu->icp =3D ICP(obj);
> > +    pnv_cpu->icp =3D ICP(obj);
> >  }
> > =20
> >  /*
> > @@ -1099,7 +1100,7 @@ static ICPState *pnv_icp_get(XICSFabric *xi, int =
pir)
> >  {
> >      PowerPCCPU *cpu =3D ppc_get_vcpu_by_pir(pir);
> > =20
> > -    return cpu ? cpu->icp : NULL;
> > +    return cpu ? pnv_cpu_state(cpu)->icp : NULL;
> >  }
> > =20
> >  static void pnv_pic_print_info(InterruptStatsProvider *obj,
> > @@ -1112,7 +1113,7 @@ static void pnv_pic_print_info(InterruptStatsProv=
ider *obj,
> >      CPU_FOREACH(cs) {
> >          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > =20
> > -        icp_pic_print_info(cpu->icp, mon);
> > +        icp_pic_print_info(pnv_cpu_state(cpu)->icp, mon);
> >      }
> > =20
> >      for (i =3D 0; i < pnv->num_chips; i++) {
> > diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> > index b98f277f1e02..7c806da720c6 100644
> > --- a/hw/ppc/pnv_core.c
> > +++ b/hw/ppc/pnv_core.c
> > @@ -155,7 +155,10 @@ static void pnv_core_realize(DeviceState *dev, Err=
or **errp)
> > =20
> >      pc->threads =3D g_new(PowerPCCPU *, cc->nr_threads);
> >      for (i =3D 0; i < cc->nr_threads; i++) {
> > +        PowerPCCPU *cpu;
> > +
> >          obj =3D object_new(typename);
> > +        cpu =3D POWERPC_CPU(obj);
> > =20
> >          pc->threads[i] =3D POWERPC_CPU(obj);
> > =20
> > @@ -163,6 +166,9 @@ static void pnv_core_realize(DeviceState *dev, Erro=
r **errp)
> >          object_property_add_child(OBJECT(pc), name, obj, &error_abort);
> >          object_property_add_alias(obj, "core-pir", OBJECT(pc),
> >                                    "pir", &error_abort);
> > +
> > +        cpu->machine_data =3D g_new0(PnvCPUState, 1);
> > +
> >          object_unref(obj);
> >      }
> > =20
> > @@ -189,9 +195,13 @@ err:
> > =20
> >  static void pnv_unrealize_vcpu(PowerPCCPU *cpu)
> >  {
> > +    PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
> > +
> >      qemu_unregister_reset(pnv_cpu_reset, cpu);
> > -    object_unparent(OBJECT(cpu->icp));
> > +    object_unparent(OBJECT(pnv_cpu_state(cpu)->icp));
> >      cpu_remove_sync(CPU(cpu));
> > +    cpu->machine_data =3D NULL;
> > +    g_free(pnv_cpu);
> >      object_unparent(OBJECT(cpu));
> >  }
> > =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--V32M1hWVjliPHW+c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxLx9gACgkQbDjKyiDZ
s5LeqA/+I25XDcosVwOae0sW9hp5cvYHolXC2ryCxc3sO34Vw/KEUTO73WH1OThJ
1ve2lISwarF7J0yHwzIGvE1pBKsAU0rZnz1W3VsTWlzLwQzYiaXGsH9y9crgTMWf
/NXv/DazKGhIEKY/xXCswk39gS/0hEvT67gWJuUbM8YYwU1g1Xcv5AlURpIrupaM
rL7jd3A2TANQuaj4PPdpG6yYz3U30zA8RWtMBXAsA96V7FkvVUMAo5kC9mGjVahg
aLzdupgqjuInxveaqq5njCvKaXBUIwq8sDEbUZ1mwG1E16uOXG2orX60+JpgJrIq
77XdmRkePHB2qAe0YhpDb9ZR//zPWc7/5XqMUJFZGva5McZSfurrZnGYQHOnriF7
k3HnFjxGWKot6dH4tiBo6CBcsJk3IU2NvITLX92YXJ28PXk4jZkrc5W5ZRASHlJU
0uz1HUlx6MVn8UiQw+wIzzqHAj9Erkm+clJjNoq0+daEBJVlgocy1+Hy38bw6F4+
GsO/fvKqlb4lX4exHH2eQPGnCEzLPyQNIhW8kMkQZ/rJK8RxMD55+XGQ1uCo9Yp8
2OPhUUN358qxHIWTeStnpmXV7fEEoNitxY/6tCXUXWsDcE0CpCyzL/7q+fmoGrZm
r0bOgtnkcf/6bgNf5y2SzOsTT3Wq65/huX0+28rDbthzLIExGEY=
=MxV9
-----END PGP SIGNATURE-----

--V32M1hWVjliPHW+c--
