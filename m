Received: from eggs.gnu.org ([2001:4830:134:3::10]:39663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fsUrW-00020h-Lm
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 11:15:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fsUrR-0004nE-MN
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 11:15:58 -0400
References: <20180822144039.5796-1-pavel.zbitskiy@gmail.com>
	<20180822144039.5796-3-pavel.zbitskiy@gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b1a7db4b-0fff-2e99-c12b-82141bc777bb@redhat.com>
Date: Wed, 22 Aug 2018 17:15:49 +0200
MIME-Version: 1.0
In-Reply-To: <20180822144039.5796-3-pavel.zbitskiy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/3] target/s390x: exception on
 non-aligned LPSW(E)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, richard.henderson@linaro.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On 22.08.2018 16:40, Pavel Zbitskiy wrote:
> Both LPSW and LPSWE should raise a specification exception when their
> operand is not doubleword aligned.
>=20
> This could've been done without a helper, but this would introduce a
> new basic block, which would require making o->in2 local. This
> could've also been done in load_psw helper, but this is too late -
> specification exception should be recognized before memory accesses
> take place.
>=20

In general, we can use MO_ALIGN to detect unaligned access (see e.g. op_s=
ck)

tcg_gen_qemu_ld_i64(o->out, a1, get_mem_index(s), mop | MO_ALIGN);

If I remember correctly, the check should be performed before actually
loading.

Can you use that instead?


> Signed-off-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
> ---
>  target/s390x/helper.h     |  1 +
>  target/s390x/mem_helper.c | 19 ++++++++++++-------
>  target/s390x/translate.c  |  8 ++++++++
>  3 files changed, 21 insertions(+), 7 deletions(-)
>=20
> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> index 97c60ca7bc..b0df3267e5 100644
> --- a/target/s390x/helper.h
> +++ b/target/s390x/helper.h
> @@ -120,6 +120,7 @@ DEF_HELPER_4(cu41, i32, env, i32, i32, i32)
>  DEF_HELPER_4(cu42, i32, env, i32, i32, i32)
>  DEF_HELPER_5(msa, i32, env, i32, i32, i32, i32)
>  DEF_HELPER_FLAGS_1(stpt, TCG_CALL_NO_RWG, i64, env)
> +DEF_HELPER_FLAGS_3(check_alignment, TCG_CALL_NO_RWG, void, env, i64, i=
32)
> =20
>  #ifndef CONFIG_USER_ONLY
>  DEF_HELPER_3(servc, i32, env, i64, i64)
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index bacae4f503..75ca1997ad 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -81,13 +81,18 @@ static inline uint32_t adj_len_to_page(uint32_t len=
, uint64_t addr)
>  /* Trigger a SPECIFICATION exception if an address or a length is not
>     naturally aligned.  */
>  static inline void check_alignment(CPUS390XState *env, uint64_t v,
> -                                   int wordsize, uintptr_t ra)
> +                                   uint32_t wordsize, int ilen, uintpt=
r_t ra)
>  {
>      if (v % wordsize) {
> -        s390_program_interrupt(env, PGM_SPECIFICATION, 6, ra);
> +        s390_program_interrupt(env, PGM_SPECIFICATION, ilen, ra);
>      }
>  }
> =20
> +void HELPER(check_alignment)(CPUS390XState *env, uint64_t v, uint32_t =
wordsize)
> +{
> +    check_alignment(env, v, wordsize, ILEN_AUTO, GETPC());
> +}
> +
>  /* Load a value from memory according to its size.  */
>  static inline uint64_t cpu_ldusize_data_ra(CPUS390XState *env, uint64_=
t addr,
>                                             int wordsize, uintptr_t ra)
> @@ -847,7 +852,7 @@ static inline uint32_t do_clcl(CPUS390XState *env,
>      uint64_t len =3D MAX(*src1len, *src3len);
>      uint32_t cc =3D 0;
> =20
> -    check_alignment(env, *src1len | *src3len, wordsize, ra);
> +    check_alignment(env, *src1len | *src3len, wordsize, 6, ra);
> =20
>      if (!len) {
>          return cc;
> @@ -1348,7 +1353,7 @@ uint32_t HELPER(trXX)(CPUS390XState *env, uint32_=
t r1, uint32_t r2,
>          tbl &=3D -8;
>      }
> =20
> -    check_alignment(env, len, ssize, ra);
> +    check_alignment(env, len, ssize, 6, ra);
> =20
>      /* Lest we fail to service interrupts in a timely manner, */
>      /* limit the amount of work we're willing to do.   */
> @@ -1400,7 +1405,7 @@ static void do_cdsg(CPUS390XState *env, uint64_t =
addr,
>      } else {
>          uint64_t oldh, oldl;
> =20
> -        check_alignment(env, addr, 16, ra);
> +        check_alignment(env, addr, 16, 6, ra);
> =20
>          oldh =3D cpu_ldq_data_ra(env, addr + 0, ra);
>          oldl =3D cpu_ldq_data_ra(env, addr + 8, ra);
> @@ -2116,7 +2121,7 @@ static uint64_t do_lpq(CPUS390XState *env, uint64=
_t addr, bool parallel)
>          lo =3D int128_getlo(v);
>  #endif
>      } else {
> -        check_alignment(env, addr, 16, ra);
> +        check_alignment(env, addr, 16, 6, ra);
> =20
>          hi =3D cpu_ldq_data_ra(env, addr + 0, ra);
>          lo =3D cpu_ldq_data_ra(env, addr + 8, ra);
> @@ -2153,7 +2158,7 @@ static void do_stpq(CPUS390XState *env, uint64_t =
addr,
>          helper_atomic_sto_be_mmu(env, addr, v, oi, ra);
>  #endif
>      } else {
> -        check_alignment(env, addr, 16, ra);
> +        check_alignment(env, addr, 16, 6, ra);
> =20
>          cpu_stq_data_ra(env, addr + 0, high, ra);
>          cpu_stq_data_ra(env, addr + 8, low, ra);
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 7363aabf3a..4161bd0b1f 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -2828,9 +2828,13 @@ static DisasJumpType op_lpp(DisasContext *s, Dis=
asOps *o)
> =20
>  static DisasJumpType op_lpsw(DisasContext *s, DisasOps *o)
>  {
> +    TCGv_i32 t0;
>      TCGv_i64 t1, t2;
> =20
>      check_privileged(s);
> +    t0 =3D tcg_const_i32(8);
> +    gen_helper_check_alignment(cpu_env, o->in2, t0);
> +    tcg_temp_free_i32(t0);
>      per_breaking_event(s);
> =20
>      t1 =3D tcg_temp_new_i64();
> @@ -2848,9 +2852,13 @@ static DisasJumpType op_lpsw(DisasContext *s, Di=
sasOps *o)
> =20
>  static DisasJumpType op_lpswe(DisasContext *s, DisasOps *o)
>  {
> +    TCGv_i32 t0;
>      TCGv_i64 t1, t2;
> =20
>      check_privileged(s);
> +    t0 =3D tcg_const_i32(8);
> +    gen_helper_check_alignment(cpu_env, o->in2, t0);
> +    tcg_temp_free_i32(t0);
>      per_breaking_event(s);
> =20
>      t1 =3D tcg_temp_new_i64();
>=20


--=20

Thanks,

David / dhildenb
