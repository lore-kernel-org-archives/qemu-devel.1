Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16669C4BA0F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 08:13:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA9502084E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 08:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zt4aQoQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9502084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6rp8-0007jD-2E
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 03:13:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6roY-0007GT-6e
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 03:13:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6roV-0005wX-SJ
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 03:13:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37788
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6roV-0005s0-Io
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 03:13:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582704782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eq/lNXDfH0npSs6YBZgMhPnYI1gm2uORmmjtAflxvBY=;
 b=Zt4aQoQNLqBND5wVeCTS8EugJc7LsOyZfZa31eDKogezwxMZN0fZvh4YL0IfThy9jEJw/3
 EUOasmGlET3dSRcuJ6uWciMey6TIXrTZIO4AHbzMFSqiYgA47cZEJRQWhBDUhuvcVOGCC6
 g0B/6P/sLiwAH4aOAvAur3lbqHg/oX8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-zaEB1lWHPrmE_DUst110KQ-1; Wed, 26 Feb 2020 03:12:58 -0500
X-MC-Unique: zaEB1lWHPrmE_DUst110KQ-1
Received: by mail-qk1-f198.google.com with SMTP id i11so3045376qki.12
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 00:12:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MtgsRwg8tm0JrYCU5RQEw+IggaDLVkEE11eBrk9zP8A=;
 b=g2VfG1Yl7y5ApHTFPE/DB2zrHhtrivqgGYw0u4KQ99MtUuxRqGb+BU6veRnle0JEwC
 iaQALeQSTrAQrUlAP6erVpskZbuYu+iy5e9h5gWkKqBQxQZErxJEngBQOeM+2jEA7rpy
 r4GDhrcRwwfZHMZ8iCo4kYRFAVBfAn2PwMTGrH+Gi11MVjemMvvNWrpYGgZjUwTbFlWJ
 qRuBM9831sbomeUIy5Lirq/+skmj6LxFfTXdD1bSmNLvN2uClRaLRZ2RHTklS+pv+Giu
 y80FIvkFBd2d5xWxLJ1vKGwENisgSf/58srV3N4PRMH1qPTxxA7kdrIFt/+hixDT6Ruk
 HLVA==
X-Gm-Message-State: APjAAAWpjJP2fXj4Y+qMAplRo4bPO0dygCfuxlK/os2WJozaqG92viXc
 kcReJtp/rJHfCcpkbQzgWGAZutDymN+c50ZYwC+ELGGf6GpdY4eaKJZuaPd+SrAQdpUI5//emxq
 hovU3W6tt/6A0v48=
X-Received: by 2002:ac8:67d7:: with SMTP id r23mr3880971qtp.20.1582704778193; 
 Wed, 26 Feb 2020 00:12:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqzLJaeyasLFT2boYI9DCJg1NbFMj6foUmUfdgrXf5NdRnYTog5JCW77aSXcMyOdMKv3cmtHXw==
X-Received: by 2002:ac8:67d7:: with SMTP id r23mr3880953qtp.20.1582704777926; 
 Wed, 26 Feb 2020 00:12:57 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id z5sm741440qta.7.2020.02.26.00.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 00:12:57 -0800 (PST)
Date: Wed, 26 Feb 2020 03:12:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost: correctly turn on VIRTIO_F_IOMMU_PLATFORM
Message-ID: <20200226030945-mutt-send-email-mst@kernel.org>
References: <20200226070647.8103-1-jasowang@redhat.com>
 <20200226020836-mutt-send-email-mst@kernel.org>
 <344493874.10686339.1582701636434.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
In-Reply-To: <344493874.10686339.1582701636434.JavaMail.zimbra@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pasic@linux.ibm.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 26, 2020 at 02:20:36AM -0500, Jason Wang wrote:
>=20
>=20
> ----- Original Message -----
> > On Wed, Feb 26, 2020 at 03:06:47PM +0800, Jason Wang wrote:
> > > We turn on device IOTLB via VIRTIO_F_IOMMU_PLATFORM unconditionally o=
n
> > > platform without IOMMU support. This can lead unnecessary IOTLB
> > > transactions which will damage the performance.
> > >=20
> > > Fixing this by check whether the device is backed by IOMMU and disabl=
e
> > > device IOTLB.
> > >=20
> > > Reported-by: Halil Pasic <pasic@linux.ibm.com>
> > > Fixes: c471ad0e9bd46 ("vhost_net: device IOTLB support")
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  hw/virtio/vhost.c | 12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > > index 9edfadc81d..6e12c3d2de 100644
> > > --- a/hw/virtio/vhost.c
> > > +++ b/hw/virtio/vhost.c
> > > @@ -290,7 +290,14 @@ static int vhost_dev_has_iommu(struct vhost_dev =
*dev)
> > >  {
> > >      VirtIODevice *vdev =3D dev->vdev;
> > > =20
> > > -    return virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
> > > +    /*
> > > +     * For vhost, VIRTIO_F_IOMMU_PLATFORM means the backend support
> > > +     * incremental memory mapping API via IOTLB API. For platform th=
at
> > > +     * does not have IOMMU, there's no need to enable this feature
> > > +     * which may cause unnecessary IOTLB miss/update trnasactions.
> > > +     */
> > > +    return vdev->dma_as !=3D &address_space_memory &&
> > > +           virtio_has_feature(dev->acked_features,
> > > VIRTIO_F_IOMMU_PLATFORM);
> > >  }
> > > =20
> > >  static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
> >=20
> > Why check acked_features and not host features here?
> > I'd worry that if we do it like this, userspace driver
> > within guest can clear the feature and make device access
> > memory directly.
>=20
> Right, host_features should be more than enough.
>=20
> >=20
> > > @@ -765,6 +772,9 @@ static int vhost_dev_set_features(struct vhost_de=
v
> > > *dev,
> > >      if (enable_log) {
> > >          features |=3D 0x1ULL << VHOST_F_LOG_ALL;
> > >      }
> > > +    if (dev->vdev->dma_as =3D=3D &address_space_memory) {
> > > +        features &=3D ~(0x1ULL << VIRTIO_F_IOMMU_PLATFORM);
> > > +    }
> >=20
> >=20
> > That's a guest visible change. Which seems at best unnecessary.
> >
>=20
> I don't get how this can be visible from guest? It works as F_LOG_ALL.
>=20
> Thanks

Oh you are right.
So just call vhost_dev_has_iommu here too?

> > >      r =3D dev->vhost_ops->vhost_set_features(dev, features);
> > >      if (r < 0) {
> > >          VHOST_OPS_DEBUG("vhost_set_features failed");
> > > --
> > > 2.19.1
> >=20
> >=20


