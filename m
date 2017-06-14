Received: from eggs.gnu.org ([2001:4830:134:3::10]:32836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dLEp4-0004Y8-0l
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dLEp0-00038K-0y
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:23:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dLEoz-00037d-Nm
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:23:21 -0400
References: <20170614133819.18480-1-david@redhat.com>
	<20170614133819.18480-3-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <25d4dffd-786c-9a24-80ed-6a71724435ae@redhat.com>
Date: Wed, 14 Jun 2017 22:23:15 +0200
MIME-Version: 1.0
In-Reply-To: <20170614133819.18480-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] target/s390x: implement mvcos
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>, Miroslav Benes <mbenes@suse.cz>

On 14.06.2017 15:38, David Hildenbrand wrote:
> This adds support for the MOVE WITH OPTIONAL SPECIFICATIONS (MVCOS)
> instruction. Allow to enable it for the qemu cpu model using
>=20
> qemu-system-s390x ... -cpu qemu,mvcos=3Don ...
>=20
> This allows to boot linux kernel that uses it for uacccess.
>=20
> We are missing (as for most other part) low address protection checks,
> PSW key / storage key checks and support for AR-mode.
>=20
> We fake an ADDRESSING exception when called from problem state (which
> seems to rely on PSW key checks to be in place) and if AR-mode is used.
> user mode will always see a PRIVILEDGED exception.
>=20
> This patch is based on an original patch by Miroslav Benes (thanks!).
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
[...]
> index 80caab9..5f76dae 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -110,6 +110,20 @@ static inline void cpu_stsize_data_ra(CPUS390XStat=
e *env, uint64_t addr,
>      }
>  }
> =20
> +static inline uint64_t wrap_address(CPUS390XState *env, uint64_t a)
> +{
> +    if (!(env->psw.mask & PSW_MASK_64)) {
> +        if (!(env->psw.mask & PSW_MASK_32)) {
> +            /* 24-Bit mode */
> +            a &=3D 0x00ffffff;
> +        } else {
> +            /* 31-Bit mode */
> +            a &=3D 0x7fffffff;
> +        }
> +    }
> +    return a;
> +}
> +
>  static void fast_memset(CPUS390XState *env, uint64_t dest, uint8_t byt=
e,
>                          uint32_t l, uintptr_t ra)
>  {
> @@ -118,7 +132,7 @@ static void fast_memset(CPUS390XState *env, uint64_=
t dest, uint8_t byte,
>      while (l > 0) {
>          void *p =3D tlb_vaddr_to_host(env, dest, MMU_DATA_STORE, mmu_i=
dx);
>          if (p) {
> -            /* Access to the whole page in write mode granted.  */
> +            /* Access to the whole page in write mode granted  */

Unrelated change ;-)

>              uint32_t l_adj =3D adj_len_to_page(l, dest);
>              memset(p, byte, l_adj);
>              dest +=3D l_adj;
> @@ -133,6 +147,68 @@ static void fast_memset(CPUS390XState *env, uint64=
_t dest, uint8_t byte,
>      }
>  }
> =20
> +#ifndef CONFIG_USER_ONLY
> +static void fast_memmove_idx(CPUS390XState *env, uint64_t dest, uint64=
_t src,
> +                             uint32_t len, int dest_idx, int src_idx,
> +                             uintptr_t ra)
> +{
> +    TCGMemOpIdx oi_dest =3D make_memop_idx(MO_UB, dest_idx);
> +    TCGMemOpIdx oi_src =3D make_memop_idx(MO_UB, src_idx);
> +    uint32_t len_adj;
> +    void *src_p;
> +    void *dest_p;
> +    uint8_t x;
> +
> +    while (len > 0) {
> +        src =3D wrap_address(env, src);
> +        dest =3D wrap_address(env, dest);
> +        src_p =3D tlb_vaddr_to_host(env, src, MMU_DATA_LOAD, src_idx);
> +        dest_p =3D tlb_vaddr_to_host(env, dest, MMU_DATA_STORE, dest_i=
dx);
> +
> +        if (src_p && dest_p) {
> +            /* Access to both whole pages granted.  */
> +            len_adj =3D adj_len_to_page(adj_len_to_page(len, src), des=
t);
> +            memmove(dest_p, src_p, len_adj);
> +        } else {
> +            /* We failed to get access to one or both whole pages. The=
 next
> +               read or write access will likely fill the QEMU TLB for =
the
> +               next iteration.  */
> +            len_adj =3D 1;
> +            x =3D helper_ret_ldub_mmu(env, src, oi_src, ra);
> +            helper_ret_stb_mmu(env, dest, x, oi_dest, ra);
> +        }
> +        src +=3D len_adj;
> +        dest +=3D len_adj;
> +        len -=3D len_adj;
> +    }
> +}

The code is pretty similar to fast_memmove() ... I wonder whether it make=
s
sense to change fast_memmove() to call fast_memmove_idx(), too?

Something like:

static void fast_memmove(CPUS390XState *env, uint64_t dest, uint64_t src,
                         uint32_t l, uintptr_t ra)
{
    int mmu_idx =3D cpu_mmu_index(env, false);

    fast_memmove_idx(env, dest, src, l, mmu_idx, mmu_idx, ra);
}

Or could that result in some speed penalty here?
Anyway, this should likely be done in a separate patch.

> +static int mmu_idx_from_as(uint8_t as)
> +{
> +    switch (as) {
> +    case AS_PRIMARY:
> +        return MMU_PRIMARY_IDX;
> +    case AS_SECONDARY:
> +        return MMU_SECONDARY_IDX;
> +    case AS_HOME:
> +        return MMU_HOME_IDX;
> +    }
> +    /* FIXME AS_ACCREG */
> +    assert(false);
> +    return -1;
> +}

Hmm, maybe it would make sense to change the MMU_*_IDX defines to match
the AS value directly?

> +static void fast_memmove_as(CPUS390XState *env, uint64_t dest, uint64_=
t src,
> +                            uint32_t len, uint8_t dest_as, uint8_t src=
_as,
> +                            uintptr_t ra)
> +{
> +    int src_idx =3D mmu_idx_from_as(src_as);
> +    int dest_idx =3D mmu_idx_from_as(dest_as);
> +
> +    fast_memmove_idx(env, dest, src, len, dest_idx, src_idx, ra);
> +}
> +#endif
> +
>  static void fast_memmove(CPUS390XState *env, uint64_t dest, uint64_t s=
rc,
>                           uint32_t l, uintptr_t ra)
>  {
> @@ -408,20 +484,6 @@ uint32_t HELPER(clm)(CPUS390XState *env, uint32_t =
r1, uint32_t mask,
>      return cc;
>  }
> =20
> -static inline uint64_t wrap_address(CPUS390XState *env, uint64_t a)
> -{
> -    if (!(env->psw.mask & PSW_MASK_64)) {
> -        if (!(env->psw.mask & PSW_MASK_32)) {
> -            /* 24-Bit mode */
> -            a &=3D 0x00ffffff;
> -        } else {
> -            /* 31-Bit mode */
> -            a &=3D 0x7fffffff;
> -        }
> -    }
> -    return a;
> -}
> -
>  static inline uint64_t get_address(CPUS390XState *env, int reg)
>  {
>      return wrap_address(env, env->regs[reg]);
> @@ -1789,3 +1851,91 @@ void HELPER(ex)(CPUS390XState *env, uint32_t ile=
n, uint64_t r1, uint64_t addr)
>         that requires such execution.  */
>      env->ex_value =3D insn | ilen;
>  }
> +
> +uint32_t HELPER(mvcos)(CPUS390XState *env, uint64_t dest, uint64_t src=
,
> +                       uint64_t len)
> +{
> +    const uint8_t psw_key =3D (env->psw.mask & PSW_MASK_KEY) >> PSW_SH=
IFT_KEY;
> +    const uint8_t psw_as =3D (env->psw.mask & PSW_MASK_ASC) >> PSW_SHI=
FT_ASC;
> +    const uint64_t r0 =3D env->regs[0];
> +    const uintptr_t ra =3D GETPC();
> +    CPUState *cs =3D CPU(s390_env_get_cpu(env));
> +    uint8_t dest_key, dest_as, dest_k, dest_a;
> +    uint8_t src_key, src_as, src_k, src_a;
> +    uint64_t val;
> +    int cc =3D 0;
> +
> +    HELPER_LOG("%s dest %" PRIx64 ", src %" PRIx64 ", len %" PRIx64 "\=
n",
> +               __func__, dest, src, len);
> +
> +    if (!(env->psw.mask & PSW_MASK_DAT)) {
> +        cpu_restore_state(cs, ra);
> +        program_interrupt(env, PGM_SPECIAL_OP, 6);
> +    }
> +
> +    /* OAC (operand access control) for the first operand -> dest */
> +    val =3D (r0 & 0xffff0000ULL) >> 16;
> +    dest_key =3D (val >> 12) & 0xf;
> +    dest_as =3D (val >> 6) & 0x3;
> +    dest_k =3D (val >> 1) & 0x1;
> +    dest_a =3D val & 0x1;
> +
> +    /* OAC (operand access control) for the second operand -> src */
> +    val =3D (r0 & 0x0000ffffULL);
> +    src_key =3D (val >> 12) & 0xf;
> +    src_as =3D (val >> 6) & 0x3;
> +    src_k =3D (val >> 1) & 0x1;
> +    src_a =3D val & 0x1;
> +
> +    if (!dest_k) {
> +        dest_key =3D psw_key;
> +    }
> +    if (!src_k) {
> +        src_key =3D psw_key;
> +    }
> +    if (!dest_a) {
> +        dest_as =3D psw_as;
> +    }
> +    if (!src_a) {
> +        src_as =3D psw_as;
> +    }

Not sure, but maybe it's nicer to write all this in a more compact way?

    src_k =3D (val >> 1) & 0x1;
    src_key =3D srk_k ? (val >> 12) & 0xf : psw_key;
    src_a =3D val & 0x1;
    src_as =3D src_a ? (val >> 6) & 0x3 : psw_as;

    ... etc ...

> +    if (dest_a && dest_as =3D=3D AS_HOME && (env->psw.mask & PSW_MASK_=
PSTATE)) {
> +        cpu_restore_state(cs, ra);
> +        program_interrupt(env, PGM_SPECIAL_OP, 6);
> +    }
> +    if (!(env->cregs[0] & CR0_SECONDARY) &&
> +        (dest_as =3D=3D AS_SECONDARY || src_as =3D=3D AS_SECONDARY)) {
> +        cpu_restore_state(cs, ra);
> +        program_interrupt(env, PGM_SPECIAL_OP, 6);
> +    }
> +    if (!psw_key_valid(env, dest_key) || !psw_key_valid(env, src_key))=
 {
> +        cpu_restore_state(cs, ra);
> +        program_interrupt(env, PGM_PRIVILEGED, 6);
> +    }
> +
> +    if (len > 4096) {
> +        cc =3D 3;
> +        len =3D 4096;
> +    }
> +
> +    /* FIXME: AR-mode and proper problem state mode (using PSW keys) m=
issing */
> +    if (src_as =3D=3D AS_ACCREG || dest_as =3D=3D AS_ACCREG ||
> +        (env->psw.mask & PSW_MASK_PSTATE)) {
> +        qemu_log_mask(LOG_UNIMP, "%s: AR-mode and PSTATE support missi=
ng\n",
> +                      __func__);
> +        cpu_restore_state(cs, ra);
> +        program_interrupt(env, PGM_ADDRESSING, 6);
> +    }
> +
> +    /* FIXME: a) LAP
> +     *        b) Access using correct keys
> +     *        c) AR-mode
> +     */
> +#ifndef CONFIG_USER_ONLY
> +    /* psw keys are never valid in user mode, we will never reach this=
 */
> +    fast_memmove_as(env, dest, src, len, dest_as, src_as, ra);
> +#endif
> +
> +    return cc;
> +}

Apart from the bikeshed-painting-worthy cosmetic nits, this looks fine
now to me. Thanks for tackling this!

 Thomas
