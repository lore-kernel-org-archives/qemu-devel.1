Received: from eggs.gnu.org ([2001:4830:134:3::10]:59922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1g9tX6-0001RB-Ck
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:02:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1g9tX1-00008i-F5
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:02:48 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:33396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1g9tX1-00006N-0v
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:02:43 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181009125541.24455-5-berrange@redhat.com>
References: <20181009125541.24455-1-berrange@redhat.com>
	<20181009125541.24455-5-berrange@redhat.com>
Date: Tue, 09 Oct 2018 17:02:39 +0200
Message-ID: <w51h8hv88og.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/6] crypto: convert xts_tweak_encdec to
 use xts_uint128 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, qemu-devel@nongnu.org

On Tue 09 Oct 2018 02:55:39 PM CEST, Daniel P. Berrang=C3=A9 wrote:
> Using 64-bit arithmetic increases the performance for xts-aes-128
> when built with gcrypt:
>
>   Encrypt: 235 MB/s -> 320 MB/s
>   Decrypt: 245 MB/s -> 325 MB/s
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  crypto/xts.c | 52 +++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 33 insertions(+), 19 deletions(-)
>
> diff --git a/crypto/xts.c b/crypto/xts.c
> index ded4365191..f109c8a3ee 100644
> --- a/crypto/xts.c
> +++ b/crypto/xts.c
> @@ -31,6 +31,12 @@ typedef struct {
>      uint64_t b;
>  } xts_uint128;
>=20=20
> +#define xts_uint128_xor(D, S1, S2)              \
> +    do {                                        \
> +        (D)->a =3D (S1)->a ^ (S2)->a;             \
> +        (D)->b =3D (S1)->b ^ (S2)->b;             \
> +    } while (0)
> +
>  static void xts_mult_x(uint8_t *I)
>  {
>      int x;
> @@ -59,25 +65,19 @@ static void xts_mult_x(uint8_t *I)
>   */
>  static void xts_tweak_encdec(const void *ctx,
>                               xts_cipher_func *func,
> -                             const uint8_t *src,
> -                             uint8_t *dst,
> -                             uint8_t *iv)
> +                             const xts_uint128 *src,
> +                             xts_uint128 *dst,
> +                             xts_uint128 *iv)
>  {
> -    unsigned long x;
> -
>      /* tweak encrypt block i */
> -    for (x =3D 0; x < XTS_BLOCK_SIZE; x++) {
> -        dst[x] =3D src[x] ^ iv[x];
> -    }
> +    xts_uint128_xor(dst, src, iv);
>=20=20
> -    func(ctx, XTS_BLOCK_SIZE, dst, dst);
> +    func(ctx, XTS_BLOCK_SIZE, (uint8_t *)dst, (uint8_t *)dst);

In the line of what I said earlier, perhaps it's clearer if you leave
everything as uint8_t * and simply make xts_uint128_xor() treat the
array as xts_uint128 internally.

>      for (i =3D 0; i < lim; i++) {
> -        xts_tweak_encdec(datactx, decfunc, src, dst, (uint8_t *)&T);
> +        xts_uint128 S, D;
> +
> +        memcpy(&S, src, XTS_BLOCK_SIZE);
> +        xts_tweak_encdec(datactx, decfunc, &S, &D, &T);
> +        memcpy(dst, &D, XTS_BLOCK_SIZE);

Why do you need S and D?

Berto
