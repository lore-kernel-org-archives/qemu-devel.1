Received: from eggs.gnu.org ([2001:4830:134:3::10]:32903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKh47-0007b0-3L
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKh42-0007ta-RD
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:20:43 -0400
Date: Tue, 13 Jun 2017 16:15:35 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170613081535.GE30171@umbus>
References: <20170608070351.1434-1-sjitindarsingh@gmail.com>
	<20170608070351.1434-3-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3XA6nns4nE4KvaS/"
Content-Disposition: inline
In-Reply-To: <20170608070351.1434-3-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] target/ppc: Implement large
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, agraf@suse.de


--3XA6nns4nE4KvaS/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2017 at 05:03:48PM +1000, Suraj Jitindar Singh wrote:
> The large decrementer is an operating mode of the decrementer.
> The decrementer is normally a 32-bit register.
> When operating in large decrementer mode the decrementer is a d-bit
> register which is sign extended to 64-bits (where d is implementation
> dependant).
>=20
> Implement support for a KVM guest to use the decrementer in large
> decrementer mode. This means adding functions to query the large
> decrementer support of the hypervisor and to enable the large
> decrementer with the hypervisor.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---
>  target/ppc/kvm.c     | 59 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  target/ppc/kvm_ppc.h | 25 ++++++++++++++++++++++
>  2 files changed, 84 insertions(+)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 51249ce..b2c94a0 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -88,6 +88,7 @@ static int cap_fixup_hcalls;
>  static int cap_htm;             /* Hardware transactional memory support=
 */
>  static int cap_mmu_radix;
>  static int cap_mmu_hash_v3;
> +static int cap_large_decr;
> =20
>  static uint32_t debug_inst_opcode;
> =20
> @@ -393,6 +394,19 @@ target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
>      }
>  }
> =20
> +void kvmppc_configure_large_decrementer(CPUState *cs, bool enable_ld)
> +{
> +    uint64_t lpcr;
> +
> +    kvm_get_one_reg(cs, KVM_REG_PPC_LPCR_64, &lpcr);
> +    if (enable_ld) {
> +        lpcr |=3D LPCR_LD;
> +    } else {
> +        lpcr &=3D LPCR_LD;
> +    }
> +    kvm_set_one_reg(cs, KVM_REG_PPC_LPCR_64, &lpcr);
> +}

This is never called, which seems bogus.  The LPCR should already be
synchronized with KVM, so I'm not sure why this needs a special call.

>  static bool kvm_valid_page_size(uint32_t flags, long rampgsize, uint32_t=
 shift)
