Received: from eggs.gnu.org ([2001:4830:134:3::10]:36007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dAv0v-0001yA-26
	for qemu-devel@nongnu.org; Wed, 17 May 2017 05:13:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dAv0q-0005IC-RC
	for qemu-devel@nongnu.org; Wed, 17 May 2017 05:13:01 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dAv0p-0005FL-Vw
	for qemu-devel@nongnu.org; Wed, 17 May 2017 05:12:56 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Wed, 17 May 2017 09:12:04 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA29B209@DGGEMA505-MBS.china.huawei.com>
References: <1494243504-127980-1-git-send-email-arei.gonglei@huawei.com>
	<1494243504-127980-7-git-send-email-arei.gonglei@huawei.com>
	<520f45d4-33d7-8836-3140-a92ee5d15421@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA278AA0@DGGEMA505-MBS.china.huawei.com>
	<1963bfa1-c0ea-156a-59f7-aed744ca49a3@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA29A0B5@DGGEMA505-MBS.china.huawei.com>
	<b7c20d5f-026e-edf1-6703-6b64ceed375f@linux.vnet.ibm.com>
In-Reply-To: <b7c20d5f-026e-edf1-6703-6b64ceed375f@linux.vnet.ibm.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Halil Pasic <pasic@linux.vnet.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, Luonengjun <luonengjun@huawei.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, Linqiangmin <linqiangmin@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "Wubin (H)" <wu.wubin@huawei.com>

> From: Halil Pasic [mailto:pasic@linux.vnet.ibm.com]
> Sent: Wednesday, May 17, 2017 6:18 AM
>=20
>=20
> On 05/16/2017 04:52 AM, Gonglei (Arei) wrote:
> >>
> >> On 05/13/2017 03:16 AM, Gonglei (Arei) wrote:
> >>>
> >>>> From: Halil Pasic [mailto:pasic@linux.vnet.ibm.com]
> >>>> Sent: Friday, May 12, 2017 7:02 PM
> >>>>
> >>>>
> >>>> On 05/08/2017 01:38 PM, Gonglei wrote:
> >>>>> According to the new spec, we should use different
> >>>>> requst structure to store the data request based
> >>>>> on whether VIRTIO_CRYPTO_F_MUX_MODE feature bit is
> >>>>> negotiated or not.
> >>>>>
> >>>>> In this patch, we havn't supported stateless mode
> >>>>> yet. The device reportes an error if both
> >>>>> VIRTIO_CRYPTO_F_MUX_MODE and
> >>>> VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE
> >>>>> are negotiated, meanwhile the header.flag doesn't set
> >>>>> to VIRTIO_CRYPTO_FLAG_SESSION_MODE.
> >>>>>
> >>>>> Let's handle this scenario in the following patches.
> >>>>>
> >>>>> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> >>>>> ---
> >>>>>  hw/virtio/virtio-crypto.c | 83
> >>>> ++++++++++++++++++++++++++++++++++++++++-------
> >>>>>  1 file changed, 71 insertions(+), 12 deletions(-)
> >>>>>
> >>>>> diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
> >>>>> index 0353eb6..c4b8a2c 100644
> >>>>> --- a/hw/virtio/virtio-crypto.c
> >>>>> +++ b/hw/virtio/virtio-crypto.c
> >>>>> @@ -577,6 +577,7 @@ virtio_crypto_handle_request(VirtIOCryptoReq
> >>>> *request)
> >>>>>      VirtQueueElement *elem =3D &request->elem;
> >>>>>      int queue_index =3D
> >>>> virtio_crypto_vq2q(virtio_get_queue_index(request->vq));
> >>>>>      struct virtio_crypto_op_data_req req;
> >>>>> +    struct virtio_crypto_op_data_req_mux req_mux;
> >>>>>      int ret;
> >>>>>      struct iovec *in_iov;
> >>>>>      struct iovec *out_iov;
> >>>>> @@ -587,6 +588,9 @@ virtio_crypto_handle_request(VirtIOCryptoReq
> >>>> *request)
> >>>>>      uint64_t session_id;
> >>>>>      CryptoDevBackendSymOpInfo *sym_op_info =3D NULL;
> >>>>>      Error *local_err =3D NULL;
> >>>>> +    bool mux_mode_is_negotiated;
> >>>>> +    struct virtio_crypto_op_header *header;
> >>>>> +    bool is_stateless_req =3D false;
> >>>>>
> >>>>>      if (elem->out_num < 1 || elem->in_num < 1) {
> >>>>>          virtio_error(vdev, "virtio-crypto dataq missing headers");
> >>>>> @@ -597,12 +601,28 @@
> virtio_crypto_handle_request(VirtIOCryptoReq
> >>>> *request)
> >>>>>      out_iov =3D elem->out_sg;
> >>>>>      in_num =3D elem->in_num;
> >>>>>      in_iov =3D elem->in_sg;
> >>>>> -    if (unlikely(iov_to_buf(out_iov, out_num, 0, &req, sizeof(req)=
)
> >>>>> -                !=3D sizeof(req))) {
> >>>>> -        virtio_error(vdev, "virtio-crypto request outhdr too short=
");
> >>>>> -        return -1;
> >>>>> +
> >>>>> +    mux_mode_is_negotiated =3D
> >>>>> +        virtio_vdev_has_feature(vdev,
> >> VIRTIO_CRYPTO_F_MUX_MODE);
> >>>>> +    if (!mux_mode_is_negotiated) {
> >>>>> +        if (unlikely(iov_to_buf(out_iov, out_num, 0, &req, sizeof(=
req))
> >>>>> +                    !=3D sizeof(req))) {
> >>>>> +            virtio_error(vdev, "virtio-crypto request outhdr too
> short");
> >>>>> +            return -1;
> >>>>> +        }
> >>>>> +        iov_discard_front(&out_iov, &out_num, sizeof(req));
> >>>>> +
> >>>>> +        header =3D &req.header;
> >>>>> +    } else {
> >>>>> +        if (unlikely(iov_to_buf(out_iov, out_num, 0, &req_mux,
> >>>>> +                sizeof(req_mux)) !=3D sizeof(req_mux))) {
> >>>>> +            virtio_error(vdev, "virtio-crypto request outhdr too
> short");
> >>>>> +            return -1;
> >>>>> +        }
> >>>>> +        iov_discard_front(&out_iov, &out_num, sizeof(req_mux));
> >>>>> +
> >>>>> +        header =3D &req_mux.header;
> >>>>
> >>>> I wonder if this request length checking logic is conform to the
> >>>> most recent spec draft on the list ("[PATCH v18 0/2] virtio-crypto:
> >>>> virtio crypto device specification").
> >>>>
> >>> Sure. Please see below normative formulation:
> >>>
> >>> '''
> >>> \drivernormative{\paragraph}{Symmetric algorithms Operation}{Device
> Types
> >> / Crypto Device / Device Operation / Symmetric algorithms Operation}
> >>> ...
> >>> \item If the VIRTIO_CRYPTO_F_MUX_MODE feature bit is negotiated, the
> >> driver MUST use struct virtio_crypto_op_data_req_mux to wrap crypto
> >> requests.
> >>> Otherwise, the driver MUST use struct virtio_crypto_op_data_req.
> >>> ...
> >>> '''
> >>>
> >>
> >> As far as I can remember, we have already agreed that in terms of the
> >> spec sizeof(struct virtio_crypto_op_data_req) makes no sense! In your
> >
> > Sorry, I don't think so. :(
> >
> >> code you have a substantially different struct virtio_crypto_op_data_r=
eq
> >> than in your spec! For instance in the spec virtio_crypto_op_data_req =
is
> >> the full request and contains the data buffers (src_data and the
> >> dest_data), while in your code it's effectively just a header and does
> >> not contain any data buffers.
> >>
> > I said struct virtio_crypto_op_data_req in the spec is just a symbol.
> > I didn't find a better way to express the src_data and dst_data etc. So
> > I used u8[len] xxx_data to occupy a sit in the request.
> >
>=20
> OK, tell me how is the reader/implementer of the spec supposed to figure
> out that a 124 byte padded "header" needs to be precede any "data"?
>=20
If those people use the asked request based on the spec,=20
they don't need to worry about the pad IMHO.

> Besides if you look at
>=20
> +Stateless mode HASH service requests are as follows:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_hash_para_statelesss {
> +    struct {
> +        /* See VIRTIO_CRYPTO_HASH_* above */
> +        le32 algo;
> +    } sess_para;
> +
> +    /* length of source data */
> +    le32 src_data_len;
> +    /* hash result length */
> +    le32 hash_result_len;
> +    le32 reserved;
> +};
> +struct virtio_crypto_hash_data_req_stateless {
> +    /* Device-readable part */
> +    struct virtio_crypto_hash_para_stateless para;
> +    /* Source data */
> +    u8 src_data[src_data_len];
> +
> +    /* Device-writable part */
> +    /* Hash result data */
> +    u8 hash_result[hash_result_len];
> +    struct virtio_crypto_inhdr inhdr;
> +};
> +\end{lstlisting}
> +
>=20
> from the "[PATCH v18 1/2] virtio-crypto: Add virtio crypto device
> specification". You need the padding to 128 bytes after
> virtio_crypto_hash_para_stateless para, but before src_data. But there is
> no indication in the definition of virtio_crypto_hash_data_req_stateless
> nor somewhere in the spec about that. On the contrary based on this
> one would expect para.reserved and src_data being pretty adjecent.
>=20
> Thus the normative statement you quoted is (IMHO) ill suited and
> insufficient to express what you have been trying to express.
>=20
That's indeed a problem. I can't find a good way to express my thoughts
in the spec. Make me sad.~

> >>
> >>>> AFAIU here you allow only requests of two sizes: one fixed size
> >>>> for VIRTIO_CRYPTO_F_MUX_MODE and one without that feature. This
> >>>> means that some requests need quite some padding between what
> >>>> you call the 'request' and the actual data on which the crypto
> >>>> operation dictated by the 'request' needs to be performed.
> >>>
> >>> Yes, that's true.
> >>>
> >>
> >> This implies that should we need more than 128 bytes for a request,
> >> we will need to introduce jet another request format and negotiate it
> >> via feature bits.
> >>
> > Why do we need other feature bits?
>=20
> Because assume you have something that needs more that 128 bytes for
> its request, how do you solve the problem without new format end new
> feature bit?
>=20
Oh, maybe I get your point now. You mean the future use for some algorithm =
requests
use more than 128 bytes? If so, we have to introduce new feature bits.
AFAICT the 128 bytes is enough for sym and asym algorithms currently. Xin Z=
eng? Any thoughts?

> >
> >> By the way, I'm having a hard time understing how is the requirement f=
orm
> >>
> http://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.html#=
x1-260
> >> 004
> >> (2.4.4 Message Framing) satisfied by this code. Could you explain this
> >> to me please?
> >>
> > Sorry for my bad English,
> > I don't know which normative formulation the code violates?
>=20
> I'm not sure it's actually violated, but I'm concerned about the followin=
g
> normative statement: "The device MUST NOT make assumptions about the
> particular
> arrangement of descriptors. The device MAY have a reasonable limit of
> descriptors it will allow in a chain."
>=20
> Please also read the explanatory part I've linked, because the normative
> statement is pretty abstract.
>=20
> In my understanding, the spec says, that e.g. the virti-crypto device
> should not fail if a single request is split up into let's say two chunks
> and transmitted by the means of two top level descriptors.
>=20
> Do you agree with my reading of the spec?
>=20
Yes, I agree. But what's the relationship about the request here?
We don't assume the request have to use one desc entity, it can
use scatter-gather list for one request header.=20
The device can cover the situation in the QEMU.=20

> What does the virtio-crypto device do if it encounters such a situation?
>=20
This isn't a problem. Pls see blow code segment:

virtio_crypto_handle_request()
{...
if (unlikely(iov_to_buf(out_iov, out_num, 0, &req, sizeof(req))
                !=3D sizeof(req))) {
    virtio_error(vdev, "virtio-crypto request outhdr too short");
    return -1;
}
iov_discard_front(&out_iov, &out_num, sizeof(req));
...


Thanks,
-Gonglei
