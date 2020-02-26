Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A90C4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:21:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F152521556
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="She/z2rI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F152521556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6r0X-0003WO-Uc
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 02:21:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j6qzt-00032X-AQ
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:20:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j6qzs-00046p-4d
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:20:45 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60369
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j6qzs-00043i-06
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:20:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582701643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IDQ8Z6Ms4Uu0ms3Wg7Dw9OhWUM9eSORoP/D6lzNajUg=;
 b=She/z2rITlORFhyCMc8XHoiUxNh7uzJU9gjBEsF5Ad3pg3WzaxEcs+KS/OpG3mP2SjPFIM
 hrcPYS6YBfLGDd7eYrbrZimX47hpnyzN1HdBR8XaEE4jQltt1xhOSJDzXSHks5pwQRfmST
 hckoXaUVVUn2QofPtBSBBOERjD6V3EA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-jqg5QBoJM9CVp4Ew5CWtbQ-1; Wed, 26 Feb 2020 02:20:40 -0500
X-MC-Unique: jqg5QBoJM9CVp4Ew5CWtbQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31E2B1005512;
 Wed, 26 Feb 2020 07:20:38 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0297F5C297;
 Wed, 26 Feb 2020 07:20:38 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id D0C411809565;
 Wed, 26 Feb 2020 07:20:37 +0000 (UTC)
Date: Wed, 26 Feb 2020 02:20:36 -0500 (EST)
From: Jason Wang <jasowang@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <344493874.10686339.1582701636434.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200226020836-mutt-send-email-mst@kernel.org>
References: <20200226070647.8103-1-jasowang@redhat.com>
 <20200226020836-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH] vhost: correctly turn on VIRTIO_F_IOMMU_PLATFORM
MIME-Version: 1.0
X-Originating-IP: [10.68.5.20, 10.4.195.12]
Thread-Topic: vhost: correctly turn on VIRTIO_F_IOMMU_PLATFORM
Thread-Index: 9QgwL5zLK/co56b5/qtupdFIaODIJQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: pasic@linux.ibm.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



----- Original Message -----
> On Wed, Feb 26, 2020 at 03:06:47PM +0800, Jason Wang wrote:
> > We turn on device IOTLB via VIRTIO_F_IOMMU_PLATFORM unconditionally on
> > platform without IOMMU support. This can lead unnecessary IOTLB
> > transactions which will damage the performance.
> > 
> > Fixing this by check whether the device is backed by IOMMU and disable
> > device IOTLB.
> > 
> > Reported-by: Halil Pasic <pasic@linux.ibm.com>
> > Fixes: c471ad0e9bd46 ("vhost_net: device IOTLB support")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  hw/virtio/vhost.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index 9edfadc81d..6e12c3d2de 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -290,7 +290,14 @@ static int vhost_dev_has_iommu(struct vhost_dev *dev)
> >  {
> >      VirtIODevice *vdev = dev->vdev;
> >  
> > -    return virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
> > +    /*
> > +     * For vhost, VIRTIO_F_IOMMU_PLATFORM means the backend support
> > +     * incremental memory mapping API via IOTLB API. For platform that
> > +     * does not have IOMMU, there's no need to enable this feature
> > +     * which may cause unnecessary IOTLB miss/update trnasactions.
> > +     */
> > +    return vdev->dma_as != &address_space_memory &&
> > +           virtio_has_feature(dev->acked_features,
> > VIRTIO_F_IOMMU_PLATFORM);
> >  }
> >  
> >  static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
> 
> Why check acked_features and not host features here?
> I'd worry that if we do it like this, userspace driver
> within guest can clear the feature and make device access
> memory directly.

Right, host_features should be more than enough.

> 
> > @@ -765,6 +772,9 @@ static int vhost_dev_set_features(struct vhost_dev
> > *dev,
> >      if (enable_log) {
> >          features |= 0x1ULL << VHOST_F_LOG_ALL;
> >      }
> > +    if (dev->vdev->dma_as == &address_space_memory) {
> > +        features &= ~(0x1ULL << VIRTIO_F_IOMMU_PLATFORM);
> > +    }
> 
> 
> That's a guest visible change. Which seems at best unnecessary.
>

I don't get how this can be visible from guest? It works as F_LOG_ALL.

Thanks

> >      r = dev->vhost_ops->vhost_set_features(dev, features);
> >      if (r < 0) {
> >          VHOST_OPS_DEBUG("vhost_set_features failed");
> > --
> > 2.19.1
> 
> 


