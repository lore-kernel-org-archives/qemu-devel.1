Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39275C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:05:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03A4A20672
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VpxSIVjU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A4A20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqFx7-0003QY-9i
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 09:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqFwN-0002fV-OX
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 09:04:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25050
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqFwM-0000wH-2q
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 09:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593522285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0alwRRzyGCKebQet1n1G3H+hWlOOajMrH45ykiClIBg=;
 b=VpxSIVjUaR4kwKQR5iuap2KqHLEdiGnQRpni3gJ2pJw2T3irDtGxqHgR2lqqBHTidxhUhR
 YzcEn6ius4uAxdM+PK9l4slOZlGrB43pjtf/9mhNNj5LKkAYUUEpCL4xVPve1kervJUwcO
 Gv0Wj9nT12XSnYvr0LgtYxD1L/d2lZU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-TZi2H-0_Nua4L5laWdKeWQ-1; Tue, 30 Jun 2020 09:04:43 -0400
X-MC-Unique: TZi2H-0_Nua4L5laWdKeWQ-1
Received: by mail-wr1-f70.google.com with SMTP id b8so4658175wro.19
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 06:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0alwRRzyGCKebQet1n1G3H+hWlOOajMrH45ykiClIBg=;
 b=i3lXYsWkxsBBloeL/HtSQkAvBTDVP5oWrkvk5w7Vmvxf/PkzPz1L0ub0UBUyeC7mDq
 arvbp5iS6S2cQStrg5EHVwZrp5TgcdX3CjuLb9WSZHwTUVIIMgHh3991Z4ujBUKFnb/W
 cvoNf6MppVsYqFY5o3hVi75ocAaTxxFStHLKdqAwwoYsq/BlRBNs8cS0hG0kDlnCQ04A
 QJ+MJOiDeLJPg/miZh3PPbFhEdRqyN8TtJjjlqHI3BsT/2/KMagxtBm85DSGEiPjieYO
 9x0anCyYIqXkH3wAqLIm16C8LHB0zKBQZOVBsyJjxshGYjDQqkQxl34Izkv6Re+ea2Y2
 vUzA==
X-Gm-Message-State: AOAM533YYzkjpkOGLFwW//HEMq3CQ1Fw0KwMrPZz10GmEL/gT1ajg/kE
 UrFddU8uabV41A/wzJfaGRFQa0P27PgYstJdHNfW9228aqgEvK5yCJDs4PzgFZsBEi/O958ibrx
 /BnfibVn6eGr3eGw=
X-Received: by 2002:a1c:80d3:: with SMTP id
 b202mr22038222wmd.111.1593522282502; 
 Tue, 30 Jun 2020 06:04:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgmO9XTwMWDT4QT8JVCQU55ksXXLfh8uMPCOzcg5J6+nNH1U3PMC9N6wgJFFF8Y192XIMX3Q==
X-Received: by 2002:a1c:80d3:: with SMTP id
 b202mr22038202wmd.111.1593522282295; 
 Tue, 30 Jun 2020 06:04:42 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 2sm3419700wmo.44.2020.06.30.06.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 06:04:41 -0700 (PDT)
Date: Tue, 30 Jun 2020 09:04:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH RFC] virtio-fs: force virtio 1.x usage
Message-ID: <20200630090327-mutt-send-email-mst@kernel.org>
References: <20200629102758.421552-1-cohuck@redhat.com>
 <20200630121037.GC91444@stefanha-x1.localdomain>
 <20200630142504.688aa989.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200630142504.688aa989.cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 03:55:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 30, 2020 at 02:25:04PM +0200, Cornelia Huck wrote:
> On Tue, 30 Jun 2020 13:10:37 +0100
> Stefan Hajnoczi <stefanha@redhat.com> wrote:
> 
> > On Mon, Jun 29, 2020 at 12:27:58PM +0200, Cornelia Huck wrote:
> > > virtio-fs devices are only specified for virtio-1, so it is unclear
> > > how a legacy or transitional device should behave.
> > > 
> > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > > ---  
> > 
> > I thought that the following already forced VIRTIO 1.0 because it
> > doesn't advertize Legacy or Transitional devices:
> > 
> >   static const VirtioPCIDeviceTypeInfo vhost_user_fs_pci_info = {
> >       .base_name             = TYPE_VHOST_USER_FS_PCI,
> >       .non_transitional_name = "vhost-user-fs-pci",
> >       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >       .instance_size = sizeof(VHostUserFSPCI),
> >       .instance_init = vhost_user_fs_pci_instance_init,
> >       .class_init    = vhost_user_fs_pci_class_init,
> >   };
> 
> This indeed makes vhost-user-fs-pci modern-only, I had not spotted that
> when I wrote the patch. Other modern-only devices do not go down this
> route and use the virtio_pci_force_virtio_1() approach.
> 
> > 
> > Do you have a guest that sees this VIRTIO 1.0 device and still fails to
> > negotiate the VERSION_1 feature bit?
> > 
> > > diff --git a/hw/virtio/vhost-user-fs-pci.c b/hw/virtio/vhost-user-fs-pci.c
> > > index e11c889d82b3..244205edf765 100644
> > > --- a/hw/virtio/vhost-user-fs-pci.c
> > > +++ b/hw/virtio/vhost-user-fs-pci.c
> > > @@ -44,6 +44,7 @@ static void vhost_user_fs_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> > >          vpci_dev->nvectors = dev->vdev.conf.num_request_queues + 2;
> > >      }
> > >  
> > > +    virtio_pci_force_virtio_1(vpci_dev);  
> > 
> > Can this be moved to virtio_pci_types_register() so that it
> > automatically happens for .non_transitional_name devices?
> 
> There are several existing modern-only devices that don't use that kind
> of naming scheme...
> 
> What bothers me most is that you need to explicitly request a device to
> be modern-only, while that should be the default for any newly added
> device. Hence the approach with the centralized list of device types
> mentioned in a parallel thread. The main problem with that is that the
> proxy device starts getting realized before the virtio device with its
> id is present... I failed to find a solution so far. But I'd really
> like an approach that can work for all transports.

So how about simply validating that the device is modern only,
unless it's one of the whitelist?

-- 
MST


