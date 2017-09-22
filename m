Received: from eggs.gnu.org ([2001:4830:134:3::10]:56902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvLER-0004Qu-Ph
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:30:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvLEQ-0004tR-05
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:30:51 -0400
Date: Fri, 22 Sep 2017 20:22:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170922102206.GJ4998@umbus.fritz.box>
References: <150599859998.23636.12473281954936824580.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3MMMIZFJzhAsRj/+"
Content-Disposition: inline
In-Reply-To: <150599859998.23636.12473281954936824580.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v2] spapr: fix the value of SDR1 in
 kvmppc_put_books_sregs()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Sam Bobroff <sam.bobroff@au1.ibm.com>


--3MMMIZFJzhAsRj/+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2017 at 02:56:40PM +0200, Greg Kurz wrote:
> When running with KVM PR, if a new HPT is allocated we need to inform
> KVM about the HPT address and size. This is currently done by hacking
> the value of SDR1 and pushing it to KVM in several places.
>=20
> Also, migration breaks the guest since it is very unlikely the HPT has
> the same address in source and destination, but we push the incoming
> value of SDR1 to KVM anyway.
>=20
> This patch introduces a new virtual hypervisor hook so that the spapr
> code can provide the correct value of SDR1 to be pushed to KVM each
> time kvmppc_put_books_sregs() is called.
>=20
> It allows to get rid of all the hacking in the spapr/kvmppc code and
> it fixes migration of nested KVM PR.
>=20
> Suggested-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v2: - push sregs to KVM PR when HPT gets re-allocated during RESIZE_HPT_C=
OMMIT
>       and CAS

Looking good, but still a few details I'd like tweaked:

> ---
>  hw/ppc/spapr.c          |   13 +++++++++++++
>  hw/ppc/spapr_cpu_core.c |   16 +---------------
>  hw/ppc/spapr_hcall.c    |   45 +++++++++++++++++++++++++++++++++--------=
----
>  target/ppc/cpu.h        |    2 ++
>  target/ppc/kvm.c        |   29 +++++------------------------
>  target/ppc/kvm_ppc.h    |    6 ------
>  6 files changed, 54 insertions(+), 57 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index b79a9c866354..8288e1bad1a2 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1240,6 +1240,18 @@ static hwaddr spapr_hpt_mask(PPCVirtualHypervisor =
*vhyp)
>      return HTAB_SIZE(spapr) / HASH_PTEG_SIZE_64 - 1;
>  }
> =20
> +static void spapr_encode_hpt_for_kvm_pr(PPCVirtualHypervisor *vhyp,
> +                                        target_ulong *hpt)

Might as well just return the "sdr1" value, rather than using a
pointer parameter.

