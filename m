Received: from eggs.gnu.org ([2001:4830:134:3::10]:34666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gCPV5-0000DD-6b
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:35:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gCPV2-0003XV-0U
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:35:07 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:44381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1gCPV1-0003Sc-JM
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:35:03 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181016100918.21030-6-berrange@redhat.com>
References: <20181016100918.21030-1-berrange@redhat.com>
	<20181016100918.21030-6-berrange@redhat.com>
Date: Tue, 16 Oct 2018 15:35:01 +0200
Message-ID: <w51bm7uypyy.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/8] crypto: convert xts_mult_x to use
 xts_uint128 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, qemu-devel@nongnu.org

On Tue 16 Oct 2018 12:09:15 PM CEST, Daniel P. Berrang=C3=A9 wrote:
> Using 64-bit arithmetic increases the performance for xts-aes-128
> when built with gcrypt:
>
>   Encrypt: 355 MB/s -> 545 MB/s
>   Decrypt: 362 MB/s -> 568 MB/s
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

This patch is also fine, but I have a couple of minor comments:

> +static void xts_mult_x(xts_uint128 *I)
> +{
> +    uint64_t tt;
> +
> +    xts_uint128_cpu_to_les(I);
> +
> +    tt =3D I->u[0] >> 63;
> +    I->u[0] =3D I->u[0] << 1;

Perhaps I->u[0] <<=3D 1 , for clarity and consistency with the following
line (I->u[0] ^=3D 0x87) ? But I don't mind if you prefer to keep it as is
now.

> +    if (I->u[1] >> 63) {
> +        I->u[0] ^=3D 0x87;
>      }
> +    I->u[1] =3D (I->u[1] << 1) | tt;
> +
> +    xts_uint128_le_to_cpus(I);

I think both endianness conversion calls should be flipped. First you
convert from the buffer byte order (LE) to the CPU byte order so you can
do the bit shifts, then back to the original byte order (LE).

Changing this doesn't have any practical effect because both calls
perform the exact same operation, but it documents better what's going
on.

With this changed,

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
