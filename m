Received: from eggs.gnu.org ([2001:4830:134:3::10]:40783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dL2sS-0004oL-Tx
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:38:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dL2sN-0000cp-TI
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:38:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dL2sN-0000cS-K6
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:38:03 -0400
References: <20170613214736.19963-1-david@redhat.com>
	<20170613214736.19963-3-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cf5f341a-2446-31e5-1990-201a8015a38f@redhat.com>
Date: Wed, 14 Jun 2017 09:37:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170613214736.19963-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 2/3] target/s390x: implement mvcos
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

On 13.06.2017 23:47, David Hildenbrand wrote:
> This adds support for the MOVE WITH OPTIONAL SPECIFICATIONS (MVCOS)
> instruction (in a relatively slow way). But it is enough to boot
> a linux kernel that uses it for uacccess (primary <-> seconardy).
>=20
> We are missing (as for most other part) low address protection checks,
> PSW key / storage key checks and support for AR-mode.
>=20
> We fake an ADDRESSING exception when called from problem state (which
> seems to rely on PSW key checks to be in place) and if AR-mode is used.
>=20
> This patch is based on an original patch by Miroslav Benes (thanks!).
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h         |  19 ++++++++-
>  target/s390x/helper.c      |   4 +-
>  target/s390x/helper.h      |   1 +
>  target/s390x/insn-data.def |   2 +
>  target/s390x/mem_helper.c  | 104 +++++++++++++++++++++++++++++++++++++=
++++++++
>  target/s390x/translate.c   |  10 +++++
>  6 files changed, 137 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 532a4a0..8da7a91 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -304,6 +304,7 @@ void s390x_cpu_debug_excp_handler(CPUState *cs);
>  #undef PSW_MASK_WAIT
>  #undef PSW_MASK_PSTATE
>  #undef PSW_MASK_ASC
> +#undef PSW_SHIFT_ASC
>  #undef PSW_MASK_CC
>  #undef PSW_MASK_PM
>  #undef PSW_MASK_64
> @@ -320,6 +321,7 @@ void s390x_cpu_debug_excp_handler(CPUState *cs);
>  #define PSW_MASK_WAIT           0x0002000000000000ULL
>  #define PSW_MASK_PSTATE         0x0001000000000000ULL
>  #define PSW_MASK_ASC            0x0000C00000000000ULL
> +#define PSW_SHIFT_ASC           46
>  #define PSW_MASK_CC             0x0000300000000000ULL
>  #define PSW_MASK_PM             0x00000F0000000000ULL
>  #define PSW_MASK_64             0x0000000100000000ULL
> @@ -353,15 +355,30 @@ void s390x_cpu_debug_excp_handler(CPUState *cs);
>  #define FLAG_MASK_32            0x00001000
> =20
>  /* Control register 0 bits */
> +#define CR0_SECONDARY           0x0000002000000000ULL
>  #define CR0_LOWPROT             0x0000000010000000ULL
>  #define CR0_EDAT                0x0000000000800000ULL
> =20
> +/* Control register 3 bits */
> +#define CR3_PKM                 0x00000000ffff0000ULL
> +
>  /* MMU */
>  #define MMU_PRIMARY_IDX         0
>  #define MMU_SECONDARY_IDX       1
>  #define MMU_HOME_IDX            2
> =20
> -static inline int cpu_mmu_index (CPUS390XState *env, bool ifetch)
> +static inline bool psw_key_valid(CPUS390XState *env, uint8_t psw_key)
> +{
> +    uint16_t pkm =3D ((env->cregs[3] & CR3_PKM) >> 16);

Since you're storing the value in an uint16_t anyway, I think you could
also do this without the CR3_PKM masking.

> +    if (env->psw.mask & PSW_MASK_PSTATE) {
> +        /* PSW key has range 0..15, it is valid if the bit is 1 in the=
 PKM */
> +        return pkm & (1 << (psw_key & 0xff));

As Richard already noted, the "0xff" looks fishy here ... I'd remove it
completely - if someone calls this function with a psw_key > 15, they
should be punished by a "false" as return value anyway.

Also, not sure, but don't you need to use IBM-bit-numbering here? i.e.
rather use 0x80 >> psw_key instead?

> +    }
> +    return true;
> +}
> +
> +static inline int cpu_mmu_index(CPUS390XState *env, bool ifetch)
>  {
>      switch (env->psw.mask & PSW_MASK_ASC) {
>      case PSW_ASC_PRIMARY:
> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> index a468424..e5f4c6f 100644
> --- a/target/s390x/helper.c
> +++ b/target/s390x/helper.c
> @@ -749,8 +749,8 @@ void s390x_cpu_debug_excp_handler(CPUState *cs)
>  }
> =20
>  /* Unaligned accesses are only diagnosed with MO_ALIGN.  At the moment=
,
> -   this is only for the atomic operations, for which we want to raise =
a
> -   specification exception.  */
> +   this is only for operations, for which we want to raise a specifica=
tion
> +   exception.  */

Unrelated to this patch?

>  void s390x_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>                                     MMUAccessType access_type,
>                                     int mmu_idx, uintptr_t retaddr)
> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> index 69249a5..505f390 100644
> --- a/target/s390x/helper.h
> +++ b/target/s390x/helper.h
> @@ -126,6 +126,7 @@ DEF_HELPER_FLAGS_2(tprot, TCG_CALL_NO_RWG, i32, i64=
, i64)
>  DEF_HELPER_FLAGS_2(iske, TCG_CALL_NO_RWG_SE, i64, env, i64)
>  DEF_HELPER_FLAGS_3(sske, TCG_CALL_NO_RWG, void, env, i64, i64)
>  DEF_HELPER_FLAGS_2(rrbe, TCG_CALL_NO_RWG, i32, env, i64)
> +DEF_HELPER_4(mvcos, i32, env, i64, i64, i64)
>  DEF_HELPER_4(mvcs, i32, env, i64, i64, i64)
>  DEF_HELPER_4(mvcp, i32, env, i64, i64, i64)
>  DEF_HELPER_4(sigp, i32, env, i64, i32, i64)
> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
> index d089707..6842de3 100644
> --- a/target/s390x/insn-data.def
> +++ b/target/s390x/insn-data.def
> @@ -918,6 +918,8 @@
>  /* LOAD USING REAL ADDRESS */
>      C(0xb24b, LURA,    RRE,   Z,   0, r2, new, r1_32, lura, 0)
>      C(0xb905, LURAG,   RRE,   Z,   0, r2, r1, 0, lurag, 0)
> +/* MOVE WITH OPTIONAL SPECIFICATION */
> +    C(0xc800, MVCOS,   SSF,   MVCOS, la1, a2, 0, 0, mvcos, 0)
>  /* MOVE TO PRIMARY */
>      C(0xda00, MVCP,    SS_d,  Z,   la1, a2, 0, 0, mvcp, 0)
>  /* MOVE TO SECONDARY */
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index 80caab9..cb27465 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -1493,6 +1493,110 @@ uint32_t HELPER(rrbe)(CPUS390XState *env, uint6=
4_t r2)
>      return re >> 1;
>  }
> =20
> +uint32_t HELPER(mvcos)(CPUS390XState *env, uint64_t dest, uint64_t src=
,
> +                       uint64_t len)
> +{
> +    const uint64_t r0 =3D env->regs[0];
> +    const uint8_t psw_key =3D (env->psw.mask & PSW_MASK_KEY) >> PSW_SH=
IFT_KEY;
> +    const uint8_t psw_as =3D (env->psw.mask & PSW_MASK_ASC) >> PSW_SHI=
FT_ASC;
> +    const uintptr_t ra =3D GETPC();
> +    uint8_t dest_key, dest_as, dest_k, dest_a;
> +    uint8_t src_key, src_as, src_k, src_a;
> +    uint64_t val;
> +    int cc =3D 0, i;
> +
> +    HELPER_LOG("%s dest %" PRIx64 ", src %" PRIx64 ", len %" PRIx64 "\=
n",
> +               __func__, dest, src, len);
> +
> +    if (!(env->psw.mask & PSW_MASK_DAT)) {
> +        program_interrupt(env, PGM_SPECIAL_OP, 6);
> +    }
> +
> +    /* OAC (operand access control) for the first operand -> dest */
> +    val =3D (r0 & 0xffff0000ULL) >> 16;
> +    dest_key =3D (val >> 12) & 0xf;
> +    dest_as =3D (val >> 6) & 0x3;
> +    dest_k =3D (val >> 1) & 0x1;
> +    dest_a =3D (val) & 0x1;

You could omit the parentheses in the last line.

> +    /* OAC (operand access control) for the second operand -> src */
> +    val =3D (r0 & 0x0000ffffULL);
> +    src_key =3D (val >> 12) & 0xf;
> +    src_as =3D (val >> 6) & 0x3;
> +    src_k =3D (val >> 1) & 0x1;
> +    src_a =3D (val) & 0x1;

dito.

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
> +
> +    if (dest_a && dest_as =3D=3D 0x11 && (env->psw.mask & PSW_MASK_PST=
ATE)) {

s/0x11/0b11/ ... or better use 3.

> +        program_interrupt(env, PGM_SPECIAL_OP, 6);
> +    }
> +    if (!(env->cregs[0] & CR0_SECONDARY) &&
> +        (dest_as =3D=3D 0x10 || src_as =3D=3D 0x10)) {

s/0x10/2/g

> +        program_interrupt(env, PGM_SPECIAL_OP, 6);
> +    }
> +    if (!psw_key_valid(env, dest_key) || !psw_key_valid(env, src_key))=
 {
> +        program_interrupt(env, PGM_PRIVILEGED, 6);
> +    }
> +    /* FIXME: AR-mode and proper problem state mode (using PSW keys) m=
issing */
> +    if ((src_as | dest_as) =3D=3D 0x01 || (env->psw.mask & PSW_MASK_PS=
TATE)) {

Could you also use a qemu_log_mask(LOG_UNIMP, ...) statement here, please=
?

> +        program_interrupt(env, PGM_ADDRESSING, 6);
> +    }

I think you should also mask the length with 0xffffffff if the PSW was
not in 64-bit mode? Or is this done automagically by the generated TCG
code already?

> +    if (len > 4096) {
> +        cc =3D 3;
> +        len =3D 4096;
> +    }
> +
> +    /*
> +     * FIXME: a) LAP protection
> +     *        b) Access using correct PSW keys
> +     *        c) AR-mode (mmu support missing)
> +     *        d) bulk transfer
> +     */
> +    for (i =3D 0; i < len; i++, src++, dest++) {
> +        uint8_t x =3D 0;
> +
> +        src =3D wrap_address(env, src);
> +        dest =3D wrap_address(env, dest);
> +        switch (src_as) {
> +        case 0x0:
> +            x =3D cpu_ldub_primary_ra(env, src, ra);
> +            break;
> +        case 0x2:
> +            x =3D cpu_ldub_secondary_ra(env, src, ra);
> +            break;
> +        case 0x3:
> +            x =3D cpu_ldub_home_ra(env, src, ra);
> +            break;
> +        }
> +        switch (dest_as) {
> +        case 0x0:
> +            cpu_stb_primary_ra(env, dest, x, ra);
> +            break;
> +        case 0x2:
> +            cpu_stb_secondary_ra(env, dest, x, ra);
> +            break;
> +        case 0x3:
> +            cpu_stb_home_ra(env, dest, x, ra);
> +            break;
> +        }

I wonder whether we should have some proper #defines for those AS values
... something like:

#define AS_PRIMARY    0
#define AS_ACCREG     1
#define AS_SECONDARY  2
#define AS_HOME       3

?

 Thomas


> +    }
> +
> +    return cc;
> +}
> +
