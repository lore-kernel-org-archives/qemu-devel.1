Received: from eggs.gnu.org ([2001:4830:134:3::10]:51407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dCzt8-0000Vr-0y
	for qemu-devel@nongnu.org; Mon, 22 May 2017 22:49:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dCzt6-0007hu-G1
	for qemu-devel@nongnu.org; Mon, 22 May 2017 22:49:34 -0400
Date: Tue, 23 May 2017 12:35:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170523023554.GQ30246@umbus.fritz.box>
References: <149518991537.24289.6673616934370284758.stgit@bahia.lan>
	<149518994010.24289.12584852638589552255.stgit@bahia.lan>
	<20170522020413.GF30246@umbus.fritz.box>
	<20170522105950.4af008c1@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jsrFa/5v3cIbBmG8"
Content-Disposition: inline
In-Reply-To: <20170522105950.4af008c1@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] target/ppc: consolidate CPU
 device-tree id computation in helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Cedric Le Goater <clg@kaod.org>


--jsrFa/5v3cIbBmG8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2017 at 10:59:50AM +0200, Greg Kurz wrote:
> On Mon, 22 May 2017 12:04:13 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Fri, May 19, 2017 at 12:32:20PM +0200, Greg Kurz wrote:
> > > For historical reasons, we compute CPU device-tree ids with a non-tri=
vial
> > > logic. This patch consolidate the logic in a single helper to be used
> > > in various places where it is currently open-coded.
> > >=20
> > > It is okay to get rid of DIV_ROUND_UP() because we're sure that the n=
umber
> > > of threads per core in the guest cannot exceed the number of threads =
per
> > > core in the host. =20
> >=20
> > However, your new logic still gives different answers in some cases.
> > In particular when max_cpus is not a multiple of smp_threads.  Which
> > is generally a bad idea, but allowed for older machine types for
> > compatibility.   e.g. smp_threads=3D4, max_cpus=3D6 smt=3D8
> >=20
> > Old logic:
> > 	         DIV_ROUND_UP(6 * 8, 4)
> > 	       =3D =E2=8C=8848 / 4=E2=8C=89 =3D 12
> >=20
> > New logic gives: =E2=8C=8A6 / 4=E2=8C=8B * 8 + (6 % 4)
> >                =3D 1 * 8 + 2
> > 	       =3D 10
> >=20
>=20
> I now realize this two formulas are hardly reconcilable... this
> probably means that this patch shouldn't try to consolidate the
> logic in hw/ppc/spapr.c with the one in target/ppc/translate_init.c.

Ok.

> > In any case the DIV_ROUND_UP() isn't to handle the case where guest
> > threads-per-core is bigger than host threads-per-core, it's (IIRC) for
> > the case where guest threads-per-core is not a factor of host
> > threads-per-core.  Again, a bad idea, but I think allowed in some old
> > cases.
> >=20
>=20
> FWIW, DIV_ROUND_UP() comes from this commit:
>=20
> f303f117fec3 spapr: ensure we have at least one XICS server

Ah, yes, I see your point.  Hrm.  I thought even then that guest
threads > host threads was definitely incorrect; but I'm wondering if
the change was just because the check for guest threads > host threads
came later during init and we didn't want to crash before we got to
it.

> but I agree that this was a bad idea...

But yeah, looks like we'll be taking a different approach so it's kind
of moot anyway.