> +{
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(vhyp);
> +
> +    assert(kvm_enabled());
> +
> +    if (spapr->htab) {
> +        *hpt =3D (target_ulong)(uintptr_t)spapr->htab | (spapr->htab_shi=
ft - 18);
> +    }
> +}
> +
>  static const ppc_hash_pte64_t *spapr_map_hptes(PPCVirtualHypervisor *vhy=
p,
>                                                  hwaddr ptex, int n)
>  {
> @@ -3607,6 +3619,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      vhc->unmap_hptes =3D spapr_unmap_hptes;
>      vhc->store_hpte =3D spapr_store_hpte;
>      vhc->get_patbe =3D spapr_get_patbe;
> +    vhc->encode_hpt_for_kvm_pr =3D spapr_encode_hpt_for_kvm_pr;
>      xic->ics_get =3D spapr_ics_get;
>      xic->ics_resend =3D spapr_ics_resend;
>      xic->icp_get =3D spapr_icp_get;
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index c08ee7571a50..3e20b1d88644 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -18,6 +18,7 @@
>  #include "hw/ppc/ppc.h"
>  #include "target/ppc/mmu-hash64.h"
>  #include "sysemu/numa.h"
> +#include "sysemu/hw_accel.h"
>  #include "qemu/error-report.h"
> =20
>  void spapr_cpu_parse_features(sPAPRMachineState *spapr)
> @@ -73,7 +74,6 @@ void spapr_cpu_parse_features(sPAPRMachineState *spapr)
> =20
>  static void spapr_cpu_reset(void *opaque)
>  {
> -    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>      PowerPCCPU *cpu =3D opaque;
>      CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
> @@ -86,20 +86,6 @@ static void spapr_cpu_reset(void *opaque)
>      cs->halted =3D 1;
> =20
>      env->spr[SPR_HIOR] =3D 0;
> -
> -    /*
> -     * This is a hack for the benefit of KVM PR - it abuses the SDR1
> -     * slot in kvm_sregs to communicate the userspace address of the
> -     * HPT
> -     */
> -    if (kvm_enabled()) {
> -        env->spr[SPR_SDR1] =3D (target_ulong)(uintptr_t)spapr->htab
> -            | (spapr->htab_shift - 18);
> -        if (kvmppc_put_books_sregs(cpu) < 0) {
> -            error_report("Unable to update SDR1 in KVM");
> -            exit(1);
> -        }
> -    }
>  }
> =20
>  static void spapr_cpu_destroy(PowerPCCPU *cpu)
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 57bb411394ed..8d72bb7c1c34 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -686,6 +686,37 @@ static int rehash_hpt(PowerPCCPU *cpu,
>      return H_SUCCESS;
>  }
> =20
> +static void do_push_sregs_to_kvm_pr(CPUState *cs, run_on_cpu_data data)
> +{
> +    int ret;
> +
> +    cpu_synchronize_state(cs);
> +
> +    ret =3D kvmppc_put_books_sregs(POWERPC_CPU(cs));
> +    if (ret < 0) {
> +        error_report("failed to push sregs to KVM: %s", strerror(-ret));
> +        exit(1);
> +    }
> +}
> +
> +static void push_sregs_to_kvm_pr(sPAPRMachineState *spapr)
> +{
> +    CPUState *cs;
> +
> +    /*
> +     * This is a hack for the benefit of KVM PR - it abuses the SDR1
> +     * slot in kvm_sregs to communicate the userspace address of the
> +     * HPT
> +     */
> +    if (!kvm_enabled() || !spapr->htab) {
> +        return;
> +    }
> +
> +    CPU_FOREACH(cs) {
> +        run_on_cpu(cs, do_push_sregs_to_kvm_pr, RUN_ON_CPU_NULL);
> +    }
> +}
> +
>  static target_ulong h_resize_hpt_commit(PowerPCCPU *cpu,
>                                          sPAPRMachineState *spapr,
>                                          target_ulong opcode,
> @@ -733,12 +764,7 @@ static target_ulong h_resize_hpt_commit(PowerPCCPU *=
cpu,
>          spapr->htab =3D pending->hpt;
>          spapr->htab_shift =3D pending->shift;
> =20
> -        if (kvm_enabled()) {
> -            /* For KVM PR, update the HPT pointer */
> -            target_ulong sdr1 =3D (target_ulong)(uintptr_t)spapr->htab
> -                | (spapr->htab_shift - 18);
> -            kvmppc_update_sdr1(sdr1);
> -        }
> +        push_sregs_to_kvm_pr(spapr);
> =20
>          pending->hpt =3D NULL; /* so it's not free()d */
>      }
> @@ -1564,12 +1590,7 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
>               * the point this is called, nothing should have been
>               * entered into the existing HPT */
>              spapr_reallocate_hpt(spapr, maxshift, &error_fatal);
> -            if (kvm_enabled()) {
> -                /* For KVM PR, update the HPT pointer */
> -                target_ulong sdr1 =3D (target_ulong)(uintptr_t)spapr->ht=
ab
> -                    | (spapr->htab_shift - 18);
> -                kvmppc_update_sdr1(sdr1);
> -            }
> +            push_sregs_to_kvm_pr(spapr);
>          }
>      }
> =20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index c9d3ffa89bcb..12e0b6e74876 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1243,6 +1243,8 @@ struct PPCVirtualHypervisorClass {
>      void (*store_hpte)(PPCVirtualHypervisor *vhyp, hwaddr ptex,
>                         uint64_t pte0, uint64_t pte1);
>      uint64_t (*get_patbe)(PPCVirtualHypervisor *vhyp);
> +    void (*encode_hpt_for_kvm_pr)(PPCVirtualHypervisor *vhyp,
> +                                  target_ulong *hpt);
>  };
> =20
>  #define TYPE_PPC_VIRTUAL_HYPERVISOR "ppc-virtual-hypervisor"
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 5b281b2f1b6d..14254425596f 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -941,6 +941,11 @@ int kvmppc_put_books_sregs(PowerPCCPU *cpu)
> =20
>      sregs.pvr =3D env->spr[SPR_PVR];
> =20
> +    if (cpu->vhyp) {
> +        PPCVirtualHypervisorClass *vhc =3D
> +            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> +        vhc->encode_hpt_for_kvm_pr(cpu->vhyp, &env->spr[SPR_SDR1]);
> +    }
>      sregs.u.s.sdr1 =3D env->spr[SPR_SDR1];

