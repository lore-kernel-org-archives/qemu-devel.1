Received: from eggs.gnu.org ([2001:4830:134:3::10]:55154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqtTr-0007j0-Ks
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 00:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqtTq-000260-Bd
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 00:04:23 -0400
Date: Sun, 10 Sep 2017 13:56:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170910035650.GD2735@umbus.fritz.box>
References: <150456160452.17000.3290192176290246589.stgit@bahia.lan>
	<150456163456.17000.11736294199857677034.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9q+4pEgVd7t11q9L"
Content-Disposition: inline
In-Reply-To: <150456163456.17000.11736294199857677034.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 3/4] ppc: kvm: introduce a helper to update
 SDR1 for a single CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Thomas Huth <thuth@redhat.com>


--9q+4pEgVd7t11q9L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 04, 2017 at 11:47:14PM +0200, Greg Kurz wrote:
> When running with KVM PR, we hijack the SDR1 slot to pass the address of
> the HPT allocated by QEMU to KVM.  On pseries virtual machines, we have to
> do this when the guest calls the KVMPPC_H_CAS or the H_RESIZE_HPT_COMMIT
> hypercalls. This is currently handled by kvmppc_update_sdr1() which updat=
es
> SDR1 for all CPUs. But we also need to update SDR1 at machine reset, and
> this is currently open-coded in spapr_cpu_reset() on a per-CPU basis.
>=20
> This patch renames kvmppc_update_sdr1() to kvmppc_update_sdr1_all() and
> reuses the kvmppc_update_sdr1() function name to update a single CPU,
> like we already do with in the CPU compat mode code.
>=20
> It finally converts the sPAPR code to use the all CPUs or single CPU help=
ers
> where appropriate.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Seems reasonable, but I'll wait for the next spin of the series, since
the previous patch wants some work.

> ---
>  hw/ppc/spapr_cpu_core.c |    6 +-----
>  hw/ppc/spapr_hcall.c    |    4 ++--
>  target/ppc/kvm.c        |   12 ++++++++----
>  target/ppc/kvm_ppc.h    |    3 ++-
>  4 files changed, 13 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 581eb4d92de9..da81688b0f4d 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -95,11 +95,7 @@ static void spapr_cpu_reset(void *opaque)
>      if (kvm_enabled()) {
>          target_ulong sdr1 =3D spapr_get_hpt_pointer(spapr);
>          if (sdr1) {
> -            env->spr[SPR_SDR1] =3D sdr1;
> -            if (kvmppc_put_books_sregs(cpu) < 0) {
> -                error_report("Unable to update SDR1 in KVM");
> -                exit(1);
> -            }
> +            kvmppc_update_sdr1(cpu, sdr1);
>          }
>      }
>  }
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 06059b44ab40..e090b69efe7f 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -737,7 +737,7 @@ static target_ulong h_resize_hpt_commit(PowerPCCPU *c=
pu,
>              /* For KVM PR, update the HPT pointer */
>              target_ulong sdr1 =3D spapr_get_hpt_pointer(spapr);
>              if (sdr1) {
> -                kvmppc_update_sdr1(sdr1);
> +                kvmppc_update_sdr1_all(sdr1);
>              }
>          }
> =20
> @@ -1569,7 +1569,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
>                  /* For KVM PR, update the HPT pointer */
>                  target_ulong sdr1 =3D spapr_get_hpt_pointer(spapr);
>                  if (sdr1) {
> -                    kvmppc_update_sdr1(sdr1);
> +                    kvmppc_update_sdr1_all(sdr1);
>                  }
>              }
>          }
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 6442dfcb95b3..e69366968f15 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2806,10 +2806,9 @@ int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, targ=
et_ulong flags, int shift)
>      return kvm_vm_ioctl(cs->kvm_state, KVM_PPC_RESIZE_HPT_COMMIT, &rhpt);
>  }
> =20
> -static void kvmppc_pivot_hpt_cpu(CPUState *cs, run_on_cpu_data arg)
> +void kvmppc_update_sdr1(PowerPCCPU *cpu, target_ulong sdr1)
>  {
> -    target_ulong sdr1 =3D arg.target_ptr;
> -    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +    CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
> =20
>      /* This is just for the benefit of PR KVM */
> @@ -2821,7 +2820,12 @@ static void kvmppc_pivot_hpt_cpu(CPUState *cs, run=
_on_cpu_data arg)
>      }
>  }
> =20
> -void kvmppc_update_sdr1(target_ulong sdr1)
> +static void kvmppc_pivot_hpt_cpu(CPUState *cs, run_on_cpu_data arg)
> +{
> +    kvmppc_update_sdr1(POWERPC_CPU(cs), arg.target_ptr);
> +}
> +
> +void kvmppc_update_sdr1_all(target_ulong sdr1)
>  {
>      CPUState *cs;
> =20
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index f780e6ec7b72..9524a7a0c21c 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -68,7 +68,8 @@ PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
>  void kvmppc_check_papr_resize_hpt(Error **errp);
>  int kvmppc_resize_hpt_prepare(PowerPCCPU *cpu, target_ulong flags, int s=
hift);
>  int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, target_ulong flags, int sh=
ift);
> -void kvmppc_update_sdr1(target_ulong sdr1);
> +void kvmppc_update_sdr1(PowerPCCPU *cpu, target_ulong sdr1);
> +void kvmppc_update_sdr1_all(target_ulong sdr1);
>  bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu);
> =20
>  bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9q+4pEgVd7t11q9L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm0t/8ACgkQbDjKyiDZ
s5IzMRAA2frTvyMKQm0HTv2RifF9S/H/GaZAj8qqxRoiSn00n50+6RGly/ahziEH
6FMuhrP2Uta7b0DBeuc9KtuJelFIYmTzOVwLizQfzxpiV8ob03ByJRjhluom7Wuo
2K29Vm9oZ2kFdQVyGooM6wALxZqxkAODRl+lvhB5fcnVzxGDG/sf++rnCdWChOOm
FKffEQ0P0MrBJKhxNcfRibu2j7gOz+HG8yK1/6OqtRMbz701WhXJU/WLcK4prSYx
hDFZ6vfsvBxJRw0GXHWv4qsfwrpshsj+pnQCZv5QDLUAKnUG6G6yysJTjmkZGiOf
55xq081tbtaBvXjPL5tuFB04yHmm0Z9PhxCIwfrSb+NE5W5WywKtxE9RBu6iitMP
uNRAn19PazV8CWG9VldW6NGRuUCyVbUYAXtsjtpcm9Lq+4xq2+97um7XksrwdvHz
ifT5vcm2oD8Z7Fz9i1L1UZKjGO3EmOHuZq1Yon87kwKrZ552xkhh67fPDhE3g8D5
gdvy5/GtOB/zsc95evOiu9IO3WBEVkPuX6GsWGlhG/tyEdDz4CRM2ZCOsDG24SMJ
0aLa/m7sMO5M23X/CCXBApSdR+ltrpBUJJCC4x7PHJAq8YX4LhzmQv86df4v3Gzj
cBbrbhfvzkWNCUt4FiicMNo+vdUcZhIEjCEspMpUONuaBK0Jha4=
=JU9L
-----END PGP SIGNATURE-----

--9q+4pEgVd7t11q9L--
