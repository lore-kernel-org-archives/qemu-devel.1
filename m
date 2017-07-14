Received: from eggs.gnu.org ([2001:4830:134:3::10]:48176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dVoq9-00070j-VP
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 20:52:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dVoq6-0005Yz-Sa
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 20:52:18 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dVoq6-0005WG-9m
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 20:52:14 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Fri, 14 Jul 2017 00:51:53 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA312FA6@DGGEMA505-MBX.china.huawei.com>
References: <20170713110237.6712-1-lprosek@redhat.com>
	<20170713110237.6712-9-lprosek@redhat.com>
	<20170713172044.418abc4b@gondolin>
	<CABdb737gurpWSvDSCBBBfRMEkeVsnZc=qtcNzvWZmQ_N9WX-xg@mail.gmail.com>
	<20170713173653.1e76d68c@gondolin>
In-Reply-To: <20170713173653.1e76d68c@gondolin>
Content-Language: zh-CN
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Cornelia Huck <cohuck@redhat.com>, Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, =?iso-8859-1?Q?Fernando_Casas_Sch=F6ssow?= <casasfernando@hotmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, Greg Kurz <groug@kaod.org>, "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>


> -----Original Message-----
> From: Cornelia Huck [mailto:cohuck@redhat.com]
> Sent: Thursday, July 13, 2017 11:37 PM
> To: Ladi Prosek
> Cc: qemu-devel; Fernando Casas Sch=F6ssow; Michael S. Tsirkin; Jason Wang=
;
> Markus Armbruster; Greg Kurz; Gonglei (Arei);
> aneesh.kumar@linux.vnet.ibm.com; Stefan Hajnoczi
> Subject: Re: [Qemu-devel] [PATCH v2 8/8] virtio-crypto: use virtqueue_err=
or for
> errors with queue context
>=20
> On Thu, 13 Jul 2017 17:31:59 +0200
> Ladi Prosek <lprosek@redhat.com> wrote:
>=20
> > On Thu, Jul 13, 2017 at 5:20 PM, Cornelia Huck <cohuck@redhat.com>
> wrote:
> > > On Thu, 13 Jul 2017 13:02:37 +0200
> > > Ladi Prosek <lprosek@redhat.com> wrote:
> > >
> > >> virtqueue_error includes queue index in the error output and is pref=
erred
> > >> for errors that pertain to a virtqueue rather than to the device as =
a whole.
> > >>
> > >> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> > >> ---
> > >>  hw/virtio/virtio-crypto.c | 56
> ++++++++++++++++++++++++-----------------------
> > >>  1 file changed, 29 insertions(+), 27 deletions(-)
> > >>
> > >> diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
> > >> index 0353eb6..08e6c03 100644
> > >> --- a/hw/virtio/virtio-crypto.c
> > >> +++ b/hw/virtio/virtio-crypto.c
> > >> @@ -35,6 +35,7 @@ static inline int virtio_crypto_vq2q(int queue_ind=
ex)
> > >>
> > >>  static int
> > >>  virtio_crypto_cipher_session_helper(VirtIODevice *vdev,
> > >> +           VirtQueue *ctrl_vq,
> > >>             CryptoDevBackendSymSessionInfo *info,
> > >>             struct virtio_crypto_cipher_session_para *cipher_para,
> > >>             struct iovec **iov, unsigned int *out_num)
> > >> @@ -61,7 +62,7 @@ virtio_crypto_cipher_session_helper(VirtIODevice
> *vdev,
> > >>          info->cipher_key =3D g_malloc(info->key_len);
> > >>          s =3D iov_to_buf(*iov, num, 0, info->cipher_key, info->key_=
len);
> > >>          if (unlikely(s !=3D info->key_len)) {
> > >> -            virtio_error(vdev, "virtio-crypto cipher key incorrect"=
);
> > >> +            virtqueue_error(ctrl_vq, "virtio-crypto cipher key
> incorrect");
> > >
> > > As virtio-crypto devices always have one control queue, I would just
> > > use the pointer stored in the vcrypto structure. This avoids some of
> > > the cascading function signature changes.
> >
> > Will do. I wanted to be explicit to make the change more future-proof,
> > but maybe it is better to keep it simple. Thanks!
>=20
> I don't see a case for multiple virtio-crypto control vqs, even in the
> future, but let's see what the virtio-crypto maintainer thinks.
>=20
Yes, Cornelia is right. Pls go ahead.

Thanks,
-Gonglei
