Received: from eggs.gnu.org ([209.51.188.92]:48847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyTtq-0003t0-OI
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 22:59:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyTto-0007jo-Fo
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 22:59:22 -0500
Date: Tue, 26 Feb 2019 14:55:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190226035532.GM6872@umbus.fritz.box>
References: <20190226030531.9932-1-sjitindarsingh@gmail.com>
	<20190226030531.9932-3-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9ToWwKEyhugL+MAz"
Content-Disposition: inline
In-Reply-To: <20190226030531.9932-3-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH 3/4] target/ppc: Implement large
 decrementer support for KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, clg@kaod.org, qemu-devel@nongnu.org


--9ToWwKEyhugL+MAz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 26, 2019 at 02:05:30PM +1100, Suraj Jitindar Singh wrote:
> Implement support to allow KVM guests to take advantage of the large
> decrementer introduced on POWER9 cpus.
>=20
> To determine if the host can support the requested large decrementer
> size, we check it matches that specified in the ibm,dec-bits device-tree
> property. We also need to enable it in KVM by setting the LPCR_LD bit in
> the LPCR. Note that to do this we need to try and set the bit, then read
> it back to check the host allowed us to set it, if so we can use it but
> if we were unable to set it the host cannot support it and we must not
> use the large decrementer.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Although changes might be necessary to match it to things I've
suggested in the earlier patches in the series.

Is the KVM side support for this already merged?  If so, as of when?

