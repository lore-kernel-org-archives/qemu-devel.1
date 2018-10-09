Received: from eggs.gnu.org ([2001:4830:134:3::10]:34658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9sQB-0000lL-DD
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:51:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9sQA-0006Az-5Y
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:51:35 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1g9sQ9-00069U-SY
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:51:34 -0400
Received: by mail-wr1-x444.google.com with SMTP id l6-v6so1514656wrt.1
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 06:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20181009125541.24455-1-berrange@redhat.com>
	<20181009125541.24455-3-berrange@redhat.com>
In-Reply-To: <20181009125541.24455-3-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 9 Oct 2018 17:51:20 +0400
Message-ID: <CAJ+F1CJm=NVweKN2neKqJyLF+BhZudRYZuwsYq4GYt925c3a5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/6] crypto: remove code duplication in
 tweak encrypt/decrypt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Alberto Garcia <berto@igalia.com>

Hi

On Tue, Oct 9, 2018 at 4:56 PM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>
> The tweak encrypt/decrypt functions are identical except for the
> comments, so can be merged. Profiling data shows that the compiler is
> in fact already merging the two merges in the object files.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  crypto/xts.c | 64 ++++++++++++----------------------------------------
>  1 file changed, 15 insertions(+), 49 deletions(-)
>
> diff --git a/crypto/xts.c b/crypto/xts.c
> index 95212341f6..3c1a92f01d 100644
> --- a/crypto/xts.c
> +++ b/crypto/xts.c
> @@ -43,20 +43,20 @@ static void xts_mult_x(uint8_t *I)
>
>
>  /**
> - * xts_tweak_uncrypt:
> + * xts_tweak_encdec:
>   * @param ctxt: the cipher context
>   * @param func: the cipher function
> - * @src: buffer providing the cipher text of XTS_BLOCK_SIZE bytes
> - * @dst: buffer to output the plain text of XTS_BLOCK_SIZE bytes
> + * @src: buffer providing the input text of XTS_BLOCK_SIZE bytes
> + * @dst: buffer to output the output text of XTS_BLOCK_SIZE bytes
>   * @iv: the initialization vector tweak of XTS_BLOCK_SIZE bytes
>   *
> - * Decrypt data with a tweak
> + * Encrypt/decrypt data with a tweak
>   */
> -static void xts_tweak_decrypt(const void *ctx,
> -                              xts_cipher_func *func,
> -                              const uint8_t *src,
> -                              uint8_t *dst,
> -                              uint8_t *iv)
> +static void xts_tweak_encdec(const void *ctx,
> +                             xts_cipher_func *func,
> +                             const uint8_t *src,
> +                             uint8_t *dst,
> +                             uint8_t *iv)
>  {
>      unsigned long x;
>
> @@ -105,7 +105,7 @@ void xts_decrypt(const void *datactx,
>      encfunc(tweakctx, XTS_BLOCK_SIZE, T, iv);
>
>      for (i =3D 0; i < lim; i++) {
> -        xts_tweak_decrypt(datactx, decfunc, src, dst, T);
> +        xts_tweak_encdec(datactx, decfunc, src, dst, T);
>
>          src +=3D XTS_BLOCK_SIZE;
>          dst +=3D XTS_BLOCK_SIZE;
> @@ -117,7 +117,7 @@ void xts_decrypt(const void *datactx,
>          xts_mult_x(CC);
>
>          /* PP =3D tweak decrypt block m-1 */
> -        xts_tweak_decrypt(datactx, decfunc, src, PP, CC);
> +        xts_tweak_encdec(datactx, decfunc, src, PP, CC);
>
>          /* Pm =3D first length % XTS_BLOCK_SIZE bytes of PP */
>          for (i =3D 0; i < mo; i++) {
> @@ -129,7 +129,7 @@ void xts_decrypt(const void *datactx,
>          }
>
>          /* Pm-1 =3D Tweak uncrypt CC */
> -        xts_tweak_decrypt(datactx, decfunc, CC, dst, T);
> +        xts_tweak_encdec(datactx, decfunc, CC, dst, T);
>      }
>
>      /* Decrypt the iv back */
> @@ -137,40 +137,6 @@ void xts_decrypt(const void *datactx,
>  }
>
>
> -/**
> - * xts_tweak_crypt:
> - * @param ctxt: the cipher context
> - * @param func: the cipher function
> - * @src: buffer providing the plain text of XTS_BLOCK_SIZE bytes
> - * @dst: buffer to output the cipher text of XTS_BLOCK_SIZE bytes
> - * @iv: the initialization vector tweak of XTS_BLOCK_SIZE bytes
> - *
> - * Encrypt data with a tweak
> - */
> -static void xts_tweak_encrypt(const void *ctx,
> -                              xts_cipher_func *func,
> -                              const uint8_t *src,
> -                              uint8_t *dst,
> -                              uint8_t *iv)
> -{
> -    unsigned long x;
> -
> -    /* tweak encrypt block i */
> -    for (x =3D 0; x < XTS_BLOCK_SIZE; x++) {
> -        dst[x] =3D src[x] ^ iv[x];
> -    }
> -
> -    func(ctx, XTS_BLOCK_SIZE, dst, dst);
> -
> -    for (x =3D 0; x < XTS_BLOCK_SIZE; x++) {
> -        dst[x] =3D dst[x] ^ iv[x];
> -    }
> -
> -    /* LFSR the tweak */
> -    xts_mult_x(iv);
> -}
> -
> -
>  void xts_encrypt(const void *datactx,
>                   const void *tweakctx,
>                   xts_cipher_func *encfunc,
> @@ -200,7 +166,7 @@ void xts_encrypt(const void *datactx,
>      encfunc(tweakctx, XTS_BLOCK_SIZE, T, iv);
>
>      for (i =3D 0; i < lim; i++) {
> -        xts_tweak_encrypt(datactx, encfunc, src, dst, T);
> +        xts_tweak_encdec(datactx, encfunc, src, dst, T);
>
>          dst +=3D XTS_BLOCK_SIZE;
>          src +=3D XTS_BLOCK_SIZE;
> @@ -209,7 +175,7 @@ void xts_encrypt(const void *datactx,
>      /* if length is not a multiple of XTS_BLOCK_SIZE then */
>      if (mo > 0) {
>          /* CC =3D tweak encrypt block m-1 */
> -        xts_tweak_encrypt(datactx, encfunc, src, CC, T);
> +        xts_tweak_encdec(datactx, encfunc, src, CC, T);
>
>          /* Cm =3D first length % XTS_BLOCK_SIZE bytes of CC */
>          for (i =3D 0; i < mo; i++) {
> @@ -222,7 +188,7 @@ void xts_encrypt(const void *datactx,
>          }
>
>          /* Cm-1 =3D Tweak encrypt PP */
> -        xts_tweak_encrypt(datactx, encfunc, PP, dst, T);
> +        xts_tweak_encdec(datactx, encfunc, PP, dst, T);
>      }
>
>      /* Decrypt the iv back */
> --
> 2.17.1
>
>


--
Marc-Andr=C3=A9 Lureau
