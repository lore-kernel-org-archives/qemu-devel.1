Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14B1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:47:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89B712065F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OgFl8eOn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B712065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDnK-00007c-S7
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqDlw-0007b6-Lt
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:45:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41053
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqDlu-0003d2-L1
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593513949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YgosO+KfR8Z/7cfpTkqpd5jpWU4AhjoFyqymwA8LozI=;
 b=OgFl8eOnjxQ8Glg14UpXW3mEkYcxdwbhf2Wp2fJPWxFF9bKABG77SlJQV4H/5ng8NiAyqn
 b3lMIYDt4GRd5M4yG0KN7Ep4Qa/bL62pHWtyKkhKPiz9lsbgj6FmgBbfRB6ALMHVKfCzbs
 wRSesiSnjYpx3UAa496z9e0pUKymwSw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-TaBYO3IjPLSw-GJrVZovFA-1; Tue, 30 Jun 2020 06:45:48 -0400
X-MC-Unique: TaBYO3IjPLSw-GJrVZovFA-1
Received: by mail-wr1-f69.google.com with SMTP id d11so1162542wrw.12
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 03:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YgosO+KfR8Z/7cfpTkqpd5jpWU4AhjoFyqymwA8LozI=;
 b=KB6sO1KaxrNTj9IT+j4Q0e+exNDKxltqnmPQd5ciWOK+/APfwMixT1ePgIxT6yFTbT
 IMp/4HY56szM1dXUogmxXwZmSUWNBa8cy/3agkFGepwc6Vh/sPx+twDMzjzBAOZ4zqJ0
 GrTfZBr1LAlQVp6GwdYaf3LgxHfSO0rTp6XfzGOODTDZ11s5VKGC0JoUe85cux/FwrP1
 3CEYXZBSuhp5mOJN0n6hOEbdT/PJBzn8tEv0DD7AWbh0fFQoEdIV45WzKKiPjJCju9Yd
 YO2nh6HX07a1tucxGDYvJbXrftLijf58pf+tFVo85aKPhp6sqpsTZVEnU4ki4e/z2M0M
 +f3Q==
X-Gm-Message-State: AOAM532SXeXGjtvF8/wpNO5DT5ROS9GerNU0oDXxF+L95xlIynvfUW7i
 j8Wxirhy/Scbtc2O7woDUsAwfjv36GqZyDVdK3sfpEAa8o4NyqR4+EQWPk+zu+kQBMD5ZuuRr0b
 9CQmeZJwzGnjjGBw=
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr22244854wrr.296.1593513946882; 
 Tue, 30 Jun 2020 03:45:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqfbTJsgNbL2aJBQUXvYi3RHfedtN4jrNnjlZQ7hTHUrMzEFjJuHJ6ZWqsgDhasvhsXqq4Fw==
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr22244829wrr.296.1593513946611; 
 Tue, 30 Jun 2020 03:45:46 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 r11sm3083458wmh.1.2020.06.30.03.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 03:45:45 -0700 (PDT)
Date: Tue, 30 Jun 2020 06:45:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH RFC] virtio-fs: force virtio 1.x usage
Message-ID: <20200630064227-mutt-send-email-mst@kernel.org>
References: <20200629102758.421552-1-cohuck@redhat.com>
 <20200629104948-mutt-send-email-mst@kernel.org>
 <20200629173933.35cea40f.cohuck@redhat.com>
 <20200629114515-mutt-send-email-mst@kernel.org>
 <20200630113527.7b27f34f.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200630113527.7b27f34f.cohuck@redhat.com>
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
Cc: Eric Auger <eric.auger@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 30, 2020 at 11:35:27AM +0200, Cornelia Huck wrote:
> On Mon, 29 Jun 2020 11:45:35 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Jun 29, 2020 at 05:39:33PM +0200, Cornelia Huck wrote:
> > > On Mon, 29 Jun 2020 10:53:23 -0400
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >   
> > > > On Mon, Jun 29, 2020 at 12:27:58PM +0200, Cornelia Huck wrote:  
> > > > > virtio-fs devices are only specified for virtio-1, so it is unclear
> > > > > how a legacy or transitional device should behave.
> > > > > 
> > > > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > > > > ---
> > > > > 
> > > > > Forcing off legacy now (after the virtio-fs device has already been
> > > > > available) may have unintended consequences, therefore RFC.
> > > > > 
> > > > > By default, a virtio-pci device uses 'AUTO' for disable_legacy, which
> > > > > will resolve to different values based upon which bus the device has
> > > > > been plugged. Therefore, forcing disable_legacy may result in the same
> > > > > device or a quite different one.
> > > > > 
> > > > > Even though pre-virtio-1 behaviour of virtio-fs devices is simply not
> > > > > specified, toggling disable_legacy will have implications for the BAR
> > > > > layout, IIRC, and therefore a guest might end up getting a different
> > > > > device, even if it always used it with virtio-1 anyway.
> > > > > 
> > > > > Not sure what the best way to solve this problem is. Adding a compat
> > > > > property for disable_legacy=AUTO may be the right thing to do, but I'm
> > > > > not quite clear if there are any further implications here.   
> 
> Hnm, I'm a bit confused where to actually set this property...


