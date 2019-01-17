Received: from eggs.gnu.org ([209.51.188.92]:51473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gk0r2-0008G2-2X
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 01:08:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gk0r1-0000eV-Bx
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 01:08:40 -0500
References: <20190116202349.29272-1-alex.bennee@linaro.org>
	<20190116202349.29272-5-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f12177d7-421f-8d3b-48f0-099f16461b4d@redhat.com>
Date: Thu, 17 Jan 2019 07:08:29 +0100
MIME-Version: 1.0
In-Reply-To: <20190116202349.29272-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/7] softfloat: fallback to __int128
 maths for s390x and others
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, "open list:S390" <qemu-s390x@nongnu.org>

On 2019-01-16 21:23, Alex Benn=C3=A9e wrote:
> Apparently some versions of clang can't handle inline assembly with
> __int128 parameters, especially on s390. Instead of hand-coding the
> s390 divide provide a generic fallback for anything that provides
> __int128 capable maths.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Thomas Huth <thuth@redhat.com>
> ---
>  include/fpu/softfloat-macros.h | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-mac=
ros.h
> index b1d772e6d4..1a43609eef 100644
> --- a/include/fpu/softfloat-macros.h
> +++ b/include/fpu/softfloat-macros.h
> @@ -641,12 +641,6 @@ static inline uint64_t udiv_qrnnd(uint64_t *r, uin=
t64_t n1,
>      uint64_t q;
>      asm("divq %4" : "=3Da"(q), "=3Dd"(*r) : "0"(n0), "1"(n1), "rm"(d))=
;
>      return q;
> -#elif defined(__s390x__)
> -    /* Need to use a TImode type to get an even register pair for DLGR=
.  */
> -    unsigned __int128 n =3D (unsigned __int128)n1 << 64 | n0;
> -    asm("dlgr %0, %1" : "+r"(n) : "r"(d));
> -    *r =3D n >> 64;
> -    return n;
>  #elif defined(_ARCH_PPC64) && defined(_ARCH_PWR7)
>      /* From Power ISA 2.06, programming note for divdeu.  */
>      uint64_t q1, q2, Q, r1, r2, R;
> @@ -663,6 +657,10 @@ static inline uint64_t udiv_qrnnd(uint64_t *r, uin=
t64_t n1,
>      }
>      *r =3D R;
>      return Q;
> +#elif defined(CONFIG_INT128)
> +    unsigned __int128 n =3D (unsigned __int128)n1 << 64 | n0;
> +    *r =3D n % d;
> +    return n / d;
>  #else
>      uint64_t d0, d1, q0, q1, r1, r0, m;

No, please don't. Use my !defined(__clang__) patch instead, please.

 Thomas
