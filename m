Received: from eggs.gnu.org ([2001:4830:134:3::10]:59739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ctOrx-0003NB-K3
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 21:27:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ctOru-00017U-GF
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 21:27:21 -0400
Date: Thu, 30 Mar 2017 12:26:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170330012616.GD21068@umbus.fritz.box>
References: <1490686352-24017-1-git-send-email-clg@kaod.org>
	<1490686352-24017-2-git-send-email-clg@kaod.org>
	<20170329041152.GV21068@umbus.fritz.box>
	<f472feaa-5c3f-0dfe-9b80-612614192d89@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dBTySC83OhS/t4p9"
Content-Disposition: inline
In-Reply-To: <f472feaa-5c3f-0dfe-9b80-612614192d89@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v3 1/8] ppc/xics: introduce an 'icp'
 backlink under PowerPCCPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--dBTySC83OhS/t4p9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 29, 2017 at 09:14:01AM +0200, C=E9dric Le Goater wrote:
> On 03/29/2017 06:11 AM, David Gibson wrote:
> > On Tue, Mar 28, 2017 at 09:32:25AM +0200, C=E9dric Le Goater wrote:
> >> Today, the ICPState array of the sPAPR machine is indexed with
> >> 'cpu_index' of the CPUState. This numbering of CPUs is internal to
> >> QEMU and the guest only knows about what is exposed in the device
> >> tree, that is the 'cpu_dt_id'. This is why sPAPR uses the helper
> >> xics_get_cpu_index_by_dt_id() to do the mapping in a couple of places.
> >>
> >> To provide a more generic XICS layer, we need to abstract the IRQ
> >> 'server' number and remove any assumption made on its nature. It
> >> should not be used as a 'cpu_index' for lookups like xics_cpu_setup()
> >> and xics_cpu_destroy() do.
> >>
> >> To reach that goal, we choose to introduce an 'icp' backlink under
> >> PowerPCCPU, and let the machine core init routine do the ICPState
> >> lookup. The resulting object is stored under PowerPCCPU which is
> >> passed on to xics_cpu_setup(). The IRQ 'server' number in XICS is now
> >> generic. sPAPR uses 'cpu_dt_id' and PowerNV will use 'PIR' number.
> >>
> >> This also has the benefit of simplifying the sPAPR hcall routines
> >> which do not need to do any ICPState lookups anymore.
> >=20
> > Since you've changed the type to a generic Object *, the name needs to
> > be changed to something generic as well.  Maybe 'intc' or
> > 'irq_private'.
>=20
> yes. I think 'intc' is a good choice, unless we make the type=20
> 'void *' and in that case 'irq_private' would be better.
>=20
> I took a quick look at the other machines under ppc. It is not=20
> obvious how we could use that 'intc' pointer. May be for the=20
> objects TYPE_OPENPIC and heathrow_pic.
>=20
> The ppc405 machines could use it to store 'qemu_irq *pic' but=20
> I am not sure there is much benefit doing that. To be studied.

Right.  I don't know that it will lead to any easy, quick conversions
of existing platforms.  It will mostly be of use for modern, high
performance type intcs (like XICS, or IO-APIC/LAPIC) - older style
simpler intcs may not have a use for it.  We'll probably want
something like it when we come to implement POWER9's XIVE, though.