Encoding the KVM PR value into env->spr[SPR_SDR1] perpetuates the
current dodginess, even if it reduces it.  Better to do:

if (cpu->vhyp)
	sregs.u.s.sdr1 =3D vhc->encode_hpt_for_kvm_pr(...);
else
	sregs.u.s.sdr1 =3D env->spr[SPR_SDR1];

This re-emphasises the thrust of this change.  For a "vhyp" machine
the vCPUs don't really *have* an SDR1, we're just re-using an sregs
field for something related but different.

> =20
>      /* Sync SLB */
> @@ -2798,30 +2803,6 @@ int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, targ=
et_ulong flags, int shift)
>      return kvm_vm_ioctl(cs->kvm_state, KVM_PPC_RESIZE_HPT_COMMIT, &rhpt);
>  }
> =20
> -static void kvmppc_pivot_hpt_cpu(CPUState *cs, run_on_cpu_data arg)
> -{
> -    target_ulong sdr1 =3D arg.target_ptr;
> -    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> -    CPUPPCState *env =3D &cpu->env;
> -
> -    /* This is just for the benefit of PR KVM */
> -    cpu_synchronize_state(cs);
> -    env->spr[SPR_SDR1] =3D sdr1;
> -    if (kvmppc_put_books_sregs(cpu) < 0) {
> -        error_report("Unable to update SDR1 in KVM");
> -        exit(1);
> -    }
> -}
> -
> -void kvmppc_update_sdr1(target_ulong sdr1)
> -{
> -    CPUState *cs;
> -
> -    CPU_FOREACH(cs) {
> -        run_on_cpu(cs, kvmppc_pivot_hpt_cpu, RUN_ON_CPU_TARGET_PTR(sdr1)=
);
> -    }
> -}
> -
>  /*
>   * This is a helper function to detect a post migration scenario
>   * in which a guest, running as KVM-HV, freezes in cpu_post_load because
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 349f892631bf..d6be38ecafbd 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -67,7 +67,6 @@ PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
>  void kvmppc_check_papr_resize_hpt(Error **errp);
>  int kvmppc_resize_hpt_prepare(PowerPCCPU *cpu, target_ulong flags, int s=
hift);
>  int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, target_ulong flags, int sh=
ift);
> -void kvmppc_update_sdr1(target_ulong sdr1);
>  bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu);
> =20
>  bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path);
> @@ -325,11 +324,6 @@ static inline int kvmppc_resize_hpt_commit(PowerPCCP=
U *cpu,
>      return -ENOSYS;
>  }
> =20
> -static inline void kvmppc_update_sdr1(target_ulong sdr1)
> -{
> -    abort();
> -}
> -
>  #endif
> =20
>  #ifndef CONFIG_KVM
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3MMMIZFJzhAsRj/+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnE5E4ACgkQbDjKyiDZ
s5IQ6BAAm9dWzgbeHtb88SPaJ8+ctDIN0fuPX10dOSLBGX+FUkMGFpZDQgz1aTK5
fmeToUi/v6C8MQ3bStoaIVy3ak0GpHrfPDkChIek8w68Pr9sW27H0hFDHZXXfOwZ
Hy+aTqLYRW63VPlFM5NvlNB4vDfqabo/2ybcnLZGS8ApJgihuaiLG0Nwg/54Lz0c
l+nsDqB73DCcKlJvhpK2yFKEZJzEo71h82FnfjMJSMCyxPUK6TB94Om0usHz+QrG
msPIZbLkDiKgYnCjLrqBRLsCbcSGJzG4WKRRf1q3tULnvRfW8eGtRn+4+FYsAbo4
o9yGwaAmQMrE4dycOIaNnOU9vZaUt6K/y8XRgxErgYpL9D/GGNqZV/869IwPjSIS
UEfgCNBekXuqUVg56XfdprckyN122+v219s5IzJp+dFoeybvjgZ2QSC1/j0v84qD
zRws6bHPIPZ8+KMqoSi381RpszMCEtmUr48MPmvd/In//SvnIPlBnJxtrNucAA3c
tZdEW1Ai21h1Xff5z3r42AUblXk/odSy2CpaT6f+sJbKPmsdn9oQlvpet6XbwXEw
FMRTHfSERjXA0+WexbjgIwBwE71Ae48WsOgO3dYQ6CS51CvbxLTUgMPYQHJmWtWV
j46NOmMThTNgWbNDbau/E8/wG87bNBPHhr84+TyiamhEG/X2GWg=
=qoGU
-----END PGP SIGNATURE-----

--3MMMIZFJzhAsRj/+--
