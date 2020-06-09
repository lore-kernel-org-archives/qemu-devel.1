Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D65EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 15:37:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07BF6207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 15:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IszXnI2i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07BF6207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jigJs-0001cX-8h
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 11:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jigIu-000112-SD
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 11:36:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59750
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jigIu-0006op-3O
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 11:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591717003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SYsusc9QBsKaS0CUak7Mvr5PaexPUxZYx6eRhqnfipU=;
 b=IszXnI2i990Xn4lMXuywR/IiIMkvHhex0Mvc6RhaFDr5Wx2kSCDhxXaFASkbXZq4pr0vII
 pZlt/xIx/Ph8Si7ghOCQUL6eFCQruZ7p+4uc9MznSVCvMX2io15YXzHCWjOXK8M3ile4yz
 3a0NOP6tca1PXDbMCxeyGawgE1/gXhg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-VQ42CqcpPdieTwn62N2lIg-1; Tue, 09 Jun 2020 11:36:42 -0400
X-MC-Unique: VQ42CqcpPdieTwn62N2lIg-1
Received: by mail-wm1-f70.google.com with SMTP id r1so829993wmh.7
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 08:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SYsusc9QBsKaS0CUak7Mvr5PaexPUxZYx6eRhqnfipU=;
 b=AN77hNSPfE+oqZVjOz/FTm29mi+lvbkhYP/0OleO9O//Y2kCfWpRT96i0t0Xiz6Vbf
 BBgv8UkFoDxZLgULDYTwqHRv7mm0VhJLA6QPaHylVKYe8NyCykv6d/NGDG3sTaunXAG/
 VZ4DeasTYEuPCCHekNoy1avD7Hk5B6KGtTluFugNyb+ERfHxtUsIN9FRSvTq9IzRpgIp
 qkQItQ9XFO0TuYGtjyfTFRxfYneGledVDjV3v/4sKIVJg1/QDzqBXx11j2V0eoG8llIb
 uYenix5Ycb7Fsb5whE2VcFDi8+/oWv/OvPRBsUaivavMawyLEQ5Lvv4dDfaV6PjvVeF+
 j2UA==
X-Gm-Message-State: AOAM533H3msiApXWfCPCRoDEwnx3ykBC29lcZ/p/q4W18BEXZhyIOU4K
 myE4663/Pbm5/zC24mNR4MNyBa0gO1NPv9o6muILIAaMFAvWc3rjv0EyIJ0uLyllvd3Y1D8HAwv
 q+3g2BBQoM5zWZ2I=
X-Received: by 2002:a1c:62d6:: with SMTP id w205mr4394472wmb.97.1591716998194; 
 Tue, 09 Jun 2020 08:36:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwf97kql+YK9bZ1zXSeIgvlKlX0vMPOw2FaHxbaeY6D2ua1AG7vUiBQM8qjUOVaz2jwQ1Hrg==
X-Received: by 2002:a1c:62d6:: with SMTP id w205mr4394373wmb.97.1591716996954; 
 Tue, 09 Jun 2020 08:36:36 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id w10sm3886247wrp.16.2020.06.09.08.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 08:36:36 -0700 (PDT)
Date: Tue, 9 Jun 2020 11:36:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: Re: [PATCH v4 5/5] vhost-user-blk: default num_queues to -smp N
Message-ID: <20200609113523-mutt-send-email-mst@kernel.org>
References: <20200527102925.128013-1-stefanha@redhat.com>
 <20200527102925.128013-6-stefanha@redhat.com>
 <CAFubqFuCk42dRtKvC=V-A288y7JC398-fWSDPx7YsU97O8foGg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFubqFuCk42dRtKvC=V-A288y7JC398-fWSDPx7YsU97O8foGg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 01:38:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 cohuck@redhat.com, QEMU <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, May 30, 2020 at 10:42:05PM -0400, Raphael Norwitz wrote:
> I'm happy with the code but as David pointed out with virtio-scsi, we
> should probably add a comment about virtio_pci_optimal_num_queues()
> capping the number of VQs here too.

