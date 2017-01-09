Received: from eggs.gnu.org ([2001:4830:134:3::10]:35664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cQPQ2-0003lr-Sp
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 21:10:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cQPQ0-0001g0-G7
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 21:10:42 -0500
Received: from [45.249.212.187] (port=2506 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cQPPz-0001ci-J3
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 21:10:40 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Mon, 9 Jan 2017 02:10:13 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA180404@DGGEMA505-MBX.china.huawei.com>
References: <1483426203-16196-1-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1483426203-16196-1-git-send-email-arei.gonglei@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] virtio-crypto: fix possible integer and
 heap overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>, "liqiang6-s@360.cn" <liqiang6-s@360.cn>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>

Hi Michael,

Ping...



Regards,
-Gonglei


> -----Original Message-----
> From: Gonglei (Arei)
> Sent: Tuesday, January 03, 2017 2:50 PM
> To: qemu-devel@nongnu.org
> Cc: mst@redhat.com; liqiang6-s@360.cn; Gonglei (Arei);
> qemu-stable@nongnu.org
> Subject: [PATCH] virtio-crypto: fix possible integer and heap overflow
>=20
> Because the 'size_t' type is 4 bytes in 32-bit platform, which
> is the same with 'int'. It's easy to make 'max_len' to zero when
> integer overflow and then cause heap overflow if 'max_len' is zero.
>=20
> Using uint_64 instead of size_t to avoid the integer overflow.
>=20
> Cc: qemu-stable@nongnu.org
> Reported-by: Li Qiang <liqiang6-s@360.cn>
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> Tested-by: Li Qiang <liqiang6-s@360.cn>
> ---
>  hw/virtio/virtio-crypto.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
> index 978bb98..fc30bc3 100644
> --- a/hw/virtio/virtio-crypto.c
> +++ b/hw/virtio/virtio-crypto.c
> @@ -416,7 +416,7 @@ virtio_crypto_sym_op_helper(VirtIODevice *vdev,
>      uint32_t hash_start_src_offset =3D 0, len_to_hash =3D 0;
>      uint32_t cipher_start_src_offset =3D 0, len_to_cipher =3D 0;
>=20
> -    size_t max_len, curr_size =3D 0;
> +    uint64_t max_len, curr_size =3D 0;
>      size_t s;
>=20
>      /* Plain cipher */
> @@ -441,7 +441,7 @@ virtio_crypto_sym_op_helper(VirtIODevice *vdev,
>          return NULL;
>      }
>=20
> -    max_len =3D iv_len + aad_len + src_len + dst_len + hash_result_len;
> +    max_len =3D (uint64_t)iv_len + aad_len + src_len + dst_len +
> hash_result_len;
>      if (unlikely(max_len > vcrypto->conf.max_size)) {
>          virtio_error(vdev, "virtio-crypto too big length");
>          return NULL;
> --
> 1.8.3.1
>=20
