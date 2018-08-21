Received: from eggs.gnu.org ([2001:4830:134:3::10]:40552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fs1NX-0003v6-Nv
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fs1NU-0003y0-EI
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:47:03 -0400
References: <20180821025104.19604-1-pavel.zbitskiy@gmail.com>
	<20180821025104.19604-8-pavel.zbitskiy@gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <95fef119-85f8-7b3f-18a1-e125ca341a40@redhat.com>
Date: Tue, 21 Aug 2018 09:46:58 +0200
MIME-Version: 1.0
In-Reply-To: <20180821025104.19604-8-pavel.zbitskiy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 7/7] target/s390x: implement CVB,
 CVBY and CVBG
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

On 21.08.2018 04:51, Pavel Zbitskiy wrote:
> Convert to Binary - counterparts of the already implemented Convert
> to Decimal (CVD*) instructions.
> Example from the Principles of Operation: 25594C becomes 63FA.
>=20
> Signed-off-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
> ---
>  target/s390x/helper.h           |  1 +
>  target/s390x/insn-data.def      |  4 +++
>  target/s390x/int_helper.c       | 50 +++++++++++++++++++++++++++++++++
>  target/s390x/translate.c        | 10 +++++++
>  tests/tcg/s390x/Makefile.target |  1 +
>  tests/tcg/s390x/cvb.c           | 18 ++++++++++++
>  6 files changed, 84 insertions(+)
>  create mode 100644 tests/tcg/s390x/cvb.c
>=20
> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> index 97c60ca7bc..46baaee0ab 100644
> --- a/target/s390x/helper.h
> +++ b/target/s390x/helper.h
> @@ -88,6 +88,7 @@ DEF_HELPER_FLAGS_4(tcxb, TCG_CALL_NO_RWG_SE, i32, env=
, i64, i64, i64)
>  DEF_HELPER_FLAGS_2(sqeb, TCG_CALL_NO_WG, i64, env, i64)
>  DEF_HELPER_FLAGS_2(sqdb, TCG_CALL_NO_WG, i64, env, i64)
>  DEF_HELPER_FLAGS_3(sqxb, TCG_CALL_NO_WG, i64, env, i64, i64)
> +DEF_HELPER_FLAGS_3(cvb, TCG_CALL_NO_WG, i64, env, i64, i32)
>  DEF_HELPER_FLAGS_1(cvd, TCG_CALL_NO_RWG_SE, i64, s32)
>  DEF_HELPER_FLAGS_4(pack, TCG_CALL_NO_WG, void, env, i32, i64, i64)
>  DEF_HELPER_FLAGS_4(pka, TCG_CALL_NO_WG, void, env, i64, i64, i32)
> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
> index 9c7b434fca..1b29a5e044 100644
> --- a/target/s390x/insn-data.def
> +++ b/target/s390x/insn-data.def
> @@ -284,6 +284,10 @@
>      D(0xec73, CLFIT,   RIE_a, GIE, r1_32u, i2_32u, 0, 0, ct, 0, 1)
>      D(0xec71, CLGIT,   RIE_a, GIE, r1_o, i2_32u, 0, 0, ct, 0, 1)
> =20
> +/* CONVERT TO BINARY */
> +    C(0x4f00, CVB,     RX_a,  Z,   0, a2, new, r1_32, cvb, 0)
> +    C(0xe306, CVBY,    RXY_a, LD,  0, a2, new, r1_32, cvb, 0)
> +    C(0xe30e, CVBG,    RXY_a, Z,   0, a2, r1, 0, cvb, 0)

use in1_la2 instead, so you can use o->addr in the handler.

>  /* CONVERT TO DECIMAL */
>      C(0x4e00, CVD,     RX_a,  Z,   r1_o, a2, 0, 0, cvd, 0)
>      C(0xe326, CVDY,    RXY_a, LD,  r1_o, a2, 0, 0, cvd, 0)
> diff --git a/target/s390x/int_helper.c b/target/s390x/int_helper.c
> index abf77a94e6..66c6dc8b3a 100644
> --- a/target/s390x/int_helper.c
> +++ b/target/s390x/int_helper.c
> @@ -24,6 +24,7 @@
>  #include "exec/exec-all.h"
>  #include "qemu/host-utils.h"
>  #include "exec/helper-proto.h"
> +#include "exec/cpu_ldst.h"
> =20
>  /* #define DEBUG_HELPER */
>  #ifdef DEBUG_HELPER
> @@ -118,6 +119,55 @@ uint64_t HELPER(divu64)(CPUS390XState *env, uint64=
_t ah, uint64_t al,
>      return ret;
>  }
> =20
> +static void general_operand_exception(CPUS390XState *env, uintptr_t ra=
)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    LowCore *lowcore;
> +
> +    lowcore =3D cpu_map_lowcore(env);
> +    lowcore->data_exc_code =3D 0;
> +    cpu_unmap_lowcore(lowcore);
> +#endif
> +    s390_program_interrupt(env, PGM_DATA, ILEN_AUTO, ra);
> +}
> +
> +uint64_t HELPER(cvb)(CPUS390XState *env, uint64_t src, uint32_t n)
> +{
> +    int i, j;
> +    uintptr_t ra =3D GETPC();

You could make this const

> +    int64_t dec, sign =3D 0, digit, val =3D 0, pow10 =3D 0;
> +
> +    for (i =3D 0; i < n; i++) {

When manually creating addresses, we should usually wrap to catch some
special cases (address space wraparound).

tmpsrc =3D wrap_address(env, src + (n - i - 1) * 8);

> +        dec =3D cpu_ldq_data_ra(env, src + (n - i - 1) * 8, ra);
> +        for (j =3D 0; j < 16; j++, dec >>=3D 4) {
> +            if (i =3D=3D 0 && j =3D=3D 0) {
> +                sign =3D dec & 0xf;
> +                if (sign < 0xa) {
> +                    general_operand_exception(env, ra);
> +                }
> +                continue;
> +            }
> +            digit =3D dec & 0xf;
> +            if (digit > 0x9) {
> +                general_operand_exception(env, ra);
> +            }
> +            if (i =3D=3D 0 && j =3D=3D 1) {
> +                if (sign =3D=3D 0xb || sign =3D=3D 0xd) {
> +                    val =3D -digit;
> +                    pow10 =3D -10;
> +                } else {
> +                    val =3D digit;
> +                    pow10 =3D 10;
> +                }
> +            } else {
> +                val +=3D digit * pow10;
> +                pow10 *=3D 10;
> +            }
> +        }
> +    }
> +    return val;
> +}
> +
>  uint64_t HELPER(cvd)(int32_t reg)
>  {
>      /* positive 0 */
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index f58b36b789..b3cbfead5d 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -2115,6 +2115,16 @@ static DisasJumpType op_csp(DisasContext *s, Dis=
asOps *o)
>  }
>  #endif
> =20
> +static DisasJumpType op_cvb(DisasContext *s, DisasOps *o)
> +{
> +    uint64_t n =3D ((s->fields->op =3D=3D 0xE3) && (s->fields->op2 =3D=
=3D 0x0E)) ?
> +        /* CVBG */      2 :
> +        /* CVB, CVBY */ 1;
> +
> +    gen_helper_cvb(o->out, cpu_env, o->in2, tcg_const_i32(n));

You are missing to free the tcg_const_i32() created variable.

> +    return DISAS_NEXT;
> +}
> +



--=20

Thanks,

David / dhildenb
