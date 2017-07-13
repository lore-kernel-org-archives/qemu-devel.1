Received: from eggs.gnu.org ([2001:4830:134:3::10]:43250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVfvJ-0001eJ-Ug
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:21:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVfvF-0008CT-B9
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:21:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dVfvF-0008C0-5B
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:20:57 -0400
Date: Thu, 13 Jul 2017 17:20:44 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170713172044.418abc4b@gondolin>
In-Reply-To: <20170713110237.6712-9-lprosek@redhat.com>
References: <20170713110237.6712-1-lprosek@redhat.com>
	<20170713110237.6712-9-lprosek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 8/8] virtio-crypto: use virtqueue_error
 for errors with queue context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel@nongnu.org, casasfernando@hotmail.com, mst@redhat.com, jasowang@redhat.com, armbru@redhat.com, groug@kaod.org, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com, stefanha@redhat.com

On Thu, 13 Jul 2017 13:02:37 +0200
Ladi Prosek <lprosek@redhat.com> wrote:

> virtqueue_error includes queue index in the error output and is preferred
> for errors that pertain to a virtqueue rather than to the device as a whole.
> 
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> ---
>  hw/virtio/virtio-crypto.c | 56 ++++++++++++++++++++++++-----------------------
>  1 file changed, 29 insertions(+), 27 deletions(-)
> 
> diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
> index 0353eb6..08e6c03 100644
> --- a/hw/virtio/virtio-crypto.c
> +++ b/hw/virtio/virtio-crypto.c
> @@ -35,6 +35,7 @@ static inline int virtio_crypto_vq2q(int queue_index)
>  
>  static int
>  virtio_crypto_cipher_session_helper(VirtIODevice *vdev,
> +           VirtQueue *ctrl_vq,
>             CryptoDevBackendSymSessionInfo *info,
>             struct virtio_crypto_cipher_session_para *cipher_para,
>             struct iovec **iov, unsigned int *out_num)
> @@ -61,7 +62,7 @@ virtio_crypto_cipher_session_helper(VirtIODevice *vdev,
>          info->cipher_key = g_malloc(info->key_len);
>          s = iov_to_buf(*iov, num, 0, info->cipher_key, info->key_len);
>          if (unlikely(s != info->key_len)) {
> -            virtio_error(vdev, "virtio-crypto cipher key incorrect");
> +            virtqueue_error(ctrl_vq, "virtio-crypto cipher key incorrect");

As virtio-crypto devices always have one control queue, I would just
use the pointer stored in the vcrypto structure. This avoids some of
the cascading function signature changes.

>              return -EFAULT;
>          }
>          iov_discard_front(iov, &num, info->key_len);
