Received: from eggs.gnu.org ([2001:4830:134:3::10]:39531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fDSyL-0000Ni-2S
	for qemu-devel@nongnu.org; Tue, 01 May 2018 06:57:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fDSyK-0005Cd-98
	for qemu-devel@nongnu.org; Tue, 01 May 2018 06:57:25 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:38696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fDSyK-0005CF-21
	for qemu-devel@nongnu.org; Tue, 01 May 2018 06:57:24 -0400
Received: by mail-wr0-x243.google.com with SMTP id 94-v6so9181203wrf.5
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 03:57:23 -0700 (PDT)
References: <20180425012300.14698-1-richard.henderson@linaro.org>
	<20180425012300.14698-8-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180425012300.14698-8-richard.henderson@linaro.org>
Date: Tue, 01 May 2018 11:57:21 +0100
Message-ID: <87o9hzabji.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 7/9] target/arm: Implement FCVT (scalar,
 fixed-point) for fp16
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

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/translate-a64.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 4f6317aa0f..794ede7222 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -5372,8 +5372,7 @@ static void disas_fp_fixed_conv(DisasContext *s, ui=
nt32_t insn)
>      bool sf =3D extract32(insn, 31, 1);
>      bool itof;
>
> -    if (sbit || (type > 1)
> -        || (!sf && scale < 32)) {
> +    if (sbit || (!sf && scale < 32)) {
>          unallocated_encoding(s);
>          return;
>      }
> @@ -5392,6 +5391,20 @@ static void disas_fp_fixed_conv(DisasContext *s, u=
int32_t insn)
>          return;
>      }
>
> +    switch (type) {
> +    case 0: /* float32 */
> +    case 1: /* float64 */
> +        break;
> +    case 3: /* float16 */
> +        if (arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
> +            break;
> +        }
> +        /* fallthru */
> +    default:
> +        unallocated_encoding(s);
> +        return;
> +    }
> +
>      if (!fp_access_check(s)) {
>          return;
>      }


--
Alex Benn=C3=A9e
