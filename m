Received: from eggs.gnu.org ([2001:4830:134:3::10]:34572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cHgap-0006Lg-8V
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 19:41:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cHgal-00072I-AF
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 19:41:47 -0500
Received: from [45.249.212.189] (port=2375 helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cHgak-0006lc-1Q
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 19:41:43 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Fri, 16 Dec 2016 00:40:14 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA166351@DGGEMA505-MBX.china.huawei.com>
References: <1481716249-185392-1-git-send-email-arei.gonglei@huawei.com>
	<1481716249-185392-2-git-send-email-arei.gonglei@huawei.com>
	<bcf62fa0-8fc9-daaf-ea7b-e09eb83b593a@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA163033@DGGEMA505-MBX.china.huawei.com>
	<82063967A54EF84C8AFCD6BD7F6AD93310C14374@SHSMSX103.ccr.corp.intel.com>
	<33183CC9F5247A488A2544077AF19020DA16320F@DGGEMA505-MBX.china.huawei.com>
	<20161215184153-mutt-send-email-mst@kernel.org>
In-Reply-To: <20161215184153-mutt-send-email-mst@kernel.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v7 1/1] crypto: add
 virtio-crypto driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Zeng, Xin" <xin.zeng@intel.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "Huangweidong (C)" <weidong.huang@huawei.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, Luonengjun <luonengjun@huawei.com>, "Hanweidong (Randy)" <hanweidong@huawei.com>, "Xuquan (Quan Xu)" <xuquan8@huawei.com>, "Wanzongshun (Vincent)" <wanzongshun@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, longpeng <longpeng2@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "davem@davemloft.net" <davem@davemloft.net>, "Wubin (H)" <wu.wubin@huawei.com>, "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>

Hi Michael,

>
> >
> >
> > > Subject: RE: [Qemu-devel] [PATCH v7 1/1] crypto: add virtio-crypto dr=
iver
> > >
> > > On Thursday, December 15, 2016 8:45 AM, Gonglei (Arei) Wrote:
> > > < > > diff --git a/drivers/crypto/virtio/virtio_crypto_core.c
> > > < > b/drivers/crypto/virtio/virtio_crypto_core.c
> > > < > > new file mode 100644
> > > < > > index 0000000..c0854a1
> > > < > > --- /dev/null
> > > < > > +++ b/drivers/crypto/virtio/virtio_crypto_core.c
> > > < > > @@ -0,0 +1,474 @@
> > > < > [..]
> > > < > > +
> > > < > > +static void virtcrypto_dataq_callback(struct virtqueue *vq)
> > > < > > +{
> > > < > > +	struct virtio_crypto *vcrypto =3D vq->vdev->priv;
> > > < > > +	struct virtio_crypto_request *vc_req;
> > > < > > +	unsigned long flags;
> > > < > > +	unsigned int len;
> > > < > > +	struct ablkcipher_request *ablk_req;
> > > < > > +	int error;
> > > < > > +
> > > < > > +	spin_lock_irqsave(&vcrypto->lock, flags);
> > > < >
> > > < > Would it make sense to use a per virtqueue lock
> > > < > like in virtio_blk for example instead of locking on the whole
> > > < > device? OK, it seems you use only one dataqueue, so it
> > > < > may not be that relevant.
> > > < >
> > > < Currently yes, both the backend device (cryptodev-backend-builtin)
> > > < and the frontend driver use one dataqueue.
> > > <
> > >
> > > I think it makes sense to use per virtqueue lock here though it only =
uses one
> > > queue so far,
> > > but in the spec we already have multi queues support.
> > >
> > Yes, I agree. Will do that in V8 soon.
> > Hope to catch up with Michael's pull request for 4.10.
> >
> > Regards,
> > -Gonglei
>=20
> I merged v7, this change will have to wait. Sorry.
>=20
That's OK. Thanks!

I can post a separate patch after this pull request.=20

Regards,
-Gonglei