> ---
>  hw/ppc/spapr_caps.c  | 17 +++++++++++++++--
>  target/ppc/kvm.c     | 39 +++++++++++++++++++++++++++++++++++++++
>  target/ppc/kvm_ppc.h | 12 ++++++++++++
>  3 files changed, 66 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 44542fdbb2..e07568fb94 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -440,8 +440,16 @@ static void cap_large_decr_apply(sPAPRMachineState *=
spapr,
>                  pcc->hdecr_bits);
>              return;
>          }
> -    } else {
> -        error_setg(errp, "No large decrementer support, try cap-large-de=
cr=3D0");
> +    } else if (kvm_enabled()) {
> +        int kvm_nr_bits =3D kvmppc_get_cap_large_decr();
> +
> +        if (!kvm_nr_bits) {
> +            error_setg(errp, "No large decrementer support, try cap-larg=
e-decr=3D0");
> +        } else if (val !=3D kvm_nr_bits) {
> +            error_setg(errp,
> +                "Large decrementer size unsupported, try -cap-large-decr=
=3D%d",
> +                kvm_nr_bits);
> +        }
>      }
>  }
> =20
> @@ -452,6 +460,11 @@ static void cap_large_decr_cpu_apply(sPAPRMachineSta=
te *spapr,
>      CPUPPCState *env =3D &cpu->env;
>      target_ulong lpcr =3D env->spr[SPR_LPCR];
> =20
> +    if (kvm_enabled()) {
> +        if (kvmppc_enable_cap_large_decr(cpu, !!val))
> +            error_setg(errp, "No large decrementer support, try cap-larg=
e-decr=3D0");
> +    }
> +
>      if (val)
>          lpcr |=3D LPCR_LD;
>      else
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index d01852fe31..3f650c8fc4 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -91,6 +91,7 @@ static int cap_ppc_safe_cache;
>  static int cap_ppc_safe_bounds_check;
>  static int cap_ppc_safe_indirect_branch;
>  static int cap_ppc_nested_kvm_hv;
> +static int cap_large_decr;
> =20
>  static uint32_t debug_inst_opcode;
> =20
> @@ -124,6 +125,7 @@ static bool kvmppc_is_pr(KVMState *ks)
> =20
>  static int kvm_ppc_register_host_cpu_type(MachineState *ms);
>  static void kvmppc_get_cpu_characteristics(KVMState *s);
> +static int kvmppc_get_dec_bits(void);
> =20
>  int kvm_arch_init(MachineState *ms, KVMState *s)
>  {
> @@ -151,6 +153,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      cap_resize_hpt =3D kvm_vm_check_extension(s, KVM_CAP_SPAPR_RESIZE_HP=
T);
>      kvmppc_get_cpu_characteristics(s);
>      cap_ppc_nested_kvm_hv =3D kvm_vm_check_extension(s, KVM_CAP_PPC_NEST=
ED_HV);
> +    cap_large_decr =3D kvmppc_get_dec_bits();
>      /*
>       * Note: setting it to false because there is not such capability
>       * in KVM at this moment.
> @@ -1927,6 +1930,15 @@ uint64_t kvmppc_get_clockfreq(void)
>      return kvmppc_read_int_cpu_dt("clock-frequency");
>  }
> =20
> +static int kvmppc_get_dec_bits(void)
> +{
> +    int nr_bits =3D kvmppc_read_int_cpu_dt("ibm,dec-bits");
> +
> +    if (nr_bits > 0)
> +        return nr_bits;
> +    return 0;
> +}
> +
>  static int kvmppc_get_pvinfo(CPUPPCState *env, struct kvm_ppc_pvinfo *pv=
info)
>   {
>       PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> @@ -2442,6 +2454,33 @@ bool kvmppc_has_cap_spapr_vfio(void)
>      return cap_spapr_vfio;
>  }
> =20
> +int kvmppc_get_cap_large_decr(void)
> +{
> +    return cap_large_decr;
> +}
> +
> +int kvmppc_enable_cap_large_decr(PowerPCCPU *cpu, int enable)
> +{
> +    CPUState *cs =3D CPU(cpu);
> +    uint64_t lpcr;
> +
> +    kvm_get_one_reg(cs, KVM_REG_PPC_LPCR_64, &lpcr);
> +    /* Do we need to modify the LPCR? */
> +    if (!!(lpcr & LPCR_LD) !=3D !!enable) {
> +        if (enable)
> +            lpcr |=3D LPCR_LD;
> +        else
> +            lpcr &=3D ~LPCR_LD;
> +        kvm_set_one_reg(cs, KVM_REG_PPC_LPCR_64, &lpcr);
> +        kvm_get_one_reg(cs, KVM_REG_PPC_LPCR_64, &lpcr);
> +
> +        if (!!(lpcr & LPCR_LD) !=3D !!enable)
> +            return -1;
> +    }
> +
> +    return 0;
> +}
> +
>  PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
>  {
>      uint32_t host_pvr =3D mfpvr();
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index bdfaa4e70a..a79835bd14 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -64,6 +64,8 @@ int kvmppc_get_cap_safe_bounds_check(void);
>  int kvmppc_get_cap_safe_indirect_branch(void);
>  bool kvmppc_has_cap_nested_kvm_hv(void);
>  int kvmppc_set_cap_nested_kvm_hv(int enable);
> +int kvmppc_get_cap_large_decr(void);
> +int kvmppc_enable_cap_large_decr(PowerPCCPU *cpu, int enable);
>  int kvmppc_enable_hwrng(void);
>  int kvmppc_put_books_sregs(PowerPCCPU *cpu);
>  PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
> @@ -332,6 +334,16 @@ static inline int kvmppc_set_cap_nested_kvm_hv(int e=
nable)
>      return -1;
>  }
> =20
> +static inline int kvmppc_get_cap_large_decr(void)
> +{
> +    return 0;
> +}
> +
> +static inline int kvmppc_enable_cap_large_decr(PowerPCCPU *cpu, int enab=
le)
> +{
> +    return -1;
> +}
> +
>  static inline int kvmppc_enable_hwrng(void)
>  {
>      return -1;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9ToWwKEyhugL+MAz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx0uLMACgkQbDjKyiDZ
s5IgTRAAl62RJnyBrbDFVIMXGDbSvYJtKCJBz9C5u2bJxE/XrFJwLT2KGN9hJ/vY
p+dAfCBoxlznLQXu63DPfrizuANX7N9esKh4ulwuKOVDSf+4t8KjziiMdLlWI5NX
8X5sfCj9aLaZ9GiSeL3oxoZIMcVjQvy9RnLDtdcqb3kKtCkzT8IuCXTO8S1kPdLa
kr58QrbF0C6kIPhDxcfCc0SJqTBY4S9yjPBkNteh2Pyyz2rBLWXgqjBTiGso8Jos
RS0xUI7/oPnlIn6rjXORSTs1wJqvb9JJbqvg/wnWi8TKvq28AkAtUpjCJWWcYuy1
SbIuGTuCICzze674ws/nANXcdHg5erdaNhiCJfRF7GQvxnATjYW/OPFNyq6oMfLl
ENsqidYkBvwFPrQYJRdX1YrMR44y2uC/xLtpt56DLVGO5+Dfq1Vwrvi6PydYYsmO
osijc4q09LBUeD544oz7aHdC2KemUnC2W7nH6iunyuh8O3GUdrNSP/dP40rp6zSi
oANz0HiPYH3k3hAkj4Omovfdk/SpH0r4wY7mdcuAO8nbdV9M2vE2EX5xC7cM/VWM
4WLsCtnsk8D+CMF7rU//RrX69kPvIN7qomMxF0zgiZK+Mq3qvAJWL/xq7rEvucB4
JB7U7SyRovqAconw7uNC+A+u9oRNZTpR+AsjzQ4elPD6pLUiPjA=
=eCDJ
-----END PGP SIGNATURE-----

--9ToWwKEyhugL+MAz--
