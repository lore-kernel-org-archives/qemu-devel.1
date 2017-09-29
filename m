Received: from eggs.gnu.org ([2001:4830:134:3::10]:38803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dxsDG-0007YE-4F
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 06:08:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dxsDC-00063F-T6
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 06:08:06 -0400
Date: Fri, 29 Sep 2017 16:49:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170929064929.GF7712@umbus.fritz.box>
References: <150659494872.25889.2069124544245723984.stgit@aravinda>
	<150659506894.25889.3558250496380782854.stgit@aravinda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rWhLK7VZz0iBluhq"
Content-Disposition: inline
In-Reply-To: <150659506894.25889.3558250496380782854.stgit@aravinda>
Subject: Re: [Qemu-devel] [PATCH v5 2/6] ppc: spapr: Handle "ibm,
 nmi-register" and "ibm, nmi-interlock" RTAS calls
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, mahesh@linux.vnet.ibm.com, benh@au1.ibm.com, paulus@samba.org, sam.bobroff@au1.ibm.com
List-ID: <qemu-devel.nongnu.org>


--rWhLK7VZz0iBluhq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I don't suppose there's a way to stop your mailer from inserting
spaces after the commas in the subject line,


On Thu, Sep 28, 2017 at 04:07:48PM +0530, Aravinda Prasad wrote:
> This patch adds support in QEMU to handle "ibm,nmi-register"
> and "ibm,nmi-interlock" RTAS calls.
>=20
> The machine check notification address is saved when the
> OS issues "ibm,nmi-register" RTAS call.
>=20
> This patch also handles the case when multiple processors
> experience machine check at or about the same time by
> handling "ibm,nmi-interlock" call. In such cases, as per
> PAPR, subsequent processors serialize waiting for the first
> processor to issue the "ibm,nmi-interlock" call. The second
> processor waits till the first processor, which also
> received a machine check error, is done reading the error
> log. The first processor issues "ibm,nmi-interlock" call
> when the error log is consumed. This patch implements the
> releasing part of the error-log while subsequent patch
> (which builds error log) handles the locking part.
>=20
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr.c         |    8 ++++++++
>  hw/ppc/spapr_rtas.c    |   35 +++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h |   11 ++++++++++-
>  3 files changed, 53 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 5deae30..d568ea6 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1477,6 +1477,11 @@ static void ppc_spapr_reset(void)
>      first_ppc_cpu->env.nip =3D SPAPR_ENTRY_POINT;
> =20
>      spapr->cas_reboot =3D false;
> +
> +    spapr->mc_status =3D -1;
> +    spapr->guest_machine_check_addr =3D 0;

You should probably use -1 as the default for this - strictly speaking
the guest could legitimately choose to have it's machine check
processing code at 0, though it would be a strange choice.

> +    qemu_cond_destroy(&spapr->mc_delivery_cond);
> +    qemu_cond_init(&spapr->mc_delivery_cond);

What will this do if one of the vcpus is waiting on the condition
variable right now?  I suspect you're going to need to first wake up
the queue, and marshal any blocked vcpus back into dead mode instead
of this.

>  }
> =20
>  static void spapr_create_nvram(sPAPRMachineState *spapr)
> @@ -2598,6 +2603,9 @@ static void ppc_spapr_init(MachineState *machine)
> =20
>          kvmppc_spapr_enable_inkernel_multitce();
>      }
> +
> +    spapr->mc_status =3D -1;
> +    qemu_cond_init(&spapr->mc_delivery_cond);
>  }
> =20
>  static int spapr_kvm_type(const char *vm_type)
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index cdf0b60..08e9a5e 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -348,6 +348,37 @@ static void rtas_get_power_level(PowerPCCPU *cpu, sP=
APRMachineState *spapr,
>      rtas_st(rets, 1, 100);
>  }
> =20
> +static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
> +                                  sPAPRMachineState *spapr,
> +                                  uint32_t token, uint32_t nargs,
> +                                  target_ulong args,
> +                                  uint32_t nret, target_ulong rets)
> +{
> +    spapr->guest_machine_check_addr =3D rtas_ld(args, 1);
> +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> +}
> +
> +static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
> +                                   sPAPRMachineState *spapr,
> +                                   uint32_t token, uint32_t nargs,
> +                                   target_ulong args,
> +                                   uint32_t nret, target_ulong rets)
> +{
> +    if (!spapr->guest_machine_check_addr) {
> +        /* NMI register not called */
> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +    } else {
> +        /*
> +         * VCPU issuing "ibm,nmi-interlock" is done with NMI handling,
> +         * hence unset mc_status.
> +         */
> +        spapr->mc_status =3D -1;
> +        qemu_cond_signal(&spapr->mc_delivery_cond);
> +        rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> +    }
> +}
> +
> +
>  static struct rtas_call {
>      const char *name;
>      spapr_rtas_fn fn;
> @@ -489,6 +520,10 @@ static void core_rtas_register_types(void)
>                          rtas_set_power_level);
>      spapr_rtas_register(RTAS_GET_POWER_LEVEL, "get-power-level",
>                          rtas_get_power_level);
> +    spapr_rtas_register(RTAS_IBM_NMI_REGISTER, "ibm,nmi-register",
> +                        rtas_ibm_nmi_register);
> +    spapr_rtas_register(RTAS_IBM_NMI_INTERLOCK, "ibm,nmi-interlock",
> +                        rtas_ibm_nmi_interlock);
>  }
> =20
>  type_init(core_rtas_register_types)
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index b395aa7..28b6e2e 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -124,6 +124,13 @@ struct sPAPRMachineState {
>       * occurs during the unplug process. */
>      QTAILQ_HEAD(, sPAPRDIMMState) pending_dimm_unplugs;
> =20
> +    /* State related to "ibm,nmi-register" and "ibm,nmi-interlock" calls=
 */
> +    target_ulong guest_machine_check_addr;

You need to migrate this.  This is separate and simpler from the
problems of migrating during machine check handling - at the moment if
the guest calls nmi-register, then you migrate, then a machine check
is triggered you will have lost the information on how to handle it
properly.


> +    /* mc_status is set to -1 if mc is not in progress, else is set to t=
he CPU
> +     * handling the mc. */
> +    int mc_status;
> +    QemuCond mc_delivery_cond;
> +
>      /*< public >*/
>      char *kvm_type;
>      MemoryHotplugState hotplug_memory;
> @@ -520,8 +527,10 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target=
_ulong opcode,
>  #define RTAS_IBM_CREATE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x27)
>  #define RTAS_IBM_REMOVE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x28)
>  #define RTAS_IBM_RESET_PE_DMA_WINDOW            (RTAS_TOKEN_BASE + 0x29)
> +#define RTAS_IBM_NMI_REGISTER                   (RTAS_TOKEN_BASE + 0x2A)
> +#define RTAS_IBM_NMI_INTERLOCK                  (RTAS_TOKEN_BASE + 0x2B)
> =20
> -#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2A)
> +#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2C)
> =20
>  /* RTAS ibm,get-system-parameter token values */
>  #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rWhLK7VZz0iBluhq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnN7PYACgkQbDjKyiDZ
s5L6GhAAotlHnMgS3xLK+ZQPbluAHDQtWbAOj5AyQIndl0qK4z2ak6ElSYUKH8Nr
25dBXT+qK9OA0rK+o+C41cBKxMcx7fDgk/4XTpivvmYjDkKlu/U1aWvjtf36Caqb
pjxE5td/TVrklVkqzKxzs6lpSz2/Caef09q4JQo2JPSnyu0+II3eEQJhOMJ18zDi
/506mr2x/bzc/EDz9palfMrH4pwgfmBw0f3ZWs2rszHNWj2tPCJZ+CKG8x5GDXIC
KLVuP8IkulkveeJ7GEHTIpDcNnenuRnKy6rg4EYMYQst1qVnKIlSeGOdtqUR7qra
Gtp4GLQ/zYQhDwe8JYtxRc5BNDsTJIi19ADqZq3XSdpqTfeRiR2cRxhjFpL1E5sy
F84UQ7lqag4w3prm8MRS4txR+dBBiLHp7xdDLYXUgcTRie5YV3JzddR2hVM6OfNf
5hpcWPZeAdn9eJBL+IzVqy3oVSABow2lRQjxsK+418664oKsQV8DbP2lZwpY8h7S
1C0pnmrUvnuJ84R1RxjodOLcu9CxUTOY5+mvmMWVL01tLPdBDVpLACXV96q/BDJH
umVlTPzoGRk4W5AmqHZ1k3Z6zuxK/GWMjJkuJ5Jff48d3rj4FeEzNYIIRhO/V4gD
mN1pmQprnQIXHJqk87uo9R1jCF5lH85segfJVEeJKoY1PyuoFDU=
=rT5T
-----END PGP SIGNATURE-----

--rWhLK7VZz0iBluhq--
