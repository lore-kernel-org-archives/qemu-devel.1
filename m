Received: from eggs.gnu.org ([2001:4830:134:3::10]:46392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzGPF-0007xb-Kd
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 02:10:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzGPC-0003rq-8y
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 02:10:13 -0400
Date: Tue, 3 Oct 2017 17:09:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171003060955.GG3260@umbus.fritz.box>
References: <150659494872.25889.2069124544245723984.stgit@aravinda>
	<150659506894.25889.3558250496380782854.stgit@aravinda>
	<20170929064929.GF7712@umbus.fritz.box>
	<911fd6ef-8931-aa40-8dbf-1d2dbb9ab800@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j2AXaZ4YhVcLc+PQ"
Content-Disposition: inline
In-Reply-To: <911fd6ef-8931-aa40-8dbf-1d2dbb9ab800@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/6] ppc: spapr: Handle "ibm,
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


--j2AXaZ4YhVcLc+PQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 03, 2017 at 11:21:27AM +0530, Aravinda Prasad wrote:
>=20
>=20
> On Friday 29 September 2017 12:19 PM, David Gibson wrote:
> > I don't suppose there's a way to stop your mailer from inserting
> > spaces after the commas in the subject line,
>=20
> Not sure how to stop the mailer from doing this as I don't have any
> spaces in the subject line of my actual patch.
>=20
> >=20
> >=20
> > On Thu, Sep 28, 2017 at 04:07:48PM +0530, Aravinda Prasad wrote:
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
> >>  include/hw/ppc/spapr.h |   11 ++++++++++-
> >>  3 files changed, 53 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index 5deae30..d568ea6 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -1477,6 +1477,11 @@ static void ppc_spapr_reset(void)
> >>      first_ppc_cpu->env.nip =3D SPAPR_ENTRY_POINT;
> >> =20
> >>      spapr->cas_reboot =3D false;
> >> +
> >> +    spapr->mc_status =3D -1;
> >> +    spapr->guest_machine_check_addr =3D 0;
> >=20
> > You should probably use -1 as the default for this - strictly speaking
> > the guest could legitimately choose to have it's machine check
> > processing code at 0, though it would be a strange choice.
>=20
> Sure.
>=20
> >=20
> >> +    qemu_cond_destroy(&spapr->mc_delivery_cond);
> >> +    qemu_cond_init(&spapr->mc_delivery_cond);
> >=20
> > What will this do if one of the vcpus is waiting on the condition
> > variable right now?  I suspect you're going to need to first wake up
> > the queue, and marshal any blocked vcpus back into dead mode instead
> > of this.
>=20
> Do we need to wake-up the queue as the system, anyway, is being
> reset?

The _virtual_ system is being reset.  These wait queues are in the
qemu process and exist outside the virtual system.  They won't be
reset with the virtual system unless we write the code to make them be
reset.


>=20
> >=20
> >>  }
> >> =20
> >>  static void spapr_create_nvram(sPAPRMachineState *spapr)
> >> @@ -2598,6 +2603,9 @@ static void ppc_spapr_init(MachineState *machine)
> >> =20
> >>          kvmppc_spapr_enable_inkernel_multitce();
> >>      }
> >> +
> >> +    spapr->mc_status =3D -1;
> >> +    qemu_cond_init(&spapr->mc_delivery_cond);
> >>  }
> >> =20
> >>  static int spapr_kvm_type(const char *vm_type)
> >> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> >> index cdf0b60..08e9a5e 100644
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
> >> +         * hence unset mc_status.
> >> +         */
> >> +        spapr->mc_status =3D -1;
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
> >> index b395aa7..28b6e2e 100644
> >> --- a/include/hw/ppc/spapr.h
> >> +++ b/include/hw/ppc/spapr.h
> >> @@ -124,6 +124,13 @@ struct sPAPRMachineState {
> >>       * occurs during the unplug process. */
> >>      QTAILQ_HEAD(, sPAPRDIMMState) pending_dimm_unplugs;
> >> =20
> >> +    /* State related to "ibm,nmi-register" and "ibm,nmi-interlock" ca=
lls */
> >> +    target_ulong guest_machine_check_addr;
> >=20
> > You need to migrate this.  This is separate and simpler from the
> > problems of migrating during machine check handling - at the moment if
> > the guest calls nmi-register, then you migrate, then a machine check
> > is triggered you will have lost the information on how to handle it
> > properly.
>=20
> I missed it. Will include.
>=20
> Regards,
> Aravinda
>=20
> >=20
> >=20
> >> +    /* mc_status is set to -1 if mc is not in progress, else is set t=
o the CPU
> >> +     * handling the mc. */
> >> +    int mc_status;
> >> +    QemuCond mc_delivery_cond;
> >> +
> >>      /*< public >*/
> >>      char *kvm_type;
> >>      MemoryHotplugState hotplug_memory;
> >> @@ -520,8 +527,10 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, tar=
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

--j2AXaZ4YhVcLc+PQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnTKbMACgkQbDjKyiDZ
s5KOOxAAnqQU1ol/5snmkWfRKxMpqPxfWYGkF3Rqd0nrBTPzoaE/K8DN467Acn3o
DDR/TJDGcfGcvKA5bq4azCVoHjD39lefMsmSo0JbHIDzxLY5VWKws1B8YiDJ7518
BbXELPFR51NGixEHyVlp8pnW1W3aenC1iBn+y26mo0cAaNE1nKKqG+HwNCyOcZa+
U1RR2StyF55nZJH/FRwv9Lyvf1Yy2jOR6tFnR4CDnrdnvh+JueTROLUlKxSxiOd7
3nuy/b/OYDBnSYTsZHHUek5s5K8NVTJ/pJZVLkyItrlKN6IChmsJ7UBd/O7MJnbV
wileV4XSdJkYglDALublmcYFRN6NvhTACy9izuCzyVlJu/+LQH7h1QIjbEmqPpBd
Jjg4/1Ih2UuO+Eq/y26TiBZX/ZR90o2POmXLrxFGexI1fI7r2mYa9MNGeaCScAr+
r9zpRVmrpxaFuBxV60DzTDjACVsdxn86vY8hHyFydrRmiJcJ/TKsxNzoC6NDncl0
pN5AW7jGWPNV0jlw4UYPXgGX/8meNiND9U1fYo192k/xt4vSMwmXdl7MTP4ZevJu
V78by2cst+l6DPhBaq/eUdQImOpSjSb9L42KcOUI9D7nR1vEK4OsnpvBAq68FqgG
q9oX5ZNBobsldCgMcw7ZFZg5JDI+woZRB28RYLpcOOF9u1nqka4=
=DZBD
-----END PGP SIGNATURE-----

--j2AXaZ4YhVcLc+PQ--
