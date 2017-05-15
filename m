Received: from eggs.gnu.org ([2001:4830:134:3::10]:56293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dAIfF-0008Dj-Q8
	for qemu-devel@nongnu.org; Mon, 15 May 2017 12:16:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dAIfA-0004IY-P9
	for qemu-devel@nongnu.org; Mon, 15 May 2017 12:16:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dAIfA-0004Hq-D6
	for qemu-devel@nongnu.org; Mon, 15 May 2017 12:16:00 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4FGDYRt138818
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 12:15:58 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2afb6p76wt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 12:15:58 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 15 May 2017 17:15:55 +0100
References: <1494243504-127980-1-git-send-email-arei.gonglei@huawei.com>
	<1494243504-127980-7-git-send-email-arei.gonglei@huawei.com>
	<520f45d4-33d7-8836-3140-a92ee5d15421@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA278AA0@DGGEMA505-MBS.china.huawei.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 15 May 2017 18:15:50 +0200
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA278AA0@DGGEMA505-MBS.china.huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <1963bfa1-c0ea-156a-59f7-aed744ca49a3@linux.vnet.ibm.com>
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
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, Luonengjun <luonengjun@huawei.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, Linqiangmin <linqiangmin@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "Wubin (H)" <wu.wubin@huawei.com>



On 05/13/2017 03:16 AM, Gonglei (Arei) wrote:
> 
>> From: Halil Pasic [mailto:pasic@linux.vnet.ibm.com]
>> Sent: Friday, May 12, 2017 7:02 PM
>>
>>
>> On 05/08/2017 01:38 PM, Gonglei wrote:
>>> According to the new spec, we should use different
>>> requst structure to store the data request based
>>> on whether VIRTIO_CRYPTO_F_MUX_MODE feature bit is
>>> negotiated or not.
>>>
>>> In this patch, we havn't supported stateless mode
>>> yet. The device reportes an error if both
>>> VIRTIO_CRYPTO_F_MUX_MODE and
>> VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE
>>> are negotiated, meanwhile the header.flag doesn't set
>>> to VIRTIO_CRYPTO_FLAG_SESSION_MODE.
>>>
>>> Let's handle this scenario in the following patches.
>>>
>>> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
>>> ---
>>>  hw/virtio/virtio-crypto.c | 83
>> ++++++++++++++++++++++++++++++++++++++++-------
>>>  1 file changed, 71 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
>>> index 0353eb6..c4b8a2c 100644
>>> --- a/hw/virtio/virtio-crypto.c
>>> +++ b/hw/virtio/virtio-crypto.c
>>> @@ -577,6 +577,7 @@ virtio_crypto_handle_request(VirtIOCryptoReq
>> *request)
>>>      VirtQueueElement *elem = &request->elem;
>>>      int queue_index =
>> virtio_crypto_vq2q(virtio_get_queue_index(request->vq));
>>>      struct virtio_crypto_op_data_req req;
>>> +    struct virtio_crypto_op_data_req_mux req_mux;
>>>      int ret;
>>>      struct iovec *in_iov;
>>>      struct iovec *out_iov;
>>> @@ -587,6 +588,9 @@ virtio_crypto_handle_request(VirtIOCryptoReq
>> *request)
>>>      uint64_t session_id;
>>>      CryptoDevBackendSymOpInfo *sym_op_info = NULL;
>>>      Error *local_err = NULL;
>>> +    bool mux_mode_is_negotiated;
>>> +    struct virtio_crypto_op_header *header;
>>> +    bool is_stateless_req = false;
>>>
>>>      if (elem->out_num < 1 || elem->in_num < 1) {
>>>          virtio_error(vdev, "virtio-crypto dataq missing headers");
>>> @@ -597,12 +601,28 @@ virtio_crypto_handle_request(VirtIOCryptoReq
>> *request)
>>>      out_iov = elem->out_sg;
>>>      in_num = elem->in_num;
>>>      in_iov = elem->in_sg;
>>> -    if (unlikely(iov_to_buf(out_iov, out_num, 0, &req, sizeof(req))
>>> -                != sizeof(req))) {
>>> -        virtio_error(vdev, "virtio-crypto request outhdr too short");
>>> -        return -1;
>>> +
>>> +    mux_mode_is_negotiated =
>>> +        virtio_vdev_has_feature(vdev, VIRTIO_CRYPTO_F_MUX_MODE);
>>> +    if (!mux_mode_is_negotiated) {
>>> +        if (unlikely(iov_to_buf(out_iov, out_num, 0, &req, sizeof(req))
>>> +                    != sizeof(req))) {
>>> +            virtio_error(vdev, "virtio-crypto request outhdr too short");
>>> +            return -1;
>>> +        }
>>> +        iov_discard_front(&out_iov, &out_num, sizeof(req));
>>> +
>>> +        header = &req.header;
>>> +    } else {
>>> +        if (unlikely(iov_to_buf(out_iov, out_num, 0, &req_mux,
>>> +                sizeof(req_mux)) != sizeof(req_mux))) {
>>> +            virtio_error(vdev, "virtio-crypto request outhdr too short");
>>> +            return -1;
>>> +        }
>>> +        iov_discard_front(&out_iov, &out_num, sizeof(req_mux));
>>> +
>>> +        header = &req_mux.header;
>>
>> I wonder if this request length checking logic is conform to the
>> most recent spec draft on the list ("[PATCH v18 0/2] virtio-crypto:
>> virtio crypto device specification").
>>
> Sure. Please see below normative formulation:
> 
> '''
> \drivernormative{\paragraph}{Symmetric algorithms Operation}{Device Types / Crypto Device / Device Operation / Symmetric algorithms Operation}
> ...
> \item If the VIRTIO_CRYPTO_F_MUX_MODE feature bit is negotiated, the driver MUST use struct virtio_crypto_op_data_req_mux to wrap crypto requests.
> Otherwise, the driver MUST use struct virtio_crypto_op_data_req.
> ...
> '''
> 

As far as I can remember, we have already agreed that in terms of the
spec sizeof(struct virtio_crypto_op_data_req) makes no sense! In your
code you have a substantially different struct virtio_crypto_op_data_req
than in your spec! For instance in the spec virtio_crypto_op_data_req is
the full request and contains the data buffers (src_data and the
dest_data), while in your code it's effectively just a header and does
not contain any data buffers.


>> AFAIU here you allow only requests of two sizes: one fixed size
>> for VIRTIO_CRYPTO_F_MUX_MODE and one without that feature. This
>> means that some requests need quite some padding between what
>> you call the 'request' and the actual data on which the crypto
>> operation dictated by the 'request' needs to be performed.
> 
> Yes, that's true.
> 

This implies that should we need more than 128 bytes for a request,
we will need to introduce jet another request format and negotiate it
via feature bits.

By the way, I'm having a hard time understing how is the requirement form 
http://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.html#x1-260004
(2.4.4 Message Framing) satisfied by this code. Could you explain this
to me please?


>> What are the benefits of this approach?
>>
> We could unify the request for all algorithms, both symmetric algos and asymmetric algos,
> which is very convenient for handling tens of hundreds of different algorithm requests.
> 

AFAIU the reason is ease of implementation. If everybody else is fine
with this, I won't object either.

> 
> Thanks,
> -Gonglei
> 
