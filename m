Received: from eggs.gnu.org ([2001:4830:134:3::10]:56543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f8R1T-00076L-6O
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 09:51:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f8R1P-0002yN-4w
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 09:51:51 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:40779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f8R1O-0002xc-U2
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 09:51:47 -0400
Received: by mail-wr0-x244.google.com with SMTP id v60so31883040wrc.7
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 06:51:46 -0700 (PDT)
References: <20180417025328.25431-1-richard.henderson@linaro.org>
	<20180417025328.25431-3-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180417025328.25431-3-richard.henderson@linaro.org>
Date: Tue, 17 Apr 2018 14:51:44 +0100
Message-ID: <871sfeaqkv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] fpu: Bound increment for scalbn
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

> Without bounding the increment, we can overflow exp either here
> in scalbn_decomposed or when adding the bias in round_canonical.
> This can result in e.g. underflowing to 0 instead of overflowing
> to infinity.
>
> The old softfloat code did bound the increment.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  fpu/softfloat.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index ba6e654050..a589f328c9 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -1883,6 +1883,12 @@ static FloatParts scalbn_decomposed(FloatParts a, =
int n, float_status *s)
>          return return_nan(a, s);
>      }
>      if (a.cls =3D=3D float_class_normal) {
> +        /* The largest float type (even though not supported by FloatPar=
ts)
> +         * is float128, which has a 15 bit exponent.  Bounding N to 16 b=
its
> +         * still allows rounding to infinity, without allowing overflow
> +         * within the int32_t that backs FloatParts.exp.
> +         */
> +        n =3D MIN(MAX(n, -0x10000), 0x10000);
>          a.exp +=3D n;
>      }
>      return a;

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

(risu FWIW although it obviously didn't catch this failure ;-)

--
Alex Benn=C3=A9e
