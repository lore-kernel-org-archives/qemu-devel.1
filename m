Received: from eggs.gnu.org ([2001:4830:134:3::10]:49428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1djzwp-0005l2-JW
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 23:33:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1djzwn-0003h8-6i
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 23:33:47 -0400
Date: Tue, 22 Aug 2017 12:08:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170822020854.GY12356@umbus.fritz.box>
References: <150287457293.9760.17827532208744487789.stgit@aravinda>
	<150287474187.9760.12052550430995757993.stgit@aravinda>
	<20170817013934.GC5509@umbus.fritz.box>
	<555e187e-38af-d897-85b7-f08364b264fd@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0pkK7MCEo5hACTvx"
Content-Disposition: inline
In-Reply-To: <555e187e-38af-d897-85b7-f08364b264fd@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/5] ppc: spapr: Handle "ibm,
 nmi-register" and "ibm, nmi-interlock" RTAS calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, mahesh@linux.vnet.ibm.com, benh@au1.ibm.com, paulus@samba.org, sam.bobroff@au1.ibm.com


--0pkK7MCEo5hACTvx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2017 at 06:05:34PM +0530, Aravinda Prasad wrote:
>=20
>=20
> On Thursday 17 August 2017 07:09 AM, David Gibson wrote:
> > What's with the extra spaces in the subject line?
>=20
> I don't see any. Can you pls point out?

I see "ibm, nmi-register" and "ibm, nmi-interlock"

