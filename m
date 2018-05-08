Received: from eggs.gnu.org ([2001:4830:134:3::10]:45290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG6Ys-0004Y7-NJ
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:38:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG6Yr-0007LG-Bt
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:38:02 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:42501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fG6Yr-0007L8-57
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:38:01 -0400
Received: by mail-ot0-x244.google.com with SMTP id l13-v6so37040787otk.9
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 10:38:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180508151437.4232-5-richard.henderson@linaro.org>
References: <20180508151437.4232-1-richard.henderson@linaro.org>
	<20180508151437.4232-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 May 2018 18:37:39 +0100
Message-ID: <CAFEAcA-6uQ4P=e7iJeNvPBVn6hxLFysG1-dLPdDeTpdpRn8mwQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 04/10] tcg: Introduce atomic helpers for
 integer min/max
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 8 May 2018 at 16:14, Richard Henderson <richard.henderson@linaro.org> wr=
ote:
> Given that this atomic operation will be used by both risc-v
> and aarch64, let's not duplicate code across the two targets.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/atomic_template.h | 71 +++++++++++++++++++++++++++++++++++++
>  accel/tcg/tcg-runtime.h     |  8 +++++
>  tcg/tcg-op.h                | 34 ++++++++++++++++++
>  tcg/tcg.h                   |  8 +++++
>  tcg/tcg-op.c                |  8 +++++
>  5 files changed, 129 insertions(+)
>
> diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
> index e022df4571..2489dd3ec1 100644
> --- a/accel/tcg/atomic_template.h
> +++ b/accel/tcg/atomic_template.h
> @@ -25,18 +25,22 @@
>  #elif DATA_SIZE =3D=3D 8
>  # define SUFFIX     q
>  # define DATA_TYPE  uint64_t
> +# define SDATA_TYPE int64_t
>  # define BSWAP      bswap64
>  #elif DATA_SIZE =3D=3D 4
>  # define SUFFIX     l
>  # define DATA_TYPE  uint32_t
> +# define SDATA_TYPE int32_t
>  # define BSWAP      bswap32
>  #elif DATA_SIZE =3D=3D 2
>  # define SUFFIX     w
>  # define DATA_TYPE  uint16_t
> +# define SDATA_TYPE int16_t
>  # define BSWAP      bswap16
>  #elif DATA_SIZE =3D=3D 1
>  # define SUFFIX     b
>  # define DATA_TYPE  uint8_t
> +# define SDATA_TYPE int8_t
>  # define BSWAP
>  #else
>  # error unsupported data size
> @@ -118,6 +122,39 @@ GEN_ATOMIC_HELPER(or_fetch)
>  GEN_ATOMIC_HELPER(xor_fetch)
>
>  #undef GEN_ATOMIC_HELPER
> +
> +/* These helpers are, as a whole, full barriers.  Within the helper,
> + * the leading barrier is explicit and the trailing barrier is within
> + * cmpxchg primitive.
> + */
> +#define GEN_ATOMIC_HELPER_FN(X, FN, XDATA_TYPE, RET)                \
> +ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
> +                        ABI_TYPE xval EXTRA_ARGS)                   \
> +{                                                                   \
> +    ATOMIC_MMU_DECLS;                                               \
> +    XDATA_TYPE *haddr =3D ATOMIC_MMU_LOOKUP;                          \
> +    XDATA_TYPE cmp, old, new, val =3D xval;                           \
> +    smp_mb();                                                       \
> +    cmp =3D atomic_read__nocheck(haddr);                              \
> +    do {                                                            \
> +        old =3D cmp; new =3D FN(old, val);                              =
\
> +        cmp =3D atomic_cmpxchg__nocheck(haddr, old, new);             \
> +    } while (cmp !=3D old);                                           \
> +    ATOMIC_MMU_CLEANUP;                                             \
> +    return RET;                                                     \
> +}
> +
> +GEN_ATOMIC_HELPER_FN(fetch_smin, MIN, SDATA_TYPE, old)
> +GEN_ATOMIC_HELPER_FN(fetch_umin, MIN,  DATA_TYPE, old)
> +GEN_ATOMIC_HELPER_FN(fetch_smax, MAX, SDATA_TYPE, old)
> +GEN_ATOMIC_HELPER_FN(fetch_umax, MAX,  DATA_TYPE, old)
> +
> +GEN_ATOMIC_HELPER_FN(smin_fetch, MIN, SDATA_TYPE, new)
> +GEN_ATOMIC_HELPER_FN(umin_fetch, MIN,  DATA_TYPE, new)
> +GEN_ATOMIC_HELPER_FN(smax_fetch, MAX, SDATA_TYPE, new)
> +GEN_ATOMIC_HELPER_FN(umax_fetch, MAX,  DATA_TYPE, new)

