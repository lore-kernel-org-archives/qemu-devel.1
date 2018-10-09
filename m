Received: from eggs.gnu.org ([2001:4830:134:3::10]:51231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1g9tLC-0002JT-Tw
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:50:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1g9tL6-0006cT-8c
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:50:30 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:59525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1g9tL4-0006Uv-EQ
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:50:23 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181009125541.24455-4-berrange@redhat.com>
References: <20181009125541.24455-1-berrange@redhat.com>
	<20181009125541.24455-4-berrange@redhat.com>
Date: Tue, 09 Oct 2018 16:50:16 +0200
Message-ID: <w51k1mr8993.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/6] crypto: introduce a xts_uint128 data
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, qemu-devel@nongnu.org

On Tue 09 Oct 2018 02:55:38 PM CEST, Daniel P. Berrang=C3=A9 wrote:

> @@ -85,7 +90,7 @@ void xts_decrypt(const void *datactx,
>                   uint8_t *dst,
>                   const uint8_t *src)
>  {
> -    uint8_t PP[XTS_BLOCK_SIZE], CC[XTS_BLOCK_SIZE], T[XTS_BLOCK_SIZE];
> +    xts_uint128 PP, CC, T;
>      unsigned long i, m, mo, lim;

   [...]

>          /* Pm =3D first length % XTS_BLOCK_SIZE bytes of PP */
>          for (i =3D 0; i < mo; i++) {
> -            CC[i] =3D src[XTS_BLOCK_SIZE + i];
> -            dst[XTS_BLOCK_SIZE + i] =3D PP[i];
> +            ((uint8_t *)&CC)[i] =3D src[XTS_BLOCK_SIZE + i];
> +            dst[XTS_BLOCK_SIZE + i] =3D ((uint8_t *)&PP)[i];
>          }

On second thoughts, these casts are a bit cumbersome. I wonder if it
isn't better to keep the array a uint8_t[] and only treat it as
xts_uint128 in the places where you actually do 64-bit operations
(xts_uint128_xor, xts_mult_x).

Berto
