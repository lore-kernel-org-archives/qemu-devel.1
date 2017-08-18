Received: from eggs.gnu.org ([2001:4830:134:3::10]:52773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1diX8a-0004cD-9Y
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 22:35:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1diX8X-0004Fj-3I
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 22:35:52 -0400
Date: Fri, 18 Aug 2017 12:35:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170818023536.GO5509@umbus.fritz.box>
References: <cover.1502771785.git.sam.bobroff@au1.ibm.com>
	<beaad4313aaf2569939bab4831acb8f6b39ef993.1502771785.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VnOTrGv5LmZxna7m"
Content-Disposition: inline
In-Reply-To: <beaad4313aaf2569939bab4831acb8f6b39ef993.1502771785.git.sam.bobroff@au1.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/1] PPC: KVM: Support machine option to
 set VSMT mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org


--VnOTrGv5LmZxna7m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2017 at 02:42:21PM +1000, Sam Bobroff wrote:
> KVM now allows writing to KVM_CAP_PPC_SMT which has previously been
> read only. Doing so causes KVM to act, for that VM, as if the host's
> SMT mode was the given value. This is particularly important on Power
> 9 systems because their default value is 1, but they are able to
> support values up to 8.
>=20
> This patch introduces a way to control this capability via a new
> machine property called VSMT ("Virtual SMT"). If the value is not set
> on the command line a default is chosen that is, when possible,
> compatible with legacy systems.
>=20
> Note that the intialization of KVM_CAP_PPC_SMT has changed slightly
> because it has changed (in KVM) from a global capability to a
> VM-specific one. This won't cause a problem on older KVMs because VM
> capabilities fall back to global ones.
>=20
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Looks basically good, though a couple of minor comments.  I'm still
not sure if I like this approach over the alternative of having the
machine take over allocation of the kvm vcpu ids itself.  But I think
this is probably simpler and doesn't make taking the other approach
any harder later on.  So, I'm fine with going this way for now.

> ---
> Changes in v3:
>=20
> * Suggested by Greg Kurz:
>     * Comment on show_vsmt_possible() converted in to an assert().
>     * Better use of g_string_new().
>     * Removed trailing periods from several error_report() strings.
>     * Shortened overly long line.
>     * Converted some helpful error_report() calls into error_printf().
>     * Simplified error handling in spapr_set_vsmt().
>     * Use error_abort when adding properties (instead of ignoring errors)=
, as it's a bug if it fails.
>     * Moved the explanation about KVM_CAP_PPC_SMT into the commit so that=
 it's not lost with the cover letter.
>=20
>  hw/ppc/spapr.c              | 96 +++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/ppc/spapr.h      |  1 +
>  target/ppc/kvm.c            | 20 +++++++++-
>  target/ppc/kvm_ppc.h        | 12 ++++++
>  target/ppc/translate_init.c | 14 -------
>  5 files changed, 128 insertions(+), 15 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index cd6eb2d4a9..e266cdd36a 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -26,6 +26,7 @@
>   */
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> +#include "qapi/visitor.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/numa.h"
>  #include "hw/hw.h"
> @@ -2140,6 +2141,82 @@ static void spapr_init_cpus(sPAPRMachineState *spa=
pr)
>      g_free(type);
>  }
> =20
> +static void show_vsmt_possible(void)

This is only used conditional on KVM, so it probably belongs in kvm.c
(instead of exposing kvm_smt_possible()).

