Received: from eggs.gnu.org ([2001:4830:134:3::10]:48169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gPsZg-0004A8-6m
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 12:15:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gPsZY-0004aY-F9
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 12:15:30 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:33578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gPsZY-0004YT-6P
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 12:15:24 -0500
Received: by mail-wm1-x32b.google.com with SMTP id 79so9980310wmo.0
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 09:15:23 -0800 (PST)
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-14-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025172057.20414-14-cota@braap.org>
Date: Thu, 22 Nov 2018 17:15:20 +0000
Message-ID: <87zhu1ghjr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 13/48] xxhash: add qemu_xxhash8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>


Emilio G. Cota <cota@braap.org> writes:

> It will be used for TB hashing soon.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/qemu/xxhash.h | 40 +++++++++++++++++++++++++++-------------
>  1 file changed, 27 insertions(+), 13 deletions(-)
>
> diff --git a/include/qemu/xxhash.h b/include/qemu/xxhash.h
> index fe35dde328..450427eeaa 100644
> --- a/include/qemu/xxhash.h
> +++ b/include/qemu/xxhash.h
> @@ -49,7 +49,8 @@
>   * contiguous in memory.
>   */
>  static inline uint32_t
> -qemu_xxhash7(uint64_t ab, uint64_t cd, uint32_t e, uint32_t f, uint32_t =
g)
> +qemu_xxhash8(uint64_t ab, uint64_t cd, uint32_t e, uint32_t f, uint32_t =
g,
> +             uint32_t h)

As we've expanded to bigger and bigger hashes why are everything after
cd passed as 32 bit values? Isn't this just generating extra register
pressure or is the compiler smart enough to figure it out?

>  {
>      uint32_t v1 =3D QEMU_XXHASH_SEED + PRIME32_1 + PRIME32_2;
>      uint32_t v2 =3D QEMU_XXHASH_SEED + PRIME32_2;
> @@ -77,17 +78,24 @@ qemu_xxhash7(uint64_t ab, uint64_t cd, uint32_t e, ui=
nt32_t f, uint32_t g)
>      v4 =3D rol32(v4, 13);
>      v4 *=3D PRIME32_1;
>
> -    h32 =3D rol32(v1, 1) + rol32(v2, 7) + rol32(v3, 12) + rol32(v4, 18);
> -    h32 +=3D 28;
> +    v1 +=3D e * PRIME32_2;
> +    v1 =3D rol32(v1, 13);
> +    v1 *=3D PRIME32_1;
>
> -    h32 +=3D e * PRIME32_3;
> -    h32  =3D rol32(h32, 17) * PRIME32_4;
> +    v2 +=3D f * PRIME32_2;
> +    v2 =3D rol32(v2, 13);
> +    v2 *=3D PRIME32_1;
> +
> +    v3 +=3D g * PRIME32_2;
> +    v3 =3D rol32(v3, 13);
> +    v3 *=3D PRIME32_1;
>
> -    h32 +=3D f * PRIME32_3;
> -    h32  =3D rol32(h32, 17) * PRIME32_4;
> +    v4 +=3D h * PRIME32_2;
> +    v4 =3D rol32(v4, 13);
> +    v4 *=3D PRIME32_1;
>
> -    h32 +=3D g * PRIME32_3;
> -    h32  =3D rol32(h32, 17) * PRIME32_4;
> +    h32 =3D rol32(v1, 1) + rol32(v2, 7) + rol32(v3, 12) + rol32(v4, 18);
> +    h32 +=3D 32;

How do we validate we haven't broken the distribution of the original
xxhash as we've extended it?

>
>      h32 ^=3D h32 >> 15;
>      h32 *=3D PRIME32_2;
> @@ -100,23 +108,29 @@ qemu_xxhash7(uint64_t ab, uint64_t cd, uint32_t e, =
uint32_t f, uint32_t g)
>
>  static inline uint32_t qemu_xxhash2(uint64_t ab)
>  {
> -    return qemu_xxhash7(ab, 0, 0, 0, 0);
> +    return qemu_xxhash8(ab, 0, 0, 0, 0, 0);
>  }
>
>  static inline uint32_t qemu_xxhash4(uint64_t ab, uint64_t cd)
>  {
> -    return qemu_xxhash7(ab, cd, 0, 0, 0);
> +    return qemu_xxhash8(ab, cd, 0, 0, 0, 0);
>  }
>
>  static inline uint32_t qemu_xxhash5(uint64_t ab, uint64_t cd, uint32_t e)
>  {
> -    return qemu_xxhash7(ab, cd, e, 0, 0);
> +    return qemu_xxhash8(ab, cd, e, 0, 0, 0);
>  }
>
>  static inline uint32_t qemu_xxhash6(uint64_t ab, uint64_t cd, uint32_t e,
>                                      uint32_t f)
>  {
> -    return qemu_xxhash7(ab, cd, e, f, 0);
> +    return qemu_xxhash8(ab, cd, e, f, 0, 0);
> +}
> +
> +static inline uint32_t qemu_xxhash7(uint64_t ab, uint64_t cd, uint32_t e,
> +                                    uint32_t f, uint32_t g)
> +{
> +    return qemu_xxhash8(ab, cd, e, f, g, 0);
>  }
>
>  #endif /* QEMU_XXHASH_H */


--
Alex Benn=C3=A9e