>  {
>      if (!(flags & KVM_PPC_PAGE_SIZES_REAL)) {
> @@ -2004,6 +2018,11 @@ uint32_t kvmppc_get_dfp(void)
>      return kvmppc_read_int_cpu_dt("ibm,dfp");
>  }
> =20
> +uint32_t kvmppc_get_dec_bits(void)
> +{
> +    return kvmppc_read_int_cpu_dt("ibm,dec-bits");
> +}
> +
>  static int kvmppc_get_pvinfo(CPUPPCState *env, struct kvm_ppc_pvinfo *pv=
info)
>   {
>       PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> @@ -2380,6 +2399,7 @@ static void kvmppc_host_cpu_class_init(ObjectClass =
*oc, void *data)
> =20
>  #if defined(TARGET_PPC64)
>      pcc->radix_page_info =3D kvm_get_radix_page_info();
> +    pcc->large_decr_bits =3D kvmppc_get_dec_bits();

As you may have heard from SamB, autodetecting properties from KVM to
set on the guest CPU is.. problematic.  We already use it in a bunch
of places, but I'd like to discourage more examples of it.

>      if ((pcc->pvr & 0xffffff00) =3D=3D CPU_POWERPC_POWER9_DD1) {
>          /*
> @@ -2424,6 +2444,45 @@ bool kvmppc_has_cap_mmu_hash_v3(void)
>      return cap_mmu_hash_v3;
>  }
> =20
> +void kvmppc_check_cap_large_decr(void)
> +{
> +    PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
> +    CPUState *cs =3D CPU(cpu);
> +    bool large_dec_support;
> +    uint32_t dec_bits;
> +    uint64_t lpcr;
> +
> +    /*
> +     * Try and set the LPCR_LD (large decrementer) bit to enable the lar=
ge
> +     * decrementer. A hypervisor with large decrementer capabilities wil=
l allow
> +     * this so the value read back after this will have the LPCR_LD bit =
set.
> +     * Otherwise the bit will be cleared meaning we can't use the large
> +     * decrementer.
> +     */
> +    kvm_get_one_reg(cs, KVM_REG_PPC_LPCR_64, &lpcr);
> +    lpcr |=3D LPCR_LD;
> +    kvm_set_one_reg(cs, KVM_REG_PPC_LPCR_64, &lpcr);
> +    kvm_get_one_reg(cs, KVM_REG_PPC_LPCR_64, &lpcr);
> +    large_dec_support =3D !!(lpcr & LPCR_LD);
> +    /* Probably a good idea to clear it again */
> +    lpcr &=3D ~LPCR_LD;
> +    kvm_set_one_reg(cs, KVM_REG_PPC_LPCR_64, &lpcr);
> +
> +    /*
> +     * Check for the ibm,dec-bits property on the host, if it isn't ther=
e then
> +     * something has gone wrong and we're better off not letting the gue=
st use
> +     * the large decrementer.
> +     */
> +    dec_bits =3D kvmppc_get_dec_bits();
> +
> +    cap_large_decr =3D large_dec_support && dec_bits;
> +}
> +
> +bool kvmppc_has_cap_large_decr(void)
> +{
> +    return cap_large_decr;
> +}
> +
>  PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
>  {
>      uint32_t host_pvr =3D mfpvr();
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index f48243d..c49c7f0 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -17,6 +17,7 @@ uint32_t kvmppc_get_tbfreq(void);
>  uint64_t kvmppc_get_clockfreq(void);
>  uint32_t kvmppc_get_vmx(void);
>  uint32_t kvmppc_get_dfp(void);
> +uint32_t kvmppc_get_dec_bits(void);
>  bool kvmppc_get_host_model(char **buf);
>  bool kvmppc_get_host_serial(char **buf);
>  int kvmppc_get_hasidle(CPUPPCState *env);
> @@ -36,6 +37,8 @@ int kvmppc_booke_watchdog_enable(PowerPCCPU *cpu);
>  target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
>                                       bool radix, bool gtse,
>                                       uint64_t proc_tbl);
> +void kvmppc_check_cap_large_decr(void);
> +void kvmppc_configure_large_decrementer(CPUState *cs, bool enable_ld);
>  #ifndef CONFIG_USER_ONLY
>  off_t kvmppc_alloc_rma(void **rma);
>  bool kvmppc_spapr_use_multitce(void);
> @@ -60,6 +63,7 @@ bool kvmppc_has_cap_fixup_hcalls(void);
>  bool kvmppc_has_cap_htm(void);
>  bool kvmppc_has_cap_mmu_radix(void);
>  bool kvmppc_has_cap_mmu_hash_v3(void);
> +bool kvmppc_has_cap_large_decr(void);
>  int kvmppc_enable_hwrng(void);
>  int kvmppc_put_books_sregs(PowerPCCPU *cpu);
>  PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
> @@ -98,6 +102,11 @@ static inline uint32_t kvmppc_get_dfp(void)
>      return 0;
>  }
> =20
> +static inline uint32_t kvmppc_get_dec_bits(void)
> +{
> +    return 0;

IIUC, this should never be called on non-KVM, so this should have an
abort() (or g_assert_not_reached()) rather than returning a
clearly-wrong value.

> +}
> +
>  static inline int kvmppc_get_hasidle(CPUPPCState *env)
>  {
>      return 0;
> @@ -170,6 +179,17 @@ static inline target_ulong kvmppc_configure_v3_mmu(P=
owerPCCPU *cpu,
>      return 0;
>  }
> =20
> +static inline void kvmppc_check_cap_large_decr(void)
> +{
> +    return;
> +}
> +
> +static inline void kvmppc_configure_large_decrementer(CPUState *cs,
> +                                                      bool enable_ld)
> +{
> +    return;
> +}
> +
>  #ifndef CONFIG_USER_ONLY
>  static inline off_t kvmppc_alloc_rma(void **rma)
>  {
> @@ -282,6 +302,11 @@ static inline bool kvmppc_has_cap_mmu_hash_v3(void)
>      return false;
>  }
> =20
> +static inline bool kvmppc_has_cap_large_decr(void)
> +{
> +    return false;
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

--3XA6nns4nE4KvaS/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZP58nAAoJEGw4ysog2bOSHsgQALrYMmOUZFjof7rZfXkC6LBX
A7mmS1IjwgCIzB1Rv+xbiXwJtAZDjb03nTgOVsMW44EC4oCsWUbWytAqDlPJ/fZO
g7JPlrOqsPuKuZEUQ1zP1Sk6gSzfzEiMcMNFOcdR/hmUqQWd8a+u9LTc2dF11G3S
oT2NVXhkDZW9SSjvyHr20rVJ3FOSLMsuMflHX3qtBGHHqa3YEI9IiLVTEhboaU10
4d2MzUzN84jGpcaz7s41XF2jzPQLV0j+Liul+Hasg8MdkL/WTE4uI3819GHQlBYf
eelW6HDN3S10pR9elzzSSxB3UW8eNEPZYaSDrW6pcyL8XAR+t1i4mr+KdFOlIdhC
/IFAGZR/fvaOtseie0A1ZUp/H4Isgzo6K5hiY6XLw0upgkdhYJkKFPbHETTZnKcx
TDp9Ud1v8Zfqjrw8YKfl0gqwOgrcvz3hiEQNpY5T9P+4SSm/tFtjOUdqJpL+vt0V
EheZrLKBqsnqq6aJW7zlr6ndx5E0Up5TXbkzEWDA+mDweQmYlghnYbQyEaTIMRAe
04F43gA1ziDa/7biMKQDEnqiH9j74CejfjIapn8wm+LjHU4fvj9uk6HPDKwfSrDP
C4fFoyd1g+PDjJFdfWU4cmQ1yf1zZ36DaVg2smPBEw487Sx2bPDJ2Jnwlsgniapm
qPWEbcTxFosDO2nPoKca
=ozdw
-----END PGP SIGNATURE-----

--3XA6nns4nE4KvaS/--
