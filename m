Received: from eggs.gnu.org ([2001:4830:134:3::10]:56206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dfc3Z-0001Ga-7S
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 21:14:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dfc3X-0001p5-D9
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 21:14:37 -0400
Date: Thu, 10 Aug 2017 10:52:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170810005256.GS13670@umbus.fritz.box>
References: <20170809204346.5220-1-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DIYaQRZjygY6fA2m"
Content-Disposition: inline
In-Reply-To: <20170809204346.5220-1-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: 'PVR != host PVR' in
 KVM_SET_SREGS workaround
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru


--DIYaQRZjygY6fA2m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2017 at 05:43:46PM -0300, Daniel Henrique Barboza wrote:
> Commit d5fc133eed ("ppc: Rework CPU compatibility testing
> across migration") changed the way cpu_post_load behaves with
> the PVR setting, causing an unexpected bug in KVM-HV migrations
> between hosts that are compatible (POWER8 and POWER8E, for example).
> Even with pvr_match() returning true, the guest freezes right after
> cpu_post_load. The reason is that the guest kernel can't handle a
> different PVR value other that the running host in KVM_SET_SREGS.
>=20
> In [1] it was discussed the possibility of a new KVM capability
> that would indicate that the guest kernel can handle a different
> PVR in KVM_SET_SREGS. Even if such feature is implemented, there is
> still the problem with older kernels that will not have this capability
> and will fail to migrate.
>=20
> This patch implements a workaround for that scenario. If running
> with KVM, check if the guest kernel does not have the capability
> (named here as 'cap_ppc_pvr_compat'). If it doesn't, calls
> kvmppc_is_pr() to see if the guest is running in KVM-HV. If all this
> happens, set env->spr[SPR_PVR] to the same value as the current
> host PVR. This ensures that we allow migrations with 'close enough'
> PVRs to still work in KVM-HV but also makes the code ready for
> this new KVM capability when it is done.
>=20
> A new function called 'kvmppc_pvr_workaround_required' was created
> to encapsulate the conditions said above and to avoid calling too
> many kvm.c internals inside cpu_post_load.
>=20
> [1] https://lists.gnu.org/archive/html/qemu-ppc/2017-06/msg00503.html
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

Ugly, but necessary.  Applied to ppc-for-2.10.

> ---
>  target/ppc/kvm.c     | 34 ++++++++++++++++++++++++++++++++++
>  target/ppc/kvm_ppc.h |  1 +
>  target/ppc/machine.c | 22 ++++++++++++++++++++++
>  3 files changed, 57 insertions(+)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 8571379..fb3ee43 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -90,6 +90,7 @@ static int cap_htm;             /* Hardware transaction=
al memory support */
>  static int cap_mmu_radix;
>  static int cap_mmu_hash_v3;
>  static int cap_resize_hpt;
> +static int cap_ppc_pvr_compat;
> =20
>  static uint32_t debug_inst_opcode;
> =20
> @@ -147,6 +148,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      cap_mmu_radix =3D kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_RADIX);
>      cap_mmu_hash_v3 =3D kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_HASH_V=
3);
>      cap_resize_hpt =3D kvm_vm_check_extension(s, KVM_CAP_SPAPR_RESIZE_HP=
T);
> +    /*
> +     * Note: setting it to false because there is not such capability
> +     * in KVM at this moment.
> +     *
> +     * TODO: call kvm_vm_check_extension() with the right capability
> +     * after the kernel starts implementing it.*/
> +    cap_ppc_pvr_compat =3D false;
> =20
>      if (!cap_interrupt_level) {
>          fprintf(stderr, "KVM: Couldn't find level irq capability. Expect=
 the "
> @@ -2785,3 +2793,29 @@ void kvmppc_update_sdr1(target_ulong sdr1)
>          run_on_cpu(cs, kvmppc_pivot_hpt_cpu, RUN_ON_CPU_TARGET_PTR(sdr1)=
);
>      }
>  }
> +
> +/*
> + * This is a helper function to detect a post migration scenario
> + * in which a guest, running as KVM-HV, freezes in cpu_post_load because
> + * the guest kernel can't handle a PVR value other than the actual host
> + * PVR in KVM_SET_SREGS, even if pvr_match() returns true.
> + *
> + * If we don't have cap_ppc_pvr_compat and we're not running in PR
> + * (so, we're HV), return true. The workaround itself is done in
> + * cpu_post_load.
> + *
> + * The order here is important: we'll only check for KVM PR as a
> + * fallback if the guest kernel can't handle the situation itself.
> + * We need to avoid as much as possible querying the running KVM type
> + * in QEMU level.
> + */
> +bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu)
> +{
> +    CPUState *cs =3D CPU(cpu);
> +
> +    if (cap_ppc_pvr_compat) {
> +        return false;
> +    }
> +
> +    return !kvmppc_is_pr(cs->kvm_state);
> +}
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 6bc6fb3..381afe6 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -67,6 +67,7 @@ void kvmppc_check_papr_resize_hpt(Error **errp);
>  int kvmppc_resize_hpt_prepare(PowerPCCPU *cpu, target_ulong flags, int s=
hift);
>  int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, target_ulong flags, int sh=
ift);
>  void kvmppc_update_sdr1(target_ulong sdr1);
> +bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu);
> =20
>  bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path);
> =20
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index f578156..e545885 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -9,6 +9,7 @@
>  #include "mmu-hash64.h"
>  #include "migration/cpu.h"
>  #include "qapi/error.h"
> +#include "kvm_ppc.h"
> =20
>  static int cpu_load_old(QEMUFile *f, void *opaque, int version_id)
>  {
> @@ -250,6 +251,27 @@ static int cpu_post_load(void *opaque, int version_i=
d)
>          }
>      }
> =20
> +    /*
> +     * If we're running with KVM HV, there is a chance that the guest
> +     * is running with KVM HV and its kernel does not have the
> +     * capability of dealing with a different PVR other than this
> +     * exact host PVR in KVM_SET_SREGS. If that happens, the
> +     * guest freezes after migration.
> +     *
> +     * The function kvmppc_pvr_workaround_required does this verification
> +     * by first checking if the kernel has the cap, returning true immed=
iately
> +     * if that is the case. Otherwise, it checks if we're running in KVM=
 PR.
> +     * If the guest kernel does not have the cap and we're not running K=
VM-PR
> +     * (so, it is running KVM-HV), we need to ensure that KVM_SET_SREGS =
will
> +     * receive the PVR it expects as a workaround.
> +     *
> +     */
> +#if defined(CONFIG_KVM)
> +    if (kvmppc_pvr_workaround_required(cpu)) {
> +        env->spr[SPR_PVR] =3D env->spr_cb[SPR_PVR].default_value;
> +    }
> +#endif
> +
>      env->lr =3D env->spr[SPR_LR];
>      env->ctr =3D env->spr[SPR_CTR];
>      cpu_write_xer(env, env->spr[SPR_XER]);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DIYaQRZjygY6fA2m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmLrmUACgkQbDjKyiDZ
s5KwFQ//dLi2WZ8sjyvqwNMEsihvikkFroQ2aqVc0Dq2Eu/S/T3mA3JQWBCWpRZS
yF0Xaoc+5uPpV2FJkUU45V7iE9MFuZbGXkFIYEetvLuWXpEVTRnAmaz9Gm3JYZrA
audDeUzHlG1l6jxIkSayLjUno3HLJMuVcClCLINQ04NXEf7L0aiKqBvXL2f4ZLry
BG7oBbb5CKiBZdYMVlXkBDYjyWntT8LfFaVMK3qna6JR9g6vBZcXGSyhZdjbGFCP
V0s3Vx7Vh0Y+5z+IPG5bKyYHXc56bKbshmtxGUB94EWs+kaGjVEFldngcyQxcKf0
T+FxNrDKfrukym5t3dcC90IM7pjmPqZr/+ybMX8dr9rG+s9+2VP0djr4M7iSnWdG
1wC5BcKllT3HImeEfjJDq1ThEw5oqpnuxUWbJtya2NvSgMD3pKeA5XZkekqrJIKi
4r7PEweUFPPmu8U25OxPfFVtfNtOxbY4AgEFI6eC8/a+13vD44H/7B1rw7rx5+kI
KELcqYNW/QPC7/yIpNq9IjT9qaZlj0LjWnACV9npEUJnFWUoZK3Bmjz84x0npa2I
bGJMsd+3G4UKqtQjovq1MvICA7RcAPIHXwLtg71x95Zytx/3Ru3sCqtCInHwcXLX
FgPm/uUeVsC7utu2I5b25Mbfc+wbW4p0q4ZC9PwuGjzhYKqKk/A=
=7Hzt
-----END PGP SIGNATURE-----

--DIYaQRZjygY6fA2m--