>=20
> Anyhow I will change the name.
>=20
> Thanks,
>=20
> C.=20
>=20
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>
> >> Changes since v2:
> >>
> >>  - changed the 'icp' backlink type to be an 'Object'
> >>
> >>  hw/intc/xics.c          |  4 ++--
> >>  hw/intc/xics_spapr.c    | 20 +++++---------------
> >>  hw/ppc/spapr_cpu_core.c |  5 ++++-
> >>  target/ppc/cpu.h        |  1 +
> >>  4 files changed, 12 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> >> index e740989a1162..bb485cc5b078 100644
> >> --- a/hw/intc/xics.c
> >> +++ b/hw/intc/xics.c
> >> @@ -52,7 +52,7 @@ int xics_get_cpu_index_by_dt_id(int cpu_dt_id)
> >>  void xics_cpu_destroy(XICSFabric *xi, PowerPCCPU *cpu)
> >>  {
> >>      CPUState *cs =3D CPU(cpu);
> >> -    ICPState *icp =3D xics_icp_get(xi, cs->cpu_index);
> >> +    ICPState *icp =3D ICP(cpu->icp);
> >> =20
> >>      assert(icp);
> >>      assert(cs =3D=3D icp->cs);
> >> @@ -65,7 +65,7 @@ void xics_cpu_setup(XICSFabric *xi, PowerPCCPU *cpu)
> >>  {
> >>      CPUState *cs =3D CPU(cpu);
> >>      CPUPPCState *env =3D &cpu->env;
> >> -    ICPState *icp =3D xics_icp_get(xi, cs->cpu_index);
> >> +    ICPState *icp =3D ICP(cpu->icp);
> >>      ICPStateClass *icpc;
> >> =20
> >>      assert(icp);
> >> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> >> index 84d24b2837a7..6144f9876ae3 100644
> >> --- a/hw/intc/xics_spapr.c
> >> +++ b/hw/intc/xics_spapr.c
> >> @@ -43,11 +43,9 @@
> >>  static target_ulong h_cppr(PowerPCCPU *cpu, sPAPRMachineState *spapr,
> >>                             target_ulong opcode, target_ulong *args)
> >>  {
> >> -    CPUState *cs =3D CPU(cpu);
> >> -    ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), cs->cpu_index);
> >>      target_ulong cppr =3D args[0];
> >> =20
> >> -    icp_set_cppr(icp, cppr);
> >> +    icp_set_cppr(ICP(cpu->icp), cppr);
> >>      return H_SUCCESS;
> >>  }
> >> =20
> >> @@ -69,9 +67,7 @@ static target_ulong h_ipi(PowerPCCPU *cpu, sPAPRMach=
ineState *spapr,
> >>  static target_ulong h_xirr(PowerPCCPU *cpu, sPAPRMachineState *spapr,
> >>                             target_ulong opcode, target_ulong *args)
> >>  {
> >> -    CPUState *cs =3D CPU(cpu);
> >> -    ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), cs->cpu_index);
> >> -    uint32_t xirr =3D icp_accept(icp);
> >> +    uint32_t xirr =3D icp_accept(ICP(cpu->icp));
> >> =20
> >>      args[0] =3D xirr;
> >>      return H_SUCCESS;
> >> @@ -80,9 +76,7 @@ static target_ulong h_xirr(PowerPCCPU *cpu, sPAPRMac=
hineState *spapr,
> >>  static target_ulong h_xirr_x(PowerPCCPU *cpu, sPAPRMachineState *spap=
r,
> >>                               target_ulong opcode, target_ulong *args)
> >>  {
> >> -    CPUState *cs =3D CPU(cpu);
> >> -    ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), cs->cpu_index);
> >> -    uint32_t xirr =3D icp_accept(icp);
> >> +    uint32_t xirr =3D icp_accept(ICP(cpu->icp));
> >> =20
> >>      args[0] =3D xirr;
> >>      args[1] =3D cpu_get_host_ticks();
> >> @@ -92,21 +86,17 @@ static target_ulong h_xirr_x(PowerPCCPU *cpu, sPAP=
RMachineState *spapr,
> >>  static target_ulong h_eoi(PowerPCCPU *cpu, sPAPRMachineState *spapr,
> >>                            target_ulong opcode, target_ulong *args)
> >>  {
> >> -    CPUState *cs =3D CPU(cpu);
> >> -    ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), cs->cpu_index);
> >>      target_ulong xirr =3D args[0];
> >> =20
> >> -    icp_eoi(icp, xirr);
> >> +    icp_eoi(ICP(cpu->icp), xirr);
> >>      return H_SUCCESS;
> >>  }
> >> =20
> >>  static target_ulong h_ipoll(PowerPCCPU *cpu, sPAPRMachineState *spapr,
> >>                              target_ulong opcode, target_ulong *args)
> >>  {
> >> -    CPUState *cs =3D CPU(cpu);
> >> -    ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), cs->cpu_index);
> >>      uint32_t mfrr;
> >> -    uint32_t xirr =3D icp_ipoll(icp, &mfrr);
> >> +    uint32_t xirr =3D icp_ipoll(ICP(cpu->icp), &mfrr);
> >> =20
> >>      args[0] =3D xirr;
> >>      args[1] =3D mfrr;
> >> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> >> index 6883f0991ae9..f9ca3f09a0f8 100644
> >> --- a/hw/ppc/spapr_cpu_core.c
> >> +++ b/hw/ppc/spapr_cpu_core.c
> >> @@ -63,6 +63,8 @@ static void spapr_cpu_init(sPAPRMachineState *spapr,=
 PowerPCCPU *cpu,
> >>                             Error **errp)
> >>  {
> >>      CPUPPCState *env =3D &cpu->env;
> >> +    XICSFabric *xi =3D XICS_FABRIC(spapr);
> >> +    ICPState *icp =3D xics_icp_get(xi, CPU(cpu)->cpu_index);
> >> =20
> >>      /* Set time-base frequency to 512 MHz */
> >>      cpu_ppc_tb_init(env, SPAPR_TIMEBASE_FREQ);
> >> @@ -80,7 +82,8 @@ static void spapr_cpu_init(sPAPRMachineState *spapr,=
 PowerPCCPU *cpu,
> >>          }
> >>      }
> >> =20
> >> -    xics_cpu_setup(XICS_FABRIC(spapr), cpu);
> >> +    cpu->icp =3D OBJECT(icp);
> >> +    xics_cpu_setup(xi, cpu);
> >> =20
> >>      qemu_register_reset(spapr_cpu_reset, cpu);
> >>      spapr_cpu_reset(cpu);
> >> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> >> index 5ee33b3fd315..774f2d717831 100644
> >> --- a/target/ppc/cpu.h
> >> +++ b/target/ppc/cpu.h
> >> @@ -1196,6 +1196,7 @@ struct PowerPCCPU {
> >>      uint32_t max_compat;
> >>      uint32_t compat_pvr;
> >>      PPCVirtualHypervisor *vhyp;
> >> +    Object *icp;
> >> =20
> >>      /* Fields related to migration compatibility hacks */
> >>      bool pre_2_8_migration;
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dBTySC83OhS/t4p9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY3F62AAoJEGw4ysog2bOSgZMQANtw+wD4i1QwjTL4RtIc+obe
HVK+wlDw9bc3+zcJBxr5iDGep0SjeF3znEGPmOMADa3zk1Ojb3AxSMycEw3B64cY
vsYaxbbqRibuCg48+WatJxQt9Dp9tEVvgunfGbMKKyEPTVdUYJ8TURRfHtDjxYEo
8z/IChZ7LiH3t2SVU+g1gE8BM0ZrVB0RkwrXzvov+VdbSQnr8r9y/msByN//RQeK
MCdwazyh6lzgVPc3K0wLtc0DF8KQygM1RwDxlGzI78y/GVOyODrrmtoy2vZqTq4z
MnF+DuvAnnagHyLltpMQeZ69FdEbIjRCWe2mv1hkROhg4D5xl9eDY7hAfDdbf98z
QANrSMchZPDlS1sCcD1B/Amu1ofdxn6/80hQm4h8+JwzEAL2trSCHgCjkA2wTpoM
nYVubNSBw3+1be5VsywciNcjTmLhWEZ0Qeho9yv/uXhlCgWHxq2r0NUHnQcZePII
61RC5RzzISdnuZo2qlhOF4o2lIJe/gKTv8ELkHNrAmJ56RoxESaocsv8tX/lVmF4
QsxZ5bd/rlpb8pT9orlktzwy4r/lnwglB8dRMXpD+ST4pALWSI8aXkMk+XKf5zA7
m2ul9AzArO3mxl4/miXcR+72qzIeaDDam0nrh5NY9BFEB2W81SznMZ5zxtfSUdsU
H9Bvqhn2uQaQjmpQaA90
=NsYQ
-----END PGP SIGNATURE-----

--dBTySC83OhS/t4p9--
