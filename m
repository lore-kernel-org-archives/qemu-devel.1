Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91AEC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 14:20:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 503BA2085B
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 14:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2T2Chix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503BA2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPRLz-0008DG-95
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 10:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kPRJf-0006iD-1N
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 10:18:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44443)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kPRJc-0003QB-4C
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 10:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601907491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2RL0F0soIlNDBSpC6DdfSBq+qKv8CRh3LT0Ert77GlM=;
 b=D2T2ChixmPAhz1PMceGObdNDa3m1RWOfwrR8cpd1n+arsnzXSnek/D9VP0rwAzOMOCg17X
 ZyxW77X1rP1jrBSLSMstSMUuRjsrnwVHMNRbX/Fix9mo0KgkUi7visMGL5Jqmvm+g4FGe0
 N+fSorZBsbAnV5jtRpcr9zsru0mus6o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-2G1ak5w3ORGmGzj4W5h_7A-1; Mon, 05 Oct 2020 10:18:08 -0400
X-MC-Unique: 2G1ak5w3ORGmGzj4W5h_7A-1
Received: by mail-wm1-f71.google.com with SMTP id s12so61968wmj.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 07:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2RL0F0soIlNDBSpC6DdfSBq+qKv8CRh3LT0Ert77GlM=;
 b=qPW2zgaKVlX526S1UjmALDHGYg3gq+av9YvRrI+fHEbGXJ7nfN9N3oJQWTpC2TZSnb
 l7lqHf/T3CYwxFz0HVvD1kSyG4EWFZWAqIERfQTMnJgBLVd8mDN5s5S3DnshjKBsdfwL
 uxqOrEKW9Q6x6zaPZ3Ctj6LAJEzuw+vXA2zdLGPAtH7YkuAZMBVjIyphtyRjR3Fk5mah
 OLmmjc6G14lhHmnQkNrzLjtS5TQh+whSYPpjAOYSXkQGtoOJmaG/fR42gEAh+/irmXxL
 EeJkzpqZAXGWTn3Uc2J4iQXDQi6thKHvFf3yQeM0c/C5HGPhZDkwHpptzC2CcgrlVTlT
 VFpQ==
X-Gm-Message-State: AOAM533OI+/c/bxlc2a/xH5EfrHBaNbYliM/6UwmcVUQGpNMvSBNC7NL
 ZUw/8usT0oDWIdWF2KC3kjjNi+0boIh8elmF9A4C5i9EdDsZz2O0fPZF9YwldMIcZ9CNMVNyMQD
 Ge2OCR3FyMLi8VJg=
X-Received: by 2002:a1c:ed05:: with SMTP id l5mr17418302wmh.106.1601907487391; 
 Mon, 05 Oct 2020 07:18:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjoWE22/JEykGXUpojW1eaYOqEuMc51+TlBbWmlIoRzW2rcOjlplEaOFBVjveXLM5OivmTcg==
X-Received: by 2002:a1c:ed05:: with SMTP id l5mr17418273wmh.106.1601907487139; 
 Mon, 05 Oct 2020 07:18:07 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id y68sm13862756wmd.39.2020.10.05.07.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 07:18:06 -0700 (PDT)
Date: Mon, 5 Oct 2020 10:18:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] vhost: Ignore vrings in dirty log when using a vIOMMU
Message-ID: <20201005101414-mutt-send-email-mst@kernel.org>
References: <160105498386.68108.2145229309875282336.stgit@bahia.lan>
 <20200928062343.GA501872@yekko.fritz.box>
 <20200928093718.334774b2@bahia.lan>
MIME-Version: 1.0
In-Reply-To: <20200928093718.334774b2@bahia.lan>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
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

