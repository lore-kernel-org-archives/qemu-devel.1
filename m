Received: from eggs.gnu.org ([2001:4830:134:3::10]:33124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fESzf-0000N7-Hv
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:10:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fESzb-00053t-C8
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:10:55 -0400
Date: Fri, 4 May 2018 15:01:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180504050143.GV13229@umbus.fritz.box>
References: <20180503062145.17899-1-david@gibson.dropbear.id.au>
	<20180503062145.17899-3-david@gibson.dropbear.id.au>
	<20180503171331.037e5917@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V8Y3+xXnhQGsvjWT"
Content-Disposition: inline
In-Reply-To: <20180503171331.037e5917@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 2/8] spapr: Clean up rtas_start_cpu() &
 rtas_stop_self()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: clg@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com


--V8Y3+xXnhQGsvjWT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 05:13:31PM +0200, Greg Kurz wrote:
> On Thu,  3 May 2018 16:21:39 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > This makes several minor cleanups to these functions:
> >   * Follow usual convention of an early exit on error, rather than havi=
ng
> >     most of the body in an if
> >   * Clearer naming of cpu and cpu_.  Now callcpu is the cpu from which =
the
> >     RTAS call is invoked, newcpu is the cpu which we're starting
> >   * Use cpu_synchronize_state() instead of kvm_cpu_synchronize_state()
> >     directly
> >   * Remove pointless comment describing what cpu_synchronize_state() do=
es
> >   * Use ppc_store_lpcr() instead of directly writing the register field
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr_rtas.c | 66 ++++++++++++++++++++++-----------------------
> >  1 file changed, 32 insertions(+), 34 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> > index 0ec5fa4cfe..b251c130cb 100644
> > --- a/hw/ppc/spapr_rtas.c
> > +++ b/hw/ppc/spapr_rtas.c
> > @@ -32,7 +32,7 @@
> >  #include "hw/qdev.h"
> >  #include "sysemu/device_tree.h"
> >  #include "sysemu/cpus.h"
> > -#include "sysemu/kvm.h"
> > +#include "sysemu/hw_accel.h"
> > =20
> >  #include "hw/ppc/spapr.h"
> >  #include "hw/ppc/spapr_vio.h"
> > @@ -45,6 +45,7 @@
> >  #include "qemu/cutils.h"
> >  #include "trace.h"
> >  #include "hw/ppc/fdt.h"
> > +#include "target/ppc/mmu-hash64.h"
> > =20
> >  static void rtas_display_character(PowerPCCPU *cpu, sPAPRMachineState =
*spapr,
> >                                     uint32_t token, uint32_t nargs,
> > @@ -140,13 +141,15 @@ static void spapr_cpu_set_endianness(PowerPCCPU *=
cpu)
> >      }
> >  }
> > =20
> > -static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRMachineState *spapr,
> > +static void rtas_start_cpu(PowerPCCPU *callcpu, sPAPRMachineState *spa=
pr,
> >                             uint32_t token, uint32_t nargs,
> >                             target_ulong args,
> >                             uint32_t nret, target_ulong rets)
> >  {
> >      target_ulong id, start, r3;
> > -    PowerPCCPU *cpu;
> > +    PowerPCCPU *newcpu;
> > +    CPUPPCState *env;
> > +    PowerPCCPUClass *pcc;
> > =20
> >      if (nargs !=3D 3 || nret !=3D 1) {
> >          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> > @@ -157,41 +160,37 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAP=
RMachineState *spapr,
> >      start =3D rtas_ld(args, 1);
> >      r3 =3D rtas_ld(args, 2);
> > =20
> > -    cpu =3D spapr_find_cpu(id);
> > -    if (cpu !=3D NULL) {
> > -        CPUState *cs =3D CPU(cpu);
>=20
> The function ends up with four invocations of CPU(newcpu), ie, we'll
> go down the full type checking path four times. Not very painful since
> rtas_start_cpu() is not a hot path, but it would certainly not hurt
> to do it only once like the current code does.
>=20
> Anyway, with or without this change:

Ah, yeah, I was thinking of CPU() as a trivial offset, and forgot it
also did type checking.

Eh, as you say it's not a hot path and I don't really want to
introduce a fourth cpu parameter/variable so let's leave it as is.

>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> > -        CPUPPCState *env =3D &cpu->env;
> > -        PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> > +    newcpu =3D spapr_find_cpu(id);
> > +    if (!newcpu) {
> > +        /* Didn't find a matching cpu */
> > +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> > +        return;
> > +    }
> > =20
> > -        if (!cs->halted) {
> > -            rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> > -            return;
> > -        }
> > +    env =3D &newcpu->env;
> > +    pcc =3D POWERPC_CPU_GET_CLASS(newcpu);
> > =20
> > -        /* This will make sure qemu state is up to date with kvm, and
> > -         * mark it dirty so our changes get flushed back before the
> > -         * new cpu enters */
> > -        kvm_cpu_synchronize_state(cs);
> > +    if (!CPU(newcpu)->halted) {
> > +        rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> > +        return;
> > +    }
> > =20
> > -        env->msr =3D (1ULL << MSR_SF) | (1ULL << MSR_ME);
> > +    cpu_synchronize_state(CPU(newcpu));
> > =20
> > -        /* Enable Power-saving mode Exit Cause exceptions for the new =
CPU */
> > -        env->spr[SPR_LPCR] |=3D pcc->lpcr_pm;
> > +    env->msr =3D (1ULL << MSR_SF) | (1ULL << MSR_ME);
> > +    spapr_cpu_set_endianness(newcpu);
> > +    spapr_cpu_update_tb_offset(newcpu);
> > +    /* Enable Power-saving mode Exit Cause exceptions for the new CPU =
*/
> > +    ppc_store_lpcr(newcpu, env->spr[SPR_LPCR] | pcc->lpcr_pm);
> > =20
> > -        env->nip =3D start;
> > -        env->gpr[3] =3D r3;
> > -        cs->halted =3D 0;
> > -        spapr_cpu_set_endianness(cpu);
> > -        spapr_cpu_update_tb_offset(cpu);
> > +    env->nip =3D start;
> > +    env->gpr[3] =3D r3;
> > =20
> > -        qemu_cpu_kick(cs);
> > +    CPU(newcpu)->halted =3D 0;
> > =20
> > -        rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> > -        return;
> > -    }
> > +    qemu_cpu_kick(CPU(newcpu));
> > =20
> > -    /* Didn't find a matching cpu */
> > -    rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> > +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> >  }
> > =20
> >  static void rtas_stop_self(PowerPCCPU *cpu, sPAPRMachineState *spapr,
> > @@ -203,13 +202,12 @@ static void rtas_stop_self(PowerPCCPU *cpu, sPAPR=
MachineState *spapr,
> >      CPUPPCState *env =3D &cpu->env;
> >      PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> > =20
> > -    cs->halted =3D 1;
> > -    qemu_cpu_kick(cs);
> > -
> >      /* Disable Power-saving mode Exit Cause exceptions for the CPU.
> >       * This could deliver an interrupt on a dying CPU and crash the
> >       * guest */
> > -    env->spr[SPR_LPCR] &=3D ~pcc->lpcr_pm;
> > +    ppc_store_lpcr(cpu, env->spr[SPR_LPCR] & ~pcc->lpcr_pm);
> > +    cs->halted =3D 1;
> > +    qemu_cpu_kick(cs);
> >  }
> > =20
> >  static inline int sysparm_st(target_ulong addr, target_ulong len,
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--V8Y3+xXnhQGsvjWT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrr6TcACgkQbDjKyiDZ
s5IfsRAAnn4Sd0/+mzxWdwPhhs8LwBeq8M2LAKN/IGHAOOt8gMeb06i2vqN6qLSI
pEGyqtd2ogJvubpev8qVi8M2pSTUHd07Ik0WvsLmxvala9mwvUM5TBWEsQlwczwU
2yoXHejV/BW+un+WVF/Q3NEoyfUqmWfrwsPCx/+Zhn07Ak/4k+SBfrjnrbC7Yi09
JdR0Ma7S5fSmGSlXOBxuteSscRmKE03iXbD2hKoi5L46DJCEhjkaEytSbdhefkGI
0r7gvnk7K3Gz+slC/zawSjgZyRO92D8/C9FO+xyaTd1FI3SHfWTmvLFnNTB8iaXE
CzNzGxtTEbh5LT9Qij6KqW212VcbZVZ1nVyscf0JKjq8TyrE+bPvPaOmGXBTi0Tk
wbFrZLtsy2ZcxSe92qdKNP3Ovv4sLBlhDJejNIrJJNvriNCMzJ3HfhUf+D5LWDsT
nrAO6yWCKm6Ik11vmCf3jIz44Q/sS3uP4AxS5ulv1W2o181gdHMiFA3HD8mXWrAR
yseDVX+XT4zy44rPEoA9R8h07q4b7p5o5KpV2TEp8rb3f3bii5WatIc6z1UJlJhW
ndZjXx/zghxAiCi7Ik7+ue3p1vYcj8mVx8lZ/VKQQRHk+3GpwNkbyLS4Ug9ngw4W
lcwVXLF2zXYT1AjXVpFUQPSVgy3+RO4VOswQAWg/TDfIe+3K1dM=
=4X+d
-----END PGP SIGNATURE-----

--V8Y3+xXnhQGsvjWT--
