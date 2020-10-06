Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99269C47095
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 10:50:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1E2D20760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 10:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bdXoAItB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E2D20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPkYS-0003RN-Jh
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 06:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kPkXO-00031R-3s
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 06:49:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33244)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kPkXK-0002NS-6K
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 06:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601981376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4wHbsnC/ohn0zuSO1tCrTIQhTiNO67Ba5K4HXT2Wjk4=;
 b=bdXoAItBMARu4k2tljAa1Li0t7Ob3/5QoHs7y7vnQIBVvPH4i521SpH9GOqfYczXPiwu21
 a3/fk+3fPTc++s5AdQicyiq0mnICmgAlpjOB9IgNwVfPrpIdKGd1BEa4STQz1ylBDll6mm
 IUJWQHvG0sZTLc2UsblQKoVOnlgLHjQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-k7-z9OgfOCu_PYy0KQbtIg-1; Tue, 06 Oct 2020 06:49:34 -0400
X-MC-Unique: k7-z9OgfOCu_PYy0KQbtIg-1
Received: by mail-wr1-f72.google.com with SMTP id l17so5152428wrw.11
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 03:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4wHbsnC/ohn0zuSO1tCrTIQhTiNO67Ba5K4HXT2Wjk4=;
 b=oRzckT+9GBf1eKAk5L8bkoze1PT2nAWFCwB2O/+CGsBUM0mHyImav57ouTkgWX8tGd
 tLCyTdcL3TExtOEi/yXl/YQ9vhv5LC3bsMTo5RojbgBBv9AaUB9IYxC2Zqlr2sVkfqge
 G9YlLvw6npW+mVvAAHe8bKMhmcLuBd4a/4RTyAV+pwmp+zlJ6q3f+ltf12PbibiwmD+8
 5obv+OyzxQgk9dRc4X+ND097MYrvbwX0QbMGNKqu9h9uNkV2SEEhO+QolAyDlmLiZ1rU
 TAgl1e2CoeunwVdbCfDojvsbYfHYilGGu1at5BJD7S8n9XoSsJebtuqfSB2cXrOlWkD/
 LREg==
X-Gm-Message-State: AOAM533OWnbu4pUwD4xsiavBlLGELFyTWp6WBqfryANbsfKFTZ/3Slnw
 NZ873mDEJxdk52bvviEVS5Iy38hAAzP+a/4kBdDxJKrAvx2a3+j8lq7lVqMgGhfgst8Nw+5lDiR
 r8OO7aKbj5+vxEzc=
X-Received: by 2002:adf:f504:: with SMTP id q4mr4130353wro.353.1601981373334; 
 Tue, 06 Oct 2020 03:49:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaZqSHROJggSp2L0l0E7pGmAJZY17haKTSVoOgrbHR5JzGcvM0XGSnG/EHYMTfeyWibrSfjQ==
X-Received: by 2002:adf:f504:: with SMTP id q4mr4130326wro.353.1601981373002; 
 Tue, 06 Oct 2020 03:49:33 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id h206sm3643381wmf.47.2020.10.06.03.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 03:49:31 -0700 (PDT)
Date: Tue, 6 Oct 2020 06:49:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] vhost: Ignore vrings in dirty log when using a vIOMMU
Message-ID: <20201006064659-mutt-send-email-mst@kernel.org>
References: <160105498386.68108.2145229309875282336.stgit@bahia.lan>
 <20200928062343.GA501872@yekko.fritz.box>
 <20200928093718.334774b2@bahia.lan>
 <20201005101414-mutt-send-email-mst@kernel.org>
 <20201006115850.11f06b8e@bahia.lan>
MIME-Version: 1.0
In-Reply-To: <20201006115850.11f06b8e@bahia.lan>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <laurent@vivier.eu>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 06, 2020 at 11:58:50AM +0200, Greg Kurz wrote:
> On Mon, 5 Oct 2020 10:18:03 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Sep 28, 2020 at 09:37:18AM +0200, Greg Kurz wrote:
> > > On Mon, 28 Sep 2020 16:23:43 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > 
> > > > On Fri, Sep 25, 2020 at 07:29:43PM +0200, Greg Kurz wrote:
> > > > > When a vIOMMU is present, any address comming from the guest is an IO
> > > > > virtual address, including those of the vrings. The backend's accesses
> > > > > to the vrings happen through vIOMMU translation : the backend hence
> > > > > only logs the final guest physical address, not the IO virtual one.
> > > > > It thus doesn't make sense to make room for the vring addresses in the
> > > > > dirty log in this case.
> > > > > 
> > > > > This fixes a crash of the source when migrating a guest using in-kernel
> > > > > vhost-net and iommu_platform=on on POWER, because DMA regions are put
> > > > > at very high addresses and the resulting log size is likely to cause
> > > > > g_malloc0() to abort.
> > > > > 
> > > > > BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1879349
> > > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > 
> > > > I'm a little confused as to what's going on here.  Obviously
> > > > allocating dirty bitmaps in IOVA space doesn't make much sense.
> > > > But.. in all cases isn't the ring ending up in guest memory, whether
> > > > translated or not.  So why do specific addresses of the ring make a
> > > > difference in *any* case.
> > > > 
> > > 
> > > I admit I'm a bit surprised as well... I can't think of a scenario
> > > where the address of the used ring would be higher than the guest
> > > memory... Maybe MST can shed some light here ?
> > 
> > So the original idea was that vring itself is specified in
> > terms of HVA as opposed to rest of stuff which is specified
> > in terms of GPA.
> 
> The vring itself is indeed described in term of HVA (vq->used) but
> when it comes to the dirty log, QEMU passes the GPA of the used
> structure to the vhost backend:
> 
> >From vhost_virtqueue_set_addr():
> 
>     addr.log_guest_addr = vq->used_phys;
>                               ^^ GPA ^^
>     addr.flags = enable_log ? (1 << VHOST_VRING_F_LOG) : 0;
>     r = dev->vhost_ops->vhost_set_vring_addr(dev, &addr);