On Mon, Sep 28, 2020 at 09:37:18AM +0200, Greg Kurz wrote:
> On Mon, 28 Sep 2020 16:23:43 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
> > On Fri, Sep 25, 2020 at 07:29:43PM +0200, Greg Kurz wrote:
> > > When a vIOMMU is present, any address comming from the guest is an IO
> > > virtual address, including those of the vrings. The backend's accesses
> > > to the vrings happen through vIOMMU translation : the backend hence
> > > only logs the final guest physical address, not the IO virtual one.
> > > It thus doesn't make sense to make room for the vring addresses in the
> > > dirty log in this case.
> > > 
> > > This fixes a crash of the source when migrating a guest using in-kernel
> > > vhost-net and iommu_platform=on on POWER, because DMA regions are put
> > > at very high addresses and the resulting log size is likely to cause
> > > g_malloc0() to abort.
> > > 
> > > BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1879349
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > 
> > I'm a little confused as to what's going on here.  Obviously
> > allocating dirty bitmaps in IOVA space doesn't make much sense.
> > But.. in all cases isn't the ring ending up in guest memory, whether
> > translated or not.  So why do specific addresses of the ring make a
> > difference in *any* case.
> > 
> 
> I admit I'm a bit surprised as well... I can't think of a scenario
> where the address of the used ring would be higher than the guest
> memory... Maybe MST can shed some light here ?

So the original idea was that vring itself is specified in
terms of HVA as opposed to rest of stuff which is specified
in terms of GPA.
This way we wanted to support e.g. migration by vhost writing into
qemu address space, qemu copying data to guest memory.




> > > ---
> > >  hw/virtio/vhost.c |   38 ++++++++++++++++++++++++--------------
> > >  1 file changed, 24 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > > index 1a1384e7a642..0b83d6b8e65e 100644
> > > --- a/hw/virtio/vhost.c
> > > +++ b/hw/virtio/vhost.c
> > > @@ -106,6 +106,20 @@ static void vhost_dev_sync_region(struct vhost_dev *dev,
> > >      }
> > >  }
> > >  
> > > +static int vhost_dev_has_iommu(struct vhost_dev *dev)
> > > +{
> > > +    VirtIODevice *vdev = dev->vdev;
> > > +
> > > +    /*
> > > +     * For vhost, VIRTIO_F_IOMMU_PLATFORM means the backend support
> > > +     * incremental memory mapping API via IOTLB API. For platform that
> > > +     * does not have IOMMU, there's no need to enable this feature
> > > +     * which may cause unnecessary IOTLB miss/update trnasactions.
> > > +     */
> > > +    return vdev->dma_as != &address_space_memory &&
> > > +           virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
> > > +}
> > > +
> > >  static int vhost_sync_dirty_bitmap(struct vhost_dev *dev,
> > >                                     MemoryRegionSection *section,
> > >                                     hwaddr first,
> > > @@ -130,6 +144,11 @@ static int vhost_sync_dirty_bitmap(struct vhost_dev *dev,
> > >                                range_get_last(reg->guest_phys_addr,
> > >                                               reg->memory_size));
> > >      }
> > > +
> > > +    if (vhost_dev_has_iommu(dev)) {
> > > +        return 0;
> > > +    }
> > > +
> > >      for (i = 0; i < dev->nvqs; ++i) {
> > >          struct vhost_virtqueue *vq = dev->vqs + i;
> > >  
> > > @@ -172,6 +191,11 @@ static uint64_t vhost_get_log_size(struct vhost_dev *dev)
> > >                                         reg->memory_size);
> > >          log_size = MAX(log_size, last / VHOST_LOG_CHUNK + 1);
> > >      }
> > > +
> > > +    if (vhost_dev_has_iommu(dev)) {
> > > +        return log_size;
> > > +    }
> > > +
> > >      for (i = 0; i < dev->nvqs; ++i) {
> > >          struct vhost_virtqueue *vq = dev->vqs + i;
> > >  
> > > @@ -287,20 +311,6 @@ static inline void vhost_dev_log_resize(struct vhost_dev *dev, uint64_t size)
> > >      dev->log_size = size;
> > >  }
> > >  
> > > -static int vhost_dev_has_iommu(struct vhost_dev *dev)
> > > -{
> > > -    VirtIODevice *vdev = dev->vdev;
> > > -
> > > -    /*
> > > -     * For vhost, VIRTIO_F_IOMMU_PLATFORM means the backend support
> > > -     * incremental memory mapping API via IOTLB API. For platform that
> > > -     * does not have IOMMU, there's no need to enable this feature
> > > -     * which may cause unnecessary IOTLB miss/update trnasactions.
> > > -     */
> > > -    return vdev->dma_as != &address_space_memory &&
> > > -           virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
> > > -}
> > > -
> > >  static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
> > >                                hwaddr *plen, bool is_write)
> > >  {
> > > 
> > > 
> > 
> 