Not a property, just some flag that I'd set in the core,
and then teach all transports to take that into account.

> > > > 
> > > > Well I notice that this device is not migrateable.
> > > > So I think that we can just switch it over and be done with it.  
> > > 
> > > Oh, that makes things easier. (I'm wondering if libvirt already
> > > configures this correctly?)
> > >   
> > > > 
> > > >   
> > > > > Whatever we do here, we should make sure that the ccw incarnation of
> > > > > this device indeed forces virtio-1.    
> > > > 
> > > > I agree. I notice that the API virtio_pci_force_virtio_1 turned out
> > > > to be too fragile. I propose that instead we have a whitelist of
> > > > devices which can be legacy or transitional. Force rest to modern.  
> > > 
> > > Also, there are further complications because the mechanism is per
> > > transport, and therefore easy to miss.
> > > 
> > > bool virtio_legacy_allowed(VirtIODevice *vdev)
> > > {
> > >     switch (vdev->device_id) {
> > >     case <...>:
> > >     <list of legacy-capable devices>
> > >         return true;
> > >     default:
> > >         return false;
> > > }
> > > 
> > > Seems straightforward enough.  
> > 
> > 
> > Agreed. virtio spec has the list.
> 
> Ok, I've been staring at this a bit, and it's a bit messy for other
> reasons.
> 
> First, I noticed that virtio-iommu does not force virtio-1, either; I
> think it should? Eric?
> 
> Then, there's the mechanism using different names for transitional and
> non-transitional devices. Devices that support both usually define both
> names (with disable_legacy and disable_modern set appropriately) and a
> base name (where the properties can be set manually for the desired
> effect). Most virtio-1 only devices set neither the non-transitional
> nor the transitional name and rely on virtio_pci_force_virtio_1() to
> disable legacy support. But there are outliers:
> 
> * this device: it has only a non-transitional name
>   ("vhost-user-fs-pci"), which means we automatically get the correct
>   configuration; in order to define a transitional/legacy device, you
>   would need to use the base name "vhost-user-fs-pci-base" explicitly,
>   and it's unlikely that someone has been doing that.
> * virtio-iommu (which I *think* is a virtio-1 only device): it defines
>   the full set of transitional, non-transitional, and base names.
> 
> How should we proceed?
> * With this patch here, we can fence off the very unlikely possibility
>   of somebody configuring a non-modern virtio-fs device for pci. We
>   probably should do it, but I don't think we need compat handling.
> * For virtio-iommu, we should get an agreement what the desired state
>   is. If it really should be modern only, we need compat handling, as
>   the device had been added in 5.0. (And we need to figure out how to
>   apply that compat handling.)


Well I know it's not really used on x86 yet, so no problem there.

Which machines are actually affected?


> * What is the preferred way to express 'this virtio-pci device is
>   modern only'? Using virtio_pci_force_virtio_1()? Setting the
>   non-transitional name to the obvious name? Both?
> * We probably still want to have a 'central authority' for whether a
>   device is virtio-1 only or not, so all transports can refer to it.
> 
> Thoughts?


I still think that for the above the best approach is a whitelist
of legacy virtio IDs.

> > 
> > > > 
> > > >   
> > > > > ---
> > > > >  hw/virtio/vhost-user-fs-pci.c | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git a/hw/virtio/vhost-user-fs-pci.c b/hw/virtio/vhost-user-fs-pci.c
> > > > > index e11c889d82b3..244205edf765 100644
> > > > > --- a/hw/virtio/vhost-user-fs-pci.c
> > > > > +++ b/hw/virtio/vhost-user-fs-pci.c
> > > > > @@ -44,6 +44,7 @@ static void vhost_user_fs_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> > > > >          vpci_dev->nvectors = dev->vdev.conf.num_request_queues + 2;
> > > > >      }
> > > > >  
> > > > > +    virtio_pci_force_virtio_1(vpci_dev);
> > > > >      qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> > > > >  }
> > > > >  
> > > > > -- 
> > > > > 2.25.4    
> > > >   
> > 


