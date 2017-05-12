Received: from eggs.gnu.org ([2001:4830:134:3::10]:54931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d98e1-0008CX-LY
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:22:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d98dy-0004Fm-Fi
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:22:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60233)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d98dy-0004Cy-5b
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:21:58 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4CBJscg116902
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 07:21:53 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2acx6c4aqr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 07:21:53 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 12 May 2017 12:21:51 +0100
Date: Fri, 12 May 2017 13:21:46 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA26D816@DGGEMA505-MBX.china.huawei.com>
References: <1494243504-127980-1-git-send-email-arei.gonglei@huawei.com>
	<1494243504-127980-9-git-send-email-arei.gonglei@huawei.com>
	<20170511170527.5846a676.cornelia.huck@de.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA26D816@DGGEMA505-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170512132146.64b811be.cornelia.huck@de.ibm.com>
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
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, "stefanha@redhat.com" <stefanha@redhat.com>, Luonengjun <luonengjun@huawei.com>, Linqiangmin <linqiangmin@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "Wubin (H)" <wu.wubin@huawei.com>

On Fri, 12 May 2017 00:55:23 +0000
"Gonglei (Arei)" <arei.gonglei@huawei.com> wrote:

> >
> > From: Cornelia Huck [mailto:cornelia.huck@de.ibm.com]
> > Sent: Thursday, May 11, 2017 11:05 PM
> > Subject: Re: [RFC v1 8/9] virtio-crypto: add host feature bits support
> > 
> > On Mon, 8 May 2017 19:38:23 +0800
> > Gonglei <arei.gonglei@huawei.com> wrote:
> > 
> > > We enable all feature bits acquiescently.
> > >
> > > Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> > > ---
> > >  hw/virtio/virtio-crypto.c         | 15 +++++++++++++++
> > >  include/hw/virtio/virtio-crypto.h |  1 +
> > >  2 files changed, 16 insertions(+)
> > >
> > > diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
> > > index 5422f25..3dc0ff2 100644
> > > --- a/hw/virtio/virtio-crypto.c
> > > +++ b/hw/virtio/virtio-crypto.c
> > > @@ -1034,6 +1034,11 @@ static uint64_t
> > virtio_crypto_get_features(VirtIODevice *vdev,
> > >                                             uint64_t features,
> > >                                             Error **errp)
> > >  {
> > > +    VirtIOCrypto *vcrypto = VIRTIO_CRYPTO(vdev);
> > > +
> > > +    /* Firstly sync all virtio-crypto possible supported features */
> > > +    features |= vcrypto->host_features;
> > > +
> > >      return features;
> > >  }
> > >
> > > @@ -1144,6 +1149,16 @@ static const VMStateDescription
> > vmstate_virtio_crypto = {
> > >  };
> > >
> > >  static Property virtio_crypto_properties[] = {
> > > +    DEFINE_PROP_BIT("mux_mode", VirtIOCrypto, host_features,
> > > +                    VIRTIO_CRYPTO_F_MUX_MODE, true),
> > > +    DEFINE_PROP_BIT("cipher_stateless_mode", VirtIOCrypto,
> > host_features,
> > > +                    VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE,
> > true),
> > > +    DEFINE_PROP_BIT("hash_stateless_mode", VirtIOCrypto,
> > host_features,
> > > +                    VIRTIO_CRYPTO_F_HASH_STATELESS_MODE,
> > true),
> > > +    DEFINE_PROP_BIT("mac_stateless_mode", VirtIOCrypto,
> > host_features,
> > > +                    VIRTIO_CRYPTO_F_MAC_STATELESS_MODE, true),
> > > +    DEFINE_PROP_BIT("aead_stateless_mode", VirtIOCrypto,
> > host_features,
> > > +                    VIRTIO_CRYPTO_F_AEAD_STATELESS_MODE,
> > true),
> > >      DEFINE_PROP_END_OF_LIST(),
> > >  };
> > >
> > > diff --git a/include/hw/virtio/virtio-crypto.h b/include/hw/virtio/virtio-crypto.h
> > > index 465ad20..30ea51d 100644
> > > --- a/include/hw/virtio/virtio-crypto.h
> > > +++ b/include/hw/virtio/virtio-crypto.h
> > > @@ -97,6 +97,7 @@ typedef struct VirtIOCrypto {
> > >      int multiqueue;
> > >      uint32_t curr_queues;
> > >      size_t config_size;
> > > +    uint32_t host_features;
> > 
> > I'd just make that 64 bits from the start.
> > 
> Yes, that's better.
> 
> > >  } VirtIOCrypto;
> > >
> > >  #endif /* _QEMU_VIRTIO_CRYPTO_H */
> > 
> > Don't you need some kind of compat handling?
> 
> I did that in patch 6 according to the results of those feature bits negotiated.
> Patch 9 tests both session mode and stateless mode, they are work. :)

Ah, I meant machine compat handling. You probably don't want to offer
these feature bits in older compat machines.