>=20
> >=20
> > On Wed, Aug 16, 2017 at 02:42:21PM +0530, Aravinda Prasad wrote:
> >> This patch adds support in QEMU to handle "ibm,nmi-register"
> >> and "ibm,nmi-interlock" RTAS calls.
> >>
> >> The machine check notification address is saved when the
> >> OS issues "ibm,nmi-register" RTAS call.
> >>
> >> This patch also handles the case when multiple processors
> >> experience machine check at or about the same time by
> >> handling "ibm,nmi-interlock" call. In such cases, as per
> >> PAPR, subsequent processors serialize waiting for the first
> >> processor to issue the "ibm,nmi-interlock" call. The second
> >> processor waits till the first processor, which also
> >> received a machine check error, is done reading the error
> >> log. The first processor issues "ibm,nmi-interlock" call
> >> when the error log is consumed. This patch implements the
> >> releasing part of the error-log while subsequent patch
> >> (which builds error log) handles the locking part.
> >>
> >> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> >> ---
> >>  hw/ppc/spapr.c         |    8 ++++++++
> >>  hw/ppc/spapr_rtas.c    |   35 +++++++++++++++++++++++++++++++++++
> >>  include/hw/ppc/spapr.h |   10 +++++++++-
> >>  3 files changed, 52 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index 2a3e53d..0bb2c4a 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -1441,6 +1441,11 @@ static void ppc_spapr_reset(void)
> >>      first_ppc_cpu->env.nip =3D SPAPR_ENTRY_POINT;
> >> =20
> >>      spapr->cas_reboot =3D false;
> >> +
> >> +    spapr->mc_in_progress =3D false;
> >> +    spapr->guest_machine_check_addr =3D 0;
> >> +    qemu_cond_destroy(&spapr->mc_delivery_cond);
> >> +    qemu_cond_init(&spapr->mc_delivery_cond);
> >>  }
> >> =20
> >>  static void spapr_create_nvram(sPAPRMachineState *spapr)
> >> @@ -2491,6 +2496,9 @@ static void ppc_spapr_init(MachineState *machine)
> >> =20
> >>          kvmppc_spapr_enable_inkernel_multitce();
> >>      }
> >> +
> >> +    spapr->mc_in_progress =3D false;
> >> +    qemu_cond_init(&spapr->mc_delivery_cond);
> >>  }
> >> =20
> >>  static int spapr_kvm_type(const char *vm_type)
> >> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> >> index 94a2799..2f3c47b 100644
> >> --- a/hw/ppc/spapr_rtas.c
> >> +++ b/hw/ppc/spapr_rtas.c
> >> @@ -348,6 +348,37 @@ static void rtas_get_power_level(PowerPCCPU *cpu,=
 sPAPRMachineState *spapr,
> >>      rtas_st(rets, 1, 100);
> >>  }
> >> =20
> >> +static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
> >> +                                  sPAPRMachineState *spapr,
> >> +                                  uint32_t token, uint32_t nargs,
> >> +                                  target_ulong args,
> >> +                                  uint32_t nret, target_ulong rets)
> >> +{
> >> +    spapr->guest_machine_check_addr =3D rtas_ld(args, 1);
> >> +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> >> +}
> >> +
> >> +static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
> >> +                                   sPAPRMachineState *spapr,
> >> +                                   uint32_t token, uint32_t nargs,
> >> +                                   target_ulong args,
> >> +                                   uint32_t nret, target_ulong rets)
> >> +{
> >> +    if (!spapr->guest_machine_check_addr) {
> >> +        /* NMI register not called */
> >> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> >> +    } else {
> >> +        /*
> >> +         * VCPU issuing "ibm,nmi-interlock" is done with NMI handling,
> >> +         * hence unset mc_in_progress.
> >> +         */
> >> +        spapr->mc_in_progress =3D false;
> >> +        qemu_cond_signal(&spapr->mc_delivery_cond);
> >> +        rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> >> +    }
> >> +}
> >> +
> >> +
> >>  static struct rtas_call {
> >>      const char *name;
> >>      spapr_rtas_fn fn;
> >> @@ -489,6 +520,10 @@ static void core_rtas_register_types(void)
> >>                          rtas_set_power_level);
> >>      spapr_rtas_register(RTAS_GET_POWER_LEVEL, "get-power-level",
> >>                          rtas_get_power_level);
> >> +    spapr_rtas_register(RTAS_IBM_NMI_REGISTER, "ibm,nmi-register",
> >> +                        rtas_ibm_nmi_register);
> >> +    spapr_rtas_register(RTAS_IBM_NMI_INTERLOCK, "ibm,nmi-interlock",
> >> +                        rtas_ibm_nmi_interlock);
> >>  }
> >> =20
> >>  type_init(core_rtas_register_types)
> >> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> >> index 46012b3..eee8d33 100644
> >> --- a/include/hw/ppc/spapr.h
> >> +++ b/include/hw/ppc/spapr.h
> >> @@ -123,6 +123,12 @@ struct sPAPRMachineState {
> >>       * occurs during the unplug process. */
> >>      QTAILQ_HEAD(, sPAPRDIMMState) pending_dimm_unplugs;
> >> =20
> >> +    /* State related to "ibm,nmi-register" and "ibm,nmi-interlock" ca=
lls */
> >> +    target_ulong guest_machine_check_addr;
> >> +    bool mc_in_progress;
> >> +    int mc_cpu;
> >=20
> > mc_cpu isn't actually used yet in this patch.  In any case it and
> > mc_in_progress could probably be folded together, no?
>=20
> It is possible to fold mc_cpu and mc_in_progress together with the
> convention that if it is set to -1 mc is not in progress otherwise it is
> set to the CPU handling the mc.
>=20
> >=20
> > These values will also need to be migrated, AFAICT.
>=20
> I am thinking of how to handle the migration when machine check handling
> is in progress. Probably wait for machine check handling to complete
> before migrating as the error could be irrelevant once migrated to a new
> hardware. If that is the case we don't need to migrate these values.

Ok.

>=20
> Regards,
> Aravinda
>=20
> >=20
> >> +    QemuCond mc_delivery_cond;
> >> +
> >>      /*< public >*/
> >>      char *kvm_type;
> >>      MemoryHotplugState hotplug_memory;
> >> @@ -519,8 +525,10 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, tar=
get_ulong opcode,
> >>  #define RTAS_IBM_CREATE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x=
27)
> >>  #define RTAS_IBM_REMOVE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x=
28)
> >>  #define RTAS_IBM_RESET_PE_DMA_WINDOW            (RTAS_TOKEN_BASE + 0x=
29)
> >> +#define RTAS_IBM_NMI_REGISTER                   (RTAS_TOKEN_BASE + 0x=
2A)
> >> +#define RTAS_IBM_NMI_INTERLOCK                  (RTAS_TOKEN_BASE + 0x=
2B)
> >> =20
> >> -#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x=
2A)
> >> +#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x=
2C)
> >> =20
> >>  /* RTAS ibm,get-system-parameter token values */
> >>  #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
> >>
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0pkK7MCEo5hACTvx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmbkjYACgkQbDjKyiDZ
s5IFCQ//TWJvbaIVws+Em5wrJyMsj1rtaBbM2q/tw1gLtR0Ezk85DR2Igi1Pwi20
fVApt4aL7omuq+5wZ2IFcqr0vL1E+nxbW1Qbh91pCkBiYeRpb9Waa/GGPtwO5apy
qT4Nc7nOvt1E4G1t6+J9DTvqrnCLJ2Twr/0M8yhJ9Z2tjOA5P2bAjtrBNtN4LsaM
UUddM/B7D8+YeQ318le679QRcpU86Z//dcEigE1ifxfyEm0xIm6PJaOfTEaGV/JK
axUvnwJgijYbYRbYwwAN8Z1oYMb46u2M8mftMDPtHk4I1+E7iWpdX/+MsbpFdX8o
Ykt/uu3XshfXkkGePQFW6AcnzWHg8w09X3Jnx302G64GtfSBR2wvwnqrXVTuxxUy
toS0HRr//XvlY6D6aazyenivSz7g/gTgX5mhLcoPFjc0V3oAwK3SZNfc7FpIZxaI
jIvlIOS4gCX7/npNlPXf0YtFrVEY8HQx/ZImdVTPAsGd8RQ1dITcw7Bt6lMUOGVm
w3vyhM5Uan0FWFbcZAG5FEr9v0LkWW11huVKuKe9ibITVHAmD6VSOnUK00+LNVmu
6JFGpYvE+CZ51Hi8vOg+HMYKHTsl8rzi4gnUPI6ZYvTsggu25EZAO5i6kZDlieif
ISltUkEztqPoesK7S5XfO7FFMurGzu/DV6dj6YVjhpjQkp4HD+g=
=mboB
-----END PGP SIGNATURE-----

--0pkK7MCEo5hACTvx--
