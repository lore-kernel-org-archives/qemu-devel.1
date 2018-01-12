Received: from eggs.gnu.org ([2001:4830:134:3::10]:41466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ea26M-0006ba-FD
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:22:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ea26L-0004Pr-Hl
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:22:42 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:32936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ea26L-0004OD-CV
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:22:41 -0500
Received: by mail-ot0-x243.google.com with SMTP id x15so5490108ote.0
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 08:22:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180109122252.17670-14-alex.bennee@linaro.org>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-14-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2018 16:22:19 +0000
Message-ID: <CAFEAcA_H_aoRqEoS8ynNknxgF4pvYbOcP3PLBgu1fwZSKCXVwQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 13/20] fpu/softfloat: re-factor div
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, bharata@linux.vnet.ibm.com, Andrew Dutcher <andrew@andrewdutcher.com>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 9 January 2018 at 12:22, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote=
:
> We can now add float16_div and use the common decompose and
> canonicalize functions to have a single implementation for
> float16/32/64 versions.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  fpu/softfloat-macros.h  |  44 +++++++++
>  fpu/softfloat.c         | 235 ++++++++++++++++++------------------------=
------
>  include/fpu/softfloat.h |   1 +
>  3 files changed, 134 insertions(+), 146 deletions(-)
>
> diff --git a/fpu/softfloat-macros.h b/fpu/softfloat-macros.h
> index 9cc6158cb4..980be2c051 100644
> --- a/fpu/softfloat-macros.h
> +++ b/fpu/softfloat-macros.h
> @@ -625,6 +625,50 @@ static uint64_t estimateDiv128To64( uint64_t a0, uin=
t64_t a1, uint64_t b )
>
>  }
>
> +/* Nicked from gmp longlong.h __udiv_qrnnd */

Can we have a copyright/license attribution for code we nick
from other projects, please? :-)

> +static uint64_t div128To64(uint64_t n0, uint64_t n1, uint64_t d)
> +{
> +    uint64_t d0, d1, q0, q1, r1, r0, m;
> +
> +    d0 =3D (uint32_t)d;
> +    d1 =3D d >> 32;
> +
> +    r1 =3D n1 % d1;
> +    q1 =3D n1 / d1;
> +    m =3D q1 * d0;
> +    r1 =3D (r1 << 32) | (n0 >> 32);
> +    if (r1 < m) {
> +        q1 -=3D 1;
> +        r1 +=3D d;
> +        if (r1 >=3D d) {
> +            if (r1 < m) {
> +                q1 -=3D 1;
> +                r1 +=3D d;
> +            }
> +        }
> +    }
> +    r1 -=3D m;
> +
> +    r0 =3D r1 % d1;
> +    q0 =3D r1 / d1;
> +    m =3D q0 * d0;
> +    r0 =3D (r0 << 32) | (uint32_t)n0;
> +    if (r0 < m) {
> +        q0 -=3D 1;
> +        r0 +=3D d;
> +        if (r0 >=3D d) {
> +            if (r0 < m) {
> +                q0 -=3D 1;
> +                r0 +=3D d;
> +            }
> +        }
> +    }
> +    r0 -=3D m;
> +
> +    /* Return remainder in LSB */
> +    return (q1 << 32) | q0 | (r0 !=3D 0);
> +}

thanks
-- PMM
