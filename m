Received: from eggs.gnu.org ([2001:4830:134:3::10]:48369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dwcvf-0000g8-SN
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dwcve-0000ZD-EG
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:36:47 -0400
Date: Tue, 26 Sep 2017 09:07:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170925230721.GD12504@umbus>
References: <150633720242.17479.13000419788993728100.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LTeJQqWS0MN7I/qa"
Content-Disposition: inline
In-Reply-To: <150633720242.17479.13000419788993728100.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH v3] spapr: fix the value of SDR1 in
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--LTeJQqWS0MN7I/qa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2017 at 01:00:02PM +0200, Greg Kurz wrote:
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

Applied to ppc-for-2.11, thanks.

> ---
> v3: - change encode_hpt_for_kvm_pr() to return the value instead of relyi=
ng
>       on a pointer
>     - don't set env->spr[SPR_SDR1] if we have cpu->vhyp
>=20
> v2: - push sregs to KVM PR when HPT gets re-allocated during RESIZE_HPT_C=
OMMIT
>       and CAS
> ---
>  hw/ppc/spapr.c          |   14 ++++++++++++++
>  hw/ppc/spapr_cpu_core.c |   16 +---------------
>  hw/ppc/spapr_hcall.c    |   45 +++++++++++++++++++++++++++++++++--------=
----
>  target/ppc/cpu.h        |    1 +
>  target/ppc/kvm.c        |   32 +++++++-------------------------
>  target/ppc/kvm_ppc.h    |    6 ------
>  6 files changed, 56 insertions(+), 58 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e82c8532ffb0..b0d528d0248a 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1240,6 +1240,19 @@ static hwaddr spapr_hpt_mask(PPCVirtualHypervisor =
*vhyp)
>      return HTAB_SIZE(spapr) / HASH_PTEG_SIZE_64 - 1;
>  }
> =20
> +static target_ulong spapr_encode_hpt_for_kvm_pr(PPCVirtualHypervisor *vh=
yp)
> +{
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(vhyp);
> +
> +    assert(kvm_enabled());
> +
> +    if (!spapr->htab) {
> +        return 0;
> +    }
> +
> +    return (target_ulong)(uintptr_t)spapr->htab | (spapr->htab_shift - 1=
8);
> +}
> +
>  static const ppc_hash_pte64_t *spapr_map_hptes(PPCVirtualHypervisor *vhy=
p,
>                                                  hwaddr ptex, int n)
>  {
> @@ -3608,6 +3621,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      vhc->unmap_hptes =3D spapr_unmap_hptes;
>      vhc->store_hpte =3D spapr_store_hpte;
>      vhc->get_patbe =3D spapr_get_patbe;
> +    vhc->encode_hpt_for_kvm_pr =3D spapr_encode_hpt_for_kvm_pr;
>      xic->ics_get =3D spapr_ics_get;
>      xic->ics_resend =3D spapr_ics_resend;
>      xic->icp_get =3D spapr_icp_get;
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 6e224ba029ec..13d7333f2061 100644
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
> index c9d3ffa89bcb..64aef17f6fb7 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1243,6 +1243,7 @@ struct PPCVirtualHypervisorClass {
>      void (*store_hpte)(PPCVirtualHypervisor *vhyp, hwaddr ptex,
>                         uint64_t pte0, uint64_t pte1);
>      uint64_t (*get_patbe)(PPCVirtualHypervisor *vhyp);
> +    target_ulong (*encode_hpt_for_kvm_pr)(PPCVirtualHypervisor *vhyp);
>  };
> =20
>  #define TYPE_PPC_VIRTUAL_HYPERVISOR "ppc-virtual-hypervisor"
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 8dd80993ec9e..beed1d3db7ee 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -940,7 +940,13 @@ int kvmppc_put_books_sregs(PowerPCCPU *cpu)
> =20
>      sregs.pvr =3D env->spr[SPR_PVR];
> =20
> -    sregs.u.s.sdr1 =3D env->spr[SPR_SDR1];
> +    if (cpu->vhyp) {
> +        PPCVirtualHypervisorClass *vhc =3D
> +            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> +        sregs.u.s.sdr1 =3D vhc->encode_hpt_for_kvm_pr(cpu->vhyp);
> +    } else {
> +        sregs.u.s.sdr1 =3D env->spr[SPR_SDR1];
> +    }
> =20
>      /* Sync SLB */
>  #ifdef TARGET_PPC64
> @@ -2786,30 +2792,6 @@ int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, targ=
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

--LTeJQqWS0MN7I/qa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnJjCkACgkQbDjKyiDZ
s5LqDxAAsJFCVi6bbJASLqhFkNtECcyZf5fWHzlodVPt+NJpJO6MO0YGpc0sysMe
7ATQ0NnrXJdXppZlwRu7sQC0eDkOBhKanqQOrhq+wmLYImXpNTMl0OuswymmjSf/
fH3QMKNm94/Byrq31dX0ExtepZ460oNKK7EAolGz+S1FmGbvoCvZOMYQr5fXIqJQ
th3+1/ijTpDs3a8Xgn4wrjjz437Zaqdh8zU5Ha6eKxH5BctF/SoijElS1ZN11ApA
xmHa4lR7TbtsRhIa5fYvilghOpgZGbnSUkM62tXLowDgi/SqptbiCb/6Vby5I1/r
tt0Lbr7aPXTOmyPI9zi/I+4Ri5mMXCyQGz/E6bMuvi2yIBWpCKMzf6/zfOaOBgOx
EI6uQTUVIfqQjadwjbX0SincrSsppdLHlj+iOb6tPcJxR7wdMOXtN1D8nQmRr58l
KzL38sJwtf+mnmkXNRe6OuGWeIHl3eecrX303/N3ZIdqAGjDQorwCamoHiLbUQGr
lpcaArEHmPx94d6q9eu01Tctl1pSPgxwN8ME5E5HX1qXbnAds8JMC4cFACTBD6FO
JNXmPLbFEZmKgl0ejrAu88dOrJdPr1d2wELTltvKQ6j7hdNt8F/ooj/c0EKnnfKQ
1gHNxXy7H/QMAZ0pviEavSYBhO9/yAYbHfVnLenzEB37MyIv3Ps=
=4/iL
-----END PGP SIGNATURE-----

--LTeJQqWS0MN7I/qa--