> +{
> +    int i;
> +    GString *g;
> +    char *s;
> +
> +    assert(kvm_enabled());
> +    if (kvmppc_smt_possible()) {
> +        g =3D g_string_new("Available VSMT modes:");
> +        for (i =3D 63; i >=3D 0; i--) {
> +            if ((1UL << i) & kvmppc_smt_possible()) {
> +                g_string_append_printf(g, " %lu", (1UL << i));
> +            }
> +        }
> +        s =3D g_string_free(g, false);
> +        error_printf("%s.\n", s);
> +        g_free(s);
> +    } else {
> +        error_printf("This KVM seems to be too old to support VSMT.\n");
> +    }
> +}
> +
> +static void spapr_set_vsmt_mode(sPAPRMachineState *spapr)
> +{
> +    bool vsmt_user =3D !!spapr->vsmt;
> +    int kvm_smt =3D kvmppc_smt_threads();
> +    int ret;
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> +    const char *machine_name =3D object_class_get_name(OBJECT_CLASS(smc)=
);
> +
> +    if (!kvm_enabled() && (smp_threads > 1)) {
> +        error_report("TCG cannot support more than 1 thread/core "
> +                     "on a %s", machine_name);
> +        exit(1);

If you respin, it might be worth having this function take an Error **
parameter, rather than dealing with the errors locally - the callers
probably have a better idea if the error should be fatal or not.

> +    }
> +    if (!is_power_of_2(smp_threads)) {
> +        error_report("Cannot support %d threads/core on a %s because "
> +                     "it must be a power of 2", smp_threads, machine_nam=
e);
> +        exit(1);

I guess it's already in the kernel (and, sort of, in the hardware),
but the power of 2 limitation bothers me a bit.  There's no inherent
reason that the number of threads per core has to be a power of 2.
After all, the ideal number of threads depends on relative compute and
memory intensity of your workload, combined with relative latency of
arithmetic versus memory operations.  There's no particular reason to
expect that to come out to a power of 2.

> +    }
> +
> +    /* Detemine the VSMT mode to use: */
> +    if (vsmt_user) {
> +        if (spapr->vsmt < smp_threads) {
> +            error_report("Cannot support VSMT mode %d"
> +                         " because it must be >=3D threads/core (%d)",
> +                         spapr->vsmt, smp_threads);
> +            exit(1);
> +        }
> +        /* In this case, spapr->vsmt has been set by the command line */
> +    } else {
> +        /* Choose a VSMT mode that may be higher than necessary but is
> +         * likely to be compatible with hosts that don't have VSMT. */
> +        spapr->vsmt =3D MAX(kvm_smt, smp_threads);

I don't love having this dependent on the kvm property, but I guess
that's already the case.  We can potentially change this default for
newer machine types in a later patch.

> +    }
> +
> +    /* KVM: If necessary, set the SMT mode: */
> +    if (kvm_enabled() && (spapr->vsmt !=3D kvm_smt)) {
> +        ret =3D kvmppc_set_smt_threads(spapr->vsmt);
> +        if (ret) {
> +            error_report("Failed to set KVM's VSMT mode to %d (errno %d)=
",
> +                         spapr->vsmt, ret);
> +            if (!vsmt_user) {
> +                error_printf("On PPC, a VM with %d threads/core on a hos=
t"
> +                             " with %d threads/core requires the use of"
> +                             " VSMT mode %d.\n",
> +                             smp_threads, kvm_smt, spapr->vsmt);
> +            }
> +            show_vsmt_possible();
> +            exit(1);
> +        }
> +    }
> +    /* else TCG: nothing to do currently */
> +    return;
> +}
> +
>  /* pSeries LPAR / sPAPR hardware init */
>  static void ppc_spapr_init(MachineState *machine)
>  {
> @@ -2272,6 +2349,8 @@ static void ppc_spapr_init(MachineState *machine)
> =20
>      spapr_cpu_parse_features(spapr);
> =20
> +    spapr_set_vsmt_mode(spapr);
> +
>      spapr_init_cpus(spapr);
> =20
>      if (kvm_enabled()) {
> @@ -2656,6 +2735,18 @@ static void spapr_set_resize_hpt(Object *obj, cons=
t char *value, Error **errp)
>      }
>  }
> =20
> +static void spapr_get_vsmt(Object *obj, Visitor *v, const char *name,
> +                                   void *opaque, Error **errp)
> +{
> +    visit_type_uint32(v, name, (uint32_t *)opaque, errp);
> +}
> +
> +static void spapr_set_vsmt(Object *obj, Visitor *v, const char *name,
> +                                   void *opaque, Error **errp)
> +{
> +    visit_type_uint32(v, name, (uint32_t *)opaque, errp);
> +}
> +
>  static void spapr_machine_initfn(Object *obj)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> @@ -2686,6 +2777,11 @@ static void spapr_machine_initfn(Object *obj)
>      object_property_set_description(obj, "resize-hpt",
>                                      "Resizing of the Hash Page Table (en=
abled, disabled, required)",
>                                      NULL);
> +    object_property_add(obj, "vsmt", "uint32", spapr_get_vsmt,
> +                        spapr_set_vsmt, NULL, &spapr->vsmt, &error_abort=
);
> +    object_property_set_description(obj, "vsmt",
> +                                    "Virtual SMT: KVM behaves as if this=
 were"
> +                                    " the host's SMT mode", &error_abort=
);
>  }
> =20
>  static void spapr_machine_finalizefn(Object *obj)
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 86c982cf2c..68c510339f 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -99,6 +99,7 @@ struct sPAPRMachineState {
>      uint64_t rtc_offset; /* Now used only during incoming migration */
>      struct PPCTimebase tb;
>      bool has_graphics;
> +    uint32_t vsmt;       /* Virtual SMT mode (KVM's "core stride") */

I thought you were going to add a VMSTATE_EQUAL migration for this.  I
guess that can be a follow up since it will change the migration
stream.

>      Notifier epow_notifier;
>      QTAILQ_HEAD(, sPAPREventLogEntry) pending_events;
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 5fc7f238eb..0b9d5b83fa 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -74,6 +74,7 @@ static int cap_interrupt_level =3D false;
>  static int cap_segstate;
>  static int cap_booke_sregs;
>  static int cap_ppc_smt;
> +static int cap_ppc_smt_possible;
>  static int cap_ppc_rma;
>  static int cap_spapr_tce;
>  static int cap_spapr_tce_64;
> @@ -130,7 +131,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      cap_interrupt_level =3D kvm_check_extension(s, KVM_CAP_PPC_IRQ_LEVEL=
);
>      cap_segstate =3D kvm_check_extension(s, KVM_CAP_PPC_SEGSTATE);
>      cap_booke_sregs =3D kvm_check_extension(s, KVM_CAP_PPC_BOOKE_SREGS);
> -    cap_ppc_smt =3D kvm_check_extension(s, KVM_CAP_PPC_SMT);
> +    cap_ppc_smt_possible =3D kvm_check_extension(s, KVM_CAP_PPC_SMT_POSS=
IBLE);
>      cap_ppc_rma =3D kvm_check_extension(s, KVM_CAP_PPC_RMA);
>      cap_spapr_tce =3D kvm_check_extension(s, KVM_CAP_SPAPR_TCE);
>      cap_spapr_tce_64 =3D kvm_check_extension(s, KVM_CAP_SPAPR_TCE_64);
> @@ -144,6 +145,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>       * only activated after this by kvmppc_set_papr() */
>      cap_htab_fd =3D kvm_check_extension(s, KVM_CAP_PPC_HTAB_FD);
>      cap_fixup_hcalls =3D kvm_check_extension(s, KVM_CAP_PPC_FIXUP_HCALL);
> +    cap_ppc_smt =3D kvm_vm_check_extension(s, KVM_CAP_PPC_SMT);
>      cap_htm =3D kvm_vm_check_extension(s, KVM_CAP_PPC_HTM);
>      cap_mmu_radix =3D kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_RADIX);
>      cap_mmu_hash_v3 =3D kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_HASH_V=
3);
> @@ -2134,6 +2136,22 @@ int kvmppc_smt_threads(void)
>      return cap_ppc_smt ? cap_ppc_smt : 1;
>  }
> =20
> +int kvmppc_set_smt_threads(int smt)
> +{
> +    int ret;
> +
> +    ret =3D kvm_vm_enable_cap(kvm_state, KVM_CAP_PPC_SMT, 0, smt, 0);
> +    if (!ret) {
> +        cap_ppc_smt =3D smt;
> +    }
> +    return ret;
> +}
> +
> +int kvmppc_smt_possible(void)
> +{
> +    return cap_ppc_smt_possible;
> +}
> +
>  #ifdef TARGET_PPC64
>  off_t kvmppc_alloc_rma(void **rma)
>  {
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 381afe6240..7b2962eb86 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -29,6 +29,8 @@ void kvmppc_set_papr(PowerPCCPU *cpu);
>  int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
>  void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
>  int kvmppc_smt_threads(void);
> +int kvmppc_smt_possible(void);
> +int kvmppc_set_smt_threads(int smt);
>  int kvmppc_clear_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits);
>  int kvmppc_or_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits);
>  int kvmppc_set_tcr(PowerPCCPU *cpu);
> @@ -148,6 +150,16 @@ static inline int kvmppc_smt_threads(void)
>      return 1;
>  }
> =20
> +static inline int kvmppc_smt_possible(void)
> +{
> +    return 1;
> +}
> +
> +static inline int kvmppc_set_smt_threads(int smt)
> +{
> +    return 0;
> +}
> +
>  static inline int kvmppc_or_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits)
>  {
>      return 0;
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 0ce923be46..7f6a349e43 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -9907,20 +9907,6 @@ static void ppc_cpu_realizefn(DeviceState *dev, Er=
ror **errp)
>      int max_smt =3D kvmppc_smt_threads();
>  #endif
> =20
> -#if !defined(CONFIG_USER_ONLY)
> -    if (smp_threads > max_smt) {
> -        error_setg(errp, "Cannot support more than %d threads on PPC wit=
h %s",
> -                   max_smt, kvm_enabled() ? "KVM" : "TCG");
> -        return;
> -    }
> -    if (!is_power_of_2(smp_threads)) {
> -        error_setg(errp, "Cannot support %d threads on PPC with %s, "
> -                   "threads count must be a power of 2.",
> -                   smp_threads, kvm_enabled() ? "KVM" : "TCG");
> -        return;
> -    }
> -#endif
> -
>      cpu_exec_realizefn(cs, &local_err);
>      if (local_err !=3D NULL) {
>          error_propagate(errp, local_err);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VnOTrGv5LmZxna7m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmWUnYACgkQbDjKyiDZ
s5IM8g/+KR9Ea/ufRfsMxdYYPcfJxfb8qfnH/iJqhUwOuNKQhUuLeZcerP4pmPnB
9d3u2BSv9NGECzs1HB958MWblJWSVeTJrEBV8+tibM9Mlsj0YbfC0I888QXl1MT5
IVYCI+9tpjtAoGfy3+kFu59AaZ7zyrKIGNuNtwRpxC+T3ZRM8n8G6QEpA1H0YP6U
V0SiH6V3sTNnxr7oDnXCvjcxWutWglhruP6nqom6bXeVzwSzqRFa6eFoTbiljxPr
Ny4a2C4lhIQBV55AXplTsxxqUhLfAg772y7VKKR+DxJhgxs6VWStns6GHLPwnXpa
84Xd7lAKAteLPvzIF5vezOYScw6wsq8v7k3QmCBzKzyfzJKC5LpBCUatjvNfsZrR
6wJi3TOTBEhRWY1NaHziu2EmNWvqjVRPr8YToolDWh8afzBHrMsdv2MIlgnVqo0n
+/Sqczg4p9rFE3ImyZ592cnUVlnzXC2f8TrmI87xFN8o5PEfMvdpFWTsuIE3CgWF
Ub6NutxWfDRr477GiJYT+5+tHN2/WoDkzkBOnGu+ECWA6ABo1W/hUutJ/h6qNgLN
tqMwAZ/9NgVfactAs2J2kto6XXuVT4ZTE1Pvl5vLgnKdtPo+/LrSGeeBvbYyNEwR
tezPqgsMireSFXWPZgY1foXJ6Dt8c6Up+wNna5aRN0blGJf7TI0=
=rdjb
-----END PGP SIGNATURE-----

--VnOTrGv5LmZxna7m--