>=20
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >  hw/ppc/spapr.c              |    6 ++----
> > >  target/ppc/cpu.h            |   17 +++++++++++++++++
> > >  target/ppc/translate_init.c |    3 +--
> > >  3 files changed, 20 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 75e298b4c6be..1bb05a9a6b07 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -981,7 +981,6 @@ static void *spapr_build_fdt(sPAPRMachineState *s=
papr,
> > >      void *fdt;
> > >      sPAPRPHBState *phb;
> > >      char *buf;
> > > -    int smt =3D kvmppc_smt_threads();
> > > =20
> > >      fdt =3D g_malloc0(FDT_MAX_SIZE);
> > >      _FDT((fdt_create_empty_tree(fdt, FDT_MAX_SIZE)));
> > > @@ -1021,7 +1020,7 @@ static void *spapr_build_fdt(sPAPRMachineState =
*spapr,
> > >      _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
> > > =20
> > >      /* /interrupt controller */
> > > -    spapr_dt_xics(DIV_ROUND_UP(max_cpus * smt, smp_threads), fdt, PH=
ANDLE_XICP);
> > > +    spapr_dt_xics(ppc_cpu_dt_id_from_index(max_cpus), fdt, PHANDLE_X=
ICP);
> > > =20
> > >      ret =3D spapr_populate_memory(spapr, fdt);
> > >      if (ret < 0) {
> > > @@ -1977,7 +1976,6 @@ static void spapr_init_cpus(sPAPRMachineState *=
spapr)
> > >      MachineState *machine =3D MACHINE(spapr);
> > >      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> > >      char *type =3D spapr_get_cpu_core_type(machine->cpu_model);
> > > -    int smt =3D kvmppc_smt_threads();
> > >      const CPUArchIdList *possible_cpus;
> > >      int boot_cores_nr =3D smp_cpus / smp_threads;
> > >      int i;
> > > @@ -2014,7 +2012,7 @@ static void spapr_init_cpus(sPAPRMachineState *=
spapr)
> > >              sPAPRDRConnector *drc =3D
> > >                  spapr_dr_connector_new(OBJECT(spapr),
> > >                                         SPAPR_DR_CONNECTOR_TYPE_CPU,
> > > -                                       (core_id / smp_threads) * smt=
);
> > > +                                       ppc_cpu_dt_id_from_index(core=
_id));
> > > =20
> > >              qemu_register_reset(spapr_drc_reset, drc);
> > >          }
> > > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > > index 401e10e7dad8..47fe6c64698f 100644
> > > --- a/target/ppc/cpu.h
> > > +++ b/target/ppc/cpu.h
> > > @@ -2529,4 +2529,21 @@ int ppc_get_vcpu_dt_id(PowerPCCPU *cpu);
> > >  PowerPCCPU *ppc_get_vcpu_by_dt_id(int cpu_dt_id);
> > > =20
> > >  void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, in=
t len);
> > > +
> > > +#if !defined(CONFIG_USER_ONLY)
> > > +#include "sysemu/cpus.h"
> > > +#include "target/ppc/kvm_ppc.h"
> > > +
> > > +static inline int ppc_cpu_dt_id_from_index(int cpu_index)
> > > +{
> > > +    /* POWER HV support has an historical limitation that different =
threads
> > > +     * on a single core cannot be in different guests at the same ti=
me. In
> > > +     * order to allow KVM to assign guest threads to host cores acco=
rdingly,
> > > +     * CPU device tree ids are spaced by the number of threads per h=
ost cores.
> > > +     */
> > > +    return (cpu_index / smp_threads) * kvmppc_smt_threads()
> > > +        + (cpu_index % smp_threads);
> > > +}
> > > +#endif
> > > +
> > >  #endif /* PPC_CPU_H */
> > > diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> > > index 56a0ab22cfbe..837a9a496a65 100644
> > > --- a/target/ppc/translate_init.c
> > > +++ b/target/ppc/translate_init.c
> > > @@ -9851,8 +9851,7 @@ static void ppc_cpu_realizefn(DeviceState *dev,=
 Error **errp)
> > >      }
> > > =20
> > >  #if !defined(CONFIG_USER_ONLY)
> > > -    cpu->cpu_dt_id =3D (cs->cpu_index / smp_threads) * max_smt
> > > -        + (cs->cpu_index % smp_threads);
> > > +    cpu->cpu_dt_id =3D ppc_cpu_dt_id_from_index(cs->cpu_index);
> > > =20
> > >      if (kvm_enabled() && !kvm_vcpu_id_is_valid(cpu->cpu_dt_id)) {
> > >          error_setg(errp, "Can't create CPU with id %d in KVM", cpu->=
cpu_dt_id);
> > >  =20
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jsrFa/5v3cIbBmG8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZI6AIAAoJEGw4ysog2bOS3wUQAM41xTl/xLDeOb6gZ9TAzNl5
KewsGi97dkcNYDzV6ddUV6lLR+rYyOMI4Cz6cQVDUBOl/fE3xfrtpylOE2xKTHOW
aySRTvGDm/dkPQnO6AbKEr70aYTj0+g2ESU3vUayQ4ZzaX2R18WYWCEm9REV9owN
UmG/ZCF4s6Ew6adYfZLNGixCmPx7QMfhQmfi3zRqtSJVuMKpoFJFdb0Nz1mmVJuY
ncfSBtjCLjhbUT8XARTN+XETKP1slVVUO0Q2NdYNdJx8ploCEHrkJGQvCyMBwsuR
8kxXl8RVfbi1rS3lM5Cilcc6wBT3QaQYFGaVbqb+93w4wPAFnbSAnQ/n6wuH+NsI
cVd6SCbEi02B0sf3LEsqmRj0j0/IOEjg3GXxirbdgi+4PjlntY4PEWOt4X9CqkA9
2NqRH8YxMWMWCZ7Qk5DpKeONlG8Vk60ZTyRhevcTnsEYlN9mXWxeOINI6AsWQUqN
YdoJFU9XtdsNTfHMuqJq91g+rD3DaXKPrvJYQ3g8XrC7PhODytNYU7o1FoIFagEn
6/AB9OQPHF58c+J4wI3DWkk7tbP48UVrDAmkflEZqZrZJ9JWwnm3fGybVXGGa1KK
+3FGx0CYQtKUd6WSK1vg/rQSOaa+4UKEeA3Qa0nYKgjqY6Ly7fHjxbEa7rm77eOY
KHsFN2L8prVHgDxRLDOA
=xU6o
-----END PGP SIGNATURE-----

--jsrFa/5v3cIbBmG8--
