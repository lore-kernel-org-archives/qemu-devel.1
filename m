Received: from eggs.gnu.org ([2001:4830:134:3::10]:53345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gCP6B-0007kf-DB
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:09:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gCP67-0007lJ-73
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:09:23 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:40351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1gCP66-0007ho-Om
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:09:19 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181016100918.21030-5-berrange@redhat.com>
References: <20181016100918.21030-1-berrange@redhat.com>
	<20181016100918.21030-5-berrange@redhat.com>
Date: Tue, 16 Oct 2018 15:09:16 +0200
Message-ID: <w51efcqyr5v.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/8] crypto: convert xts_tweak_encdec to
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

On Tue 16 Oct 2018 12:09:14 PM CEST, Daniel P. Berrang=C3=A9 wrote:

> @@ -110,20 +111,34 @@ void xts_decrypt(const void *datactx,
>      /* encrypt the iv */
>      encfunc(tweakctx, XTS_BLOCK_SIZE, T.b, iv);
>=20=20
> -    for (i =3D 0; i < lim; i++) {
> -        xts_tweak_encdec(datactx, decfunc, src, dst, T.b);
> -
> -        src +=3D XTS_BLOCK_SIZE;
> -        dst +=3D XTS_BLOCK_SIZE;
> +    if (QEMU_PTR_IS_ALIGNED(src, sizeof(uint64_t)) &&
> +        QEMU_PTR_IS_ALIGNED(dst, sizeof(uint64_t))) {
> +        xts_uint128 *S =3D (xts_uint128 *)src;
> +        xts_uint128 *D =3D (xts_uint128 *)dst;
> +        for (i =3D 0; i < lim; i++, S++, D++) {
> +            xts_tweak_encdec(datactx, decfunc, S, D, &T);
> +        }
> +    } else {
> +        xts_uint128 S, D;
> +
> +        for (i =3D 0; i < lim; i++) {
> +            memcpy(&S, src, XTS_BLOCK_SIZE);
> +            xts_tweak_encdec(datactx, decfunc, &S, &D, &T);
> +            memcpy(dst, &D, XTS_BLOCK_SIZE);
> +            src +=3D XTS_BLOCK_SIZE;
> +            dst +=3D XTS_BLOCK_SIZE;
> +        }

The patch looks good to me, but a couple of comments:

- As far as I can see xts_tweak_encdec() works the same regardless of
  whether src and dst point to the same address or not. As a matter of
  fact both qcrypto_block_decrypt() and qcrypto_block_encrypt() do the
  decryption and encryption in place, and as you can see the
  qcrypto_cipher_*crypt() calls in crypto/block.c pass the same buffer
  as input and output.

  So instead of having S and D you should be fine with just one of them.

- I think this is just a matter of style preference, but in the first
  for loop you can remove the comma operator (i++, S++, D++) and use
  S[i] and D[I] instead in the line after that. I'm fine if you prefer
  the current style, though.

Berto