Right. The point being we either use the log bitmap or the ring aliasing
trick to track memory changes, not both. If we used the ring aliasing
trick then presumably VHOST_VRING_F_LOG would be clear and then
log_guest_addr is unused.

> And the sizing of the bitmap computed in vhost_get_log_size() is
> also based on this GPA:
> 
>     for (i = 0; i < dev->nvqs; ++i) {
>         struct vhost_virtqueue *vq = dev->vqs + i;
> 
>         if (!vq->used_phys && !vq->used_size) {
>             continue;
>         }
> 
>         uint64_t last = vq->used_phys + vq->used_size - 1;
>                             ^^ GPA ^^
>         log_size = MAX(log_size, last / VHOST_LOG_CHUNK + 1);
>     }
>
> With platform_iommu=off, I couldn't find a case where this second
> loop in vhost_get_log_size() increases the log size actually... and
> when platform_iommu=on, vq->used_phys is a GIOVA that my other patches
> you've already merged in the kernel explicitly ignore when it comes to
> the dirty log... So it really seems that this loop is useless for the
> general case. If it is there to address some corner case, I guess it
> deserves a comment at the very least.
> 
> Cheers,
> 
> --
> Greg
> 
> > This way we wanted to support e.g. migration by vhost writing into
> > qemu address space, qemu copying data to guest memory.
> > 
> > 
> > 
> > 
> > > > > ---
> > > > >  hw/virtio/vhost.c |   38 ++++++++++++++++++++++++--------------
> > > > >  1 file changed, 24 insertions(+), 14 deletions(-)
> > > > > 
> > > > > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > > > > index 1a1384e7a642..0b83d6b8e65e 100644
> > > > > --- a/hw/virtio/vhost.c
> > > > > +++ b/hw/virtio/vhost.c
> > > > > @@ -106,6 +106,20 @@ static void vhost_dev_sync_region(struct vhost_dev *dev,
> > > > >      }
> > > > >  }
> > > > >  
> > > > > +static int vhost_dev_has_iommu(struct vhost_dev *dev)
> > > > > +{
> > > > > +    VirtIODevice *vdev = dev->vdev;
> > > > > +
> > > > > +    /*
> > > > > +     * For vhost, VIRTIO_F_IOMMU_PLATFORM means the backend support
> > > > > +     * incremental memory mapping API via IOTLB API. For platform that
> > > > > +     * does not have IOMMU, there's no need to enable this feature
> > > > > +     * which may cause unnecessary IOTLB miss/update trnasactions.
> > > > > +     */
> > > > > +    return vdev->dma_as != &address_space_memory &&
> > > > > +           virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
> > > > > +}
> > > > > +
> > > > >  static int vhost_sync_dirty_bitmap(struct vhost_dev *dev,
> > > > >                                     MemoryRegionSection *section,
> > > > >                                     hwaddr first,
> > > > > @@ -130,6 +144,11 @@ static int vhost_sync_dirty_bitmap(struct vhost_dev *dev,
> > > > >                                range_get_last(reg->guest_phys_addr,
> > > > >                                               reg->memory_size));
> > > > >      }
> > > > > +
> > > > > +    if (vhost_dev_has_iommu(dev)) {
> > > > > +        return 0;
> > > > > +    }
> > > > > +
> > > > >      for (i = 0; i < dev->nvqs; ++i) {
> > > > >          struct vhost_virtqueue *vq = dev->vqs + i;
> > > > >  
> > > > > @@ -172,6 +191,11 @@ static uint64_t vhost_get_log_size(struct vhost_dev *dev)
> > > > >                                         reg->memory_size);
> > > > >          log_size = MAX(log_size, last / VHOST_LOG_CHUNK + 1);
> > > > >      }
> > > > > +
> > > > > +    if (vhost_dev_has_iommu(dev)) {
> > > > > +        return log_size;
> > > > > +    }
> > > > > +
> > > > >      for (i = 0; i < dev->nvqs; ++i) {
> > > > >          struct vhost_virtqueue *vq = dev->vqs + i;
> > > > >  
> > > > > @@ -287,20 +311,6 @@ static inline void vhost_dev_log_resize(struct vhost_dev *dev, uint64_t size)
> > > > >      dev->log_size = size;
> > > > >  }
> > > > >  
> > > > > -static int vhost_dev_has_iommu(struct vhost_dev *dev)
> > > > > -{
> > > > > -    VirtIODevice *vdev = dev->vdev;
> > > > > -
> > > > > -    /*
> > > > > -     * For vhost, VIRTIO_F_IOMMU_PLATFORM means the backend support
> > > > > -     * incremental memory mapping API via IOTLB API. For platform that
> > > > > -     * does not have IOMMU, there's no need to enable this feature
> > > > > -     * which may cause unnecessary IOTLB miss/update trnasactions.
> > > > > -     */
> > > > > -    return vdev->dma_as != &address_space_memory &&
> > > > > -           virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
> > > > > -}
> > > > > -
> > > > >  static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
> > > > >                                hwaddr *plen, bool is_write)
> > > > >  {
> > > > > 
> > > > > 
> > > > 
> > > 
> > 
> > 


