Received: from eggs.gnu.org ([2001:4830:134:3::10]:35331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cQPNL-0001el-Il
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 21:07:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cQPNJ-0000up-16
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 21:07:55 -0500
Received: from [45.249.212.188] (port=2437 helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cQPNI-0000tq-AO
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 21:07:52 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Mon, 9 Jan 2017 02:07:24 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA1803D3@DGGEMA505-MBX.china.huawei.com>
References: <1482375688-20872-1-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1482375688-20872-1-git-send-email-arei.gonglei@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3] virtio-crypto: zeroize the key material
 before free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>

Hi Michael,

Ping...


Regards,
-Gonglei


> -----Original Message-----
> From: Gonglei (Arei)
> Sent: Thursday, December 22, 2016 11:01 AM
> To: qemu-devel@nongnu.org
> Cc: mst@redhat.com; Gonglei (Arei)
> Subject: [PATCH v3] virtio-crypto: zeroize the key material before free
>=20
> Common practice with sensitive information (key material, passwords,
> etc). Prevents sensitive information from being exposed by accident later=
 in
> coredumps, memory disclosure bugs when heap memory is reused, etc.
>=20
> Sensitive information is sometimes also held in mlocked pages to prevent
> it being swapped to disk but that's not being done here.
>=20
> Let's zeroize the memory of CryptoDevBackendSymOpInfo structure pointed
> for key material security.
>=20
> [Thanks to Stefan for help with crafting the commit message]
>=20
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  v3:
>  - rework the commit message [Eric]
>  - add Eric's R-by tag.
>=20
>  hw/virtio/virtio-crypto.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
> index 4f11fee..48288e8 100644
> --- a/hw/virtio/virtio-crypto.c
> +++ b/hw/virtio/virtio-crypto.c
> @@ -337,7 +337,18 @@ static void
> virtio_crypto_free_request(VirtIOCryptoReq *req)
>  {
>      if (req) {
>          if (req->flags =3D=3D CRYPTODEV_BACKEND_ALG_SYM) {
> -            g_free(req->u.sym_op_info);
> +            size_t max_len;
> +            CryptoDevBackendSymOpInfo *op_info =3D req->u.sym_op_info;
> +
> +            max_len =3D op_info->iv_len +
> +                      op_info->aad_len +
> +                      op_info->src_len +
> +                      op_info->dst_len +
> +                      op_info->digest_result_len;
> +
> +            /* Zeroize and free request data structure */
> +            memset(op_info, 0, sizeof(*op_info) + max_len);
> +            g_free(op_info);
>          }
>          g_free(req);
>      }
> --
> 1.8.3.1
>=20
