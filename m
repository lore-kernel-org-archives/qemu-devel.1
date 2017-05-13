Received: from eggs.gnu.org ([2001:4830:134:3::10]:53189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d9LgX-0000hJ-TI
	for qemu-devel@nongnu.org; Fri, 12 May 2017 21:17:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d9LgU-0005fL-Ny
	for qemu-devel@nongnu.org; Fri, 12 May 2017 21:17:29 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d9LgT-0005Yu-Uh
	for qemu-devel@nongnu.org; Fri, 12 May 2017 21:17:26 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Sat, 13 May 2017 01:16:58 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA278AA0@DGGEMA505-MBS.china.huawei.com>
References: <1494243504-127980-1-git-send-email-arei.gonglei@huawei.com>
	<1494243504-127980-7-git-send-email-arei.gonglei@huawei.com>
	<520f45d4-33d7-8836-3140-a92ee5d15421@linux.vnet.ibm.com>
In-Reply-To: <520f45d4-33d7-8836-3140-a92ee5d15421@linux.vnet.ibm.com>
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
> Sent: Friday, May 12, 2017 7:02 PM
>=20
>=20
> On 05/08/2017 01:38 PM, Gonglei wrote:
> > According to the new spec, we should use different
> > requst structure to store the data request based
> > on whether VIRTIO_CRYPTO_F_MUX_MODE feature bit is
> > negotiated or not.
> >
> > In this patch, we havn't supported stateless mode
> > yet. The device reportes an error if both
> > VIRTIO_CRYPTO_F_MUX_MODE and
> VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE
> > are negotiated, meanwhile the header.flag doesn't set
> > to VIRTIO_CRYPTO_FLAG_SESSION_MODE.
> >
> > Let's handle this scenario in the following patches.
> >
> > Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> > ---
> >  hw/virtio/virtio-crypto.c | 83
> ++++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 71 insertions(+), 12 deletions(-)
> >
> > diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
> > index 0353eb6..c4b8a2c 100644
> > --- a/hw/virtio/virtio-crypto.c
> > +++ b/hw/virtio/virtio-crypto.c
> > @@ -577,6 +577,7 @@ virtio_crypto_handle_request(VirtIOCryptoReq
> *request)
> >      VirtQueueElement *elem =3D &request->elem;
> >      int queue_index =3D
> virtio_crypto_vq2q(virtio_get_queue_index(request->vq));
> >      struct virtio_crypto_op_data_req req;
> > +    struct virtio_crypto_op_data_req_mux req_mux;
> >      int ret;
> >      struct iovec *in_iov;
> >      struct iovec *out_iov;
> > @@ -587,6 +588,9 @@ virtio_crypto_handle_request(VirtIOCryptoReq
> *request)
> >      uint64_t session_id;
> >      CryptoDevBackendSymOpInfo *sym_op_info =3D NULL;
> >      Error *local_err =3D NULL;
> > +    bool mux_mode_is_negotiated;
> > +    struct virtio_crypto_op_header *header;
> > +    bool is_stateless_req =3D false;
> >
> >      if (elem->out_num < 1 || elem->in_num < 1) {
> >          virtio_error(vdev, "virtio-crypto dataq missing headers");
> > @@ -597,12 +601,28 @@ virtio_crypto_handle_request(VirtIOCryptoReq
> *request)
> >      out_iov =3D elem->out_sg;
> >      in_num =3D elem->in_num;
> >      in_iov =3D elem->in_sg;
> > -    if (unlikely(iov_to_buf(out_iov, out_num, 0, &req, sizeof(req))
> > -                !=3D sizeof(req))) {
> > -        virtio_error(vdev, "virtio-crypto request outhdr too short");
> > -        return -1;
> > +
> > +    mux_mode_is_negotiated =3D
> > +        virtio_vdev_has_feature(vdev, VIRTIO_CRYPTO_F_MUX_MODE);
> > +    if (!mux_mode_is_negotiated) {
> > +        if (unlikely(iov_to_buf(out_iov, out_num, 0, &req, sizeof(req)=
)
> > +                    !=3D sizeof(req))) {
> > +            virtio_error(vdev, "virtio-crypto request outhdr too short=
");
> > +            return -1;
> > +        }
> > +        iov_discard_front(&out_iov, &out_num, sizeof(req));
> > +
> > +        header =3D &req.header;
> > +    } else {
> > +        if (unlikely(iov_to_buf(out_iov, out_num, 0, &req_mux,
> > +                sizeof(req_mux)) !=3D sizeof(req_mux))) {
> > +            virtio_error(vdev, "virtio-crypto request outhdr too short=
");
> > +            return -1;
> > +        }
> > +        iov_discard_front(&out_iov, &out_num, sizeof(req_mux));
> > +
> > +        header =3D &req_mux.header;
>=20
> I wonder if this request length checking logic is conform to the
> most recent spec draft on the list ("[PATCH v18 0/2] virtio-crypto:
> virtio crypto device specification").
>=20
Sure. Please see below normative formulation:

'''
\drivernormative{\paragraph}{Symmetric algorithms Operation}{Device Types /=
 Crypto Device / Device Operation / Symmetric algorithms Operation}
...
\item If the VIRTIO_CRYPTO_F_MUX_MODE feature bit is negotiated, the driver=
 MUST use struct virtio_crypto_op_data_req_mux to wrap crypto requests.
Otherwise, the driver MUST use struct virtio_crypto_op_data_req.
...
'''

> AFAIU here you allow only requests of two sizes: one fixed size
> for VIRTIO_CRYPTO_F_MUX_MODE and one without that feature. This
> means that some requests need quite some padding between what
> you call the 'request' and the actual data on which the crypto
> operation dictated by the 'request' needs to be performed.

Yes, that's true.

> What are the benefits of this approach?
>=20
We could unify the request for all algorithms, both symmetric algos and asy=
mmetric algos,
which is very convenient for handling tens of hundreds of different algorit=
hm requests.


Thanks,
-Gonglei