This fails to compile for me:
In file included from
/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/cputlb.c:1062:0:
/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/atomic_template.h:
In function =E2=80=98helper_atomic_fetch_sminb_mmu=E2=80=99:
/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/atomic_template.h:147=
:1:
error: value computed is not used [-Werror=3Dunused-value]
 GEN_ATOMIC_HELPER_FN(fetch_smin, MIN, SDATA_TYPE, old)
 ^
In file included from
/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/cputlb.c:1062:0:
/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/atomic_template.h:
In function =E2=80=98helper_atomic_fetch_smaxb_mmu=E2=80=99:
/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/atomic_template.h:149=
:1:
error: value computed is not used [-Werror=3Dunused-value]
 GEN_ATOMIC_HELPER_FN(fetch_smax, MAX, SDATA_TYPE, old)
 ^
In file included from
/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/cputlb.c:1062:0:
/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/atomic_template.h:
In function =E2=80=98helper_atomic_smin_fetchb_mmu=E2=80=99:
/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/atomic_template.h:152=
:1:
error: value computed is not used [-Werror=3Dunused-value]
 GEN_ATOMIC_HELPER_FN(smin_fetch, MIN, SDATA_TYPE, new)
 ^
In file included from
/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/cputlb.c:1062:0:
/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/atomic_template.h:
In function =E2=80=98helper_atomic_smax_fetchb_mmu=E2=80=99:
/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/atomic_template.h:154=
:1:
error: value computed is not used [-Werror=3Dunused-value]
 GEN_ATOMIC_HELPER_FN(smax_fetch, MAX, SDATA_TYPE, new)
 ^
In file included from
/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/cputlb.c:1090:0:
/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/atomic_template.h:
In function =E2=80=98helper_atomic_fetch_sminb=E2=80=99:
/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/atomic_template.h:147=
:1:
error: value computed is not used [-Werror=3Dunused-value]
 GEN_ATOMIC_HELPER_FN(fetch_smin, MIN, SDATA_TYPE, old)
 ^
In file included from
/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/cputlb.c:1090:0:
/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/atomic_template.h:
In function =E2=80=98helper_atomic_fetch_smaxb=E2=80=99:
/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/atomic_template.h:149=
:1:
error: value computed is not used [-Werror=3Dunused-value]
 GEN_ATOMIC_HELPER_FN(fetch_smax, MAX, SDATA_TYPE, old)
 ^
In file included from
/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/cputlb.c:1090:0:
/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/atomic_template.h:
In function =E2=80=98helper_atomic_smin_fetchb=E2=80=99:
/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/atomic_template.h:152=
:1:
error: value computed is not used [-Werror=3Dunused-value]
 GEN_ATOMIC_HELPER_FN(smin_fetch, MIN, SDATA_TYPE, new)
 ^
In file included from
/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/cputlb.c:1090:0:
/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/atomic_template.h:
In function =E2=80=98helper_atomic_smax_fetchb=E2=80=99:
/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/atomic_template.h:154=
:1:
error: value computed is not used [-Werror=3Dunused-value]
 GEN_ATOMIC_HELPER_FN(smax_fetch, MAX, SDATA_TYPE, new)
 ^

gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
configure arguments
exec '../../configure'
'--target-list=3Darm-softmmu,aarch64-softmmu,arm-linux-user,aarch64-linux-u=
ser'
'--enable-debug' '--cc=3Dccache gcc' '--audio-drv-list=3Dpa'
'--with-pkgversion=3Dpm215' "$@"

For some reason, only the signed versions get warnings...

thanks
-- PMM
