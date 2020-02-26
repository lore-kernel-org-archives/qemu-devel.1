Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768F8C4BA0E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:48:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FCC020838
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hnPjYosd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FCC020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6vAi-0007Q2-D5
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 06:48:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60509)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6v7I-0003vx-Sz
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:44:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6v7H-0004g4-LX
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:44:40 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32006
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6v7G-0004ew-BM
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:44:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582717477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b2x94qZCIq4oqbhE7y5Dwa5PJ+QYeto4ruMNKJOAWgs=;
 b=hnPjYosdH4F6KBXoQMd4ctUeGkfq7EKYTbqVFedaTP0mwC+aDlRfkYLncihrfEeh2VLz/y
 rtGcBO9uNUM2uIK0afEI5c3mc41DWpTCuyxZo/+ch8NyPWnYow0USdw5wB7zLEL0L6h7gF
 mseh3oj36fApCTjxNx0gHLc2aU19ThE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-E1GyQ9QuNhq9bo3H1KcimQ-1; Wed, 26 Feb 2020 06:44:33 -0500
X-MC-Unique: E1GyQ9QuNhq9bo3H1KcimQ-1
Received: by mail-qt1-f197.google.com with SMTP id g26so4048706qts.16
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 03:44:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Ys+uwEZu0g1CxAD2/8HYnVrCJgaIzzZ14z/dg/SL1WQ=;
 b=VKczEe3vh5OKYg17yd3zyFC2ehP/7BH5XH+fuyAWerD9yAW5n9FjdPPQrA2O5VpRyj
 wDYjwcbZDLIBfkGXntLvWWdvzHEJcDwF8kLIpmwef+Ts5FK/EWpKq0oSp9mfi7hqDX9q
 zHZYtoe1rvxyI3wT1KdqP5cfvXAZODl8Aa6ZwvrtLFFlR7UWMzGRl9+xe+SccasX6Rrg
 TCXh0o7XbxeUBJpJlg7XCS33fom+bEEim0haKUKaPh6sqI1NtgZyzW7y0c8t8hpQKm67
 B5MEStiakk0VlZblILDBUJlSnELmCXBrHZ+ynzAPurrxipCQK5ZfddZKxZkUoLbj8jLD
 DUqg==
X-Gm-Message-State: APjAAAUMrzobLZ2/gR9Cj5cKkuVfQNlH/+7aasPTudoK0+AycbDN+wVS
 6JQxDdCta/k2aoRcYA+KtLCbnAmgBY/xvptvMMLgClelOj0a1t9d9EX+Ph6GYo5IHUvLpFGDFJp
 J+pWPpFhFstFSgRo=
X-Received: by 2002:a05:620a:74c:: with SMTP id
 i12mr5364863qki.286.1582717472994; 
 Wed, 26 Feb 2020 03:44:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqyHgpQUxeWxfZ7WvtdlldTV/pODsSVa+J52m5Z1uT5GGUCo80qy03aHUdGQqrMt6Mua7OZ3jw==
X-Received: by 2002:a05:620a:74c:: with SMTP id
 i12mr5364830qki.286.1582717472621; 
 Wed, 26 Feb 2020 03:44:32 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 x19sm944949qtm.47.2020.02.26.03.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 03:44:30 -0800 (PST)
Date: Wed, 26 Feb 2020 06:44:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2] vhost: correctly turn on VIRTIO_F_IOMMU_PLATFORM
Message-ID: <20200226064243-mutt-send-email-mst@kernel.org>
References: <20200226094357.25061-1-jasowang@redhat.com>
 <20200226045128-mutt-send-email-mst@kernel.org>
 <bd592433-71b9-773f-97ef-f5da87734b05@redhat.com>
MIME-Version: 1.0
In-Reply-To: <bd592433-71b9-773f-97ef-f5da87734b05@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: pasic@linux.ibm.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 26, 2020 at 06:17:34PM +0800, Jason Wang wrote:
>=20
> On 2020/2/26 =E4=B8=8B=E5=8D=885:53, Michael S. Tsirkin wrote:
> > On Wed, Feb 26, 2020 at 05:43:57PM +0800, Jason Wang wrote:
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
> > Well it's just an optimization, isn't it?
>=20
>=20
> Kind of, or a fix for the performance.
>=20

Given this wasn't a regression, it's a valuable enhancement
but Fixes: seems to agressive.

> > I don't think it's justified to push this to everyone using
> > vhost with IOTLB, is it?
>=20
>=20
> My understanding is that the function should be equivalent to IOTLB in th=
is
> case.
>=20
> Since no IOMMU is used and device may only see GPA.
>=20
> Another possible direction is to qemu to update memory table via device
> IOTLB API, this seems less straightforward.
>=20
>=20
> > If you disagree, could you comment a bit on which configurations where =
tested?
>=20
>=20
> I just do dirty shortcut to emulate the platform without get_dma_as wth
> IOMMU_PLATFORM set.
>=20
> Thanks

If you want Fixes tag with an expectation of everyone backporting,
then this also needs to be tested on a platform with a viommu,
such as dpdk within guest.

>=20
> >=20
> > > Cc: qemu-stable@nongnu.org
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > Halil could you test this pls? Does this help your performance issue?
> >=20
> > > ---
> > > Changes from V1:
> > > - do not check acked_features
> > > - reuse vhost_dev_has_iommu()
> > > ---
> > >   hw/virtio/vhost.c | 12 +++++++++++-
> > >   1 file changed, 11 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > > index 9edfadc81d..9182a00495 100644
> > > --- a/hw/virtio/vhost.c
> > > +++ b/hw/virtio/vhost.c
> > > @@ -290,7 +290,14 @@ static int vhost_dev_has_iommu(struct vhost_dev =
*dev)
> > >   {
> > >       VirtIODevice *vdev =3D dev->vdev;
> > > -    return virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
> > > +    /*
> > > +     * For vhost, VIRTIO_F_IOMMU_PLATFORM means the backend support
> > > +     * incremental memory mapping API via IOTLB API. For platform th=
at
> > > +     * does not have IOMMU, there's no need to enable this feature
> > > +     * which may cause unnecessary IOTLB miss/update trnasactions.
> > > +     */
> > > +    return vdev->dma_as !=3D &address_space_memory &&
> > > +           virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
> > >   }
> > >   static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
> > > @@ -765,6 +772,9 @@ static int vhost_dev_set_features(struct vhost_de=
v *dev,
> > >       if (enable_log) {
> > >           features |=3D 0x1ULL << VHOST_F_LOG_ALL;
> > >       }
> > > +    if (!vhost_dev_has_iommu(dev)) {
> > > +        features &=3D ~(0x1ULL << VIRTIO_F_IOMMU_PLATFORM);
> > > +    }
> > >       r =3D dev->vhost_ops->vhost_set_features(dev, features);
> > >       if (r < 0) {
> > >           VHOST_OPS_DEBUG("vhost_set_features failed");
> > > --=20
> > > 2.19.1


