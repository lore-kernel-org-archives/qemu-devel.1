Received: from eggs.gnu.org ([2001:4830:134:3::10]:45864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gUFax-0003km-I6
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 13:38:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gUFWZ-0001RT-HN
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 13:34:26 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gUFWX-0001Qa-Qz
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 13:34:22 -0500
Received: by mail-wr1-x443.google.com with SMTP id x10so17039619wrs.8
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 10:34:21 -0800 (PST)
References: <20181124235553.17371-1-cota@braap.org>
	<20181124235553.17371-9-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181124235553.17371-9-cota@braap.org>
Date: Tue, 04 Dec 2018 18:34:18 +0000
Message-ID: <87bm612lat.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 08/13] hardfloat: implement float32/64
 addition and subtraction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> Performance results (single and double precision) for fp-bench:
>
> 1. Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz
> - before:
> add-single: 135.07 MFlops
> add-double: 131.60 MFlops
> sub-single: 130.04 MFlops
> sub-double: 133.01 MFlops
> - after:
> add-single: 443.04 MFlops
> add-double: 301.95 MFlops
> sub-single: 411.36 MFlops
> sub-double: 293.15 MFlops
>
> 2. ARM Aarch64 A57 @ 2.4GHz
> - before:
> add-single: 44.79 MFlops
> add-double: 49.20 MFlops
> sub-single: 44.55 MFlops
> sub-double: 49.06 MFlops
> - after:
> add-single: 93.28 MFlops
> add-double: 88.27 MFlops
> sub-single: 91.47 MFlops
> sub-double: 88.27 MFlops
>
> 3. IBM POWER8E @ 2.1 GHz
> - before:
> add-single: 72.59 MFlops
> add-double: 72.27 MFlops
> sub-single: 75.33 MFlops
> sub-double: 70.54 MFlops
> - after:
> add-single: 112.95 MFlops
> add-double: 201.11 MFlops
> sub-single: 116.80 MFlops
> sub-double: 188.72 MFlops
>
> Note that the IBM and ARM machines benefit from having
> HARDFLOAT_2F{32,64}_USE_FP set to 0. Otherwise their performance
> can suffer significantly:

Is this just the latency of pushing the number into a SIMD register and
checking the flags compared to a bitmask check?

> - IBM Power8:
> add-single: [1] 54.94 vs [0] 116.37 MFlops
> add-double: [1] 58.92 vs [0] 201.44 MFlops
> - Aarch64 A57:
> add-single: [1] 80.72 vs [0] 93.24 MFlops
> add-double: [1] 82.10 vs [0] 88.18 MFlops
>
> On the Intel machine, having 2F64 set to 1 pays off, but it
> doesn't for 2F32:
> - Intel i7-6700K:
> add-single: [1] 285.79 vs [0] 426.70 MFlops
> add-double: [1] 302.15 vs [0] 278.82 MFlops
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  fpu/softfloat.c | 117 ++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 98 insertions(+), 19 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 306a12fa8d..cc500b1618 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -1050,49 +1050,128 @@ float16 QEMU_FLATTEN float16_add(float16 a, floa=
t16 b, float_status *status)
>      return float16_round_pack_canonical(pr, status);
>  }
>
> -float32 QEMU_FLATTEN float32_add(float32 a, float32 b, float_status *sta=
tus)
> +float16 QEMU_FLATTEN float16_sub(float16 a, float16 b, float_status *sta=
tus)
> +{
> +    FloatParts pa =3D float16_unpack_canonical(a, status);
> +    FloatParts pb =3D float16_unpack_canonical(b, status);
> +    FloatParts pr =3D addsub_floats(pa, pb, true, status);
> +
> +    return float16_round_pack_canonical(pr, status);
> +}

Hmm the diff is confusing but the changes look fine in the final code:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
