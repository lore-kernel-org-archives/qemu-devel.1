Received: from eggs.gnu.org ([2001:4830:134:3::10]:47846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d8ys2-00060r-92
	for qemu-devel@nongnu.org; Thu, 11 May 2017 20:55:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d8yrz-00077W-6K
	for qemu-devel@nongnu.org; Thu, 11 May 2017 20:55:50 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d8yry-0006yh-Js
	for qemu-devel@nongnu.org; Thu, 11 May 2017 20:55:47 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Fri, 12 May 2017 00:55:23 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA26D816@DGGEMA505-MBX.china.huawei.com>
References: <1494243504-127980-1-git-send-email-arei.gonglei@huawei.com>
	<1494243504-127980-9-git-send-email-arei.gonglei@huawei.com>
	<20170511170527.5846a676.cornelia.huck@de.ibm.com>
In-Reply-To: <20170511170527.5846a676.cornelia.huck@de.ibm.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC v1 8/9] virtio-crypto: add host feature bits
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, "stefanha@redhat.com" <stefanha@redhat.com>, Luonengjun <luonengjun@huawei.com>, Linqiangmin <linqiangmin@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "Wubin
	(H)" <wu.wubin@huawei.com>

>
> From: Cornelia Huck [mailto:cornelia.huck@de.ibm.com]
> Sent: Thursday, May 11, 2017 11:05 PM
> Subject: Re: [RFC v1 8/9] virtio-crypto: add host feature bits support
>=20
> On Mon, 8 May 2017 19:38:23 +0800
> Gonglei <arei.gonglei@huawei.com> wrote:
>=20
> > We enable all feature bits acquiescently.
> >
> > Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> > ---
> >  hw/virtio/virtio-crypto.c         | 15 +++++++++++++++
> >  include/hw/virtio/virtio-crypto.h |  1 +
> >  2 files changed, 16 insertions(+)
> >
> > diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
> > index 5422f25..3dc0ff2 100644
> > --- a/hw/virtio/virtio-crypto.c
> > +++ b/hw/virtio/virtio-crypto.c
> > @@ -1034,6 +1034,11 @@ static uint64_t
> virtio_crypto_get_features(VirtIODevice *vdev,
> >                                             uint64_t features,
> >                                             Error **errp)
> >  {
> > +    VirtIOCrypto *vcrypto =3D VIRTIO_CRYPTO(vdev);
> > +
> > +    /* Firstly sync all virtio-crypto possible supported features */
> > +    features |=3D vcrypto->host_features;
> > +
> >      return features;
> >  }
> >
> > @@ -1144,6 +1149,16 @@ static const VMStateDescription
> vmstate_virtio_crypto =3D {
> >  };
> >
> >  static Property virtio_crypto_properties[] =3D {
> > +    DEFINE_PROP_BIT("mux_mode", VirtIOCrypto, host_features,
> > +                    VIRTIO_CRYPTO_F_MUX_MODE, true),
> > +    DEFINE_PROP_BIT("cipher_stateless_mode", VirtIOCrypto,
> host_features,
> > +                    VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE,
> true),
> > +    DEFINE_PROP_BIT("hash_stateless_mode", VirtIOCrypto,
> host_features,
> > +                    VIRTIO_CRYPTO_F_HASH_STATELESS_MODE,
> true),
> > +    DEFINE_PROP_BIT("mac_stateless_mode", VirtIOCrypto,
> host_features,
> > +                    VIRTIO_CRYPTO_F_MAC_STATELESS_MODE, true),
> > +    DEFINE_PROP_BIT("aead_stateless_mode", VirtIOCrypto,
> host_features,
> > +                    VIRTIO_CRYPTO_F_AEAD_STATELESS_MODE,
> true),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >
> > diff --git a/include/hw/virtio/virtio-crypto.h b/include/hw/virtio/virt=
io-crypto.h
> > index 465ad20..30ea51d 100644
> > --- a/include/hw/virtio/virtio-crypto.h
> > +++ b/include/hw/virtio/virtio-crypto.h
> > @@ -97,6 +97,7 @@ typedef struct VirtIOCrypto {
> >      int multiqueue;
> >      uint32_t curr_queues;
> >      size_t config_size;
> > +    uint32_t host_features;
>=20
> I'd just make that 64 bits from the start.
>=20
Yes, that's better.

> >  } VirtIOCrypto;
> >
> >  #endif /* _QEMU_VIRTIO_CRYPTO_H */
>=20
> Don't you need some kind of compat handling?

I did that in patch 6 according to the results of those feature bits negoti=
ated.
Patch 9 tests both session mode and stateless mode, they are work. :)

Thanks,
-Gonglei
