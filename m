Received: from eggs.gnu.org ([2001:4830:134:3::10]:49831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d98Kz-0003lw-F7
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d98Kv-0006Fu-9h
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:02:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55143)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1d98Ku-0006Ey-RV
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:02:17 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4CAweiW058745
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 07:02:14 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2acy11hmqk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 07:02:13 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 12 May 2017 12:02:10 +0100
References: <1494243504-127980-1-git-send-email-arei.gonglei@huawei.com>
	<1494243504-127980-7-git-send-email-arei.gonglei@huawei.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 12 May 2017 13:02:02 +0200
MIME-Version: 1.0
In-Reply-To: <1494243504-127980-7-git-send-email-arei.gonglei@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <520f45d4-33d7-8836-3140-a92ee5d15421@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC v1 6/9] virtio-crypto: rework
 virtio_crypto_handle_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gonglei <arei.gonglei@huawei.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, weidong.huang@huawei.com, stefanha@redhat.com, luonengjun@huawei.com, cornelia.huck@de.ibm.com, linqiangmin@huawei.com, xin.zeng@intel.com, wu.wubin@huawei.com



On 05/08/2017 01:38 PM, Gonglei wrote:
> According to the new spec, we should use different
> requst structure to store the data request based
> on whether VIRTIO_CRYPTO_F_MUX_MODE feature bit is
> negotiated or not.
> 
> In this patch, we havn't supported stateless mode
> yet. The device reportes an error if both
> VIRTIO_CRYPTO_F_MUX_MODE and VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE
> are negotiated, meanwhile the header.flag doesn't set
> to VIRTIO_CRYPTO_FLAG_SESSION_MODE.
> 
> Let's handle this scenario in the following patches.
> 
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> ---
>  hw/virtio/virtio-crypto.c | 83 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 71 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
> index 0353eb6..c4b8a2c 100644
> --- a/hw/virtio/virtio-crypto.c
> +++ b/hw/virtio/virtio-crypto.c
> @@ -577,6 +577,7 @@ virtio_crypto_handle_request(VirtIOCryptoReq *request)
>      VirtQueueElement *elem = &request->elem;
>      int queue_index = virtio_crypto_vq2q(virtio_get_queue_index(request->vq));
>      struct virtio_crypto_op_data_req req;
> +    struct virtio_crypto_op_data_req_mux req_mux;
>      int ret;
>      struct iovec *in_iov;
>      struct iovec *out_iov;
> @@ -587,6 +588,9 @@ virtio_crypto_handle_request(VirtIOCryptoReq *request)
>      uint64_t session_id;
>      CryptoDevBackendSymOpInfo *sym_op_info = NULL;
>      Error *local_err = NULL;
> +    bool mux_mode_is_negotiated;
> +    struct virtio_crypto_op_header *header;
> +    bool is_stateless_req = false;
> 
>      if (elem->out_num < 1 || elem->in_num < 1) {
>          virtio_error(vdev, "virtio-crypto dataq missing headers");
> @@ -597,12 +601,28 @@ virtio_crypto_handle_request(VirtIOCryptoReq *request)
>      out_iov = elem->out_sg;
>      in_num = elem->in_num;
>      in_iov = elem->in_sg;
> -    if (unlikely(iov_to_buf(out_iov, out_num, 0, &req, sizeof(req))
> -                != sizeof(req))) {
> -        virtio_error(vdev, "virtio-crypto request outhdr too short");
> -        return -1;
> +
> +    mux_mode_is_negotiated =
> +        virtio_vdev_has_feature(vdev, VIRTIO_CRYPTO_F_MUX_MODE);
> +    if (!mux_mode_is_negotiated) {
> +        if (unlikely(iov_to_buf(out_iov, out_num, 0, &req, sizeof(req))
> +                    != sizeof(req))) {
> +            virtio_error(vdev, "virtio-crypto request outhdr too short");
> +            return -1;
> +        }
> +        iov_discard_front(&out_iov, &out_num, sizeof(req));
> +
> +        header = &req.header;
> +    } else {
> +        if (unlikely(iov_to_buf(out_iov, out_num, 0, &req_mux,
> +                sizeof(req_mux)) != sizeof(req_mux))) {
> +            virtio_error(vdev, "virtio-crypto request outhdr too short");
> +            return -1;
> +        }
> +        iov_discard_front(&out_iov, &out_num, sizeof(req_mux));
> +
> +        header = &req_mux.header;

I wonder if this request length checking logic is conform to the
most recent spec draft on the list ("[PATCH v18 0/2] virtio-crypto:
virtio crypto device specification").

AFAIU here you allow only requests of two sizes: one fixed size
for VIRTIO_CRYPTO_F_MUX_MODE and one without that feature. This
means that some requests need quite some padding between what
you call the 'request' and the actual data on which the crypto
operation dictated by the 'request' needs to be performed.
What are the benefits of this approach?


Regards,
Halil
