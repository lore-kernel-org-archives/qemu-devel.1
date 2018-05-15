Received: from eggs.gnu.org ([2001:4830:134:3::10]:34224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIaMy-0004aq-8B
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:52:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIaMv-0006nW-3o
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:52:00 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:52657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fIaMu-0006n8-TS
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:51:57 -0400
Received: by mail-wm0-x242.google.com with SMTP id w194-v6so1189722wmf.2
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 06:51:56 -0700 (PDT)
References: <20180514221219.7091-1-richard.henderson@linaro.org>
	<20180514221219.7091-24-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180514221219.7091-24-richard.henderson@linaro.org>
Date: Tue, 15 May 2018 14:51:54 +0100
Message-ID: <877eo5f2md.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 23/28] fpu/softfloat: Make is_nan et al
 available to softfloat-specialize.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> We will need these helpers within softfloat-specialize.h, so move
> the definitions above the include.  After specialization, they will
> not always be used so mark them to avoid the Werror.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  fpu/softfloat.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index e9e421728b..9934adbae5 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -181,6 +181,22 @@ typedef enum __attribute__ ((__packed__)) {
>      float_class_snan,
>  } FloatClass;
>
> +/* Simple helpers for checking if, or what kind of, NaN we have */
> +static inline __attribute__((unused)) bool is_nan(FloatClass c)
> +{
> +    return unlikely(c >=3D float_class_qnan);
> +}
> +
> +static inline __attribute__((unused)) bool is_snan(FloatClass c)
> +{
> +    return c =3D=3D float_class_snan;
> +}
> +
> +static inline __attribute__((unused)) bool is_qnan(FloatClass c)
> +{
> +    return c =3D=3D float_class_qnan;
> +}
> +
>  /*
>   * Structure holding all of the decomposed parts of a float. The
>   * exponent is unbiased and the fraction is normalized. All
> @@ -536,20 +552,6 @@ static float64 float64_round_pack_canonical(FloatPar=
ts p, float_status *s)
>      return float64_pack_raw(round_canonical(p, s, &float64_params));
>  }
>
> -/* Simple helpers for checking if what NaN we have */
> -static bool is_nan(FloatClass c)
> -{
> -    return unlikely(c >=3D float_class_qnan);
> -}
> -static bool is_snan(FloatClass c)
> -{
> -    return c =3D=3D float_class_snan;
> -}
> -static bool is_qnan(FloatClass c)
> -{
> -    return c =3D=3D float_class_qnan;
> -}
> -
>  static FloatParts return_nan(FloatParts a, float_status *s)
>  {
>      switch (a.cls) {


--
Alex Benn=C3=A9e