Stefan could you add this tweak and repost pls? Thanks!


> 
> On Wed, May 27, 2020 at 6:34 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >
> > Automatically size the number of request virtqueues to match the number
> > of vCPUs.  This ensures that completion interrupts are handled on the
> > same vCPU that submitted the request.  No IPI is necessary to complete
> > an I/O request and performance is improved.
> >
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  include/hw/virtio/vhost-user-blk.h | 2 ++
> >  hw/block/vhost-user-blk.c          | 6 +++++-
> >  hw/core/machine.c                  | 1 +
> >  hw/virtio/vhost-user-blk-pci.c     | 4 ++++
> >  4 files changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
> > index 34ad6f0c0e..292d17147c 100644
> > --- a/include/hw/virtio/vhost-user-blk.h
> > +++ b/include/hw/virtio/vhost-user-blk.h
> > @@ -25,6 +25,8 @@
> >  #define VHOST_USER_BLK(obj) \
> >          OBJECT_CHECK(VHostUserBlk, (obj), TYPE_VHOST_USER_BLK)
> >
> > +#define VHOST_USER_BLK_AUTO_NUM_QUEUES UINT16_MAX
> > +
> >  typedef struct VHostUserBlk {
> >      VirtIODevice parent_obj;
> >      CharBackend chardev;
> > diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> > index 9d8c0b3909..7a8639516f 100644
> > --- a/hw/block/vhost-user-blk.c
> > +++ b/hw/block/vhost-user-blk.c
> > @@ -385,6 +385,9 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
> >          return;
> >      }
> >
> > +    if (s->num_queues == VHOST_USER_BLK_AUTO_NUM_QUEUES) {
> > +        s->num_queues = 1;
> > +    }
> >      if (!s->num_queues || s->num_queues > VIRTIO_QUEUE_MAX) {
> >          error_setg(errp, "vhost-user-blk: invalid number of IO queues");
> >          return;
> > @@ -496,7 +499,8 @@ static const VMStateDescription vmstate_vhost_user_blk = {
> >
> >  static Property vhost_user_blk_properties[] = {
> >      DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
> > -    DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues, 1),
> > +    DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues,
> > +                       VHOST_USER_BLK_AUTO_NUM_QUEUES),
> >      DEFINE_PROP_UINT32("queue-size", VHostUserBlk, queue_size, 128),
> >      DEFINE_PROP_BIT("config-wce", VHostUserBlk, config_wce, 0, true),
> >      DEFINE_PROP_END_OF_LIST(),
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index 4aba3bdd3c..8cc4b54eec 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -32,6 +32,7 @@ GlobalProperty hw_compat_5_0[] = {
> >      { "virtio-blk-device", "num-queues", "1"},
> >      { "virtio-scsi-device", "num_queues", "1"},
> >      { "vhost-scsi", "num_queues", "1"},
> > +    { "vhost-user-blk", "num-queues", "1"},
> >      { "vhost-user-scsi", "num_queues", "1"},
> >  };
> >  const size_t hw_compat_5_0_len = G_N_ELEMENTS(hw_compat_5_0);
> > diff --git a/hw/virtio/vhost-user-blk-pci.c b/hw/virtio/vhost-user-blk-pci.c
> > index 58d7c31735..1c8ab7f5e6 100644
> > --- a/hw/virtio/vhost-user-blk-pci.c
> > +++ b/hw/virtio/vhost-user-blk-pci.c
> > @@ -54,6 +54,10 @@ static void vhost_user_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> >      VHostUserBlkPCI *dev = VHOST_USER_BLK_PCI(vpci_dev);
> >      DeviceState *vdev = DEVICE(&dev->vdev);
> >
> > +    if (dev->vdev.num_queues == VHOST_USER_BLK_AUTO_NUM_QUEUES) {
> > +        dev->vdev.num_queues = virtio_pci_optimal_num_queues(0);
> > +    }
> > +
> >      if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
> >          vpci_dev->nvectors = dev->vdev.num_queues + 1;
> >      }
> > --
> > 2.25.4
> >


