Received: from eggs.gnu.org ([2001:4830:134:3::10]:36859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cEFzR-00082U-7w
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 08:41:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cEFzO-00045g-3a
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 08:41:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cEFzN-00045U-TW
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 08:40:58 -0500
Date: Tue, 6 Dec 2016 15:40:49 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20161206153945-mutt-send-email-mst@kernel.org>
References: <1481016553-69252-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1481016553-69252-1-git-send-email-arei.gonglei@huawei.com>
Subject: Re: [Qemu-devel] [PATCH for-2.8] virtio-crypto: zeroize the key
 material before free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gonglei <arei.gonglei@huawei.com>
Cc: qemu-devel@nongnu.org

On Tue, Dec 06, 2016 at 05:29:13PM +0800, Gonglei wrote:
> Zeroize the memory of CryptoDevBackendSymOpInfo structure pointed
> for key material security.
> 
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> ---
>  hw/virtio/virtio-crypto.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
> index 2f2467e..ecb19b6 100644
> --- a/hw/virtio/virtio-crypto.c
> +++ b/hw/virtio/virtio-crypto.c
> @@ -337,7 +337,18 @@ static void virtio_crypto_free_request(VirtIOCryptoReq *req)
>  {
>      if (req) {
>          if (req->flags == CRYPTODEV_BACKEND_ALG_SYM) {
> -            g_free(req->u.sym_op_info);
> +            size_t max_len;
> +            CryptoDevBackendSymOpInfo *op_info = req->u.sym_op_info;
> +
> +            max_len = op_info->iv_len +
> +                      op_info->aad_len +
> +                      op_info->src_len +
> +                      op_info->dst_len +
> +                      op_info->digest_result_len;
> +
> +            /* Zeroize and free request data structure */
> +            memset(op_info, 0, sizeof(*op_info) + max_len);
> +            g_free(op_info);

Write into memory, then free it?  This looks rather strange. Why are we
doing this?

>          }
>          g_free(req);
>      }
> -- 
> 1.8.3.1
> 
